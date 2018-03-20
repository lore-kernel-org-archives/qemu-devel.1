Received: from eggs.gnu.org ([2001:4830:134:3::10]:48356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eyMV4-0004Mf-MX
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 15:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eyMV1-0005Ey-A9
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 15:00:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1eyMV1-0005En-1A
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 15:00:43 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Tue, 20 Mar 2018 21:00:23 +0200
Message-Id: <20180320190023.24077-3-yuval.shaia@oracle.com>
In-Reply-To: <20180320190023.24077-1-yuval.shaia@oracle.com>
References: <20180320190023.24077-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v1 2/2] hw/rdma: Add support for Query QP verb
 to pvrdma device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel@redhat.com, qemu-devel@nongnu.org

This IB verb is needed by some applications - implement it.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/vmw/pvrdma_cmd.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

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
