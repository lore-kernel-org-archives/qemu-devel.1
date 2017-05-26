Received: from eggs.gnu.org ([2001:4830:134:3::10]:49014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEHBy-0005aQ-E8
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEHBu-0004Ik-GH
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:30:18 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEHBu-0004HO-B9
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:30:14 -0400
Received: by mail-oi0-x244.google.com with SMTP id v80so2199998oie.2
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 08:30:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7bb7effb-c111-3c7d-56f4-a5835a316900@amsat.org>
Date: Fri, 26 May 2017 12:30:11 -0300
MIME-Version: 1.0
In-Reply-To: <20170509113332.4987-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/13] char-win: close file handle except
 with console
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

Hi Marc-André,

On 05/09/2017 08:33 AM, Marc-André Lureau wrote:
> Only the console handle shouldn't be closed, however, the "file" handle
> should.

Correct.

>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-win.h     |  5 ++---
>  chardev/char-console.c |  2 +-
>  chardev/char-file.c    |  2 +-
>  chardev/char-win.c     | 12 ++++--------
>  4 files changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/chardev/char-win.h b/chardev/char-win.h
> index 888be2b3ca..9ed2ba998a 100644
> --- a/chardev/char-win.h
> +++ b/chardev/char-win.h
> @@ -29,14 +29,13 @@
>  typedef struct {
>      Chardev parent;
>
> +    bool dont_close; /* console do not close file */

That or "keep_open" to avoid negative thoughts ;)

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      HANDLE file, hrecv, hsend;
>      OVERLAPPED orecv;
>      BOOL fpipe;
>
>      /* Protected by the Chardev chr_write_lock.  */
>      OVERLAPPED osend;
> -    /* FIXME: file/console do not finalize */
> -    bool skip_free;
>  } WinChardev;
>
>  #define NSENDBUF 2048
> @@ -45,7 +44,7 @@ typedef struct {
>  #define TYPE_CHARDEV_WIN "chardev-win"
>  #define WIN_CHARDEV(obj) OBJECT_CHECK(WinChardev, (obj), TYPE_CHARDEV_WIN)
>
> -void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_out);
> +void win_chr_set_file(Chardev *chr, HANDLE file, bool dont_close);
>  int win_chr_serial_init(Chardev *chr, const char *filename, Error **errp);
>  int win_chr_pipe_poll(void *opaque);
>
> diff --git a/chardev/char-console.c b/chardev/char-console.c
> index c824937fe6..8d972c1506 100644
> --- a/chardev/char-console.c
> +++ b/chardev/char-console.c
> @@ -29,7 +29,7 @@ static void qemu_chr_open_win_con(Chardev *chr,
>                                    bool *be_opened,
>                                    Error **errp)
>  {
> -    qemu_chr_open_win_file(chr, GetStdHandle(STD_OUTPUT_HANDLE));
> +    win_chr_set_file(chr, GetStdHandle(STD_OUTPUT_HANDLE), true);
>  }
>
>  static void char_console_class_init(ObjectClass *oc, void *data)
> diff --git a/chardev/char-file.c b/chardev/char-file.c
> index 8bae25350d..aed4ae1569 100644
> --- a/chardev/char-file.c
> +++ b/chardev/char-file.c
> @@ -65,7 +65,7 @@ static void qmp_chardev_open_file(Chardev *chr,
>          return;
>      }
>
> -    qemu_chr_open_win_file(chr, out);
> +    win_chr_set_file(chr, out, false);
>  #else
>      int flags, in = -1, out;
>
> diff --git a/chardev/char-win.c b/chardev/char-win.c
> index a7e3296909..24cf364947 100644
> --- a/chardev/char-win.c
> +++ b/chardev/char-win.c
> @@ -192,17 +192,13 @@ static void char_win_finalize(Object *obj)
>      Chardev *chr = CHARDEV(obj);
>      WinChardev *s = WIN_CHARDEV(chr);
>
> -    if (s->skip_free) {
> -        return;
> -    }
> -
>      if (s->hsend) {
>          CloseHandle(s->hsend);
>      }
>      if (s->hrecv) {
>          CloseHandle(s->hrecv);
>      }
> -    if (s->file) {
> +    if (!s->dont_close && s->file) {
>          CloseHandle(s->file);
>      }
>      if (s->fpipe) {
> @@ -214,12 +210,12 @@ static void char_win_finalize(Object *obj)
>      qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
>  }
>
> -void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_out)
> +void win_chr_set_file(Chardev *chr, HANDLE file, bool dont_close)
>  {
>      WinChardev *s = WIN_CHARDEV(chr);
>
> -    s->skip_free = true;
> -    s->file = fd_out;
> +    s->dont_close = dont_close;
> +    s->file = file;
>  }
>
>  static void char_win_class_init(ObjectClass *oc, void *data)
>
