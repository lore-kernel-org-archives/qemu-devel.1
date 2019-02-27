Received: from eggs.gnu.org ([209.51.188.92]:37227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1gyv0W-0007KO-Tj
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1gyv0W-0007fn-1E
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:56:04 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kamalheib1@gmail.com>)
	id 1gyv0V-0007bH-88
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:56:03 -0500
Received: by mail-wm1-x344.google.com with SMTP id q187so4982896wme.5
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 00:55:58 -0800 (PST)
From: Kamal Heib <kamalheib1@gmail.com>
Date: Wed, 27 Feb 2019 10:55:46 +0200
Message-Id: <20190227085546.23690-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/rdma: Fix the error prints in
 create_qp_rings()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Yuval Shaia <yuval.shaia@oracle.com>, Kamal Heib <kamalheib1@gmail.com>

The prints should indicate that we are talking about QP and not CQ.

Fixes: 98d176f8e592 ("hw/rdma: PVRDMA commands and data-path ops")
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 hw/rdma/vmw/pvrdma_cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 21a55e225a61..8bc24e952073 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -374,13 +374,13 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
 
     dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
     if (!dir) {
-        rdma_error_report("Failed to map to CQ page directory");
+        rdma_error_report("Failed to map to QP page directory");
         goto out;
     }
 
     tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
     if (!tbl) {
-        rdma_error_report("Failed to map to CQ page table");
+        rdma_error_report("Failed to map to QP page table");
         goto out;
     }
 
@@ -393,7 +393,7 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
     sr->ring_state = (struct pvrdma_ring *)
         rdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
     if (!sr->ring_state) {
-        rdma_error_report("Failed to map to CQ ring state");
+        rdma_error_report("Failed to map to QP ring state");
         goto out_free_sr_mem;
     }
 
-- 
2.20.1
