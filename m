Received: from eggs.gnu.org ([209.51.188.92]:51944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1ghKKg-0001t0-71
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1ghKKf-00046I-Eu
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:20:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1ghKKf-00041N-5p
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:20:09 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Wed,  9 Jan 2019 22:19:56 +0200
Message-Id: <20190109201956.3982-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH] hw/rdma: Delete unused struct member
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

This member is used only in init_device_caps function, make it local.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c      | 26 ++++++++++++++------------
 hw/rdma/rdma_backend_defs.h |  1 -
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 16dca69ee9..b49edaacaf 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -917,23 +917,25 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp)
 static int init_device_caps(RdmaBackendDev *backend_dev,
                             struct ibv_device_attr *dev_attr)
 {
-    if (ibv_query_device(backend_dev->context, &backend_dev->dev_attr)) {
+    struct ibv_device_attr bk_dev_attr;
+
+    if (ibv_query_device(backend_dev->context, &bk_dev_attr)) {
         return -EIO;
     }
 
     dev_attr->max_sge = MAX_SGE;
 
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_mr_size, "%" PRId64);
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_sge, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_wr, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_cq, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_cqe, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_mr, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_pd, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_rd_atom, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_init_rd_atom, "%d");
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_ah, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_mr_size, "%" PRId64);
+    CHK_ATTR(dev_attr, bk_dev_attr, max_qp, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_sge, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_qp_wr, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_cq, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_cqe, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_mr, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_pd, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_qp_rd_atom, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_qp_init_rd_atom, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_ah, "%d");
 
     return 0;
 }
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
index 1e5c3dd3bf..15ae8b970e 100644
--- a/hw/rdma/rdma_backend_defs.h
+++ b/hw/rdma/rdma_backend_defs.h
@@ -41,7 +41,6 @@ typedef struct RdmaCmMux {
 } RdmaCmMux;
 
 typedef struct RdmaBackendDev {
-    struct ibv_device_attr dev_attr;
     RdmaBackendThread comp_thread;
     PCIDevice *dev;
     RdmaDeviceResources *rdma_dev_res;
-- 
2.17.2
