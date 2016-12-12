Received: from eggs.gnu.org ([2001:4830:134:3::10]:43201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZL9-0004C4-Np
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZL6-0003oU-KE
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZL6-0003nr-EO
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:56 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CF108123A
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:44:55 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:52 +0300
Message-Id: <20161212224325.20790-22-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 21/54] char-socket: convert to finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-char.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 06281c60e7..ea8b12fa4f 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -3442,9 +3442,10 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Er=
ror **errp)
     return qemu_chr_wait_connected(be->chr, errp);
 }
=20
-static void tcp_chr_free(Chardev *chr)
+static void char_socket_finalize(Object *obj)
 {
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    Chardev *chr =3D CHARDEV(obj);
+    SocketChardev *s =3D SOCKET_CHARDEV(obj);
=20
     tcp_chr_free_connection(chr);
=20
@@ -4924,13 +4925,13 @@ static void char_socket_class_init(ObjectClass *o=
c, void *data)
     cc->chr_add_client =3D tcp_chr_add_client;
     cc->chr_add_watch =3D tcp_chr_add_watch;
     cc->chr_update_read_handler =3D tcp_chr_update_read_handler;
-    cc->chr_free =3D tcp_chr_free;
 }
=20
 static const TypeInfo char_socket_type_info =3D {
     .name =3D TYPE_CHARDEV_SOCKET,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(SocketChardev),
+    .instance_finalize =3D char_socket_finalize,
     .class_init =3D char_socket_class_init,
 };
=20
--=20
2.11.0
