Received: from eggs.gnu.org ([2001:4830:134:3::10]:50388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dInsf-0001QJ-Q8
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 23:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dInsc-0003eq-Lh
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 23:13:05 -0400
Received: from [59.151.112.132] (port=14277 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dInsc-0003YA-9B
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 23:13:02 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Thu, 8 Jun 2017 11:11:24 +0800
Message-ID: <20170608031124.8031-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] util/qemu-sockets: Drop unused helper
 socket_address_to_string()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, armbru@redhat.com

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 include/qemu/sockets.h | 15 ---------------
 util/qemu-sockets.c    | 34 ----------------------------------
 2 files changed, 49 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 7abffc4..8eb0172 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -106,21 +106,6 @@ SocketAddress *socket_local_address(int fd, Error **errp);
 SocketAddress *socket_remote_address(int fd, Error **errp);
 
 /**
- * socket_address_to_string:
- * @addr: the socket address struct
- * @errp: pointer to uninitialized error object
- *
- * Get the string representation of the socket
- * address. A pointer to the char array containing
- * string format will be returned, the caller is
- * required to release the returned value when no
- * longer required with g_free.
- *
- * Returns: the socket address in string format, or NULL on error
- */
-char *socket_address_to_string(struct SocketAddress *addr, Error **errp);
-
-/**
  * socket_address_flatten:
  * @addr: the socket address to flatten
  *
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b39ae74..08b1a26 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1301,40 +1301,6 @@ SocketAddress *socket_remote_address(int fd, Error **errp)
     return socket_sockaddr_to_address(&ss, sslen, errp);
 }
 
-char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
-{
-    char *buf;
-    InetSocketAddress *inet;
-
-    switch (addr->type) {
-    case SOCKET_ADDRESS_TYPE_INET:
-        inet = &addr->u.inet;
-        if (strchr(inet->host, ':') == NULL) {
-            buf = g_strdup_printf("%s:%s", inet->host, inet->port);
-        } else {
-            buf = g_strdup_printf("[%s]:%s", inet->host, inet->port);
-        }
-        break;
-
-    case SOCKET_ADDRESS_TYPE_UNIX:
-        buf = g_strdup(addr->u.q_unix.path);
-        break;
-
-    case SOCKET_ADDRESS_TYPE_FD:
-        buf = g_strdup(addr->u.fd.str);
-        break;
-
-    case SOCKET_ADDRESS_TYPE_VSOCK:
-        buf = g_strdup_printf("%s:%s",
-                              addr->u.vsock.cid,
-                              addr->u.vsock.port);
-        break;
-
-    default:
-        abort();
-    }
-    return buf;
-}
 
 SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
 {
-- 
2.9.3
