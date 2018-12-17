Received: from eggs.gnu.org ([2001:4830:134:3::10]:54913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYnzq-0002DR-3V
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYnzl-0007KM-Fj
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYnzj-0007H1-PY
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:21 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 10:10:29 +0200
Message-Id: <20181217081047.2039-6-yuval.shaia@oracle.com>
In-Reply-To: <20181217081047.2039-1-yuval.shaia@oracle.com>
References: <20181217081047.2039-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v7 05/23] hw/rdma: Add support for MAD packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

MAD (Management Datagram) packets are widely used by various modules
both in kernel and in user space for example the rdma_* API which is
used to create and maintain "connection" layer on top of RDMA uses
several types of MAD packets.

For more information please refer to chapter 13.4 in Volume 1
Architecture Specification, Release 1.1 available here:
https://www.infinibandta.org/ibta-specifications-download/

To support MAD packets the device uses an external utility
(contrib/rdmacm-mux) to relay packets from and to the guest driver.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c      | 250 +++++++++++++++++++++++++++++++++++-
 hw/rdma/rdma_backend.h      |   4 +-
 hw/rdma/rdma_backend_defs.h |  10 +-
 hw/rdma/vmw/pvrdma.h        |   2 +
 hw/rdma/vmw/pvrdma_main.c   |   4 +-
 5 files changed, 260 insertions(+), 10 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 1e148398a2..c6dedda555 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -16,8 +16,13 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qnum.h"
 
 #include <infiniband/verbs.h>
+#include <infiniband/umad_types.h>
+#include <infiniband/umad.h>
+#include <rdma/rdma_user_cm.h>
 
 #include "trace.h"
 #include "rdma_utils.h"
@@ -33,16 +38,25 @@
 #define VENDOR_ERR_MAD_SEND         0x206
 #define VENDOR_ERR_INVLKEY          0x207
 #define VENDOR_ERR_MR_SMALL         0x208
+#define VENDOR_ERR_INV_MAD_BUFF     0x209
+#define VENDOR_ERR_INV_NUM_SGE      0x210
 
 #define THR_NAME_LEN 16
 #define THR_POLL_TO  5000
 
+#define MAD_HDR_SIZE sizeof(struct ibv_grh)
+
 typedef struct BackendCtx {
-    uint64_t req_id;
     void *up_ctx;
     bool is_tx_req;
+    struct ibv_sge sge; /* Used to save MAD recv buffer */
 } BackendCtx;
 
+struct backend_umad {
+    struct ib_user_mad hdr;
+    char mad[RDMA_MAX_PRIVATE_DATA];
+};
+
 static void (*comp_handler)(int status, unsigned int vendor_err, void *ctx);
 
 static void dummy_comp_handler(int status, unsigned int vendor_err, void *ctx)
@@ -286,6 +300,61 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
     return 0;
 }
 
+static int mad_send(RdmaBackendDev *backend_dev, struct ibv_sge *sge,
+                    uint32_t num_sge)
+{
+    struct backend_umad umad = {0};
+    char *hdr, *msg;
+    int ret;
+
+    pr_dbg("num_sge=%d\n", num_sge);
+
+    if (num_sge != 2) {
+        return -EINVAL;
+    }
+
+    umad.hdr.length = sge[0].length + sge[1].length;
+    pr_dbg("msg_len=%d\n", umad.hdr.length);
+
+    if (umad.hdr.length > sizeof(umad.mad)) {
+        return -ENOMEM;
+    }
+
+    umad.hdr.addr.qpn = htobe32(1);
+    umad.hdr.addr.grh_present = 1;
+    umad.hdr.addr.gid_index = backend_dev->backend_gid_idx;
+    memcpy(umad.hdr.addr.gid, backend_dev->gid.raw, sizeof(umad.hdr.addr.gid));
+    umad.hdr.addr.hop_limit = 0xFF;
+
+    hdr = rdma_pci_dma_map(backend_dev->dev, sge[0].addr, sge[0].length);
+    if (!hdr) {
+        pr_dbg("Fail to map to sge[0]\n");
+        return -ENOMEM;
+    }
+    msg = rdma_pci_dma_map(backend_dev->dev, sge[1].addr, sge[1].length);
+    if (!msg) {
+        pr_dbg("Fail to map to sge[1]\n");
+        rdma_pci_dma_unmap(backend_dev->dev, hdr, sge[0].length);
+        return -ENOMEM;
+    }
+
+    pr_dbg_buf("mad_hdr", hdr, sge[0].length);
+    pr_dbg_buf("mad_data", data, sge[1].length);
+
+    memcpy(&umad.mad[0], hdr, sge[0].length);
+    memcpy(&umad.mad[sge[0].length], msg, sge[1].length);
+
+    rdma_pci_dma_unmap(backend_dev->dev, msg, sge[1].length);
+    rdma_pci_dma_unmap(backend_dev->dev, hdr, sge[0].length);
+
+    ret = qemu_chr_fe_write(backend_dev->mad_chr_be, (const uint8_t *)&umad,
+                            sizeof(umad));
+
+    pr_dbg("qemu_chr_fe_write=%d\n", ret);
+
+    return (ret != sizeof(umad));
+}
+
 void rdma_backend_post_send(RdmaBackendDev *backend_dev,
                             RdmaBackendQP *qp, uint8_t qp_type,
                             struct ibv_sge *sge, uint32_t num_sge,
@@ -304,9 +373,13 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
             comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
         } else if (qp_type == IBV_QPT_GSI) {
             pr_dbg("QP1\n");
-            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
+            rc = mad_send(backend_dev, sge, num_sge);
+            if (rc) {
+                comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
+            } else {
+                comp_handler(IBV_WC_SUCCESS, 0, ctx);
+            }
         }
