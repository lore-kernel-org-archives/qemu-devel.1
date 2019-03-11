Received: from eggs.gnu.org ([209.51.188.92]:36372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h3IBS-0007YD-Jd
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h3IBP-0000uB-E2
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1h3IBP-0000tN-0t
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:23 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 11 Mar 2019 03:29:08 -0700
Message-Id: <1552300155-25216-5-git-send-email-yuval.shaia@oracle.com>
In-Reply-To: <1552300155-25216-1-git-send-email-yuval.shaia@oracle.com>
References: <1552300155-25216-1-git-send-email-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v6 04/11] hw/pvrdma: Collect debugging
 statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com

Add counters to enable enhance debugging

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c    | 70 +++++++++++++++++++++++++++++++++++------------
 hw/rdma/rdma_rm.c         |  7 +++++
 hw/rdma/rdma_rm_defs.h    | 27 +++++++++++++++++-
 hw/rdma/vmw/pvrdma.h      | 10 +++++++
 hw/rdma/vmw/pvrdma_cmd.c  |  2 ++
 hw/rdma/vmw/pvrdma_main.c |  8 ++++++
 6 files changed, 106 insertions(+), 18 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 1897540..e8af974 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -64,9 +64,9 @@ static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
     comp_handler(ctx, &wc);
 }
 
-static void rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
+static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
 {
-    int i, ne;
+    int i, ne, total_ne = 0;
     BackendCtx *bctx;
     struct ibv_wc wc[2];
 
@@ -89,12 +89,18 @@ static void rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
             rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
             g_free(bctx);
         }
+        total_ne += ne;
     } while (ne > 0);
+    atomic_sub(&rdma_dev_res->stats.missing_cqe, total_ne);
     qemu_mutex_unlock(&rdma_dev_res->lock);
 
     if (ne < 0) {
         rdma_error_report("ibv_poll_cq fail, rc=%d, errno=%d", ne, errno);
     }
+
+    rdma_dev_res->stats.completions += total_ne;
+
+    return total_ne;
 }
 
 static void *comp_handler_thread(void *arg)
@@ -122,6 +128,9 @@ static void *comp_handler_thread(void *arg)
     while (backend_dev->comp_thread.run) {
         do {
             rc = qemu_poll_ns(pfds, 1, THR_POLL_TO * (int64_t)SCALE_MS);
+            if (!rc) {
+                backend_dev->rdma_dev_res->stats.poll_cq_ppoll_to++;
+            }
         } while (!rc && backend_dev->comp_thread.run);
 
         if (backend_dev->comp_thread.run) {
@@ -138,6 +147,7 @@ static void *comp_handler_thread(void *arg)
                                   errno);
             }
 
+            backend_dev->rdma_dev_res->stats.poll_cq_from_bk++;
             rdma_poll_cq(backend_dev->rdma_dev_res, ev_cq);
 
             ibv_ack_cq_events(ev_cq, 1);
@@ -271,7 +281,13 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
 
 void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq)
 {
-    rdma_poll_cq(rdma_dev_res, cq->ibcq);
+    int polled;
+
+    rdma_dev_res->stats.poll_cq_from_guest++;
+    polled = rdma_poll_cq(rdma_dev_res, cq->ibcq);
+    if (!polled) {
+        rdma_dev_res->stats.poll_cq_from_guest_empty++;
+    }
 }
 
 static GHashTable *ah_hash;
@@ -333,7 +349,7 @@ static void ah_cache_init(void)
 
 static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
                                 struct ibv_sge *dsge, struct ibv_sge *ssge,
-                                uint8_t num_sge)
+                                uint8_t num_sge, uint64_t *total_length)
 {
     RdmaRmMR *mr;
     int ssge_idx;
@@ -349,6 +365,8 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
         dsge->length = ssge[ssge_idx].length;
         dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
 
+        *total_length += dsge->length;
+
         dsge++;
     }
 
@@ -445,8 +463,10 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
             rc = mad_send(backend_dev, sgid_idx, sgid, sge, num_sge);
             if (rc) {
                 complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
+                backend_dev->rdma_dev_res->stats.mad_tx_err++;
             } else {
                 complete_work(IBV_WC_SUCCESS, 0, ctx);
+                backend_dev->rdma_dev_res->stats.mad_tx++;
             }
         }
         return;
@@ -458,20 +478,21 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
         complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
-        goto out_free_bctx;
+        goto err_free_bctx;
     }
 
-    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge);
+    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
+                              &backend_dev->rdma_dev_res->stats.tx_len);
     if (rc) {
         complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
-        goto out_dealloc_cqe_ctx;
+        goto err_dealloc_cqe_ctx;
     }
 
     if (qp_type == IBV_QPT_UD) {
         wr.wr.ud.ah = create_ah(backend_dev, qp->ibpd, sgid_idx, dgid);
         if (!wr.wr.ud.ah) {
             complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
-            goto out_dealloc_cqe_ctx;
+            goto err_dealloc_cqe_ctx;
         }
         wr.wr.ud.remote_qpn = dqpn;
         wr.wr.ud.remote_qkey = dqkey;
@@ -488,15 +509,19 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
         rdma_error_report("ibv_post_send fail, qpn=0x%x, rc=%d, errno=%d",
                           qp->ibqp->qp_num, rc, errno);
         complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
-        goto out_dealloc_cqe_ctx;
+        goto err_dealloc_cqe_ctx;
     }
 
