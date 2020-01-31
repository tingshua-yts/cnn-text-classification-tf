# 用来运行本地测试的docker环境
#!/bin/bash
set -x
name=tmp_classification_tingshuai
flag=$(sudo docker ps  | grep "$name" | wc -l)
if [ $flag == 0 ] || [ "$1" = "restart" ]
then
    sudo nvidia-docker stop "$name"
    sudo nvidia-docker rm "$name"
    sudo nvidia-docker run --name="$name" -d --net=host -u "$UID" \
    -e TZ=Asia/Shanghai \
    -v /etc/passwd:/etc/passwd:ro \
    -v "$HOME":"$HOME" \
    -u "root" \
    -w $(pwd)     -it tensorflow/tensorflow:1.12.0-gpu-py3 /bin/bash
fi
sudo docker exec -it "$name" bash
