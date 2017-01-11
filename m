Received: from eggs.gnu.org ([2001:4830:134:3::10]:41038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjZ-0001KC-Rk
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjX-0006aY-T2
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRMjX-0006a6-Kr
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:47 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D454A4D6A3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:30:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 18:29:52 +0100
Message-Id: <20170111172956.11255-37-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-1-marcandre.lureau@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 36/40] char: move pipe chardev in its own file
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
---
 chardev/char-pipe.c   | 168 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        | 166 --------------------------------------------=
-----
 chardev/Makefile.objs |   1 +
 3 files changed, 169 insertions(+), 166 deletions(-)
 create mode 100644 chardev/char-pipe.c

diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
new file mode 100644
index 0000000000..3c8ef350a1
--- /dev/null
+++ b/chardev/char-pipe.c
@@ -0,0 +1,168 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "sysemu/char.h"
+
+#ifdef _WIN32
+#include "char-win.h"
+#else
+#include "char-fd.h"
+#endif
+
+#ifdef _WIN32
+#define MAXCONNECT 1
+#define NTIMEOUT 5000
+
+static int win_chr_pipe_init(Chardev *chr, const char *filename,
+                             Error **errp)
+{
+    WinChardev *s =3D WIN_CHARDEV(chr);
+    OVERLAPPED ov;
+    int ret;
+    DWORD size;
+    char *openname;
+
+    s->fpipe =3D TRUE;
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
+    openname =3D g_strdup_printf("\\\\.\\pipe\\%s", filename);
+    s->hcom =3D CreateNamedPipe(openname,
+                              PIPE_ACCESS_DUPLEX | FILE_FLAG_OVERLAPPED,
+                              PIPE_TYPE_BYTE | PIPE_READMODE_BYTE |
+                              PIPE_WAIT,
+                              MAXCONNECT, NSENDBUF, NRECVBUF, NTIMEOUT, =
NULL);
+    g_free(openname);
+    if (s->hcom =3D=3D INVALID_HANDLE_VALUE) {
+        error_setg(errp, "Failed CreateNamedPipe (%lu)", GetLastError())=
;
+        s->hcom =3D NULL;
+        goto fail;
+    }
+
+    ZeroMemory(&ov, sizeof(ov));
+    ov.hEvent =3D CreateEvent(NULL, TRUE, FALSE, NULL);
+    ret =3D ConnectNamedPipe(s->hcom, &ov);
+    if (ret) {
+        error_setg(errp, "Failed ConnectNamedPipe");
+        goto fail;
+    }
+
+    ret =3D GetOverlappedResult(s->hcom, &ov, &size, TRUE);
+    if (!ret) {
+        error_setg(errp, "Failed GetOverlappedResult");
+        if (ov.hEvent) {
+            CloseHandle(ov.hEvent);
+            ov.hEvent =3D NULL;
+        }
+        goto fail;
+    }
+
+    if (ov.hEvent) {
+        CloseHandle(ov.hEvent);
+        ov.hEvent =3D NULL;
+    }
+    qemu_add_polling_cb(win_chr_pipe_poll, chr);
+    return 0;
+
+ fail:
+    return -1;
+}
+
+static void qemu_chr_open_pipe(Chardev *chr,
+                               ChardevBackend *backend,
+                               bool *be_opened,
+                               Error **errp)
+{
+    ChardevHostdev *opts =3D backend->u.pipe.data;
+    const char *filename =3D opts->device;
+
+    if (win_chr_pipe_init(chr, filename, errp) < 0) {
+        return;
+    }
+}
+
+#else
+
+static void qemu_chr_open_pipe(Chardev *chr,
+                               ChardevBackend *backend,
+                               bool *be_opened,
+                               Error **errp)
+{
+    ChardevHostdev *opts =3D backend->u.pipe.data;
+    int fd_in, fd_out;
+    char *filename_in;
+    char *filename_out;
+    const char *filename =3D opts->device;
+
+    filename_in =3D g_strdup_printf("%s.in", filename);
+    filename_out =3D g_strdup_printf("%s.out", filename);
+    TFR(fd_in =3D qemu_open(filename_in, O_RDWR | O_BINARY));
+    TFR(fd_out =3D qemu_open(filename_out, O_RDWR | O_BINARY));
+    g_free(filename_in);
+    g_free(filename_out);
+    if (fd_in < 0 || fd_out < 0) {
+        if (fd_in >=3D 0) {
+            close(fd_in);
+        }
+        if (fd_out >=3D 0) {
+            close(fd_out);
+        }
+        TFR(fd_in =3D fd_out =3D qemu_open(filename, O_RDWR | O_BINARY))=
;
+        if (fd_in < 0) {
+            error_setg_file_open(errp, errno, filename);
+            return;
+        }
+    }
+    qemu_chr_open_fd(chr, fd_in, fd_out);
+}
+
+#endif /* !_WIN32 */
+
+static void qemu_chr_parse_pipe(QemuOpts *opts, ChardevBackend *backend,
+                                Error **errp)
+{
+    const char *device =3D qemu_opt_get(opts, "path");
+    ChardevHostdev *dev;
+
+    if (device =3D=3D NULL) {
+        error_setg(errp, "chardev: pipe: no device path given");
+        return;
+    }
+    backend->type =3D CHARDEV_BACKEND_KIND_PIPE;
+    dev =3D backend->u.pipe.data =3D g_new0(ChardevHostdev, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
+    dev->device =3D g_strdup(device);
+}
+
+static void char_pipe_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_pipe;
+    cc->open =3D qemu_chr_open_pipe;
+}
+
+static const TypeInfo char_pipe_type_info =3D {
+    .name =3D TYPE_CHARDEV_PIPE,
+#ifdef _WIN32
+    .parent =3D TYPE_CHARDEV_WIN,
+#else
+    .parent =3D TYPE_CHARDEV_FD,
+#endif
+    .class_init =3D char_pipe_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_pipe_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index a11cec378d..f8e54d9c4b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -655,36 +655,6 @@ void qemu_chr_fe_take_focus(CharBackend *b)
 }
