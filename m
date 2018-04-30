Received: from eggs.gnu.org ([2001:4830:134:3::10]:48755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzq-0003lH-BO
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzp-0005uV-IE
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:02:02 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fDEzp-0005th-CA
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:02:01 -0400
Received: by mail-wr0-x242.google.com with SMTP id p18-v6so9135316wrm.1
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 13:02:01 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Mon, 30 Apr 2018 23:02:21 +0300
Message-Id: <20180430200223.4119-6-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
References: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH 5/7] hw/rdma: Fix possible out of bounds access
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
Cc: marcel.apfelbaum@gmail.com, yuval.shaia@oracle.com, peter.maydell@linaro.org

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
