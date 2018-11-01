Received: from eggs.gnu.org ([2001:4830:134:3::10]:35292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gI8Ie-0007ZU-Hv
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gI8IY-0006Fw-Mq
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:25:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gI8IY-0006FC-BY
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:25:50 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Nov 2018 12:24:20 +0400
Message-Id: <20181101082423.26424-5-marcandre.lureau@redhat.com>
In-Reply-To: <20181101082423.26424-1-marcandre.lureau@redhat.com>
References: <20181101082423.26424-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 4/7] chardev/char-socket: Function headers
 refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Julia Suvorova <jusual@mail.ru>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Julia Suvorova <jusual@mail.ru>

Upcoming websocket support requires additional parameters in function
headers that are already overloaded. This patch replaces the bunch of
parameters with a single structure pointer.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Message-Id: <20181018223501.21683-2-jusual@mail.ru>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 chardev/char-socket.c | 55 +++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e4137ccd3c..0bbeb83ceb 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -389,30 +389,37 @@ static void tcp_chr_free_connection(Chardev *chr)
     s->connected =3D 0;
 }
=20
-static char *SocketAddress_to_str(const char *prefix, SocketAddress *add=
r,
-                                  bool is_listen, bool is_telnet)
+static const char *qemu_chr_socket_protocol(SocketChardev *s)
 {
-    switch (addr->type) {
+    if (s->is_telnet) {
+        return "telnet";
+    }
+    return "tcp";
+}
+
+static char *qemu_chr_socket_address(SocketChardev *s, const char *prefi=
x)
+{
+    switch (s->addr->type) {
     case SOCKET_ADDRESS_TYPE_INET:
         return g_strdup_printf("%s%s:%s:%s%s", prefix,
-                               is_telnet ? "telnet" : "tcp",
-                               addr->u.inet.host,
-                               addr->u.inet.port,
-                               is_listen ? ",server" : "");
+                               qemu_chr_socket_protocol(s),
+                               s->addr->u.inet.host,
+                               s->addr->u.inet.port,
+                               s->is_listen ? ",server" : "");
         break;
     case SOCKET_ADDRESS_TYPE_UNIX:
         return g_strdup_printf("%sunix:%s%s", prefix,
-                               addr->u.q_unix.path,
-                               is_listen ? ",server" : "");
+                               s->addr->u.q_unix.path,
+                               s->is_listen ? ",server" : "");
         break;
     case SOCKET_ADDRESS_TYPE_FD:
-        return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.str,
-                               is_listen ? ",server" : "");
+        return g_strdup_printf("%sfd:%s%s", prefix, s->addr->u.fd.str,
+                               s->is_listen ? ",server" : "");
         break;
     case SOCKET_ADDRESS_TYPE_VSOCK:
         return g_strdup_printf("%svsock:%s:%s", prefix,
-                               addr->u.vsock.cid,
-                               addr->u.vsock.port);
+                               s->addr->u.vsock.cid,
+                               s->addr->u.vsock.port);
     default:
         abort();
     }
@@ -424,8 +431,7 @@ static void update_disconnected_filename(SocketCharde=
v *s)
=20
     g_free(chr->filename);
     if (s->addr) {
-        chr->filename =3D SocketAddress_to_str("disconnected:", s->addr,
-                                             s->is_listen, s->is_telnet)=
;
+        chr->filename =3D qemu_chr_socket_address(s, "disconnected:");
     } else {
         chr->filename =3D g_strdup("disconnected:socket");
     }
@@ -514,10 +520,12 @@ static int tcp_chr_sync_read(Chardev *chr, const ui=
nt8_t *buf, int len)
     return size;
 }
=20
-static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_l=
en,
-                             struct sockaddr_storage *ps, socklen_t ps_l=
en,
-                             bool is_listen, bool is_telnet)
+static char *qemu_chr_compute_filename(SocketChardev *s)
 {
+    struct sockaddr_storage *ss =3D &s->sioc->localAddr;
+    struct sockaddr_storage *ps =3D &s->sioc->remoteAddr;
+    socklen_t ss_len =3D s->sioc->localAddrLen;
+    socklen_t ps_len =3D s->sioc->remoteAddrLen;
     char shost[NI_MAXHOST], sserv[NI_MAXSERV];
     char phost[NI_MAXHOST], pserv[NI_MAXSERV];
     const char *left =3D "", *right =3D "";
@@ -527,7 +535,7 @@ static char *sockaddr_to_str(struct sockaddr_storage =
*ss, socklen_t ss_len,
     case AF_UNIX:
         return g_strdup_printf("unix:%s%s",
                                ((struct sockaddr_un *)(ss))->sun_path,
-                               is_listen ? ",server" : "");
+                               s->is_listen ? ",server" : "");
 #endif
     case AF_INET6:
         left  =3D "[";
@@ -539,9 +547,9 @@ static char *sockaddr_to_str(struct sockaddr_storage =
*ss, socklen_t ss_len,
         getnameinfo((struct sockaddr *) ps, ps_len, phost, sizeof(phost)=
,
                     pserv, sizeof(pserv), NI_NUMERICHOST | NI_NUMERICSER=
V);
         return g_strdup_printf("%s:%s%s%s:%s%s <-> %s%s%s:%s",
-                               is_telnet ? "telnet" : "tcp",
+                               qemu_chr_socket_protocol(s),
                                left, shost, right, sserv,
-                               is_listen ? ",server" : "",
+                               s->is_listen ? ",server" : "",
                                left, phost, right, pserv);
=20
     default:
@@ -576,10 +584,7 @@ static void tcp_chr_connect(void *opaque)
     SocketChardev *s =3D SOCKET_CHARDEV(opaque);
=20
     g_free(chr->filename);
-    chr->filename =3D sockaddr_to_str(
-        &s->sioc->localAddr, s->sioc->localAddrLen,
-        &s->sioc->remoteAddr, s->sioc->remoteAddrLen,
-        s->is_listen, s->is_telnet);
+    chr->filename =3D qemu_chr_compute_filename(s);
=20
     s->connected =3D 1;
     update_ioc_handlers(s);
--=20
2.19.1.708.g4ede3d42df
