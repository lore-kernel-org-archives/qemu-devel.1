Received: from eggs.gnu.org ([2001:4830:134:3::10]:55340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGzA-00032e-ME
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGz9-0003QQ-FR
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGz9-0003QF-7P
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:03 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:17 +0800
Message-Id: <1481512100-10380-12-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 11/14] pci: edu: introduce
 pci-edu helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: drjones@redhat.com, agordeev@redhat.com, jan.kiszka@web.de, rkrcmar@redhat.com, pbonzini@redhat.com, peterx@redhat.com

QEMU edu device is a pci device that is originally written for
educational purpose, however it also suits for IOMMU unit test. Adding
helpers for this specific device to implement the device logic.

The device supports lots of functions, here only DMA operation is
supported.

The spec of the device can be found at:

  https://github.com/qemu/qemu/blob/master/docs/specs/edu.txt

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/pci-edu.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/pci-edu.h | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 lib/pci-edu.c
 create mode 100644 lib/pci-edu.h

diff --git a/lib/pci-edu.c b/lib/pci-edu.c
new file mode 100644
index 0000000..8096470
--- /dev/null
+++ b/lib/pci-edu.c
@@ -0,0 +1,73 @@
+/*
+ * Edu PCI device.
+ *
+ * Copyright (C) 2016 Red Hat, Inc.
+ *
+ * Authors:
+ *   Peter Xu <peterx@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or
+ * later.
+ */
+
+#include "pci-edu.h"
+#include "asm/barrier.h"
+
+/* Return true if alive */
+static inline bool edu_check_alive(struct pci_edu_dev *dev)
+{
+	static uint32_t live_count = 1;
+	uint32_t value;
+
+	edu_reg_writel(dev, EDU_REG_ALIVE, live_count++);
+	value = edu_reg_readl(dev, EDU_REG_ALIVE);
+	return (live_count - 1 == ~value);
+}
+
+bool edu_init(struct pci_edu_dev *dev)
+{
+	pcidevaddr_t dev_addr;
+
+	dev_addr = pci_find_dev(PCI_VENDOR_ID_QEMU, PCI_DEVICE_ID_EDU);
+	if (dev_addr == PCIDEVADDR_INVALID)
+		return false;
+
+	pci_dev_init(&dev->pci_dev, dev_addr);
+	pci_enable_defaults(&dev->pci_dev);
+	dev->reg_base = ioremap(dev->pci_dev.resource[EDU_BAR], PAGE_SIZE);
+	assert(edu_check_alive(dev));
+	return true;
+}
+
+void edu_dma(struct pci_edu_dev *dev, iova_t iova,
+	     size_t size, unsigned int dev_offset, bool from_device)
+{
+	uint64_t from, to;
+	uint32_t cmd = EDU_CMD_DMA_START;
+
+	assert(size <= EDU_DMA_SIZE_MAX);
+	assert(dev_offset < EDU_DMA_SIZE_MAX);
+
+	printf("edu device DMA start %s addr %p size 0x%lu off 0x%x\n",
+	       from_device ? "FROM" : "TO",
+	       (void *)iova, size, dev_offset);
+
+	if (from_device) {
+		from = dev_offset + EDU_DMA_START;
+		to = iova;
+		cmd |= EDU_CMD_DMA_FROM;
+	} else {
+		from = iova;
+		to = EDU_DMA_START + dev_offset;
+		cmd |= EDU_CMD_DMA_TO;
+	}
+
+	edu_reg_writeq(dev, EDU_REG_DMA_SRC, from);
+	edu_reg_writeq(dev, EDU_REG_DMA_DST, to);
+	edu_reg_writeq(dev, EDU_REG_DMA_COUNT, size);
+	edu_reg_writel(dev, EDU_REG_DMA_CMD, cmd);
+
+	/* Wait until DMA finished */
+	while (edu_reg_readl(dev, EDU_REG_DMA_CMD) & EDU_CMD_DMA_START)
+		cpu_relax();
+}
diff --git a/lib/pci-edu.h b/lib/pci-edu.h
new file mode 100644
index 0000000..8395ebe
--- /dev/null
+++ b/lib/pci-edu.h
@@ -0,0 +1,83 @@
+/*
+ * Edu PCI device header.
+ *
+ * Copyright (C) 2016 Red Hat, Inc.
+ *
+ * Authors:
+ *   Peter Xu <peterx@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or
+ * later.
+ *
+ * Edu device is a virtualized device in QEMU. Please refer to
+ * docs/specs/edu.txt in QEMU repository for EDU device manual.
+ */
+#ifndef __PCI_EDU_H__
+#define __PCI_EDU_H__
+
+#include "pci.h"
+#include "asm/io.h"
+
+#define  PCI_VENDOR_ID_QEMU              0x1234
+#define  PCI_DEVICE_ID_EDU               0x11e8
+
+/* The only bar used by EDU device */
+#define EDU_BAR                     0
+#define EDU_MAGIC                   0xed
+#define EDU_VERSION                 0x100
+#define EDU_DMA_BUF_SIZE            (1 << 20)
+#define EDU_INPUT_BUF_SIZE          256
+
+#define EDU_REG_ID                  0x0
+#define EDU_REG_ALIVE               0x4
+#define EDU_REG_FACTORIAL           0x8
+#define EDU_REG_STATUS              0x20
+#define EDU_REG_DMA_SRC             0x80
+#define EDU_REG_DMA_DST             0x88
+#define EDU_REG_DMA_COUNT           0x90
+#define EDU_REG_DMA_CMD             0x98
+
+#define EDU_CMD_DMA_START           0x01
+#define EDU_CMD_DMA_FROM            0x02
+#define EDU_CMD_DMA_TO              0x00
+
+#define EDU_STATUS_FACTORIAL        0x1
+#define EDU_STATUS_INT_ENABLE       0x80
+
+#define EDU_DMA_START               0x40000
+#define EDU_DMA_SIZE_MAX            4096
+
+struct pci_edu_dev {
+	struct pci_dev pci_dev;
+	volatile void *reg_base;
+};
+
+#define edu_reg(d, r) (volatile void *)((d)->reg_base + (r))
+
+static inline uint64_t edu_reg_readq(struct pci_edu_dev *dev, int reg)
+{
+	return __raw_readq(edu_reg(dev, reg));
+}
+
+static inline uint32_t edu_reg_readl(struct pci_edu_dev *dev, int reg)
+{
+	return __raw_readl(edu_reg(dev, reg));
+}
+
+static inline void edu_reg_writeq(struct pci_edu_dev *dev, int reg,
+				  uint64_t val)
+{
+	__raw_writeq(val, edu_reg(dev, reg));
+}
+
+static inline void edu_reg_writel(struct pci_edu_dev *dev, int reg,
+				  uint32_t val)
+{
+	__raw_writel(val, edu_reg(dev, reg));
+}
+
+bool edu_init(struct pci_edu_dev *dev);
+void edu_dma(struct pci_edu_dev *dev, iova_t iova,
+	     size_t size, unsigned int dev_offset, bool from_device);
+
+#endif
-- 
2.7.4
