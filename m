Received: from eggs.gnu.org ([2001:4830:134:3::10]:55311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGz4-0002wE-GR
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGz2-0003PY-BC
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGz2-0003PO-2g
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:56 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:15 +0800
Message-Id: <1481512100-10380-10-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 09/14] pci: provide
 pci_scan_bars()
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

Let's provide a more general way to scan PCI bars, rather than read the
config registers every time.

Then let x86/vmexit.c leverage pci_scan_bars()

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/pci-host-generic.c |  2 +-
 lib/pci.c              | 17 ++++++++++++++++-
 lib/pci.h              |  5 +++++
 x86/vmexit.c           | 17 ++++++-----------
 4 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/lib/pci-host-generic.c b/lib/pci-host-generic.c
index 958ef70..b1d2fc5 100644
--- a/lib/pci-host-generic.c
+++ b/lib/pci-host-generic.c
@@ -235,7 +235,7 @@ bool pci_probe(void)
 
 		cmd = PCI_COMMAND_SERR | PCI_COMMAND_PARITY;
 
-		for (i = 0; i < 6; i++) {
+		for (i = 0; i < PCI_BAR_NUM; i++) {
 			u64 addr;
 
 			if (pci_alloc_resource(&pci_dev, i, &addr)) {
diff --git a/lib/pci.c b/lib/pci.c
index 8f2356d..d4521be 100644
--- a/lib/pci.c
+++ b/lib/pci.c
@@ -207,7 +207,7 @@ static void pci_dev_print(pcidevaddr_t dev)
 	if ((header & PCI_HEADER_TYPE_MASK) != PCI_HEADER_TYPE_NORMAL)
 		return;
 
-	for (i = 0; i < 6; i++) {
+	for (i = 0; i < PCI_BAR_NUM; i++) {
 		if (pci_bar_size(&pci_dev, i)) {
 			printf("\t");
 			pci_bar_print(&pci_dev, i);
@@ -227,3 +227,18 @@ void pci_print(void)
 			pci_dev_print(dev);
 	}
 }
+
+void pci_scan_bars(struct pci_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < PCI_BAR_NUM; i++) {
+		if (!pci_bar_is_valid(dev, i))
+			continue;
+		dev->resource[i] = pci_bar_get_addr(dev, i);
+		if (pci_bar_is64(dev, i)) {
+			i++;
+			dev->resource[i] = (phys_addr_t)0;
+		}
+	}
+}
diff --git a/lib/pci.h b/lib/pci.h
index 355acd0..8215c9d 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -15,13 +15,16 @@ enum {
 	PCIDEVADDR_INVALID = 0xffff,
 };
 
+#define PCI_BAR_NUM                     6
 #define PCI_DEVFN_MAX                   256
 
 struct pci_dev {
 	uint16_t bdf;
+	phys_addr_t resource[PCI_BAR_NUM];
 };
 
 extern void pci_dev_init(struct pci_dev *dev, pcidevaddr_t bdf);
+extern void pci_scan_bars(struct pci_dev *dev);
 
 extern bool pci_probe(void);
 extern void pci_print(void);
@@ -65,6 +68,8 @@ extern int pci_testdev(void);
  * pci-testdev supports at least three types of tests (via mmio and
  * portio BARs): no-eventfd, wildcard-eventfd and datamatch-eventfd
  */
+#define PCI_TESTDEV_BAR_MEM		0
+#define PCI_TESTDEV_BAR_IO		1
 #define PCI_TESTDEV_NUM_BARS		2
 #define PCI_TESTDEV_NUM_TESTS		3
 
diff --git a/x86/vmexit.c b/x86/vmexit.c
index 63fa070..f9a22de 100644
--- a/x86/vmexit.c
+++ b/x86/vmexit.c
@@ -389,17 +389,12 @@ int main(int ac, char **av)
 	ret = pci_find_dev(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_TEST);
 	if (ret != PCIDEVADDR_INVALID) {
 		pci_dev_init(&pcidev, ret);
-		for (i = 0; i < PCI_TESTDEV_NUM_BARS; i++) {
-			if (!pci_bar_is_valid(&pcidev, i)) {
-				continue;
-			}
-			if (pci_bar_is_memory(&pcidev, i)) {
-				membar = pci_bar_get_addr(&pcidev, i);
-				pci_test.memaddr = ioremap(membar, PAGE_SIZE);
-			} else {
-				pci_test.iobar = pci_bar_get_addr(&pcidev, i);
-			}
-		}
+		pci_scan_bars(&pcidev);
+		assert(pci_bar_is_memory(&pcidev, PCI_TESTDEV_BAR_MEM));
+		assert(!pci_bar_is_memory(&pcidev, PCI_TESTDEV_BAR_IO));
+		membar = pcidev.resource[PCI_TESTDEV_BAR_MEM];
+		pci_test.memaddr = ioremap(membar, PAGE_SIZE);
+		pci_test.iobar = pcidev.resource[PCI_TESTDEV_BAR_IO];
 		printf("pci-testdev at 0x%x membar %lx iobar %x\n",
 		       pcidev.bdf, membar, pci_test.iobar);
 	}
-- 
2.7.4
