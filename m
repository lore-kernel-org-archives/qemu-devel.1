Received: from eggs.gnu.org ([209.51.188.92]:40654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1h3Osr-00081i-4r
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1h3Ooa-0005ed-0v
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:34:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1h3OoY-0005ag-0U
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:34:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AC29882F5
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 17:25:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Mar 2019 18:25:05 +0100
Message-Id: <20190311172505.1470-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] net/socket: learn to talk with a unix dgram
 socket
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

-net socket has a fd argument, and may be passed pre-opened sockets.

TCP sockets use framing.
UDP sockets have datagram boundaries.

When given a unix dgram socket, it will be able to read from it, but
will attempt to send on the dgram_dst, which is unset. The other end
will not receive the data.

Let's teach -net socket to recognize a UNIX DGRAM socket, and use the
regular send() command (without dgram_dst).

This makes running slirp out-of-process possible that
way (python pseudo-code):

a, b =3D socket.socketpair(socket.AF_UNIX, socket.SOCK_DGRAM)

subprocess.Popen('qemu -net socket,fd=3D%d -net user' % a.fileno(), shell=
=3DTrue)
subprocess.Popen('qemu ... -net nic -net socket,fd=3D%d' % b.fileno(), sh=
ell=3DTrue)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 net/socket.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 90ef3517be..c92354049b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -119,9 +119,13 @@ static ssize_t net_socket_receive_dgram(NetClientSta=
te *nc, const uint8_t *buf,
     ssize_t ret;
=20
     do {
-        ret =3D qemu_sendto(s->fd, buf, size, 0,
-                          (struct sockaddr *)&s->dgram_dst,
-                          sizeof(s->dgram_dst));
+        if (s->dgram_dst.sin_family !=3D AF_UNIX) {
+            ret =3D qemu_sendto(s->fd, buf, size, 0,
+                              (struct sockaddr *)&s->dgram_dst,
+                              sizeof(s->dgram_dst));
+        } else {
+            ret =3D send(s->fd, buf, size, 0);
+        }
     } while (ret =3D=3D -1 && errno =3D=3D EINTR);
=20
     if (ret =3D=3D -1 && errno =3D=3D EAGAIN) {
@@ -336,6 +340,15 @@ static NetSocketState *net_socket_fd_init_dgram(NetC=
lientState *peer,
     int newfd;
     NetClientState *nc;
     NetSocketState *s;
+    SocketAddress *sa;
+    SocketAddressType sa_type;
+
+    sa =3D socket_local_address(fd, errp);
+    if (!sa) {
+        return NULL;
+    }
+    sa_type =3D sa->type;
+    qapi_free_SocketAddress(sa);
=20
     /* fd passed: multicast: "learn" dgram_dst address from bound addres=
s and save it
      * Because this may be "shared" socket from a "master" process, data=
grams would be recv()
@@ -379,8 +392,12 @@ static NetSocketState *net_socket_fd_init_dgram(NetC=
lientState *peer,
                  "socket: fd=3D%d (cloned mcast=3D%s:%d)",
                  fd, inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
     } else {
+        if (sa_type =3D=3D SOCKET_ADDRESS_TYPE_UNIX) {
+            s->dgram_dst.sin_family =3D AF_UNIX;
+        }
+
         snprintf(nc->info_str, sizeof(nc->info_str),
-                 "socket: fd=3D%d", fd);
+                 "socket: fd=3D%d %s", fd, SocketAddressType_str(sa_type=
));
     }
=20
     return s;
--=20
2.21.0.4.g36eb1cb9cf
