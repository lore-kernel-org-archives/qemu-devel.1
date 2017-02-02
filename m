Received: from eggs.gnu.org ([2001:4830:134:3::10]:39739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIkf-00056l-3N
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIkb-0004Ln-5U
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIka-0004L1-VR
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:41 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1069EC04D2F2
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:52:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:31 +0400
Message-Id: <20170202145141.17138-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170202145141.17138-1-marcandre.lureau@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/22] char-socket: introduce
 update_disconnected_filename()
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

This helper will be used in yet another place in the following patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 00b7de3cc4..1f2377bb4e 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -353,6 +353,15 @@ static char *SocketAddress_to_str(const char *prefix=
, SocketAddress *addr,
     }
 }
=20
+static void update_disconnected_filename(SocketChardev *s)
+{
+    Chardev *chr =3D CHARDEV(s);
+
+    g_free(chr->filename);
+    chr->filename =3D SocketAddress_to_str("disconnected:", s->addr,
+                                         s->is_listen, s->is_telnet);
+}
+
 static void tcp_chr_disconnect(Chardev *chr)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
@@ -367,8 +376,7 @@ static void tcp_chr_disconnect(Chardev *chr)
         s->listen_tag =3D qio_channel_add_watch(
             QIO_CHANNEL(s->listen_ioc), G_IO_IN, tcp_chr_accept, chr, NU=
LL);
     }
-    chr->filename =3D SocketAddress_to_str("disconnected:", s->addr,
-                                         s->is_listen, s->is_telnet);
+    update_disconnected_filename(s);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
     if (s->reconnect_time) {
         qemu_chr_socket_restart_timer(chr);
@@ -862,8 +870,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     /* be isn't opened until we get a connection */
     *be_opened =3D false;
=20
-    chr->filename =3D SocketAddress_to_str("disconnected:",
-                                         addr, is_listen, is_telnet);
+    update_disconnected_filename(s);
=20
     if (is_listen) {
         if (is_telnet) {
--=20
2.11.0.295.gd7dffce1c.dirty
