Received: from eggs.gnu.org ([2001:4830:134:3::10]:35743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dUUqF-0004Ep-Pi
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dUUqC-0006qm-In
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:18:55 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dUUqC-0006qB-7T
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:18:52 -0400
Received: by mail-lf0-f65.google.com with SMTP id f28so9427763lfi.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 02:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <1499705121-71730-1-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1499705121-71730-1-git-send-email-peng.hao2@zte.com.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Jul 2017 09:17:40 +0000
Message-ID: <CAJ+F1CJqKTj4ChAy6C94EJFOjXU3Bmu=bWGvfTEBVA2AXhYTgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: fix parallel device can't be
 reconnect.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, pbonzini@redhat.com
Cc: wang.yechao255@zte.com.cn, qemu-devel@nongnu.org

Hi

On Mon, Jul 10, 2017 at 10:36 AM Peng Hao <peng.hao2@zte.com.cn> wrote:

> Parallel device don't register be->chr_can_read function, but remote
> disconnect event is handled in chr_read.
> So connected parallel device can not detect remote disconnect event.
>
>
What is it that you call a parallel device? you are modifying the socket
code here. Could you describe a test setup? even better would be to write a
test in test-char.c.


> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  chardev/char-socket.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index ccc499c..59509d4 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -131,6 +131,14 @@ static int tcp_chr_write(Chardev *chr, const uint8_t
> *buf, int len)
>      }
>  }
>
> +static gboolean is_parallel_device(Chardev *chr)
> +{
> +    if (chr && chr->label && strstr(chr->label, "charparallel")) {
> +        return TRUE;
>

What guarantees that a parallel device will have "charparallel" in its
label?


> +    }
> +    return FALSE;
> +}
> +
>  static int tcp_chr_read_poll(void *opaque)
>  {
>      Chardev *chr =3D CHARDEV(opaque);
> @@ -138,6 +146,8 @@ static int tcp_chr_read_poll(void *opaque)
>      if (!s->connected) {
>          return 0;
>      }
> +    if (is_parallel_device(chr)) {
> +        return 1;
>

That means 1 byte can be read, but s->max_size isn't updated, this will
confuse tcp_chr_read().


> +    }
>      s->max_size =3D qemu_chr_be_can_write(chr);
>      return s->max_size;
>  }
> @@ -422,6 +432,15 @@ static gboolean tcp_chr_read(QIOChannel *chan,
> GIOCondition cond, void *opaque)
>      uint8_t buf[CHR_READ_BUF_LEN];
>      int len, size;
>
> +    /* for parallel-device handle the socket close event here*/
> +    if (!s->max_size && is_parallel_device(chr)) {
> +        size =3D tcp_chr_recv(chr, (void *)buf, CHR_READ_BUF_LEN);
> +        if (size =3D=3D 0 || size =3D=3D -1) {
> +            tcp_chr_disconnect(chr);
>

I don't understand why that condition wouldn't be reached by the following
tcp_chr_recv() handling. Furthermore, you may read more that s->max_size,
which will likely break qemu_chr_be_write() in various cases.



> +        }
> +        return TRUE;
> +    }
> +
>      if (!s->connected || s->max_size <=3D 0) {
>          return TRUE;
>      }
> --
> 1.8.3.1
>
>
>
> --
Marc-Andr=C3=A9 Lureau
