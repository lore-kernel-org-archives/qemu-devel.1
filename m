Received: from eggs.gnu.org ([2001:4830:134:3::10]:45687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv3zw-0006Gy-NE
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv3zv-0007QS-P2
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:28 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 17:33:48 +0200
Message-Id: <20170403153355.19722-9-mreitz@redhat.com>
In-Reply-To: <20170403153355.19722-1-mreitz@redhat.com>
References: <20170403153355.19722-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 08/15] sockets: New helper
 socket_address_crumple()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Markus Armbruster <armbru@redhat.com>

SocketAddress is a simple union, and simple unions are awkward: they
have their variant members wrapped in a "data" object on the wire, and
require additional indirections in C.  I intend to limit its use to
existing external interfaces.  New ones should use SocketAddressFlat.
I further intend to convert all internal interfaces to
SocketAddressFlat.  This helper should go away then.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-id: 1490895797-29094-8-git-send-email-armbru@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/qemu/sockets.h | 11 +++++++++++
 util/qemu-sockets.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 5f1bab9b3e..7842f6d150 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -119,4 +119,15 @@ SocketAddress *socket_remote_address(int fd, Error **errp);
  */
 char *socket_address_to_string(struct SocketAddress *addr, Error **errp);
 
+/**
+ * socket_address_crumple:
+ * @addr_flat: the socket address to crumple
+ *
+ * Convert SocketAddressFlat to SocketAddress.  Caller is responsible
+ * for freeing with qapi_free_SocketAddress().
+ *
+ * Returns: the argument converted to SocketAddress.
+ */
+SocketAddress *socket_address_crumple(SocketAddressFlat *addr_flat);
+
 #endif /* QEMU_SOCKETS_H */
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 4ae37bd2a2..21442c30dc 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "qemu/sockets.h"
 #include "qemu/main-loop.h"
+#include "qapi/clone-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi-visit.h"
@@ -1341,3 +1342,34 @@ char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
     }
     return buf;
 }
+
+SocketAddress *socket_address_crumple(SocketAddressFlat *addr_flat)
+{
+    SocketAddress *addr = g_new(SocketAddress, 1);
+
+    switch (addr_flat->type) {
+    case SOCKET_ADDRESS_FLAT_TYPE_INET:
+        addr->type = SOCKET_ADDRESS_KIND_INET;
+        addr->u.inet.data = QAPI_CLONE(InetSocketAddress,
+                                       &addr_flat->u.inet);
+        break;
+    case SOCKET_ADDRESS_FLAT_TYPE_UNIX:
+        addr->type = SOCKET_ADDRESS_KIND_UNIX;
+        addr->u.q_unix.data = QAPI_CLONE(UnixSocketAddress,
+                                         &addr_flat->u.q_unix);
+        break;
+    case SOCKET_ADDRESS_FLAT_TYPE_VSOCK:
+        addr->type = SOCKET_ADDRESS_KIND_VSOCK;
+        addr->u.vsock.data = QAPI_CLONE(VsockSocketAddress,
+                                        &addr_flat->u.vsock);
+        break;
+    case SOCKET_ADDRESS_FLAT_TYPE_FD:
+        addr->type = SOCKET_ADDRESS_KIND_FD;
+        addr->u.fd.data = QAPI_CLONE(String, &addr_flat->u.fd);
+        break;
+    default:
+        abort();
+    }
+
+    return addr;
+}
-- 
2.12.1