=20
 #ifndef _WIN32
-static void qemu_chr_open_pipe(Chardev *chr,
-                               ChardevBackend *backend,
-                               bool *be_opened,
-                               Error **errp)
-{
-    ChardevHostdev *opts =3D backend->u.pipe.data;
-    int fd_in, fd_out;
-    char *filename_in;
-    char *filename_out;
-    const char *filename =3D opts->device;
-
-    filename_in =3D g_strdup_printf("%s.in", filename);
-    filename_out =3D g_strdup_printf("%s.out", filename);
-    TFR(fd_in =3D qemu_open(filename_in, O_RDWR | O_BINARY));
-    TFR(fd_out =3D qemu_open(filename_out, O_RDWR | O_BINARY));
-    g_free(filename_in);
-    g_free(filename_out);
-    if (fd_in < 0 || fd_out < 0) {
-	if (fd_in >=3D 0)
-	    close(fd_in);
-	if (fd_out >=3D 0)
-	    close(fd_out);
-        TFR(fd_in =3D fd_out =3D qemu_open(filename, O_RDWR | O_BINARY))=
;
-        if (fd_in < 0) {
-            error_setg_file_open(errp, errno, filename);
-            return;
-        }
-    }
-    qemu_chr_open_fd(chr, fd_in, fd_out);
-}
=20
 #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
     || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFl=
