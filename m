Received: from eggs.gnu.org ([209.51.188.92]:43984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyw-00021H-01
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyu-0002Ju-8w
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hMuyu-0002J1-08
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id h15so5611098wrb.2
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 06:45:35 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat,  4 May 2019 16:45:26 +0300
Message-Id: <20190504134529.4755-2-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
References: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 1/4] hw/rdma: Add SRQ support to backend
 layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com

From: Kamal Heib <kamalheib1@gmail.com>

Add the required functions and definitions to support shared receive
queues (SRQs) in the backend layer.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Message-Id: <20190403113343.26384-2-kamalheib1@gmail.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c      | 116 +++++++++++++++++++++++++++++++++++-
 hw/rdma/rdma_backend.h      |  12 ++++
 hw/rdma/rdma_backend_defs.h |   5 ++
 hw/rdma/rdma_rm.c           |   2 +
 hw/rdma/rdma_rm_defs.h      |   1 +
 5 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index d1660b6474..04dfd63a57 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -40,6 +40,7 @@ typedef struct BackendCtx {
     void *up_ctx;
     struct ibv_sge sge; /* Used to save MAD recv buffer */
     RdmaBackendQP *backend_qp; /* To maintain recv buffers */
+    RdmaBackendSRQ *backend_srq;
 } BackendCtx;
 
 struct backend_umad {
@@ -99,6 +100,7 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
     int i, ne, total_ne = 0;
     BackendCtx *bctx;
     struct ibv_wc wc[2];
+    RdmaProtectedGSList *cqe_ctx_list;
 
     qemu_mutex_lock(&rdma_dev_res->lock);
     do {
@@ -116,8 +118,13 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
 
             comp_handler(bctx->up_ctx, &wc[i]);
 
-            rdma_protected_gslist_remove_int32(&bctx->backend_qp->cqe_ctx_list,
-                                               wc[i].wr_id);
+            if (bctx->backend_qp) {
+                cqe_ctx_list = &bctx->backend_qp->cqe_ctx_list;
+            } else {
+                cqe_ctx_list = &bctx->backend_srq->cqe_ctx_list;
+            }
+
+            rdma_protected_gslist_remove_int32(cqe_ctx_list, wc[i].wr_id);
             rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
             g_free(bctx);
         }
@@ -662,6 +669,60 @@ err_free_bctx:
     g_free(bctx);
 }
 
+void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
+                                RdmaBackendSRQ *srq, struct ibv_sge *sge,
+                                uint32_t num_sge, void *ctx)
+{
+    BackendCtx *bctx;
+    struct ibv_sge new_sge[MAX_SGE];
+    uint32_t bctx_id;
+    int rc;
+    struct ibv_recv_wr wr = {}, *bad_wr;
+
+    bctx = g_malloc0(sizeof(*bctx));
+    bctx->up_ctx = ctx;
+    bctx->backend_srq = srq;
+
+    rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
+    if (unlikely(rc)) {
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        goto err_free_bctx;
+    }
+
+    rdma_protected_gslist_append_int32(&srq->cqe_ctx_list, bctx_id);
+
+    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
+                              &backend_dev->rdma_dev_res->stats.rx_bufs_len);
+    if (rc) {
+        complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
+        goto err_dealloc_cqe_ctx;
+    }
+
+    wr.num_sge = num_sge;
+    wr.sg_list = new_sge;
+    wr.wr_id = bctx_id;
+    rc = ibv_post_srq_recv(srq->ibsrq, &wr, &bad_wr);
+    if (rc) {
+        rdma_error_report("ibv_post_srq_recv fail, srqn=0x%x, rc=%d, errno=%d",
+                          srq->ibsrq->handle, rc, errno);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
+        goto err_dealloc_cqe_ctx;
+    }
+
+    atomic_inc(&backend_dev->rdma_dev_res->stats.missing_cqe);
+    backend_dev->rdma_dev_res->stats.rx_bufs++;
+    backend_dev->rdma_dev_res->stats.rx_srq++;
+
+    return;
+
+err_dealloc_cqe_ctx:
+    backend_dev->rdma_dev_res->stats.rx_bufs_err++;
+    rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, bctx_id);
+
+err_free_bctx:
+    g_free(bctx);
+}
+
 int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd)
 {
     pd->ibpd = ibv_alloc_pd(backend_dev->context);
@@ -938,6 +999,55 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp, RdmaDeviceResources *dev_res)
     rdma_protected_gslist_destroy(&qp->cqe_ctx_list);
 }
 