-        pr_dbg("qp->ibqp is NULL for qp_type %d!!!\n", qp_type);
         return;
     }
 
@@ -370,6 +443,48 @@ out_free_bctx:
     g_free(bctx);
 }
 
+static unsigned int save_mad_recv_buffer(RdmaBackendDev *backend_dev,
+                                         struct ibv_sge *sge, uint32_t num_sge,
+                                         void *ctx)
+{
+    BackendCtx *bctx;
+    int rc;
+    uint32_t bctx_id;
+
+    if (num_sge != 1) {
+        pr_dbg("Invalid num_sge (%d), expecting 1\n", num_sge);
+        return VENDOR_ERR_INV_NUM_SGE;
+    }
+
+    if (sge[0].length < RDMA_MAX_PRIVATE_DATA + sizeof(struct ibv_grh)) {
+        pr_dbg("Too small buffer for MAD\n");
+        return VENDOR_ERR_INV_MAD_BUFF;
+    }
+
+    pr_dbg("addr=0x%" PRIx64"\n", sge[0].addr);
+    pr_dbg("length=%d\n", sge[0].length);
+    pr_dbg("lkey=%d\n", sge[0].lkey);
+
+    bctx = g_malloc0(sizeof(*bctx));
+
+    rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
+    if (unlikely(rc)) {
+        g_free(bctx);
+        pr_dbg("Fail to allocate cqe_ctx\n");
+        return VENDOR_ERR_NOMEM;
+    }
+
+    pr_dbg("bctx_id %d, bctx %p, ctx %p\n", bctx_id, bctx, ctx);
+    bctx->up_ctx = ctx;
+    bctx->sge = *sge;
+
+    qemu_mutex_lock(&backend_dev->recv_mads_list.lock);
+    qlist_append_int(backend_dev->recv_mads_list.list, bctx_id);
+    qemu_mutex_unlock(&backend_dev->recv_mads_list.lock);
+
+    return 0;
+}
+
 void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
                             RdmaDeviceResources *rdma_dev_res,
                             RdmaBackendQP *qp, uint8_t qp_type,
@@ -388,7 +503,10 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
         }
         if (qp_type == IBV_QPT_GSI) {
             pr_dbg("QP1\n");
-            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
+            rc = save_mad_recv_buffer(backend_dev, sge, num_sge, ctx);
+            if (rc) {
+                comp_handler(IBV_WC_GENERAL_ERR, rc, ctx);
+            }
         }
         return;
     }
@@ -517,7 +635,6 @@ int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
 
     switch (qp_type) {
     case IBV_QPT_GSI:
-        pr_dbg("QP1 unsupported\n");
         return 0;
 
     case IBV_QPT_RC:
@@ -748,11 +865,122 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
     return 0;
 }
 
