Received: from eggs.gnu.org ([209.51.188.92]:48227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5p-0007Jq-2x
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5o-0000MP-1A
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gpC5n-0000M7-Oy
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:19 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 31 Jan 2019 15:08:49 +0200
Message-Id: <20190131130850.6850-10-yuval.shaia@oracle.com>
In-Reply-To: <20190131130850.6850-1-yuval.shaia@oracle.com>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 09/10] hw/rdma: Free all receive buffers when
 QP is destroyed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

When QP is destroyed the backend QP is destroyed as well. This ensures
we clean all received buffer we posted to it.
However, a contexts of these buffers are still remain in the device.
Fix it by maintaining a list of buffer's context and free them when QP
is destroyed.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c      | 25 +++++++++++++++++++------
 hw/rdma/rdma_backend.h      |  2 +-
 hw/rdma/rdma_backend_defs.h |  1 +
 hw/rdma/rdma_rm.c           |  2 +-
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 65b28aa5b2..3283461b15 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -39,6 +39,7 @@
 typedef struct BackendCtx {
     void *up_ctx;
     struct ibv_sge sge; /* Used to save MAD recv buffer */
+    RdmaBackendQP *backend_qp; /* To maintain recv buffers */
 } BackendCtx;
 
 struct backend_umad {
@@ -90,7 +91,8 @@ static void clean_recv_mads(RdmaBackendDev *backend_dev)
     } while (cqe_ctx_id != -ENOENT);
 }
 
-static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
+static int rdma_poll_cq(RdmaBackendDev *backend_dev,
+                        RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
 {
     int i, ne, total_ne = 0;
     BackendCtx *bctx;
@@ -113,6 +115,9 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
 
             comp_handler(bctx->up_ctx, &wc[i]);
 
+            bctx->backend_qp->cqe_ctx_list =
+                g_slist_remove(bctx->backend_qp->cqe_ctx_list,
+                               GINT_TO_POINTER(wc[i].wr_id));
             rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
             g_free(bctx);
         }
@@ -173,14 +178,12 @@ static void *comp_handler_thread(void *arg)
             }
 
             backend_dev->rdma_dev_res->stats.poll_cq_from_bk++;
-            rdma_poll_cq(backend_dev->rdma_dev_res, ev_cq);
+            rdma_poll_cq(backend_dev, backend_dev->rdma_dev_res, ev_cq);
 
             ibv_ack_cq_events(ev_cq, 1);
         }
     }
 
-    /* TODO: Post cqe for all remaining buffs that were posted */
-
     backend_dev->comp_thread.is_running = false;
 
     qemu_thread_exit(0);
@@ -307,7 +310,7 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
 int rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq)
 {
     rdma_dev_res->stats.poll_cq_from_guest++;
-    return rdma_poll_cq(rdma_dev_res, cq->ibcq);
+    return rdma_poll_cq(cq->backend_dev, rdma_dev_res, cq->ibcq);
 }
 
 static GHashTable *ah_hash;
@@ -494,6 +497,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
 
     bctx = g_malloc0(sizeof(*bctx));
     bctx->up_ctx = ctx;
+    bctx->backend_qp = qp;
 
     rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
@@ -501,6 +505,9 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
         goto err_free_bctx;
     }
 
+    qp->cqe_ctx_list = g_slist_append(qp->cqe_ctx_list,
+                                      GINT_TO_POINTER(bctx_id));
+
     rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.tx_len);
     if (rc) {
@@ -608,6 +615,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
 
     bctx = g_malloc0(sizeof(*bctx));
     bctx->up_ctx = ctx;
+    bctx->backend_qp = qp;
 
     rc = rdma_rm_alloc_cqe_ctx(rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
@@ -615,6 +623,9 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
         goto err_free_bctx;
     }
 
+    qp->cqe_ctx_list = g_slist_append(qp->cqe_ctx_list,
+                                      GINT_TO_POINTER(bctx_id));
+
     rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.rx_bufs_len);
     if (rc) {
@@ -910,11 +921,13 @@ int rdma_backend_query_qp(RdmaBackendQP *qp, struct ibv_qp_attr *attr,
     return ibv_query_qp(qp->ibqp, attr, attr_mask, init_attr);
 }
 
-void rdma_backend_destroy_qp(RdmaBackendQP *qp)
+void rdma_backend_destroy_qp(RdmaBackendQP *qp, RdmaDeviceResources *dev_res)
 {
     if (qp->ibqp) {
         ibv_destroy_qp(qp->ibqp);
     }
+    g_slist_foreach(qp->cqe_ctx_list, free_cqe_ctx, dev_res);
+    g_slist_free(qp->cqe_ctx_list);
 }
 
 #define CHK_ATTR(req, dev, member, fmt) ({ \
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 6abc367a52..798a12f28f 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -103,7 +103,7 @@ int rdma_backend_qp_state_rts(RdmaBackendQP *qp, uint8_t qp_type,
                               uint32_t sq_psn, uint32_t qkey, bool use_qkey);
 int rdma_backend_query_qp(RdmaBackendQP *qp, struct ibv_qp_attr *attr,
                           int attr_mask, struct ibv_qp_init_attr *init_attr);
-void rdma_backend_destroy_qp(RdmaBackendQP *qp);
+void rdma_backend_destroy_qp(RdmaBackendQP *qp, RdmaDeviceResources *dev_res);
 
 void rdma_backend_post_send(RdmaBackendDev *backend_dev,
                             RdmaBackendQP *qp, uint8_t qp_type,
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
index bec0457f25..2306bbd18e 100644
--- a/hw/rdma/rdma_backend_defs.h
+++ b/hw/rdma/rdma_backend_defs.h
@@ -66,6 +66,7 @@ typedef struct RdmaBackendQP {
     struct ibv_pd *ibpd;
     struct ibv_qp *ibqp;
     uint8_t sgid_idx;
+    GSList *cqe_ctx_list;
 } RdmaBackendQP;
 
 #endif
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index ff536e356b..c7b9ef17f8 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -485,7 +485,7 @@ void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle)
         return;
     }
 
-    rdma_backend_destroy_qp(&qp->backend_qp);
+    rdma_backend_destroy_qp(&qp->backend_qp, dev_res);
 
     rdma_res_tbl_dealloc(&dev_res->qp_tbl, qp->qpn);
 }
-- 
2.17.2
