Received: from eggs.gnu.org ([209.51.188.92]:59537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLH-0001fK-Hr
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLG-0004gl-Og
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLG-0004gU-GP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:22 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:15 -0800
Message-Id: <20190307072115.8428-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 08/37] multi-process: add
 functions to synchronize proxy and remote endpoints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, berrange@redhat.com

From: Jagannathan Raman <jag.raman@oracle.com>

In some cases, for example MMIO read, QEMU has to wait for the remote to
complete a command before proceeding. An eventfd based mechanism is
added to synchronize QEMU & remote process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 include/io/proxy-link.h |  9 +++++++++
 io/proxy-link.c         | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index ff602e4..a12c565 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -28,7 +28,9 @@
 #include <stddef.h>
 #include <stdint.h>
 #include <glib.h>
+#include <unistd.h>
 #include <pthread.h>
+#include <sys/eventfd.h>
 
 #include "qemu/osdep.h"
 #include "qom/object.h"
@@ -124,11 +126,18 @@ struct ProxyLinkState {
     proxy_link_callback callback;
 };
 
+#define GET_REMOTE_WAIT eventfd(0, 0)
+#define PUT_REMOTE_WAIT(wait) close(wait)
+#define PROXY_LINK_WAIT_DONE 1
+
 ProxyLinkState *proxy_link_create(void);
 void proxy_link_finalize(ProxyLinkState *s);
 
 void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg);
 int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg);
+uint64_t wait_for_remote(int efd);
+void notify_proxy(int fd, uint64_t val);
+
 void proxy_link_set_sock(ProxyLinkState *s, int fd);
 void proxy_link_set_callback(ProxyLinkState *s, proxy_link_callback callback);
 void start_handler(ProxyLinkState *s);
diff --git a/io/proxy-link.c b/io/proxy-link.c
index 9ea0ed7..9f6ae77 100644
--- a/io/proxy-link.c
+++ b/io/proxy-link.c
@@ -31,6 +31,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <unistd.h>
+#include <limits.h>
 
 #include "qemu/module.h"
 #include "io/proxy-link.h"
@@ -210,6 +211,31 @@ int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg)
     return rc;
 }
 
+uint64_t wait_for_remote(int efd)
+{
+    uint64_t val;
+
+    if (read(efd, &val, sizeof(val)) == -1) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "Error wait_for_remote: %s\n",
+                      strerror(errno));
+        return ULLONG_MAX;
+    }
+
+    val = (val == ULLONG_MAX) ? val : (val - 1);
+
+    return val;
+}
+
+void notify_proxy(int efd, uint64_t val)
+{
+    val = (val == ULLONG_MAX) ? val : (val + 1);
+
+    if (write(efd, &val, sizeof(val)) == -1) {
+        qemu_log_mask(LOG_REMOTE_DEBUG, "Error notify_proxy: %s\n",
+                      strerror(errno));
+    }
+}
+
 static gboolean proxy_link_handler_prepare(GSource *gsrc, gint *timeout)
 {
     g_assert(timeout);
-- 
1.8.3.1
