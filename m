Received: from eggs.gnu.org ([209.51.188.92]:47516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2u6F-0000bu-Cw
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2u6E-0007Q2-LU
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1h2u6E-0007PY-C7
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:26 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun, 10 Mar 2019 10:46:03 +0200
Message-Id: <20190310084610.23077-4-yuval.shaia@oracle.com>
In-Reply-To: <20190310084610.23077-1-yuval.shaia@oracle.com>
References: <20190310084610.23077-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v5 03/10] hw/rdma: Protect against concurrent
 execution of poll_cq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

The function rdma_poll_cq is called from two contexts - completion
handler thread which sense new completion on backend channel and
explicitly as result of guest issuing poll_cq command.

Add lock to protect against concurrent executions.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c | 2 ++
 hw/rdma/rdma_rm.c      | 4 ++++
 hw/rdma/rdma_rm_defs.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 0ed14751be..9679b842d1 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -70,6 +70,7 @@ static void rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
     BackendCtx *bctx;
     struct ibv_wc wc[2];
 
+    qemu_mutex_lock(&rdma_dev_res->lock);
     do {
         ne = ibv_poll_cq(ibcq, ARRAY_SIZE(wc), wc);
 
@@ -89,6 +90,7 @@ static void rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
             g_free(bctx);
         }
     } while (ne > 0);
+    qemu_mutex_unlock(&rdma_dev_res->lock);
 
     if (ne < 0) {
         rdma_error_report("ibv_poll_cq fail, rc=%d, errno=%d", ne, errno);
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 5dab4a2189..14580ca379 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -618,12 +618,16 @@ int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr,
 
     init_ports(dev_res);
 
+    qemu_mutex_init(&dev_res->lock);
+
     return 0;
 }
 
 void rdma_rm_fini(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
                   const char *ifname)
 {
+    qemu_mutex_destroy(&dev_res->lock);
+
     fini_ports(dev_res, backend_dev, ifname);
 
     res_tbl_free(&dev_res->uc_tbl);
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 0ba61d1838..f0ee1f3072 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -105,6 +105,7 @@ typedef struct RdmaDeviceResources {
     RdmaRmResTbl cq_tbl;
     RdmaRmResTbl cqe_ctx_tbl;
     GHashTable *qp_hash; /* Keeps mapping between real and emulated */
+    QemuMutex lock;
 } RdmaDeviceResources;
 
 #endif
-- 
2.17.2
