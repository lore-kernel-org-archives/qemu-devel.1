Received: from eggs.gnu.org ([2001:4830:134:3::10]:35732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHJ-0007Z5-Hk
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHG-0003Cl-3y
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gJeHB-0002UE-BD
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:43 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon,  5 Nov 2018 14:45:45 +0200
Message-Id: <20181105124559.21561-5-yuval.shaia@oracle.com>
In-Reply-To: <20181105124559.21561-1-yuval.shaia@oracle.com>
References: <20181105124559.21561-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 04/18] hw/rdma: Abort send-op if fail to create
 addr handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, shamir.rabinovitch@oracle.com, qemu-devel@nongnu.org

Function create_ah might return NULL, let's exit with an error.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index d7a4bbd91f..1e148398a2 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -338,6 +338,10 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     if (qp_type == IBV_QPT_UD) {
         wr.wr.ud.ah = create_ah(backend_dev, qp->ibpd,
                                 backend_dev->backend_gid_idx, dgid);
+        if (!wr.wr.ud.ah) {
+            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
+            goto out_dealloc_cqe_ctx;
+        }
         wr.wr.ud.remote_qpn = dqpn;
         wr.wr.ud.remote_qkey = dqkey;
     }
-- 
2.17.2
