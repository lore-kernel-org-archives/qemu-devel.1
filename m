Received: from eggs.gnu.org ([2001:4830:134:3::10]:40755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjF-00012O-KB
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjE-0006S7-N1
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:9613)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRMjE-0006Rm-Ff
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A10F0369C3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:30:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 18:29:38 +0100
Message-Id: <20170111172956.11255-23-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-1-marcandre.lureau@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 22/40] char: move null chardev to its own file
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
 chardev/char-null.c   | 31 +++++++++++++++++++++++++++++++
 chardev/char.c        | 23 -----------------------
 chardev/Makefile.objs |  1 +
 3 files changed, 32 insertions(+), 23 deletions(-)
 create mode 100644 chardev/char-null.c

diff --git a/chardev/char-null.c b/chardev/char-null.c
new file mode 100644
index 0000000000..18a49f5802
--- /dev/null
+++ b/chardev/char-null.c
@@ -0,0 +1,31 @@
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
index 74e0d0b32a..a27199f89b 100644
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
@@ -5082,7 +5060,6 @@ static void register_types(void)
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
2.11.0
