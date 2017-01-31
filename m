Received: from eggs.gnu.org ([2001:4830:134:3::10]:45606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCC-0008TE-Oo
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbC8-0000ri-Px
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbC8-0000rb-K1
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:12 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:20:52 +0400
Message-Id: <20170131162122.29408-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/41] char-stdio: convert to finalize
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
 qemu-char.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 1981058f45..390e6a99de 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -1422,10 +1422,10 @@ static void qemu_chr_set_echo_stdio(Chardev *chr,=
 bool echo)
     tcsetattr (0, TCSANOW, &tty);
 }
=20
-static void qemu_chr_free_stdio(struct Chardev *chr)
+static void char_stdio_finalize(Object *obj)
 {
     term_exit();
-    fd_chr_free(chr);
+    fd_chr_free(CHARDEV(chr));
 }
=20
 static void qemu_chr_open_stdio(Chardev *chr,
@@ -3859,7 +3859,6 @@ static void char_stdio_class_init(ObjectClass *oc, =
void *data)
     cc->chr_free =3D win_stdio_free;
 #else
     cc->chr_set_echo =3D qemu_chr_set_echo_stdio;
-    cc->chr_free =3D qemu_chr_free_stdio;
 #endif
 }
=20
@@ -3869,6 +3868,7 @@ static const TypeInfo char_stdio_type_info =3D {
     .parent =3D TYPE_CHARDEV_WIN_STDIO,
 #else
     .parent =3D TYPE_CHARDEV_FD,
+    .instance_finalize =3D char_stdio_finalize,
 #endif
     .class_init =3D char_stdio_class_init,
 };
--=20
2.11.0.295.gd7dffce1c.dirty
