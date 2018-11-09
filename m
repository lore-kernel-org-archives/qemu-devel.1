Received: from eggs.gnu.org ([2001:4830:134:3::10]:34519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLDAH-0004dg-7p
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 15:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLDAB-0006Jq-AI
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 15:13:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gLDA7-00061y-2n
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 15:13:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C95088E5F
	for <qemu-devel@nongnu.org>; Fri,  9 Nov 2018 20:13:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 10 Nov 2018 00:13:25 +0400
Message-Id: <20181109201325.26177-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] net: refactor net_socket_send()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Simplify net_socket_send(), avoid extra buf/buf1 variable, and
backwards goto.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 net/socket.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index c92354049b..8a9c30892d 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -159,17 +159,12 @@ static void net_socket_send(void *opaque)
 {
     NetSocketState *s =3D opaque;
     int size;
-    int ret;
-    uint8_t buf1[NET_BUFSIZE];
-    const uint8_t *buf;
-
-    size =3D qemu_recv(s->fd, buf1, sizeof(buf1), 0);
-    if (size < 0) {
-        if (errno !=3D EWOULDBLOCK)
-            goto eoc;
-    } else if (size =3D=3D 0) {
+    uint8_t buf[NET_BUFSIZE];
+
+    size =3D qemu_recv(s->fd, buf, sizeof(buf), 0);
+    if (size =3D=3D 0 || (size < 0 && errno !=3D EWOULDBLOCK) ||
+        net_fill_rstate(&s->rs, buf, size) =3D=3D -1) {
         /* end of connection */
-    eoc:
         net_socket_read_poll(s, false);
         net_socket_write_poll(s, false);
         if (s->listen_fd !=3D -1) {
@@ -181,15 +176,6 @@ static void net_socket_send(void *opaque)
         net_socket_rs_init(&s->rs, net_socket_rs_finalize, false);
         s->nc.link_down =3D true;
         memset(s->nc.info_str, 0, sizeof(s->nc.info_str));
-
-        return;
-    }
-    buf =3D buf1;
-
-    ret =3D net_fill_rstate(&s->rs, buf, size);
-
-    if (ret =3D=3D -1) {
-        goto eoc;
     }
 }
=20
--=20
2.19.1.708.g4ede3d42df
