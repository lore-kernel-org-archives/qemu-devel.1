Received: from eggs.gnu.org ([2001:4830:134:3::10]:45923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCv-0000or-8K
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCu-0001AC-Av
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbCu-0001A7-1t
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:00 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:21:04 +0400
Message-Id: <20170131162122.29408-24-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/41] char: move null chardev to its own file
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 chardev/char-null.c   | 54 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c        | 23 ----------------------
 chardev/Makefile.objs |  1 +
 3 files changed, 55 insertions(+), 23 deletions(-)
 create mode 100644 chardev/char-null.c

diff --git a/chardev/char-null.c b/chardev/char-null.c
new file mode 100644
index 0000000000..dc0d68ab2d
--- /dev/null
+++ b/chardev/char-null.c
@@ -0,0 +1,54 @@
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
+#include "sysemu/char.h"
+
+static void null_chr_open(Chardev *chr,
+                          ChardevBackend *backend,
+                          bool *be_opened,
+                          Error **errp)
+{
+    *be_opened =3D false;
+}
+
+static void char_null_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D null_chr_open;
+}
+
+static const TypeInfo char_null_type_info =3D {
+    .name =3D TYPE_CHARDEV_NULL,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(Chardev),
+    .class_init =3D char_null_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_null_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index ee6ceb3471..2ca6c7cf67 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -560,28 +560,6 @@ static const TypeInfo char_type_info =3D {
     .class_init =3D char_class_init,
 };
=20
-static void null_chr_open(Chardev *chr,
-                          ChardevBackend *backend,
-                          bool *be_opened,
-                          Error **errp)
-{
-    *be_opened =3D false;
-}
-
-static void char_null_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc =3D CHARDEV_CLASS(oc);
-
-    cc->open =3D null_chr_open;
-}
-
-static const TypeInfo char_null_type_info =3D {
-    .name =3D TYPE_CHARDEV_NULL,
-    .parent =3D TYPE_CHARDEV,
-    .instance_size =3D sizeof(Chardev),
-    .class_init =3D char_null_class_init,
-};
-
 /* MUX driver for serial I/O splitting */
 #define MAX_MUX 4
 #define MUX_BUFFER_SIZE 32	/* Must be a power of 2.  */
@@ -5105,7 +5083,6 @@ static void register_types(void)
     type_register_static(&char_win_type_info);
     type_register_static(&char_win_stdio_type_info);
 #endif
-    type_register_static(&char_null_type_info);
     type_register_static(&char_socket_type_info);
     type_register_static(&char_udp_type_info);
     type_register_static(&char_ringbuf_type_info);
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 8bf131b461..be7ff800c3 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1 +1,2 @@
 chardev-obj-y +=3D char.o
+chardev-obj-y +=3D char-null.o
--=20
2.11.0.295.gd7dffce1c.dirty
