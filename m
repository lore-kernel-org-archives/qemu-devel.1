Received: from eggs.gnu.org ([2001:4830:134:3::10]:35022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvc-0005wM-6e
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvY-0002O9-S1
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYxvY-0002NU-Gs
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:40 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 20:45:33 +0200
Message-Id: <20181217184540.4571-17-yuval.shaia@oracle.com>
In-Reply-To: <20181217184540.4571-1-yuval.shaia@oracle.com>
References: <20181217184540.4571-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v8 16/23] hw/pvrdma: Fill all CQE fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

Add ability to pass specific WC attributes to CQE such as GRH_BIT flag.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c      | 59 +++++++++++++++++++++++--------------
 hw/rdma/rdma_backend.h      |  4 +--
 hw/rdma/vmw/pvrdma_qp_ops.c | 31 +++++++++++--------
 3 files changed, 58 insertions(+), 36 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 1d496bbd95..ae1e4dcb29 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -60,13 +60,24 @@ struct backend_umad {
     char mad[RDMA_MAX_PRIVATE_DATA];
 };
 
-static void (*comp_handler)(int status, unsigned int vendor_err, void *ctx);
+static void (*comp_handler)(void *ctx, struct ibv_wc *wc);
 
-static void dummy_comp_handler(int status, unsigned int vendor_err, void *ctx)
+static void dummy_comp_handler(void *ctx, struct ibv_wc *wc)
 {
     pr_err("No completion handler is registered\n");
 }
 
+static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
+                                 void *ctx)
+{
+    struct ibv_wc wc = {0};
+
+    wc.status = status;
+    wc.vendor_err = vendor_err;
+
+    comp_handler(ctx, &wc);
+}
+
 static void poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
 {
     int i, ne;
@@ -91,7 +102,7 @@ static void poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
             }
             pr_dbg("Processing %s CQE\n", bctx->is_tx_req ? "send" : "recv");
 
-            comp_handler(wc[i].status, wc[i].vendor_err, bctx->up_ctx);
+            comp_handler(bctx->up_ctx, &wc[i]);
 
             rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
             g_free(bctx);
@@ -256,8 +267,8 @@ static void start_comp_thread(RdmaBackendDev *backend_dev)
                        comp_handler_thread, backend_dev, QEMU_THREAD_DETACHED);
 }
 
-void rdma_backend_register_comp_handler(void (*handler)(int status,
-                                        unsigned int vendor_err, void *ctx))
+void rdma_backend_register_comp_handler(void (*handler)(void *ctx,
+                                                         struct ibv_wc *wc))
 {
     comp_handler = handler;
 }
@@ -451,14 +462,14 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     if (!qp->ibqp) { /* This field does not get initialized for QP0 and QP1 */
         if (qp_type == IBV_QPT_SMI) {
             pr_dbg("QP0 unsupported\n");
-            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
+            complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
         } else if (qp_type == IBV_QPT_GSI) {
             pr_dbg("QP1\n");
             rc = mad_send(backend_dev, sgid_idx, sgid, sge, num_sge);
             if (rc) {
-                comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
+                complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
             } else {
-                comp_handler(IBV_WC_SUCCESS, 0, ctx);
+                complete_work(IBV_WC_SUCCESS, 0, ctx);
             }
         }
         return;
@@ -467,7 +478,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     pr_dbg("num_sge=%d\n", num_sge);
     if (!num_sge) {
         pr_dbg("num_sge=0\n");
-        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
         return;
     }
 
@@ -478,21 +489,21 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
         pr_dbg("Failed to allocate cqe_ctx\n");
-        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
         goto out_free_bctx;
     }
 
     rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge);
     if (rc) {
         pr_dbg("Error: Failed to build host SGE array\n");
-        comp_handler(IBV_WC_GENERAL_ERR, rc, ctx);
+        complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
         goto out_dealloc_cqe_ctx;
     }
 
     if (qp_type == IBV_QPT_UD) {
         wr.wr.ud.ah = create_ah(backend_dev, qp->ibpd, sgid_idx, dgid);
         if (!wr.wr.ud.ah) {
-            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
+            complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
             goto out_dealloc_cqe_ctx;
         }
         wr.wr.ud.remote_qpn = dqpn;
@@ -510,7 +521,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     if (rc) {
         pr_dbg("Fail (%d, %d) to post send WQE to qpn %d\n", rc, errno,
                 qp->ibqp->qp_num);
-        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
         goto out_dealloc_cqe_ctx;
     }
 
@@ -579,13 +590,13 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
     if (!qp->ibqp) { /* This field does not get initialized for QP0 and QP1 */
         if (qp_type == IBV_QPT_SMI) {
             pr_dbg("QP0 unsupported\n");
-            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
+            complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
         }
         if (qp_type == IBV_QPT_GSI) {
             pr_dbg("QP1\n");
             rc = save_mad_recv_buffer(backend_dev, sge, num_sge, ctx);
             if (rc) {
-                comp_handler(IBV_WC_GENERAL_ERR, rc, ctx);
+                complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
             }
         }
         return;
@@ -594,7 +605,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
     pr_dbg("num_sge=%d\n", num_sge);
     if (!num_sge) {
         pr_dbg("num_sge=0\n");
-        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
         return;
     }
 
@@ -605,14 +616,14 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
     rc = rdma_rm_alloc_cqe_ctx(rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
         pr_dbg("Failed to allocate cqe_ctx\n");
-        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
         goto out_free_bctx;
     }
 
     rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge);
     if (rc) {
         pr_dbg("Error: Failed to build host SGE array\n");
-        comp_handler(IBV_WC_GENERAL_ERR, rc, ctx);
+        complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
         goto out_dealloc_cqe_ctx;
     }
 
@@ -624,7 +635,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
     if (rc) {
         pr_dbg("Fail (%d, %d) to post recv WQE to qpn %d\n", rc, errno,
                 qp->ibqp->qp_num);
-        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
         goto out_dealloc_cqe_ctx;
     }
 
@@ -998,9 +1009,10 @@ static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
     mad = rdma_pci_dma_map(backend_dev->dev, bctx->sge.addr,
                            bctx->sge.length);
     if (!mad || bctx->sge.length < msg->umad_len + MAD_HDR_SIZE) {
-        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_MAD_BUFF,
-                     bctx->up_ctx);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_MAD_BUFF,
+                      bctx->up_ctx);
     } else {
+        struct ibv_wc wc = {0};
         pr_dbg_buf("mad", msg->umad.mad, msg->umad_len);
         memset(mad, 0, bctx->sge.length);
         build_mad_hdr((struct ibv_grh *)mad,
@@ -1009,7 +1021,10 @@ static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
         memcpy(&mad[MAD_HDR_SIZE], msg->umad.mad, msg->umad_len);
         rdma_pci_dma_unmap(backend_dev->dev, mad, bctx->sge.length);
 
-        comp_handler(IBV_WC_SUCCESS, 0, bctx->up_ctx);
+        wc.byte_len = msg->umad_len;
+        wc.status = IBV_WC_SUCCESS;
+        wc.wc_flags = IBV_WC_GRH;
+        comp_handler(bctx->up_ctx, &wc);
     }
 
     g_free(bctx);
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 59ad2b874b..8cae40f827 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -57,8 +57,8 @@ int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,
                                union ibv_gid *gid);
 void rdma_backend_start(RdmaBackendDev *backend_dev);
 void rdma_backend_stop(RdmaBackendDev *backend_dev);
