Received: from eggs.gnu.org ([2001:4830:134:3::10]:46394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbDl-0001dZ-4U
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbDk-0001Nr-1r
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbDj-0001Nh-Oq
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:51 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:21:17 +0400
Message-Id: <20170131162122.29408-37-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 36/41] char: move console in its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Eric Blake <eblake@redhat.com>
---
 chardev/char-console.c | 53 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c         |  3 ---
 chardev/Makefile.objs  |  1 +
 3 files changed, 54 insertions(+), 3 deletions(-)
 create mode 100644 chardev/char-console.c

diff --git a/chardev/char-console.c b/chardev/char-console.c
new file mode 100644
index 0000000000..c824937fe6
--- /dev/null
+++ b/chardev/char-console.c
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
+#include "qemu/osdep.h"
+#include "char-win.h"
+
+static void qemu_chr_open_win_con(Chardev *chr,
+                                  ChardevBackend *backend,
+                                  bool *be_opened,
+                                  Error **errp)
+{
+    qemu_chr_open_win_file(chr, GetStdHandle(STD_OUTPUT_HANDLE));
+}
+
+static void char_console_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qemu_chr_open_win_con;
+}
+
+static const TypeInfo char_console_type_info =3D {
+    .name =3D TYPE_CHARDEV_CONSOLE,
+    .parent =3D TYPE_CHARDEV_WIN,
+    .class_init =3D char_console_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_console_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index e93dfb8d86..8ae8b5a4c3 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -2343,9 +2343,6 @@ static void register_types(void)
 #ifdef HAVE_CHARDEV_PTY
     type_register_static(&char_pty_type_info);
 #endif
-#ifdef _WIN32
-    type_register_static(&char_console_type_info);
-#endif
     type_register_static(&char_pipe_type_info);
=20
     /* this must be done after machine init, since we register FEs with =
muxes
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index ee40e8a1d7..265a6dad5d 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,4 +1,5 @@
 chardev-obj-y +=3D char.o
+chardev-obj-$(CONFIG_WIN32) +=3D char-console.o
 chardev-obj-$(CONFIG_POSIX) +=3D char-fd.o
 chardev-obj-y +=3D char-file.o
 chardev-obj-y +=3D char-io.o
--=20
2.11.0.295.gd7dffce1c.dirty
