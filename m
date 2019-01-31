Received: from eggs.gnu.org ([209.51.188.92]:48133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5g-0007BW-Qa
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5Z-0000HF-M5
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gpC5Z-0000H2-3n
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:05 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 31 Jan 2019 15:08:41 +0200
Message-Id: <20190131130850.6850-2-yuval.shaia@oracle.com>
In-Reply-To: <20190131130850.6850-1-yuval.shaia@oracle.com>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 01/10] hw/rdma: Switch to generic error
 reporting way
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

Utilize error_report for all pr_err calls and some pr_dbg that are
considered as errors.
For the remaining pr_dbg calls, the important ones were replaced by
trace points while other deleted.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c        | 336 ++++++++++++++--------------------
 hw/rdma/rdma_rm.c             | 121 +++++-------
 hw/rdma/rdma_utils.c          |  11 +-
 hw/rdma/rdma_utils.h          |  45 +----
 hw/rdma/trace-events          |  32 +++-
 hw/rdma/vmw/pvrdma.h          |   2 +-
 hw/rdma/vmw/pvrdma_cmd.c      | 113 +++---------
 hw/rdma/vmw/pvrdma_dev_ring.c |  26 +--
 hw/rdma/vmw/pvrdma_main.c     | 132 +++++--------
 hw/rdma/vmw/pvrdma_qp_ops.c   |  49 ++---
 hw/rdma/vmw/trace-events      |  16 +-
 11 files changed, 337 insertions(+), 546 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index fd571f21e5..5f60856d19 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -14,7 +14,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qlist.h"
@@ -39,7 +38,6 @@
 
 typedef struct BackendCtx {
     void *up_ctx;
-    bool is_tx_req;
     struct ibv_sge sge; /* Used to save MAD recv buffer */
 } BackendCtx;
 
@@ -52,7 +50,7 @@ static void (*comp_handler)(void *ctx, struct ibv_wc *wc);
 
 static void dummy_comp_handler(void *ctx, struct ibv_wc *wc)
 {
-    pr_err("No completion handler is registered\n");
+    rdma_error_report("No completion handler is registered");
 }
 
 static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
@@ -66,29 +64,24 @@ static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
     comp_handler(ctx, &wc);
 }
 
-static void poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
+static void rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
 {
     int i, ne;
     BackendCtx *bctx;
     struct ibv_wc wc[2];
 
-    pr_dbg("Entering poll_cq loop on cq %p\n", ibcq);
     do {
         ne = ibv_poll_cq(ibcq, ARRAY_SIZE(wc), wc);
 
-        pr_dbg("Got %d completion(s) from cq %p\n", ne, ibcq);
+        trace_rdma_poll_cq(ne, ibcq);
 
         for (i = 0; i < ne; i++) {
-            pr_dbg("wr_id=0x%" PRIx64 "\n", wc[i].wr_id);
-            pr_dbg("status=%d\n", wc[i].status);
-
             bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
             if (unlikely(!bctx)) {
-                pr_dbg("Error: Failed to find ctx for req %" PRId64 "\n",
-                       wc[i].wr_id);
+                rdma_error_report("No matching ctx for req %"PRId64,
+                                  wc[i].wr_id);
                 continue;
             }
-            pr_dbg("Processing %s CQE\n", bctx->is_tx_req ? "send" : "recv");
 
             comp_handler(bctx->up_ctx, &wc[i]);
 
@@ -98,7 +91,7 @@ static void poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
     } while (ne > 0);
 
     if (ne < 0) {
-        pr_dbg("Got error %d from ibv_poll_cq\n", ne);
+        rdma_error_report("ibv_poll_cq fail, rc=%d, errno=%d", ne, errno);
     }
 }
 
@@ -115,12 +108,10 @@ static void *comp_handler_thread(void *arg)
     flags = fcntl(backend_dev->channel->fd, F_GETFL);
     rc = fcntl(backend_dev->channel->fd, F_SETFL, flags | O_NONBLOCK);
     if (rc < 0) {
-        pr_dbg("Fail to change to non-blocking mode\n");
+        rdma_error_report("Failed to change backend channel FD to non-blocking");
         return NULL;
     }
 
-    pr_dbg("Starting\n");
-
     pfds[0].fd = backend_dev->channel->fd;
     pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
 
@@ -132,27 +123,25 @@ static void *comp_handler_thread(void *arg)
         } while (!rc && backend_dev->comp_thread.run);
 
         if (backend_dev->comp_thread.run) {
-            pr_dbg("Waiting for completion on channel %p\n", backend_dev->channel);
             rc = ibv_get_cq_event(backend_dev->channel, &ev_cq, &ev_ctx);
-            pr_dbg("ibv_get_cq_event=%d\n", rc);
             if (unlikely(rc)) {
-                pr_dbg("---> ibv_get_cq_event (%d)\n", rc);
+                rdma_error_report("ibv_get_cq_event fail, rc=%d, errno=%d", rc,
+                                  errno);
                 continue;
             }
 
             rc = ibv_req_notify_cq(ev_cq, 0);
             if (unlikely(rc)) {
-                pr_dbg("Error %d from ibv_req_notify_cq\n", rc);
+                rdma_error_report("ibv_req_notify_cq fail, rc=%d, errno=%d", rc,
+                                  errno);
             }
 
-            poll_cq(backend_dev->rdma_dev_res, ev_cq);
+            rdma_poll_cq(backend_dev->rdma_dev_res, ev_cq);
 
             ibv_ack_cq_events(ev_cq, 1);
         }
     }
 
-    pr_dbg("Going down\n");
-
     /* TODO: Post cqe for all remaining buffs that were posted */
 
     backend_dev->comp_thread.is_running = false;
@@ -177,55 +166,54 @@ static inline int rdmacm_mux_can_process_async(RdmaBackendDev *backend_dev)
     return atomic_read(&backend_dev->rdmacm_mux.can_receive);
 }
 
-static int check_mux_op_status(CharBackend *mad_chr_be)
+static int rdmacm_mux_check_op_status(CharBackend *mad_chr_be)
 {
     RdmaCmMuxMsg msg = {};
     int ret;
 
-    pr_dbg("Reading response\n");
     ret = qemu_chr_fe_read_all(mad_chr_be, (uint8_t *)&msg, sizeof(msg));
     if (ret != sizeof(msg)) {
-        pr_dbg("Invalid message size %d, expecting %ld\n", ret, sizeof(msg));
+        rdma_error_report("Got invalid message from mux: size %d, expecting %ld",
+                          ret, sizeof(msg));
         return -EIO;
     }
 
-    pr_dbg("msg_type=%d\n", msg.hdr.msg_type);
-    pr_dbg("op_code=%d\n", msg.hdr.op_code);
-    pr_dbg("err_code=%d\n", msg.hdr.err_code);
+    trace_rdmacm_mux_check_op_status(msg.hdr.msg_type, msg.hdr.op_code,
+                                     msg.hdr.err_code);
 
     if (msg.hdr.msg_type != RDMACM_MUX_MSG_TYPE_RESP) {
-        pr_dbg("Invalid message type %d\n", msg.hdr.msg_type);
+        rdma_error_report("Got invalid message type %d", msg.hdr.msg_type);
         return -EIO;
     }
 
     if (msg.hdr.err_code != RDMACM_MUX_ERR_CODE_OK) {
-        pr_dbg("Operation failed in mux, error code %d\n", msg.hdr.err_code);
+        rdma_error_report("Operation failed in mux, error code %d",
+                          msg.hdr.err_code);
         return -EIO;
     }
 
     return 0;
 }
 
-static int exec_rdmacm_mux_req(RdmaBackendDev *backend_dev, RdmaCmMuxMsg *msg)
+static int rdmacm_mux_send(RdmaBackendDev *backend_dev, RdmaCmMuxMsg *msg)
 {
     int rc = 0;
 
-    pr_dbg("Executing request %d\n", msg->hdr.op_code);
-
     msg->hdr.msg_type = RDMACM_MUX_MSG_TYPE_REQ;
+    trace_rdmacm_mux("send", msg->hdr.msg_type, msg->hdr.op_code);
     disable_rdmacm_mux_async(backend_dev);
     rc = qemu_chr_fe_write(backend_dev->rdmacm_mux.chr_be,
                            (const uint8_t *)msg, sizeof(*msg));
     if (rc != sizeof(*msg)) {
         enable_rdmacm_mux_async(backend_dev);
-        pr_dbg("Fail to send request to rdmacm_mux (rc=%d)\n", rc);
+        rdma_error_report("Failed to send request to rdmacm_mux (rc=%d)", rc);
         return -EIO;
     }
 
-    rc = check_mux_op_status(backend_dev->rdmacm_mux.chr_be);
+    rc = rdmacm_mux_check_op_status(backend_dev->rdmacm_mux.chr_be);
     if (rc) {
-        pr_dbg("Fail to execute rdmacm_mux request %d (rc=%d)\n",
-               msg->hdr.op_code, rc);
+        rdma_error_report("Failed to execute rdmacm_mux request %d (rc=%d)",
+                          msg->hdr.op_code, rc);
     }
 
     enable_rdmacm_mux_async(backend_dev);
@@ -237,7 +225,6 @@ static void stop_backend_thread(RdmaBackendThread *thread)
 {
     thread->run = false;
     while (thread->is_running) {
-        pr_dbg("Waiting for thread to complete\n");
         sleep(THR_POLL_TO / SCALE_US / 2);
     }
 }
@@ -273,7 +260,7 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
 
     rc = ibv_query_port(backend_dev->context, backend_dev->port_num, port_attr);
     if (rc) {
-        pr_dbg("Error %d from ibv_query_port\n", rc);
+        rdma_error_report("ibv_query_port fail, rc=%d, errno=%d", rc, errno);
         return -EIO;
     }
 
@@ -282,7 +269,7 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
 
 void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq)
 {
-    poll_cq(rdma_dev_res, cq->ibcq);
+    rdma_poll_cq(rdma_dev_res, cq->ibcq);
 }
 
 static GHashTable *ah_hash;