-void rdma_backend_register_comp_handler(void (*handler)(int status,
-                                        unsigned int vendor_err, void *ctx));
+void rdma_backend_register_comp_handler(void (*handler)(void *ctx,
+                                                        struct ibv_wc *wc));
 void rdma_backend_unregister_comp_handler(void);
 
 int rdma_backend_query_port(RdmaBackendDev *backend_dev,
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 2130824098..300471a4c9 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -47,7 +47,7 @@ typedef struct PvrdmaRqWqe {
  * 3. Interrupt host
  */
 static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
-                           struct pvrdma_cqe *cqe)
+                           struct pvrdma_cqe *cqe, struct ibv_wc *wc)
 {
     struct pvrdma_cqe *cqe1;
     struct pvrdma_cqne *cqne;
@@ -66,6 +66,7 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
     pr_dbg("Writing CQE\n");
     cqe1 = pvrdma_ring_next_elem_write(ring);
     if (unlikely(!cqe1)) {
+        pr_dbg("No CQEs in ring\n");
         return -EINVAL;
     }
 
@@ -73,8 +74,20 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
     cqe1->wr_id = cqe->wr_id;
     cqe1->qp = cqe->qp;
     cqe1->opcode = cqe->opcode;
-    cqe1->status = cqe->status;
-    cqe1->vendor_err = cqe->vendor_err;
+    cqe1->status = wc->status;
+    cqe1->byte_len = wc->byte_len;
+    cqe1->src_qp = wc->src_qp;
+    cqe1->wc_flags = wc->wc_flags;
+    cqe1->vendor_err = wc->vendor_err;
+
+    pr_dbg("wr_id=%" PRIx64 "\n", cqe1->wr_id);
+    pr_dbg("qp=0x%lx\n", cqe1->qp);
+    pr_dbg("opcode=%d\n", cqe1->opcode);
+    pr_dbg("status=%d\n", cqe1->status);
+    pr_dbg("byte_len=%d\n", cqe1->byte_len);
+    pr_dbg("src_qp=%d\n", cqe1->src_qp);
+    pr_dbg("wc_flags=%d\n", cqe1->wc_flags);
+    pr_dbg("vendor_err=%d\n", cqe1->vendor_err);
 
     pvrdma_ring_write_inc(ring);
 
@@ -99,18 +112,12 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
     return 0;
 }
 
-static void pvrdma_qp_ops_comp_handler(int status, unsigned int vendor_err,
-                                       void *ctx)
+static void pvrdma_qp_ops_comp_handler(void *ctx, struct ibv_wc *wc)
 {
     CompHandlerCtx *comp_ctx = (CompHandlerCtx *)ctx;
 
-    pr_dbg("cq_handle=%d\n", comp_ctx->cq_handle);
-    pr_dbg("wr_id=%" PRIx64 "\n", comp_ctx->cqe.wr_id);
-    pr_dbg("status=%d\n", status);
-    pr_dbg("vendor_err=0x%x\n", vendor_err);
-    comp_ctx->cqe.status = status;
-    comp_ctx->cqe.vendor_err = vendor_err;
-    pvrdma_post_cqe(comp_ctx->dev, comp_ctx->cq_handle, &comp_ctx->cqe);
+    pvrdma_post_cqe(comp_ctx->dev, comp_ctx->cq_handle, &comp_ctx->cqe, wc);
+
     g_free(ctx);
 }
 
-- 
2.17.2
