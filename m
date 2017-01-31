Received: from eggs.gnu.org ([2001:4830:134:3::10]:45500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbBs-0008AF-M6
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbBo-0000oB-Ng
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbBo-0000nz-HL
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:21:52 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:20:47 +0400
Message-Id: <20170131162122.29408-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/41] char-udp: convert to finalize
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
index 91ca4cb083..1c4fcf3a6e 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -2779,9 +2779,10 @@ static void udp_chr_update_read_handler(Chardev *c=
hr,
     }
 }
=20
-static void udp_chr_free(Chardev *chr)
+static void char_udp_finalize(Object *obj)
 {
-    UdpChardev *s =3D UDP_CHARDEV(chr);
+    Chardev *chr =3D CHARDEV(obj);
+    UdpChardev *s =3D UDP_CHARDEV(obj);
=20
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -4975,13 +4976,13 @@ static void char_udp_class_init(ObjectClass *oc, =
void *data)
     cc->open =3D qmp_chardev_open_udp;
     cc->chr_write =3D udp_chr_write;
     cc->chr_update_read_handler =3D udp_chr_update_read_handler;
-    cc->chr_free =3D udp_chr_free;
 }
=20
 static const TypeInfo char_udp_type_info =3D {
     .name =3D TYPE_CHARDEV_UDP,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(UdpChardev),
+    .instance_finalize =3D char_udp_finalize,
     .class_init =3D char_udp_class_init,
 };
=20
--=20
2.11.0.295.gd7dffce1c.dirty
