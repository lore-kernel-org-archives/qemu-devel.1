Received: from eggs.gnu.org ([2001:4830:134:3::10]:53576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciLa4-00029s-DJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciLa3-0001jM-JV
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:43:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ciLa3-0001j6-Cw
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:43:11 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8230D3A7697
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 13:43:11 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Feb 2017 17:41:54 +0400
Message-Id: <20170227134202.2991-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170227134202.2991-1-marcandre.lureau@redhat.com>
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/21] char-socket: add 'addr' property
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

Add a property to lookup the connection details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index dbf2c54639..393b315225 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1006,6 +1006,15 @@ static void qemu_chr_parse_socket(QemuOpts *opts, =
ChardevBackend *backend,
     sock->addr =3D addr;
 }
=20
+static void
+char_socket_get_addr(Object *obj, Visitor *v, const char *name,
+                     void *opaque, Error **errp)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(obj);
+
+    visit_type_SocketAddress(v, name, &s->addr, errp);
+}
+
 static void char_socket_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
@@ -1021,6 +1030,10 @@ static void char_socket_class_init(ObjectClass *oc=
, void *data)
     cc->chr_add_client =3D tcp_chr_add_client;
     cc->chr_add_watch =3D tcp_chr_add_watch;
     cc->chr_update_read_handler =3D tcp_chr_update_read_handler;
+
+    object_class_property_add(oc, "addr", "SocketAddress",
+                              char_socket_get_addr, NULL,
+                              NULL, NULL, &error_abort);
 }
=20
 static const TypeInfo char_socket_type_info =3D {
--=20
2.12.0.rc2.3.gc93709801
