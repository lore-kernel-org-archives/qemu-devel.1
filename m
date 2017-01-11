Received: from eggs.gnu.org ([2001:4830:134:3::10]:40475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMiu-0000es-KF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMir-0006Cr-Gr
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRMir-0006Ce-B7
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:05 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C48D2173D
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:30:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 18:29:21 +0100
Message-Id: <20170111172956.11255-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-1-marcandre.lureau@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/40] char-udp: convert to finalize
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
 qemu-char.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 8e301af3e5..7e2a412954 100644
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
@@ -4973,13 +4974,13 @@ static void char_udp_class_init(ObjectClass *oc, =
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
2.11.0
