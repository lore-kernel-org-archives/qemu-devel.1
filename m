Received: from eggs.gnu.org ([209.51.188.92]:42457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gxY6t-0006UN-55
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gxY6r-0002Nc-CU
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:16:59 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gxY6q-0002NI-Eo
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:16:56 -0500
Received: by mail-wm1-x343.google.com with SMTP id v26so4344963wmh.3
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 06:16:56 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 23 Feb 2019 16:16:37 +0200
Message-Id: <20190223141644.6609-5-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
References: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 04/11] hw/rdma: Protect against concurrent
 execution of poll_cq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com, philmd@redhat.com, dgilbert@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

The function rdma_poll_cq is called from two contexts - completion
handler thread which sense new completion on backend channel and
explicitly as result of guest issuing poll_cq command.

Add lock to protect against concurrent executions.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20190213065357.16076-5-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c | 2 ++
 hw/rdma/rdma_rm.c      | 4 ++++
 hw/rdma/rdma_rm_defs.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 6e9c4617da..3a2913facf 100644
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
index 64c6ea1a4e..7cc597cdc8 100644
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
2.17.1
