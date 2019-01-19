Received: from eggs.gnu.org ([209.51.188.92]:55286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTa-0001MM-GR
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTZ-00082x-GA
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:42 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gknTZ-0007ve-4o
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id x10so17872128wrs.8
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 02:03:30 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 19 Jan 2019 12:03:11 +0200
Message-Id: <20190119100315.23985-7-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
References: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH PULL 06/10] hw/rdma: Verify that ptr is not
 NULL before freeing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com, liq3ea@163.com, cohuck@redhat.com, philmd@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

To cover the case where fini() was called even when init() fails make
sure objects are not NULL before calling to non-null-safe destructors.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190116151538.14088-1-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
2.17.1
