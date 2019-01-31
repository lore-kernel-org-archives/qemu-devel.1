Received: from eggs.gnu.org ([209.51.188.92]:48244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5r-0007MM-Dj
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5q-0000N6-FE
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:32998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gpC5q-0000Mz-6X
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:22 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 31 Jan 2019 15:08:50 +0200
Message-Id: <20190131130850.6850-11-yuval.shaia@oracle.com>
In-Reply-To: <20190131130850.6850-1-yuval.shaia@oracle.com>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 10/10] hw/pvrdma: Delete unneeded function
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

The function argument rdma_dev_res is not needed as it is stored in the
backend_dev object at init.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c      | 13 ++++++-------
 hw/rdma/rdma_backend.h      |  1 -
 hw/rdma/vmw/pvrdma_qp_ops.c |  3 +--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 3283461b15..544b7d6148 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -586,7 +586,6 @@ static unsigned int save_mad_recv_buffer(RdmaBackendDev *backend_dev,
 }
 
 void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
-                            RdmaDeviceResources *rdma_dev_res,
                             RdmaBackendQP *qp, uint8_t qp_type,
                             struct ibv_sge *sge, uint32_t num_sge, void *ctx)
 {
@@ -605,9 +604,9 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
             rc = save_mad_recv_buffer(backend_dev, sge, num_sge, ctx);
             if (rc) {
                 complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
-                rdma_dev_res->stats.mad_rx_bufs_err++;
+                backend_dev->rdma_dev_res->stats.mad_rx_bufs_err++;
             } else {
-                rdma_dev_res->stats.mad_rx_bufs++;
+                backend_dev->rdma_dev_res->stats.mad_rx_bufs++;
             }
         }
         return;
@@ -617,7 +616,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
     bctx->up_ctx = ctx;
     bctx->backend_qp = qp;
 
-    rc = rdma_rm_alloc_cqe_ctx(rdma_dev_res, &bctx_id, bctx);
+    rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
         complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
         goto err_free_bctx;
@@ -626,7 +625,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
     qp->cqe_ctx_list = g_slist_append(qp->cqe_ctx_list,
                                       GINT_TO_POINTER(bctx_id));
 
-    rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge,
+    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.rx_bufs_len);
     if (rc) {
         complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
@@ -644,13 +643,13 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
         goto err_dealloc_cqe_ctx;
     }
 
-    rdma_dev_res->stats.rx_bufs++;
+    backend_dev->rdma_dev_res->stats.rx_bufs++;
 
     return;
 
 err_dealloc_cqe_ctx:
     backend_dev->rdma_dev_res->stats.rx_bufs_err++;
-    rdma_rm_dealloc_cqe_ctx(rdma_dev_res, bctx_id);
+    rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, bctx_id);
 
 err_free_bctx:
     g_free(bctx);
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 798a12f28f..160b9e74db 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -112,7 +112,6 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
                             union ibv_gid *dgid, uint32_t dqpn, uint32_t dqkey,
                             void *ctx);
 void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
-                            RdmaDeviceResources *rdma_dev_res,
                             RdmaBackendQP *qp, uint8_t qp_type,
                             struct ibv_sge *sge, uint32_t num_sge, void *ctx);
 
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 5d650a4943..4ec1dacfd1 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -241,8 +241,7 @@ void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
         }
 
         atomic_inc(&cq->missing_cqe);
-        rdma_backend_post_recv(&dev->backend_dev, &dev->rdma_dev_res,
-                               &qp->backend_qp, qp->qp_type,
+        rdma_backend_post_recv(&dev->backend_dev, &qp->backend_qp, qp->qp_type,
                                (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
                                comp_ctx);
 
-- 
2.17.2
