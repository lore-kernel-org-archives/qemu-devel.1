Received: from eggs.gnu.org ([2001:4830:134:3::10]:48684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84YP-0007P5-H6
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84YK-00005c-KR
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:47:49 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84YK-00005H-Fg
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:47:44 -0400
Received: by mail-qk0-x242.google.com with SMTP id y128so14497272qka.3
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 05:47:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1fb4bd39-474d-4bc9-53e8-389cc21c86a1@amsat.org>
Date: Tue, 9 May 2017 09:47:40 -0300
MIME-Version: 1.0
In-Reply-To: <20170509113332.4987-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/13] char-win: remove WinChardev.len
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
> The "len" argument can be passed directly to win_chr_read()
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  chardev/char-win.h |  1 -
>  chardev/char-win.c | 16 +++++++---------
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/chardev/char-win.h b/chardev/char-win.h
> index 73a0e3caef..70215e04c2 100644
> --- a/chardev/char-win.h
> +++ b/chardev/char-win.h
> @@ -32,7 +32,6 @@ typedef struct {
>      HANDLE hcom, hrecv, hsend;
>      OVERLAPPED orecv;
>      BOOL fpipe;
> -    DWORD len;
>
>      /* Protected by the Chardev chr_write_lock.  */
>      OVERLAPPED osend;
> diff --git a/chardev/char-win.c b/chardev/char-win.c
> index a46d878ef8..5e7daeeae1 100644
> --- a/chardev/char-win.c
> +++ b/chardev/char-win.c
> @@ -26,7 +26,7 @@
>  #include "qapi/error.h"
>  #include "char-win.h"
>
> -static void win_chr_read(Chardev *chr)
> +static void win_chr_read(Chardev *chr, DWORD len)
>  {
>      WinChardev *s = WIN_CHARDEV(chr);
>      int max_size = qemu_chr_be_can_write(chr);
> @@ -34,16 +34,16 @@ static void win_chr_read(Chardev *chr)
>      uint8_t buf[CHR_READ_BUF_LEN];
>      DWORD size;
>
> -    if (s->len > max_size) {
> -        s->len = max_size;
> +    if (len > max_size) {
> +        len = max_size;
>      }
> -    if (s->len == 0) {
> +    if (len == 0) {
>          return;
>      }
>
>      ZeroMemory(&s->orecv, sizeof(s->orecv));
>      s->orecv.hEvent = s->hrecv;
> -    ret = ReadFile(s->hcom, buf, s->len, &size, &s->orecv);
> +    ret = ReadFile(s->hcom, buf, len, &size, &s->orecv);
>      if (!ret) {
>          err = GetLastError();
>          if (err == ERROR_IO_PENDING) {
> @@ -65,8 +65,7 @@ static int win_chr_poll(void *opaque)
>
>      ClearCommError(s->hcom, &comerr, &status);
>      if (status.cbInQue > 0) {
> -        s->len = status.cbInQue;
> -        win_chr_read(chr);
> +        win_chr_read(chr, status.cbInQue);
>          return 1;
>      }
>      return 0;
> @@ -146,8 +145,7 @@ int win_chr_pipe_poll(void *opaque)
>
>      PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
>      if (size > 0) {
> -        s->len = size;
> -        win_chr_read(chr);
> +        win_chr_read(chr, size);
>          return 1;
>      }
>      return 0;
>
