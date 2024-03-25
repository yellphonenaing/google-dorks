#!/usr/bin/bash

urlencode() {
  # Usage: urlencode "string"
  local string="$1"
  local length="${#string}"
  local encoded=""
  local i

  for (( i = 0; i < length; i++ )); do
    local c="${string:i:1}"
    case $c in
      [a-zA-Z0-9.~_-])
        encoded+="$c"
        ;;
      *)
        printf -v hex "%02X" "'$c"
        encoded+="%$hex"
        ;;
    esac
  done

  echo "$encoded"
}

echo -e "
         \e[1;33m   ********************************************
            *                                          *
            *             Google Dorking Tool          *
            *           Coded By :: CyberBullet        *
            *        Hack Everything,Harm Nothing      *
            *                                          *
            ********************************************
\e[0m"

if [[ $# != 2 ]];then
echo -e "\e[1;31mPlease run the script as bash $0 <username> <password>\e[0m"
exit
else
code=$(curl -Iks -u $1:$2 https://google-reverse-proxy.duckdns.org/ | head -1 | awk '{ print $2 }')
if [[ $code != 200 ]];then
echo -e "\e[1;31mAuthentication failed\e[0m"
exit
else
n=1
read -p $'\e[1;32mEnter dork :: \e[0m' dork
for i in {1..1000..10};do
for urls in `curl -u $1:$2 -ks "https://google-reverse-proxy.duckdns.org/search?q=$(urlencode "$dork")&start=$i" -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0' | grep -Eoi '<a[^>]+>' | grep 'UWckNb' | grep -oP 'href="\K[^"]+'`;do
echo -e "\e[1;32m [\e[1;31m$n\e[1;32m] \e[1;33m$urls\e[0m"
n=$((n+1))
done
done
fi
fi
