Received: from eggs.gnu.org ([2001:4830:134:3::10]:59640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83PS-00058H-40
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83PO-0002Pu-45
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:34:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d83PN-0002Ph-RA
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:34:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4DB0C04B927
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:34:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 15:33:23 +0400
Message-Id: <20170509113332.4987-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170509113332.4987-1-marcandre.lureau@redhat.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/13] char-win: rename hcom->file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

hcom is the name of the file handle, regardless of the actual chardev
driver (serial, file, console etc..). Rename it to be more explicit.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-win.h  |  2 +-
 chardev/char-pipe.c | 10 +++++-----
 chardev/char-win.c  | 36 ++++++++++++++++++------------------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/chardev/char-win.h b/chardev/char-win.h
index e0b3839a77..888be2b3ca 100644
--- a/chardev/char-win.h
+++ b/chardev/char-win.h
@@ -29,7 +29,7 @@
 typedef struct {
     Chardev parent;
=20
-    HANDLE hcom, hrecv, hsend;
+    HANDLE file, hrecv, hsend;
     OVERLAPPED orecv;
     BOOL fpipe;
=20
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index 54240c863d..aae950a22b 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -58,27 +58,27 @@ static int win_chr_pipe_init(Chardev *chr, const char=
 *filename,
     }
=20
     openname =3D g_strdup_printf("\\\\.\\pipe\\%s", filename);
-    s->hcom =3D CreateNamedPipe(openname,
+    s->file =3D CreateNamedPipe(openname,
                               PIPE_ACCESS_DUPLEX | FILE_FLAG_OVERLAPPED,
                               PIPE_TYPE_BYTE | PIPE_READMODE_BYTE |
                               PIPE_WAIT,
                               MAXCONNECT, NSENDBUF, NRECVBUF, NTIMEOUT, =
NULL);
     g_free(openname);
-    if (s->hcom =3D=3D INVALID_HANDLE_VALUE) {
+    if (s->file =3D=3D INVALID_HANDLE_VALUE) {
         error_setg(errp, "Failed CreateNamedPipe (%lu)", GetLastError())=
;
-        s->hcom =3D NULL;
+        s->file =3D NULL;
         goto fail;
     }
=20
     ZeroMemory(&ov, sizeof(ov));
     ov.hEvent =3D CreateEvent(NULL, TRUE, FALSE, NULL);
-    ret =3D ConnectNamedPipe(s->hcom, &ov);
+    ret =3D ConnectNamedPipe(s->file, &ov);
     if (ret) {
         error_setg(errp, "Failed ConnectNamedPipe");
         goto fail;
     }
=20
-    ret =3D GetOverlappedResult(s->hcom, &ov, &size, TRUE);
+    ret =3D GetOverlappedResult(s->file, &ov, &size, TRUE);
     if (!ret) {
         error_setg(errp, "Failed GetOverlappedResult");
         if (ov.hEvent) {
diff --git a/chardev/char-win.c b/chardev/char-win.c
index 11abad1521..a7e3296909 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -43,11 +43,11 @@ static void win_chr_read(Chardev *chr, DWORD len)
=20
     ZeroMemory(&s->orecv, sizeof(s->orecv));
     s->orecv.hEvent =3D s->hrecv;
-    ret =3D ReadFile(s->hcom, buf, len, &size, &s->orecv);
+    ret =3D ReadFile(s->file, buf, len, &size, &s->orecv);
     if (!ret) {
         err =3D GetLastError();
         if (err =3D=3D ERROR_IO_PENDING) {
-            ret =3D GetOverlappedResult(s->hcom, &s->orecv, &size, TRUE)=
;
+            ret =3D GetOverlappedResult(s->file, &s->orecv, &size, TRUE)=
;
         }
     }
=20
@@ -63,7 +63,7 @@ static int win_chr_serial_poll(void *opaque)
     COMSTAT status;
     DWORD comerr;
=20
-    ClearCommError(s->hcom, &comerr, &status);
+    ClearCommError(s->file, &comerr, &status);
     if (status.cbInQue > 0) {
         win_chr_read(chr, status.cbInQue);
         return 1;
@@ -91,15 +91,15 @@ int win_chr_serial_init(Chardev *chr, const char *fil=
ename, Error **errp)
         goto fail;
     }
=20
-    s->hcom =3D CreateFile(filename, GENERIC_READ | GENERIC_WRITE, 0, NU=
LL,
+    s->file =3D CreateFile(filename, GENERIC_READ | GENERIC_WRITE, 0, NU=
LL,
                       OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
-    if (s->hcom =3D=3D INVALID_HANDLE_VALUE) {
+    if (s->file =3D=3D INVALID_HANDLE_VALUE) {
         error_setg(errp, "Failed CreateFile (%lu)", GetLastError());
-        s->hcom =3D NULL;
+        s->file =3D NULL;
         goto fail;
     }
=20
-    if (!SetupComm(s->hcom, NRECVBUF, NSENDBUF)) {
+    if (!SetupComm(s->file, NRECVBUF, NSENDBUF)) {
         error_setg(errp, "Failed SetupComm");
         goto fail;
     }
@@ -110,23 +110,23 @@ int win_chr_serial_init(Chardev *chr, const char *f=
ilename, Error **errp)
     comcfg.dcb.DCBlength =3D sizeof(DCB);
     CommConfigDialog(filename, NULL, &comcfg);
=20
-    if (!SetCommState(s->hcom, &comcfg.dcb)) {
+    if (!SetCommState(s->file, &comcfg.dcb)) {
         error_setg(errp, "Failed SetCommState");
         goto fail;
     }
=20
-    if (!SetCommMask(s->hcom, EV_ERR)) {
+    if (!SetCommMask(s->file, EV_ERR)) {
         error_setg(errp, "Failed SetCommMask");
         goto fail;
     }
=20
     cto.ReadIntervalTimeout =3D MAXDWORD;
-    if (!SetCommTimeouts(s->hcom, &cto)) {
+    if (!SetCommTimeouts(s->file, &cto)) {
         error_setg(errp, "Failed SetCommTimeouts");
         goto fail;
     }
=20
-    if (!ClearCommError(s->hcom, &err, &comstat)) {
+    if (!ClearCommError(s->file, &err, &comstat)) {
         error_setg(errp, "Failed ClearCommError");
         goto fail;
     }
@@ -143,7 +143,7 @@ int win_chr_pipe_poll(void *opaque)
     WinChardev *s =3D WIN_CHARDEV(opaque);
     DWORD size;
=20
-    PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
+    PeekNamedPipe(s->file, NULL, 0, NULL, &size, NULL);
     if (size > 0) {
         win_chr_read(chr, size);
         return 1;
@@ -162,14 +162,14 @@ static int win_chr_write(Chardev *chr, const uint8_=
t *buf, int len1)
     s->osend.hEvent =3D s->hsend;
     while (len > 0) {
         if (s->hsend) {
-            ret =3D WriteFile(s->hcom, buf, len, &size, &s->osend);
+            ret =3D WriteFile(s->file, buf, len, &size, &s->osend);
         } else {
-            ret =3D WriteFile(s->hcom, buf, len, &size, NULL);
+            ret =3D WriteFile(s->file, buf, len, &size, NULL);
         }
         if (!ret) {
             err =3D GetLastError();
             if (err =3D=3D ERROR_IO_PENDING) {
-                ret =3D GetOverlappedResult(s->hcom, &s->osend, &size, T=
RUE);
+                ret =3D GetOverlappedResult(s->file, &s->osend, &size, T=
RUE);
                 if (ret) {
                     buf +=3D size;
                     len -=3D size;
@@ -202,8 +202,8 @@ static void char_win_finalize(Object *obj)
     if (s->hrecv) {
         CloseHandle(s->hrecv);
     }
-    if (s->hcom) {
-        CloseHandle(s->hcom);
+    if (s->file) {
+        CloseHandle(s->file);
     }
     if (s->fpipe) {
         qemu_del_polling_cb(win_chr_pipe_poll, chr);
@@ -219,7 +219,7 @@ void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_o=
ut)
     WinChardev *s =3D WIN_CHARDEV(chr);
=20
     s->skip_free =3D true;
-    s->hcom =3D fd_out;
+    s->file =3D fd_out;
 }
=20
 static void char_win_class_init(ObjectClass *oc, void *data)
--=20
2.13.0.rc1.16.gd80b50c3f
