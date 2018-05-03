Received: from eggs.gnu.org ([2001:4830:134:3::10]:53292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqb-00028D-PV
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqa-0008JJ-Pb
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:53 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fEIqa-0008Iu-Iz
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:52 -0400
Received: by mail-wm0-x243.google.com with SMTP id f6so431202wmc.4
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:20:52 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu,  3 May 2018 21:21:22 +0300
Message-Id: <20180503182125.20310-6-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
References: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PULL 5/8] hw/rdma: Fix possible out of bounds access
 to regs array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel.apfelbaum@gmail.com, yuval.shaia@oracle.com, peter.maydell@linaro.org, f4bug@amsat.org

From: Yuval Shaia <yuval.shaia@oracle.com>

Coverity (CID1390589, CID1390608).
Array size is RDMA_BAR1_REGS_SIZE, let's make sure the given address is
in range.

While there also:
1. Adjust the size of this bar to reasonable size
2. Report the size of the array with sizeof(array)

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20180430200223.4119-6-marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma.h      | 6 +++---
 hw/rdma/vmw/pvrdma_main.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index 8c173cb824..0b46dc5a9b 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -31,7 +31,7 @@
 #define RDMA_REG_BAR_IDX     1
 #define RDMA_UAR_BAR_IDX     2
 #define RDMA_BAR0_MSIX_SIZE  (16 * 1024)
-#define RDMA_BAR1_REGS_SIZE  256
+#define RDMA_BAR1_REGS_SIZE  64
 #define RDMA_BAR2_UAR_SIZE   (0x1000 * MAX_UCS) /* each uc gets page */
 
 /* MSIX */
@@ -86,7 +86,7 @@ static inline int get_reg_val(PVRDMADev *dev, hwaddr addr, uint32_t *val)
 {
     int idx = addr >> 2;
 
-    if (idx > RDMA_BAR1_REGS_SIZE) {
+    if (idx >= RDMA_BAR1_REGS_SIZE) {
         return -EINVAL;
     }
 
@@ -99,7 +99,7 @@ static inline int set_reg_val(PVRDMADev *dev, hwaddr addr, uint32_t val)
 {
     int idx = addr >> 2;
 
-    if (idx > RDMA_BAR1_REGS_SIZE) {
+    if (idx >= RDMA_BAR1_REGS_SIZE) {
         return -EINVAL;
     }
 
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 994220b58e..3ed7409763 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -449,14 +449,14 @@ static void init_bars(PCIDevice *pdev)
     /* BAR 1 - Registers */
     memset(&dev->regs_data, 0, sizeof(dev->regs_data));
     memory_region_init_io(&dev->regs, OBJECT(dev), &regs_ops, dev,
-                          "pvrdma-regs", RDMA_BAR1_REGS_SIZE);
+                          "pvrdma-regs", sizeof(dev->regs_data));
     pci_register_bar(pdev, RDMA_REG_BAR_IDX, PCI_BASE_ADDRESS_SPACE_MEMORY,
                      &dev->regs);
 
     /* BAR 2 - UAR */
     memset(&dev->uar_data, 0, sizeof(dev->uar_data));
     memory_region_init_io(&dev->uar, OBJECT(dev), &uar_ops, dev, "rdma-uar",
-                          RDMA_BAR2_UAR_SIZE);
+                          sizeof(dev->uar_data));
     pci_register_bar(pdev, RDMA_UAR_BAR_IDX, PCI_BASE_ADDRESS_SPACE_MEMORY,
                      &dev->uar);
 }
-- 
2.14.3
