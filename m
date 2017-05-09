Received: from eggs.gnu.org ([2001:4830:134:3::10]:48783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84Z1-0007jX-7f
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84Yw-00010T-Bd
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:48:27 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d84Yw-0000zw-52
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:48:22 -0400
Received: by mail-qt0-x243.google.com with SMTP id j13so13598210qta.3
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 05:48:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-5-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f1dd9f88-6a7a-b3e3-41c7-a0bf6e5e3403@amsat.org>
Date: Tue, 9 May 2017 09:48:18 -0300
MIME-Version: 1.0
In-Reply-To: <20170509113332.4987-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/13] char-win: rename hcom->file
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
> hcom is the name of the file handle, regardless of the actual chardev
> driver (serial, file, console etc..). Rename it to be more explicit.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  chardev/char-win.h  |  2 +-
>  chardev/char-pipe.c | 10 +++++-----
>  chardev/char-win.c  | 36 ++++++++++++++++++------------------
>  3 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/chardev/char-win.h b/chardev/char-win.h
> index e0b3839a77..888be2b3ca 100644
> --- a/chardev/char-win.h
> +++ b/chardev/char-win.h
> @@ -29,7 +29,7 @@
>  typedef struct {
>      Chardev parent;
>
> -    HANDLE hcom, hrecv, hsend;
> +    HANDLE file, hrecv, hsend;
>      OVERLAPPED orecv;
>      BOOL fpipe;
>
> diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
> index 54240c863d..aae950a22b 100644
> --- a/chardev/char-pipe.c
> +++ b/chardev/char-pipe.c
> @@ -58,27 +58,27 @@ static int win_chr_pipe_init(Chardev *chr, const char *filename,
>      }
>
>      openname = g_strdup_printf("\\\\.\\pipe\\%s", filename);
> -    s->hcom = CreateNamedPipe(openname,
> +    s->file = CreateNamedPipe(openname,
>                                PIPE_ACCESS_DUPLEX | FILE_FLAG_OVERLAPPED,
>                                PIPE_TYPE_BYTE | PIPE_READMODE_BYTE |
>                                PIPE_WAIT,
>                                MAXCONNECT, NSENDBUF, NRECVBUF, NTIMEOUT, NULL);
>      g_free(openname);
> -    if (s->hcom == INVALID_HANDLE_VALUE) {
> +    if (s->file == INVALID_HANDLE_VALUE) {
>          error_setg(errp, "Failed CreateNamedPipe (%lu)", GetLastError());
> -        s->hcom = NULL;
> +        s->file = NULL;
>          goto fail;
>      }
>
>      ZeroMemory(&ov, sizeof(ov));
>      ov.hEvent = CreateEvent(NULL, TRUE, FALSE, NULL);
> -    ret = ConnectNamedPipe(s->hcom, &ov);
> +    ret = ConnectNamedPipe(s->file, &ov);
>      if (ret) {
>          error_setg(errp, "Failed ConnectNamedPipe");
>          goto fail;
>      }
>
> -    ret = GetOverlappedResult(s->hcom, &ov, &size, TRUE);
> +    ret = GetOverlappedResult(s->file, &ov, &size, TRUE);
>      if (!ret) {
>          error_setg(errp, "Failed GetOverlappedResult");
>          if (ov.hEvent) {
> diff --git a/chardev/char-win.c b/chardev/char-win.c
> index 11abad1521..a7e3296909 100644
> --- a/chardev/char-win.c
> +++ b/chardev/char-win.c
> @@ -43,11 +43,11 @@ static void win_chr_read(Chardev *chr, DWORD len)
>
>      ZeroMemory(&s->orecv, sizeof(s->orecv));
>      s->orecv.hEvent = s->hrecv;
> -    ret = ReadFile(s->hcom, buf, len, &size, &s->orecv);
> +    ret = ReadFile(s->file, buf, len, &size, &s->orecv);
>      if (!ret) {
>          err = GetLastError();
>          if (err == ERROR_IO_PENDING) {
> -            ret = GetOverlappedResult(s->hcom, &s->orecv, &size, TRUE);
> +            ret = GetOverlappedResult(s->file, &s->orecv, &size, TRUE);
>          }
>      }
>
> @@ -63,7 +63,7 @@ static int win_chr_serial_poll(void *opaque)
>      COMSTAT status;
>      DWORD comerr;
>
> -    ClearCommError(s->hcom, &comerr, &status);
> +    ClearCommError(s->file, &comerr, &status);
>      if (status.cbInQue > 0) {
>          win_chr_read(chr, status.cbInQue);
>          return 1;
> @@ -91,15 +91,15 @@ int win_chr_serial_init(Chardev *chr, const char *filename, Error **errp)
>          goto fail;
>      }
>
> -    s->hcom = CreateFile(filename, GENERIC_READ | GENERIC_WRITE, 0, NULL,
> +    s->file = CreateFile(filename, GENERIC_READ | GENERIC_WRITE, 0, NULL,
>                        OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
> -    if (s->hcom == INVALID_HANDLE_VALUE) {
> +    if (s->file == INVALID_HANDLE_VALUE) {
>          error_setg(errp, "Failed CreateFile (%lu)", GetLastError());
> -        s->hcom = NULL;
> +        s->file = NULL;
>          goto fail;
>      }
>
> -    if (!SetupComm(s->hcom, NRECVBUF, NSENDBUF)) {
> +    if (!SetupComm(s->file, NRECVBUF, NSENDBUF)) {
>          error_setg(errp, "Failed SetupComm");
>          goto fail;
>      }
> @@ -110,23 +110,23 @@ int win_chr_serial_init(Chardev *chr, const char *filename, Error **errp)
>      comcfg.dcb.DCBlength = sizeof(DCB);
>      CommConfigDialog(filename, NULL, &comcfg);
>
> -    if (!SetCommState(s->hcom, &comcfg.dcb)) {
> +    if (!SetCommState(s->file, &comcfg.dcb)) {
>          error_setg(errp, "Failed SetCommState");
>          goto fail;
>      }
>
> -    if (!SetCommMask(s->hcom, EV_ERR)) {
> +    if (!SetCommMask(s->file, EV_ERR)) {
>          error_setg(errp, "Failed SetCommMask");
>          goto fail;
>      }
>
>      cto.ReadIntervalTimeout = MAXDWORD;
> -    if (!SetCommTimeouts(s->hcom, &cto)) {
> +    if (!SetCommTimeouts(s->file, &cto)) {
>          error_setg(errp, "Failed SetCommTimeouts");
>          goto fail;
>      }
>
> -    if (!ClearCommError(s->hcom, &err, &comstat)) {
> +    if (!ClearCommError(s->file, &err, &comstat)) {
>          error_setg(errp, "Failed ClearCommError");
>          goto fail;
>      }
> @@ -143,7 +143,7 @@ int win_chr_pipe_poll(void *opaque)
>      WinChardev *s = WIN_CHARDEV(opaque);
>      DWORD size;
>
> -    PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
> +    PeekNamedPipe(s->file, NULL, 0, NULL, &size, NULL);
>      if (size > 0) {
>          win_chr_read(chr, size);
>          return 1;
> @@ -162,14 +162,14 @@ static int win_chr_write(Chardev *chr, const uint8_t *buf, int len1)
>      s->osend.hEvent = s->hsend;
>      while (len > 0) {
>          if (s->hsend) {
> -            ret = WriteFile(s->hcom, buf, len, &size, &s->osend);
> +            ret = WriteFile(s->file, buf, len, &size, &s->osend);
>          } else {
> -            ret = WriteFile(s->hcom, buf, len, &size, NULL);
> +            ret = WriteFile(s->file, buf, len, &size, NULL);
>          }
>          if (!ret) {
>              err = GetLastError();
>              if (err == ERROR_IO_PENDING) {
> -                ret = GetOverlappedResult(s->hcom, &s->osend, &size, TRUE);
> +                ret = GetOverlappedResult(s->file, &s->osend, &size, TRUE);
>                  if (ret) {
>                      buf += size;
>                      len -= size;
> @@ -202,8 +202,8 @@ static void char_win_finalize(Object *obj)
>      if (s->hrecv) {
>          CloseHandle(s->hrecv);
>      }
> -    if (s->hcom) {
> -        CloseHandle(s->hcom);
> +    if (s->file) {
> +        CloseHandle(s->file);
>      }
>      if (s->fpipe) {
>          qemu_del_polling_cb(win_chr_pipe_poll, chr);
> @@ -219,7 +219,7 @@ void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_out)
>      WinChardev *s = WIN_CHARDEV(chr);
>
>      s->skip_free = true;
> -    s->hcom = fd_out;
> +    s->file = fd_out;
>  }
>
>  static void char_win_class_init(ObjectClass *oc, void *data)
>
