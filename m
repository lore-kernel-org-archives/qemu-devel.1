Received: from eggs.gnu.org ([2001:4830:134:3::10]:35989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0G-0008Cg-ET
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0D-0007cn-G6
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ezP0D-0007cY-Af
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:13 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Fri, 23 Mar 2018 18:52:59 +0300
Message-Id: <20180323155306.83812-2-marcel@redhat.com>
In-Reply-To: <20180323155306.83812-1-marcel@redhat.com>
References: <20180323155306.83812-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH PULL 1/8] hw/rdma: Add Query QP operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com, mst@redhat.com, marcel@redhat.com, f4bug@amsat.org, eblake@redhat.com, berrange@redhat.com, stefanha@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

This operation is needed by rdma devices - implement it.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/rdma/rdma_backend.c | 12 ++++++++++++
 hw/rdma/rdma_backend.h |  2 ++
 hw/rdma/rdma_rm.c      | 18 ++++++++++++++++++
 hw/rdma/rdma_rm.h      |  3 +++
 4 files changed, 35 insertions(+)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index e306fba534..0beed77c27 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -646,6 +646,18 @@ int rdma_backend_qp_state_rts(RdmaBackendQP *qp, uint8_t qp_type,
     return 0;
 }
 
+int rdma_backend_query_qp(RdmaBackendQP *qp, struct ibv_qp_attr *attr,
+                          int attr_mask, struct ibv_qp_init_attr *init_attr)
+{
+    if (!qp->ibqp) {
+        pr_dbg("QP1\n");
+        attr->qp_state = IBV_QPS_RTS;
+        return 0;
+    }
+
+    return ibv_query_qp(qp->ibqp, attr, attr_mask, init_attr);
+}
+
 void rdma_backend_destroy_qp(RdmaBackendQP *qp)
 {
     if (qp->ibqp) {
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 68f2b05ca7..36218d1990 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -83,6 +83,8 @@ int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
                               bool use_qkey);
 int rdma_backend_qp_state_rts(RdmaBackendQP *qp, uint8_t qp_type,
                               uint32_t sq_psn, uint32_t qkey, bool use_qkey);
+int rdma_backend_query_qp(RdmaBackendQP *qp, struct ibv_qp_attr *attr,
+                          int attr_mask, struct ibv_qp_init_attr *init_attr);
 void rdma_backend_destroy_qp(RdmaBackendQP *qp);
 
 void rdma_backend_post_send(RdmaBackendDev *backend_dev,
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index b5fc45ddab..43f73adecf 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -453,6 +453,24 @@ int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
     return 0;
 }
 
+int rdma_rm_query_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                     uint32_t qp_handle, struct ibv_qp_attr *attr,
+                     int attr_mask, struct ibv_qp_init_attr *init_attr)
+{
+    RdmaRmQP *qp;
+
+    pr_dbg("qpn=%d\n", qp_handle);
+
+    qp = rdma_rm_get_qp(dev_res, qp_handle);
+    if (!qp) {
+        return -EINVAL;
+    }
+
+    pr_dbg("qp_type=%d\n", qp->qp_type);
+
+    return rdma_backend_query_qp(&qp->backend_qp, attr, attr_mask, init_attr);
+}
+
 void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle)
 {
     RdmaRmQP *qp;
diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
index be95c1b0f4..0528c1972b 100644
--- a/hw/rdma/rdma_rm.h
+++ b/hw/rdma/rdma_rm.h
@@ -59,6 +59,9 @@ int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
                       union ibv_gid *dgid, uint32_t dqpn,
                       enum ibv_qp_state qp_state, uint32_t qkey,
                       uint32_t rq_psn, uint32_t sq_psn);
+int rdma_rm_query_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                     uint32_t qp_handle, struct ibv_qp_attr *attr,
+                     int attr_mask, struct ibv_qp_init_attr *init_attr);
 void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle);
 
 int rdma_rm_alloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t *cqe_ctx_id,
-- 
2.13.5
