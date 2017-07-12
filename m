Received: from eggs.gnu.org ([2001:4830:134:3::10]:59288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVHqN-0008US-DJ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVHqJ-0005Kg-FV
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:38:19 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Wed, 12 Jul 2017 16:37:58 +0300
Message-Id: <3bcf7d7df552c8bd4fdfe70b753f45169407cacb.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 02/13] util/qemu-sockets: Drop unused helper
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
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/qemu/sockets.h | 15 ---------------
 util/qemu-sockets.c    | 34 ----------------------------------
 2 files changed, 49 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 5c326db232..ef6b5591f7 100644
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
index d3e51089de..55b6c17f5f 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1325,40 +1325,6 @@ SocketAddress *socket_remote_address(int fd, Error **errp)
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
2.11.0
