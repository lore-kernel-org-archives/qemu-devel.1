Received: from eggs.gnu.org ([209.51.188.92]:55333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTb-0001N9-8D
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTZ-00083B-GK
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:43 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gknTZ-0007qx-5V
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id n190so6683569wmd.0
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 02:03:23 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 19 Jan 2019 12:03:07 +0200
Message-Id: <20190119100315.23985-3-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
References: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 02/10] hw/pvrdma: Remove max-sge
 command-line param
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

This parameter has no effect, fix it.

The function init_dev_caps sets the front-end's max-sge to MAX_SGE. Then
it checks backend's max-sge and adjust it accordingly (we can't send
more than what the device supports).

On send and recv we need to make sure the num_sge in the WQE does not
exceeds the backend device capability.
This check is done in pvrdma level so check on rdma level is deleted.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Message-Id: <20190109194123.3468-1-yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 docs/pvrdma.txt             |  1 -
 hw/rdma/rdma_backend.c      | 23 ++---------------------
 hw/rdma/rdma_backend.h      | 11 +++++++++++
 hw/rdma/vmw/pvrdma_main.c   | 10 +++++-----
 hw/rdma/vmw/pvrdma_qp_ops.c | 24 ++++++++++++++++++++++++
 5 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/docs/pvrdma.txt b/docs/pvrdma.txt
index 81959378b1..0f0dd8a7e5 100644
--- a/docs/pvrdma.txt
+++ b/docs/pvrdma.txt
@@ -156,7 +156,6 @@ Ethernet function can be used for other Ethernet purposes such as IP.
   specify the port to use. If not set 1 will be used.
 - dev-caps-max-mr-size: The maximum size of MR.
 - dev-caps-max-qp:      Maximum number of QPs.
-- dev-caps-max-sge:     Maximum number of SGE elements in WR.
 - dev-caps-max-cq:      Maximum number of CQs.
 - dev-caps-max-mr:      Maximum number of MRs.
 - dev-caps-max-pd:      Maximum number of PDs.
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index c28bfbd44d..16dca69ee9 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -32,17 +32,6 @@
 #include "rdma_rm.h"
 #include "rdma_backend.h"
 
-/* Vendor Errors */
-#define VENDOR_ERR_FAIL_BACKEND     0x201
-#define VENDOR_ERR_TOO_MANY_SGES    0x202
-#define VENDOR_ERR_NOMEM            0x203
-#define VENDOR_ERR_QP0              0x204
-#define VENDOR_ERR_INV_NUM_SGE      0x205
-#define VENDOR_ERR_MAD_SEND         0x206
-#define VENDOR_ERR_INVLKEY          0x207
-#define VENDOR_ERR_MR_SMALL         0x208
-#define VENDOR_ERR_INV_MAD_BUFF     0x209
-
 #define THR_NAME_LEN 16
 #define THR_POLL_TO  5000
 
@@ -475,11 +464,6 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     }
 
     pr_dbg("num_sge=%d\n", num_sge);
-    if (!num_sge || num_sge > MAX_SGE) {
-        pr_dbg("invalid num_sge=%d\n", num_sge);
-        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_NUM_SGE, ctx);
-        return;
-    }
 
     bctx = g_malloc0(sizeof(*bctx));
     bctx->up_ctx = ctx;
@@ -602,11 +586,6 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
     }
 
     pr_dbg("num_sge=%d\n", num_sge);
-    if (!num_sge || num_sge > MAX_SGE) {
-        pr_dbg("invalid num_sge=%d\n", num_sge);
-        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_NUM_SGE, ctx);
-        return;
-    }
 
     bctx = g_malloc0(sizeof(*bctx));
     bctx->up_ctx = ctx;
@@ -942,6 +921,8 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
         return -EIO;
     }
 
+    dev_attr->max_sge = MAX_SGE;
+
     CHK_ATTR(dev_attr, backend_dev->dev_attr, max_mr_size, "%" PRId64);
     CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp, "%d");
     CHK_ATTR(dev_attr, backend_dev->dev_attr, max_sge, "%d");
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 8cae40f827..a9ba40ae48 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -22,6 +22,17 @@
 #include "rdma_rm_defs.h"
 #include "rdma_backend_defs.h"
 
