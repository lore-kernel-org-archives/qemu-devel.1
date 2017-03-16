Received: from eggs.gnu.org ([2001:4830:134:3::10]:47286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbz-0004f3-DT
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRby-0000XQ-BJ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1coRby-0000Wx-5u
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BAC881253
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:22:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Mar 2017 13:21:13 +0400
Message-Id: <20170316092121.25672-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170316092121.25672-1-marcandre.lureau@redhat.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 13/21] char-socket: add 'addr' property
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
index 4325a05387..81021c5863 100644
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
2.12.0.191.gc5d8de91d