+    atomic_inc(&backend_dev->rdma_dev_res->stats.missing_cqe);
+    backend_dev->rdma_dev_res->stats.tx++;
+
     return;
 
-out_dealloc_cqe_ctx:
+err_dealloc_cqe_ctx:
+    backend_dev->rdma_dev_res->stats.tx_err++;
     rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, bctx_id);
 
-out_free_bctx:
+err_free_bctx:
     g_free(bctx);
 }
 
@@ -554,6 +579,9 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
             rc = save_mad_recv_buffer(backend_dev, sge, num_sge, ctx);
             if (rc) {
                 complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
+                rdma_dev_res->stats.mad_rx_bufs_err++;
+            } else {
+                rdma_dev_res->stats.mad_rx_bufs++;
             }
         }
         return;
@@ -565,13 +593,14 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
     rc = rdma_rm_alloc_cqe_ctx(rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
         complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
-        goto out_free_bctx;
+        goto err_free_bctx;
     }
 
-    rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge);
+    rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge,
+                              &backend_dev->rdma_dev_res->stats.rx_bufs_len);
     if (rc) {
         complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
-        goto out_dealloc_cqe_ctx;
+        goto err_dealloc_cqe_ctx;
     }
 
     wr.num_sge = num_sge;
@@ -582,15 +611,19 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
         rdma_error_report("ibv_post_recv fail, qpn=0x%x, rc=%d, errno=%d",
                           qp->ibqp->qp_num, rc, errno);
         complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
-        goto out_dealloc_cqe_ctx;
+        goto err_dealloc_cqe_ctx;
     }
 
+    atomic_inc(&backend_dev->rdma_dev_res->stats.missing_cqe);
+    rdma_dev_res->stats.rx_bufs++;
+
     return;
 
-out_dealloc_cqe_ctx:
+err_dealloc_cqe_ctx:
+    backend_dev->rdma_dev_res->stats.rx_bufs_err++;
     rdma_rm_dealloc_cqe_ctx(rdma_dev_res, bctx_id);
 
-out_free_bctx:
+err_free_bctx:
     g_free(bctx);
 }
 
@@ -929,12 +962,14 @@ static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
     bctx = rdma_rm_get_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_id);
     if (unlikely(!bctx)) {
         rdma_error_report("No matching ctx for req %ld", cqe_ctx_id);
+        backend_dev->rdma_dev_res->stats.mad_rx_err++;
         return;
     }
 
     mad = rdma_pci_dma_map(backend_dev->dev, bctx->sge.addr,
                            bctx->sge.length);
     if (!mad || bctx->sge.length < msg->umad_len + MAD_HDR_SIZE) {
+        backend_dev->rdma_dev_res->stats.mad_rx_err++;
         complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_MAD_BUFF,
                       bctx->up_ctx);
     } else {
@@ -949,6 +984,7 @@ static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
         wc.byte_len = msg->umad_len;
         wc.status = IBV_WC_SUCCESS;
         wc.wc_flags = IBV_WC_GRH;
+        backend_dev->rdma_dev_res->stats.mad_rx++;
         comp_handler(bctx->up_ctx, &wc);
     }
 
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 7ea62a9..35fa1ab 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -37,6 +37,7 @@ static inline void res_tbl_init(const char *name, RdmaRmResTbl *tbl,
     tbl->bitmap = bitmap_new(tbl_sz);
     tbl->tbl_sz = tbl_sz;
     tbl->res_sz = res_sz;
+    tbl->used = 0;
     qemu_mutex_init(&tbl->lock);
 }
 
@@ -76,6 +77,8 @@ static inline void *rdma_res_tbl_alloc(RdmaRmResTbl *tbl, uint32_t *handle)
 
     set_bit(*handle, tbl->bitmap);
 
+    tbl->used++;
+
     qemu_mutex_unlock(&tbl->lock);
 
     memset(tbl->tbl + *handle * tbl->res_sz, 0, tbl->res_sz);
@@ -93,6 +96,7 @@ static inline void rdma_res_tbl_dealloc(RdmaRmResTbl *tbl, uint32_t handle)
 
     if (handle < tbl->tbl_sz) {
         clear_bit(handle, tbl->bitmap);
+        tbl->used--;
     }
 
     qemu_mutex_unlock(&tbl->lock);
@@ -619,6 +623,9 @@ int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr)
 
     qemu_mutex_init(&dev_res->lock);
 
+    memset(&dev_res->stats, 0, sizeof(dev_res->stats));
+    atomic_set(&dev_res->stats.missing_cqe, 0);
+
     return 0;
 }
 
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index f0ee1f3..4b8d704 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -34,7 +34,9 @@
 #define MAX_QP_INIT_RD_ATOM   16
 #define MAX_AH                64
 
