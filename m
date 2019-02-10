Received: from eggs.gnu.org ([209.51.188.92]:51368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gsmdB-0008Ui-70
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 05:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gsmd6-0007P3-0i
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 05:46:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gsmd4-0007NL-1J
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 05:46:31 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun, 10 Feb 2019 12:45:34 +0200
Message-Id: <20190210104537.1488-7-yuval.shaia@oracle.com>
In-Reply-To: <20190210104537.1488-1-yuval.shaia@oracle.com>
References: <20190210104537.1488-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v1 6/9] hw/rdma: Free all receive buffers when
 QP is destroyed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org, eblake@redhat.com
Cc: Yuval Shaia <yuval.shaia@oracle.com>

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
 hw/rdma/rdma_utils.c        | 27 +++++++++++++++++++++++++++
 hw/rdma/rdma_utils.h        |  9 +++++++++
 6 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index c51e7cac59..11cc13596a 100644
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
@@ -84,13 +86,15 @@ static void clean_recv_mads(RdmaBackendDev *backend_dev)
     do {
         cqe_ctx_id = rdma_locked_list_pop_int64(&backend_dev->recv_mads_list);
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
@@ -112,6 +116,8 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
 
             comp_handler(bctx->up_ctx, &wc[i]);
 
+            rdma_locked_glist_remove_int32(&bctx->backend_qp->cqe_ctx_list,
+                                           wc[i].wr_id);
             rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
             g_free(bctx);
         }
@@ -174,14 +180,12 @@ static void *comp_handler_thread(void *arg)
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
@@ -310,7 +314,7 @@ void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq)
     int polled;
 
     rdma_dev_res->stats.poll_cq_from_guest++;
-    polled = rdma_poll_cq(rdma_dev_res, cq->ibcq);
+    polled = rdma_poll_cq(cq->backend_dev, rdma_dev_res, cq->ibcq);
     if (!polled) {
         rdma_dev_res->stats.poll_cq_from_guest_empty++;
     }
@@ -500,6 +504,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
 
     bctx = g_malloc0(sizeof(*bctx));
     bctx->up_ctx = ctx;
+    bctx->backend_qp = qp;
 
     rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
@@ -507,6 +512,8 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
         goto err_free_bctx;
     }
 
+    rdma_locked_glist_append_int32(&qp->cqe_ctx_list, bctx_id);
+
     rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.tx_len);
     if (rc) {
@@ -615,6 +622,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
 
     bctx = g_malloc0(sizeof(*bctx));
     bctx->up_ctx = ctx;
+    bctx->backend_qp = qp;
 
     rc = rdma_rm_alloc_cqe_ctx(rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
@@ -622,6 +630,8 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
         goto err_free_bctx;
     }
 
+    rdma_locked_glist_append_int32(&qp->cqe_ctx_list, bctx_id);
+
     rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.rx_bufs_len);
     if (rc) {
@@ -761,6 +771,8 @@ int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
         return -EIO;
     }
 
+    rdma_locked_glist_init(&qp->cqe_ctx_list);
+
     qp->ibpd = pd->ibpd;
 
     /* TODO: Query QP to get max_inline_data and save it to be used in send */
@@ -918,11 +930,13 @@ int rdma_backend_query_qp(RdmaBackendQP *qp, struct ibv_qp_attr *attr,
     return ibv_query_qp(qp->ibqp, attr, attr_mask, init_attr);
 }
 
-void rdma_backend_destroy_qp(RdmaBackendQP *qp)
+void rdma_backend_destroy_qp(RdmaBackendQP *qp, RdmaDeviceResources *dev_res)
 {
     if (qp->ibqp) {
         ibv_destroy_qp(qp->ibqp);
     }
+    g_slist_foreach(qp->cqe_ctx_list.list, free_cqe_ctx, dev_res);
+    rdma_locked_glist_destroy(&qp->cqe_ctx_list);
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
index bec0457f25..d57640103c 100644
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
+    LockedGSList cqe_ctx_list;
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
index a2a4ea2a15..5172a77fba 100644
--- a/hw/rdma/rdma_utils.c
+++ b/hw/rdma/rdma_utils.c
@@ -94,3 +94,30 @@ int64_t rdma_locked_list_pop_int64(LockedList *list)
 
     return qnum_get_uint(qobject_to(QNum, obj));
 }
+
+void rdma_locked_glist_init(LockedGSList *list)
+{
+    qemu_mutex_init(&list->lock);
+}
+
+void rdma_locked_glist_destroy(LockedGSList *list)
+{
+    if (list->list) {
+        g_slist_free(list->list);
+        list->list = NULL;
+    }
+}
+
+void rdma_locked_glist_append_int32(LockedGSList *list, int32_t value)
+{
+    qemu_mutex_lock(&list->lock);
+    list->list = g_slist_prepend(list->list, GINT_TO_POINTER(value));
+    qemu_mutex_unlock(&list->lock);
+}
+
+void rdma_locked_glist_remove_int32(LockedGSList *list, int32_t value)
+{
+    qemu_mutex_lock(&list->lock);
+    list->list = g_slist_remove(list->list, GINT_TO_POINTER(value));
+    qemu_mutex_unlock(&list->lock);
+}
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
index 4ba9956f81..d5d4909bb3 100644
--- a/hw/rdma/rdma_utils.h
+++ b/hw/rdma/rdma_utils.h
@@ -34,12 +34,21 @@ typedef struct LockedList {
     QList *list;
 } LockedList;
 
+typedef struct LockedGSList {
+    QemuMutex lock;
+    GSList *list;
+} LockedGSList;
+
 void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen);
 void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);
 void rdma_locked_list_init(LockedList *list);
 void rdma_locked_list_destroy(LockedList *list);
 void rdma_locked_list_append_int64(LockedList *list, int64_t value);
 int64_t rdma_locked_list_pop_int64(LockedList *list);
+void rdma_locked_glist_init(LockedGSList *list);
+void rdma_locked_glist_destroy(LockedGSList *list);
+void rdma_locked_glist_append_int32(LockedGSList *list, int32_t value);
+void rdma_locked_glist_remove_int32(LockedGSList *list, int32_t value);
 
 static inline void addrconf_addr_eui48(uint8_t *eui, const char *addr)
 {
-- 
2.17.2
