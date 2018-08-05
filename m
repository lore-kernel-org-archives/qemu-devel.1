Received: from eggs.gnu.org ([2001:4830:134:3::10]:39757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fmL4c-00071n-Mv
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fmL4X-0006NU-QI
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fmL4X-0006N0-HI
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:35:57 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun,  5 Aug 2018 18:35:07 +0300
Message-Id: <20180805153518.2983-3-yuval.shaia@oracle.com>
In-Reply-To: <20180805153518.2983-1-yuval.shaia@oracle.com>
References: <20180805153518.2983-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v2 02/13] hw/pvrdma: Bugfix - provide the
 correct attr_mask to query_qp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com

Calling rdma_rm_query_qp with attr_mask equals to -1 leads to error
where backend query_qp fails to retrieve the needed QP attributes.
Fix it by providing the attr_mask we got from driver.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_cmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 14255d609f..e7d6589cdc 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -524,6 +524,7 @@ static int query_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct ibv_qp_init_attr init_attr;
 
     pr_dbg("qp_handle=%d\n", cmd->qp_handle);
+    pr_dbg("attr_mask=0x%x\n", cmd->attr_mask);
 
     memset(rsp, 0, sizeof(*rsp));
     rsp->hdr.response = cmd->hdr.response;
@@ -531,8 +532,8 @@ static int query_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
 
     rsp->hdr.err = rdma_rm_query_qp(&dev->rdma_dev_res, &dev->backend_dev,
                                     cmd->qp_handle,
-                                    (struct ibv_qp_attr *)&resp->attrs, -1,
-                                    &init_attr);
+                                    (struct ibv_qp_attr *)&resp->attrs,
+                                    cmd->attr_mask, &init_attr);
 
     pr_dbg("ret=%d\n", rsp->hdr.err);
     return rsp->hdr.err;
-- 
2.17.1