-#define MAX_RM_TBL_NAME 16
+#define MAX_RM_TBL_NAME             16
+#define MAX_CONSEQ_EMPTY_POLL_CQ    4096 /* considered as error above this */
+
 typedef struct RdmaRmResTbl {
     char name[MAX_RM_TBL_NAME];
     QemuMutex lock;
@@ -42,6 +44,7 @@ typedef struct RdmaRmResTbl {
     size_t tbl_sz;
     size_t res_sz;
     void *tbl;
+    uint32_t used; /* number of used entries in the table */
 } RdmaRmResTbl;
 
 typedef struct RdmaRmPD {
@@ -96,6 +99,27 @@ typedef struct RdmaRmPort {
     enum ibv_port_state state;
 } RdmaRmPort;
 
+typedef struct RdmaRmStats {
+    uint64_t tx;
+    uint64_t tx_len;
+    uint64_t tx_err;
+    uint64_t rx_bufs;
+    uint64_t rx_bufs_len;
+    uint64_t rx_bufs_err;
+    uint64_t completions;
+    uint64_t mad_tx;
+    uint64_t mad_tx_err;
+    uint64_t mad_rx;
+    uint64_t mad_rx_err;
+    uint64_t mad_rx_bufs;
+    uint64_t mad_rx_bufs_err;
+    uint64_t poll_cq_from_bk;
+    uint64_t poll_cq_from_guest;
+    uint64_t poll_cq_from_guest_empty;
+    uint64_t poll_cq_ppoll_to;
+    uint32_t missing_cqe;
+} RdmaRmStats;
+
 typedef struct RdmaDeviceResources {
     RdmaRmPort port;
     RdmaRmResTbl pd_tbl;
@@ -106,6 +130,7 @@ typedef struct RdmaDeviceResources {
     RdmaRmResTbl cqe_ctx_tbl;
     GHashTable *qp_hash; /* Keeps mapping between real and emulated */
     QemuMutex lock;
+    RdmaRmStats stats;
 } RdmaDeviceResources;
 
 #endif
diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index 0879224..a8a04a2 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -70,6 +70,14 @@ typedef struct DSRInfo {
     PvrdmaRing cq;
 } DSRInfo;
 
+typedef struct PVRDMADevStats {
+    uint64_t commands;
+    uint64_t regs_reads;
+    uint64_t regs_writes;
+    uint64_t uar_writes;
+    uint64_t interrupts;
+} PVRDMADevStats;
+
 typedef struct PVRDMADev {
     PCIDevice parent_obj;
     MemoryRegion msix;
@@ -89,6 +97,7 @@ typedef struct PVRDMADev {
     CharBackend mad_chr;
     VMXNET3State *func0;
     Notifier shutdown_notifier;
+    PVRDMADevStats stats;
 } PVRDMADev;
 #define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
 
@@ -123,6 +132,7 @@ static inline void post_interrupt(PVRDMADev *dev, unsigned vector)
     PCIDevice *pci_dev = PCI_DEVICE(dev);
 
     if (likely(!dev->interrupt_mask)) {
+        dev->stats.interrupts++;
         msix_notify(pci_dev, vector);
     }
 }
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 21a55e2..6d56746 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -651,6 +651,8 @@ int pvrdma_exec_cmd(PVRDMADev *dev)
 
     trace_pvrdma_exec_cmd(dsr_info->req->hdr.cmd, dsr_info->rsp->hdr.err);
 
+    dev->stats.commands++;
+
 out:
     set_reg_val(dev, PVRDMA_REG_ERR, err);
     post_interrupt(dev, INTR_VEC_CMD_RING);
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 81ae08b..dd35646 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -337,6 +337,8 @@ static uint64_t pvrdma_regs_read(void *opaque, hwaddr addr, unsigned size)
     PVRDMADev *dev = opaque;
     uint32_t val;
 
+    dev->stats.regs_reads++;
+
     if (get_reg_val(dev, addr, &val)) {
         rdma_error_report("Failed to read REG value from address 0x%x",
                           (uint32_t)addr);
@@ -353,6 +355,8 @@ static void pvrdma_regs_write(void *opaque, hwaddr addr, uint64_t val,
 {
     PVRDMADev *dev = opaque;
 
+    dev->stats.regs_writes++;
+
     if (set_reg_val(dev, addr, val)) {
         rdma_error_report("Failed to set REG value, addr=0x%"PRIx64 ", val=0x%"PRIx64,
                           addr, val);
@@ -421,6 +425,8 @@ static void pvrdma_uar_write(void *opaque, hwaddr addr, uint64_t val,
 {
     PVRDMADev *dev = opaque;
 
+    dev->stats.uar_writes++;
+
     switch (addr & 0xFFF) { /* Mask with 0xFFF as each UC gets page */
     case PVRDMA_UAR_QP_OFFSET:
         if (val & PVRDMA_UAR_QP_SEND) {
@@ -612,6 +618,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
         goto out;
     }
 
+    memset(&dev->stats, 0, sizeof(dev->stats));
+
     dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
     qemu_register_shutdown_notifier(&dev->shutdown_notifier);
 
-- 
1.8.3.1
