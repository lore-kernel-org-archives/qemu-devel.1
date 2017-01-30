Received: from eggs.gnu.org ([2001:4830:134:3::10]:38740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCEQ-0006wx-AD
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCEO-0007S5-NG
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCEO-0007Rq-Er
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:52 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CD2780F6B
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:42:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:48 +0400
Message-Id: <20170130133954.31353-36-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 35/41] char: move stdio in its own file
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
 chardev/char-stdio.c  | 164 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        | 120 ------------------------------------
 chardev/Makefile.objs |   1 +
 3 files changed, 165 insertions(+), 120 deletions(-)
 create mode 100644 chardev/char-stdio.c

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
new file mode 100644
index 0000000000..be4a65962c
--- /dev/null
+++ b/chardev/char-stdio.c
@@ -0,0 +1,164 @@
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
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "sysemu/char.h"
+
+#ifdef _WIN32
+#include "char-win.h"
+#include "char-win-stdio.h"
+#else
+#include <termios.h>
+#include "char-fd.h"
+#endif
+
+#ifndef _WIN32
+/* init terminal so that we can grab keys */
+static struct termios oldtty;
+static int old_fd0_flags;
+static bool stdio_in_use;
+static bool stdio_allow_signal;
+static bool stdio_echo_state;
+
+static void term_exit(void)
+{
+    tcsetattr(0, TCSANOW, &oldtty);
+    fcntl(0, F_SETFL, old_fd0_flags);
+}
+
+static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
+{
+    struct termios tty;
+
+    stdio_echo_state =3D echo;
+    tty =3D oldtty;
+    if (!echo) {
+        tty.c_iflag &=3D ~(IGNBRK | BRKINT | PARMRK | ISTRIP
+                         | INLCR | IGNCR | ICRNL | IXON);
+        tty.c_oflag |=3D OPOST;
+        tty.c_lflag &=3D ~(ECHO | ECHONL | ICANON | IEXTEN);
+        tty.c_cflag &=3D ~(CSIZE | PARENB);
+        tty.c_cflag |=3D CS8;
+        tty.c_cc[VMIN] =3D 1;
+        tty.c_cc[VTIME] =3D 0;
+    }
+    if (!stdio_allow_signal) {
+        tty.c_lflag &=3D ~ISIG;
+    }
+
+    tcsetattr(0, TCSANOW, &tty);
+}
+
+static void term_stdio_handler(int sig)
+{
+    /* restore echo after resume from suspend. */
+    qemu_chr_set_echo_stdio(NULL, stdio_echo_state);
+}
+
+static void qemu_chr_open_stdio(Chardev *chr,
+                                ChardevBackend *backend,
+                                bool *be_opened,
+                                Error **errp)
+{
+    ChardevStdio *opts =3D backend->u.stdio.data;
+    struct sigaction act;
+
+    if (is_daemonized()) {
+        error_setg(errp, "cannot use stdio with -daemonize");
+        return;
+    }
+
+    if (stdio_in_use) {
+        error_setg(errp, "cannot use stdio by multiple character devices=
");
+        return;
+    }
+
+    stdio_in_use =3D true;
+    old_fd0_flags =3D fcntl(0, F_GETFL);
+    tcgetattr(0, &oldtty);
+    qemu_set_nonblock(0);
+    atexit(term_exit);
+
+    memset(&act, 0, sizeof(act));
+    act.sa_handler =3D term_stdio_handler;
+    sigaction(SIGCONT, &act, NULL);
+
+    qemu_chr_open_fd(chr, 0, 1);
+
+    if (opts->has_signal) {
+        stdio_allow_signal =3D opts->signal;
+    }
+    qemu_chr_set_echo_stdio(chr, false);
+}
+#endif
+
+static void qemu_chr_parse_stdio(QemuOpts *opts, ChardevBackend *backend=
,
+                                 Error **errp)
+{
+    ChardevStdio *stdio;
+
+    backend->type =3D CHARDEV_BACKEND_KIND_STDIO;
+    stdio =3D backend->u.stdio.data =3D g_new0(ChardevStdio, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevStdio_base(stdio));
+    stdio->has_signal =3D true;
+    stdio->signal =3D qemu_opt_get_bool(opts, "signal", true);
+}
+
+static void char_stdio_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_stdio;
+#ifndef _WIN32
+    cc->open =3D qemu_chr_open_stdio;
+    cc->chr_set_echo =3D qemu_chr_set_echo_stdio;
+#endif
+}
+
+static void char_stdio_finalize(Object *obj)
+{
+#ifndef _WIN32
+    term_exit();
+#endif
+}
+
+static const TypeInfo char_stdio_type_info =3D {
+    .name =3D TYPE_CHARDEV_STDIO,
+#ifdef _WIN32
+    .parent =3D TYPE_CHARDEV_WIN_STDIO,
+#else
+    .parent =3D TYPE_CHARDEV_FD,
+#endif
+    .instance_finalize =3D char_stdio_finalize,
+    .class_init =3D char_stdio_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_stdio_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index 7ec867ffc8..e93dfb8d86 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -90,7 +90,6 @@
 #include "char-io.h"
 #ifdef _WIN32
 #include "char-win.h"
-#include "char-win-stdio.h"
 #endif
=20
 /***********************************************************/
@@ -687,90 +686,6 @@ static void qemu_chr_open_pipe(Chardev *chr,
     qemu_chr_open_fd(chr, fd_in, fd_out);
 }
=20
-/* init terminal so that we can grab keys */
-static struct termios oldtty;
-static int old_fd0_flags;
-static bool stdio_in_use;
-static bool stdio_allow_signal;
-static bool stdio_echo_state;
-
-static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo);
-
-static void term_exit(void)
-{
-    tcsetattr (0, TCSANOW, &oldtty);
-    fcntl(0, F_SETFL, old_fd0_flags);
-}
-
-static void term_stdio_handler(int sig)
-{
-    /* restore echo after resume from suspend. */
-    qemu_chr_set_echo_stdio(NULL, stdio_echo_state);
-}
-
-static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
-{
-    struct termios tty;
-
-    stdio_echo_state =3D echo;
-    tty =3D oldtty;
-    if (!echo) {
-        tty.c_iflag &=3D ~(IGNBRK|BRKINT|PARMRK|ISTRIP
-                          |INLCR|IGNCR|ICRNL|IXON);
-        tty.c_oflag |=3D OPOST;
-        tty.c_lflag &=3D ~(ECHO|ECHONL|ICANON|IEXTEN);
-        tty.c_cflag &=3D ~(CSIZE|PARENB);
-        tty.c_cflag |=3D CS8;
-        tty.c_cc[VMIN] =3D 1;
-        tty.c_cc[VTIME] =3D 0;
-    }
-    if (!stdio_allow_signal)
-        tty.c_lflag &=3D ~ISIG;
-
-    tcsetattr (0, TCSANOW, &tty);
-}
-
-static void char_stdio_finalize(Object *obj)
-{
-    term_exit();
-}
-
-static void qemu_chr_open_stdio(Chardev *chr,
-                                ChardevBackend *backend,
-                                bool *be_opened,
-                                Error **errp)
-{
-    ChardevStdio *opts =3D backend->u.stdio.data;
-    struct sigaction act;
-
-    if (is_daemonized()) {
-        error_setg(errp, "cannot use stdio with -daemonize");
-        return;
-    }
-
-    if (stdio_in_use) {
-        error_setg(errp, "cannot use stdio by multiple character devices=
");
-        return;
-    }
-
-    stdio_in_use =3D true;
-    old_fd0_flags =3D fcntl(0, F_GETFL);
-    tcgetattr(0, &oldtty);
-    qemu_set_nonblock(0);
-    atexit(term_exit);
-
-    memset(&act, 0, sizeof(act));
-    act.sa_handler =3D term_stdio_handler;
-    sigaction(SIGCONT, &act, NULL);
-
-    qemu_chr_open_fd(chr, 0, 1);
-
-    if (opts->has_signal) {
-        stdio_allow_signal =3D opts->signal;
-    }
-    qemu_chr_set_echo_stdio(chr, false);
-}
-
 #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
     || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFl=
y__) \
     || defined(__GLIBC__)
