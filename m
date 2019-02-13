Received: from eggs.gnu.org ([209.51.188.92]:33309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gtodS-0003Ky-FF
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gtoRA-000477-1K
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:54:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gtoR8-000421-44
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:54:26 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Wed, 13 Feb 2019 08:53:54 +0200
Message-Id: <20190213065357.16076-8-yuval.shaia@oracle.com>
In-Reply-To: <20190213065357.16076-1-yuval.shaia@oracle.com>
References: <20190213065357.16076-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v2 6/9] hw/rdma: Free all receive buffers when
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
 hw/rdma/rdma_backend.c      | 26 ++++++++++++++++++++------
 hw/rdma/rdma_backend.h      |  2 +-
 hw/rdma/rdma_backend_defs.h |  2 +-
 hw/rdma/rdma_rm.c           |  2 +-
 hw/rdma/rdma_utils.c        | 29 +++++++++++++++++++++++++++++
 hw/rdma/rdma_utils.h        | 11 +++++++++++
 6 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index e8ee205b5f..83a68057a7 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -39,6 +39,7 @@
 typedef struct BackendCtx {
     void *up_ctx;
     struct ibv_sge sge; /* Used to save MAD recv buffer */
+    RdmaBackendQP *backend_qp; /* To maintain recv buffers */
 } BackendCtx;
 
 struct backend_umad {
@@ -73,6 +74,7 @@ static void free_cqe_ctx(gpointer data, gpointer user_data)
     bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, cqe_ctx_id);
     if (bctx) {
         rdma_rm_dealloc_cqe_ctx(rdma_dev_res, cqe_ctx_id);
+        atomic_dec(&rdma_dev_res->stats.missing_cqe);
     }
     g_free(bctx);
 }
@@ -85,13 +87,15 @@ static void clean_recv_mads(RdmaBackendDev *backend_dev)
         cqe_ctx_id = rdma_protected_qlist_pop_int64(&backend_dev->
                                                     recv_mads_list);
         if (cqe_ctx_id != -ENOENT) {
+            atomic_inc(&backend_dev->rdma_dev_res->stats.missing_cqe);
             free_cqe_ctx(GINT_TO_POINTER(cqe_ctx_id),
                          backend_dev->rdma_dev_res);
         }
     } while (cqe_ctx_id != -ENOENT);
 }
 
-static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
+static int rdma_poll_cq(RdmaBackendDev *backend_dev,
+                        RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
 {
     int i, ne, total_ne = 0;
     BackendCtx *bctx;
@@ -113,6 +117,8 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
 
             comp_handler(bctx->up_ctx, &wc[i]);
 
+            rdma_protected_gslist_remove_int32(&bctx->backend_qp->cqe_ctx_list,
+                                               wc[i].wr_id);
             rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
             g_free(bctx);
         }
@@ -175,14 +181,12 @@ static void *comp_handler_thread(void *arg)
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
@@ -311,7 +315,7 @@ void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq)
     int polled;
 
     rdma_dev_res->stats.poll_cq_from_guest++;
-    polled = rdma_poll_cq(rdma_dev_res, cq->ibcq);
+    polled = rdma_poll_cq(cq->backend_dev, rdma_dev_res, cq->ibcq);
     if (!polled) {
         rdma_dev_res->stats.poll_cq_from_guest_empty++;
     }
@@ -501,6 +505,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
 
     bctx = g_malloc0(sizeof(*bctx));
     bctx->up_ctx = ctx;
+    bctx->backend_qp = qp;
 
     rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
@@ -508,6 +513,8 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
         goto err_free_bctx;
     }
 
+    rdma_protected_gslist_append_int32(&qp->cqe_ctx_list, bctx_id);
+
     rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.tx_len);
     if (rc) {
@@ -616,6 +623,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
 
     bctx = g_malloc0(sizeof(*bctx));
     bctx->up_ctx = ctx;
+    bctx->backend_qp = qp;
 
     rc = rdma_rm_alloc_cqe_ctx(rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
@@ -623,6 +631,8 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
         goto err_free_bctx;
     }
 
+    rdma_protected_gslist_append_int32(&qp->cqe_ctx_list, bctx_id);
+
     rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.rx_bufs_len);
     if (rc) {
@@ -762,6 +772,8 @@ int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
         return -EIO;
     }
 
+    rdma_protected_gslist_init(&qp->cqe_ctx_list);
+
     qp->ibpd = pd->ibpd;
 
     /* TODO: Query QP to get max_inline_data and save it to be used in send */
@@ -919,11 +931,13 @@ int rdma_backend_query_qp(RdmaBackendQP *qp, struct ibv_qp_attr *attr,
     return ibv_query_qp(qp->ibqp, attr, attr_mask, init_attr);
 }
 
