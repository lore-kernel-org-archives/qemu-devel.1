Received: from eggs.gnu.org ([2001:4830:134:3::10]:41848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwN-0006Zn-Ts
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwN-0006l4-2V
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:27 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadwM-0006g9-RZ
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:26 -0500
Received: by mail-wr1-x442.google.com with SMTP id 96so7530930wrb.2
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:51:20 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:33 +0200
Message-Id: <20181222095036.29743-29-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 28/31] pvrdma: check number of pages when
 creating rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, pjp@fedoraproject.org

From: Prasad J Pandit <pjp@fedoraproject.org>

When creating CQ/QP rings, an object can have up to
PVRDMA_MAX_FAST_REG_PAGES 8 pages. Check 'npages' parameter
to avoid excessive memory allocation or a null dereference.

Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_cmd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 3b94545761..f236ac4795 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -259,6 +259,11 @@ static int create_cq_ring(PCIDevice *pci_dev , PvrdmaRing **ring,
     int rc = -EINVAL;
     char ring_name[MAX_RING_NAME_SZ];
 
+    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES) {
+        pr_dbg("invalid nchunks: %d\n", nchunks);
+        return rc;
+    }
+
     pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
     dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
     if (!dir) {
@@ -372,6 +377,12 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
     char ring_name[MAX_RING_NAME_SZ];
     uint32_t wqe_sz;
 
+    if (!spages || spages > PVRDMA_MAX_FAST_REG_PAGES
+        || !rpages || rpages > PVRDMA_MAX_FAST_REG_PAGES) {
+        pr_dbg("invalid pages: %d, %d\n", spages, rpages);
+        return rc;
+    }
+
     pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
     dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
     if (!dir) {
-- 
2.17.1
