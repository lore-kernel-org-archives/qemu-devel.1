Received: from eggs.gnu.org ([2001:4830:134:3::10]:49598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84eH-0001EL-4a
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84eD-0003We-8R
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:53:53 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84eD-0003WU-45
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:53:49 -0400
Received: by mail-qt0-x243.google.com with SMTP id r58so13602210qtb.2
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 05:53:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0dc4659f-e42d-e89b-30e7-cfa6adf226a7@amsat.org>
Date: Tue, 9 May 2017 09:53:45 -0300
MIME-Version: 1.0
In-Reply-To: <20170509113332.4987-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/13] char-win: rename win_chr_init/poll
 win_chr_serial_init/poll
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

On 05/09/2017 08:33 AM, Marc-André Lureau wrote:
> Those 2 functions are specific to serial chardev, make it more clear.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  chardev/char-win.h    | 2 +-
>  chardev/char-serial.c | 2 +-
>  chardev/char-win.c    | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/chardev/char-win.h b/chardev/char-win.h
> index 70215e04c2..e0b3839a77 100644
> --- a/chardev/char-win.h
> +++ b/chardev/char-win.h
> @@ -46,7 +46,7 @@ typedef struct {
>  #define WIN_CHARDEV(obj) OBJECT_CHECK(WinChardev, (obj), TYPE_CHARDEV_WIN)
>
>  void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_out);
> -int win_chr_init(Chardev *chr, const char *filename, Error **errp);
> +int win_chr_serial_init(Chardev *chr, const char *filename, Error **errp);
>  int win_chr_pipe_poll(void *opaque);
>
>  #endif /* CHAR_WIN_H */
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index 094e08dca5..fef3a91c77 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -45,7 +45,7 @@ static void qmp_chardev_open_serial(Chardev *chr,
>  {
>      ChardevHostdev *serial = backend->u.serial.data;
>
> -    win_chr_init(chr, serial->device, errp);
> +    win_chr_serial_init(chr, serial->device, errp);
>  }
>
>  #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      \
> diff --git a/chardev/char-win.c b/chardev/char-win.c
> index 5e7daeeae1..11abad1521 100644
> --- a/chardev/char-win.c
> +++ b/chardev/char-win.c
> @@ -56,7 +56,7 @@ static void win_chr_read(Chardev *chr, DWORD len)
>      }
>  }
>
> -static int win_chr_poll(void *opaque)
> +static int win_chr_serial_poll(void *opaque)

Nice :)

>  {
>      Chardev *chr = CHARDEV(opaque);
>      WinChardev *s = WIN_CHARDEV(opaque);
> @@ -71,7 +71,7 @@ static int win_chr_poll(void *opaque)
>      return 0;
>  }
>
> -int win_chr_init(Chardev *chr, const char *filename, Error **errp)
> +int win_chr_serial_init(Chardev *chr, const char *filename, Error **errp)
>  {
>      WinChardev *s = WIN_CHARDEV(chr);
>      COMMCONFIG comcfg;
> @@ -130,7 +130,7 @@ int win_chr_init(Chardev *chr, const char *filename, Error **errp)
>          error_setg(errp, "Failed ClearCommError");
>          goto fail;
>      }
> -    qemu_add_polling_cb(win_chr_poll, chr);
> +    qemu_add_polling_cb(win_chr_serial_poll, chr);
>      return 0;
>
>   fail:
> @@ -208,7 +208,7 @@ static void char_win_finalize(Object *obj)
>      if (s->fpipe) {
>          qemu_del_polling_cb(win_chr_pipe_poll, chr);
>      } else {
> -        qemu_del_polling_cb(win_chr_poll, chr);
> +        qemu_del_polling_cb(win_chr_serial_poll, chr);
>      }
>
>      qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
>