@@ -294,8 +281,8 @@ static struct ibv_ah *create_ah(RdmaBackendDev *backend_dev, struct ibv_pd *pd,
     struct ibv_ah *ah = g_hash_table_lookup(ah_hash, ah_key);
 
     if (ah) {
-        trace_create_ah_cache_hit(be64_to_cpu(dgid->global.subnet_prefix),
-                                  be64_to_cpu(dgid->global.interface_id));
+        trace_rdma_create_ah_cache_hit(be64_to_cpu(dgid->global.subnet_prefix),
+                                       be64_to_cpu(dgid->global.interface_id));
         g_bytes_unref(ah_key);
     } else {
         struct ibv_ah_attr ah_attr = {
@@ -312,13 +299,13 @@ static struct ibv_ah *create_ah(RdmaBackendDev *backend_dev, struct ibv_pd *pd,
             g_hash_table_insert(ah_hash, ah_key, ah);
         } else {
             g_bytes_unref(ah_key);
-            pr_dbg("Fail to create AH for gid <0x%" PRIx64 ", 0x%" PRIx64 ">\n",
-                    be64_to_cpu(dgid->global.subnet_prefix),
-                    be64_to_cpu(dgid->global.interface_id));
+            rdma_error_report("Failed to create AH for gid <0x%" PRIx64", 0x%"PRIx64">",
+                              be64_to_cpu(dgid->global.subnet_prefix),
+                              be64_to_cpu(dgid->global.interface_id));
         }
 
-        trace_create_ah_cache_miss(be64_to_cpu(dgid->global.subnet_prefix),
-                                   be64_to_cpu(dgid->global.interface_id));
+        trace_rdma_create_ah_cache_miss(be64_to_cpu(dgid->global.subnet_prefix),
+                                        be64_to_cpu(dgid->global.interface_id));
     }
 
     return ah;
@@ -349,12 +336,10 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
     RdmaRmMR *mr;
     int ssge_idx;
 
-    pr_dbg("num_sge=%d\n", num_sge);
-
     for (ssge_idx = 0; ssge_idx < num_sge; ssge_idx++) {
         mr = rdma_rm_get_mr(rdma_dev_res, ssge[ssge_idx].lkey);
         if (unlikely(!mr)) {
-            pr_dbg("Invalid lkey 0x%x\n", ssge[ssge_idx].lkey);
+            rdma_error_report("Invalid lkey 0x%x", ssge[ssge_idx].lkey);
             return VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
         }
 
@@ -362,17 +347,28 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
         dsge->length = ssge[ssge_idx].length;
         dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
 
-        pr_dbg("ssge->addr=0x%" PRIx64 "\n", ssge[ssge_idx].addr);
-        pr_dbg("dsge->addr=0x%" PRIx64 "\n", dsge->addr);
-        pr_dbg("dsge->length=%d\n", dsge->length);
-        pr_dbg("dsge->lkey=0x%x\n", dsge->lkey);
-
         dsge++;
     }
 
     return 0;
 }
 
+static void trace_mad_message(const char *title, char *buf, size_t len)
+{
+    int i;
+    char *b = g_malloc0(len * 3 + 1);
+    char b1[4];
+
+    for (i = 0; i < len; i++) {
+        sprintf(b1, "%.2X ", buf[i] & 0x000000FF);
+        strcat(b, b1);
+    }
+
+    trace_rdma_mad_message(title, len, b);
+
+    g_free(b);
+}
+
 static int mad_send(RdmaBackendDev *backend_dev, uint8_t sgid_idx,
                     union ibv_gid *sgid, struct ibv_sge *sge, uint32_t num_sge)
 {
@@ -380,8 +376,6 @@ static int mad_send(RdmaBackendDev *backend_dev, uint8_t sgid_idx,
     char *hdr, *data;
     int ret;
 
-    pr_dbg("num_sge=%d\n", num_sge);
-
     if (num_sge != 2) {
         return -EINVAL;
     }
@@ -390,7 +384,6 @@ static int mad_send(RdmaBackendDev *backend_dev, uint8_t sgid_idx,
     memcpy(msg.hdr.sgid.raw, sgid->raw, sizeof(msg.hdr.sgid));
 
     msg.umad_len = sge[0].length + sge[1].length;
-    pr_dbg("umad_len=%d\n", msg.umad_len);
 
     if (msg.umad_len > sizeof(msg.umad.mad)) {
         return -ENOMEM;
@@ -398,36 +391,31 @@ static int mad_send(RdmaBackendDev *backend_dev, uint8_t sgid_idx,
 
     msg.umad.hdr.addr.qpn = htobe32(1);
     msg.umad.hdr.addr.grh_present = 1;
-    pr_dbg("sgid_idx=%d\n", sgid_idx);
-    pr_dbg("sgid=0x%llx\n", sgid->global.interface_id);
     msg.umad.hdr.addr.gid_index = sgid_idx;
     memcpy(msg.umad.hdr.addr.gid, sgid->raw, sizeof(msg.umad.hdr.addr.gid));
     msg.umad.hdr.addr.hop_limit = 0xFF;
 
     hdr = rdma_pci_dma_map(backend_dev->dev, sge[0].addr, sge[0].length);
     if (!hdr) {
-        pr_dbg("Fail to map to sge[0]\n");
         return -ENOMEM;
     }
     data = rdma_pci_dma_map(backend_dev->dev, sge[1].addr, sge[1].length);
     if (!data) {
-        pr_dbg("Fail to map to sge[1]\n");
         rdma_pci_dma_unmap(backend_dev->dev, hdr, sge[0].length);
         return -ENOMEM;
     }
 
-    pr_dbg_buf("mad_hdr", hdr, sge[0].length);
-    pr_dbg_buf("mad_data", data, sge[1].length);
-
     memcpy(&msg.umad.mad[0], hdr, sge[0].length);
     memcpy(&msg.umad.mad[sge[0].length], data, sge[1].length);
 
     rdma_pci_dma_unmap(backend_dev->dev, data, sge[1].length);
     rdma_pci_dma_unmap(backend_dev->dev, hdr, sge[0].length);
 
-    ret = exec_rdmacm_mux_req(backend_dev, &msg);
+    trace_mad_message("send", msg.umad.mad, msg.umad_len);
+
+    ret = rdmacm_mux_send(backend_dev, &msg);
     if (ret) {
-        pr_dbg("Fail to send MAD to rdma_umadmux (%d)\n", ret);
+        rdma_error_report("Failed to send MAD to rdma_umadmux (%d)", ret);
         return -EIO;
     }
 
@@ -447,12 +435,11 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     int rc;
     struct ibv_send_wr wr = {0}, *bad_wr;
 
-    if (!qp->ibqp) { /* This field does not get initialized for QP0 and QP1 */
+    if (!qp->ibqp) { /* This field is not initialized for QP0 and QP1 */
         if (qp_type == IBV_QPT_SMI) {
-            pr_dbg("QP0 unsupported\n");
+            rdma_error_report("Got QP0 request");
             complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
         } else if (qp_type == IBV_QPT_GSI) {
-            pr_dbg("QP1\n");
             rc = mad_send(backend_dev, sgid_idx, sgid, sge, num_sge);
             if (rc) {
                 complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
@@ -463,22 +450,17 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
         return;
     }
 
-    pr_dbg("num_sge=%d\n", num_sge);
-
     bctx = g_malloc0(sizeof(*bctx));
     bctx->up_ctx = ctx;
-    bctx->is_tx_req = 1;
 
     rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
-        pr_dbg("Failed to allocate cqe_ctx\n");
         complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
         goto out_free_bctx;
     }
 
     rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge);
     if (rc) {
-        pr_dbg("Error: Failed to build host SGE array\n");
         complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
         goto out_dealloc_cqe_ctx;
     }
@@ -500,10 +482,9 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     wr.wr_id = bctx_id;
 
     rc = ibv_post_send(qp->ibqp, &wr, &bad_wr);
-    pr_dbg("ibv_post_send=%d\n", rc);
     if (rc) {
-        pr_dbg("Fail (%d, %d) to post send WQE to qpn %d\n", rc, errno,
-                qp->ibqp->qp_num);
+        rdma_error_report("ibv_post_send fail, qpn=0x%x, rc=%d, errno=%d",
+                          qp->ibqp->qp_num, rc, errno);
         complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
         goto out_dealloc_cqe_ctx;
     }
@@ -526,29 +507,23 @@ static unsigned int save_mad_recv_buffer(RdmaBackendDev *backend_dev,
     uint32_t bctx_id;
 
     if (num_sge != 1) {
-        pr_dbg("Invalid num_sge (%d), expecting 1\n", num_sge);
+        rdma_error_report("Invalid num_sge (%d), expecting 1", num_sge);
         return VENDOR_ERR_INV_NUM_SGE;
     }
 
     if (sge[0].length < RDMA_MAX_PRIVATE_DATA + sizeof(struct ibv_grh)) {
-        pr_dbg("Too small buffer for MAD\n");
+        rdma_error_report("Too small buffer for MAD");
         return VENDOR_ERR_INV_MAD_BUFF;
     }
 
-    pr_dbg("addr=0x%" PRIx64"\n", sge[0].addr);
-    pr_dbg("length=%d\n", sge[0].length);
-    pr_dbg("lkey=%d\n", sge[0].lkey);
-
     bctx = g_malloc0(sizeof(*bctx));
 
     rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
         g_free(bctx);
-        pr_dbg("Fail to allocate cqe_ctx\n");
         return VENDOR_ERR_NOMEM;
     }
 
-    pr_dbg("bctx_id %d, bctx %p, ctx %p\n", bctx_id, bctx, ctx);
     bctx->up_ctx = ctx;
     bctx->sge = *sge;
 
@@ -572,11 +547,10 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
 
     if (!qp->ibqp) { /* This field does not get initialized for QP0 and QP1 */
         if (qp_type == IBV_QPT_SMI) {
-            pr_dbg("QP0 unsupported\n");
+            rdma_error_report("Got QP0 request");
             complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
         }
         if (qp_type == IBV_QPT_GSI) {
-            pr_dbg("QP1\n");
             rc = save_mad_recv_buffer(backend_dev, sge, num_sge, ctx);
             if (rc) {
                 complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
@@ -585,22 +559,17 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
         return;
     }
 
-    pr_dbg("num_sge=%d\n", num_sge);
-
     bctx = g_malloc0(sizeof(*bctx));
     bctx->up_ctx = ctx;
-    bctx->is_tx_req = 0;
 
     rc = rdma_rm_alloc_cqe_ctx(rdma_dev_res, &bctx_id, bctx);
     if (unlikely(rc)) {
-        pr_dbg("Failed to allocate cqe_ctx\n");
         complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
         goto out_free_bctx;
     }
 
     rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge);
     if (rc) {
-        pr_dbg("Error: Failed to build host SGE array\n");
         complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
         goto out_dealloc_cqe_ctx;
     }
@@ -609,10 +578,9 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
     wr.sg_list = new_sge;
     wr.wr_id = bctx_id;
     rc = ibv_post_recv(qp->ibqp, &wr, &bad_wr);
-    pr_dbg("ibv_post_recv=%d\n", rc);
     if (rc) {
-        pr_dbg("Fail (%d, %d) to post recv WQE to qpn %d\n", rc, errno,
-                qp->ibqp->qp_num);
+        rdma_error_report("ibv_post_recv fail, qpn=0x%x, rc=%d, errno=%d",
+                          qp->ibqp->qp_num, rc, errno);
         complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
         goto out_dealloc_cqe_ctx;
     }
@@ -630,7 +598,12 @@ int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd)
 {
     pd->ibpd = ibv_alloc_pd(backend_dev->context);
 
-    return pd->ibpd ? 0 : -EIO;
+    if (!pd->ibpd) {
+        rdma_error_report("ibv_alloc_pd fail, errno=%d", errno);
+        return -EIO;
+    }
+
+    return 0;
 }
 
 void rdma_backend_destroy_pd(RdmaBackendPD *pd)
@@ -643,16 +616,15 @@ void rdma_backend_destroy_pd(RdmaBackendPD *pd)
 int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
                            size_t length, int access)
 {
-    pr_dbg("addr=0x%p\n", addr);
-    pr_dbg("len=%zu\n", length);
     mr->ibmr = ibv_reg_mr(pd->ibpd, addr, length, access);
-    if (mr->ibmr) {
-        pr_dbg("lkey=0x%x\n", mr->ibmr->lkey);
-        pr_dbg("rkey=0x%x\n", mr->ibmr->rkey);
-        mr->ibpd = pd->ibpd;
+    if (!mr->ibmr) {
+        rdma_error_report("ibv_reg_mr fail, errno=%d", errno);
+        return -EIO;
     }
 
-    return mr->ibmr ? 0 : -EIO;
+    mr->ibpd = pd->ibpd;
+
+    return 0;
 }
 
 void rdma_backend_destroy_mr(RdmaBackendMR *mr)
@@ -667,21 +639,21 @@ int rdma_backend_create_cq(RdmaBackendDev *backend_dev, RdmaBackendCQ *cq,
 {
     int rc;
 
-    pr_dbg("cqe=%d\n", cqe);
-
-    pr_dbg("dev->channel=%p\n", backend_dev->channel);
     cq->ibcq = ibv_create_cq(backend_dev->context, cqe + 1, NULL,
                              backend_dev->channel, 0);
+    if (!cq->ibcq) {
+        rdma_error_report("ibv_create_cq fail, errno=%d", errno);
+        return -EIO;
+    }
 
-    if (cq->ibcq) {
-        rc = ibv_req_notify_cq(cq->ibcq, 0);
-        if (rc) {
-            pr_dbg("Error %d from ibv_req_notify_cq\n", rc);
-        }
-        cq->backend_dev = backend_dev;
+    rc = ibv_req_notify_cq(cq->ibcq, 0);
+    if (rc) {
+        rdma_warn_report("ibv_req_notify_cq fail, rc=%d, errno=%d", rc, errno);
     }
 
-    return cq->ibcq ? 0 : -EIO;
+    cq->backend_dev = backend_dev;
+
+    return 0;
 }
 
 void rdma_backend_destroy_cq(RdmaBackendCQ *cq)
@@ -700,7 +672,6 @@ int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
     struct ibv_qp_init_attr attr = {0};
 
     qp->ibqp = 0;
-    pr_dbg("qp_type=%d\n", qp_type);
 
     switch (qp_type) {
     case IBV_QPT_GSI:
@@ -713,7 +684,7 @@ int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
         break;
 
     default:
-        pr_dbg("Unsupported QP type %d\n", qp_type);
+        rdma_error_report("Unsupported QP type %d", qp_type);
         return -EIO;
     }
 
@@ -725,14 +696,9 @@ int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
     attr.cap.max_send_sge = max_send_sge;
     attr.cap.max_recv_sge = max_recv_sge;
 
-    pr_dbg("max_send_wr=%d\n", max_send_wr);
-    pr_dbg("max_recv_wr=%d\n", max_recv_wr);
-    pr_dbg("max_send_sge=%d\n", max_send_sge);
-    pr_dbg("max_recv_sge=%d\n", max_recv_sge);
-
     qp->ibqp = ibv_create_qp(pd->ibpd, &attr);
-    if (likely(!qp->ibqp)) {
-        pr_dbg("Error from ibv_create_qp\n");
+    if (!qp->ibqp) {
+        rdma_error_report("ibv_create_qp fail, errno=%d", errno);
         return -EIO;
     }
 
@@ -740,8 +706,6 @@ int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
 
     /* TODO: Query QP to get max_inline_data and save it to be used in send */
 
-    pr_dbg("qpn=0x%x\n", qp->ibqp->qp_num);
-
     return 0;
 }
 
@@ -751,9 +715,6 @@ int rdma_backend_qp_state_init(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
     struct ibv_qp_attr attr = {0};
     int rc, attr_mask;
 
-    pr_dbg("qpn=0x%x\n", qp->ibqp->qp_num);
-    pr_dbg("sport_num=%d\n", backend_dev->port_num);
-
     attr_mask = IBV_QP_STATE | IBV_QP_PKEY_INDEX | IBV_QP_PORT;
     attr.qp_state        = IBV_QPS_INIT;
     attr.pkey_index      = 0;
@@ -762,21 +723,23 @@ int rdma_backend_qp_state_init(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
     switch (qp_type) {
     case IBV_QPT_RC:
         attr_mask |= IBV_QP_ACCESS_FLAGS;
+        trace_rdma_backend_rc_qp_state_init(qp->ibqp->qp_num);
         break;
 
     case IBV_QPT_UD:
         attr.qkey = qkey;
         attr_mask |= IBV_QP_QKEY;
+        trace_rdma_backend_ud_qp_state_init(qp->ibqp->qp_num, qkey);
         break;
 
     default:
-        pr_dbg("Unsupported QP type %d\n", qp_type);
+        rdma_error_report("Unsupported QP type %d", qp_type);
         return -EIO;
     }
 
     rc = ibv_modify_qp(qp->ibqp, &attr, attr_mask);
     if (rc) {
-        pr_dbg("Error %d from ibv_modify_qp\n", rc);
+        rdma_error_report("ibv_modify_qp fail, rc=%d, errno=%d", rc, errno);
         return -EIO;
     }
 
@@ -802,14 +765,6 @@ int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
 
     switch (qp_type) {
     case IBV_QPT_RC:
-        pr_dbg("dgid=0x%" PRIx64 ",%" PRIx64 "\n",
-               be64_to_cpu(ibv_gid.global.subnet_prefix),
-               be64_to_cpu(ibv_gid.global.interface_id));
-        pr_dbg("dqpn=0x%x\n", dqpn);
-        pr_dbg("sgid_idx=%d\n", qp->sgid_idx);
-        pr_dbg("sport_num=%d\n", backend_dev->port_num);
-        pr_dbg("rq_psn=0x%x\n", rq_psn);
-
         attr.path_mtu               = IBV_MTU_1024;
         attr.dest_qp_num            = dqpn;
         attr.max_dest_rd_atomic     = 1;
@@ -824,20 +779,28 @@ int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
         attr_mask |= IBV_QP_AV | IBV_QP_PATH_MTU | IBV_QP_DEST_QPN |
                      IBV_QP_RQ_PSN | IBV_QP_MAX_DEST_RD_ATOMIC |
                      IBV_QP_MIN_RNR_TIMER;
+
+        trace_rdma_backend_rc_qp_state_rtr(qp->ibqp->qp_num,
+                                           be64_to_cpu(ibv_gid.global.
+                                                       subnet_prefix),
+                                           be64_to_cpu(ibv_gid.global.
+                                                       interface_id),
+                                           qp->sgid_idx, dqpn, rq_psn);
         break;
 
     case IBV_QPT_UD:
-        pr_dbg("qkey=0x%x\n", qkey);
         if (use_qkey) {
             attr.qkey = qkey;
             attr_mask |= IBV_QP_QKEY;
         }
+        trace_rdma_backend_ud_qp_state_rtr(qp->ibqp->qp_num, use_qkey ? qkey :
+                                           0);
         break;
     }
 
     rc = ibv_modify_qp(qp->ibqp, &attr, attr_mask);
     if (rc) {
-        pr_dbg("Error %d from ibv_modify_qp\n", rc);
+        rdma_error_report("ibv_modify_qp fail, rc=%d, errno=%d", rc, errno);
         return -EIO;
     }
 
@@ -850,9 +813,6 @@ int rdma_backend_qp_state_rts(RdmaBackendQP *qp, uint8_t qp_type,
     struct ibv_qp_attr attr = {0};
     int rc, attr_mask;
 
-    pr_dbg("qpn=0x%x\n", qp->ibqp->qp_num);
-    pr_dbg("sq_psn=0x%x\n", sq_psn);
-
     attr.qp_state = IBV_QPS_RTS;
     attr.sq_psn = sq_psn;
     attr_mask = IBV_QP_STATE | IBV_QP_SQ_PSN;
@@ -866,20 +826,22 @@ int rdma_backend_qp_state_rts(RdmaBackendQP *qp, uint8_t qp_type,
 
         attr_mask |= IBV_QP_TIMEOUT | IBV_QP_RETRY_CNT | IBV_QP_RNR_RETRY |
                      IBV_QP_MAX_QP_RD_ATOMIC;
+        trace_rdma_backend_rc_qp_state_rts(qp->ibqp->qp_num, sq_psn);
         break;
 
     case IBV_QPT_UD:
         if (use_qkey) {
-            pr_dbg("qkey=0x%x\n", qkey);
             attr.qkey = qkey;
             attr_mask |= IBV_QP_QKEY;
         }
+        trace_rdma_backend_ud_qp_state_rts(qp->ibqp->qp_num, sq_psn,
+                                           use_qkey ? qkey : 0);
         break;
     }
 
     rc = ibv_modify_qp(qp->ibqp, &attr, attr_mask);
     if (rc) {
-        pr_dbg("Error %d from ibv_modify_qp\n", rc);
+        rdma_error_report("ibv_modify_qp fail, rc=%d, errno=%d", rc, errno);
         return -EIO;
     }
 
@@ -890,7 +852,6 @@ int rdma_backend_query_qp(RdmaBackendQP *qp, struct ibv_qp_attr *attr,
                           int attr_mask, struct ibv_qp_init_attr *init_attr)
 {
     if (!qp->ibqp) {
-        pr_dbg("QP1\n");
         attr->qp_state = IBV_QPS_RTS;
         return 0;
     }
@@ -906,20 +867,23 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp)
 }
 
 #define CHK_ATTR(req, dev, member, fmt) ({ \
-    pr_dbg("%s="fmt","fmt"\n", #member, dev.member, req->member); \
+    trace_rdma_check_dev_attr(#member, dev.member, req->member); \
     if (req->member > dev.member) { \
-        warn_report("%s = "fmt" is higher than host device capability "fmt, \
-                    #member, req->member, dev.member); \
+        rdma_warn_report("%s = "fmt" is higher than host device capability "fmt, \
+                         #member, req->member, dev.member); \
         req->member = dev.member; \
     } \
-    pr_dbg("%s="fmt"\n", #member, req->member); })
+})
 
 static int init_device_caps(RdmaBackendDev *backend_dev,
                             struct ibv_device_attr *dev_attr)
 {
     struct ibv_device_attr bk_dev_attr;
+    int rc;
 
-    if (ibv_query_device(backend_dev->context, &bk_dev_attr)) {
+    rc = ibv_query_device(backend_dev->context, &bk_dev_attr);
+    if (rc) {
+        rdma_error_report("ibv_query_device fail, rc=%d, errno=%d", rc, errno);
         return -EIO;
     }
 
@@ -928,9 +892,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
     CHK_ATTR(dev_attr, bk_dev_attr, max_mr_size, "%" PRId64);
     CHK_ATTR(dev_attr, bk_dev_attr, max_qp, "%d");
     CHK_ATTR(dev_attr, bk_dev_attr, max_sge, "%d");
-    CHK_ATTR(dev_attr, bk_dev_attr, max_qp_wr, "%d");
     CHK_ATTR(dev_attr, bk_dev_attr, max_cq, "%d");
-    CHK_ATTR(dev_attr, bk_dev_attr, max_cqe, "%d");
     CHK_ATTR(dev_attr, bk_dev_attr, max_mr, "%d");
     CHK_ATTR(dev_attr, bk_dev_attr, max_pd, "%d");
     CHK_ATTR(dev_attr, bk_dev_attr, max_qp_rd_atom, "%d");
@@ -946,10 +908,6 @@ static inline void build_mad_hdr(struct ibv_grh *grh, union ibv_gid *sgid,
     grh->paylen = htons(paylen);
     grh->sgid = *sgid;
     grh->dgid = *my_gid;
-
-    pr_dbg("paylen=%d (net=0x%x)\n", paylen, grh->paylen);
-    pr_dbg("dgid=0x%llx\n", my_gid->global.interface_id);
-    pr_dbg("sgid=0x%llx\n", sgid->global.interface_id);
 }
 
 static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
@@ -960,21 +918,13 @@ static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
     BackendCtx *bctx;
     char *mad;
 
-    pr_dbg("umad_len=%d\n", msg->umad_len);
-
-#ifdef PVRDMA_DEBUG
-    struct umad_hdr *hdr = (struct umad_hdr *)&msg->umad.mad;
-    pr_dbg("bv %x cls %x cv %x mtd %x st %d tid %" PRIx64 " at %x atm %x\n",
-           hdr->base_version, hdr->mgmt_class, hdr->class_version,
-           hdr->method, hdr->status, be64toh(hdr->tid),
-           hdr->attr_id, hdr->attr_mod);
-#endif
+    trace_mad_message("recv", msg->umad.mad, msg->umad_len);
 
     qemu_mutex_lock(&backend_dev->recv_mads_list.lock);
     o_ctx_id = qlist_pop(backend_dev->recv_mads_list.list);
     qemu_mutex_unlock(&backend_dev->recv_mads_list.lock);
     if (!o_ctx_id) {
-        pr_dbg("No more free MADs buffers, waiting for a while\n");
+        rdma_warn_report("No more free MADs buffers, waiting for a while");
         sleep(THR_POLL_TO);
         return;
     }
@@ -982,12 +932,10 @@ static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
     cqe_ctx_id = qnum_get_uint(qobject_to(QNum, o_ctx_id));
     bctx = rdma_rm_get_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_id);
     if (unlikely(!bctx)) {
-        pr_dbg("Error: Fail to find ctx for %ld\n", cqe_ctx_id);
+        rdma_error_report("No matching ctx for req %ld", cqe_ctx_id);
         return;
     }
 
-    pr_dbg("id %ld, bctx %p, ctx %p\n", cqe_ctx_id, bctx, bctx->up_ctx);
-
     mad = rdma_pci_dma_map(backend_dev->dev, bctx->sge.addr,
                            bctx->sge.length);
     if (!mad || bctx->sge.length < msg->umad_len + MAD_HDR_SIZE) {
@@ -995,7 +943,6 @@ static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
                       bctx->up_ctx);
     } else {
         struct ibv_wc wc = {0};
-        pr_dbg_buf("mad", msg->umad.mad, msg->umad_len);
         memset(mad, 0, bctx->sge.length);
         build_mad_hdr((struct ibv_grh *)mad,
                       (union ibv_gid *)&msg->umad.hdr.addr.gid, &msg->hdr.sgid,
@@ -1025,13 +972,11 @@ static void rdmacm_mux_read(void *opaque, const uint8_t *buf, int size)
     RdmaBackendDev *backend_dev = (RdmaBackendDev *)opaque;
     RdmaCmMuxMsg *msg = (RdmaCmMuxMsg *)buf;
 
-    pr_dbg("Got %d bytes\n", size);
-    pr_dbg("msg_type=%d\n", msg->hdr.msg_type);
-    pr_dbg("op_code=%d\n", msg->hdr.op_code);
+    trace_rdmacm_mux("read", msg->hdr.msg_type, msg->hdr.op_code);
 
     if (msg->hdr.msg_type != RDMACM_MUX_MSG_TYPE_REQ &&
         msg->hdr.op_code != RDMACM_MUX_OP_CODE_MAD) {
-            pr_dbg("Error: Not a MAD request, skipping\n");
+            rdma_error_report("Error: Not a MAD request, skipping");
             return;
     }
     process_incoming_mad_req(backend_dev, msg);
@@ -1045,7 +990,7 @@ static int mad_init(RdmaBackendDev *backend_dev, CharBackend *mad_chr_be)
 
     ret = qemu_chr_fe_backend_connected(backend_dev->rdmacm_mux.chr_be);
     if (!ret) {
-        pr_dbg("Missing chardev for MAD multiplexer\n");
+        rdma_error_report("Missing chardev for MAD multiplexer");
         return -EIO;
     }
 
@@ -1063,7 +1008,6 @@ static int mad_init(RdmaBackendDev *backend_dev, CharBackend *mad_chr_be)
 
 static void mad_fini(RdmaBackendDev *backend_dev)
 {
-    pr_dbg("Stopping MAD\n");
     disable_rdmacm_mux_async(backend_dev);
     qemu_chr_fe_disconnect(backend_dev->rdmacm_mux.chr_be);
     if (backend_dev->recv_mads_list.list) {
@@ -1079,17 +1023,15 @@ int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,
     int ret;
     int i = 0;
 
-    pr_dbg("0x%llx, 0x%llx\n",
-           (long long unsigned int)be64_to_cpu(gid->global.subnet_prefix),
-           (long long unsigned int)be64_to_cpu(gid->global.interface_id));
-
     do {
         ret = ibv_query_gid(backend_dev->context, backend_dev->port_num, i,
                             &sgid);
         i++;
     } while (!ret && (memcmp(&sgid, gid, sizeof(*gid))));
 
-    pr_dbg("gid_index=%d\n", i - 1);
+    trace_rdma_backend_get_gid_index(be64_to_cpu(gid->global.subnet_prefix),
+                                     be64_to_cpu(gid->global.interface_id),
+                                     i - 1);
 
     return ret ? ret : i - 1;
 }
@@ -1100,16 +1042,15 @@ int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname,
     RdmaCmMuxMsg msg = {};
     int ret;
 
-    pr_dbg("0x%llx, 0x%llx\n",
-           (long long unsigned int)be64_to_cpu(gid->global.subnet_prefix),
-           (long long unsigned int)be64_to_cpu(gid->global.interface_id));
+    trace_rdma_backend_gid_change("add", be64_to_cpu(gid->global.subnet_prefix),
+                                  be64_to_cpu(gid->global.interface_id));
 
     msg.hdr.op_code = RDMACM_MUX_OP_CODE_REG;
     memcpy(msg.hdr.sgid.raw, gid->raw, sizeof(msg.hdr.sgid));
 
-    ret = exec_rdmacm_mux_req(backend_dev, &msg);
+    ret = rdmacm_mux_send(backend_dev, &msg);
     if (ret) {
-        pr_dbg("Fail to register GID to rdma_umadmux (%d)\n", ret);
+        rdma_error_report("Failed to register GID to rdma_umadmux (%d)", ret);
         return -EIO;
     }
 
@@ -1126,16 +1067,16 @@ int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
     RdmaCmMuxMsg msg = {};
     int ret;
 
-    pr_dbg("0x%llx, 0x%llx\n",
-           (long long unsigned int)be64_to_cpu(gid->global.subnet_prefix),
-           (long long unsigned int)be64_to_cpu(gid->global.interface_id));
+    trace_rdma_backend_gid_change("del", be64_to_cpu(gid->global.subnet_prefix),
+                                  be64_to_cpu(gid->global.interface_id));
 
     msg.hdr.op_code = RDMACM_MUX_OP_CODE_UNREG;
     memcpy(msg.hdr.sgid.raw, gid->raw, sizeof(msg.hdr.sgid));
 
-    ret = exec_rdmacm_mux_req(backend_dev, &msg);
+    ret = rdmacm_mux_send(backend_dev, &msg);
     if (ret) {
-        pr_dbg("Fail to unregister GID from rdma_umadmux (%d)\n", ret);
+        rdma_error_report("Failed to unregister GID from rdma_umadmux (%d)",
+                          ret);
         return -EIO;
     }
 
@@ -1196,9 +1137,7 @@ int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
         backend_dev->ib_dev = *dev_list;
     }
 
-    pr_dbg("Using backend device %s, port %d\n",
-           ibv_get_device_name(backend_dev->ib_dev), backend_dev->port_num);
-    pr_dbg("uverb device %s\n", backend_dev->ib_dev->dev_name);
+    rdma_info_report("uverb device %s", backend_dev->ib_dev->dev_name);
 
     backend_dev->context = ibv_open_device(backend_dev->ib_dev);
     if (!backend_dev->context) {
@@ -1213,7 +1152,6 @@ int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
         ret = -EIO;
         goto out_close_device;
     }
-    pr_dbg("dev->backend_dev.channel=%p\n", backend_dev->channel);
 
     ret = init_device_caps(backend_dev, dev_attr);
     if (ret) {
@@ -1225,7 +1163,7 @@ int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
 
     ret = mad_init(backend_dev, mad_chr_be);
     if (ret) {
-        error_setg(errp, "Fail to initialize mad");
+        error_setg(errp, "Failed to initialize mad");
         ret = -EIO;
         goto out_destroy_comm_channel;
     }
@@ -1253,13 +1191,11 @@ out:
 
 void rdma_backend_start(RdmaBackendDev *backend_dev)
 {
-    pr_dbg("Starting rdma_backend\n");
     start_comp_thread(backend_dev);
 }
 
 void rdma_backend_stop(RdmaBackendDev *backend_dev)
 {
-    pr_dbg("Stopping rdma_backend\n");
     stop_backend_thread(&backend_dev->comp_thread);
 }
 
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 268ff633a4..64c6ea1a4e 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 
+#include "trace.h"
 #include "rdma_utils.h"
 #include "rdma_backend.h"
 #include "rdma_rm.h"
@@ -49,25 +50,26 @@ static inline void res_tbl_free(RdmaRmResTbl *tbl)
     g_free(tbl->bitmap);
 }
 
-static inline void *res_tbl_get(RdmaRmResTbl *tbl, uint32_t handle)
+static inline void *rdma_res_tbl_get(RdmaRmResTbl *tbl, uint32_t handle)
 {
-    pr_dbg("%s, handle=%d\n", tbl->name, handle);
+    trace_rdma_res_tbl_get(tbl->name, handle);
 
     if ((handle < tbl->tbl_sz) && (test_bit(handle, tbl->bitmap))) {
         return tbl->tbl + handle * tbl->res_sz;
     } else {
-        pr_dbg("Invalid handle %d\n", handle);
+        rdma_error_report("Table %s, invalid handle %d", tbl->name, handle);
         return NULL;
     }
 }
 
-static inline void *res_tbl_alloc(RdmaRmResTbl *tbl, uint32_t *handle)
+static inline void *rdma_res_tbl_alloc(RdmaRmResTbl *tbl, uint32_t *handle)
 {
     qemu_mutex_lock(&tbl->lock);
 
     *handle = find_first_zero_bit(tbl->bitmap, tbl->tbl_sz);
     if (*handle > tbl->tbl_sz) {
-        pr_dbg("Failed to alloc, bitmap is full\n");
+        rdma_error_report("Table %s, failed to allocate, bitmap is full",
+                          tbl->name);
         qemu_mutex_unlock(&tbl->lock);
         return NULL;
     }
@@ -78,14 +80,14 @@ static inline void *res_tbl_alloc(RdmaRmResTbl *tbl, uint32_t *handle)
 
     memset(tbl->tbl + *handle * tbl->res_sz, 0, tbl->res_sz);
 
-    pr_dbg("%s, handle=%d\n", tbl->name, *handle);
+    trace_rdma_res_tbl_alloc(tbl->name, *handle);
 
     return tbl->tbl + *handle * tbl->res_sz;
 }
 
-static inline void res_tbl_dealloc(RdmaRmResTbl *tbl, uint32_t handle)
+static inline void rdma_res_tbl_dealloc(RdmaRmResTbl *tbl, uint32_t handle)
 {
-    pr_dbg("%s, handle=%d\n", tbl->name, handle);
+    trace_rdma_res_tbl_dealloc(tbl->name, handle);
 
     qemu_mutex_lock(&tbl->lock);
 
@@ -102,7 +104,7 @@ int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
     RdmaRmPD *pd;
     int ret = -ENOMEM;
 
-    pd = res_tbl_alloc(&dev_res->pd_tbl, pd_handle);
+    pd = rdma_res_tbl_alloc(&dev_res->pd_tbl, pd_handle);
     if (!pd) {
         goto out;
     }
@@ -118,7 +120,7 @@ int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
     return 0;
 
 out_tbl_dealloc:
-    res_tbl_dealloc(&dev_res->pd_tbl, *pd_handle);
+    rdma_res_tbl_dealloc(&dev_res->pd_tbl, *pd_handle);
 
 out:
     return ret;
@@ -126,7 +128,7 @@ out:
 
 RdmaRmPD *rdma_rm_get_pd(RdmaDeviceResources *dev_res, uint32_t pd_handle)
 {
-    return res_tbl_get(&dev_res->pd_tbl, pd_handle);
+    return rdma_res_tbl_get(&dev_res->pd_tbl, pd_handle);
 }
 
 void rdma_rm_dealloc_pd(RdmaDeviceResources *dev_res, uint32_t pd_handle)
@@ -135,7 +137,7 @@ void rdma_rm_dealloc_pd(RdmaDeviceResources *dev_res, uint32_t pd_handle)
 
     if (pd) {
         rdma_backend_destroy_pd(&pd->backend_pd);
-        res_tbl_dealloc(&dev_res->pd_tbl, pd_handle);
+        rdma_res_tbl_dealloc(&dev_res->pd_tbl, pd_handle);
     }
 }
 
@@ -150,20 +152,15 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
 
     pd = rdma_rm_get_pd(dev_res, pd_handle);
     if (!pd) {
-        pr_dbg("Invalid PD\n");
         return -EINVAL;
     }
 
-    mr = res_tbl_alloc(&dev_res->mr_tbl, mr_handle);
+    mr = rdma_res_tbl_alloc(&dev_res->mr_tbl, mr_handle);
     if (!mr) {
-        pr_dbg("Failed to allocate obj in table\n");
         return -ENOMEM;
     }
-    pr_dbg("mr_handle=%d\n", *mr_handle);
-
-    pr_dbg("host_virt=0x%p\n", host_virt);
-    pr_dbg("guest_start=0x%" PRIx64 "\n", guest_start);
-    pr_dbg("length=%zu\n", guest_length);
+    trace_rdma_rm_alloc_mr(*mr_handle, host_virt, guest_start, guest_length,
+                           access_flags);
 
     if (host_virt) {
         mr->virt = host_virt;
@@ -174,7 +171,6 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
         ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
                                      mr->length, access_flags);
         if (ret) {
-            pr_dbg("Fail in rdma_backend_create_mr, err=%d\n", ret);
             ret = -EIO;
             goto out_dealloc_mr;
         }
@@ -189,14 +185,14 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
     return 0;
 
 out_dealloc_mr:
-    res_tbl_dealloc(&dev_res->mr_tbl, *mr_handle);
+    rdma_res_tbl_dealloc(&dev_res->mr_tbl, *mr_handle);
 
     return ret;
 }
 
 RdmaRmMR *rdma_rm_get_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle)
 {
-    return res_tbl_get(&dev_res->mr_tbl, mr_handle);
+    return rdma_res_tbl_get(&dev_res->mr_tbl, mr_handle);
 }
 
 void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle)
@@ -205,12 +201,12 @@ void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle)
 
     if (mr) {
         rdma_backend_destroy_mr(&mr->backend_mr);
-        pr_dbg("start=0x%" PRIx64 "\n", mr->start);
+        trace_rdma_rm_dealloc_mr(mr_handle, mr->start);
         if (mr->start) {
             mr->virt -= (mr->start & (TARGET_PAGE_SIZE - 1));
             munmap(mr->virt, mr->length);
         }
-        res_tbl_dealloc(&dev_res->mr_tbl, mr_handle);
+        rdma_res_tbl_dealloc(&dev_res->mr_tbl, mr_handle);
     }
 }
 
@@ -222,12 +218,13 @@ int rdma_rm_alloc_uc(RdmaDeviceResources *dev_res, uint32_t pfn,
     /* TODO: Need to make sure pfn is between bar start address and
      * bsd+RDMA_BAR2_UAR_SIZE
     if (pfn > RDMA_BAR2_UAR_SIZE) {
-        pr_err("pfn out of range (%d > %d)\n", pfn, RDMA_BAR2_UAR_SIZE);
+        rdma_error_report("pfn out of range (%d > %d)", pfn,
+                          RDMA_BAR2_UAR_SIZE);
         return -ENOMEM;
     }
     */
 
-    uc = res_tbl_alloc(&dev_res->uc_tbl, uc_handle);
+    uc = rdma_res_tbl_alloc(&dev_res->uc_tbl, uc_handle);
     if (!uc) {
         return -ENOMEM;
     }
@@ -237,7 +234,7 @@ int rdma_rm_alloc_uc(RdmaDeviceResources *dev_res, uint32_t pfn,
 
 RdmaRmUC *rdma_rm_get_uc(RdmaDeviceResources *dev_res, uint32_t uc_handle)
 {
-    return res_tbl_get(&dev_res->uc_tbl, uc_handle);
+    return rdma_res_tbl_get(&dev_res->uc_tbl, uc_handle);
 }
 
 void rdma_rm_dealloc_uc(RdmaDeviceResources *dev_res, uint32_t uc_handle)
@@ -245,13 +242,13 @@ void rdma_rm_dealloc_uc(RdmaDeviceResources *dev_res, uint32_t uc_handle)
     RdmaRmUC *uc = rdma_rm_get_uc(dev_res, uc_handle);
 
     if (uc) {
-        res_tbl_dealloc(&dev_res->uc_tbl, uc_handle);
+        rdma_res_tbl_dealloc(&dev_res->uc_tbl, uc_handle);
     }
 }
 
 RdmaRmCQ *rdma_rm_get_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle)
 {
-    return res_tbl_get(&dev_res->cq_tbl, cq_handle);
+    return rdma_res_tbl_get(&dev_res->cq_tbl, cq_handle);
 }
 
 int rdma_rm_alloc_cq(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
@@ -260,7 +257,7 @@ int rdma_rm_alloc_cq(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
     int rc;
     RdmaRmCQ *cq;
 
-    cq = res_tbl_alloc(&dev_res->cq_tbl, cq_handle);
+    cq = rdma_res_tbl_alloc(&dev_res->cq_tbl, cq_handle);
     if (!cq) {
         return -ENOMEM;
     }
@@ -287,8 +284,6 @@ void rdma_rm_req_notify_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle,
 {
     RdmaRmCQ *cq;
 
-    pr_dbg("cq_handle=%d, notify=0x%x\n", cq_handle, notify);
-
     cq = rdma_rm_get_cq(dev_res, cq_handle);
     if (!cq) {
         return;
@@ -297,8 +292,6 @@ void rdma_rm_req_notify_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle,
     if (cq->notify != CNT_SET) {
         cq->notify = notify ? CNT_ARM : CNT_CLEAR;
     }
-
-    pr_dbg("notify=%d\n", cq->notify);
 }
 
 void rdma_rm_dealloc_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle)
@@ -312,7 +305,7 @@ void rdma_rm_dealloc_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle)
 
     rdma_backend_destroy_cq(&cq->backend_cq);
 
-    res_tbl_dealloc(&dev_res->cq_tbl, cq_handle);
+    rdma_res_tbl_dealloc(&dev_res->cq_tbl, cq_handle);
 }
 
 RdmaRmQP *rdma_rm_get_qp(RdmaDeviceResources *dev_res, uint32_t qpn)
@@ -323,6 +316,10 @@ RdmaRmQP *rdma_rm_get_qp(RdmaDeviceResources *dev_res, uint32_t qpn)
 
     g_bytes_unref(key);
 
+    if (!qp) {
+        rdma_error_report("Invalid QP handle %d", qpn);
+    }
+
     return qp;
 }
 
@@ -338,11 +335,8 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
     RdmaRmPD *pd;
     uint32_t rm_qpn;
 
-    pr_dbg("qp_type=%d\n", qp_type);
-
     pd = rdma_rm_get_pd(dev_res, pd_handle);
     if (!pd) {
-        pr_err("Invalid pd handle (%d)\n", pd_handle);
         return -EINVAL;
     }
 
@@ -350,8 +344,8 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
     rcq = rdma_rm_get_cq(dev_res, recv_cq_handle);
 
     if (!scq || !rcq) {
-        pr_err("Invalid send_cqn or recv_cqn (%d, %d)\n",
-               send_cq_handle, recv_cq_handle);
+        rdma_error_report("Invalid send_cqn or recv_cqn (%d, %d)",
+                          send_cq_handle, recv_cq_handle);
         return -EINVAL;
     }
 
@@ -360,11 +354,10 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
         rcq->notify = CNT_SET;
     }
 
-    qp = res_tbl_alloc(&dev_res->qp_tbl, &rm_qpn);
+    qp = rdma_res_tbl_alloc(&dev_res->qp_tbl, &rm_qpn);
     if (!qp) {
         return -ENOMEM;
     }
-    pr_dbg("rm_qpn=%d\n", rm_qpn);
 
     qp->qpn = rm_qpn;
     qp->qp_state = IBV_QPS_RESET;
@@ -382,13 +375,13 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
     }
 
     *qpn = rdma_backend_qpn(&qp->backend_qp);
-    pr_dbg("rm_qpn=%d, backend_qpn=0x%x\n", rm_qpn, *qpn);
+    trace_rdma_rm_alloc_qp(rm_qpn, *qpn, qp_type);
     g_hash_table_insert(dev_res->qp_hash, g_bytes_new(qpn, sizeof(*qpn)), qp);
 
     return 0;
 
 out_dealloc_qp:
-    res_tbl_dealloc(&dev_res->qp_tbl, qp->qpn);
+    rdma_res_tbl_dealloc(&dev_res->qp_tbl, qp->qpn);
 
     return rc;
 }
@@ -402,28 +395,22 @@ int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
     RdmaRmQP *qp;
     int ret;
 
-    pr_dbg("qpn=0x%x\n", qp_handle);
-    pr_dbg("qkey=0x%x\n", qkey);
-
     qp = rdma_rm_get_qp(dev_res, qp_handle);
     if (!qp) {
         return -EINVAL;
     }
 
-    pr_dbg("qp_type=%d\n", qp->qp_type);
-    pr_dbg("attr_mask=0x%x\n", attr_mask);
-
     if (qp->qp_type == IBV_QPT_SMI) {
-        pr_dbg("QP0 unsupported\n");
+        rdma_error_report("Got QP0 request");
         return -EPERM;
     } else if (qp->qp_type == IBV_QPT_GSI) {
-        pr_dbg("QP1\n");
         return 0;
     }
 
+    trace_rdma_rm_modify_qp(qp_handle, attr_mask, qp_state, sgid_idx);
+
     if (attr_mask & IBV_QP_STATE) {
         qp->qp_state = qp_state;
-        pr_dbg("qp_state=%d\n", qp->qp_state);
 
         if (qp->qp_state == IBV_QPS_INIT) {
             ret = rdma_backend_qp_state_init(backend_dev, &qp->backend_qp,
@@ -435,11 +422,11 @@ int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
 
         if (qp->qp_state == IBV_QPS_RTR) {
             /* Get backend gid index */
-            pr_dbg("Guest sgid_idx=%d\n", sgid_idx);
             sgid_idx = rdma_rm_get_backend_gid_index(dev_res, backend_dev,
                                                      sgid_idx);
             if (sgid_idx <= 0) { /* TODO check also less than bk.max_sgid */
-                pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n", sgid_idx);
+                rdma_error_report("Failed to get bk sgid_idx for sgid_idx %d",
+                                  sgid_idx);
                 return -EIO;
             }
 
@@ -471,15 +458,11 @@ int rdma_rm_query_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
 {
     RdmaRmQP *qp;
 
-    pr_dbg("qpn=0x%x\n", qp_handle);
-
     qp = rdma_rm_get_qp(dev_res, qp_handle);
     if (!qp) {
         return -EINVAL;
     }
 
-    pr_dbg("qp_type=%d\n", qp->qp_type);
-
     return rdma_backend_query_qp(&qp->backend_qp, attr, attr_mask, init_attr);
 }
 
@@ -499,20 +482,18 @@ void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle)
 
     rdma_backend_destroy_qp(&qp->backend_qp);
 
-    res_tbl_dealloc(&dev_res->qp_tbl, qp->qpn);
+    rdma_res_tbl_dealloc(&dev_res->qp_tbl, qp->qpn);
 }
 
 void *rdma_rm_get_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id)
 {
     void **cqe_ctx;
 
-    cqe_ctx = res_tbl_get(&dev_res->cqe_ctx_tbl, cqe_ctx_id);
+    cqe_ctx = rdma_res_tbl_get(&dev_res->cqe_ctx_tbl, cqe_ctx_id);
     if (!cqe_ctx) {
         return NULL;
     }
 
-    pr_dbg("ctx=%p\n", *cqe_ctx);
-
     return *cqe_ctx;
 }
 
@@ -521,12 +502,11 @@ int rdma_rm_alloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t *cqe_ctx_id,
 {
     void **cqe_ctx;
 
-    cqe_ctx = res_tbl_alloc(&dev_res->cqe_ctx_tbl, cqe_ctx_id);
+    cqe_ctx = rdma_res_tbl_alloc(&dev_res->cqe_ctx_tbl, cqe_ctx_id);
     if (!cqe_ctx) {
         return -ENOMEM;
     }
 
-    pr_dbg("ctx=%p\n", ctx);
     *cqe_ctx = ctx;
 
     return 0;
@@ -534,7 +514,7 @@ int rdma_rm_alloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t *cqe_ctx_id,
 
 void rdma_rm_dealloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id)
 {
-    res_tbl_dealloc(&dev_res->cqe_ctx_tbl, cqe_ctx_id);
+    rdma_res_tbl_dealloc(&dev_res->cqe_ctx_tbl, cqe_ctx_id);
 }
 
 int rdma_rm_add_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
@@ -544,7 +524,6 @@ int rdma_rm_add_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
 
     rc = rdma_backend_add_gid(backend_dev, ifname, gid);
     if (rc) {
-        pr_dbg("Fail to add gid\n");
         return -EINVAL;
     }
 
@@ -565,7 +544,6 @@ int rdma_rm_del_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
     rc = rdma_backend_del_gid(backend_dev, ifname,
                               &dev_res->port.gid_tbl[gid_idx].gid);
     if (rc) {
-        pr_dbg("Fail to delete gid\n");
         return -EINVAL;
     }
 
@@ -580,7 +558,7 @@ int rdma_rm_get_backend_gid_index(RdmaDeviceResources *dev_res,
                                   RdmaBackendDev *backend_dev, int sgid_idx)
 {
     if (unlikely(sgid_idx < 0 || sgid_idx >= MAX_PORT_GIDS)) {
-        pr_dbg("Got invalid sgid_idx %d\n", sgid_idx);
+        rdma_error_report("Got invalid sgid_idx %d", sgid_idx);
         return -EINVAL;
     }
 
@@ -590,9 +568,6 @@ int rdma_rm_get_backend_gid_index(RdmaDeviceResources *dev_res,
                                    &dev_res->port.gid_tbl[sgid_idx].gid);
     }
 
-    pr_dbg("backend_gid_index=%d\n",
-           dev_res->port.gid_tbl[sgid_idx].backend_gid_index);
-
     return dev_res->port.gid_tbl[sgid_idx].backend_gid_index;
 }
 
diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
index 4fbea8cde2..f1c980c6be 100644
--- a/hw/rdma/rdma_utils.c
+++ b/hw/rdma/rdma_utils.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "trace.h"
 #include "rdma_utils.h"
 
 #ifdef PVRDMA_DEBUG
@@ -26,14 +27,14 @@ void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen)
     hwaddr len = plen;
 
     if (!addr) {
-        pr_dbg("addr is NULL\n");
+        rdma_error_report("addr is NULL");
         return NULL;
     }
 
     p = pci_dma_map(dev, addr, &len, DMA_DIRECTION_TO_DEVICE);
     if (!p) {
-        pr_dbg("Fail in pci_dma_map, addr=0x%" PRIx64 ", len=%" PRId64 "\n",
-               addr, len);
+        rdma_error_report("pci_dma_map fail, addr=0x%"PRIx64", len=%"PRId64,
+                          addr, len);
         return NULL;
     }
 
@@ -42,14 +43,14 @@ void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen)
         return NULL;
     }
 
-    pr_dbg("0x%" PRIx64 " -> %p (len=% " PRId64 ")\n", addr, p, len);
+    trace_rdma_pci_dma_map(addr, p, len);
 
     return p;
 }
 
 void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len)
 {
-    pr_dbg("%p\n", buffer);
+    trace_rdma_pci_dma_unmap(buffer);
     if (buffer) {
         pci_dma_unmap(dev, buffer, len, DMA_DIRECTION_TO_DEVICE, 0);
     }
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
index 4490ea0b94..acd148837f 100644
--- a/hw/rdma/rdma_utils.h
+++ b/hw/rdma/rdma_utils.h
@@ -17,48 +17,17 @@
 #ifndef RDMA_UTILS_H
 #define RDMA_UTILS_H
 
+#include "qemu/error-report.h"
 #include "hw/pci/pci.h"
 #include "sysemu/dma.h"
 #include "stdio.h"
 
-#define pr_info(fmt, ...) \
-    fprintf(stdout, "%s: %-20s (%3d): " fmt, "rdma",  __func__, __LINE__,\
-           ## __VA_ARGS__)
-
-#define pr_err(fmt, ...) \
-    fprintf(stderr, "%s: Error at %-20s (%3d): " fmt, "rdma", __func__, \
-        __LINE__, ## __VA_ARGS__)
-
-#ifdef PVRDMA_DEBUG
-extern unsigned long pr_dbg_cnt;
-
-#define init_pr_dbg(void) \
-{ \
-    pr_dbg_cnt = 0; \
-}
-
-#define pr_dbg(fmt, ...) \
-    fprintf(stdout, "%lx %ld: %-20s (%3d): " fmt, pthread_self(), pr_dbg_cnt++, \
-            __func__, __LINE__, ## __VA_ARGS__)
-
-#define pr_dbg_buf(title, buf, len) \
-{ \
-    int i; \
-    char *b = g_malloc0(len * 3 + 1); \
-    char b1[4]; \
-    for (i = 0; i < len; i++) { \
-        sprintf(b1, "%.2X ", buf[i] & 0x000000FF); \
-        strcat(b, b1); \
-    } \
-    pr_dbg("%s (%d): %s\n", title, len, b); \
-    g_free(b); \
-}
-
-#else
-#define init_pr_dbg(void)
-#define pr_dbg(fmt, ...)
-#define pr_dbg_buf(title, buf, len)
-#endif
+#define rdma_error_report(fmt, ...) \
+    error_report("%s: " fmt, "rdma", ## __VA_ARGS__)
+#define rdma_warn_report(fmt, ...) \
+    warn_report("%s: " fmt, "rdma", ## __VA_ARGS__)
+#define rdma_info_report(fmt, ...) \
+    info_report("%s: " fmt, "rdma", ## __VA_ARGS__)
 
 void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen);
 void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);
diff --git a/hw/rdma/trace-events b/hw/rdma/trace-events
index c4c202e647..09cec43fd8 100644
--- a/hw/rdma/trace-events
+++ b/hw/rdma/trace-events
@@ -1,5 +1,31 @@
 # See docs/tracing.txt for syntax documentation.
 
-#hw/rdma/rdma_backend.c
-create_ah_cache_hit(uint64_t subnet, uint64_t net_id) "subnet = 0x%"PRIx64" net_id = 0x%"PRIx64
-create_ah_cache_miss(uint64_t subnet, uint64_t net_id) "subnet = 0x%"PRIx64" net_id = 0x%"PRIx64
+# hw/rdma/rdma_backend.c
+rdma_check_dev_attr(const char *name, int max_bk, int max_fe) "%s: be=%d, fe=%d"
+rdma_create_ah_cache_hit(uint64_t subnet, uint64_t if_id) "subnet=0x%"PRIx64",if_id=0x%"PRIx64
+rdma_create_ah_cache_miss(uint64_t subnet, uint64_t if_id) "subnet=0x%"PRIx64",if_id=0x%"PRIx64
+rdma_poll_cq(int ne, void *ibcq) "Got %d completion(s) from cq %p"
+rdmacm_mux(const char *title, int msg_type, int op_code) "%s: msg_type=%d, op_code=%d"
+rdmacm_mux_check_op_status(int msg_type, int op_code, int err_code) "resp: msg_type=%d, op_code=%d, err_code=%d"
+rdma_mad_message(const char *title, size_t len, char *data) "mad %s (%ld): %s"
+rdma_backend_rc_qp_state_init(uint32_t qpn) "RC QP 0x%x switch to INIT"
+rdma_backend_ud_qp_state_init(uint32_t qpn, uint32_t qkey) "UD QP 0x%x switch to INIT, qkey=0x%x"
+rdma_backend_rc_qp_state_rtr(uint32_t qpn, uint64_t subnet, uint64_t ifid, uint8_t sgid_idx, uint32_t dqpn, uint32_t rq_psn) "RC QP 0x%x switch to RTR, subnet = 0x%"PRIx64", ifid = 0x%"PRIx64 ", sgid_idx=%d, dqpn=0x%x, rq_psn=0x%x"
+rdma_backend_ud_qp_state_rtr(uint32_t qpn, uint32_t qkey) "UD QP 0x%x switch to RTR, qkey=0x%x"
+rdma_backend_rc_qp_state_rts(uint32_t qpn, uint32_t sq_psn) "RC QP 0x%x switch to RTS, sq_psn=0x%x, "
+rdma_backend_ud_qp_state_rts(uint32_t qpn, uint32_t sq_psn, uint32_t qkey) "UD QP 0x%x switch to RTS, sq_psn=0x%x, qkey=0x%x"
+rdma_backend_get_gid_index(uint64_t subnet, uint64_t ifid, int gid_idx) "subnet=0x%"PRIx64", ifid=0x%"PRIx64 ", gid_idx=%d"
+rdma_backend_gid_change(const char *op, uint64_t subnet, uint64_t ifid) "%s subnet=0x%"PRIx64", ifid=0x%"PRIx64
+
+# hw/rdma/rdma_rm.c
+rdma_res_tbl_get(char *name, uint32_t handle) "tbl %s, handle %d"
+rdma_res_tbl_alloc(char *name, uint32_t handle) "tbl %s, handle %d"
+rdma_res_tbl_dealloc(char *name, uint32_t handle) "tbl %s, handle %d"
+rdma_rm_alloc_mr(uint32_t mr_handle, void *host_virt, uint64_t guest_start, size_t guest_length, int access_flags) "mr_handle=%d, host_virt=%p, guest_start=0x%"PRIx64", length=%ld, access_flags=0x%x"
+rdma_rm_dealloc_mr(uint32_t mr_handle, uint64_t guest_start) "mr_handle=%d, guest_start=0x%"PRIx64
+rdma_rm_alloc_qp(uint32_t rm_qpn, uint32_t backend_qpn, uint8_t qp_type) "rm_qpn=%d, backend_qpn=0x%x, qp_type=%d"
+rdma_rm_modify_qp(uint32_t qpn, uint32_t attr_mask, int qp_state, uint8_t sgid_idx) "qpn=0x%x, attr_mask=0x%x, qp_state=%d, sgid_idx=%d"
+
+# hw/rdma/rdma_utils.c
+rdma_pci_dma_map(uint64_t addr, void *vaddr, uint64_t len) "0x%"PRIx64" -> %p (len=%" PRId64")"
+rdma_pci_dma_unmap(void *vaddr) "%p"
diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index ffae36986e..0879224957 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -127,6 +127,6 @@ static inline void post_interrupt(PVRDMADev *dev, unsigned vector)
     }
 }
 
-int execute_command(PVRDMADev *dev);
+int pvrdma_exec_cmd(PVRDMADev *dev);
 
 #endif
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 89920887bf..21a55e225a 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -14,7 +14,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
@@ -24,6 +23,7 @@
 #include "../rdma_rm.h"
 #include "../rdma_utils.h"
 
+#include "trace.h"
 #include "pvrdma.h"
 #include "standard-headers/rdma/vmw_pvrdma-abi.h"
 
@@ -35,40 +35,38 @@ static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma,
     void *host_virt = NULL, *curr_page;
 
     if (!nchunks) {
-        pr_dbg("nchunks=0\n");
+        rdma_error_report("Got nchunks=0");
         return NULL;
     }
 
     dir = rdma_pci_dma_map(pdev, pdir_dma, TARGET_PAGE_SIZE);
     if (!dir) {
-        error_report("PVRDMA: Failed to map to page directory");
+        rdma_error_report("Failed to map to page directory");
         return NULL;
     }
 
     tbl = rdma_pci_dma_map(pdev, dir[0], TARGET_PAGE_SIZE);
     if (!tbl) {
-        error_report("PVRDMA: Failed to map to page table 0");
+        rdma_error_report("Failed to map to page table 0");
         goto out_unmap_dir;
     }
 
     curr_page = rdma_pci_dma_map(pdev, (dma_addr_t)tbl[0], TARGET_PAGE_SIZE);
     if (!curr_page) {
-        error_report("PVRDMA: Failed to map the first page");
+        rdma_error_report("Failed to map the page 0");
         goto out_unmap_tbl;
     }
 
     host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
-    pr_dbg("mremap %p -> %p\n", curr_page, host_virt);
     if (host_virt == MAP_FAILED) {
         host_virt = NULL;
-        error_report("PVRDMA: Failed to remap memory for host_virt");
+        rdma_error_report("Failed to remap memory for host_virt");
         goto out_unmap_tbl;
     }
+    trace_pvrdma_map_to_pdir_host_virt(curr_page, host_virt);
 
     rdma_pci_dma_unmap(pdev, curr_page, TARGET_PAGE_SIZE);
 
-    pr_dbg("host_virt=%p\n", host_virt);
-
     dir_idx = 0;
     tbl_idx = 1;
     addr_idx = 1;
@@ -76,28 +74,28 @@ static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma,
         if (tbl_idx == TARGET_PAGE_SIZE / sizeof(uint64_t)) {
             tbl_idx = 0;
             dir_idx++;
-            pr_dbg("Mapping to table %d\n", dir_idx);
             rdma_pci_dma_unmap(pdev, tbl, TARGET_PAGE_SIZE);
             tbl = rdma_pci_dma_map(pdev, dir[dir_idx], TARGET_PAGE_SIZE);
             if (!tbl) {
-                error_report("PVRDMA: Failed to map to page table %d", dir_idx);
+                rdma_error_report("Failed to map to page table %d", dir_idx);
                 goto out_unmap_host_virt;
             }
         }
 
-        pr_dbg("guest_dma[%d]=0x%" PRIx64 "\n", addr_idx, tbl[tbl_idx]);
-
         curr_page = rdma_pci_dma_map(pdev, (dma_addr_t)tbl[tbl_idx],
                                      TARGET_PAGE_SIZE);
         if (!curr_page) {
-            error_report("PVRDMA: Failed to map to page %d, dir %d", tbl_idx,
-                         dir_idx);
+            rdma_error_report("Failed to map to page %d, dir %d", tbl_idx,
+                              dir_idx);
             goto out_unmap_host_virt;
         }
 
         mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
                host_virt + TARGET_PAGE_SIZE * addr_idx);
 
+        trace_pvrdma_map_to_pdir_next_page(addr_idx, curr_page, host_virt +
+                                           TARGET_PAGE_SIZE * addr_idx);
+
         rdma_pci_dma_unmap(pdev, curr_page, TARGET_PAGE_SIZE);
 
         addr_idx++;
@@ -127,7 +125,6 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct pvrdma_cmd_query_port_resp *resp = &rsp->query_port_resp;
     struct pvrdma_port_attr attrs = {0};
 
-    pr_dbg("port=%d\n", cmd->port_num);
     if (cmd->port_num > MAX_PORTS) {
         return -EINVAL;
     }
@@ -159,12 +156,10 @@ static int query_pkey(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct pvrdma_cmd_query_pkey *cmd = &req->query_pkey;
     struct pvrdma_cmd_query_pkey_resp *resp = &rsp->query_pkey_resp;
 
-    pr_dbg("port=%d\n", cmd->port_num);
     if (cmd->port_num > MAX_PORTS) {
         return -EINVAL;
     }
 
-    pr_dbg("index=%d\n", cmd->index);
     if (cmd->index > MAX_PKEYS) {
         return -EINVAL;
     }
@@ -172,7 +167,6 @@ static int query_pkey(PVRDMADev *dev, union pvrdma_cmd_req *req,
     memset(resp, 0, sizeof(*resp));
 
     resp->pkey = PVRDMA_PKEY;
-    pr_dbg("pkey=0x%x\n", resp->pkey);
 
     return 0;
 }
@@ -184,8 +178,6 @@ static int create_pd(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct pvrdma_cmd_create_pd_resp *resp = &rsp->create_pd_resp;
     int rc;
 
-    pr_dbg("context=0x%x\n", cmd->ctx_handle ? cmd->ctx_handle : 0);
-
     memset(resp, 0, sizeof(*resp));
     rc = rdma_rm_alloc_pd(&dev->rdma_dev_res, &dev->backend_dev,
                           &resp->pd_handle, cmd->ctx_handle);
@@ -198,8 +190,6 @@ static int destroy_pd(PVRDMADev *dev, union pvrdma_cmd_req *req,
 {
     struct pvrdma_cmd_destroy_pd *cmd = &req->destroy_pd;
 
-    pr_dbg("pd_handle=%d\n", cmd->pd_handle);
-
     rdma_rm_dealloc_pd(&dev->rdma_dev_res, cmd->pd_handle);
 
     return 0;
@@ -216,15 +206,11 @@ static int create_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
 
     memset(resp, 0, sizeof(*resp));
 
-    pr_dbg("pd_handle=%d\n", cmd->pd_handle);
-    pr_dbg("access_flags=0x%x\n", cmd->access_flags);
-    pr_dbg("flags=0x%x\n", cmd->flags);
-
     if (!(cmd->flags & PVRDMA_MR_FLAG_DMA)) {
         host_virt = pvrdma_map_to_pdir(pci_dev, cmd->pdir_dma, cmd->nchunks,
                                        cmd->length);
         if (!host_virt) {
-            pr_dbg("Failed to map to pdir\n");
+            rdma_error_report("Failed to map to pdir");
             return -EINVAL;
         }
     }
@@ -244,8 +230,6 @@ static int destroy_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
 {
     struct pvrdma_cmd_destroy_mr *cmd = &req->destroy_mr;
 
-    pr_dbg("mr_handle=%d\n", cmd->mr_handle);
-
     rdma_rm_dealloc_mr(&dev->rdma_dev_res, cmd->mr_handle);
 
     return 0;
@@ -260,20 +244,19 @@ static int create_cq_ring(PCIDevice *pci_dev , PvrdmaRing **ring,
     char ring_name[MAX_RING_NAME_SZ];
 
     if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES) {
-        pr_dbg("invalid nchunks: %d\n", nchunks);
+        rdma_error_report("Got invalid nchunks: %d", nchunks);
         return rc;
     }
 
-    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
     dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
     if (!dir) {
-        pr_dbg("Failed to map to CQ page directory\n");
+        rdma_error_report("Failed to map to CQ page directory");
         goto out;
     }
 
     tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
     if (!tbl) {
-        pr_dbg("Failed to map to CQ page table\n");
+        rdma_error_report("Failed to map to CQ page table");
         goto out;
     }
 
@@ -284,7 +267,7 @@ static int create_cq_ring(PCIDevice *pci_dev , PvrdmaRing **ring,
         rdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
 
     if (!r->ring_state) {
-        pr_dbg("Failed to map to CQ ring state\n");
+        rdma_error_report("Failed to map to CQ ring state");
         goto out_free_ring;
     }
 
@@ -339,8 +322,6 @@ static int create_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
         return rc;
     }
 
-    pr_dbg("ring=%p\n", ring);
-
     rc = rdma_rm_alloc_cq(&dev->rdma_dev_res, &dev->backend_dev, cmd->cqe,
                           &resp->cq_handle, ring);
     if (rc) {
@@ -359,11 +340,9 @@ static int destroy_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
     RdmaRmCQ *cq;
     PvrdmaRing *ring;
 
-    pr_dbg("cq_handle=%d\n", cmd->cq_handle);
-
     cq = rdma_rm_get_cq(&dev->rdma_dev_res, cmd->cq_handle);
     if (!cq) {
-        pr_dbg("Invalid CQ handle\n");
+        rdma_error_report("Got invalid CQ handle");
         return -EINVAL;
     }
 
@@ -388,42 +367,33 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
 
     if (!spages || spages > PVRDMA_MAX_FAST_REG_PAGES
         || !rpages || rpages > PVRDMA_MAX_FAST_REG_PAGES) {
-        pr_dbg("invalid pages: %d, %d\n", spages, rpages);
+        rdma_error_report("Got invalid page count for QP ring: %d, %d", spages,
+                          rpages);
         return rc;
     }
 
-    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
     dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
     if (!dir) {
-        pr_dbg("Failed to map to CQ page directory\n");
+        rdma_error_report("Failed to map to CQ page directory");
         goto out;
     }
 
     tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
     if (!tbl) {
-        pr_dbg("Failed to map to CQ page table\n");
+        rdma_error_report("Failed to map to CQ page table");
         goto out;
     }
 
     sr = g_malloc(2 * sizeof(*rr));
     rr = &sr[1];
-    pr_dbg("sring=%p\n", sr);
-    pr_dbg("rring=%p\n", rr);
 
     *rings = sr;
 
-    pr_dbg("scqe=%d\n", scqe);
-    pr_dbg("smax_sge=%d\n", smax_sge);
-    pr_dbg("spages=%d\n", spages);
-    pr_dbg("rcqe=%d\n", rcqe);
-    pr_dbg("rmax_sge=%d\n", rmax_sge);
-    pr_dbg("rpages=%d\n", rpages);
-
     /* Create send ring */
     sr->ring_state = (struct pvrdma_ring *)
         rdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
     if (!sr->ring_state) {
-        pr_dbg("Failed to map to CQ ring state\n");
+        rdma_error_report("Failed to map to CQ ring state");
         goto out_free_sr_mem;
     }
 
@@ -468,9 +438,7 @@ out:
 
 static void destroy_qp_rings(PvrdmaRing *ring)
 {
-    pr_dbg("sring=%p\n", &ring[0]);
     pvrdma_ring_free(&ring[0]);
-    pr_dbg("rring=%p\n", &ring[1]);
     pvrdma_ring_free(&ring[1]);
 
     rdma_pci_dma_unmap(ring->dev, ring->ring_state, TARGET_PAGE_SIZE);
@@ -487,9 +455,6 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
 
     memset(resp, 0, sizeof(*resp));
 
-    pr_dbg("total_chunks=%d\n", cmd->total_chunks);
-    pr_dbg("send_chunks=%d\n", cmd->send_chunks);
-
     rc = create_qp_rings(PCI_DEVICE(dev), cmd->pdir_dma, &rings,
                          cmd->max_send_wr, cmd->max_send_sge, cmd->send_chunks,
                          cmd->max_recv_wr, cmd->max_recv_sge,
@@ -498,8 +463,6 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
         return rc;
     }
 
-    pr_dbg("rings=%p\n", rings);
-
     rc = rdma_rm_alloc_qp(&dev->rdma_dev_res, cmd->pd_handle, cmd->qp_type,
                           cmd->max_send_wr, cmd->max_send_sge,
                           cmd->send_cq_handle, cmd->max_recv_wr,
@@ -525,8 +488,6 @@ static int modify_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct pvrdma_cmd_modify_qp *cmd = &req->modify_qp;
     int rc;
 
-    pr_dbg("qp_handle=%d\n", cmd->qp_handle);
-
     memset(rsp, 0, sizeof(*rsp));
 
     /* No need to verify sgid_index since it is u8 */
@@ -551,9 +512,6 @@ static int query_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct ibv_qp_init_attr init_attr;
     int rc;
 
-    pr_dbg("qp_handle=%d\n", cmd->qp_handle);
-    pr_dbg("attr_mask=0x%x\n", cmd->attr_mask);
-
     memset(rsp, 0, sizeof(*rsp));
 
     rc = rdma_rm_query_qp(&dev->rdma_dev_res, &dev->backend_dev, cmd->qp_handle,
@@ -572,7 +530,6 @@ static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
 
     qp = rdma_rm_get_qp(&dev->rdma_dev_res, cmd->qp_handle);
     if (!qp) {
-        pr_dbg("Invalid QP handle\n");
         return -EINVAL;
     }
 
@@ -591,16 +548,10 @@ static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
     int rc;
     union ibv_gid *gid = (union ibv_gid *)&cmd->new_gid;
 
-    pr_dbg("index=%d\n", cmd->index);
-
     if (cmd->index >= MAX_PORT_GIDS) {
         return -EINVAL;
     }
 
-    pr_dbg("gid[%d]=0x%llx,0x%llx\n", cmd->index,
-           (long long unsigned int)be64_to_cpu(gid->global.subnet_prefix),
-           (long long unsigned int)be64_to_cpu(gid->global.interface_id));
-
     rc = rdma_rm_add_gid(&dev->rdma_dev_res, &dev->backend_dev,
                          dev->backend_eth_device_name, gid, cmd->index);
 
@@ -614,8 +565,6 @@ static int destroy_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
 
     struct pvrdma_cmd_destroy_bind *cmd = &req->destroy_bind;
 
-    pr_dbg("index=%d\n", cmd->index);
-
     if (cmd->index >= MAX_PORT_GIDS) {
         return -EINVAL;
     }
@@ -633,8 +582,6 @@ static int create_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct pvrdma_cmd_create_uc_resp *resp = &rsp->create_uc_resp;
     int rc;
 
-    pr_dbg("pfn=%d\n", cmd->pfn);
-
     memset(resp, 0, sizeof(*resp));
     rc = rdma_rm_alloc_uc(&dev->rdma_dev_res, cmd->pfn, &resp->ctx_handle);
 
@@ -646,8 +593,6 @@ static int destroy_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
 {
     struct pvrdma_cmd_destroy_uc *cmd = &req->destroy_uc;
 
-    pr_dbg("ctx_handle=%d\n", cmd->ctx_handle);
-
     rdma_rm_dealloc_uc(&dev->rdma_dev_res, cmd->ctx_handle);
 
     return 0;
@@ -680,22 +625,21 @@ static struct cmd_handler cmd_handlers[] = {
     {PVRDMA_CMD_DESTROY_BIND, PVRDMA_CMD_DESTROY_BIND_RESP_NOOP, destroy_bind},
 };
 
-int execute_command(PVRDMADev *dev)
+int pvrdma_exec_cmd(PVRDMADev *dev)
 {
     int err = 0xFFFF;
     DSRInfo *dsr_info;
 
     dsr_info = &dev->dsr_info;
 
-    pr_dbg("cmd=%d\n", dsr_info->req->hdr.cmd);
     if (dsr_info->req->hdr.cmd >= sizeof(cmd_handlers) /
                       sizeof(struct cmd_handler)) {
-        pr_dbg("Unsupported command\n");
+        rdma_error_report("Unsupported command");
         goto out;
     }
 
     if (!cmd_handlers[dsr_info->req->hdr.cmd].exec) {
-        pr_dbg("Unsupported command (not implemented yet)\n");
+        rdma_error_report("Unsupported command (not implemented yet)");
         goto out;
     }
 
@@ -704,7 +648,8 @@ int execute_command(PVRDMADev *dev)
     dsr_info->rsp->hdr.response = dsr_info->req->hdr.response;
     dsr_info->rsp->hdr.ack = cmd_handlers[dsr_info->req->hdr.cmd].ack;
     dsr_info->rsp->hdr.err = err < 0 ? -err : 0;
-    pr_dbg("rsp->hdr.err=%d\n", dsr_info->rsp->hdr.err);
+
+    trace_pvrdma_exec_cmd(dsr_info->req->hdr.cmd, dsr_info->rsp->hdr.err);
 
 out:
     set_reg_val(dev, PVRDMA_REG_ERR, err);
diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.c
index e8e5b502f6..d7bc7f5ccc 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.c
+++ b/hw/rdma/vmw/pvrdma_dev_ring.c
@@ -17,6 +17,8 @@
 #include "hw/pci/pci.h"
 #include "cpu.h"
 
+#include "trace.h"
+
 #include "../rdma_utils.h"
 #include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h"
 #include "pvrdma_dev_ring.h"
@@ -30,13 +32,10 @@ int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
 
     strncpy(ring->name, name, MAX_RING_NAME_SZ);
     ring->name[MAX_RING_NAME_SZ - 1] = 0;
-    pr_dbg("Initializing %s ring\n", ring->name);
     ring->dev = dev;
     ring->ring_state = ring_state;
     ring->max_elems = max_elems;
     ring->elem_sz = elem_sz;
-    pr_dbg("ring->elem_sz=%zu\n", ring->elem_sz);
-    pr_dbg("npages=%d\n", npages);
     /* TODO: Give a moment to think if we want to redo driver settings
     atomic_set(&ring->ring_state->prod_tail, 0);
     atomic_set(&ring->ring_state->cons_head, 0);
@@ -46,14 +45,14 @@ int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
 
     for (i = 0; i < npages; i++) {
         if (!tbl[i]) {
-            pr_err("npages=%ld but tbl[%d] is NULL\n", (long)npages, i);
+            rdma_error_report("npages=%d but tbl[%d] is NULL", npages, i);
             continue;
         }
 
         ring->pages[i] = rdma_pci_dma_map(dev, tbl[i], TARGET_PAGE_SIZE);
         if (!ring->pages[i]) {
             rc = -ENOMEM;
-            pr_dbg("Failed to map to page %d\n", i);
+            rdma_error_report("Failed to map to page %d in ring %s", i, name);
             goto out_free;
         }
         memset(ring->pages[i], 0, TARGET_PAGE_SIZE);
@@ -78,7 +77,7 @@ void *pvrdma_ring_next_elem_read(PvrdmaRing *ring)
 
     e = pvrdma_idx_ring_has_data(ring->ring_state, ring->max_elems, &idx);
     if (e <= 0) {
-        pr_dbg("No more data in ring\n");
+        trace_pvrdma_ring_next_elem_read_no_data(ring->name);
         return NULL;
     }
 
@@ -89,11 +88,6 @@ void *pvrdma_ring_next_elem_read(PvrdmaRing *ring)
 void pvrdma_ring_read_inc(PvrdmaRing *ring)
 {
     pvrdma_idx_ring_inc(&ring->ring_state->cons_head, ring->max_elems);
-    /*
-    pr_dbg("%s: t=%d, h=%d, m=%ld\n", ring->name,
-           ring->ring_state->prod_tail, ring->ring_state->cons_head,
-           ring->max_elems);
-    */
 }
 
 void *pvrdma_ring_next_elem_write(PvrdmaRing *ring)
@@ -103,13 +97,13 @@ void *pvrdma_ring_next_elem_write(PvrdmaRing *ring)
 
     idx = pvrdma_idx_ring_has_space(ring->ring_state, ring->max_elems, &tail);
     if (idx <= 0) {
-        pr_dbg("CQ is full\n");
+        rdma_error_report("CQ is full");
         return NULL;
     }
 
     idx = pvrdma_idx(&ring->ring_state->prod_tail, ring->max_elems);
     if (idx < 0 || tail != idx) {
-        pr_dbg("invalid idx\n");
+        rdma_error_report("Invalid idx %d", idx);
         return NULL;
     }
 
@@ -120,11 +114,6 @@ void *pvrdma_ring_next_elem_write(PvrdmaRing *ring)
 void pvrdma_ring_write_inc(PvrdmaRing *ring)
 {
     pvrdma_idx_ring_inc(&ring->ring_state->prod_tail, ring->max_elems);
-    /*
-    pr_dbg("%s: t=%d, h=%d, m=%ld\n", ring->name,
-           ring->ring_state->prod_tail, ring->ring_state->cons_head,
-           ring->max_elems);
-    */
 }
 
 void pvrdma_ring_free(PvrdmaRing *ring)
@@ -137,7 +126,6 @@ void pvrdma_ring_free(PvrdmaRing *ring)
         return;
     }
 
-    pr_dbg("ring->npages=%d\n", ring->npages);
     while (ring->npages--) {
         rdma_pci_dma_unmap(ring->dev, ring->pages[ring->npages],
                            TARGET_PAGE_SIZE);
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index d2bdb5ba8c..b6061f4b6e 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -69,25 +69,22 @@ static int init_dev_ring(PvrdmaRing *ring, struct pvrdma_ring **ring_state,
     uint64_t *dir, *tbl;
     int rc = 0;
 
-    pr_dbg("Initializing device ring %s\n", name);
-    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)dir_addr);
-    pr_dbg("num_pages=%d\n", num_pages);
     dir = rdma_pci_dma_map(pci_dev, dir_addr, TARGET_PAGE_SIZE);
     if (!dir) {
-        pr_err("Failed to map to page directory\n");
+        rdma_error_report("Failed to map to page directory (ring %s)", name);
         rc = -ENOMEM;
         goto out;
     }
     tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
     if (!tbl) {
-        pr_err("Failed to map to page table\n");
+        rdma_error_report("Failed to map to page table (ring %s)", name);
         rc = -ENOMEM;
         goto out_free_dir;
     }
 
     *ring_state = rdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
     if (!*ring_state) {
-        pr_err("Failed to map to ring state\n");
+        rdma_error_report("Failed to map to ring state (ring %s)", name);
         rc = -ENOMEM;
         goto out_free_tbl;
     }
@@ -100,7 +97,6 @@ static int init_dev_ring(PvrdmaRing *ring, struct pvrdma_ring **ring_state,
                           sizeof(struct pvrdma_cqne),
                           (dma_addr_t *)&tbl[1], (dma_addr_t)num_pages - 1);
     if (rc) {
-        pr_err("Failed to initialize ring\n");
         rc = -ENOMEM;
         goto out_free_ring_state;
     }
@@ -155,11 +151,10 @@ static int load_dsr(PVRDMADev *dev)
     free_dsr(dev);
 
     /* Map to DSR */
-    pr_dbg("dsr_dma=0x%llx\n", (long long unsigned int)dev->dsr_info.dma);
     dev->dsr_info.dsr = rdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
                               sizeof(struct pvrdma_device_shared_region));
     if (!dev->dsr_info.dsr) {
-        pr_err("Failed to map to DSR\n");
+        rdma_error_report("Failed to map to DSR");
         rc = -ENOMEM;
         goto out;
     }
@@ -169,21 +164,19 @@ static int load_dsr(PVRDMADev *dev)
     dsr = dsr_info->dsr;
 
     /* Map to command slot */
-    pr_dbg("cmd_dma=0x%llx\n", (long long unsigned int)dsr->cmd_slot_dma);
     dsr_info->req = rdma_pci_dma_map(pci_dev, dsr->cmd_slot_dma,
                                      sizeof(union pvrdma_cmd_req));
     if (!dsr_info->req) {
-        pr_err("Failed to map to command slot address\n");
+        rdma_error_report("Failed to map to command slot address");
         rc = -ENOMEM;
         goto out_free_dsr;
     }
 
     /* Map to response slot */
-    pr_dbg("rsp_dma=0x%llx\n", (long long unsigned int)dsr->resp_slot_dma);
     dsr_info->rsp = rdma_pci_dma_map(pci_dev, dsr->resp_slot_dma,
                                      sizeof(union pvrdma_cmd_resp));
     if (!dsr_info->rsp) {
-        pr_err("Failed to map to response slot address\n");
+        rdma_error_report("Failed to map to response slot address");
         rc = -ENOMEM;
         goto out_free_req;
     }
@@ -193,7 +186,6 @@ static int load_dsr(PVRDMADev *dev)
                        pci_dev, dsr->cq_ring_pages.pdir_dma,
                        dsr->cq_ring_pages.num_pages);
     if (rc) {
-        pr_err("Failed to map to initialize CQ ring\n");
         rc = -ENOMEM;
         goto out_free_rsp;
     }
@@ -203,7 +195,6 @@ static int load_dsr(PVRDMADev *dev)
                        "dev_async", pci_dev, dsr->async_ring_pages.pdir_dma,
                        dsr->async_ring_pages.num_pages);
     if (rc) {
-        pr_err("Failed to map to initialize event ring\n");
         rc = -ENOMEM;
         goto out_free_rsp;
     }
@@ -230,24 +221,15 @@ static void init_dsr_dev_caps(PVRDMADev *dev)
     struct pvrdma_device_shared_region *dsr;
 
     if (dev->dsr_info.dsr == NULL) {
-        pr_err("Can't initialized DSR\n");
+        rdma_error_report("Can't initialized DSR");
         return;
     }
 
     dsr = dev->dsr_info.dsr;
-
     dsr->caps.fw_ver = PVRDMA_FW_VERSION;
-    pr_dbg("fw_ver=0x%" PRIx64 "\n", dsr->caps.fw_ver);
-
     dsr->caps.mode = PVRDMA_DEVICE_MODE_ROCE;
-    pr_dbg("mode=%d\n", dsr->caps.mode);
-
     dsr->caps.gid_types |= PVRDMA_GID_TYPE_FLAG_ROCE_V1;
-    pr_dbg("gid_types=0x%x\n", dsr->caps.gid_types);
-
     dsr->caps.max_uar = RDMA_BAR2_UAR_SIZE;
-    pr_dbg("max_uar=%d\n", dsr->caps.max_uar);
-
     dsr->caps.max_mr_size = dev->dev_attr.max_mr_size;
     dsr->caps.max_qp = dev->dev_attr.max_qp;
     dsr->caps.max_qp_wr = dev->dev_attr.max_qp_wr;
@@ -257,23 +239,11 @@ static void init_dsr_dev_caps(PVRDMADev *dev)
     dsr->caps.max_mr = dev->dev_attr.max_mr;
     dsr->caps.max_pd = dev->dev_attr.max_pd;
     dsr->caps.max_ah = dev->dev_attr.max_ah;
-
     dsr->caps.gid_tbl_len = MAX_GIDS;
-    pr_dbg("gid_tbl_len=%d\n", dsr->caps.gid_tbl_len);
-
     dsr->caps.sys_image_guid = 0;
-    pr_dbg("sys_image_guid=%" PRIx64 "\n", dsr->caps.sys_image_guid);
-
     dsr->caps.node_guid = dev->node_guid;
-    pr_dbg("node_guid=%" PRIx64 "\n", be64_to_cpu(dsr->caps.node_guid));
-
     dsr->caps.phys_port_cnt = MAX_PORTS;
-    pr_dbg("phys_port_cnt=%d\n", dsr->caps.phys_port_cnt);
-
     dsr->caps.max_pkeys = MAX_PKEYS;
-    pr_dbg("max_pkeys=%d\n", dsr->caps.max_pkeys);
-
-    pr_dbg("Initialized\n");
 }
 
 static void uninit_msix(PCIDevice *pdev, int used_vectors)
@@ -319,9 +289,6 @@ static void pvrdma_fini(PCIDevice *pdev)
 {
     PVRDMADev *dev = PVRDMA_DEV(pdev);
 
-    pr_dbg("Closing device %s %x.%x\n", pdev->name, PCI_SLOT(pdev->devfn),
-           PCI_FUNC(pdev->devfn));
-
     pvrdma_qp_ops_fini();
 
     rdma_rm_fini(&dev->rdma_dev_res, &dev->backend_dev,
@@ -335,8 +302,8 @@ static void pvrdma_fini(PCIDevice *pdev)
         uninit_msix(pdev, RDMA_MAX_INTRS);
     }
 
-    pr_dbg("Device %s %x.%x is down\n", pdev->name, PCI_SLOT(pdev->devfn),
-           PCI_FUNC(pdev->devfn));
+    rdma_info_report("Device %s %x.%x is down", pdev->name,
+                     PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
 }
 
 static void pvrdma_stop(PVRDMADev *dev)
@@ -353,32 +320,26 @@ static void activate_device(PVRDMADev *dev)
 {
     pvrdma_start(dev);
     set_reg_val(dev, PVRDMA_REG_ERR, 0);
-    pr_dbg("Device activated\n");
 }
 
 static int unquiesce_device(PVRDMADev *dev)
 {
-    pr_dbg("Device unquiesced\n");
     return 0;
 }
 
 static void reset_device(PVRDMADev *dev)
 {
     pvrdma_stop(dev);
-
-    pr_dbg("Device reset complete\n");
 }
 
-static uint64_t regs_read(void *opaque, hwaddr addr, unsigned size)
+static uint64_t pvrdma_regs_read(void *opaque, hwaddr addr, unsigned size)
 {
     PVRDMADev *dev = opaque;
     uint32_t val;
 
-    /* pr_dbg("addr=0x%lx, size=%d\n", addr, size); */
-
     if (get_reg_val(dev, addr, &val)) {
-        pr_dbg("Error trying to read REG value from address 0x%x\n",
-               (uint32_t)addr);
+        rdma_error_report("Failed to read REG value from address 0x%x",
+                          (uint32_t)addr);
         return -EINVAL;
     }
 
@@ -387,25 +348,24 @@ static uint64_t regs_read(void *opaque, hwaddr addr, unsigned size)
     return val;
 }
 
-static void regs_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+static void pvrdma_regs_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
 {
     PVRDMADev *dev = opaque;
 
-    /* pr_dbg("addr=0x%lx, val=0x%x, size=%d\n", addr, (uint32_t)val, size); */
-
     if (set_reg_val(dev, addr, val)) {
-        pr_err("Fail to set REG value, addr=0x%" PRIx64 ", val=0x%" PRIx64 "\n",
-               addr, val);
+        rdma_error_report("Failed to set REG value, addr=0x%"PRIx64 ", val=0x%"PRIx64,
+                          addr, val);
         return;
     }
 
-    trace_pvrdma_regs_write(addr, val);
-
     switch (addr) {
     case PVRDMA_REG_DSRLOW:
+        trace_pvrdma_regs_write(addr, val, "DSRLOW", "");
         dev->dsr_info.dma = val;
         break;
     case PVRDMA_REG_DSRHIGH:
+        trace_pvrdma_regs_write(addr, val, "DSRHIGH", "");
         dev->dsr_info.dma |= val << 32;
         load_dsr(dev);
         init_dsr_dev_caps(dev);
@@ -413,23 +373,27 @@ static void regs_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     case PVRDMA_REG_CTL:
         switch (val) {
         case PVRDMA_DEVICE_CTL_ACTIVATE:
+            trace_pvrdma_regs_write(addr, val, "CTL", "ACTIVATE");
             activate_device(dev);
             break;
         case PVRDMA_DEVICE_CTL_UNQUIESCE:
+            trace_pvrdma_regs_write(addr, val, "CTL", "UNQUIESCE");
             unquiesce_device(dev);
             break;
         case PVRDMA_DEVICE_CTL_RESET:
+            trace_pvrdma_regs_write(addr, val, "CTL", "URESET");
             reset_device(dev);
             break;
         }
         break;
     case PVRDMA_REG_IMR:
-        pr_dbg("Interrupt mask=0x%" PRIx64 "\n", val);
+        trace_pvrdma_regs_write(addr, val, "INTR_MASK", "");
         dev->interrupt_mask = val;
         break;
     case PVRDMA_REG_REQUEST:
         if (val == 0) {
-            execute_command(dev);
+            trace_pvrdma_regs_write(addr, val, "REQUEST", "");
+            pvrdma_exec_cmd(dev);
         }
         break;
     default:
@@ -438,8 +402,8 @@ static void regs_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 }
 
 static const MemoryRegionOps regs_ops = {
-    .read = regs_read,
-    .write = regs_write,
+    .read = pvrdma_regs_read,
+    .write = pvrdma_regs_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = sizeof(uint32_t),
@@ -447,54 +411,58 @@ static const MemoryRegionOps regs_ops = {
     },
 };
 
-static uint64_t uar_read(void *opaque, hwaddr addr, unsigned size)
+static uint64_t pvrdma_uar_read(void *opaque, hwaddr addr, unsigned size)
 {
     return 0xffffffff;
 }
 
-static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+static void pvrdma_uar_write(void *opaque, hwaddr addr, uint64_t val,
+                             unsigned size)
 {
     PVRDMADev *dev = opaque;
 
-    /* pr_dbg("addr=0x%lx, val=0x%x, size=%d\n", addr, (uint32_t)val, size); */
-
     switch (addr & 0xFFF) { /* Mask with 0xFFF as each UC gets page */
     case PVRDMA_UAR_QP_OFFSET:
-        pr_dbg("UAR QP command, addr=0x%" PRIx64 ", val=0x%" PRIx64 "\n",
-               (uint64_t)addr, val);
         if (val & PVRDMA_UAR_QP_SEND) {
+            trace_pvrdma_uar_write(addr, val, "QP", "SEND",
+                                   val & PVRDMA_UAR_HANDLE_MASK, 0);
             pvrdma_qp_send(dev, val & PVRDMA_UAR_HANDLE_MASK);
         }
         if (val & PVRDMA_UAR_QP_RECV) {
+            trace_pvrdma_uar_write(addr, val, "QP", "RECV",
+                                   val & PVRDMA_UAR_HANDLE_MASK, 0);
             pvrdma_qp_recv(dev, val & PVRDMA_UAR_HANDLE_MASK);
         }
         break;
     case PVRDMA_UAR_CQ_OFFSET:
-        /* pr_dbg("UAR CQ cmd, addr=0x%x, val=0x%lx\n", (uint32_t)addr, val); */
         if (val & PVRDMA_UAR_CQ_ARM) {
+            trace_pvrdma_uar_write(addr, val, "CQ", "ARM",
+                                   val & PVRDMA_UAR_HANDLE_MASK,
+                                   !!(val & PVRDMA_UAR_CQ_ARM_SOL));
             rdma_rm_req_notify_cq(&dev->rdma_dev_res,
                                   val & PVRDMA_UAR_HANDLE_MASK,
                                   !!(val & PVRDMA_UAR_CQ_ARM_SOL));
         }
         if (val & PVRDMA_UAR_CQ_ARM_SOL) {
-            pr_dbg("UAR_CQ_ARM_SOL (%" PRIx64 ")\n",
-                   val & PVRDMA_UAR_HANDLE_MASK);
+            trace_pvrdma_uar_write(addr, val, "CQ", "ARMSOL - not supported", 0,
+                                   0);
         }
         if (val & PVRDMA_UAR_CQ_POLL) {
-            pr_dbg("UAR_CQ_POLL (%" PRIx64 ")\n", val & PVRDMA_UAR_HANDLE_MASK);
+            trace_pvrdma_uar_write(addr, val, "CQ", "POLL",
+                                   val & PVRDMA_UAR_HANDLE_MASK, 0);
             pvrdma_cq_poll(&dev->rdma_dev_res, val & PVRDMA_UAR_HANDLE_MASK);
         }
         break;
     default:
-        pr_err("Unsupported command, addr=0x%" PRIx64 ", val=0x%" PRIx64 "\n",
-               addr, val);
+        rdma_error_report("Unsupported command, addr=0x%"PRIx64", val=0x%"PRIx64,
+                          addr, val);
         break;
     }
 }
 
 static const MemoryRegionOps uar_ops = {
-    .read = uar_read,
-    .write = uar_write,
+    .read = pvrdma_uar_read,
+    .write = pvrdma_uar_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = sizeof(uint32_t),
@@ -551,11 +519,9 @@ static void init_dev_caps(PVRDMADev *dev)
                               (wr_sz + sizeof(struct pvrdma_sge) *
                               dev->dev_attr.max_sge) - TARGET_PAGE_SIZE;
                               /* First page is ring state  ^^^^ */
-    pr_dbg("max_qp_wr=%d\n", dev->dev_attr.max_qp_wr);
 
     dev->dev_attr.max_cqe = pg_tbl_bytes / sizeof(struct pvrdma_cqe) -
                             TARGET_PAGE_SIZE; /* First page is ring state */
-    pr_dbg("max_cqe=%d\n", dev->dev_attr.max_cqe);
 }
 
 static int pvrdma_check_ram_shared(Object *obj, void *opaque)
@@ -585,10 +551,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
     bool ram_shared = false;
     PCIDevice *func0;
 
-    init_pr_dbg();
-
-    pr_dbg("Initializing device %s %x.%x\n", pdev->name,
-           PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+    rdma_info_report("Initializing device %s %x.%x", pdev->name,
+                     PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
 
     if (TARGET_PAGE_SIZE != getpagesize()) {
         error_setg(errp, "Target page size must be the same as host page size");
@@ -598,8 +562,6 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
     func0 = pci_get_function_0(pdev);
     /* Break if not vmxnet3 device in slot 0 */
     if (strcmp(object_get_typename(&func0->qdev.parent_obj), TYPE_VMXNET3)) {
-        pr_dbg("func0 type is %s\n",
-               object_get_typename(&func0->qdev.parent_obj));
         error_setg(errp, "Device on %x.0 must be %s", PCI_SLOT(pdev->devfn),
                    TYPE_VMXNET3);
         return;
@@ -656,7 +618,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
 out:
     if (rc) {
         pvrdma_fini(pdev);
-        error_append_hint(errp, "Device fail to load\n");
+        error_append_hint(errp, "Device failed to load\n");
     }
 }
 
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index ce5a60e184..16db726dac 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -19,6 +19,8 @@
 #include "../rdma_rm.h"
 #include "../rdma_backend.h"
 
+#include "trace.h"
+
 #include "pvrdma.h"
 #include "standard-headers/rdma/vmw_pvrdma-abi.h"
 #include "pvrdma_qp_ops.h"
@@ -55,18 +57,14 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
     RdmaRmCQ *cq = rdma_rm_get_cq(&dev->rdma_dev_res, cq_handle);
 
     if (unlikely(!cq)) {
-        pr_dbg("Invalid cqn %d\n", cq_handle);
         return -EINVAL;
     }
 
     ring = (PvrdmaRing *)cq->opaque;
-    pr_dbg("ring=%p\n", ring);
 
     /* Step #1: Put CQE on CQ ring */
-    pr_dbg("Writing CQE\n");
     cqe1 = pvrdma_ring_next_elem_write(ring);
     if (unlikely(!cqe1)) {
-        pr_dbg("No CQEs in ring\n");
         return -EINVAL;
     }
 
@@ -80,19 +78,13 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
     cqe1->wc_flags = wc->wc_flags;
     cqe1->vendor_err = wc->vendor_err;
 
-    pr_dbg("wr_id=%" PRIx64 "\n", cqe1->wr_id);
-    pr_dbg("qp=0x%lx\n", cqe1->qp);
-    pr_dbg("opcode=%d\n", cqe1->opcode);
-    pr_dbg("status=%d\n", cqe1->status);
-    pr_dbg("byte_len=%d\n", cqe1->byte_len);
-    pr_dbg("src_qp=%d\n", cqe1->src_qp);
-    pr_dbg("wc_flags=%d\n", cqe1->wc_flags);
-    pr_dbg("vendor_err=%d\n", cqe1->vendor_err);
+    trace_pvrdma_post_cqe(cq_handle, cq->notify, cqe1->wr_id, cqe1->qp,
+                          cqe1->opcode, cqe1->status, cqe1->byte_len,
+                          cqe1->src_qp, cqe1->wc_flags, cqe1->vendor_err);
 
     pvrdma_ring_write_inc(ring);
 
     /* Step #2: Put CQ number on dsr completion ring */
-    pr_dbg("Writing CQNE\n");
     cqne = pvrdma_ring_next_elem_write(&dev->dsr_info.cq);
     if (unlikely(!cqne)) {
         return -EINVAL;
@@ -101,7 +93,6 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
     cqne->info = cq_handle;
     pvrdma_ring_write_inc(&dev->dsr_info.cq);
 
-    pr_dbg("cq->notify=%d\n", cq->notify);
     if (cq->notify != CNT_CLEAR) {
         if (cq->notify == CNT_ARM) {
             cq->notify = CNT_CLEAR;
@@ -151,23 +142,17 @@ void pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
     int sgid_idx;
     union ibv_gid *sgid;
 
-    pr_dbg("qp_handle=0x%x\n", qp_handle);
-
     qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
     if (unlikely(!qp)) {
-        pr_dbg("Invalid qpn\n");
         return;
     }
 
     ring = (PvrdmaRing *)qp->opaque;
-    pr_dbg("sring=%p\n", ring);
 
     wqe = (struct PvrdmaSqWqe *)pvrdma_ring_next_elem_read(ring);
     while (wqe) {
         CompHandlerCtx *comp_ctx;
 
-        pr_dbg("wr_id=%" PRIx64 "\n", wqe->hdr.wr_id);
-
         /* Prepare CQE */
         comp_ctx = g_malloc(sizeof(CompHandlerCtx));
         comp_ctx->dev = dev;
@@ -178,26 +163,25 @@ void pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
 
         sgid = rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.av.gid_index);
         if (!sgid) {
-            pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av.gid_index);
+            rdma_error_report("Failed to get gid for idx %d",
+                              wqe->hdr.wr.ud.av.gid_index);
             complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
             continue;
         }
-        pr_dbg("sgid_id=%d, sgid=0x%llx\n", wqe->hdr.wr.ud.av.gid_index,
-               sgid->global.interface_id);
 
         sgid_idx = rdma_rm_get_backend_gid_index(&dev->rdma_dev_res,
                                                  &dev->backend_dev,
                                                  wqe->hdr.wr.ud.av.gid_index);
         if (sgid_idx <= 0) {
-            pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
-                   wqe->hdr.wr.ud.av.gid_index);
+            rdma_error_report("Failed to get bk sgid_idx for sgid_idx %d",
+                              wqe->hdr.wr.ud.av.gid_index);
             complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
             continue;
         }
 
         if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
-            pr_dbg("Invalid num_sge=%d (max %d)\n", wqe->hdr.num_sge,
-                   dev->dev_attr.max_sge);
+            rdma_error_report("Invalid num_sge=%d (max %d)", wqe->hdr.num_sge,
+                              dev->dev_attr.max_sge);
             complete_with_error(VENDOR_ERR_INV_NUM_SGE, comp_ctx);
             continue;
         }
@@ -221,23 +205,17 @@ void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
     PvrdmaRqWqe *wqe;
     PvrdmaRing *ring;
 
-    pr_dbg("qp_handle=0x%x\n", qp_handle);
-
     qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
     if (unlikely(!qp)) {
-        pr_dbg("Invalid qpn\n");
         return;
     }
 
     ring = &((PvrdmaRing *)qp->opaque)[1];
-    pr_dbg("rring=%p\n", ring);
 
     wqe = (struct PvrdmaRqWqe *)pvrdma_ring_next_elem_read(ring);
     while (wqe) {
         CompHandlerCtx *comp_ctx;
 
-        pr_dbg("wr_id=%" PRIx64 "\n", wqe->hdr.wr_id);
-
         /* Prepare CQE */
         comp_ctx = g_malloc(sizeof(CompHandlerCtx));
         comp_ctx->dev = dev;
@@ -247,8 +225,8 @@ void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
         comp_ctx->cqe.opcode = IBV_WC_RECV;
 
         if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
-            pr_dbg("Invalid num_sge=%d (max %d)\n", wqe->hdr.num_sge,
-                   dev->dev_attr.max_sge);
+            rdma_error_report("Invalid num_sge=%d (max %d)", wqe->hdr.num_sge,
+                              dev->dev_attr.max_sge);
             complete_with_error(VENDOR_ERR_INV_NUM_SGE, comp_ctx);
             continue;
         }
@@ -270,7 +248,6 @@ void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle)
 
     cq = rdma_rm_get_cq(dev_res, cq_handle);
     if (!cq) {
-        pr_dbg("Invalid CQ# %d\n", cq_handle);
         return;
     }
 
diff --git a/hw/rdma/vmw/trace-events b/hw/rdma/vmw/trace-events
index b3f9e2b19f..0122266ad7 100644
--- a/hw/rdma/vmw/trace-events
+++ b/hw/rdma/vmw/trace-events
@@ -1,5 +1,17 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/rdma/vmw/pvrdma_main.c
-pvrdma_regs_read(uint64_t addr, uint64_t val) "regs[0x%"PRIx64"] = 0x%"PRIx64
-pvrdma_regs_write(uint64_t addr, uint64_t val) "regs[0x%"PRIx64"] = 0x%"PRIx64
+pvrdma_regs_read(uint64_t addr, uint64_t val) "pvrdma.regs[0x%"PRIx64"]=0x%"PRIx64
+pvrdma_regs_write(uint64_t addr, uint64_t val, const char *reg_name, const char *val_name) "pvrdma.regs[0x%"PRIx64"]=0x%"PRIx64" (%s %s)"
+pvrdma_uar_write(uint64_t addr, uint64_t val, const char *reg_name, const char *val_name, int val1, int val2) "uar[0x%"PRIx64"]=0x%"PRIx64" (cls=%s, op=%s, obj=%d, val=%d)"
+
+# hw/rdma/vmw/pvrdma_cmd.c
+pvrdma_map_to_pdir_host_virt(void *vfirst, void *vremaped) "mremap %p -> %p"
+pvrdma_map_to_pdir_next_page(int page_idx, void *vnext, void *vremaped) "mremap [%d] %p -> %p"
+pvrdma_exec_cmd(int cmd, int err) "cmd=%d, err=%d"
+
+# hw/rdma/vmw/pvrdma_dev_ring.c
+pvrdma_ring_next_elem_read_no_data(char *ring_name) "pvrdma_ring %s is empty"
+
+# hw/rdma/vmw/pvrdma_qp_ops.c
+pvrdma_post_cqe(uint32_t cq_handle, int notify, uint64_t wr_id, uint64_t qpn, uint32_t op_code, uint32_t status, uint32_t byte_len, uint32_t src_qp, uint32_t wc_flags, uint32_t vendor_err) "cq_handle=%d, notify=%d, wr_id=0x%"PRIx64", qpn=0x%"PRIx64", opcode=%d, status=%d, byte_len=%d, src_qp=%d, wc_flags=%d, vendor_err=%d"
-- 
2.17.2
