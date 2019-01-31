Received: from eggs.gnu.org ([209.51.188.92]:48197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5n-0007IE-AY
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5m-0000Ln-I6
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:19 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:32920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gpC5m-0000LM-9M
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:18 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 31 Jan 2019 15:08:48 +0200
Message-Id: <20190131130850.6850-9-yuval.shaia@oracle.com>
In-Reply-To: <20190131130850.6850-1-yuval.shaia@oracle.com>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 08/10] hw/rdma: Free all MAD receive buffers
 when device is closed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

When device is going down free all saved MAD buffers.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c | 32 ++++++++++++++++++++++++++++++++
 hw/rdma/rdma_backend.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index d43fb1e677..65b28aa5b2 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -64,6 +64,32 @@ static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
     comp_handler(ctx, &wc);
 }
 
+static void free_cqe_ctx(gpointer data, gpointer user_data)
+{
+    BackendCtx *bctx;
+    RdmaDeviceResources *rdma_dev_res = user_data;
+    unsigned long cqe_ctx_id = GPOINTER_TO_INT(data);
+
+    bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, cqe_ctx_id);
+    if (bctx) {
+        rdma_rm_dealloc_cqe_ctx(rdma_dev_res, cqe_ctx_id);
+    }
+    g_free(bctx);
+}
+
+static void clean_recv_mads(RdmaBackendDev *backend_dev)
+{
+    unsigned long cqe_ctx_id;
+
+    do {
+        cqe_ctx_id = rdma_locked_list_pop_int64(&backend_dev->recv_mads_list);
+        if (cqe_ctx_id != -ENOENT) {
+            free_cqe_ctx(GINT_TO_POINTER(cqe_ctx_id),
+                         backend_dev->rdma_dev_res);
+        }
+    } while (cqe_ctx_id != -ENOENT);
+}
+
 static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
 {
     int i, ne, total_ne = 0;
@@ -1029,6 +1055,11 @@ static int mad_init(RdmaBackendDev *backend_dev, CharBackend *mad_chr_be)
     return 0;
 }
 
+static void mad_stop(RdmaBackendDev *backend_dev)
+{
+    clean_recv_mads(backend_dev);
+}
+
 static void mad_fini(RdmaBackendDev *backend_dev)
 {
     disable_rdmacm_mux_async(backend_dev);
@@ -1216,6 +1247,7 @@ void rdma_backend_start(RdmaBackendDev *backend_dev)
 
 void rdma_backend_stop(RdmaBackendDev *backend_dev)
 {
+    mad_stop(backend_dev);
     stop_backend_thread(&backend_dev->comp_thread);
 }
 
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 36305cd148..6abc367a52 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -33,6 +33,7 @@
 #define VENDOR_ERR_MR_SMALL         0x208
 #define VENDOR_ERR_INV_MAD_BUFF     0x209
 #define VENDOR_ERR_INV_GID_IDX      0x210
+#define VENDOR_ERR_DEV_GOING_DOWN   0x211
 
 /* Add definition for QP0 and QP1 as there is no userspace enums for them */
 enum ibv_special_qp_type {
-- 
2.17.2