+static inline void build_mad_hdr(struct ibv_grh *grh, union ibv_gid *sgid,
+                                 union ibv_gid *my_gid, int paylen)
+{
+    grh->paylen = htons(paylen);
+    grh->sgid = *sgid;
+    grh->dgid = *my_gid;
+
+    pr_dbg("paylen=%d (net=0x%x)\n", paylen, grh->paylen);
+    pr_dbg("my_gid=0x%llx\n", my_gid->global.interface_id);
+    pr_dbg("gid=0x%llx\n", sgid->global.interface_id);
+}
+
+static inline int mad_can_receieve(void *opaque)
+{
+    return sizeof(struct backend_umad);
+}
+
+static void mad_read(void *opaque, const uint8_t *buf, int size)
+{
+    RdmaBackendDev *backend_dev = (RdmaBackendDev *)opaque;
+    QObject *o_ctx_id;
+    unsigned long cqe_ctx_id;
+    BackendCtx *bctx;
+    char *mad;
+    struct backend_umad *umad;
+
+    assert(size != sizeof(umad));
+    umad = (struct backend_umad *)buf;
+
+    pr_dbg("Got %d bytes\n", size);
+    pr_dbg("umad->hdr.length=%d\n", umad->hdr.length);
+
+#ifdef PVRDMA_DEBUG
+    struct umad_hdr *hdr = (struct umad_hdr *)&msg->umad.mad;
+    pr_dbg("bv %x cls %x cv %x mtd %x st %d tid %" PRIx64 " at %x atm %x\n",
+           hdr->base_version, hdr->mgmt_class, hdr->class_version,
+           hdr->method, hdr->status, be64toh(hdr->tid),
+           hdr->attr_id, hdr->attr_mod);
+#endif
+
+    qemu_mutex_lock(&backend_dev->recv_mads_list.lock);
+    o_ctx_id = qlist_pop(backend_dev->recv_mads_list.list);
+    qemu_mutex_unlock(&backend_dev->recv_mads_list.lock);
+    if (!o_ctx_id) {
+        pr_dbg("No more free MADs buffers, waiting for a while\n");
+        sleep(THR_POLL_TO);
+        return;
+    }
+
+    cqe_ctx_id = qnum_get_uint(qobject_to(QNum, o_ctx_id));
+    bctx = rdma_rm_get_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_id);
+    if (unlikely(!bctx)) {
+        pr_dbg("Error: Fail to find ctx for %ld\n", cqe_ctx_id);
+        return;
+    }
+
+    pr_dbg("id %ld, bctx %p, ctx %p\n", cqe_ctx_id, bctx, bctx->up_ctx);
+
+    mad = rdma_pci_dma_map(backend_dev->dev, bctx->sge.addr,
+                           bctx->sge.length);
+    if (!mad || bctx->sge.length < umad->hdr.length + MAD_HDR_SIZE) {
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_MAD_BUFF,
+                     bctx->up_ctx);
+    } else {
+        memset(mad, 0, bctx->sge.length);
+        build_mad_hdr((struct ibv_grh *)mad,
+                      (union ibv_gid *)&umad->hdr.addr.gid,
+                      &backend_dev->gid, umad->hdr.length);
+        memcpy(&mad[MAD_HDR_SIZE], umad->mad, umad->hdr.length);
+        rdma_pci_dma_unmap(backend_dev->dev, mad, bctx->sge.length);
+
+        comp_handler(IBV_WC_SUCCESS, 0, bctx->up_ctx);
+    }
+
+    g_free(bctx);
+    rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_id);
+}
+
+static int mad_init(RdmaBackendDev *backend_dev)
+{
+    struct backend_umad umad = {0};
+    int ret;
+
+    if (!qemu_chr_fe_backend_connected(backend_dev->mad_chr_be)) {
+        pr_dbg("Missing chardev for MAD multiplexer\n");
+        return -EIO;
+    }
+
+    qemu_chr_fe_set_handlers(backend_dev->mad_chr_be, mad_can_receieve,
+                             mad_read, NULL, NULL, backend_dev, NULL, true);
+
+    /* Register ourself */
+    memcpy(umad.hdr.addr.gid, backend_dev->gid.raw, sizeof(umad.hdr.addr.gid));
+    ret = qemu_chr_fe_write(backend_dev->mad_chr_be, (const uint8_t *)&umad,
+                            sizeof(umad.hdr));
+    if (ret != sizeof(umad.hdr)) {
+        pr_dbg("Fail to register to rdma_umadmux (%d)\n", ret);
+    }
+
+    qemu_mutex_init(&backend_dev->recv_mads_list.lock);
+    backend_dev->recv_mads_list.list = qlist_new();
+
+    return 0;
+}
+
+static void mad_fini(RdmaBackendDev *backend_dev)
+{
+    qlist_destroy_obj(QOBJECT(backend_dev->recv_mads_list.list));
+    qemu_mutex_destroy(&backend_dev->recv_mads_list.lock);
+}
+
 int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
                       RdmaDeviceResources *rdma_dev_res,
                       const char *backend_device_name, uint8_t port_num,
                       uint8_t backend_gid_idx, struct ibv_device_attr *dev_attr,