-void rdma_backend_destroy_qp(RdmaBackendQP *qp)
+void rdma_backend_destroy_qp(RdmaBackendQP *qp, RdmaDeviceResources *dev_res)
 {
     if (qp->ibqp) {
         ibv_destroy_qp(qp->ibqp);
     }
+    g_slist_foreach(qp->cqe_ctx_list.list, free_cqe_ctx, dev_res);
+    rdma_protected_gslist_destroy(&qp->cqe_ctx_list);
 }
 
 #define CHK_ATTR(req, dev, member, fmt) ({ \
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 5114c90e67..cb5efa2a3a 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -102,7 +102,7 @@ int rdma_backend_qp_state_rts(RdmaBackendQP *qp, uint8_t qp_type,
                               uint32_t sq_psn, uint32_t qkey, bool use_qkey);
 int rdma_backend_query_qp(RdmaBackendQP *qp, struct ibv_qp_attr *attr,
                           int attr_mask, struct ibv_qp_init_attr *init_attr);
-void rdma_backend_destroy_qp(RdmaBackendQP *qp);
+void rdma_backend_destroy_qp(RdmaBackendQP *qp, RdmaDeviceResources *dev_res);
 
 void rdma_backend_post_send(RdmaBackendDev *backend_dev,
                             RdmaBackendQP *qp, uint8_t qp_type,
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
index a8c15b09ab..817153dc8c 100644
--- a/hw/rdma/rdma_backend_defs.h
+++ b/hw/rdma/rdma_backend_defs.h
@@ -26,7 +26,6 @@ typedef struct RdmaDeviceResources RdmaDeviceResources;
 
 typedef struct RdmaBackendThread {
     QemuThread thread;
-    QemuMutex mutex;
     bool run; /* Set by thread manager to let thread know it should exit */
     bool is_running; /* Set by the thread to report its status */
 } RdmaBackendThread;
@@ -66,6 +65,7 @@ typedef struct RdmaBackendQP {
     struct ibv_pd *ibpd;
     struct ibv_qp *ibqp;
     uint8_t sgid_idx;
+    RdmaProtectedGSList cqe_ctx_list;
 } RdmaBackendQP;
 
 #endif
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index d0f5dd0744..3475f67da5 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -484,7 +484,7 @@ void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle)
         return;
     }
 
-    rdma_backend_destroy_qp(&qp->backend_qp);
+    rdma_backend_destroy_qp(&qp->backend_qp, dev_res);
 
     rdma_res_tbl_dealloc(&dev_res->qp_tbl, qp->qpn);
 }
diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
index 672a09079a..5cf993d2e7 100644
--- a/hw/rdma/rdma_utils.c
+++ b/hw/rdma/rdma_utils.c
@@ -94,3 +94,32 @@ int64_t rdma_protected_qlist_pop_int64(RdmaProtectedQList *list)
 
     return qnum_get_uint(qobject_to(QNum, obj));
 }
+
+void rdma_protected_gslist_init(RdmaProtectedGSList *list)
+{
+    qemu_mutex_init(&list->lock);
+}
+
+void rdma_protected_gslist_destroy(RdmaProtectedGSList *list)
+{
+    if (list->list) {
+        g_slist_free(list->list);
+        list->list = NULL;
+    }
+}
+
+void rdma_protected_gslist_append_int32(RdmaProtectedGSList *list,
+                                        int32_t value)
+{
+    qemu_mutex_lock(&list->lock);
+    list->list = g_slist_prepend(list->list, GINT_TO_POINTER(value));
+    qemu_mutex_unlock(&list->lock);
+}
+
+void rdma_protected_gslist_remove_int32(RdmaProtectedGSList *list,
+                                        int32_t value)
+{
+    qemu_mutex_lock(&list->lock);
+    list->list = g_slist_remove(list->list, GINT_TO_POINTER(value));
+    qemu_mutex_unlock(&list->lock);
+}
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
index a8bf1d4fec..2d42249691 100644
--- a/hw/rdma/rdma_utils.h
+++ b/hw/rdma/rdma_utils.h
@@ -34,12 +34,23 @@ typedef struct RdmaProtectedQList {
     QList *list;
 } RdmaProtectedQList;
 
+typedef struct RdmaProtectedGSList {
+    QemuMutex lock;
+    GSList *list;
+} RdmaProtectedGSList;
+
 void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen);
 void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);
 void rdma_protected_qlist_init(RdmaProtectedQList *list);
 void rdma_protected_qlist_destroy(RdmaProtectedQList *list);
 void rdma_protected_qlist_append_int64(RdmaProtectedQList *list, int64_t value);
 int64_t rdma_protected_qlist_pop_int64(RdmaProtectedQList *list);
+void rdma_protected_gslist_init(RdmaProtectedGSList *list);
+void rdma_protected_gslist_destroy(RdmaProtectedGSList *list);
+void rdma_protected_gslist_append_int32(RdmaProtectedGSList *list,
+                                        int32_t value);
+void rdma_protected_gslist_remove_int32(RdmaProtectedGSList *list,
+                                        int32_t value);
 
 static inline void addrconf_addr_eui48(uint8_t *eui, const char *addr)
 {
-- 
2.17.2
