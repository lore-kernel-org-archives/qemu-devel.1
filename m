Received: from eggs.gnu.org ([2001:4830:134:3::10]:47243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbv-0004Zp-5q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbp-0000Sl-KU
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1coRbp-0000SJ-E9
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81F628124A
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:22:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Mar 2017 13:21:11 +0400
Message-Id: <20170316092121.25672-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170316092121.25672-1-marcandre.lureau@redhat.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 11/21] char-socket: introduce
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
index dc3d3532a7..e3b5288af7 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -363,6 +363,15 @@ static char *SocketAddress_to_str(const char *prefix=
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
@@ -377,8 +386,7 @@ static void tcp_chr_disconnect(Chardev *chr)
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
@@ -872,8 +880,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
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
2.12.0.191.gc5d8de91d
