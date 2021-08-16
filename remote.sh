#!/bin/bash
clear
option=0
direcrtory="/etc/hosts"
username="xxxx"
password="xxxx"

#function for question
func_question(){

        echo ****Welcome****
        echo Login as :
        echo 1. ssh 
        echo 2. telnet
        echo 3. for quit or press ctrl+c
        read -p 'Massukan Pilihan 1 or 2(only number): ' option

}
#function for find ip in /etc/hosts
func_find_ip(){

        ip=$1
        dev="$(cat "$direcrtory" | grep -i -w -c "$ip")"
        if [ $dev -gt 0 ]
        then
                devices=($(cat "$direcrtory" | grep -i -w "$ip"))
                device=${devices[0]}
        fi
        echo "$device"              
}

#func for remote ssh
func_remote(){
        ip="$(func_find_ip $1)"
        option=$2
        if [ $option == 1 ]
        then
                ssh $username@$ip
        else
                telnet $ip
        fi
}

#looping condition
while true
        do
                clear
                func_question
                if [ $option  == 1 -o $option  == 2 ] #condition from question
                then
                        read -p 'Masukkan IP/Hostname:' ip
                        func_remote $ip $option
                elif [ $option == 3 ]
                then
                        exit
                else
                        echo pilihan salah
                        sleep 1
                        bash rmt.sh
                fi
done
