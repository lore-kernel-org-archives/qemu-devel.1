Received: from eggs.gnu.org ([2001:4830:134:3::10]:60927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fZnr1-00037p-LQ
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 21:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fZnr0-00050O-60
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 21:42:11 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fZnr0-000509-1G
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 21:42:10 -0400
Received: by mail-qt0-x242.google.com with SMTP id s47-v6so12611445qth.7
	for <qemu-devel@nongnu.org>; Sun, 01 Jul 2018 18:42:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702004910.13216-1-caoxinhua@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <caac8add-5003-a63f-0fef-f765b5967880@amsat.org>
Date: Sun, 1 Jul 2018 22:42:03 -0300
MIME-Version: 1.0
In-Reply-To: <20180702004910.13216-1-caoxinhua@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qemu-char: reset errno before qemu char
 write or read action
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "xinhua.Cao" <caoxinhua@huawei.com>, pbonzini@redhat.com, marcandre.lureau@redhat.com, eblake@redhat.com, anton.nefedov@virtuozzo.com, vsementsov@virtuozzo.com
Cc: weidong.huang@huawei.com, weifuqiang@huawei.com, qemu-devel@nongnu.org, king.wang@huawei.com, liuyongan@huawei.com, arei.gonglei@huawei.com

On 07/01/2018 09:49 PM, xinhua.Cao wrote:
> In the tcp_chr_write function, we checked errno,
> but errno was not reset before a read or write operation.
> Therefore, this check of errno's actions is often
> incorrect after EAGAIN has occurred.
> We reset errno before reading and writing to
> ensure the correctness of errno's judgment
> 
> Signed-off-by: xinhua.Cao <caoxinhua@huawei.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  chardev/char-fe.c | 1 +
>  chardev/char.c    | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index b1f228e..d96ca6f 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -69,6 +69,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
>  
>      while (offset < len) {
>      retry:
> +        errno = 0;
>          res = CHARDEV_GET_CLASS(s)->chr_sync_read(s, buf + offset,
>                                                    len - offset);
>          if (res == -1 && errno == EAGAIN) {
> diff --git a/chardev/char.c b/chardev/char.c
> index 76d866e..3387442 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -85,6 +85,7 @@ static void qemu_chr_write_log(Chardev *s, const uint8_t *buf, size_t len)
>  
>      while (done < len) {
>      retry:
> +        errno = 0;
>          ret = write(s->logfd, buf + done, len - done);
>          if (ret == -1 && errno == EAGAIN) {
>              g_usleep(100);
> @@ -109,6 +110,7 @@ static int qemu_chr_write_buffer(Chardev *s,
>      qemu_mutex_lock(&s->chr_write_lock);
>      while (*offset < len) {
>      retry:
> +        errno = 0;
>          res = cc->chr_write(s, buf + *offset, len - *offset);
>          if (res < 0 && errno == EAGAIN && write_all) {
>              g_usleep(100);
> 
