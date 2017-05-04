Received: from eggs.gnu.org ([2001:4830:134:3::10]:46261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FB3-0003wH-Oa
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FB2-0004gk-Tu
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6FB2-0004gP-Mu
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:08 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 15:42:24 +0400
Message-Id: <20170504114232.20318-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170504114232.20318-1-marcandre.lureau@redhat.com>
References: <20170504114232.20318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/21] char-socket: add 'addr' property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Add a property to lookup the connection details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 chardev/char-socket.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index f24961ad16..5a5840edb1 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1009,6 +1009,15 @@ static void qemu_chr_parse_socket(QemuOpts *opts, =
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
@@ -1024,6 +1033,10 @@ static void char_socket_class_init(ObjectClass *oc=
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
