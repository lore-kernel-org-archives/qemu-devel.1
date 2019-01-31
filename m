Received: from eggs.gnu.org ([209.51.188.92]:48140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5i-0007EL-VY
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5g-0000JW-Fd
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:14 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:32776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gpC5g-0000JJ-6M
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:12 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 31 Jan 2019 15:08:45 +0200
Message-Id: <20190131130850.6850-6-yuval.shaia@oracle.com>
In-Reply-To: <20190131130850.6850-1-yuval.shaia@oracle.com>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 05/10] hw/pvrdma: Add device statistics counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c    | 53 ++++++++++++++++++++++++++++-----------
 hw/rdma/rdma_rm.c         |  6 +++++
 hw/rdma/rdma_rm_defs.h    | 21 ++++++++++++++++
 hw/rdma/vmw/pvrdma.h      |  5 ++++
 hw/rdma/vmw/pvrdma_main.c |  3 +++
 5 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index bf8e889144..d43fb1e677 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -97,6 +97,8 @@ static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
         rdma_error_report("ibv_poll_cq fail, rc=%d, errno=%d", ne, errno);
     }
 
+    rdma_dev_res->stats.completions += total_ne;
+
     return total_ne;
 }
 
@@ -125,6 +127,9 @@ static void *comp_handler_thread(void *arg)
     while (backend_dev->comp_thread.run) {
         do {
             rc = qemu_poll_ns(pfds, 1, THR_POLL_TO * (int64_t)SCALE_MS);
+            if (!rc) {
+                backend_dev->rdma_dev_res->stats.poll_cq_ppoll_to++;
+            }
         } while (!rc && backend_dev->comp_thread.run);
 
         if (backend_dev->comp_thread.run) {
@@ -141,6 +146,7 @@ static void *comp_handler_thread(void *arg)
                                   errno);
             }
 
+            backend_dev->rdma_dev_res->stats.poll_cq_from_bk++;
             rdma_poll_cq(backend_dev->rdma_dev_res, ev_cq);
 
             ibv_ack_cq_events(ev_cq, 1);
@@ -274,6 +280,7 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
 
 int rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq)
 {
+    rdma_dev_res->stats.poll_cq_from_guest++;
     return rdma_poll_cq(rdma_dev_res, cq->ibcq);
 }
 
@@ -336,7 +343,7 @@ static void ah_cache_init(void)
 
 static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
                                 struct ibv_sge *dsge, struct ibv_sge *ssge,
-                                uint8_t num_sge)
+                                uint8_t num_sge, uint64_t *total_length)
 {
     RdmaRmMR *mr;
     int ssge_idx;
@@ -352,6 +359,8 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
         dsge->length = ssge[ssge_idx].length;
         dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
 
+        *total_length += dsge->length;
+
         dsge++;
     }
 
@@ -448,8 +457,10 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
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
@@ -461,20 +472,21 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
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
@@ -491,15 +503,18 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
         rdma_error_report("ibv_post_send fail, qpn=0x%x, rc=%d, errno=%d",
                           qp->ibqp->qp_num, rc, errno);
         complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
-        goto out_dealloc_cqe_ctx;
+        goto err_dealloc_cqe_ctx;
     }
 
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
 
@@ -557,6 +572,9 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
             rc = save_mad_recv_buffer(backend_dev, sge, num_sge, ctx);
             if (rc) {
                 complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
+                rdma_dev_res->stats.mad_rx_bufs_err++;
+            } else {
+                rdma_dev_res->stats.mad_rx_bufs++;
             }
         }
         return;
@@ -568,13 +586,14 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
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
@@ -585,15 +604,18 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
         rdma_error_report("ibv_post_recv fail, qpn=0x%x, rc=%d, errno=%d",
                           qp->ibqp->qp_num, rc, errno);
         complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
-        goto out_dealloc_cqe_ctx;
+        goto err_dealloc_cqe_ctx;
     }
 
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
 
@@ -932,12 +954,14 @@ static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
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
@@ -952,6 +976,7 @@ static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
         wc.byte_len = msg->umad_len;
         wc.status = IBV_WC_SUCCESS;
         wc.wc_flags = IBV_WC_GRH;
+        backend_dev->rdma_dev_res->stats.mad_rx++;
         comp_handler(bctx->up_ctx, &wc);
     }
 
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 9408bfb751..ff536e356b 100644
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
@@ -621,6 +625,8 @@ int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr,
 
     qemu_mutex_init(&dev_res->lock);
 
+    memset(&dev_res->stats, 0, sizeof(dev_res->stats));
+
     return 0;
 }
 
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 9e98565a28..49b0a59785 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -44,6 +44,7 @@ typedef struct RdmaRmResTbl {
     size_t tbl_sz;
     size_t res_sz;
     void *tbl;
+    uint32_t used; /* number of used entries in the table */
 } RdmaRmResTbl;
 
 typedef struct RdmaRmPD {
@@ -100,6 +101,25 @@ typedef struct RdmaRmPort {
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
+    uint64_t poll_cq_ppoll_to;
+} RdmaRmStats;
+
 typedef struct RdmaDeviceResources {
     RdmaRmPort port;
     RdmaRmResTbl pd_tbl;
@@ -110,6 +130,7 @@ typedef struct RdmaDeviceResources {
     RdmaRmResTbl cqe_ctx_tbl;
     GHashTable *qp_hash; /* Keeps mapping between real and emulated */
     QemuMutex lock;
+    RdmaRmStats stats;
 } RdmaDeviceResources;
 
 #endif
diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index 0879224957..167706ec2c 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -70,6 +70,10 @@ typedef struct DSRInfo {
     PvrdmaRing cq;
 } DSRInfo;
 
+typedef struct PVRDMADevStats {
+    uint64_t commands;
+} PVRDMADevStats;
+
 typedef struct PVRDMADev {
     PCIDevice parent_obj;
     MemoryRegion msix;
@@ -89,6 +93,7 @@ typedef struct PVRDMADev {
     CharBackend mad_chr;
     VMXNET3State *func0;
     Notifier shutdown_notifier;
+    PVRDMADevStats stats;
 } PVRDMADev;
 #define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
 
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index b6061f4b6e..cf82e78f08 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -394,6 +394,7 @@ static void pvrdma_regs_write(void *opaque, hwaddr addr, uint64_t val,
         if (val == 0) {
             trace_pvrdma_regs_write(addr, val, "REQUEST", "");
             pvrdma_exec_cmd(dev);
+            dev->stats.commands++;
         }
         break;
     default:
@@ -612,6 +613,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
         goto out;
     }
 
+    memset(&dev->stats, 0, sizeof(dev->stats));
+
     dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
     qemu_register_shutdown_notifier(&dev->shutdown_notifier);
 
-- 
2.17.2
