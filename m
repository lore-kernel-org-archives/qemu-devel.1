Received: from eggs.gnu.org ([2001:4830:134:3::10]:56801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZuTT-0003aR-LX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZuTQ-0005Gr-J4
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:46:19 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:47069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fZuTQ-0005Gd-CD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:46:16 -0400
Received: by mail-wr0-f194.google.com with SMTP id s11-v6so5390432wra.13
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 01:46:16 -0700 (PDT)
References: <20180702004910.13216-1-caoxinhua@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75a4e7db-594c-10e1-761a-38325bffa887@redhat.com>
Date: Mon, 2 Jul 2018 10:46:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180702004910.13216-1-caoxinhua@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "xinhua.Cao" <caoxinhua@huawei.com>, marcandre.lureau@redhat.com, eblake@redhat.com, anton.nefedov@virtuozzo.com, vsementsov@virtuozzo.com
Cc: weidong.huang@huawei.com, weifuqiang@huawei.com, qemu-devel@nongnu.org, king.wang@huawei.com, liuyongan@huawei.com, arei.gonglei@huawei.com

On 02/07/2018 02:49, xinhua.Cao wrote:
> In the tcp_chr_write function, we checked errno,
> but errno was not reset before a read or write operation.
> Therefore, this check of errno's actions is often
> incorrect after EAGAIN has occurred.
> We reset errno before reading and writing to
> ensure the correctness of errno's judgment

You should explain why this is a problem, because all the places you
modified are checking that the read or write has returned -1.  In that
case, errno must have been modified and it is unnecessary to write 0.

Thanks,

Paolo

> Signed-off-by: xinhua.Cao <caoxinhua@huawei.com>
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
