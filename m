Received: from eggs.gnu.org ([2001:4830:134:3::10]:36860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3HVQ-0003Es-8l
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3HVO-0005fw-SB
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:36:56 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 26 Apr 2017 09:36:37 +0200
Message-Id: <1493192202-3184-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1493192202-3184-1-git-send-email-armbru@redhat.com>
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] sockets: Prepare inet_parse() for
 flattened SocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, eblake@redhat.com, qemu-block@nongnu.org

I'm going to flatten SocketAddress: rename SocketAddress to
SocketAddressLegacy, SocketAddressFlat to SocketAddress, eliminate
SocketAddressLegacy except in external interfaces.

inet_parse() returns a newly allocated InetSocketAddress.  Lift the
allocation from inet_parse() into its caller socket_parse() to prepare
for flattening SocketAddress.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/nbd.c            |  8 ++++----
 include/qemu/sockets.h |  2 +-
 migration/rdma.c       |  4 ++--
 migration/socket.c     |  5 +++--
 util/qemu-sockets.c    | 30 ++++++++++++------------------
 5 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 814ab26d..9f4ff44 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -199,16 +199,16 @@ static void nbd_parse_filename(const char *filename, QDict *options,
         qdict_put(options, "server.type", qstring_from_str("unix"));
         qdict_put(options, "server.path", qstring_from_str(unixpath));
     } else {
-        InetSocketAddress *addr = NULL;
+        InetSocketAddress *addr = g_new(InetSocketAddress, 1);
 
-        addr = inet_parse(host_spec, errp);
-        if (!addr) {
-            goto out;
+        if (inet_parse(addr, host_spec, errp)) {
+            goto out_inet;
         }
 
         qdict_put(options, "server.type", qstring_from_str("inet"));
         qdict_put(options, "server.host", qstring_from_str(addr->host));
         qdict_put(options, "server.port", qstring_from_str(addr->port));
+    out_inet:
         qapi_free_InetSocketAddress(addr);
     }
 
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index af28532..8b9325c 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -34,7 +34,7 @@ typedef void NonBlockingConnectHandler(int fd, Error *err, void *opaque);
 
 int inet_ai_family_from_address(InetSocketAddress *addr,
                                 Error **errp);
-InetSocketAddress *inet_parse(const char *str, Error **errp);
+int inet_parse(InetSocketAddress *addr, const char *str, Error **errp);
 int inet_connect(const char *str, Error **errp);
 int inet_connect_saddr(InetSocketAddress *saddr,
                        NonBlockingConnectHandler *callback, void *opaque,
diff --git a/migration/rdma.c b/migration/rdma.c
index fe0a4b5..7eaaf96 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2506,8 +2506,8 @@ static void *qemu_rdma_data_init(const char *host_port, Error **errp)
         rdma->current_index = -1;
         rdma->current_chunk = -1;
 
-        addr = inet_parse(host_port, NULL);
-        if (addr != NULL) {
+        addr = g_new(InetSocketAddress, 1);
+        if (!inet_parse(addr, host_port, NULL)) {
             rdma->port = atoi(addr->port);
             rdma->host = g_strdup(addr->host);
         } else {
diff --git a/migration/socket.c b/migration/socket.c
index 13966f1..8db6d0d 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -27,10 +27,11 @@
 
 static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
 {
-    InetSocketAddress *iaddr = inet_parse(host_port, errp);
+    InetSocketAddress *iaddr = g_new(InetSocketAddress, 1);
     SocketAddress *saddr;
 
-    if (!iaddr) {
+    if (inet_parse(iaddr, host_port, errp)) {
+        qapi_free_InetSocketAddress(iaddr);
         return NULL;
     }
 
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 1abe095..62c93ba 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -578,16 +578,15 @@ err:
 }
 
 /* compatibility wrapper */
-InetSocketAddress *inet_parse(const char *str, Error **errp)
+int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
 {
-    InetSocketAddress *addr;
     const char *optstr, *h;
     char host[65];
     char port[33];
     int to;
     int pos;
 
-    addr = g_new0(InetSocketAddress, 1);
+    memset(addr, 0, sizeof(*addr));
 
     /* parse address */
     if (str[0] == ':') {
@@ -595,20 +594,20 @@ InetSocketAddress *inet_parse(const char *str, Error **errp)
         host[0] = '\0';
         if (sscanf(str, ":%32[^,]%n", port, &pos) != 1) {
             error_setg(errp, "error parsing port in address '%s'", str);
-            goto fail;
+            return -1;
         }
     } else if (str[0] == '[') {
         /* IPv6 addr */
         if (sscanf(str, "[%64[^]]]:%32[^,]%n", host, port, &pos) != 2) {
             error_setg(errp, "error parsing IPv6 address '%s'", str);
-            goto fail;
+            return -1;
         }
         addr->ipv6 = addr->has_ipv6 = true;
     } else {
         /* hostname or IPv4 addr */
         if (sscanf(str, "%64[^:]:%32[^,]%n", host, port, &pos) != 2) {
             error_setg(errp, "error parsing address '%s'", str);
-            goto fail;
+            return -1;
         }
         if (host[strspn(host, "0123456789.")] == '\0') {
             addr->ipv4 = addr->has_ipv4 = true;
@@ -626,7 +625,7 @@ InetSocketAddress *inet_parse(const char *str, Error **errp)
         if (sscanf(h, "%d%n", &to, &pos) != 1 ||
             (h[pos] != '\0' && h[pos] != ',')) {
             error_setg(errp, "error parsing to= argument");
-            goto fail;
+            return -1;
         }
         addr->has_to = true;
         addr->to = to;
@@ -637,11 +636,7 @@ InetSocketAddress *inet_parse(const char *str, Error **errp)
     if (strstr(optstr, ",ipv6")) {
         addr->ipv6 = addr->has_ipv6 = true;
     }
-    return addr;
-
-fail:
-    qapi_free_InetSocketAddress(addr);
-    return NULL;
+    return 0;
 }
 
 
@@ -656,13 +651,12 @@ fail:
 int inet_connect(const char *str, Error **errp)
 {
     int sock = -1;
-    InetSocketAddress *addr;
+    InetSocketAddress *addr = g_new(InetSocketAddress, 1);
 
-    addr = inet_parse(str, errp);
-    if (addr != NULL) {
+    if (!inet_parse(addr, str, errp)) {
         sock = inet_connect_saddr(addr, NULL, NULL, errp);
-        qapi_free_InetSocketAddress(addr);
     }
+    qapi_free_InetSocketAddress(addr);
     return sock;
 }
 
@@ -1066,8 +1060,8 @@ SocketAddress *socket_parse(const char *str, Error **errp)
         }
     } else {
         addr->type = SOCKET_ADDRESS_KIND_INET;
-        addr->u.inet.data = inet_parse(str, errp);
-        if (addr->u.inet.data == NULL) {
+        addr->u.inet.data = g_new(InetSocketAddress, 1);
+        if (inet_parse(addr->u.inet.data, str, errp)) {
             goto fail;
         }
     }
-- 
2.7.4