+/* Vendor Errors */
+#define VENDOR_ERR_FAIL_BACKEND     0x201
+#define VENDOR_ERR_TOO_MANY_SGES    0x202
+#define VENDOR_ERR_NOMEM            0x203
+#define VENDOR_ERR_QP0              0x204
+#define VENDOR_ERR_INV_NUM_SGE      0x205
+#define VENDOR_ERR_MAD_SEND         0x206
+#define VENDOR_ERR_INVLKEY          0x207
+#define VENDOR_ERR_MR_SMALL         0x208
+#define VENDOR_ERR_INV_MAD_BUFF     0x209
+
 /* Add definition for QP0 and QP1 as there is no userspace enums for them */
 enum ibv_special_qp_type {
     IBV_QPT_SMI = 0,
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 838ad8a949..d2bdb5ba8c 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -43,7 +43,6 @@ static Property pvrdma_dev_properties[] = {
     DEFINE_PROP_UINT64("dev-caps-max-mr-size", PVRDMADev, dev_attr.max_mr_size,
                        MAX_MR_SIZE),
     DEFINE_PROP_INT32("dev-caps-max-qp", PVRDMADev, dev_attr.max_qp, MAX_QP),
-    DEFINE_PROP_INT32("dev-caps-max-sge", PVRDMADev, dev_attr.max_sge, MAX_SGE),
     DEFINE_PROP_INT32("dev-caps-max-cq", PVRDMADev, dev_attr.max_cq, MAX_CQ),
     DEFINE_PROP_INT32("dev-caps-max-mr", PVRDMADev, dev_attr.max_mr, MAX_MR),
     DEFINE_PROP_INT32("dev-caps-max-pd", PVRDMADev, dev_attr.max_pd, MAX_PD),
@@ -549,8 +548,9 @@ static void init_dev_caps(PVRDMADev *dev)
                        sizeof(struct pvrdma_rq_wqe_hdr));
 
     dev->dev_attr.max_qp_wr = pg_tbl_bytes /
-                              (wr_sz + sizeof(struct pvrdma_sge) * MAX_SGE) -
-                              TARGET_PAGE_SIZE; /* First page is ring state */
+                              (wr_sz + sizeof(struct pvrdma_sge) *
+                              dev->dev_attr.max_sge) - TARGET_PAGE_SIZE;
+                              /* First page is ring state  ^^^^ */
     pr_dbg("max_qp_wr=%d\n", dev->dev_attr.max_qp_wr);
 
     dev->dev_attr.max_cqe = pg_tbl_bytes / sizeof(struct pvrdma_cqe) -
@@ -626,8 +626,6 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
 
     init_regs(pdev);
 
-    init_dev_caps(dev);
-
     rc = init_msix(pdev, errp);
     if (rc) {
         goto out;
@@ -640,6 +638,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
         goto out;
     }
 
+    init_dev_caps(dev);
+
     rc = rdma_rm_init(&dev->rdma_dev_res, &dev->dev_attr, errp);
     if (rc) {
         goto out;
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 300471a4c9..465bee8641 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -121,6 +121,16 @@ static void pvrdma_qp_ops_comp_handler(void *ctx, struct ibv_wc *wc)
     g_free(ctx);
 }
 
+static void complete_with_error(uint32_t vendor_err, void *ctx)
+{
+    struct ibv_wc wc = {0};
+
+    wc.status = IBV_WC_GENERAL_ERR;
+    wc.vendor_err = vendor_err;
+
+    pvrdma_qp_ops_comp_handler(ctx, &wc);
+}
+
 void pvrdma_qp_ops_fini(void)
 {
     rdma_backend_unregister_comp_handler();
@@ -182,6 +192,13 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
             return -EIO;
         }
 
+        if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
+            pr_dbg("Invalid num_sge=%d (max %d)\n", wqe->hdr.num_sge,
+                   dev->dev_attr.max_sge);
+            complete_with_error(VENDOR_ERR_INV_NUM_SGE, comp_ctx);
+            continue;
+        }
+
         rdma_backend_post_send(&dev->backend_dev, &qp->backend_qp, qp->qp_type,
                                (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
                                sgid_idx, sgid,
@@ -227,6 +244,13 @@ int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
         comp_ctx->cqe.qp = qp_handle;
         comp_ctx->cqe.opcode = IBV_WC_RECV;
 
+        if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
+            pr_dbg("Invalid num_sge=%d (max %d)\n", wqe->hdr.num_sge,
+                   dev->dev_attr.max_sge);
+            complete_with_error(VENDOR_ERR_INV_NUM_SGE, comp_ctx);
+            continue;
+        }
+
         rdma_backend_post_recv(&dev->backend_dev, &dev->rdma_dev_res,
                                &qp->backend_qp, qp->qp_type,
                                (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
-- 
2.17.1
