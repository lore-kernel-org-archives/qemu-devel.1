Received: from eggs.gnu.org ([2001:4830:134:3::10]:34916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvP-0005kq-KM
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvM-0002Cn-6Q
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYxvL-0002Bp-Nk
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:28 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 20:45:26 +0200
Message-Id: <20181217184540.4571-10-yuval.shaia@oracle.com>
In-Reply-To: <20181217184540.4571-1-yuval.shaia@oracle.com>
References: <20181217184540.4571-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v8 09/23] hw/pvrdma: Set the correct opcode for
 send completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

opcode for WC should be set by the device and not taken from work
element.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_qp_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 7b0f440fda..3388be1926 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -154,7 +154,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
         comp_ctx->cq_handle = qp->send_cq_handle;
         comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
         comp_ctx->cqe.qp = qp_handle;
-        comp_ctx->cqe.opcode = wqe->hdr.opcode;
+        comp_ctx->cqe.opcode = IBV_WC_SEND;
 
         rdma_backend_post_send(&dev->backend_dev, &qp->backend_qp, qp->qp_type,
                                (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
-- 
2.17.2
