Received: from eggs.gnu.org ([209.51.188.92]:33309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gtodR-0003Ky-CB
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gtoRC-0004AA-Ie
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:54:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gtoRA-000469-Tm
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:54:29 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Wed, 13 Feb 2019 08:53:53 +0200
Message-Id: <20190213065357.16076-7-yuval.shaia@oracle.com>
In-Reply-To: <20190213065357.16076-1-yuval.shaia@oracle.com>
References: <20190213065357.16076-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v2 5/9] hw/rdma: Free all MAD receive buffers
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
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c    | 34 +++++++++++++++++++++++++++++++++-
 hw/rdma/vmw/pvrdma_main.c |  2 ++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 0fb4842970..e8ee205b5f 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -64,6 +64,33 @@ static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
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
+        cqe_ctx_id = rdma_protected_qlist_pop_int64(&backend_dev->
+                                                    recv_mads_list);
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
@@ -1037,6 +1064,11 @@ static int mad_init(RdmaBackendDev *backend_dev, CharBackend *mad_chr_be)
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
@@ -1224,12 +1256,12 @@ void rdma_backend_start(RdmaBackendDev *backend_dev)
 
 void rdma_backend_stop(RdmaBackendDev *backend_dev)
 {
+    mad_stop(backend_dev);
     stop_backend_thread(&backend_dev->comp_thread);
 }
 
 void rdma_backend_fini(RdmaBackendDev *backend_dev)
 {
-    rdma_backend_stop(backend_dev);
     mad_fini(backend_dev);
     g_hash_table_destroy(ah_hash);
     ibv_destroy_comp_channel(backend_dev->channel);
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 8ffe79ceca..90dc9b191b 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -361,6 +361,8 @@ static void pvrdma_fini(PCIDevice *pdev)
 
     pvrdma_qp_ops_fini();
 
+    rdma_backend_stop(&dev->backend_dev);
+
     rdma_rm_fini(&dev->rdma_dev_res, &dev->backend_dev,
                  dev->backend_eth_device_name);
 
-- 
2.17.2
