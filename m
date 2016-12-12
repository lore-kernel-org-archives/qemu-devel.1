Received: from eggs.gnu.org ([2001:4830:134:3::10]:55440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGzN-0003DK-0i
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGzJ-0003TV-Ow
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGzJ-0003TI-GT
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:13 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:20 +0800
Message-Id: <1481512100-10380-15-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 14/14] x86: intel-iommu: add
 IR MSI test
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

First of all, vtd_setup_msi() is provided. It setup IRTE entries,
meanwhile, setup PCI device MSI vectors corresponding to VT-d spec.

Meanwhile, IR MSI test is added to intel IOMMU unit test. The basic IR
test is carried out by a edu INTR raise request. When write to the intr
raise register, interrupt will be generated. Type of interrupt will
depend on the setup (either INTx or MSI).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/pci-edu.h         |  1 +
 lib/x86/intel-iommu.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/x86/intel-iommu.h |  1 +
 x86/intel-iommu.c     | 44 +++++++++++++++++++++++-
 4 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/lib/pci-edu.h b/lib/pci-edu.h
index 8395ebe..9fe32c6 100644
--- a/lib/pci-edu.h
+++ b/lib/pci-edu.h
@@ -32,6 +32,7 @@
 #define EDU_REG_ALIVE               0x4
 #define EDU_REG_FACTORIAL           0x8
 #define EDU_REG_STATUS              0x20
+#define EDU_REG_INTR_RAISE          0x60
 #define EDU_REG_DMA_SRC             0x80
 #define EDU_REG_DMA_DST             0x88
 #define EDU_REG_DMA_COUNT           0x90
diff --git a/lib/x86/intel-iommu.c b/lib/x86/intel-iommu.c
index 86b1805..20b9240 100644
--- a/lib/x86/intel-iommu.c
+++ b/lib/x86/intel-iommu.c
@@ -12,6 +12,7 @@
 
 #include "intel-iommu.h"
 #include "libcflat.h"
+#include "pci.h"
 
 /*
  * VT-d in QEMU currently only support 39 bits address width, which is
@@ -48,6 +49,26 @@ struct vtd_context_entry {
 } __attribute__ ((packed));
 typedef struct vtd_context_entry vtd_ce_t;
 
+struct vtd_irte {
+	uint32_t present:1;
+	uint32_t fault_disable:1;    /* Fault Processing Disable */
+	uint32_t dest_mode:1;        /* Destination Mode */
+	uint32_t redir_hint:1;       /* Redirection Hint */
+	uint32_t trigger_mode:1;     /* Trigger Mode */
+	uint32_t delivery_mode:3;    /* Delivery Mode */
+	uint32_t __avail:4;          /* Available spaces for software */
+	uint32_t __reserved_0:3;     /* Reserved 0 */
+	uint32_t irte_mode:1;        /* IRTE Mode */
+	uint32_t vector:8;           /* Interrupt Vector */
+	uint32_t __reserved_1:8;     /* Reserved 1 */
+	uint32_t dest_id;            /* Destination ID */
+	uint16_t source_id:16;       /* Source-ID */
+	uint64_t sid_q:2;            /* Source-ID Qualifier */
+	uint64_t sid_vtype:2;        /* Source-ID Validation Type */
+	uint64_t __reserved_2:44;    /* Reserved 2 */
+} __attribute__ ((packed));
+typedef struct vtd_irte vtd_irte_t;
+
 #define VTD_RTA_MASK  (PAGE_MASK)
 #define VTD_IRTA_MASK (PAGE_MASK)
 
@@ -216,6 +237,79 @@ void vtd_map_range(uint16_t sid, iova_t iova, phys_addr_t pa, size_t size)
 	}
 }
 
