Received: from eggs.gnu.org ([2001:4830:134:3::10]:34564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMszY-0000Cn-CY
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMszX-0008Of-DW
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cMszX-0008OX-4a
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:47 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 30 Dec 2016 16:56:00 +0800
Message-Id: <1483088160-6714-9-git-send-email-peterx@redhat.com>
In-Reply-To: <1483088160-6714-1-git-send-email-peterx@redhat.com>
References: <1483088160-6714-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 8/8] intel-iommu: add ioapic irq
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@web.de>, Paolo Bonzini <pbonzini@redhat.com>, agordeev@redhat.com, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Andrew Jones <drjones@redhat.com>, peterx@redhat.com

IOAPIC irqs are line-based irqs comparing to MSI ones (which are
memory-based). To make it complete, let's also test IOAPIC interrupts
in the IR testcase.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/x86/intel-iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
 lib/x86/intel-iommu.h |  3 +++
 x86/intel-iommu.c     | 38 +++++++++++++++++++++++++++++++++-----
 3 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/lib/x86/intel-iommu.c b/lib/x86/intel-iommu.c
index 0585248..1629920 100644
--- a/lib/x86/intel-iommu.c
+++ b/lib/x86/intel-iommu.c
@@ -284,6 +284,21 @@ struct vtd_msi_data {
 } __attribute__ ((packed));
 typedef struct vtd_msi_data vtd_msi_data_t;
 
+struct vtd_ioapic_entry {
+	uint64_t vector:8;
+	uint64_t __zeros:3;
+	uint64_t index_15:1;
+	uint64_t delivery_status:1;
+	uint64_t polarity:1;
+	uint64_t remote_irr:1;
+	uint64_t trigger_mode:1;
+	uint64_t mask:1;
+	uint64_t __zeros_2:31;
+	uint64_t interrupt_format:1;
+	uint64_t index_0_14:15;
+} __attribute__ ((packed));
+typedef struct vtd_ioapic_entry vtd_ioapic_entry_t;
+
 /**
  * vtd_setup_msi - setup MSI message for a device
  *
@@ -316,6 +331,31 @@ bool vtd_setup_msi(struct pci_dev *dev, int vector, int dest_id)
 			     *(uint32_t *)&msi_data);
 }
 
+void vtd_setup_ioapic_irq(struct pci_dev *dev, int vector,
+			  int dest_id, trigger_mode_t trigger)
+{
+	vtd_ioapic_entry_t entry = {};
+	vtd_irte_t *irte = phys_to_virt(vtd_ir_table());
+	ioapic_redir_entry_t *entry_2 = (ioapic_redir_entry_t *)&entry;
+	uint16_t index = vtd_intr_index_alloc();
+	uint8_t line;
+
+	assert(dev);
+	assert(sizeof(vtd_ioapic_entry_t) == 8);
+
+	vtd_setup_irte(dev, irte + index, vector,
+		       dest_id, trigger);
+
+	entry.vector = vector;
+	entry.trigger_mode = trigger;
+	entry.index_15 = (index >> 15) & 1;
+	entry.interrupt_format = 1;
+	entry.index_0_14 = index & 0x7fff;
+
+	line = pci_intx_line(dev);
+	ioapic_write_redir(line, *entry_2);
+}
+
 void vtd_init(void)
 {
 	setup_vm();
diff --git a/lib/x86/intel-iommu.h b/lib/x86/intel-iommu.h
index e3e956d..885be53 100644
--- a/lib/x86/intel-iommu.h
+++ b/lib/x86/intel-iommu.h
@@ -22,6 +22,7 @@
 #include "desc.h"
 #include "pci.h"
 #include "asm/io.h"
+#include "apic.h"
 
 #define Q35_HOST_BRIDGE_IOMMU_ADDR  0xfed90000ULL
 #define VTD_PAGE_SHIFT              PAGE_SHIFT
@@ -142,5 +143,7 @@ static inline uint64_t vtd_readq(unsigned int reg)
 void vtd_init(void);
 void vtd_map_range(uint16_t sid, phys_addr_t iova, phys_addr_t pa, size_t size);
 bool vtd_setup_msi(struct pci_dev *dev, int vector, int dest_id);
+void vtd_setup_ioapic_irq(struct pci_dev *dev, int vector,
+			  int dest_id, trigger_mode_t trigger);
 
 #endif
diff --git a/x86/intel-iommu.c b/x86/intel-iommu.c
index 59171a1..5a65232 100644
--- a/x86/intel-iommu.c
+++ b/x86/intel-iommu.c
@@ -16,6 +16,7 @@
 
 #define VTD_TEST_DMAR_4B ("DMAR 4B memcpy test")
 #define VTD_TEST_IR_MSI ("IR MSI")
+#define VTD_TEST_IR_IOAPIC ("IR IOAPIC")
 
 void vtd_test_dmar(struct pci_edu_dev *dev)
 {
@@ -67,22 +68,48 @@ static void edu_isr(isr_regs_t *regs)
 
 static void vtd_test_ir(struct pci_edu_dev *dev)
 {
-#define VTD_TEST_VECTOR (0xee)
+#define VTD_TEST_VECTOR_IOAPIC (0xed)
+#define VTD_TEST_VECTOR_MSI (0xee)
+	struct pci_dev *pci_dev = &dev->pci_dev;
+
 	report_prefix_push("vtd_ir");
 
+	irq_enable();
+
+	/* This will enable INTx */
+	pci_msi_set_enable(pci_dev, false);
+	vtd_setup_ioapic_irq(pci_dev, VTD_TEST_VECTOR_IOAPIC,
+			     0, TRIGGER_EDGE);
+	handle_irq(VTD_TEST_VECTOR_IOAPIC, edu_isr);
+
+	edu_intr_recved = false;
+	wmb();
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
+	report(VTD_TEST_IR_IOAPIC, edu_intr_recved == true);
+
 	/*
 	 * Setup EDU PCI device MSI, using interrupt remapping. By
 	 * default, EDU device is using INTx.
 	 */
-	if (!vtd_setup_msi(&dev->pci_dev, VTD_TEST_VECTOR, 0)) {
+	if (!vtd_setup_msi(pci_dev, VTD_TEST_VECTOR_MSI, 0)) {
 		printf("edu device does not support MSI, skip test\n");
 		report_skip(VTD_TEST_IR_MSI);
 		return;
 	}
 
-	handle_irq(VTD_TEST_VECTOR, edu_isr);
-	irq_enable();
+	handle_irq(VTD_TEST_VECTOR_MSI, edu_isr);
 
+	edu_intr_recved = false;
+	wmb();
 	/* Manually trigger INTR */
 	edu_reg_writel(dev, EDU_REG_INTR_RAISE, 1);
 
@@ -93,7 +120,7 @@ static void vtd_test_ir(struct pci_edu_dev *dev)
 	edu_reg_writel(dev, EDU_REG_INTR_RAISE, 0);
 
 	/* We are good as long as we reach here */
-	report(VTD_TEST_IR_MSI, true);
+	report(VTD_TEST_IR_MSI, edu_intr_recved == true);
 
 	report_prefix_pop();
 }
@@ -122,6 +149,7 @@ int main(int argc, char *argv[])
 		printf("Please specify \"-device edu\" to do "
 		       "further IOMMU tests.\n");
 		report_skip(VTD_TEST_DMAR_4B);
+		report_skip(VTD_TEST_IR_IOAPIC);
 		report_skip(VTD_TEST_IR_MSI);
 	} else {
 		vtd_test_dmar(&dev);
-- 
2.7.4
