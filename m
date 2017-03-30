Received: from eggs.gnu.org ([2001:4830:134:3::10]:58799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctZvD-0002jd-5c
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctZvA-0002bG-Os
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:15:27 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 30 Mar 2017 15:15:04 +0200
Message-Id: <1490879707-6060-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1490879707-6060-1-git-send-email-armbru@redhat.com>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC v2 for-2.9 07/10] sockets: New helper
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
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com

SocketAddress is a simple union, and simple unions are awkward: they
have their variant members wrapped in a "data" object on the wire, and
require additional indirections in C.  I intend to limit its use to
existing external interfaces.  New ones should use SocketAddressFlat.
I further intend to convert all internal interfaces to
SocketAddressFlat.  This helper should go away then.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/sockets.h | 11 +++++++++++
 util/qemu-sockets.c    | 29 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 5f1bab9..cef05a5 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -119,4 +119,15 @@ SocketAddress *socket_remote_address(int fd, Error **errp);
  */
 char *socket_address_to_string(struct SocketAddress *addr, Error **errp);
 
+/**
+ * socket_address_crumple:
+ * @addr_flat: the socket addres to crumple
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
index 4ae37bd..03a2a47 100644
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
@@ -1341,3 +1342,31 @@ char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
     }
     return buf;
 }
+
+SocketAddress *socket_address_crumple(SocketAddressFlat *addr_flat)
+{
+    SocketAddress *addr = g_new(SocketAddress, 1);
+
+    addr->type = addr_flat->type;
+    switch (addr->type) {
+    case SOCKET_ADDRESS_FLAT_TYPE_INET:
+        addr->u.inet.data = QAPI_CLONE(InetSocketAddress,
+                                        &addr_flat->u.inet);
+        break;
+    case SOCKET_ADDRESS_FLAT_TYPE_UNIX:
+        addr->u.q_unix.data = QAPI_CLONE(UnixSocketAddress, &
+                                          addr_flat->u.q_unix);
+        break;
+    case SOCKET_ADDRESS_FLAT_TYPE_VSOCK:
+        addr->u.vsock.data = QAPI_CLONE(VsockSocketAddress,
+                                         &addr_flat->u.vsock);
+        break;
+    case SOCKET_ADDRESS_FLAT_TYPE_FD:
+        addr->u.fd.data = QAPI_CLONE(String, &addr_flat->u.fd);
+        break;
+    default:
+        abort();
+    }
+
+    return addr;
+}
-- 
2.7.4