y__) \
@@ -1325,107 +1295,6 @@ static void qemu_chr_open_pp_fd(Chardev *chr,
=20
 #define HAVE_CHARDEV_SERIAL 1
=20
-#define MAXCONNECT 1
-#define NTIMEOUT 5000
-
-static int win_chr_pipe_init(Chardev *chr, const char *filename,
-                             Error **errp)
-{
-    WinChardev *s =3D WIN_CHARDEV(chr);
-    OVERLAPPED ov;
-    int ret;
-    DWORD size;
-    char *openname;
-
-    s->fpipe =3D TRUE;
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
-    openname =3D g_strdup_printf("\\\\.\\pipe\\%s", filename);
-    s->hcom =3D CreateNamedPipe(openname, PIPE_ACCESS_DUPLEX | FILE_FLAG=
_OVERLAPPED,
-                              PIPE_TYPE_BYTE | PIPE_READMODE_BYTE |
-                              PIPE_WAIT,
-                              MAXCONNECT, NSENDBUF, NRECVBUF, NTIMEOUT, =
NULL);
-    g_free(openname);
-    if (s->hcom =3D=3D INVALID_HANDLE_VALUE) {
-        error_setg(errp, "Failed CreateNamedPipe (%lu)", GetLastError())=
;
-        s->hcom =3D NULL;
-        goto fail;
-    }
-
-    ZeroMemory(&ov, sizeof(ov));
-    ov.hEvent =3D CreateEvent(NULL, TRUE, FALSE, NULL);
-    ret =3D ConnectNamedPipe(s->hcom, &ov);
-    if (ret) {
-        error_setg(errp, "Failed ConnectNamedPipe");
-        goto fail;
-    }
-
-    ret =3D GetOverlappedResult(s->hcom, &ov, &size, TRUE);
-    if (!ret) {
-        error_setg(errp, "Failed GetOverlappedResult");
-        if (ov.hEvent) {
-            CloseHandle(ov.hEvent);
-            ov.hEvent =3D NULL;
-        }
-        goto fail;
-    }
-
-    if (ov.hEvent) {
-        CloseHandle(ov.hEvent);
-        ov.hEvent =3D NULL;
-    }
-    qemu_add_polling_cb(win_chr_pipe_poll, chr);
-    return 0;
-
- fail:
-    return -1;
-}
-
-
-static void qemu_chr_open_pipe(Chardev *chr,
-                               ChardevBackend *backend,
-                               bool *be_opened,
-                               Error **errp)
-{
-    ChardevHostdev *opts =3D backend->u.pipe.data;
-    const char *filename =3D opts->device;
-
-    if (win_chr_pipe_init(chr, filename, errp) < 0) {
-        return;
-    }
-}
-
-static void qemu_chr_open_win_con(Chardev *chr,
-                                  ChardevBackend *backend,
-                                  bool *be_opened,
-                                  Error **errp)
-{
-    qemu_chr_open_win_file(chr, GetStdHandle(STD_OUTPUT_HANDLE));
-}
-
-static void char_console_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->open =3D qemu_chr_open_win_con;
-}
-
-static const TypeInfo char_console_type_info =3D {
-    .name =3D TYPE_CHARDEV_CONSOLE,
-    .parent =3D TYPE_CHARDEV_WIN,
-    .class_init =3D char_console_class_init,
-};
-
 #endif /* !_WIN32 */
=20
 int qemu_chr_wait_connected(Chardev *chr, Error **errp)
@@ -1638,40 +1507,6 @@ static void qemu_chr_parse_parallel(QemuOpts *opts=
, ChardevBackend *backend,
 }
 #endif
=20
-static void qemu_chr_parse_pipe(QemuOpts *opts, ChardevBackend *backend,
-                                Error **errp)
-{
-    const char *device =3D qemu_opt_get(opts, "path");
-    ChardevHostdev *dev;
-
-    backend->type =3D CHARDEV_BACKEND_KIND_PIPE;
-    if (device =3D=3D NULL) {
-        error_setg(errp, "chardev: pipe: no device path given");
-        return;
-    }
-    dev =3D backend->u.pipe.data =3D g_new0(ChardevHostdev, 1);
-    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
-    dev->device =3D g_strdup(device);
-}
-
-static void char_pipe_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->parse =3D qemu_chr_parse_pipe;
-    cc->open =3D qemu_chr_open_pipe;
-}
-
-static const TypeInfo char_pipe_type_info =3D {
-    .name =3D TYPE_CHARDEV_PIPE,
-#ifdef _WIN32
-    .parent =3D TYPE_CHARDEV_WIN,
-#else
-    .parent =3D TYPE_CHARDEV_FD,
-#endif
-    .class_init =3D char_pipe_class_init,
-};
-
 static const ChardevClass *char_get_class(const char *driver, Error **er=
rp)
 {
     ObjectClass *oc;
@@ -2321,7 +2156,6 @@ static void register_types(void)
 #ifdef HAVE_CHARDEV_PTY
     type_register_static(&char_pty_type_info);
 #endif
-    type_register_static(&char_pipe_type_info);
=20
     /* this must be done after machine init, since we register FEs with =
muxes
      * as part of realize functions like serial_isa_realizefn when -nogr=
aphic
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 265a6dad5d..778b312377 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -5,6 +5,7 @@ chardev-obj-y +=3D char-file.o
 chardev-obj-y +=3D char-io.o
 chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
+chardev-obj-y +=3D char-pipe.o
 chardev-obj-y +=3D char-ringbuf.o
 chardev-obj-y +=3D char-socket.o
 chardev-obj-y +=3D char-stdio.o
--=20
2.11.0