@@ -1687,40 +1602,6 @@ void qemu_chr_parse_common(QemuOpts *opts, Chardev=
Common *backend)
     backend->logappend =3D qemu_opt_get_bool(opts, "logappend", false);
 }
=20
-static void qemu_chr_parse_stdio(QemuOpts *opts, ChardevBackend *backend=
,
-                                 Error **errp)
-{
-    ChardevStdio *stdio;
-
-    backend->type =3D CHARDEV_BACKEND_KIND_STDIO;
-    stdio =3D backend->u.stdio.data =3D g_new0(ChardevStdio, 1);
-    qemu_chr_parse_common(opts, qapi_ChardevStdio_base(stdio));
-    stdio->has_signal =3D true;
-    stdio->signal =3D qemu_opt_get_bool(opts, "signal", true);
-}
-
-static void char_stdio_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->parse =3D qemu_chr_parse_stdio;
-#ifndef _WIN32
-    cc->open =3D qemu_chr_open_stdio;
-    cc->chr_set_echo =3D qemu_chr_set_echo_stdio;
-#endif
-}
-
-static const TypeInfo char_stdio_type_info =3D {
-    .name =3D TYPE_CHARDEV_STDIO,
-#ifdef _WIN32
-    .parent =3D TYPE_CHARDEV_WIN_STDIO,
-#else
-    .parent =3D TYPE_CHARDEV_FD,
-    .instance_finalize =3D char_stdio_finalize,
-#endif
-    .class_init =3D char_stdio_class_init,
-};
-
 #ifdef HAVE_CHARDEV_SERIAL
 static void qemu_chr_parse_serial(QemuOpts *opts, ChardevBackend *backen=
d,
                                   Error **errp)
@@ -2453,7 +2334,6 @@ void qemu_chr_cleanup(void)
 static void register_types(void)
 {
     type_register_static(&char_type_info);
-    type_register_static(&char_stdio_type_info);
 #ifdef HAVE_CHARDEV_SERIAL
     type_register_static(&char_serial_type_info);
 #endif
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 0051a7a819..ee40e8a1d7 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -6,6 +6,7 @@ chardev-obj-y +=3D char-mux.o
 chardev-obj-y +=3D char-null.o
 chardev-obj-y +=3D char-ringbuf.o
 chardev-obj-y +=3D char-socket.o
+chardev-obj-y +=3D char-stdio.o
 chardev-obj-y +=3D char-udp.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
--=20
2.11.0.295.gd7dffce1c.dirty
