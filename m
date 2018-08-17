Received: from eggs.gnu.org ([2001:4830:134:3::10]:47806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqfBE-0001N3-3U
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqfBA-00077w-VY
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:52:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fqfBA-00077a-I1
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:52:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39C217A7EE
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 13:52:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Aug 2018 15:52:22 +0200
Message-Id: <20180817135224.22971-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180817135224.22971-1-marcandre.lureau@redhat.com>
References: <20180817135224.22971-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] Revert "chardev: tcp: postpone async
 connection setup"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This reverts commit 25679e5d58e258e9950685ffbd0cae4cd40d9cc2.

This commit broke "reconnect socket" chardev that are created after
"machine_done": they no longer try to connect. It broke also
vhost-user-test that uses chardev while there is no "machine_done"
event.

The goal of this patch was to move the "connect" source to the
frontend context. chr->gcontext is set with
qemu_chr_fe_set_handlers(). But there is no guarantee that it will be
called, so we can't delay connection until then: the chardev should
still attempt to connect during open(). qemu_chr_fe_set_handlers() is
eventually called later and will update the context.

Unless there is a good reason to not use initially the default
context, I think we should revert to the previous state to fix the
regressions.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e28d2cca4c..14f6567f6a 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1005,8 +1005,9 @@ static void qmp_chardev_open_socket(Chardev *chr,
         s->reconnect_time =3D reconnect;
     }
=20
-    /* If reconnect_time is set, will do that in chr_machine_done. */
-    if (!s->reconnect_time) {
+    if (s->reconnect_time) {
+        tcp_chr_connect_async(chr);
+    } else {
         if (s->is_listen) {
             char *name;
             s->listener =3D qio_net_listener_new();
@@ -1155,17 +1156,6 @@ char_socket_get_connected(Object *obj, Error **err=
p)
     return s->connected;
 }
=20
-static int tcp_chr_machine_done_hook(Chardev *chr)
-{
-    SocketChardev *s =3D SOCKET_CHARDEV(chr);
-
-    if (s->reconnect_time) {
-        tcp_chr_connect_async(chr);
-    }
-
-    return 0;
-}
-
 static void char_socket_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
@@ -1181,7 +1171,6 @@ static void char_socket_class_init(ObjectClass *oc,=
 void *data)
     cc->chr_add_client =3D tcp_chr_add_client;
     cc->chr_add_watch =3D tcp_chr_add_watch;
     cc->chr_update_read_handler =3D tcp_chr_update_read_handler;
-    cc->chr_machine_done =3D tcp_chr_machine_done_hook;
=20
     object_class_property_add(oc, "addr", "SocketAddress",
                               char_socket_get_addr, NULL,
--=20
2.18.0.547.g1d89318c48
