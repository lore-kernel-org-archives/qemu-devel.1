Received: from eggs.gnu.org ([2001:4830:134:3::10]:34864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvI-0005ga-AA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvE-00026X-N9
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYxvE-00025V-Dq
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:20 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 20:45:25 +0200
Message-Id: <20181217184540.4571-9-yuval.shaia@oracle.com>
In-Reply-To: <20181217184540.4571-1-yuval.shaia@oracle.com>
References: <20181217184540.4571-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v8 08/23] hw/pvrdma: Set the correct opcode for
 recv completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

The function pvrdma_post_cqe populates CQE entry with opcode from the
given completion element. For receive operation value was not set. Fix
it by setting it to IBV_WC_RECV.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
