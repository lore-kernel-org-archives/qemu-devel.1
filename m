Received: from eggs.gnu.org ([2001:4830:134:3::10]:34493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMszK-0008Ud-Q1
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMszJ-0008LR-Ux
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cMszJ-0008Kv-P5
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:33 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 30 Dec 2016 16:55:57 +0800
Message-Id: <1483088160-6714-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1483088160-6714-1-git-send-email-peterx@redhat.com>
References: <1483088160-6714-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 5/8] intel-iommu: add report
 prefixes
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 x86/intel-iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/x86/intel-iommu.c b/x86/intel-iommu.c
index 753f90e..59171a1 100644
--- a/x86/intel-iommu.c
+++ b/x86/intel-iommu.c
@@ -21,6 +21,8 @@ void vtd_test_dmar(struct pci_edu_dev *dev)
 {
 	void *page = alloc_page();
 
+	report_prefix_push("vtd_dmar");
+
 #define DMA_TEST_WORD (0x12345678)
 	/* Modify the first 4 bytes of the page */
 	*(uint32_t *)page = DMA_TEST_WORD;
@@ -51,6 +53,8 @@ void vtd_test_dmar(struct pci_edu_dev *dev)
 	report(VTD_TEST_DMAR_4B, *((uint32_t *)page + 1) == DMA_TEST_WORD);
 
 	free_page(page);
+
+	report_prefix_pop();
 }
 
 static volatile bool edu_intr_recved;
@@ -64,6 +68,8 @@ static void edu_isr(isr_regs_t *regs)
 static void vtd_test_ir(struct pci_edu_dev *dev)
 {
 #define VTD_TEST_VECTOR (0xee)
+	report_prefix_push("vtd_ir");
+
 	/*
 	 * Setup EDU PCI device MSI, using interrupt remapping. By
 	 * default, EDU device is using INTx.
@@ -88,6 +94,8 @@ static void vtd_test_ir(struct pci_edu_dev *dev)
 
 	/* We are good as long as we reach here */
 	report(VTD_TEST_IR_MSI, true);
+
+	report_prefix_pop();
 }
 
 int main(int argc, char *argv[])
@@ -96,6 +104,8 @@ int main(int argc, char *argv[])
 
 	vtd_init();
 
+	report_prefix_push("vtd_init");
+
 	report("fault status check", vtd_readl(DMAR_FSTS_REG) == 0);
 	report("QI enablement", vtd_readl(DMAR_GSTS_REG) & VTD_GCMD_QI);
 	report("DMAR table setup", vtd_readl(DMAR_GSTS_REG) & VTD_GCMD_ROOT);
@@ -106,6 +116,8 @@ int main(int argc, char *argv[])
 	       vtd_readq(DMAR_CAP_REG) & VTD_CAP_SAGAW);
 	report("DMAR support huge pages", vtd_readq(DMAR_CAP_REG) & VTD_CAP_SLLPS);
 
+	report_prefix_pop();
+
 	if (!edu_init(&dev)) {
 		printf("Please specify \"-device edu\" to do "
 		       "further IOMMU tests.\n");
-- 
2.7.4
