Received: from eggs.gnu.org ([2001:4830:134:3::10]:56436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic4-00027A-03
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic0-0008Kg-GJ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Ic0-0008Iq-26
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A7D3C04B95A
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AF4CC18380
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:23:51 +0200
Message-Id: <1493911445-19568-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 14/28] sockets: Prepare inet_parse() for
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

I'm going to flatten SocketAddress: rename SocketAddress to
SocketAddressLegacy, SocketAddressFlat to SocketAddress, eliminate
SocketAddressLegacy except in external interfaces.

inet_parse() returns a newly allocated InetSocketAddress.  Lift the
allocation from inet_parse() into its caller socket_parse() to prepare
for flattening SocketAddress.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1493192202-3184-3-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[Straightforward rebase]
---
 block/nbd.c            |  8 ++++----
 include/qemu/sockets.h |  2 +-
 migration/rdma.c       |  4 ++--
 migration/socket.c     |  5 +++--
 util/qemu-sockets.c    | 30 ++++++++++++------------------
 5 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index b3545f5..37969eb 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -198,16 +198,16 @@ static void nbd_parse_filename(const char *filename, QDict *options,
         qdict_put_str(options, "server.type", "unix");
         qdict_put_str(options, "server.path", unixpath);
     } else {
-        InetSocketAddress *addr = NULL;
+        InetSocketAddress *addr = g_new(InetSocketAddress, 1);
 
-        addr = inet_parse(host_spec, errp);
-        if (!addr) {
-            goto out;
+        if (inet_parse(addr, host_spec, errp)) {
+            goto out_inet;
         }
 
         qdict_put_str(options, "server.type", "inet");
         qdict_put_str(options, "server.host", addr->host);
         qdict_put_str(options, "server.port", addr->port);
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
