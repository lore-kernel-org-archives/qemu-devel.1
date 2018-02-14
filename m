Received: from eggs.gnu.org ([2001:4830:134:3::10]:47770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1em2dt-0003Ci-HN
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1em2ds-0008GP-AN
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:22:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1em2ds-0008GD-4s
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:22:56 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 14 Feb 2018 21:22:25 +0200
Message-Id: <20180214192230.70287-6-marcel@redhat.com>
In-Reply-To: <20180214192230.70287-1-marcel@redhat.com>
References: <20180214192230.70287-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH V11 05/10] hw/rdma: Add wrappers and macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, mst@redhat.com, dotanb@mellanox.com, yanjun.zhu@oracle.com, ghammer@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

As all mapping for this device are from driver to device,
declare wrappers on top of pci_dma_*map functions.

In addition, declare macros to be used for debug messages.

Reviewed-by: Dotan Barak <dotanb@mellanox.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/Makefile.objs      |  1 +
 hw/rdma/Makefile.objs |  3 +++
 hw/rdma/rdma_utils.c  | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/rdma/rdma_utils.h  | 43 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+)
 create mode 100644 hw/rdma/Makefile.objs
 create mode 100644 hw/rdma/rdma_utils.c
 create mode 100644 hw/rdma/rdma_utils.h

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index cf4cb2010b..6a0ffe0afd 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -18,6 +18,7 @@ devices-dirs-$(CONFIG_IPMI) += ipmi/
 devices-dirs-$(CONFIG_SOFTMMU) += isa/
 devices-dirs-$(CONFIG_SOFTMMU) += misc/
 devices-dirs-$(CONFIG_SOFTMMU) += net/
+devices-dirs-$(CONFIG_SOFTMMU) += rdma/
 devices-dirs-$(CONFIG_SOFTMMU) += nvram/
 devices-dirs-$(CONFIG_SOFTMMU) += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
new file mode 100644
index 0000000000..cdffe4a9a3
--- /dev/null
+++ b/hw/rdma/Makefile.objs
@@ -0,0 +1,3 @@
+ifeq ($(CONFIG_RDMA),y)
+obj-$(CONFIG_PCI) += rdma_utils.o
+endif
diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
new file mode 100644
index 0000000000..0e5caffd40
--- /dev/null
+++ b/hw/rdma/rdma_utils.c
@@ -0,0 +1,51 @@
+/*
+ * QEMU paravirtual RDMA - Generic RDMA backend
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "rdma_utils.h"
+
+void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen)
+{
+    void *p;
+    hwaddr len = plen;
+
+    if (!addr) {
+        pr_dbg("addr is NULL\n");
+        return NULL;
+    }
+
+    p = pci_dma_map(dev, addr, &len, DMA_DIRECTION_TO_DEVICE);
+    if (!p) {
+        pr_dbg("Fail in pci_dma_map, addr=0x%llx, len=%ld\n",
+               (long long unsigned int)addr, len);
+        return NULL;
+    }
+
+    if (len != plen) {
+        rdma_pci_dma_unmap(dev, p, len);
+        return NULL;
+    }
+
+    pr_dbg("0x%llx -> %p (len=%ld)\n", (long long unsigned int)addr, p, len);
+
+    return p;
+}
+
+void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len)
+{
+    pr_dbg("%p\n", buffer);
+    if (buffer) {
+        pci_dma_unmap(dev, buffer, len, DMA_DIRECTION_TO_DEVICE, 0);
+    }
+}
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
new file mode 100644
index 0000000000..cdac910e24
--- /dev/null
+++ b/hw/rdma/rdma_utils.h
@@ -0,0 +1,43 @@
+/*
+ * RDMA device: Debug utilities
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef RDMA_UTILS_H
+#define RDMA_UTILS_H
+
+#include <qemu/osdep.h>
+#include <include/hw/pci/pci.h>
+#include <include/sysemu/dma.h>
+
+#define pr_info(fmt, ...) \
+    fprintf(stdout, "%s: %-20s (%3d): " fmt, "pvrdma",  __func__, __LINE__,\
+           ## __VA_ARGS__)
+
+#define pr_err(fmt, ...) \
+    fprintf(stderr, "%s: Error at %-20s (%3d): " fmt, "pvrdma", __func__, \
+        __LINE__, ## __VA_ARGS__)
+
+#ifdef PVRDMA_DEBUG
+#define pr_dbg(fmt, ...) \
+    fprintf(stdout, "%s: %-20s (%3d): " fmt, "pvrdma", __func__, __LINE__,\
+           ## __VA_ARGS__)
+#else
+#define pr_dbg(fmt, ...)
+#endif
+
+void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen);
+void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);
+
+#endif
-- 
2.13.5