+static uint16_t vtd_intr_index_alloc(void)
+{
+	static int index_ctr = 0;
+	assert(index_ctr < 65535);
+	return index_ctr++;
+}
+
+static void vtd_setup_irte(struct pci_dev *dev, vtd_irte_t *irte,
+			   int vector, int dest_id)
+{
+	assert(sizeof(vtd_irte_t) == 16);
+	memset(irte, 0, sizeof(*irte));
+	irte->fault_disable = 1;
+	irte->dest_mode = 0;	 /* physical */
+	irte->trigger_mode = 0;	 /* edge */
+	irte->delivery_mode = 0; /* fixed */
+	irte->irte_mode = 0;	 /* remapped */
+	irte->vector = vector;
+	irte->dest_id = dest_id;
+	irte->source_id = dev->bdf;
+	irte->sid_q = 0;
+	irte->sid_vtype = 1;     /* full-sid verify */
+	irte->present = 1;
+}
+
+struct vtd_msi_addr {
+	uint32_t __dont_care:2;
+	uint32_t handle_15:1;	 /* handle[15] */
+	uint32_t shv:1;
+	uint32_t interrupt_format:1;
+	uint32_t handle_0_14:15; /* handle[0:14] */
+	uint32_t head:12;	 /* 0xfee */
+	uint32_t addr_hi;	 /* not used except with x2apic */
+} __attribute__ ((packed));
+typedef struct vtd_msi_addr vtd_msi_addr_t;
+
+struct vtd_msi_data {
+	uint16_t __reserved;
+	uint16_t subhandle;
+} __attribute__ ((packed));
+typedef struct vtd_msi_data vtd_msi_data_t;
+
+/**
+ * vtd_setup_msi - setup MSI message for a device
+ *
+ * @dev: PCI device to setup MSI
+ * @vector: interrupt vector
+ * @dest_id: destination processor
+ */
+bool vtd_setup_msi(struct pci_dev *dev, int vector, int dest_id)
+{
+	vtd_msi_data_t msi_data = {};
+	vtd_msi_addr_t msi_addr = {};
+	vtd_irte_t *irte = phys_to_virt(vtd_ir_table());
+	uint16_t index = vtd_intr_index_alloc();
+
+	assert(sizeof(vtd_msi_addr_t) == 8);
+	assert(sizeof(vtd_msi_data_t) == 4);
+
+	printf("INTR: setup IRTE index %d\n", index);
+	vtd_setup_irte(dev, irte + index, vector, dest_id);
+
+	msi_addr.handle_15 = index >> 15 & 1;
+	msi_addr.shv = 0;
+	msi_addr.interrupt_format = 1;
+	msi_addr.handle_0_14 = index & 0x7fff;
+	msi_addr.head = 0xfee;
+	msi_data.subhandle = 0;
+
+	return pci_setup_msi(dev, *(uint64_t *)&msi_addr,
+			     *(uint32_t *)&msi_data);
+}
+
 void vtd_init(void)
 {
 	setup_vm();
diff --git a/lib/x86/intel-iommu.h b/lib/x86/intel-iommu.h
index 50f67f1..e3e956d 100644
--- a/lib/x86/intel-iommu.h
+++ b/lib/x86/intel-iommu.h
@@ -141,5 +141,6 @@ static inline uint64_t vtd_readq(unsigned int reg)
 
 void vtd_init(void);
 void vtd_map_range(uint16_t sid, phys_addr_t iova, phys_addr_t pa, size_t size);
+bool vtd_setup_msi(struct pci_dev *dev, int vector, int dest_id);
 
 #endif
diff --git a/x86/intel-iommu.c b/x86/intel-iommu.c
index 21fd57f..753f90e 100644
--- a/x86/intel-iommu.c
+++ b/x86/intel-iommu.c
@@ -12,8 +12,10 @@
 
 #include "intel-iommu.h"
 #include "pci-edu.h"
+#include "x86/apic.h"
 
 #define VTD_TEST_DMAR_4B ("DMAR 4B memcpy test")
+#define VTD_TEST_IR_MSI ("IR MSI")
 
 void vtd_test_dmar(struct pci_edu_dev *dev)
 {
@@ -51,6 +53,43 @@ void vtd_test_dmar(struct pci_edu_dev *dev)
 	free_page(page);
 }
 
+static volatile bool edu_intr_recved;
+
+static void edu_isr(isr_regs_t *regs)
+{
+	edu_intr_recved = true;
+	eoi();
+}
+
+static void vtd_test_ir(struct pci_edu_dev *dev)
+{
+#define VTD_TEST_VECTOR (0xee)
+	/*
+	 * Setup EDU PCI device MSI, using interrupt remapping. By
+	 * default, EDU device is using INTx.
+	 */
+	if (!vtd_setup_msi(&dev->pci_dev, VTD_TEST_VECTOR, 0)) {
+		printf("edu device does not support MSI, skip test\n");
+		report_skip(VTD_TEST_IR_MSI);
+		return;
+	}
+
+	handle_irq(VTD_TEST_VECTOR, edu_isr);
+	irq_enable();
+
+	/* Manually trigger INTR */
+	edu_reg_writel(dev, EDU_REG_INTR_RAISE, 1);
+
+	while (!edu_intr_recved)
+		cpu_relax();
+
+	/* Clear INTR bits */
+	edu_reg_writel(dev, EDU_REG_INTR_RAISE, 0);
+
+	/* We are good as long as we reach here */
+	report(VTD_TEST_IR_MSI, true);
+}
+
 int main(int argc, char *argv[])
 {
 	struct pci_edu_dev dev;
@@ -71,8 +110,11 @@ int main(int argc, char *argv[])
 		printf("Please specify \"-device edu\" to do "
 		       "further IOMMU tests.\n");
 		report_skip(VTD_TEST_DMAR_4B);
-	} else
+		report_skip(VTD_TEST_IR_MSI);
+	} else {
 		vtd_test_dmar(&dev);
+		vtd_test_ir(&dev);
+	}
 
 	return report_summary();
 }
-- 
2.7.4
