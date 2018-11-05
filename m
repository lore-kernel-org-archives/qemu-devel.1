Received: from eggs.gnu.org ([2001:4830:134:3::10]:35602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHD-0007T0-7y
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeGu-0002VY-UV
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gJeGu-0002Nk-AD
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:24 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon,  5 Nov 2018 14:45:43 +0200
Message-Id: <20181105124559.21561-3-yuval.shaia@oracle.com>
In-Reply-To: <20181105124559.21561-1-yuval.shaia@oracle.com>
References: <20181105124559.21561-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 02/18] hw/rdma: Add ability to force
 notification without re-arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, shamir.rabinovitch@oracle.com, qemu-devel@nongnu.org

Upon completion of incoming packet the device pushes CQE to driver's RX
ring and notify the driver (msix).
While for data-path incoming packets the driver needs the ability to
control whether it wished to receive interrupts or not, for control-path
packets such as incoming MAD the driver needs to be notified anyway, it
even do not need to re-arm the notification bit.

Enhance the notification field to support this.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_rm.c           | 12 ++++++++++--
 hw/rdma/rdma_rm_defs.h      |  8 +++++++-
 hw/rdma/vmw/pvrdma_qp_ops.c |  6 ++++--
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 8d59a42cd1..4f10fcabcc 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -263,7 +263,7 @@ int rdma_rm_alloc_cq(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
     }
 
     cq->opaque = opaque;
-    cq->notify = false;
+    cq->notify = CNT_CLEAR;
 
     rc = rdma_backend_create_cq(backend_dev, &cq->backend_cq, cqe);
     if (rc) {
@@ -291,7 +291,10 @@ void rdma_rm_req_notify_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle,
         return;
     }
 
-    cq->notify = notify;
+    if (cq->notify != CNT_SET) {
+        cq->notify = notify ? CNT_ARM : CNT_CLEAR;
+    }
+
     pr_dbg("notify=%d\n", cq->notify);
 }
 
@@ -349,6 +352,11 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
         return -EINVAL;
     }
 
+    if (qp_type == IBV_QPT_GSI) {
+        scq->notify = CNT_SET;
+        rcq->notify = CNT_SET;
+    }
+
     qp = res_tbl_alloc(&dev_res->qp_tbl, &rm_qpn);
     if (!qp) {
         return -ENOMEM;
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 7228151239..9b399063d3 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -49,10 +49,16 @@ typedef struct RdmaRmPD {
     uint32_t ctx_handle;
 } RdmaRmPD;
 
+typedef enum CQNotificationType {
+    CNT_CLEAR,
+    CNT_ARM,
+    CNT_SET,
+} CQNotificationType;
+
 typedef struct RdmaRmCQ {
     RdmaBackendCQ backend_cq;
     void *opaque;
-    bool notify;
+    CQNotificationType notify;
 } RdmaRmCQ;
 
 /* MR (DMA region) */
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index c668afd0ed..762700a205 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -89,8 +89,10 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
     pvrdma_ring_write_inc(&dev->dsr_info.cq);
 
     pr_dbg("cq->notify=%d\n", cq->notify);
-    if (cq->notify) {
-        cq->notify = false;
+    if (cq->notify != CNT_CLEAR) {
+        if (cq->notify == CNT_ARM) {
+            cq->notify = CNT_CLEAR;
+        }
         post_interrupt(dev, INTR_VEC_CMD_COMPLETION_Q);
     }
 
-- 
2.17.2
