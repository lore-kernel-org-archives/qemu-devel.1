Received: from eggs.gnu.org ([2001:4830:134:3::10]:55361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGzE-00035c-5G
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGzC-0003Qs-MP
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGzC-0003Qi-Ds
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:09:06 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:18 +0800
Message-Id: <1481512100-10380-13-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 12/14] x86: intel-iommu: add
 dmar test
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

DMAR test is based on QEMU edu device. A 4B DMA memory copy is carried
out as the simplest DMAR test.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/pci.h             |   5 ++
 lib/x86/intel-iommu.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/x86/intel-iommu.h |   4 ++
 x86/Makefile.common   |   1 +
 x86/intel-iommu.c     |  51 +++++++++++++++++++
 5 files changed, 194 insertions(+)

diff --git a/lib/pci.h b/lib/pci.h
index d3052ef..26968b1 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -18,6 +18,9 @@ enum {
 #define PCI_BAR_NUM                     6
 #define PCI_DEVFN_MAX                   256
 
+#define PCI_BDF_GET_DEVFN(x)            ((x) & 0xff)
+#define PCI_BDF_GET_BUS(x)              (((x) >> 8) & 0xff)
+
 struct pci_dev {
 	uint16_t bdf;
 	phys_addr_t resource[PCI_BAR_NUM];
@@ -28,6 +31,8 @@ extern void pci_scan_bars(struct pci_dev *dev);
 extern void pci_cmd_set_clr(struct pci_dev *dev, uint16_t set, uint16_t clr);
 extern void pci_enable_defaults(struct pci_dev *dev);
 
+typedef phys_addr_t iova_t;
+
 extern bool pci_probe(void);
 extern void pci_print(void);
 extern bool pci_dev_exists(pcidevaddr_t dev);
diff --git a/lib/x86/intel-iommu.c b/lib/x86/intel-iommu.c
index 1887998..86b1805 100644
--- a/lib/x86/intel-iommu.c
+++ b/lib/x86/intel-iommu.c
@@ -11,6 +11,42 @@
  */
 
 #include "intel-iommu.h"
+#include "libcflat.h"
+
+/*
+ * VT-d in QEMU currently only support 39 bits address width, which is
+ * 3-level translation.
+ */
+#define VTD_PAGE_LEVEL      3
+#define VTD_CE_AW_39BIT     0x1
+
+typedef uint64_t vtd_pte_t;
+
+struct vtd_root_entry {
+	/* Quad 1 */
+	uint64_t present:1;
+	uint64_t __reserved:11;
+	uint64_t context_table_p:52;
+	/* Quad 2 */
+	uint64_t __reserved_2;
+} __attribute__ ((packed));
+typedef struct vtd_root_entry vtd_re_t;
+
+struct vtd_context_entry {
+	/* Quad 1 */
+	uint64_t present:1;
+	uint64_t disable_fault_report:1;
+	uint64_t trans_type:2;
+	uint64_t __reserved:8;
+	uint64_t slptptr:52;
+	/* Quad 2 */
+	uint64_t addr_width:3;
+	uint64_t __ignore:4;
+	uint64_t __reserved_2:1;
+	uint64_t domain_id:16;
+	uint64_t __reserved_3:40;
+} __attribute__ ((packed));
+typedef struct vtd_context_entry vtd_ce_t;
 
 #define VTD_RTA_MASK  (PAGE_MASK)
 #define VTD_IRTA_MASK (PAGE_MASK)
@@ -83,6 +119,103 @@ static void vtd_setup_ir_table(void)
 	printf("IR table address: 0x%016lx\n", vtd_ir_table());
 }
 
+static void vtd_install_pte(vtd_pte_t *root, iova_t iova,
+			    phys_addr_t pa, int level_target)
+{
+	int level;
+	unsigned int offset;
+	void *page;
+
+	for (level = VTD_PAGE_LEVEL; level > level_target; level--) {
+		offset = PGDIR_OFFSET(iova, level);
+		if (!(root[offset] & VTD_PTE_RW)) {
+			page = alloc_page();
+			memset(page, 0, PAGE_SIZE);
+			root[offset] = virt_to_phys(page) | VTD_PTE_RW;
+		}
+		root = (uint64_t *)(phys_to_virt(root[offset] &
+						 VTD_PTE_ADDR));
+	}
+
+	offset = PGDIR_OFFSET(iova, level);
+	root[offset] = pa | VTD_PTE_RW;
+	if (level != 1) {
+		/* This is huge page */
+		root[offset] |= VTD_PTE_HUGE;
+	}
+}
+
+#define  VTD_PHYS_TO_VIRT(x) \
+	((void *)(((uint64_t)phys_to_virt(x)) >> VTD_PAGE_SHIFT))
+
+/**
+ * vtd_map_range: setup IO address mapping for specific memory range
+ *
+ * @sid: source ID of the device to setup
+ * @iova: start IO virtual address
+ * @pa: start physical address
+ * @size: size of the mapping area
+ */
+void vtd_map_range(uint16_t sid, iova_t iova, phys_addr_t pa, size_t size)
+{
+	uint8_t bus_n, devfn;
+	void *slptptr;
+	vtd_ce_t *ce;
+	vtd_re_t *re = phys_to_virt(vtd_root_table());
+
+	assert(IS_ALIGNED(iova, SZ_4K));
+	assert(IS_ALIGNED(pa, SZ_4K));
+	assert(IS_ALIGNED(size, SZ_4K));
+
+	bus_n = PCI_BDF_GET_BUS(sid);
+	devfn = PCI_BDF_GET_DEVFN(sid);
+
+	/* Point to the correct root entry */
+	re += bus_n;
+
+	if (!re->present) {
+		ce = alloc_page();
+		memset(ce, 0, PAGE_SIZE);
+		memset(re, 0, sizeof(*re));
+		re->context_table_p = virt_to_phys(ce) >> VTD_PAGE_SHIFT;
+		re->present = 1;
+		printf("allocated vt-d root entry for PCI bus %d\n",
+		       bus_n);
+	} else
+		ce = VTD_PHYS_TO_VIRT(re->context_table_p);
+
+	/* Point to the correct context entry */
+	ce += devfn;
+
+	if (!ce->present) {
+		slptptr = alloc_page();
+		memset(slptptr, 0, PAGE_SIZE);
+		memset(ce, 0, sizeof(*ce));
+		/* To make it simple, domain ID is the same as SID */
+		ce->domain_id = sid;
+		/* We only test 39 bits width case (3-level paging) */
+		ce->addr_width = VTD_CE_AW_39BIT;
+		ce->slptptr = virt_to_phys(slptptr) >> VTD_PAGE_SHIFT;
+		ce->trans_type = VTD_CONTEXT_TT_MULTI_LEVEL;
+		ce->present = 1;
+		/* No error reporting yet */
+		ce->disable_fault_report = 1;
+		printf("allocated vt-d context entry for devfn 0x%x\n",
+		       devfn);
+	} else
+		slptptr = VTD_PHYS_TO_VIRT(ce->slptptr);
+
+	while (size) {
+		/* TODO: currently we only map 4K pages (level = 1) */
+		printf("map 4K page IOVA 0x%lx to 0x%lx (sid=0x%04x)\n",
+		       iova, pa, sid);
+		vtd_install_pte(slptptr, iova, pa, 1);
+		size -= VTD_PAGE_SIZE;
+		iova += VTD_PAGE_SIZE;
+		pa += VTD_PAGE_SIZE;
+	}
+}
+
 void vtd_init(void)
 {
 	setup_vm();
diff --git a/lib/x86/intel-iommu.h b/lib/x86/intel-iommu.h
index 92cc85f..50f67f1 100644
--- a/lib/x86/intel-iommu.h
+++ b/lib/x86/intel-iommu.h
@@ -20,9 +20,12 @@
 #include "isr.h"
 #include "smp.h"
 #include "desc.h"
+#include "pci.h"
 #include "asm/io.h"
 
 #define Q35_HOST_BRIDGE_IOMMU_ADDR  0xfed90000ULL
+#define VTD_PAGE_SHIFT              PAGE_SHIFT
+#define VTD_PAGE_SIZE               PAGE_SIZE
 
 /*
  * Intel IOMMU register specification
@@ -137,5 +140,6 @@ static inline uint64_t vtd_readq(unsigned int reg)
 }
 
 void vtd_init(void);
+void vtd_map_range(uint16_t sid, phys_addr_t iova, phys_addr_t pa, size_t size);
 
 #endif
diff --git a/x86/Makefile.common b/x86/Makefile.common
index 356d879..1dad18b 100644
--- a/x86/Makefile.common
+++ b/x86/Makefile.common
@@ -3,6 +3,7 @@
 all: test_cases
 
 cflatobjs += lib/pci.o
+cflatobjs += lib/pci-edu.o
 cflatobjs += lib/x86/io.o
 cflatobjs += lib/x86/smp.o
 cflatobjs += lib/x86/vm.o
diff --git a/x86/intel-iommu.c b/x86/intel-iommu.c
index f247913..21fd57f 100644
--- a/x86/intel-iommu.c
+++ b/x86/intel-iommu.c
@@ -11,9 +11,50 @@
  */
 
 #include "intel-iommu.h"
+#include "pci-edu.h"
+
+#define VTD_TEST_DMAR_4B ("DMAR 4B memcpy test")
+
+void vtd_test_dmar(struct pci_edu_dev *dev)
+{
+	void *page = alloc_page();
+
+#define DMA_TEST_WORD (0x12345678)
+	/* Modify the first 4 bytes of the page */
+	*(uint32_t *)page = DMA_TEST_WORD;
+
+	/*
+	 * Map the newly allocated page into IOVA address 0 (size 4K)
+	 * of the device address space. Root entry and context entry
+	 * will be automatically created when needed.
+	 */
+	vtd_map_range(dev->pci_dev.bdf, 0, virt_to_phys(page), PAGE_SIZE);
+
+	/*
+	 * DMA the first 4 bytes of the page to EDU device buffer
+	 * offset 0.
+	 */
+	edu_dma(dev, 0, 4, 0, false);
+
+	/*
+	 * DMA the first 4 bytes of EDU device buffer into the page
+	 * with offset 4 (so it'll be using 4-7 bytes).
+	 */
+	edu_dma(dev, 4, 4, 0, true);
+
+	/*
+	 * Check data match between 0-3 bytes and 4-7 bytes of the
+	 * page.
+	 */
+	report(VTD_TEST_DMAR_4B, *((uint32_t *)page + 1) == DMA_TEST_WORD);
+
+	free_page(page);
+}
 
 int main(int argc, char *argv[])
 {
+	struct pci_edu_dev dev;
+
 	vtd_init();
 
 	report("fault status check", vtd_readl(DMAR_FSTS_REG) == 0);
@@ -22,6 +63,16 @@ int main(int argc, char *argv[])
 	report("IR table setup", vtd_readl(DMAR_GSTS_REG) & VTD_GCMD_IR_TABLE);
 	report("DMAR enablement", vtd_readl(DMAR_GSTS_REG) & VTD_GCMD_DMAR);
 	report("IR enablement", vtd_readl(DMAR_GSTS_REG) & VTD_GCMD_IR);
+	report("DMAR support 39 bits address width",
+	       vtd_readq(DMAR_CAP_REG) & VTD_CAP_SAGAW);
+	report("DMAR support huge pages", vtd_readq(DMAR_CAP_REG) & VTD_CAP_SLLPS);
+
+	if (!edu_init(&dev)) {
+		printf("Please specify \"-device edu\" to do "
+		       "further IOMMU tests.\n");
+		report_skip(VTD_TEST_DMAR_4B);
+	} else
+		vtd_test_dmar(&dev);
 
 	return report_summary();
 }
-- 
2.7.4