-                      Error **errp)
+                      CharBackend *mad_chr_be, Error **errp)
 {
     int i;
     int ret = 0;
@@ -763,7 +991,7 @@ int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
     memset(backend_dev, 0, sizeof(*backend_dev));
 
     backend_dev->dev = pdev;
-
+    backend_dev->mad_chr_be = mad_chr_be;
     backend_dev->backend_gid_idx = backend_gid_idx;
     backend_dev->port_num = port_num;
     backend_dev->rdma_dev_res = rdma_dev_res;
@@ -854,6 +1082,13 @@ int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
     pr_dbg("interface_id=0x%" PRIx64 "\n",
            be64_to_cpu(backend_dev->gid.global.interface_id));
 
+    ret = mad_init(backend_dev);
+    if (ret) {
+        error_setg(errp, "Fail to initialize mad");
+        ret = -EIO;
+        goto out_destroy_comm_channel;
+    }
+
     backend_dev->comp_thread.run = false;
     backend_dev->comp_thread.is_running = false;
 
@@ -890,6 +1125,7 @@ void rdma_backend_stop(RdmaBackendDev *backend_dev)
 void rdma_backend_fini(RdmaBackendDev *backend_dev)
 {
     rdma_backend_stop(backend_dev);
+    mad_fini(backend_dev);
     g_hash_table_destroy(ah_hash);
     ibv_destroy_comp_channel(backend_dev->channel);
     ibv_close_device(backend_dev->context);
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 3ccc9a2494..fc83330251 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -17,6 +17,8 @@
 #define RDMA_BACKEND_H
 
 #include "qapi/error.h"
+#include "chardev/char-fe.h"
+
 #include "rdma_rm_defs.h"
 #include "rdma_backend_defs.h"
 
@@ -50,7 +52,7 @@ int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
                       RdmaDeviceResources *rdma_dev_res,
                       const char *backend_device_name, uint8_t port_num,
                       uint8_t backend_gid_idx, struct ibv_device_attr *dev_attr,
-                      Error **errp);
+                      CharBackend *mad_chr_be, Error **errp);
 void rdma_backend_fini(RdmaBackendDev *backend_dev);
 void rdma_backend_start(RdmaBackendDev *backend_dev);
 void rdma_backend_stop(RdmaBackendDev *backend_dev);
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
index 7404f64002..2a7e667075 100644
--- a/hw/rdma/rdma_backend_defs.h
+++ b/hw/rdma/rdma_backend_defs.h
@@ -16,8 +16,9 @@
 #ifndef RDMA_BACKEND_DEFS_H
 #define RDMA_BACKEND_DEFS_H
 
-#include <infiniband/verbs.h>
 #include "qemu/thread.h"
+#include "chardev/char-fe.h"
+#include <infiniband/verbs.h>
 
 typedef struct RdmaDeviceResources RdmaDeviceResources;
 
@@ -28,6 +29,11 @@ typedef struct RdmaBackendThread {
     bool is_running; /* Set by the thread to report its status */
 } RdmaBackendThread;
 
+typedef struct RecvMadList {
+    QemuMutex lock;
+    QList *list;
+} RecvMadList;
+
 typedef struct RdmaBackendDev {
     struct ibv_device_attr dev_attr;
     RdmaBackendThread comp_thread;
@@ -39,6 +45,8 @@ typedef struct RdmaBackendDev {
     struct ibv_comp_channel *channel;
     uint8_t port_num;
     uint8_t backend_gid_idx;
+    RecvMadList recv_mads_list;
+    CharBackend *mad_chr_be;
 } RdmaBackendDev;
 
 typedef struct RdmaBackendPD {
diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index e2d9f93cdf..e3742d893a 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -19,6 +19,7 @@
 #include "qemu/units.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msix.h"
+#include "chardev/char-fe.h"
 
 #include "../rdma_backend_defs.h"
 #include "../rdma_rm_defs.h"
@@ -83,6 +84,7 @@ typedef struct PVRDMADev {
     uint8_t backend_port_num;
     RdmaBackendDev backend_dev;
     RdmaDeviceResources rdma_dev_res;
+    CharBackend mad_chr;
 } PVRDMADev;
 #define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
 
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index ca5fa8d981..6c8c0154fa 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -51,6 +51,7 @@ static Property pvrdma_dev_properties[] = {
     DEFINE_PROP_INT32("dev-caps-max-qp-init-rd-atom", PVRDMADev,
                       dev_attr.max_qp_init_rd_atom, MAX_QP_INIT_RD_ATOM),
     DEFINE_PROP_INT32("dev-caps-max-ah", PVRDMADev, dev_attr.max_ah, MAX_AH),
+    DEFINE_PROP_CHR("mad-chardev", PVRDMADev, mad_chr),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -613,7 +614,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
 
     rc = rdma_backend_init(&dev->backend_dev, pdev, &dev->rdma_dev_res,
                            dev->backend_device_name, dev->backend_port_num,
-                           dev->backend_gid_idx, &dev->dev_attr, errp);
+                           dev->backend_gid_idx, &dev->dev_attr, &dev->mad_chr,
+                           errp);
     if (rc) {
         goto out;
     }
-- 
2.17.2
