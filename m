Received: from eggs.gnu.org ([2001:4830:134:3::10]:38411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gDGtG-0007Y2-Ip
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 18:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gDGtC-0003BH-Qk
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 18:35:38 -0400
Received: from smtp50.i.mail.ru ([94.100.177.110]:33096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gDGtA-0002uQ-JQ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 18:35:34 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Fri, 19 Oct 2018 01:34:59 +0300
Message-Id: <20181018223501.21683-2-jusual@mail.ru>
In-Reply-To: <20181018223501.21683-1-jusual@mail.ru>
References: <20181018223501.21683-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v3 1/3] chardev/char-socket: Function headers
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Upcoming websocket support requires additional parameters in function
headers that are already overloaded. This patch replaces the bunch of
parameters with a single structure pointer.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 chardev/char-socket.c | 55 +++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a75b46d9fe..effde65a89 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -389,30 +389,37 @@ static void tcp_chr_free_connection(Chardev *chr)
     s->connected = 0;
 }
 
-static char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
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
+static char *qemu_chr_socket_address(SocketChardev *s, const char *prefix)
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
@@ -424,8 +431,7 @@ static void update_disconnected_filename(SocketChardev *s)
 
     g_free(chr->filename);
     if (s->addr) {
-        chr->filename = SocketAddress_to_str("disconnected:", s->addr,
-                                             s->is_listen, s->is_telnet);
+        chr->filename = qemu_chr_socket_address(s, "disconnected:");
     } else {
         chr->filename = g_strdup("disconnected:socket");
     }
@@ -514,10 +520,12 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
     return size;
 }
 
-static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_len,
-                             struct sockaddr_storage *ps, socklen_t ps_len,
-                             bool is_listen, bool is_telnet)
+static char *qemu_chr_compute_filename(SocketChardev *s)
 {
+    struct sockaddr_storage *ss = &s->sioc->localAddr;
+    struct sockaddr_storage *ps = &s->sioc->remoteAddr;
+    socklen_t ss_len = s->sioc->localAddrLen;
+    socklen_t ps_len = s->sioc->remoteAddrLen;
     char shost[NI_MAXHOST], sserv[NI_MAXSERV];
     char phost[NI_MAXHOST], pserv[NI_MAXSERV];
     const char *left = "", *right = "";
@@ -527,7 +535,7 @@ static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_len,
     case AF_UNIX:
         return g_strdup_printf("unix:%s%s",
                                ((struct sockaddr_un *)(ss))->sun_path,
-                               is_listen ? ",server" : "");
+                               s->is_listen ? ",server" : "");
 #endif
     case AF_INET6:
         left  = "[";
@@ -539,9 +547,9 @@ static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_len,
         getnameinfo((struct sockaddr *) ps, ps_len, phost, sizeof(phost),
                     pserv, sizeof(pserv), NI_NUMERICHOST | NI_NUMERICSERV);
         return g_strdup_printf("%s:%s%s%s:%s%s <-> %s%s%s:%s",
-                               is_telnet ? "telnet" : "tcp",
+                               qemu_chr_socket_protocol(s),
                                left, shost, right, sserv,
-                               is_listen ? ",server" : "",
+                               s->is_listen ? ",server" : "",
                                left, phost, right, pserv);
 
     default:
@@ -576,10 +584,7 @@ static void tcp_chr_connect(void *opaque)
     SocketChardev *s = SOCKET_CHARDEV(opaque);
 
     g_free(chr->filename);
-    chr->filename = sockaddr_to_str(
-        &s->sioc->localAddr, s->sioc->localAddrLen,
-        &s->sioc->remoteAddr, s->sioc->remoteAddrLen,
-        s->is_listen, s->is_telnet);
+    chr->filename = qemu_chr_compute_filename(s);
 
     s->connected = 1;
     update_ioc_handlers(s);
-- 
2.17.1
