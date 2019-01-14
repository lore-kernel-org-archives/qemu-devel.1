Received: from eggs.gnu.org ([209.51.188.92]:50582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gj2wp-0007PI-Pn
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gj2wo-0002Fh-Sm
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:10:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gj2wo-0002Ao-IY
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:10:38 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 14 Jan 2019 16:10:06 +0200
Message-Id: <20190114141006.1841-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH] hw/rdma: Verify that ptr is not NULL before
 freeing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

Make sure objects are not NULL before calling to non-nulll-safe
destructors.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c | 6 ++++--
 hw/rdma/rdma_rm.c      | 7 ++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index b49edaacaf..3ee5172c96 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -1066,8 +1066,10 @@ static void mad_fini(RdmaBackendDev *backend_dev)
     pr_dbg("Stopping MAD\n");
     disable_rdmacm_mux_async(backend_dev);
     qemu_chr_fe_disconnect(backend_dev->rdmacm_mux.chr_be);
-    qlist_destroy_obj(QOBJECT(backend_dev->recv_mads_list.list));
-    qemu_mutex_destroy(&backend_dev->recv_mads_list.lock);
+    if (backend_dev->recv_mads_list.list) {
+        qlist_destroy_obj(QOBJECT(backend_dev->recv_mads_list.list));
+        qemu_mutex_destroy(&backend_dev->recv_mads_list.lock);
+    }
 }
 
 int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index f5b1295890..8bf241e91f 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -41,6 +41,9 @@ static inline void res_tbl_init(const char *name, RdmaRmResTbl *tbl,
 
 static inline void res_tbl_free(RdmaRmResTbl *tbl)
 {
+    if (!tbl->bitmap) {
+        return;
+    }
     qemu_mutex_destroy(&tbl->lock);
     g_free(tbl->tbl);
     g_free(tbl->bitmap);
@@ -655,5 +658,7 @@ void rdma_rm_fini(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
     res_tbl_free(&dev_res->cq_tbl);
     res_tbl_free(&dev_res->pd_tbl);
 
-    g_hash_table_destroy(dev_res->qp_hash);
+    if (dev_res->qp_hash) {
+        g_hash_table_destroy(dev_res->qp_hash);
+    }
 }
-- 
2.17.2