+int rdma_backend_create_srq(RdmaBackendSRQ *srq, RdmaBackendPD *pd,
+                            uint32_t max_wr, uint32_t max_sge,
+                            uint32_t srq_limit)
+{
+    struct ibv_srq_init_attr srq_init_attr = {};
+
+    srq_init_attr.attr.max_wr = max_wr;
+    srq_init_attr.attr.max_sge = max_sge;
+    srq_init_attr.attr.srq_limit = srq_limit;
+
+    srq->ibsrq = ibv_create_srq(pd->ibpd, &srq_init_attr);
+    if (!srq->ibsrq) {
+        rdma_error_report("ibv_create_srq failed, errno=%d", errno);
+        return -EIO;
+    }
+
+    rdma_protected_gslist_init(&srq->cqe_ctx_list);
+
+    return 0;
+}
+
+int rdma_backend_query_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr)
+{
+    if (!srq->ibsrq) {
+        return -EINVAL;
+    }
+
+    return ibv_query_srq(srq->ibsrq, srq_attr);
+}
+
+int rdma_backend_modify_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr,
+                int srq_attr_mask)
+{
+    if (!srq->ibsrq) {
+        return -EINVAL;
+    }
+
+    return ibv_modify_srq(srq->ibsrq, srq_attr, srq_attr_mask);
+}
+
+void rdma_backend_destroy_srq(RdmaBackendSRQ *srq, RdmaDeviceResources *dev_res)
+{
+    if (srq->ibsrq) {
+        ibv_destroy_srq(srq->ibsrq);
+    }
+    g_slist_foreach(srq->cqe_ctx_list.list, free_cqe_ctx, dev_res);
+    rdma_protected_gslist_destroy(&srq->cqe_ctx_list);
+}
+
 #define CHK_ATTR(req, dev, member, fmt) ({ \
     trace_rdma_check_dev_attr(#member, dev.member, req->member); \
     if (req->member > dev.member) { \
@@ -960,6 +1070,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
     }
 
     dev_attr->max_sge = MAX_SGE;
+    dev_attr->max_srq_sge = MAX_SGE;
 
     CHK_ATTR(dev_attr, bk_dev_attr, max_mr_size, "%" PRId64);
     CHK_ATTR(dev_attr, bk_dev_attr, max_qp, "%d");
@@ -970,6 +1081,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
     CHK_ATTR(dev_attr, bk_dev_attr, max_qp_rd_atom, "%d");
     CHK_ATTR(dev_attr, bk_dev_attr, max_qp_init_rd_atom, "%d");
     CHK_ATTR(dev_attr, bk_dev_attr, max_ah, "%d");
+    CHK_ATTR(dev_attr, bk_dev_attr, max_srq, "%d");
 
     return 0;
 }
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 38056d97c7..cad7956d98 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -114,4 +114,16 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
                             RdmaBackendQP *qp, uint8_t qp_type,
                             struct ibv_sge *sge, uint32_t num_sge, void *ctx);
 
+int rdma_backend_create_srq(RdmaBackendSRQ *srq, RdmaBackendPD *pd,
+                            uint32_t max_wr, uint32_t max_sge,
+                            uint32_t srq_limit);
+int rdma_backend_query_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr);
+int rdma_backend_modify_srq(RdmaBackendSRQ *srq, struct ibv_srq_attr *srq_attr,
+                            int srq_attr_mask);
+void rdma_backend_destroy_srq(RdmaBackendSRQ *srq,
+                              RdmaDeviceResources *dev_res);
+void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
+                                RdmaBackendSRQ *srq, struct ibv_sge *sge,
+                                uint32_t num_sge, void *ctx);
+
 #endif
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
index 817153dc8c..0b55be3503 100644
--- a/hw/rdma/rdma_backend_defs.h
+++ b/hw/rdma/rdma_backend_defs.h
@@ -68,4 +68,9 @@ typedef struct RdmaBackendQP {
     RdmaProtectedGSList cqe_ctx_list;
 } RdmaBackendQP;
 
+typedef struct RdmaBackendSRQ {
+    struct ibv_srq *ibsrq;
+    RdmaProtectedGSList cqe_ctx_list;
+} RdmaBackendSRQ;
+
 #endif
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index bac3b2f4a6..b683506b86 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -37,6 +37,8 @@ void rdma_dump_device_counters(Monitor *mon, RdmaDeviceResources *dev_res)
                    dev_res->stats.tx_err);
     monitor_printf(mon, "\trx_bufs          : %" PRId64 "\n",
                    dev_res->stats.rx_bufs);
+    monitor_printf(mon, "\trx_srq           : %" PRId64 "\n",
+                   dev_res->stats.rx_srq);
     monitor_printf(mon, "\trx_bufs_len      : %" PRId64 "\n",
                    dev_res->stats.rx_bufs_len);
     monitor_printf(mon, "\trx_bufs_err      : %" PRId64 "\n",
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index c200d311de..e774af5280 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -106,6 +106,7 @@ typedef struct RdmaRmStats {
     uint64_t rx_bufs;
     uint64_t rx_bufs_len;
     uint64_t rx_bufs_err;
+    uint64_t rx_srq;
     uint64_t completions;
     uint64_t mad_tx;
     uint64_t mad_tx_err;
-- 
2.17.1
