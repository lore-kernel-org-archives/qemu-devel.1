Received: from eggs.gnu.org ([2001:4830:134:3::10]:40992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjX-0001JB-DT
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjW-0006Zv-K5
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRMjW-0006Zd-EY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:46 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A074481240
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:30:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 18:29:51 +0100
Message-Id: <20170111172956.11255-36-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-1-marcandre.lureau@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 35/40] char: move console in its own file
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
 chardev/char-console.c | 30 ++++++++++++++++++++++++++++++
 chardev/char.c         |  3 ---
 chardev/Makefile.objs  |  1 +
 3 files changed, 31 insertions(+), 3 deletions(-)
 create mode 100644 chardev/char-console.c

diff --git a/chardev/char-console.c b/chardev/char-console.c
new file mode 100644
index 0000000000..6cc8336622
--- /dev/null
+++ b/chardev/char-console.c
@@ -0,0 +1,30 @@
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
index bd91826f8c..a11cec378d 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -2321,9 +2321,6 @@ static void register_types(void)
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
2.11.0
