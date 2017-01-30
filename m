Received: from eggs.gnu.org ([2001:4830:134:3::10]:37974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCC7-0003yg-5M
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCC6-0006aY-5c
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCC6-0006a9-03
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:40:30 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29E238046C
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:40:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:20 +0400
Message-Id: <20170130133954.31353-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/41] char-socket: convert to finalize
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

Notice that finalize() will be run after a failure to open(), so cleanup
code must be adjusted.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-char.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 1c4fcf3a6e..a00bbb0a1c 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -3446,9 +3446,10 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Er=
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
@@ -4886,7 +4887,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
             s->listen_ioc =3D sioc;
             if (is_waitconnect &&
                 qemu_chr_wait_connected(chr, errp) < 0) {
-                goto error;
+                return;
             }
             if (!s->ioc) {
                 s->listen_tag =3D qio_channel_add_watch(
@@ -4904,9 +4905,6 @@ error:
     if (sioc) {
         object_unref(OBJECT(sioc));
     }
-    if (s->tls_creds) {
-        object_unref(OBJECT(s->tls_creds));
-    }
 }
=20
 static const CharDriver socket_driver =3D {
@@ -4928,13 +4926,13 @@ static void char_socket_class_init(ObjectClass *o=
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
2.11.0.295.gd7dffce1c.dirty
