Received: from eggs.gnu.org ([2001:4830:134:3::10]:40602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMj5-0000rc-3W
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMj4-0006Mh-79
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRMj4-0006MD-1Z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:18 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 390127EAB9
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:30:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 18:29:30 +0100
Message-Id: <20170111172956.11255-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-1-marcandre.lureau@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/40] char-fd: convert to finalize
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

char-serial inherits from char-fd finalizer.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-char.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 4cbcc29bd5..b106f6ef33 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -1296,9 +1296,10 @@ static void fd_chr_update_read_handler(Chardev *ch=
r,
     }
 }
=20
-static void fd_chr_free(struct Chardev *chr)
+static void char_fd_finalize(Object *obj)
 {
-    FDChardev *s =3D FD_CHARDEV(chr);
+    Chardev *chr =3D CHARDEV(obj);
+    FDChardev *s =3D FD_CHARDEV(obj);
=20
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1337,13 +1338,13 @@ static void char_fd_class_init(ObjectClass *oc, v=
oid *data)
     cc->chr_add_watch =3D fd_chr_add_watch;
     cc->chr_write =3D fd_chr_write;
     cc->chr_update_read_handler =3D fd_chr_update_read_handler;
-    cc->chr_free =3D fd_chr_free;
 }
=20
 static const TypeInfo char_fd_type_info =3D {
     .name =3D TYPE_CHARDEV_FD,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(FDChardev),
+    .instance_finalize =3D char_fd_finalize,
     .class_init =3D char_fd_class_init,
     .abstract =3D true,
 };
@@ -1425,7 +1426,6 @@ static void qemu_chr_set_echo_stdio(Chardev *chr, b=
ool echo)
 static void char_stdio_finalize(Object *obj)
 {
     term_exit();
-    fd_chr_free(CHARDEV(chr));
 }
=20
 static void qemu_chr_open_stdio(Chardev *chr,
@@ -1913,11 +1913,6 @@ static int tty_serial_ioctl(Chardev *chr, int cmd,=
 void *arg)
     }
     return 0;
 }
-
-static void qemu_chr_free_tty(Chardev *chr)
-{
-    fd_chr_free(chr);
-}
 #endif /* __linux__ || __sun__ */
=20
 #if defined(__linux__)
@@ -4758,7 +4753,6 @@ static void char_serial_class_init(ObjectClass *oc,=
 void *data)
     cc->open =3D qmp_chardev_open_serial;
 #ifndef _WIN32
     cc->chr_ioctl =3D tty_serial_ioctl;
-    cc->chr_free =3D qemu_chr_free_tty;
 #endif
 }
=20
--=20
2.11.0
