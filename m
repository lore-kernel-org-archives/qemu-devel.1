Received: from eggs.gnu.org ([2001:4830:134:3::10]:55390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGzH-00038Q-D4
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGzG-0003Rk-9m
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGzG-0003Rc-19
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:10 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:19 +0800
Message-Id: <1481512100-10380-14-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 13/14] pci: add msi support
 for 32/64bit address
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

pci_cap_walk() is provided to allow walk through all the capability bits
for a specific PCI device. If a cap handler is provided, it'll be
triggered if the cap is detected along the cap walk.

MSI cap handler is the first one supported. We can add more cap handler
in the future.

Meanwhile, pci_setup_msi() API is provided to support basic 32/64 bit
address MSI setup.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/pci.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/pci.h |  4 ++++
 2 files changed, 73 insertions(+)

diff --git a/lib/pci.c b/lib/pci.c
index bf2a3df..a51eb8e 100644
--- a/lib/pci.c
+++ b/lib/pci.c
@@ -7,6 +7,74 @@
 #include "pci.h"
 #include "asm/pci.h"
 
+typedef void (*pci_cap_handler)(struct pci_dev *dev, int cap_offset);
+
+static void pci_cap_msi_handler(struct pci_dev *dev, int cap_offset)
+{
+	printf("Detected MSI for device 0x%x offset 0x%x\n",
+	       dev->bdf, cap_offset);
+	dev->msi_offset = cap_offset;
+}
+
+static pci_cap_handler cap_handlers[PCI_CAP_ID_MAX + 1] = {
+	[PCI_CAP_ID_MSI] = pci_cap_msi_handler,
+};
+
+void pci_cap_walk(struct pci_dev *dev)
+{
+	uint8_t cap_offset;
+	uint8_t cap_id;
+	int count = 0;
+
+	cap_offset = pci_config_readb(dev->bdf, PCI_CAPABILITY_LIST);
+	while (cap_offset) {
+		cap_id = pci_config_readb(dev->bdf, cap_offset);
+		printf("PCI detected cap 0x%x\n", cap_id);
+		assert(cap_id < PCI_CAP_ID_MAX + 1);
+		if (cap_handlers[cap_id])
+			cap_handlers[cap_id](dev, cap_offset);
+		cap_offset = pci_config_readb(dev->bdf, cap_offset + 1);
+		/* Avoid dead loop during cap walk */
+		assert(++count <= 255);
+	}
+}
+
+bool pci_setup_msi(struct pci_dev *dev, uint64_t msi_addr, uint32_t msi_data)
+{
+	uint16_t msi_control;
+	uint16_t offset;
+	pcidevaddr_t addr;
+
+	assert(dev);
+
+	if (!dev->msi_offset) {
+		printf("MSI: dev 0x%x does not support MSI.\n", dev->bdf);
+		return false;
+	}
+
+	addr = dev->bdf;
+	offset = dev->msi_offset;
+	msi_control = pci_config_readw(addr, offset + PCI_MSI_FLAGS);
+	pci_config_writel(addr, offset + PCI_MSI_ADDRESS_LO,
+			  msi_addr & 0xffffffff);
+
+	if (msi_control & PCI_MSI_FLAGS_64BIT) {
+		pci_config_writel(addr, offset + PCI_MSI_ADDRESS_HI,
+				  (uint32_t)(msi_addr >> 32));
+		pci_config_writel(addr, offset + PCI_MSI_DATA_64, msi_data);
+		printf("MSI: dev 0x%x init 64bit address: ", addr);
+	} else {
+		pci_config_writel(addr, offset + PCI_MSI_DATA_32, msi_data);
+		printf("MSI: dev 0x%x init 32bit address: ", addr);
+	}
+	printf("addr=0x%lx, data=0x%x\n", msi_addr, msi_data);
+
+	msi_control |= PCI_MSI_FLAGS_ENABLE;
+	pci_config_writew(addr, offset + PCI_MSI_FLAGS, msi_control);
+
+	return true;
+}
+
 void pci_cmd_set_clr(struct pci_dev *dev, uint16_t set, uint16_t clr)
 {
 	uint16_t val = pci_config_readw(dev->bdf, PCI_COMMAND);
@@ -260,4 +328,5 @@ void pci_enable_defaults(struct pci_dev *dev)
 	pci_scan_bars(dev);
 	/* Enable device DMA operations */
 	pci_cmd_set_clr(dev, PCI_COMMAND_MASTER, 0);
+	pci_cap_walk(dev);
 }
diff --git a/lib/pci.h b/lib/pci.h
index 26968b1..e71a05d 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -23,13 +23,17 @@ enum {
 
 struct pci_dev {
 	uint16_t bdf;
+	uint16_t msi_offset;
 	phys_addr_t resource[PCI_BAR_NUM];
 };
 
 extern void pci_dev_init(struct pci_dev *dev, pcidevaddr_t bdf);
 extern void pci_scan_bars(struct pci_dev *dev);
 extern void pci_cmd_set_clr(struct pci_dev *dev, uint16_t set, uint16_t clr);
+extern void pci_cap_walk(struct pci_dev *dev);
 extern void pci_enable_defaults(struct pci_dev *dev);
+extern bool pci_setup_msi(struct pci_dev *dev, uint64_t msi_addr,
+			  uint32_t msi_data);
 
 typedef phys_addr_t iova_t;
 
-- 
2.7.4
