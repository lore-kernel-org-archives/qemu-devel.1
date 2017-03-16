Received: from eggs.gnu.org ([2001:4830:134:3::10]:44785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cobbD-0001ql-27
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cobbB-0003DN-6w
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:02:15 -0400
Received: from mail.kernel.org ([198.145.29.136]:45862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cobbA-0003C5-T9
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:02:13 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu, 16 Mar 2017 13:01:53 -0700
Message-Id: <1489694518-16978-4-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1489694518-16978-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703161241220.14378@sstabellini-ThinkPad-X260>
	<1489694518-16978-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH v3 4/9] xen/9pfs: introduce Xen 9pfs backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org, jgross@suse.com, groug@kaod.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Introduce the Xen 9pfs backend: add struct XenDevOps to register as a
Xen backend and add struct V9fsTransport to register as v9fs transport.

All functions are empty stubs for now.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
CC: anthony.perard@citrix.com
CC: jgross@suse.com
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/xen-9p-backend.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 hw/9pfs/xen-9p-backend.c

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
new file mode 100644
index 0000000..92bb805
--- /dev/null
+++ b/hw/9pfs/xen-9p-backend.c
@@ -0,0 +1,102 @@
+/*
+ * Xen 9p backend
+ *
+ * Copyright Aporeto 2017
+ *
+ * Authors:
+ *  Stefano Stabellini <stefano@aporeto.com>
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/hw.h"
+#include "hw/9pfs/9p.h"
+#include "hw/xen/xen_backend.h"
+#include "hw/xen/io/ring.h"
+#include "qemu/config-file.h"
+#include "fsdev/qemu-fsdev.h"
+#include <xen/io/protocols.h>
+
+#define PAGE_SHIFT XC_PAGE_SHIFT
+#define XEN_9PFS_RING_ORDER 6
+#define XEN_9PFS_RING_SIZE  XEN_FLEX_RING_SIZE(XEN_9PFS_RING_ORDER)
+DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);
+
+typedef struct Xen9pfsDev {
+    struct XenDevice xendev;  /* must be first */
+} Xen9pfsDev;
+
+static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
+                                     size_t offset,
+                                     const char *fmt,
+                                     va_list ap)
+{
+    return 0;
+}
+
+static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
+                                       size_t offset,
+                                       const char *fmt,
+                                       va_list ap)
+{
+    return 0;
+}
+
+static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
+                                           struct iovec **piov,
+                                           unsigned int *pniov)
+{
+}
+
+static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
+                                          struct iovec **piov,
+                                          unsigned int *pniov,
+                                          size_t size)
+{
+}
+
+static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
+{
+}
+
+static const struct V9fsTransport xen_9p_transport = {
+    .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
+    .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
+    .init_in_iov_from_pdu = xen_9pfs_init_in_iov_from_pdu,
+    .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
+    .push_and_notify = xen_9pfs_push_and_notify,
+};
+
+static int xen_9pfs_init(struct XenDevice *xendev)
+{
+    return 0;
+}
+
+static int xen_9pfs_free(struct XenDevice *xendev)
+{
+    return -1;
+}
+
+static int xen_9pfs_connect(struct XenDevice *xendev)
+{
+    return 0;
+}
+
+static void xen_9pfs_alloc(struct XenDevice *xendev)
+{
+}
+
+static void xen_9pfs_disconnect(struct XenDevice *xendev)
+{
+}
+
+struct XenDevOps xen_9pfs_ops = {
+    .size       = sizeof(Xen9pfsDev),
+    .flags      = DEVOPS_FLAG_NEED_GNTDEV,
+    .alloc      = xen_9pfs_alloc,
+    .init       = xen_9pfs_init,
+    .initialise = xen_9pfs_connect,
+    .disconnect = xen_9pfs_disconnect,
+    .free       = xen_9pfs_free,
+};
-- 
1.9.1
