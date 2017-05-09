Received: from eggs.gnu.org ([2001:4830:134:3::10]:49829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84ff-0002U0-6I
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84fb-0003s1-A6
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:55:19 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84fb-0003rr-5n
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:55:15 -0400
Received: by mail-qk0-x244.google.com with SMTP id y128so14540542qka.3
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 05:55:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7e02b063-0535-a03e-1fc0-0719381157d9@amsat.org>
Date: Tue, 9 May 2017 09:55:11 -0300
MIME-Version: 1.0
In-Reply-To: <20170509113332.4987-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/13] char-win: simplify win_chr_read()
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
> win_chr_read_poll() is always used before win_chr_read().
> We can easily fold win_chr_readfile() too.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  chardev/char-win.h |  2 +-
>  chardev/char-win.c | 35 +++++++++--------------------------
>  2 files changed, 10 insertions(+), 27 deletions(-)
>
> diff --git a/chardev/char-win.h b/chardev/char-win.h
> index d78a7d7972..73a0e3caef 100644
> --- a/chardev/char-win.h
> +++ b/chardev/char-win.h
> @@ -28,7 +28,7 @@
>
>  typedef struct {
>      Chardev parent;
> -    int max_size;
> +
>      HANDLE hcom, hrecv, hsend;
>      OVERLAPPED orecv;
>      BOOL fpipe;
> diff --git a/chardev/char-win.c b/chardev/char-win.c
> index e4b6957ded..a46d878ef8 100644
> --- a/chardev/char-win.c
> +++ b/chardev/char-win.c
> @@ -26,14 +26,21 @@
>  #include "qapi/error.h"
>  #include "char-win.h"
>
> -static void win_chr_readfile(Chardev *chr)
> +static void win_chr_read(Chardev *chr)
>  {
>      WinChardev *s = WIN_CHARDEV(chr);
> -
> +    int max_size = qemu_chr_be_can_write(chr);
>      int ret, err;
>      uint8_t buf[CHR_READ_BUF_LEN];
>      DWORD size;
>
> +    if (s->len > max_size) {
> +        s->len = max_size;
> +    }
> +    if (s->len == 0) {
> +        return;
> +    }
> +
>      ZeroMemory(&s->orecv, sizeof(s->orecv));
>      s->orecv.hEvent = s->hrecv;
>      ret = ReadFile(s->hcom, buf, s->len, &size, &s->orecv);
> @@ -49,28 +56,6 @@ static void win_chr_readfile(Chardev *chr)
>      }
>  }
>
> -static void win_chr_read(Chardev *chr)
> -{
> -    WinChardev *s = WIN_CHARDEV(chr);
> -
> -    if (s->len > s->max_size) {
> -        s->len = s->max_size;
> -    }
> -    if (s->len == 0) {
> -        return;
> -    }
> -
> -    win_chr_readfile(chr);
> -}
> -
> -static int win_chr_read_poll(Chardev *chr)
> -{
> -    WinChardev *s = WIN_CHARDEV(chr);
> -
> -    s->max_size = qemu_chr_be_can_write(chr);
> -    return s->max_size;
> -}
> -
>  static int win_chr_poll(void *opaque)
>  {
>      Chardev *chr = CHARDEV(opaque);
> @@ -81,7 +66,6 @@ static int win_chr_poll(void *opaque)
>      ClearCommError(s->hcom, &comerr, &status);
>      if (status.cbInQue > 0) {
>          s->len = status.cbInQue;
> -        win_chr_read_poll(chr);
>          win_chr_read(chr);
>          return 1;
>      }
> @@ -163,7 +147,6 @@ int win_chr_pipe_poll(void *opaque)
>      PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
>      if (size > 0) {
>          s->len = size;
> -        win_chr_read_poll(chr);
>          win_chr_read(chr);
>          return 1;
>      }
>
