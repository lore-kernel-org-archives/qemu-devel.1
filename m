Received: from eggs.gnu.org ([2001:4830:134:3::10]:41839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwN-0006Zh-Nd
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwM-0006ke-NW
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:27 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadwM-0006h6-Hf
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:26 -0500
Received: by mail-wm1-x330.google.com with SMTP id c126so7866321wmh.0
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:51:22 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:34 +0200
Message-Id: <20181222095036.29743-30-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 29/31] pvrdma: release ring object in case
 of an error
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

create_cq and create_qp routines allocate ring object, but it's
not released in case of an error, leading to memory leakage.

Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_cmd.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index f236ac4795..89920887bf 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -313,6 +313,14 @@ out:
     return rc;
 }
 
+static void destroy_cq_ring(PvrdmaRing *ring)
+{
+    pvrdma_ring_free(ring);
+    /* ring_state was in slot 1, not 0 so need to jump back */
+    rdma_pci_dma_unmap(ring->dev, --ring->ring_state, TARGET_PAGE_SIZE);
+    g_free(ring);
+}
+
 static int create_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
                      union pvrdma_cmd_resp *rsp)
 {
@@ -335,6 +343,10 @@ static int create_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
 
     rc = rdma_rm_alloc_cq(&dev->rdma_dev_res, &dev->backend_dev, cmd->cqe,
                           &resp->cq_handle, ring);
+    if (rc) {
+        destroy_cq_ring(ring);
+    }
+
     resp->cqe = cmd->cqe;
 
     return rc;
@@ -356,10 +368,7 @@ static int destroy_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
     }
 
     ring = (PvrdmaRing *)cq->opaque;
-    pvrdma_ring_free(ring);
-    /* ring_state was in slot 1, not 0 so need to jump back */
-    rdma_pci_dma_unmap(PCI_DEVICE(dev), --ring->ring_state, TARGET_PAGE_SIZE);
-    g_free(ring);
+    destroy_cq_ring(ring);
 
     rdma_rm_dealloc_cq(&dev->rdma_dev_res, cmd->cq_handle);
 
@@ -457,6 +466,17 @@ out:
     return rc;
 }
 
+static void destroy_qp_rings(PvrdmaRing *ring)
+{
+    pr_dbg("sring=%p\n", &ring[0]);
+    pvrdma_ring_free(&ring[0]);
+    pr_dbg("rring=%p\n", &ring[1]);
+    pvrdma_ring_free(&ring[1]);
+
+    rdma_pci_dma_unmap(ring->dev, ring->ring_state, TARGET_PAGE_SIZE);
+    g_free(ring);
+}
+
 static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
                      union pvrdma_cmd_resp *rsp)
 {
@@ -486,6 +506,7 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
                           cmd->max_recv_sge, cmd->recv_cq_handle, rings,
                           &resp->qpn);
     if (rc) {
+        destroy_qp_rings(rings);
         return rc;
     }
 
@@ -558,13 +579,7 @@ static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
     rdma_rm_dealloc_qp(&dev->rdma_dev_res, cmd->qp_handle);
 
     ring = (PvrdmaRing *)qp->opaque;
-    pr_dbg("sring=%p\n", &ring[0]);
-    pvrdma_ring_free(&ring[0]);
-    pr_dbg("rring=%p\n", &ring[1]);
-    pvrdma_ring_free(&ring[1]);
-
-    rdma_pci_dma_unmap(PCI_DEVICE(dev), ring->ring_state, TARGET_PAGE_SIZE);
-    g_free(ring);
+    destroy_qp_rings(ring);
 
     return 0;
 }
-- 
2.17.1
