Received: from eggs.gnu.org ([2001:4830:134:3::10]:38625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCE3-0006Jc-8R
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCE0-00079E-02
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCDz-00078z-NT
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:27 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D63183D94D
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:42:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:43 +0400
Message-Id: <20170130133954.31353-31-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 30/41] char: move win chardev base class in
 its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Eric Blake <eblake@redhat.com>
---
 chardev/char-win.h    |  53 ++++++++++
 chardev/char-win.c    | 265 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        | 253 +-------------------------------------------=
---
 chardev/Makefile.objs |   1 +
 4 files changed, 322 insertions(+), 250 deletions(-)
 create mode 100644 chardev/char-win.h
 create mode 100644 chardev/char-win.c

diff --git a/chardev/char-win.h b/chardev/char-win.h
new file mode 100644
index 0000000000..d78a7d7972
--- /dev/null
+++ b/chardev/char-win.h
@@ -0,0 +1,53 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#ifndef CHAR_WIN_H
+#define CHAR_WIN_H
+
+#include "sysemu/char.h"
+
+typedef struct {
+    Chardev parent;
+    int max_size;
+    HANDLE hcom, hrecv, hsend;
+    OVERLAPPED orecv;
+    BOOL fpipe;
+    DWORD len;
+
+    /* Protected by the Chardev chr_write_lock.  */
+    OVERLAPPED osend;
+    /* FIXME: file/console do not finalize */
+    bool skip_free;
+} WinChardev;
+
+#define NSENDBUF 2048
+#define NRECVBUF 2048
+
+#define TYPE_CHARDEV_WIN "chardev-win"
+#define WIN_CHARDEV(obj) OBJECT_CHECK(WinChardev, (obj), TYPE_CHARDEV_WI=
N)
+
+void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_out);
+int win_chr_init(Chardev *chr, const char *filename, Error **errp);
+int win_chr_pipe_poll(void *opaque);
+
+#endif /* CHAR_WIN_H */
diff --git a/chardev/char-win.c b/chardev/char-win.c
new file mode 100644
index 0000000000..e4b6957ded
--- /dev/null
+++ b/chardev/char-win.c
@@ -0,0 +1,265 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "char-win.h"
+
+static void win_chr_readfile(Chardev *chr)
+{
+    WinChardev *s =3D WIN_CHARDEV(chr);
+
+    int ret, err;
+    uint8_t buf[CHR_READ_BUF_LEN];
+    DWORD size;
+
+    ZeroMemory(&s->orecv, sizeof(s->orecv));
+    s->orecv.hEvent =3D s->hrecv;
+    ret =3D ReadFile(s->hcom, buf, s->len, &size, &s->orecv);
+    if (!ret) {
+        err =3D GetLastError();
+        if (err =3D=3D ERROR_IO_PENDING) {
+            ret =3D GetOverlappedResult(s->hcom, &s->orecv, &size, TRUE)=
;
+        }
+    }
+
+    if (size > 0) {
+        qemu_chr_be_write(chr, buf, size);
+    }
+}
+
+static void win_chr_read(Chardev *chr)
+{
+    WinChardev *s =3D WIN_CHARDEV(chr);
+
+    if (s->len > s->max_size) {
+        s->len =3D s->max_size;
+    }
+    if (s->len =3D=3D 0) {
+        return;
+    }
+
+    win_chr_readfile(chr);
+}
+
+static int win_chr_read_poll(Chardev *chr)
+{
+    WinChardev *s =3D WIN_CHARDEV(chr);
+
+    s->max_size =3D qemu_chr_be_can_write(chr);
+    return s->max_size;
+}
+
+static int win_chr_poll(void *opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    WinChardev *s =3D WIN_CHARDEV(opaque);
+    COMSTAT status;
+    DWORD comerr;
+
+    ClearCommError(s->hcom, &comerr, &status);
+    if (status.cbInQue > 0) {
+        s->len =3D status.cbInQue;
+        win_chr_read_poll(chr);
+        win_chr_read(chr);
+        return 1;
+    }
+    return 0;
+}
+
+int win_chr_init(Chardev *chr, const char *filename, Error **errp)
+{
+    WinChardev *s =3D WIN_CHARDEV(chr);
+    COMMCONFIG comcfg;
+    COMMTIMEOUTS cto =3D { 0, 0, 0, 0, 0};
+    COMSTAT comstat;
+    DWORD size;
+    DWORD err;
+
+    s->hsend =3D CreateEvent(NULL, TRUE, FALSE, NULL);
+    if (!s->hsend) {
+        error_setg(errp, "Failed CreateEvent");
+        goto fail;
+    }
+    s->hrecv =3D CreateEvent(NULL, TRUE, FALSE, NULL);
+    if (!s->hrecv) {
+        error_setg(errp, "Failed CreateEvent");
+        goto fail;
+    }
+
+    s->hcom =3D CreateFile(filename, GENERIC_READ | GENERIC_WRITE, 0, NU=
LL,
+                      OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
+    if (s->hcom =3D=3D INVALID_HANDLE_VALUE) {
+        error_setg(errp, "Failed CreateFile (%lu)", GetLastError());
+        s->hcom =3D NULL;
+        goto fail;
+    }
+
+    if (!SetupComm(s->hcom, NRECVBUF, NSENDBUF)) {
+        error_setg(errp, "Failed SetupComm");
+        goto fail;
+    }
+
+    ZeroMemory(&comcfg, sizeof(COMMCONFIG));
+    size =3D sizeof(COMMCONFIG);
+    GetDefaultCommConfig(filename, &comcfg, &size);
+    comcfg.dcb.DCBlength =3D sizeof(DCB);
+    CommConfigDialog(filename, NULL, &comcfg);
+
+    if (!SetCommState(s->hcom, &comcfg.dcb)) {
+        error_setg(errp, "Failed SetCommState");
+        goto fail;
+    }
+
+    if (!SetCommMask(s->hcom, EV_ERR)) {
+        error_setg(errp, "Failed SetCommMask");
+        goto fail;
+    }
+
+    cto.ReadIntervalTimeout =3D MAXDWORD;
+    if (!SetCommTimeouts(s->hcom, &cto)) {
+        error_setg(errp, "Failed SetCommTimeouts");
+        goto fail;
+    }
+
+    if (!ClearCommError(s->hcom, &err, &comstat)) {
+        error_setg(errp, "Failed ClearCommError");
+        goto fail;
+    }
+    qemu_add_polling_cb(win_chr_poll, chr);
+    return 0;
+
+ fail:
+    return -1;
+}
+
+int win_chr_pipe_poll(void *opaque)
+{
+    Chardev *chr =3D CHARDEV(opaque);
+    WinChardev *s =3D WIN_CHARDEV(opaque);
+    DWORD size;
+
+    PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
+    if (size > 0) {
+        s->len =3D size;
+        win_chr_read_poll(chr);
+        win_chr_read(chr);
+        return 1;
+    }
+    return 0;
+}
+
+/* Called with chr_write_lock held.  */
+static int win_chr_write(Chardev *chr, const uint8_t *buf, int len1)
+{
+    WinChardev *s =3D WIN_CHARDEV(chr);
+    DWORD len, ret, size, err;
+
+    len =3D len1;
+    ZeroMemory(&s->osend, sizeof(s->osend));
+    s->osend.hEvent =3D s->hsend;
+    while (len > 0) {
+        if (s->hsend) {
+            ret =3D WriteFile(s->hcom, buf, len, &size, &s->osend);
+        } else {
+            ret =3D WriteFile(s->hcom, buf, len, &size, NULL);
+        }
+        if (!ret) {
+            err =3D GetLastError();
+            if (err =3D=3D ERROR_IO_PENDING) {
+                ret =3D GetOverlappedResult(s->hcom, &s->osend, &size, T=
RUE);
+                if (ret) {
+                    buf +=3D size;
+                    len -=3D size;
+                } else {
+                    break;
+                }
+            } else {
+                break;
+            }
+        } else {
+            buf +=3D size;
+            len -=3D size;
+        }
+    }
+    return len1 - len;
+}
+
+static void char_win_finalize(Object *obj)
+{
+    Chardev *chr =3D CHARDEV(obj);
+    WinChardev *s =3D WIN_CHARDEV(chr);
+
+    if (s->skip_free) {
+        return;
+    }
+
+    if (s->hsend) {
+        CloseHandle(s->hsend);
+    }
+    if (s->hrecv) {
+        CloseHandle(s->hrecv);
+    }
+    if (s->hcom) {
+        CloseHandle(s->hcom);
+    }
+    if (s->fpipe) {
+        qemu_del_polling_cb(win_chr_pipe_poll, chr);
+    } else {
+        qemu_del_polling_cb(win_chr_poll, chr);
+    }
+
+    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+}
+
+void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_out)
+{
+    WinChardev *s =3D WIN_CHARDEV(chr);
+
+    s->skip_free =3D true;
+    s->hcom =3D fd_out;
+}
+
+static void char_win_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->chr_write =3D win_chr_write;
+}
+
+static const TypeInfo char_win_type_info =3D {
+    .name =3D TYPE_CHARDEV_WIN,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(WinChardev),
+    .instance_finalize =3D char_win_finalize,
+    .class_init =3D char_win_class_init,
+    .abstract =3D true,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_win_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index aad57ac17e..b80fcae028 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -88,6 +88,9 @@
 #include "char-mux.h"
 #include "char-fd.h"
 #include "char-io.h"
+#ifdef _WIN32
+#include "char-win.h"
+#endif
=20
 #define TCP_MAX_FDS 16
=20
@@ -1473,23 +1476,6 @@ static void qemu_chr_open_pp_fd(Chardev *chr,
=20
 typedef struct {
     Chardev parent;
-    int max_size;
-    HANDLE hcom, hrecv, hsend;
-    OVERLAPPED orecv;
-    BOOL fpipe;
-    DWORD len;
-
-    /* Protected by the Chardev chr_write_lock.  */
-    OVERLAPPED osend;
-    /* FIXME: file/console do not finalize */
-    bool skip_free;
-} WinChardev;
-
-#define TYPE_CHARDEV_WIN "chardev-win"
-#define WIN_CHARDEV(obj) OBJECT_CHECK(WinChardev, (obj), TYPE_CHARDEV_WI=
N)
-
-typedef struct {
-    Chardev parent;
     HANDLE  hStdIn;
     HANDLE  hInputReadyEvent;
     HANDLE  hInputDoneEvent;
@@ -1501,217 +1487,9 @@ typedef struct {
 #define WIN_STDIO_CHARDEV(obj)                                  \
     OBJECT_CHECK(WinStdioChardev, (obj), TYPE_CHARDEV_WIN_STDIO)
=20
-#define NSENDBUF 2048
-#define NRECVBUF 2048
 #define MAXCONNECT 1
 #define NTIMEOUT 5000
=20
-static int win_chr_poll(void *opaque);
-static int win_chr_pipe_poll(void *opaque);
-
-static void char_win_finalize(Object *obj)
-{
-    Chardev *chr =3D CHARDEV(obj);
-    WinChardev *s =3D WIN_CHARDEV(chr);
-
-    if (s->skip_free) {
-        return;
-    }
-
-    if (s->hsend) {
-        CloseHandle(s->hsend);
-    }
-    if (s->hrecv) {
-        CloseHandle(s->hrecv);
-    }
-    if (s->hcom) {
-        CloseHandle(s->hcom);
-    }
-    if (s->fpipe)
-        qemu_del_polling_cb(win_chr_pipe_poll, chr);
-    else
-        qemu_del_polling_cb(win_chr_poll, chr);
-
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
-}
-
-static int win_chr_init(Chardev *chr, const char *filename, Error **errp=
)
-{
-    WinChardev *s =3D WIN_CHARDEV(chr);
-    COMMCONFIG comcfg;
-    COMMTIMEOUTS cto =3D { 0, 0, 0, 0, 0};
-    COMSTAT comstat;
-    DWORD size;
-    DWORD err;
-
-    s->hsend =3D CreateEvent(NULL, TRUE, FALSE, NULL);
-    if (!s->hsend) {
-        error_setg(errp, "Failed CreateEvent");
-        goto fail;
-    }
-    s->hrecv =3D CreateEvent(NULL, TRUE, FALSE, NULL);
-    if (!s->hrecv) {
-        error_setg(errp, "Failed CreateEvent");
-        goto fail;
-    }
-
-    s->hcom =3D CreateFile(filename, GENERIC_READ|GENERIC_WRITE, 0, NULL=
,
-                      OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
-    if (s->hcom =3D=3D INVALID_HANDLE_VALUE) {
-        error_setg(errp, "Failed CreateFile (%lu)", GetLastError());
-        s->hcom =3D NULL;
-        goto fail;
-    }
-
-    if (!SetupComm(s->hcom, NRECVBUF, NSENDBUF)) {
-        error_setg(errp, "Failed SetupComm");
-        goto fail;
-    }
-
-    ZeroMemory(&comcfg, sizeof(COMMCONFIG));
-    size =3D sizeof(COMMCONFIG);
-    GetDefaultCommConfig(filename, &comcfg, &size);
-    comcfg.dcb.DCBlength =3D sizeof(DCB);
-    CommConfigDialog(filename, NULL, &comcfg);
-
-    if (!SetCommState(s->hcom, &comcfg.dcb)) {
-        error_setg(errp, "Failed SetCommState");
-        goto fail;
-    }
-
-    if (!SetCommMask(s->hcom, EV_ERR)) {
-        error_setg(errp, "Failed SetCommMask");
-        goto fail;
-    }
-
-    cto.ReadIntervalTimeout =3D MAXDWORD;
-    if (!SetCommTimeouts(s->hcom, &cto)) {
-        error_setg(errp, "Failed SetCommTimeouts");
-        goto fail;
-    }
-
-    if (!ClearCommError(s->hcom, &err, &comstat)) {
-        error_setg(errp, "Failed ClearCommError");
-        goto fail;
-    }
-    qemu_add_polling_cb(win_chr_poll, chr);
-    return 0;
-
- fail:
-    return -1;
-}
-
-/* Called with chr_write_lock held.  */
-static int win_chr_write(Chardev *chr, const uint8_t *buf, int len1)
-{
-    WinChardev *s =3D WIN_CHARDEV(chr);
-    DWORD len, ret, size, err;
-
-    len =3D len1;
-    ZeroMemory(&s->osend, sizeof(s->osend));
-    s->osend.hEvent =3D s->hsend;
-    while (len > 0) {
-        if (s->hsend)
-            ret =3D WriteFile(s->hcom, buf, len, &size, &s->osend);
-        else
-            ret =3D WriteFile(s->hcom, buf, len, &size, NULL);
-        if (!ret) {
-            err =3D GetLastError();
-            if (err =3D=3D ERROR_IO_PENDING) {
-                ret =3D GetOverlappedResult(s->hcom, &s->osend, &size, T=
RUE);
-                if (ret) {
-                    buf +=3D size;
-                    len -=3D size;
-                } else {
-                    break;
-                }
-            } else {
-                break;
-            }
-        } else {
-            buf +=3D size;
-            len -=3D size;
-        }
-    }
-    return len1 - len;
-}
-
-static int win_chr_read_poll(Chardev *chr)
-{
-    WinChardev *s =3D WIN_CHARDEV(chr);
-
-    s->max_size =3D qemu_chr_be_can_write(chr);
-    return s->max_size;
-}
-
-static void win_chr_readfile(Chardev *chr)
-{
-    WinChardev *s =3D WIN_CHARDEV(chr);
-
-    int ret, err;
-    uint8_t buf[CHR_READ_BUF_LEN];
-    DWORD size;
-
-    ZeroMemory(&s->orecv, sizeof(s->orecv));
-    s->orecv.hEvent =3D s->hrecv;
-    ret =3D ReadFile(s->hcom, buf, s->len, &size, &s->orecv);
-    if (!ret) {
-        err =3D GetLastError();
-        if (err =3D=3D ERROR_IO_PENDING) {
-            ret =3D GetOverlappedResult(s->hcom, &s->orecv, &size, TRUE)=
;
-        }
-    }
-
-    if (size > 0) {
-        qemu_chr_be_write(chr, buf, size);
-    }
-}
-
-static void win_chr_read(Chardev *chr)
-{
-    WinChardev *s =3D WIN_CHARDEV(chr);
-
-    if (s->len > s->max_size)
-        s->len =3D s->max_size;
-    if (s->len =3D=3D 0)
-        return;
-
-    win_chr_readfile(chr);
-}
-
-static int win_chr_poll(void *opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    WinChardev *s =3D WIN_CHARDEV(opaque);
-    COMSTAT status;
-    DWORD comerr;
-
-    ClearCommError(s->hcom, &comerr, &status);
-    if (status.cbInQue > 0) {
-        s->len =3D status.cbInQue;
-        win_chr_read_poll(chr);
-        win_chr_read(chr);
-        return 1;
-    }
-    return 0;
-}
-
-static int win_chr_pipe_poll(void *opaque)
-{
-    Chardev *chr =3D CHARDEV(opaque);
-    WinChardev *s =3D WIN_CHARDEV(opaque);
-    DWORD size;
-
-    PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
-    if (size > 0) {
-        s->len =3D size;
-        win_chr_read_poll(chr);
-        win_chr_read(chr);
-        return 1;
-    }
-    return 0;
-}
-
 static int win_chr_pipe_init(Chardev *chr, const char *filename,
                              Error **errp)
 {
@@ -1789,30 +1567,6 @@ static void qemu_chr_open_pipe(Chardev *chr,
     }
 }
=20
-static void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_out)
-{
-    WinChardev *s =3D WIN_CHARDEV(chr);
-
-    s->skip_free =3D true;
-    s->hcom =3D fd_out;
-}
-
-static void char_win_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->chr_write =3D win_chr_write;
-}
-
-static const TypeInfo char_win_type_info =3D {
-    .name =3D TYPE_CHARDEV_WIN,
-    .parent =3D TYPE_CHARDEV,
-    .instance_size =3D sizeof(WinChardev),
-    .instance_finalize =3D char_win_finalize,
-    .class_init =3D char_win_class_init,
-    .abstract =3D true,
-};
-
 static void qemu_chr_open_win_con(Chardev *chr,
                                   ChardevBackend *backend,
                                   bool *be_opened,
@@ -4202,7 +3956,6 @@ static void register_types(void)
 {
     type_register_static(&char_type_info);
 #ifdef _WIN32
-    type_register_static(&char_win_type_info);
     type_register_static(&char_win_stdio_type_info);
 #endif
     type_register_static(&char_socket_type_info);
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index d2f03dc5df..bdf5a112a7 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -4,3 +4,4 @@ chardev-obj-y +=3D char-io.o
 chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
 chardev-obj-y +=3D char-ringbuf.o
+chardev-obj-$(CONFIG_WIN32) +=3D char-win.o
--=20
2.11.0.295.gd7dffce1c.dirty
