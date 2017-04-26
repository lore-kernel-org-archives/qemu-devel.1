Received: from eggs.gnu.org ([2001:4830:134:3::10]:36829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3HVP-0003CD-4H
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3HVO-0005ez-2t
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:36:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 26 Apr 2017 09:36:42 +0200
Message-Id: <1493192202-3184-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1493192202-3184-1-git-send-email-armbru@redhat.com>
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 7/7] socket: Delete unused helper
 socket_address_crumple()
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/sockets.h | 11 -----------
 util/qemu-sockets.c    | 31 -------------------------------
 2 files changed, 42 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index a7da674..5b12252 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -121,17 +121,6 @@ SocketAddress *socket_remote_address(int fd, Error **errp);
 char *socket_address_to_string(struct SocketAddress *addr, Error **errp);
 
 /**
- * socket_address_crumple:
- * @addr_flat: the socket address to crumple
- *
- * Convert SocketAddress to SocketAddressLegacy.  Caller is responsible
- * for freeing with qapi_free_SocketAddressLegacy().
- *
- * Returns: the argument converted to SocketAddressLegacy.
- */
-SocketAddressLegacy *socket_address_crumple(SocketAddress *addr);
-
-/**
  * socket_address_flatten:
  * @addr: the socket address to flatten
  *
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index ad3ce65..31b5e8c 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1336,37 +1336,6 @@ char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
     return buf;
 }
 
-SocketAddressLegacy *socket_address_crumple(SocketAddress *addr_flat)
-{
-    SocketAddressLegacy *addr = g_new(SocketAddressLegacy, 1);
-
-    switch (addr_flat->type) {
-    case SOCKET_ADDRESS_TYPE_INET:
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-        addr->u.inet.data = QAPI_CLONE(InetSocketAddress,
-                                       &addr_flat->u.inet);
-        break;
-    case SOCKET_ADDRESS_TYPE_UNIX:
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-        addr->u.q_unix.data = QAPI_CLONE(UnixSocketAddress,
-                                         &addr_flat->u.q_unix);
-        break;
-    case SOCKET_ADDRESS_TYPE_VSOCK:
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_VSOCK;
-        addr->u.vsock.data = QAPI_CLONE(VsockSocketAddress,
-                                        &addr_flat->u.vsock);
-        break;
-    case SOCKET_ADDRESS_TYPE_FD:
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_FD;
-        addr->u.fd.data = QAPI_CLONE(String, &addr_flat->u.fd);
-        break;
-    default:
-        abort();
-    }
-
-    return addr;
-}
-
 SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
 {
     SocketAddress *addr = g_new(SocketAddress, 1);
-- 
2.7.4
