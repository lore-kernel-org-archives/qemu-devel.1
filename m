Received: from eggs.gnu.org ([2001:4830:134:3::10]:35835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHM-0007cA-1Q
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHI-0003J5-DD
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gJeHI-00033B-2P
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:48 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon,  5 Nov 2018 14:45:49 +0200
Message-Id: <20181105124559.21561-9-yuval.shaia@oracle.com>
In-Reply-To: <20181105124559.21561-1-yuval.shaia@oracle.com>
References: <20181105124559.21561-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 08/18] hw/pvrdma: Set the correct opcode for
 recv completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, shamir.rabinovitch@oracle.com, qemu-devel@nongnu.org

The function pvrdma_post_cqe populates CQE entry with opcode from the
given completion element. For receive operation value was not set. Fix
it by setting it to IBV_WC_RECV.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/vmw/pvrdma_qp_ops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 762700a205..7b0f440fda 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -196,8 +196,9 @@ int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
         comp_ctx = g_malloc(sizeof(CompHandlerCtx));
         comp_ctx->dev = dev;
         comp_ctx->cq_handle = qp->recv_cq_handle;
-        comp_ctx->cqe.qp = qp_handle;
         comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
+        comp_ctx->cqe.qp = qp_handle;
+        comp_ctx->cqe.opcode = IBV_WC_RECV;
 
         rdma_backend_post_recv(&dev->backend_dev, &dev->rdma_dev_res,
                                &qp->backend_qp, qp->qp_type,
-- 
2.17.2
