Received: from eggs.gnu.org ([2001:4830:134:3::10]:45532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbBy-0008HC-1V
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbBx-0000pe-8L
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbBx-0000pX-2C
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:01 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:20:49 +0400
Message-Id: <20170131162122.29408-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/41] char-pty: convert to finalize
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
 qemu-char.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index a00bbb0a1c..fecebde87a 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -1659,9 +1659,10 @@ static void pty_chr_state(Chardev *chr, int connec=
ted)
     }
 }
=20
-static void pty_chr_free(struct Chardev *chr)
+static void char_pty_finalize(Object *obj)
 {
-    PtyChardev *s =3D PTY_CHARDEV(chr);
+    Chardev *chr =3D CHARDEV(obj);
+    PtyChardev *s =3D PTY_CHARDEV(obj);
=20
     qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_state(chr, 0);
@@ -1718,13 +1719,13 @@ static void char_pty_class_init(ObjectClass *oc, =
void *data)
     cc->chr_write =3D char_pty_chr_write;
     cc->chr_update_read_handler =3D pty_chr_update_read_handler;
     cc->chr_add_watch =3D pty_chr_add_watch;
-    cc->chr_free =3D pty_chr_free;
 }
=20
 static const TypeInfo char_pty_type_info =3D {
     .name =3D TYPE_CHARDEV_PTY,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(PtyChardev),
+    .instance_finalize =3D char_pty_finalize,
     .class_init =3D char_pty_class_init,
 };
=20
--=20
2.11.0.295.gd7dffce1c.dirty
