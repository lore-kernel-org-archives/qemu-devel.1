Received: from eggs.gnu.org ([2001:4830:134:3::10]:49576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eyMZH-0007Il-Kk
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 15:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eyMZE-000707-AF
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 15:05:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1eyMZE-0006zC-1K
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 15:05:04 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Tue, 20 Mar 2018 20:45:01 +0200
Message-Id: <20180320184501.23447-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH] hw/rdma: Implementation of Query QP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c   | 12 ++++++++++++
 hw/rdma/rdma_backend.h   |  2 ++
 hw/rdma/rdma_rm.c        | 18 ++++++++++++++++++
 hw/rdma/rdma_rm.h        |  3 +++
 hw/rdma/vmw/pvrdma_cmd.c | 24 +++++++++++++++++++++++-
 5 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index ae7589c190..da2c8671e5 100644
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
index 07f6fed768..6d9b45efe8 100644
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
index 296e40518e..a4e1de31fd 100644
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
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 293dfed29f..cf8c50af31 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -515,6 +515,28 @@ static int modify_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
     return rsp->hdr.err;
 }
 
+static int query_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                     union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_query_qp *cmd = &req->query_qp;
+    struct pvrdma_cmd_query_qp_resp *resp = &rsp->query_qp_resp;
+    struct ibv_qp_init_attr init_attr;
+
+    pr_dbg("qp_handle=%d\n", cmd->qp_handle);
+
+    memset(rsp, 0, sizeof(*rsp));
+    rsp->hdr.response = cmd->hdr.response;
+    rsp->hdr.ack = PVRDMA_CMD_QUERY_QP_RESP;
+
+    rsp->hdr.err = rdma_rm_query_qp(&dev->rdma_dev_res, &dev->backend_dev,
+                                    cmd->qp_handle,
+                                    (struct ibv_qp_attr *)&resp->attrs, -1,
+                                    &init_attr);
+
+    pr_dbg("ret=%d\n", rsp->hdr.err);
+    return rsp->hdr.err;
+}
+
 static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
                       union pvrdma_cmd_resp *rsp)
 {
@@ -636,7 +658,7 @@ static struct cmd_handler cmd_handlers[] = {
     {PVRDMA_CMD_DESTROY_CQ, destroy_cq},
     {PVRDMA_CMD_CREATE_QP, create_qp},
     {PVRDMA_CMD_MODIFY_QP, modify_qp},
-    {PVRDMA_CMD_QUERY_QP, NULL},
+    {PVRDMA_CMD_QUERY_QP, query_qp},
     {PVRDMA_CMD_DESTROY_QP, destroy_qp},
     {PVRDMA_CMD_CREATE_UC, create_uc},
     {PVRDMA_CMD_DESTROY_UC, destroy_uc},
-- 
2.13.6
