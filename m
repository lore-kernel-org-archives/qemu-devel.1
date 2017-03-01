Received: from eggs.gnu.org ([2001:4830:134:3::10]:45294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1civyV-0006c4-CW
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1civyS-0005Zg-7o
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:34:51 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1civyS-0005ZX-4D
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:34:48 -0500
Received: by mail-qk0-x243.google.com with SMTP id s186so8031470qkb.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 20:34:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
	<20170227134202.2991-16-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <788221cc-b17c-8d29-81da-9a23e5507686@amsat.org>
Date: Wed, 1 Mar 2017 01:34:43 -0300
MIME-Version: 1.0
In-Reply-To: <20170227134202.2991-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 15/21] char-udp: flush as much buffer as
 possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 02/27/2017 10:41 AM, Marc-André Lureau wrote:
> Instead of flushing the buffer byte by byte, call qemu_chr_be_write()
> with as much byte possible accepted by the front-end.
>
> Factor out buffer flushing in a common function udp_chr_flush_buffer().
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  chardev/char-udp.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/chardev/char-udp.c b/chardev/char-udp.c
> index 2c6c7ddd73..5364b5fc59 100644
> --- a/chardev/char-udp.c
> +++ b/chardev/char-udp.c
> @@ -51,6 +51,18 @@ static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
>          s->ioc, (const char *)buf, len, NULL);
>  }
>
> +static void udp_chr_flush_buffer(UdpChardev *s)
> +{
> +    Chardev *chr = CHARDEV(s);
> +
> +    while (s->max_size > 0 && s->bufptr < s->bufcnt) {
> +        int n = MIN(s->max_size, s->bufcnt - s->bufptr);
> +        qemu_chr_be_write(chr, &s->buf[s->bufptr], n);
> +        s->bufptr += n;
> +        s->max_size = qemu_chr_be_can_write(chr);
> +    }
> +}
> +
>  static int udp_chr_read_poll(void *opaque)
>  {
>      Chardev *chr = CHARDEV(opaque);
> @@ -61,11 +73,8 @@ static int udp_chr_read_poll(void *opaque)
>      /* If there were any stray characters in the queue process them
>       * first
>       */
> -    while (s->max_size > 0 && s->bufptr < s->bufcnt) {
> -        qemu_chr_be_write(chr, &s->buf[s->bufptr], 1);
> -        s->bufptr++;
> -        s->max_size = qemu_chr_be_can_write(chr);
> -    }
> +    udp_chr_flush_buffer(s);
> +
>      return s->max_size;
>  }
>
> @@ -85,13 +94,8 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
>          return FALSE;
>      }
>      s->bufcnt = ret;
> -
>      s->bufptr = 0;
> -    while (s->max_size > 0 && s->bufptr < s->bufcnt) {
> -        qemu_chr_be_write(chr, &s->buf[s->bufptr], 1);
> -        s->bufptr++;
> -        s->max_size = qemu_chr_be_can_write(chr);
> -    }
> +    udp_chr_flush_buffer(s);
>
>      return TRUE;
>  }
>
