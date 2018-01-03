Received: from eggs.gnu.org ([2001:4830:134:3::10]:59527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eWgJ0-0002is-To
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eWgIo-0001Rr-IQ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:29:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eWgIn-0001RT-Rt
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:29:42 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed,  3 Jan 2018 12:29:10 +0200
Message-Id: <20180103102911.35562-5-marcel@redhat.com>
In-Reply-To: <20180103102911.35562-1-marcel@redhat.com>
References: <20180103102911.35562-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH V3 4/5] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, marcel@redhat.com, mst@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, f4bug@amsat.org

From: Yuval Shaia <yuval.shaia@oracle.com>

PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
It works with its Linux Kernel driver AS IS, no need for any special guest
modifications.

While it complies with the VMware device, it can also communicate with bare
metal RDMA-enabled machines and does not require an RDMA HCA in the host, it
can work with Soft-RoCE (rxe).

It does not require the whole guest RAM to be pinned allowing memory
over-commit and, even if not implemented yet, migration support will be
possible with some HW assistance.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 Makefile.objs                      |   2 +
 configure                          |   9 +-
 default-configs/arm-softmmu.mak    |   1 +
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 hw/Makefile.objs                   |   1 +
 hw/rdma/Makefile.objs              |   7 +
 hw/rdma/rdma_backend.c             | 815 +++++++++++++++++++++++++++++++++++++
 hw/rdma/rdma_backend.h             |  92 +++++
 hw/rdma/rdma_backend_defs.h        |  62 +++
 hw/rdma/rdma_rm.c                  | 619 ++++++++++++++++++++++++++++
 hw/rdma/rdma_rm.h                  |  69 ++++
 hw/rdma/rdma_rm_defs.h             | 106 +++++
 hw/rdma/rdma_utils.h               |  36 ++
 hw/rdma/trace-events               |   5 +
 hw/rdma/vmw/pvrdma.h               | 123 ++++++
 hw/rdma/vmw/pvrdma_cmd.c           | 585 ++++++++++++++++++++++++++
 hw/rdma/vmw/pvrdma_dev_api.h       | 580 ++++++++++++++++++++++++++
 hw/rdma/vmw/pvrdma_dev_ring.c      | 140 +++++++
 hw/rdma/vmw/pvrdma_dev_ring.h      |  43 ++
 hw/rdma/vmw/pvrdma_ib_verbs.h      | 400 ++++++++++++++++++
 hw/rdma/vmw/pvrdma_main.c          | 644 +++++++++++++++++++++++++++++
 hw/rdma/vmw/pvrdma_qp_ops.c        | 212 ++++++++++
 hw/rdma/vmw/pvrdma_qp_ops.h        |  27 ++
 hw/rdma/vmw/pvrdma_ring.h          | 134 ++++++
 hw/rdma/vmw/pvrdma_types.h         |  38 ++
 hw/rdma/vmw/pvrdma_utils.c         | 135 ++++++
 hw/rdma/vmw/pvrdma_utils.h         |  26 ++
 hw/rdma/vmw/trace-events           |   5 +
 include/hw/pci/pci_ids.h           |   3 +
 30 files changed, 4917 insertions(+), 4 deletions(-)
 create mode 100644 hw/rdma/Makefile.objs
 create mode 100644 hw/rdma/rdma_backend.c
 create mode 100644 hw/rdma/rdma_backend.h
 create mode 100644 hw/rdma/rdma_backend_defs.h
 create mode 100644 hw/rdma/rdma_rm.c
 create mode 100644 hw/rdma/rdma_rm.h
 create mode 100644 hw/rdma/rdma_rm_defs.h
 create mode 100644 hw/rdma/rdma_utils.h
 create mode 100644 hw/rdma/trace-events
 create mode 100644 hw/rdma/vmw/pvrdma.h
 create mode 100644 hw/rdma/vmw/pvrdma_cmd.c
 create mode 100644 hw/rdma/vmw/pvrdma_dev_api.h
 create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
 create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
 create mode 100644 hw/rdma/vmw/pvrdma_ib_verbs.h
 create mode 100644 hw/rdma/vmw/pvrdma_main.c
 create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
 create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
 create mode 100644 hw/rdma/vmw/pvrdma_ring.h
 create mode 100644 hw/rdma/vmw/pvrdma_types.h
 create mode 100644 hw/rdma/vmw/pvrdma_utils.c
 create mode 100644 hw/rdma/vmw/pvrdma_utils.h
 create mode 100644 hw/rdma/vmw/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 285c6f3c15..4acaa1352d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -129,6 +129,8 @@ trace-events-subdirs += hw/block/dataplane
 trace-events-subdirs += hw/char
 trace-events-subdirs += hw/intc
 trace-events-subdirs += hw/net
+trace-events-subdirs += hw/rdma
+trace-events-subdirs += hw/rdma/vmw
 trace-events-subdirs += hw/virtio
 trace-events-subdirs += hw/audio
 trace-events-subdirs += hw/misc
diff --git a/configure b/configure
index 100309c33f..d36466f622 100755
--- a/configure
+++ b/configure
@@ -1529,7 +1529,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   bluez           bluez stack connectivity
   kvm             KVM acceleration support
   hax             HAX acceleration support
-  rdma            RDMA-based migration support
+  rdma            Enable RDMA-based migration support and PVRDMA
   vde             support for vde network
   netmap          support for netmap network
   linux-aio       Linux AIO support
@@ -2856,15 +2856,16 @@ if test "$rdma" != "no" ; then
 #include <rdma/rdma_cma.h>
 int main(void) { return 0; }
 EOF
-  rdma_libs="-lrdmacm -libverbs"
+  rdma_libs="-lrdmacm -libverbs -libumad"
   if compile_prog "" "$rdma_libs" ; then
     rdma="yes"
   else
+    libs_softmmu="$libs_softmmu $rdma_libs"
     if test "$rdma" = "yes" ; then
         error_exit \
-            " OpenFabrics librdmacm/libibverbs not present." \
+            " OpenFabrics librdmacm/libibverbs/libibumad not present." \
             " Your options:" \
-            "  (1) Fast: Install infiniband packages from your distro." \
+            "  (1) Fast: Install infiniband packages (devel) from your distro." \
             "  (2) Cleanest: Install libraries from www.openfabrics.org" \
             "  (3) Also: Install softiwarp if you don't have RDMA hardware"
     fi
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index b0d6e65038..0e7a3c1700 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -132,3 +132,4 @@ CONFIG_GPIO_KEY=y
 CONFIG_MSF2=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_XILINX_AXI=y
+CONFIG_PVRDMA=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 95ac4b464a..88298e4ef5 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -61,3 +61,4 @@ CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
 CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
 CONFIG_FW_CFG_DMA=y
+CONFIG_PVRDMA=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 0221236825..f571da36eb 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -61,3 +61,4 @@ CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
 CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
 CONFIG_FW_CFG_DMA=y
+CONFIG_PVRDMA=y
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index cf4cb2010b..6a0ffe0afd 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -18,6 +18,7 @@ devices-dirs-$(CONFIG_IPMI) += ipmi/
 devices-dirs-$(CONFIG_SOFTMMU) += isa/
 devices-dirs-$(CONFIG_SOFTMMU) += misc/
 devices-dirs-$(CONFIG_SOFTMMU) += net/
+devices-dirs-$(CONFIG_SOFTMMU) += rdma/
 devices-dirs-$(CONFIG_SOFTMMU) += nvram/
 devices-dirs-$(CONFIG_SOFTMMU) += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
new file mode 100644
index 0000000000..0537e36c39
--- /dev/null
+++ b/hw/rdma/Makefile.objs
@@ -0,0 +1,7 @@
+ifeq ($(CONFIG_RDMA),y)
+obj-$(CONFIG_PVRDMA) += rdma_backend.o rdma_rm.o
+obj-$(CONFIG_PVRDMA) += vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o \
+                        vmw/pvrdma_utils.o vmw/pvrdma_qp_ops.o \
+                        vmw/pvrdma_main.o
+endif
+
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
new file mode 100644
index 0000000000..dcb799f49b
--- /dev/null
+++ b/hw/rdma/rdma_backend.c
@@ -0,0 +1,815 @@
+/*
+ * QEMU paravirtual RDMA - Generic RDMA backend
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include <qemu/osdep.h>
+#include <qemu/error-report.h>
+#include <qapi/error.h>
+
+#include <infiniband/verbs.h>
+
+#include "trace.h"
+#include "rdma_utils.h"
+#include "rdma_rm.h"
+#include "rdma_backend.h"
+
+/* Vendor Errors */
+#define VENDOR_ERR_FAIL_BACKEND     0x201
+#define VENDOR_ERR_TOO_MANY_SGES    0x202
+#define VENDOR_ERR_NOMEM            0x203
+#define VENDOR_ERR_QP0              0x204
+#define VENDOR_ERR_NO_SGE           0x205
+#define VENDOR_ERR_MAD_SEND         0x206
+#define VENDOR_ERR_INVLKEY          0x207
+#define VENDOR_ERR_MR_SMALL         0x208
+
+typedef struct BackendCtx {
+    void *up_ctx;
+    uint64_t req_id;
+    bool is_tx_req;
+} BackendCtx;
+
+static void (*comp_handler)(int status, unsigned int vendor_err, void *ctx);
+
+static void dummy_comp_handler(int status, unsigned int vendor_err, void *ctx)
+{
+    pr_err("No completion handler is registered\n");
+}
+
+static void poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq,
+                    bool one_poll)
+{
+    int i, ne;
+    BackendCtx *bctx;
+    struct ibv_wc wc[2];
+
+    pr_dbg("Entering poll_cq loop on cq %p\n", ibcq);
+    do {
+        ne = ibv_poll_cq(ibcq, 2, wc);
+        if (ne == 0 && one_poll) {
+            pr_dbg("CQ is empty\n");
+            return;
+        }
+    } while (ne < 0);
+
+    pr_dbg("Got %d completion(s) from cq %p\n", ne, ibcq);
+
+    for (i = 0; i < ne; i++) {
+        pr_dbg("wr_id=0x%lx\n", wc[i].wr_id);
+        pr_dbg("status=%d\n", wc[i].status);
+
+        bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
+        if (unlikely(!bctx)) {
+            pr_dbg("Error: Fail to find ctx for req %ld\n", wc[i].wr_id);
+            continue;
+        }
+        pr_dbg("Processing %s CQE\n", bctx->is_tx_req ? "send" : "recv");
+
+        comp_handler(wc[i].status, wc[i].vendor_err, bctx->up_ctx);
+
+        rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
+        free(bctx);
+    }
+}
+
+static void *comp_handler_thread(void *arg)
+{
+    RdmaBackendDev *backend_dev = (RdmaBackendDev *)arg;
+    int rc;
+    struct ibv_cq *ev_cq;
+    void *ev_ctx;
+
+    pr_dbg("Starting\n");
+
+    while (backend_dev->comp_thread.run) {
+        pr_dbg("Waiting for completion on channel %p\n", backend_dev->channel);
+        rc = ibv_get_cq_event(backend_dev->channel, &ev_cq, &ev_ctx);
+        pr_dbg("ibv_get_cq_event=%d\n", rc);
+        if (unlikely(rc)) {
+            pr_dbg("---> ibv_get_cq_event (%d)\n", rc);
+            continue;
+        }
+
+        if (unlikely(ibv_req_notify_cq(ev_cq, 0))) {
+            pr_dbg("---> ibv_req_notify_cq\n");
+        }
+
+        poll_cq(backend_dev->rdma_dev_res, ev_cq, false);
+
+        ibv_ack_cq_events(ev_cq, 1);
+    }
+
+    pr_dbg("Going down\n");
+    /* TODO: Post cqe for all remaining buffs that were posted */
+
+    return NULL;
+}
+
+void rdma_backend_register_comp_handler(void (*handler)(int status,
+                                        unsigned int vendor_err, void *ctx))
+{
+    comp_handler = handler;
+}
+
+void rdma_backend_unregister_comp_handler(void)
+{
+    rdma_backend_register_comp_handler(dummy_comp_handler);
+}
+
+int rdma_backend_query_port(RdmaBackendDev *backend_dev,
+                            struct ibv_port_attr *port_attr)
+{
+    int rc;
+
+    memset(port_attr, 0, sizeof(*port_attr));
+
+    rc = ibv_query_port(backend_dev->context, backend_dev->port_num, port_attr);
+    if (rc) {
+        pr_dbg("Error %d from ibv_query_port\n", rc);
+        return -EIO;
+    }
+
+    return 0;
+}
+
+void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq)
+{
+    poll_cq(rdma_dev_res, cq->ibcq, true);
+}
+
+static GHashTable *ah_hash;
+
+static struct ibv_ah *create_ah(RdmaBackendDev *backend_dev, struct ibv_pd *pd,
+                                uint8_t sgid_idx, union ibv_gid *dgid)
+{
+    GBytes *ah_key = g_bytes_new(dgid, sizeof(*dgid));
+    struct ibv_ah *ah = g_hash_table_lookup(ah_hash, ah_key);
+
+    if (ah) {
+        trace_create_ah_cache_hit(be64_to_cpu(dgid->global.subnet_prefix),
+                                  be64_to_cpu(dgid->global.interface_id));
+        g_bytes_unref(ah_key);
+    } else {
+        struct ibv_ah_attr ah_attr = {
+            .is_global     = 1,
+            .port_num      = backend_dev->port_num,
+            .grh.hop_limit = 1,
+        };
+
+        ah_attr.grh.dgid = *dgid;
+        ah_attr.grh.sgid_index = sgid_idx;
+
+        ah = ibv_create_ah(pd, &ah_attr);
+        if (ah) {
+            g_hash_table_insert(ah_hash, ah_key, ah);
+        } else {
+            pr_dbg("ibv_create_ah failed for gid <%lx %lx>\n",
+                    be64_to_cpu(dgid->global.subnet_prefix),
+                    be64_to_cpu(dgid->global.interface_id));
+        }
+
+        trace_create_ah_cache_miss(be64_to_cpu(dgid->global.subnet_prefix),
+                                   be64_to_cpu(dgid->global.interface_id));
+    }
+
+    return ah;
+}
+
+static void destroy_ah_hash_key(gpointer data)
+{
+    g_bytes_unref(data);
+}
+
+static void destroy_ah_hast_data(gpointer data)
+{
+    struct ibv_ah *ah = data;
+    ibv_destroy_ah(ah);
+}
+
+static void ah_cache_init(void)
+{
+    ah_hash = g_hash_table_new_full(g_bytes_hash, g_bytes_equal,
+                                    destroy_ah_hash_key, destroy_ah_hast_data);
+}
+
+static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
+                                struct ibv_sge *dsge, struct ibv_sge *ssge,
+                                uint8_t num_sge)
+{
+    RdmaRmMR *mr;
+    int ssge_idx;
+    int ret = 0;
+
+    pr_dbg("num_sge=%d\n", num_sge);
+
+    for (ssge_idx = 0; ssge_idx < num_sge; ssge_idx++) {
+        mr = rdma_rm_get_mr(rdma_dev_res, ssge[ssge_idx].lkey);
+        if (unlikely(!mr)) {
+            ret = VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
+            pr_dbg("Invalid lkey %d\n", ssge[ssge_idx].lkey);
+            goto out;
+        }
+
+        dsge->addr = mr->user_mr.host_virt + ssge[ssge_idx].addr -
+                     mr->user_mr.guest_start;
+        dsge->length = ssge[ssge_idx].length;
+        dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
+
+        pr_dbg("ssge->addr=0x%lx\n", (uint64_t)ssge[ssge_idx].addr);
+        pr_dbg("dsge->addr=0x%lx\n", dsge->addr);
+        pr_dbg("dsge->lenght=%d\n", dsge->length);
+        pr_dbg("dsge->lkey=0x%x\n", dsge->lkey);
+
+        dsge++;
+    }
+
+out:
+    return ret;
+}
+
+void rdma_backend_post_send(RdmaBackendDev *backend_dev,
+                            RdmaDeviceResources *rdma_dev_res,
+                            RdmaBackendQP *qp, uint8_t qp_type,
+                            struct ibv_sge *sge, uint32_t num_sge,
+                            union ibv_gid *dgid, uint32_t dqpn,
+                            uint32_t dqkey, void *ctx)
+{
+    BackendCtx *bctx;
+    struct ibv_sge new_sge[MAX_SGE];
+    uint32_t bctx_id;
+    int rc;
+    struct ibv_send_wr wr = {0}, *bad_wr;
+
+    if (!qp->ibqp && qp_type == 0) {
+        pr_dbg("QP0 is not supported\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
+        return;
+    }
+
+    pr_dbg("num_sge=%d\n", num_sge);
+
+    if (!qp->ibqp && qp_type == 1) {
+        pr_dbg("QP1\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
+    }
+
+    if (!num_sge) {
+        pr_dbg("num_sge=0\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
+        return;
+    }
+
+    bctx = malloc(sizeof(*bctx));
+    if (unlikely(!bctx)) {
+        pr_dbg("Fail to allocate request ctx\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        return;
+    }
+    memset(bctx, 0, sizeof(*bctx));
+
+    bctx->up_ctx = ctx;
+    bctx->is_tx_req = 1;
+
+    rc = rdma_rm_alloc_cqe_ctx(rdma_dev_res, &bctx_id, bctx);
+    if (unlikely(rc)) {
+        pr_dbg("Fail to allocate cqe_ctx\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        goto out_free_bctx;
+    }
+
+    rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge);
+    if (rc) {
+        pr_dbg("Error: Fail to build host SGE array\n");
+        comp_handler(IBV_WC_GENERAL_ERR, rc, ctx);
+        goto out_dealloc_cqe_ctx;
+    }
+
+    if (qp_type == IBV_QPT_UD) {
+        wr.wr.ud.ah = create_ah(backend_dev, qp->ibpd,
+                                backend_dev->backend_gid_idx, dgid);
+        wr.wr.ud.remote_qpn = dqpn;
+        wr.wr.ud.remote_qkey = dqkey;
+    }
+
+    wr.num_sge = num_sge;
+    wr.opcode = IBV_WR_SEND;
+    wr.send_flags = IBV_SEND_SIGNALED;
+    wr.sg_list = &new_sge[0];
+    wr.wr_id = bctx_id;
+
+    rc = ibv_post_send(qp->ibqp, &wr, &bad_wr);
+    pr_dbg("ibv_post_send=%d\n", rc);
+    if (rc) {
+        pr_dbg("Fail (%d, %d) to post send WQE to qpn %d\n", rc, errno,
+                qp->ibqp->qp_num);
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
+        goto out_dealloc_cqe_ctx;
+    }
+
+    return;
+
+out_dealloc_cqe_ctx:
+    rdma_rm_dealloc_cqe_ctx(rdma_dev_res, bctx_id);
+
+out_free_bctx:
+    free(bctx);
+}
+
+void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
+                            RdmaDeviceResources *rdma_dev_res,
+                            RdmaBackendQP *qp, uint8_t qp_type,
+                            struct ibv_sge *sge, uint32_t num_sge, void *ctx)
+{
+    BackendCtx *bctx;
+    struct ibv_sge new_sge[MAX_SGE];
+    uint32_t bctx_id;
+    int rc;
+    struct ibv_recv_wr wr = {0}, *bad_wr;
+
+    if (!qp->ibqp && qp_type == 0) {
+        pr_dbg("QP0 is not supported\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
+        return;
+    }
+
+    pr_dbg("num_sge=%d\n", num_sge);
+
+    if (!qp->ibqp && qp_type == 1) {
+        pr_dbg("QP1\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
+        return;
+    }
+
+    if (!num_sge) {
+        pr_dbg("num_sge=0\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
+        return;
+    }
+
+    bctx = malloc(sizeof(*bctx));
+    if (unlikely(!bctx)) {
+        pr_dbg("Fail to allocate request ctx\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        return;
+    }
+    memset(bctx, 0, sizeof(*bctx));
+
+    bctx->up_ctx = ctx;
+    bctx->is_tx_req = 0;
+
+    rc = rdma_rm_alloc_cqe_ctx(rdma_dev_res, &bctx_id, bctx);
+    if (unlikely(rc)) {
+        pr_dbg("Fail to allocate cqe_ctx\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        goto out_free_bctx;
+    }
+
+    rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge);
+    if (rc) {
+        pr_dbg("Error: Fail to build host SGE array\n");
+        comp_handler(IBV_WC_GENERAL_ERR, rc, ctx);
+        goto out_dealloc_cqe_ctx;
+    }
+
+    wr.num_sge = num_sge;
+    wr.sg_list = &new_sge[0];
+    wr.wr_id = bctx_id;
+    rc = ibv_post_recv(qp->ibqp, &wr, &bad_wr);
+    pr_dbg("ibv_post_recv=%d\n", rc);
+    if (rc) {
+        pr_dbg("Fail (%d, %d) to post recv WQE to qpn %d\n", rc, errno,
+                qp->ibqp->qp_num);
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
+        goto out_dealloc_cqe_ctx;
+    }
+
+    return;
+
+out_dealloc_cqe_ctx:
+    rdma_rm_dealloc_cqe_ctx(rdma_dev_res, bctx_id);
+
+out_free_bctx:
+    free(bctx);
+}
+
+int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd)
+{
+    pd->ibpd = ibv_alloc_pd(backend_dev->context);
+
+    return pd->ibpd ? 0 : -EIO;
+}
+
+void rdma_backend_destroy_pd(RdmaBackendPD *pd)
+{
+    if (pd->ibpd) {
+        ibv_dealloc_pd(pd->ibpd);
+    }
+}
+
+int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, uint64_t addr,
+                           size_t length, int access)
+{
+    pr_dbg("addr=0x%lx\n", addr);
+    pr_dbg("len=%ld\n", length);
+    mr->ibpd = pd->ibpd;
+    mr->ibmr = ibv_reg_mr(mr->ibpd, (void *)addr, length, access);
+
+    if (mr->ibmr) {
+        pr_dbg("lkey=0x%x\n", mr->ibmr->lkey);
+        pr_dbg("rkey=0x%x\n", mr->ibmr->rkey);
+    }
+
+    return mr->ibmr ? 0 : -EIO;
+}
+
+void rdma_backend_destroy_mr(RdmaBackendMR *mr)
+{
+    if (mr->ibmr) {
+        ibv_dereg_mr(mr->ibmr);
+    }
+}
+
+int rdma_backend_create_cq(RdmaBackendDev *backend_dev, RdmaBackendCQ *cq,
+                           int cqe)
+{
+    pr_dbg("cqe=%d\n", cqe);
+
+    pr_dbg("dev->channel=%p\n", backend_dev->channel);
+    cq->ibcq = ibv_create_cq(backend_dev->context, cqe + 1, NULL,
+                             backend_dev->channel, 0);
+
+    if (cq->ibcq) {
+        if (ibv_req_notify_cq(cq->ibcq, 0)) {
+            pr_dbg("---> ibv_req_notify_cq\n");
+        }
+    }
+
+    cq->backend_dev = backend_dev;
+
+    return cq->ibcq ? 0 : -EIO;
+}
+
+void rdma_backend_destroy_cq(RdmaBackendCQ *cq)
+{
+    if (cq->ibcq) {
+        ibv_req_notify_cq(cq->ibcq, 0);
+
+        /* Cleanup the queue before destruction */
+        poll_cq(cq->backend_dev->rdma_dev_res, cq->ibcq, false);
+
+        ibv_destroy_cq(cq->ibcq);
+    }
+}
+
+int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
+                           RdmaBackendPD *pd, RdmaBackendCQ *scq,
+                           RdmaBackendCQ *rcq, uint32_t max_send_wr,
+                           uint32_t max_recv_wr, uint32_t max_send_sge,
+                           uint32_t max_recv_sge)
+{
+    struct ibv_qp_init_attr attr = {0};
+
+    qp->ibqp = 0;
+    pr_dbg("qp_type=%d\n", qp_type);
+
+    if (qp_type == 0) {
+        pr_dbg("QP0 is not supported\n");
+        return -EPERM;
+    }
+
+    if (qp_type == 1) {
+        pr_dbg("QP1\n");
+        return 0;
+    }
+
+    attr.qp_type = qp_type;
+    attr.send_cq = scq->ibcq;
+    attr.recv_cq = rcq->ibcq;
+    attr.cap.max_send_wr = max_send_wr;
+    attr.cap.max_recv_wr = max_recv_wr;
+    attr.cap.max_send_sge = max_send_sge;
+    attr.cap.max_recv_sge = max_recv_sge;
+
+    pr_dbg("max_send_wr=%d\n", max_send_wr);
+    pr_dbg("max_recv_wr=%d\n", max_recv_wr);
+    pr_dbg("max_send_sge=%d\n", max_send_sge);
+    pr_dbg("max_recv_sge=%d\n", max_recv_sge);
+
+    qp->ibpd = pd->ibpd;
+    qp->ibqp = ibv_create_qp(qp->ibpd, &attr);
+
+    if (likely(!qp->ibqp)) {
+        pr_dbg("Error from ibv_create_qp\n");
+        return -EIO;
+    }
+
+    /* TODO: Query QP to get max_inline_data and save it to be used in send */
+
+    pr_dbg("qpn=0x%x\n", qp->ibqp->qp_num);
+
+    return 0;
+}
+
+int rdma_backend_qp_state_init(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
+                               uint8_t qp_type, uint32_t qkey)
+{
+    struct ibv_qp_attr attr = {0};
+    int rc, attr_mask;
+
+    pr_dbg("qpn=0x%x\n", qp->ibqp->qp_num);
+    pr_dbg("sport_num=%d\n", backend_dev->port_num);
+
+    attr_mask = IBV_QP_STATE | IBV_QP_PKEY_INDEX | IBV_QP_PORT;
+    attr.qp_state        = IBV_QPS_INIT;
+    attr.pkey_index      = 0;
+    attr.port_num        = backend_dev->port_num;
+    if (qp_type == IBV_QPT_RC) {
+        attr_mask |= IBV_QP_ACCESS_FLAGS;
+    }
+    if (qp_type == IBV_QPT_UD) {
+        attr.qkey = qkey;
+        if (qkey) {
+            attr_mask |= IBV_QP_QKEY;
+        }
+    }
+
+    rc = ibv_modify_qp(qp->ibqp, &attr, attr_mask);
+    if (rc) {
+        pr_dbg("Error %d from ibv_modify_qp\n", rc);
+        return -EIO;
+    }
+
+    return 0;
+}
+
+int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
+                              uint8_t qp_type, union ibv_gid *dgid,
+                              uint32_t dqpn, uint32_t rq_psn, uint32_t qkey)
+{
+    struct ibv_qp_attr attr = {0};
+    union ibv_gid ibv_gid = {
+        .global.interface_id = dgid->global.interface_id,
+        .global.subnet_prefix = dgid->global.subnet_prefix
+    };
+    int rc, attr_mask = 0;
+
+    attr.qp_state = IBV_QPS_RTR;
+    attr_mask = IBV_QP_STATE;
+
+    if (qp_type == IBV_QPT_RC) {
+        pr_dbg("dgid=0x%lx,%lx\n", be64_to_cpu(ibv_gid.global.subnet_prefix),
+               be64_to_cpu(ibv_gid.global.interface_id));
+        pr_dbg("dqpn=0x%x\n", dqpn);
+        pr_dbg("sgid_idx=%d\n", backend_dev->backend_gid_idx);
+        pr_dbg("sport_num=%d\n", backend_dev->port_num);
+        pr_dbg("rq_psn=0x%x\n", rq_psn);
+
+        attr.path_mtu               = IBV_MTU_1024;
+        attr.dest_qp_num            = dqpn;
+        attr.max_dest_rd_atomic     = 1;
+        attr.min_rnr_timer          = 12;
+        attr.ah_attr.port_num       = backend_dev->port_num;
+        attr.ah_attr.is_global      = 1;
+        attr.ah_attr.grh.hop_limit  = 1;
+        attr.ah_attr.grh.dgid       = ibv_gid;
+        attr.ah_attr.grh.sgid_index = backend_dev->backend_gid_idx;
+        attr.rq_psn                 = rq_psn;
+
+        attr_mask |= IBV_QP_AV | IBV_QP_PATH_MTU | IBV_QP_DEST_QPN |
+                     IBV_QP_RQ_PSN | IBV_QP_MAX_DEST_RD_ATOMIC |
+                     IBV_QP_MIN_RNR_TIMER;
+    }
+
+    if (qp_type == IBV_QPT_UD) {
+        pr_dbg("qkey=0x%x\n", qkey);
+        attr.qkey = qkey;
+        if (qkey) {
+            attr_mask |= IBV_QP_QKEY;
+        }
+    }
+
+    rc = ibv_modify_qp(qp->ibqp, &attr, attr_mask);
+    if (rc) {
+        pr_dbg("Error %d from ibv_modify_qp\n", rc);
+        return -EIO;
+    }
+
+    return 0;
+}
+
+int rdma_backend_qp_state_rts(RdmaBackendQP *qp, uint8_t qp_type,
+                              uint32_t sq_psn, uint32_t qkey)
+{
+    struct ibv_qp_attr attr = {0};
+    int rc, attr_mask = 0;
+
+    pr_dbg("qpn=0x%x\n", qp->ibqp->qp_num);
+    pr_dbg("sq_psn=0x%x\n", sq_psn);
+
+    attr_mask |= IBV_QP_SQ_PSN;
+    attr.sq_psn = sq_psn;
+
+    attr.qp_state = IBV_QPS_RTS;
+    attr_mask = IBV_QP_STATE | IBV_QP_SQ_PSN;
+
+    if (qp_type == IBV_QPT_RC) {
+        attr.timeout       = 14;
+        attr.retry_cnt     = 7;
+        attr.rnr_retry     = 7;
+        attr.max_rd_atomic = 1;
+
+        attr_mask |= IBV_QP_TIMEOUT | IBV_QP_RETRY_CNT | IBV_QP_RNR_RETRY |
+                     IBV_QP_MAX_QP_RD_ATOMIC;
+    }
+
+    if (qp_type == IBV_QPT_UD) {
+        attr.qkey = qkey;
+        if (qkey) {
+            attr_mask |= IBV_QP_QKEY;
+        }
+    }
+
+    rc = ibv_modify_qp(qp->ibqp, &attr, attr_mask);
+    if (rc) {
+        pr_dbg("Error %d from ibv_modify_qp\n", rc);
+        return -EIO;
+    }
+
+    return 0;
+}
+
+void rdma_backend_destroy_qp(RdmaBackendQP *qp)
+{
+    if (qp->ibqp) {
+        ibv_destroy_qp(qp->ibqp);
+    }
+}
+
+#define CHK_ATTR(req, dev, member, fmt) ({ \
+    pr_dbg("%s="fmt","fmt"\n", #member, dev.member, req->member); \
+    if (req->member > dev.member) { \
+        warn_report("Setting of %s to 0x%lx higher than host device capability 0x%lx", \
+                    #member, (uint64_t)req->member, (uint64_t)dev.member); \
+        req->member = dev.member; \
+    } \
+    pr_dbg("%s="fmt"\n", #member, req->member); })
+
+static int init_device_caps(RdmaBackendDev *backend_dev,
+                            struct ibv_device_attr *dev_attr)
+{
+    memset(&backend_dev->dev_attr, 0, sizeof(backend_dev->dev_attr));
+
+    if (ibv_query_device(backend_dev->context, &backend_dev->dev_attr)) {
+        return -EIO;
+    }
+
+    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_mr_size, "%ld");
+    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp, "%d");
+    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_sge, "%d");
+    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_wr, "%d");
+    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_cq, "%d");
+    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_cqe, "%d");
+    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_mr, "%d");
+    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_pd, "%d");
+    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_rd_atom, "%d");
+    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_init_rd_atom, "%d");
+    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_ah, "%d");
+
+    return 0;
+}
+
+int rdma_backend_init(RdmaBackendDev *backend_dev,
+                      RdmaDeviceResources *rdma_dev_res,
+                      const char *backend_device_name, uint8_t port_num,
+                      uint8_t backend_gid_idx, struct ibv_device_attr *dev_attr,
+                      Error **errp)
+{
+    int i;
+    int ret = 0;
+    int num_ibv_devices;
+    char thread_name[80] = {0};
+    struct ibv_device **dev_list;
+    struct ibv_port_attr port_attr;
+
+    backend_dev->backend_gid_idx = backend_gid_idx;
+    backend_dev->port_num = port_num;
+    backend_dev->rdma_dev_res = rdma_dev_res;
+
+    rdma_backend_register_comp_handler(dummy_comp_handler);
+
+    dev_list = ibv_get_device_list(&num_ibv_devices);
+    if (!dev_list) {
+        error_setg(errp, "Failed to get IB devices list");
+        ret = -EIO;
+        goto out;
+    }
+    if (num_ibv_devices == 0) {
+        error_setg(errp, "No IB devices were found");
+        ret = -ENXIO;
+        goto out;
+    }
+
+    if (backend_device_name) {
+        for (i = 0; dev_list[i]; ++i) {
+            if (!strcmp(ibv_get_device_name(dev_list[i]),
+                        backend_device_name)) {
+                break;
+            }
+        }
+
+        backend_dev->ib_dev = dev_list[i];
+        if (!backend_dev->ib_dev) {
+            error_setg(errp, "Failed to find IB device %s",
+                       backend_device_name);
+            ret = -EIO;
+            goto out;
+        }
+    } else {
+        backend_dev->ib_dev = *dev_list;
+    }
+    ibv_free_device_list(dev_list);
+
+    pr_dbg("Using backend device %s, port %d, gid_idx %d\n",
+           ibv_get_device_name(backend_dev->ib_dev),
+           backend_dev->port_num, backend_dev->backend_gid_idx);
+
+    backend_dev->context = ibv_open_device(backend_dev->ib_dev);
+    if (!backend_dev->context) {
+        error_setg(errp, "Failed to open IB device");
+        ret = -EIO;
+        goto out;
+    }
+
+    backend_dev->channel = ibv_create_comp_channel(backend_dev->context);
+    if (!backend_dev->channel) {
+        error_setg(errp, "Failed to create IB communication channel");
+        ret = -EIO;
+        goto out_close_device;
+    }
+    pr_dbg("dev->backend_dev.channel=%p\n", backend_dev->channel);
+
+    ret = ibv_query_gid(backend_dev->context, backend_dev->port_num,
+                         backend_dev->backend_gid_idx, &backend_dev->gid);
+    if (ret) {
+        error_setg(errp, "Failed to query gid %d",
+                   backend_dev->backend_gid_idx);
+        ret = -EIO;
+        goto out_destroy_comm_channel;
+    }
+    pr_dbg("subnet_prefix=0x%lx\n",
+           be64_to_cpu(backend_dev->gid.global.subnet_prefix));
+    pr_dbg("interface_id=0x%lx\n",
+           be64_to_cpu(backend_dev->gid.global.interface_id));
+
+    ret = ibv_query_port(backend_dev->context, backend_dev->port_num,
+                         &port_attr);
+    if (ret) {
+        error_setg(errp, "Error %d from ibv_query_port", ret);
+        ret = -EIO;
+        goto out_destroy_comm_channel;
+    }
+
+    ret = init_device_caps(backend_dev, dev_attr);
+    if (ret) {
+        error_setg(errp, "Fail to initialize device capabilities");
+        ret = -EIO;
+        goto out_destroy_comm_channel;
+    }
+
+    sprintf(thread_name, "pvrdma_comp_%s",
+            ibv_get_device_name(backend_dev->ib_dev));
+    backend_dev->comp_thread.run = true;
+    qemu_thread_create(&backend_dev->comp_thread.thread, thread_name,
+                       comp_handler_thread, backend_dev, QEMU_THREAD_DETACHED);
+
+    ah_cache_init();
+
+    goto out;
+
+out_destroy_comm_channel:
+    ibv_destroy_comp_channel(backend_dev->channel);
+
+out_close_device:
+    ibv_close_device(backend_dev->context);
+
+out:
+    return ret;
+}
+
+void rdma_backend_fini(RdmaBackendDev *backend_dev)
+{
+    g_hash_table_destroy(ah_hash);
+    ibv_destroy_comp_channel(backend_dev->channel);
+    ibv_close_device(backend_dev->context);
+}
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
new file mode 100644
index 0000000000..0a594a42ca
--- /dev/null
+++ b/hw/rdma/rdma_backend.h
@@ -0,0 +1,92 @@
+/*
+ *  RDMA device: Definitions of Backend Device functions
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef RDMA_BACKEND_H
+#define RDMA_BACKEND_H
+
+#include <qapi/error.h>
+#include "rdma_rm_defs.h"
+#include "rdma_backend_defs.h"
+
+static inline union ibv_gid *rdma_backend_gid(RdmaBackendDev *dev)
+{
+    return &dev->gid;
+}
+
+static inline uint32_t rdma_backend_qpn(RdmaBackendQP *qp)
+{
+    return qp->ibqp ? qp->ibqp->qp_num : 0;
+}
+
+static inline uint32_t rdma_backend_mr_lkey(RdmaBackendMR *mr)
+{
+    return mr->ibmr ? mr->ibmr->lkey : 0;
+}
+
+static inline uint32_t rdma_backend_mr_rkey(RdmaBackendMR *mr)
+{
+    return mr->ibmr ? mr->ibmr->rkey : 0;
+}
+
+int rdma_backend_init(RdmaBackendDev *backend_dev,
+                      RdmaDeviceResources *rdma_dev_res,
+                      const char *backend_device_name, uint8_t port_num,
+                      uint8_t backend_gid_idx, struct ibv_device_attr *dev_attr,
+                      Error **errp);
+void rdma_backend_fini(RdmaBackendDev *backend_dev);
+void rdma_backend_register_comp_handler(void (*handler)(int status,
+                                        unsigned int vendor_err, void *ctx));
+void rdma_backend_unregister_comp_handler(void);
+
+int rdma_backend_query_port(RdmaBackendDev *backend_dev,
+                            struct ibv_port_attr *port_attr);
+int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd);
+void rdma_backend_destroy_pd(RdmaBackendPD *pd);
+
+int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, uint64_t addr,
+                           size_t length, int access);
+void rdma_backend_destroy_mr(RdmaBackendMR *mr);
+
+int rdma_backend_create_cq(RdmaBackendDev *backend_dev, RdmaBackendCQ *cq,
+                           int cqe);
+void rdma_backend_destroy_cq(RdmaBackendCQ *cq);
+void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq);
+
+int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
+                           RdmaBackendPD *pd, RdmaBackendCQ *scq,
+                           RdmaBackendCQ *rcq, uint32_t max_send_wr,
+                           uint32_t max_recv_wr, uint32_t max_send_sge,
+                           uint32_t max_recv_sge);
+int rdma_backend_qp_state_init(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
+                               uint8_t qp_type, uint32_t qkey);
+int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
+                              uint8_t qp_type, union ibv_gid *dgid,
+                              uint32_t dqpn, uint32_t rq_psn, uint32_t qkey);
+int rdma_backend_qp_state_rts(RdmaBackendQP *qp, uint8_t qp_type,
+                              uint32_t sq_psn, uint32_t qkey);
+void rdma_backend_destroy_qp(RdmaBackendQP *qp);
+
+void rdma_backend_post_send(RdmaBackendDev *backend_dev,
+                            RdmaDeviceResources *rdma_dev_res,
+                            RdmaBackendQP *qp, uint8_t qp_type,
+                            struct ibv_sge *sge, uint32_t num_sge,
+                            union ibv_gid *dgid, uint32_t dqpn, uint32_t dqkey,
+                            void *ctx);
+void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
+                            RdmaDeviceResources *rdma_dev_res,
+                            RdmaBackendQP *qp, uint8_t qp_type,
+                            struct ibv_sge *sge, uint32_t num_sge, void *ctx);
+
+#endif
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
new file mode 100644
index 0000000000..516e6e0b19
--- /dev/null
+++ b/hw/rdma/rdma_backend_defs.h
@@ -0,0 +1,62 @@
+/*
+ *  RDMA device: Definitions of Backend Device structures
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef RDMA_BACKEND_DEFS_H
+#define RDMA_BACKEND_DEFS_H
+
+#include <infiniband/verbs.h>
+#include <qemu/thread.h>
+
+typedef struct RdmaDeviceResources RdmaDeviceResources;
+
+typedef struct RdmaBackendThread {
+    QemuThread thread;
+    QemuMutex mutex;
+    bool run;
+} RdmaBackendThread;
+
+typedef struct RdmaBackendDev {
+    PCIDevice *dev;
+    RdmaBackendThread comp_thread;
+    struct ibv_device *ib_dev;
+    uint8_t port_num;
+    struct ibv_context *context;
+    struct ibv_comp_channel *channel;
+    union ibv_gid gid;
+    struct ibv_device_attr dev_attr;
+    uint8_t backend_gid_idx;
+    RdmaDeviceResources *rdma_dev_res;
+} RdmaBackendDev;
+
+typedef struct RdmaBackendPD {
+    struct ibv_pd *ibpd;
+} RdmaBackendPD;
+
+typedef struct RdmaBackendMR {
+    struct ibv_pd *ibpd;
+    struct ibv_mr *ibmr;
+} RdmaBackendMR;
+
+typedef struct RdmaBackendCQ {
+    RdmaBackendDev *backend_dev;
+    struct ibv_cq *ibcq;
+} RdmaBackendCQ;
+
+typedef struct RdmaBackendQP {
+    struct ibv_pd *ibpd;
+    struct ibv_qp *ibqp;
+} RdmaBackendQP;
+
+#endif
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
new file mode 100644
index 0000000000..8d9d87cc27
--- /dev/null
+++ b/hw/rdma/rdma_rm.c
@@ -0,0 +1,619 @@
+/*
+ * QEMU paravirtual RDMA - Resource Manager Implementation
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include <qemu/osdep.h>
+#include <qapi/error.h>
+#include <cpu.h>
+
+#include "rdma_utils.h"
+#include "rdma_backend.h"
+#include "rdma_rm.h"
+
+#define MAX_RM_TBL_NAME 16
+
+/* Page directory and page tables */
+#define PG_DIR_SZ { TARGET_PAGE_SIZE / sizeof(__u64) }
+#define PG_TBL_SZ { TARGET_PAGE_SIZE / sizeof(__u64) }
+
+static inline int res_tbl_init(const char *name, RdmaRmResTbl *tbl,
+                               uint32_t tbl_sz, uint32_t res_sz)
+{
+    tbl->tbl = malloc(tbl_sz * res_sz);
+    if (!tbl->tbl) {
+        return -ENOMEM;
+    }
+
+    strncpy(tbl->name, name, MAX_RM_TBL_NAME);
+    tbl->name[MAX_RM_TBL_NAME - 1] = 0;
+
+    tbl->bitmap = bitmap_new(tbl_sz);
+    tbl->tbl_sz = tbl_sz;
+    tbl->res_sz = res_sz;
+    qemu_mutex_init(&tbl->lock);
+
+    return 0;
+}
+
+static inline void res_tbl_free(RdmaRmResTbl *tbl)
+{
+    qemu_mutex_destroy(&tbl->lock);
+    free(tbl->tbl);
+    bitmap_zero_extend(tbl->bitmap, tbl->tbl_sz, 0);
+}
+
+static inline void *res_tbl_get(RdmaRmResTbl *tbl, uint32_t handle)
+{
+    pr_dbg("%s, handle=%d\n", tbl->name, handle);
+
+    if ((handle < tbl->tbl_sz) && (test_bit(handle, tbl->bitmap))) {
+        return tbl->tbl + handle * tbl->res_sz;
+    } else {
+        pr_dbg("Invalid handle %d\n", handle);
+        return NULL;
+    }
+}
+
+static inline void *res_tbl_alloc(RdmaRmResTbl *tbl, uint32_t *handle)
+{
+    qemu_mutex_lock(&tbl->lock);
+
+    *handle = find_first_zero_bit(tbl->bitmap, tbl->tbl_sz);
+    if (*handle > tbl->tbl_sz) {
+        pr_dbg("Fail to alloc, bitmap is full\n");
+        qemu_mutex_unlock(&tbl->lock);
+        return NULL;
+    }
+
+    set_bit(*handle, tbl->bitmap);
+
+    qemu_mutex_unlock(&tbl->lock);
+
+    memset(tbl->tbl + *handle * tbl->res_sz, 0, tbl->res_sz);
+
+    pr_dbg("%s, handle=%d\n", tbl->name, *handle);
+
+    return tbl->tbl + *handle * tbl->res_sz;
+}
+
+static inline void res_tbl_dealloc(RdmaRmResTbl *tbl, uint32_t handle)
+{
+    pr_dbg("%s, handle=%d\n", tbl->name, handle);
+
+    qemu_mutex_lock(&tbl->lock);
+
+    if (handle < tbl->tbl_sz) {
+        clear_bit(handle, tbl->bitmap);
+    }
+
+    qemu_mutex_unlock(&tbl->lock);
+}
+
+int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                     uint32_t *pd_handle, uint32_t ctx_handle)
+{
+    RdmaRmPD *pd;
+    int ret = -ENOMEM;
+
+    pd = res_tbl_alloc(&dev_res->pd_tbl, pd_handle);
+    if (!pd) {
+        goto out;
+    }
+
+    ret = rdma_backend_create_pd(backend_dev, &pd->backend_pd);
+    if (ret) {
+        ret = -EIO;
+        goto out_tbl_dealloc;
+    }
+
+    pd->ctx_handle = ctx_handle;
+
+    return 0;
+
+out_tbl_dealloc:
+    res_tbl_dealloc(&dev_res->pd_tbl, *pd_handle);
+
+out:
+    return ret;
+}
+
+RdmaRmPD *rdma_rm_get_pd(RdmaDeviceResources *dev_res, uint32_t pd_handle)
+{
+    return res_tbl_get(&dev_res->pd_tbl, pd_handle);
+}
+
+void rdma_rm_dealloc_pd(RdmaDeviceResources *dev_res, uint32_t pd_handle)
+{
+    RdmaRmPD *pd = rdma_rm_get_pd(dev_res, pd_handle);
+
+    if (pd) {
+        rdma_backend_destroy_pd(&pd->backend_pd);
+        res_tbl_dealloc(&dev_res->pd_tbl, pd_handle);
+    }
+}
+
+int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
+                     uint64_t guest_start, size_t guest_length, void *host_virt,
+                     int access_flags, uint32_t *mr_handle, uint32_t *lkey,
+                     uint32_t *rkey)
+{
+    RdmaRmMR *mr;
+    int ret = 0;
+    RdmaRmPD *pd;
+    uint64_t addr;
+    size_t length;
+
+    pd = rdma_rm_get_pd(dev_res, pd_handle);
+    if (!pd) {
+        pr_dbg("Invalid PD\n");
+        ret = -EINVAL;
+        goto out;
+    }
+
+    mr = res_tbl_alloc(&dev_res->mr_tbl, mr_handle);
+    if (!mr) {
+        pr_dbg("Fail to allocate obj in table\n");
+        ret = -ENOMEM;
+        goto out;
+    }
+
+    if (!host_virt) {
+        /* TODO: This is my guess but not so sure that this needs to be
+         * done */
+        length = mr->length = TARGET_PAGE_SIZE;
+        addr = mr->addr = (uint64_t)malloc(length);
+    } else {
+        mr->addr = 0;
+
+        mr->user_mr.host_virt = (uint64_t) host_virt;
+        pr_dbg("host_virt=0x%lx\n", mr->user_mr.host_virt);
+        mr->user_mr.length = guest_length;
+        pr_dbg("length=0x%lx\n", guest_length);
+        mr->user_mr.guest_start = guest_start;
+        pr_dbg("guest_start=0x%lx\n", mr->user_mr.guest_start);
+
+        length = mr->user_mr.length;
+        addr = mr->user_mr.host_virt;
+    }
+
+    ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, addr, length,
+                                 access_flags);
+    if (ret) {
+        pr_dbg("Fail in rdma_backend_create_mr, err=%d\n", ret);
+        ret = -EIO;
+        goto out_dealloc_mr;
+    }
+
+    if (!host_virt) {
+        *lkey = mr->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
+        *rkey = mr->rkey = rdma_backend_mr_rkey(&mr->backend_mr);
+    } else {
+        /* We keep mr_handle in lkey so send and recv get get mr ptr */
+        *lkey = *mr_handle;
+        *rkey = -1;
+    }
+
+    mr->pd_handle = pd_handle;
+
+    return 0;
+
+out_dealloc_mr:
+    res_tbl_dealloc(&dev_res->mr_tbl, *mr_handle);
+
+out:
+    return ret;
+}
+
+RdmaRmMR *rdma_rm_get_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle)
+{
+    return res_tbl_get(&dev_res->mr_tbl, mr_handle);
+}
+
+void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle)
+{
+    RdmaRmMR *mr = rdma_rm_get_mr(dev_res, mr_handle);
+
+    if (mr) {
+        rdma_backend_destroy_mr(&mr->backend_mr);
+        munmap((void *)mr->user_mr.host_virt, mr->user_mr.length);
+        free((void *)mr->addr);
+        res_tbl_dealloc(&dev_res->mr_tbl, mr_handle);
+    }
+}
+
+int rdma_rm_alloc_uc(RdmaDeviceResources *dev_res, uint32_t pfn,
+                     uint32_t *uc_handle)
+{
+    RdmaRmUC *uc;
+
+    /* TODO: Need to make sure pfn is between bar start address and
+     * bsd+RDMA_BAR2_UAR_SIZE
+    if (pfn > RDMA_BAR2_UAR_SIZE) {
+        pr_err("pfn out of range (%d > %d)\n", pfn, RDMA_BAR2_UAR_SIZE);
+        return -ENOMEM;
+    }
+    */
+
+    uc = res_tbl_alloc(&dev_res->uc_tbl, uc_handle);
+    if (!uc) {
+        return -ENOMEM;
+    }
+
+    return 0;
+}
+
+RdmaRmUC *rdma_rm_get_uc(RdmaDeviceResources *dev_res, uint32_t uc_handle)
+{
+    return res_tbl_get(&dev_res->uc_tbl, uc_handle);
+}
+
+void rdma_rm_dealloc_uc(RdmaDeviceResources *dev_res, uint32_t uc_handle)
+{
+    RdmaRmUC *uc = rdma_rm_get_uc(dev_res, uc_handle);
+
+    if (uc) {
+        res_tbl_dealloc(&dev_res->uc_tbl, uc_handle);
+    }
+}
+
+RdmaRmCQ *rdma_rm_get_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle)
+{
+    return res_tbl_get(&dev_res->cq_tbl, cq_handle);
+}
+
+int rdma_rm_alloc_cq(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                     uint32_t cqe, uint32_t *cq_handle, void *opaque)
+{
+    int rc = -ENOMEM;
+    RdmaRmCQ *cq;
+
+    cq = res_tbl_alloc(&dev_res->cq_tbl, cq_handle);
+    if (!cq) {
+        return -ENOMEM;
+    }
+
+    cq->opaque = opaque;
+    cq->notify = false;
+
+    rc = rdma_backend_create_cq(backend_dev, &cq->backend_cq, cqe);
+    if (rc) {
+        rc = -EIO;
+        goto out_dealloc_cq;
+    }
+
+    goto out;
+
+out_dealloc_cq:
+    rdma_rm_dealloc_cq(dev_res, *cq_handle);
+
+out:
+    return rc;
+}
+
+void rdma_rm_req_notify_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle,
+                           bool notify)
+{
+    RdmaRmCQ *cq;
+
+    pr_dbg("cq_handle=%d, notify=0x%x\n", cq_handle, notify);
+
+    cq = rdma_rm_get_cq(dev_res, cq_handle);
+    if (!cq) {
+        return;
+    }
+
+    cq->notify = notify;
+    pr_dbg("notify=%d\n", cq->notify);
+}
+
+void rdma_rm_dealloc_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle)
+{
+    RdmaRmCQ *cq;
+
+    cq = rdma_rm_get_cq(dev_res, cq_handle);
+    if (!cq) {
+        return;
+    }
+
+    rdma_backend_destroy_cq(&cq->backend_cq);
+
+    res_tbl_dealloc(&dev_res->cq_tbl, cq_handle);
+}
+
+RdmaRmQP *rdma_rm_get_qp(RdmaDeviceResources *dev_res, uint32_t qpn)
+{
+    GBytes *key = g_bytes_new(&qpn, sizeof(qpn));
+
+    RdmaRmQP *qp = g_hash_table_lookup(dev_res->qp_hash, key);
+
+    g_bytes_unref(key);
+
+    return qp;
+}
+
+int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
+                     uint8_t qp_type, uint32_t max_send_wr,
+                     uint32_t max_send_sge, uint32_t send_cq_handle,
+                     uint32_t max_recv_wr, uint32_t max_recv_sge,
+                     uint32_t recv_cq_handle, void *opaque, uint32_t *qpn)
+{
+    int rc = 0;
+    RdmaRmQP *qp;
+    RdmaRmCQ *scq, *rcq;
+    RdmaRmPD *pd;
+    uint32_t rm_qpn;
+
+    pr_dbg("qp_type=%d\n", qp_type);
+
+    pd = rdma_rm_get_pd(dev_res, pd_handle);
+    if (!pd) {
+        pr_err("Invalid pd handle (%d)\n", pd_handle);
+        return -EINVAL;
+    }
+
+    scq = rdma_rm_get_cq(dev_res, send_cq_handle);
+    rcq = rdma_rm_get_cq(dev_res, recv_cq_handle);
+
+    if (!scq || !rcq) {
+        pr_err("Invalid send_cqn or recv_cqn (%d, %d)\n",
+               send_cq_handle, recv_cq_handle);
+        return -EINVAL;
+    }
+
+    qp = res_tbl_alloc(&dev_res->qp_tbl, &rm_qpn);
+    if (!qp) {
+        return -ENOMEM;
+    }
+    pr_dbg("rm_qpn=%d\n", rm_qpn);
+
+    qp->qpn = rm_qpn;
+    qp->qp_state = IBV_QPS_ERR;
+    qp->qp_type = qp_type;
+    qp->send_cq_handle = send_cq_handle;
+    qp->recv_cq_handle = recv_cq_handle;
+    qp->opaque = opaque;
+
+    rc = rdma_backend_create_qp(&qp->backend_qp, qp_type, &pd->backend_pd,
+                                &scq->backend_cq, &rcq->backend_cq, max_send_wr,
+                                max_recv_wr, max_send_sge, max_recv_sge);
+    if (rc) {
+        rc = -EIO;
+        goto out_dealloc_qp;
+    }
+
+    *qpn = rdma_backend_qpn(&qp->backend_qp);
+    pr_dbg("rm_qpn=%d, backend_qpn=0x%x\n", rm_qpn, *qpn);
+    g_hash_table_insert(dev_res->qp_hash, g_bytes_new(qpn, sizeof(*qpn)), qp);
+
+    return 0;
+
+out_dealloc_qp:
+    res_tbl_dealloc(&dev_res->qp_tbl, qp->qpn);
+
+    return rc;
+}
+
+int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                      uint32_t qp_handle, uint32_t attr_mask,
+                      union ibv_gid *dgid, uint32_t dqpn,
+                      enum ibv_qp_state qp_state, uint32_t qkey,
+                      uint32_t rq_psn, uint32_t sq_psn)
+{
+    RdmaRmQP *qp;
+    int ret;
+
+    pr_dbg("qpn=%d\n", qp_handle);
+
+    qp = rdma_rm_get_qp(dev_res, qp_handle);
+    if (!qp) {
+        return -EINVAL;
+    }
+
+    pr_dbg("qp_type=%d\n", qp->qp_type);
+    pr_dbg("attr_mask=0x%x\n", attr_mask);
+
+    if (qp->qp_type == 0) {
+        pr_dbg("QP0 is not supported\n");
+        return -EPERM;
+    }
+
+    if (qp->qp_type == 1) {
+        pr_dbg("QP1\n");
+        return 0;
+    }
+
+    if (attr_mask & IBV_QP_STATE) {
+        qp->qp_state = qp_state;
+        pr_dbg("qp_state=%d\n", qp->qp_state);
+
+        if (qp->qp_state == IBV_QPS_INIT) {
+            ret = rdma_backend_qp_state_init(backend_dev, &qp->backend_qp,
+                                             qp->qp_type, qkey);
+            if (ret) {
+                return -EIO;
+            }
+        }
+
+        if (qp->qp_state == IBV_QPS_RTR) {
+            if (!(attr_mask & IBV_QP_DEST_QPN) && qp->qp_type == IBV_QPT_RC) {
+                pr_dbg("IBV_QPS_RTR but not IBV_QP_DEST_QPN\n");
+                return -EIO;
+            }
+            if (!(attr_mask & IBV_QP_AV) && qp->qp_type == IBV_QPT_RC) {
+                pr_dbg("IBV_QPS_RTR but not IBV_QP_AV\n");
+                return -EIO;
+            }
+
+            ret = rdma_backend_qp_state_rtr(backend_dev, &qp->backend_qp,
+                                            qp->qp_type, dgid, dqpn, rq_psn,
+                                            qkey);
+            if (ret) {
+                return -EIO;
+            }
+        }
+
+        if (qp->qp_state == IBV_QPS_RTS) {
+            ret = rdma_backend_qp_state_rts(&qp->backend_qp, qp->qp_type,
+                                            sq_psn, qkey);
+            if (ret) {
+                return -EIO;
+            }
+        }
+    }
+
+    return 0;
+}
+
+void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle)
+{
+    RdmaRmQP *qp;
+    GBytes *key;
+
+    key = g_bytes_new(&qp_handle, sizeof(qp_handle));
+    qp = g_hash_table_lookup(dev_res->qp_hash, key);
+    if (!qp) {
+        return;
+    }
+    g_hash_table_remove(dev_res->qp_hash, key);
+    g_bytes_unref(key);
+
+    rdma_backend_destroy_qp(&qp->backend_qp);
+
+    res_tbl_dealloc(&dev_res->qp_tbl, qp->qpn);
+}
+
+void *rdma_rm_get_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id)
+{
+    void **cqe_ctx;
+
+    cqe_ctx = res_tbl_get(&dev_res->cqe_ctx_tbl, cqe_ctx_id);
+    if (!cqe_ctx) {
+        return NULL;
+    }
+
+    pr_dbg("ctx=%p\n", *cqe_ctx);
+
+    return *cqe_ctx;
+}
+
+int rdma_rm_alloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t *cqe_ctx_id,
+                          void *ctx)
+{
+    void **cqe_ctx;
+
+    cqe_ctx = res_tbl_alloc(&dev_res->cqe_ctx_tbl, cqe_ctx_id);
+    if (!cqe_ctx) {
+        return -ENOMEM;
+    }
+
+    pr_dbg("ctx=%p\n", ctx);
+    *cqe_ctx = ctx;
+
+    return 0;
+}
+
+void rdma_rm_dealloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id)
+{
+    res_tbl_dealloc(&dev_res->cqe_ctx_tbl, cqe_ctx_id);
+}
+
+static void destroy_qp_hash_key(gpointer data)
+{
+    g_bytes_unref(data);
+}
+
+int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr,
+                 Error **errp)
+{
+    int ret = 0;
+
+    ret = res_tbl_init("PD", &dev_res->pd_tbl, dev_attr->max_pd,
+                       sizeof(RdmaRmPD));
+    if (ret) {
+        goto out;
+    }
+
+    ret = res_tbl_init("CQ", &dev_res->cq_tbl, dev_attr->max_cq,
+                       sizeof(RdmaRmCQ));
+    if (ret) {
+        goto cln_pds;
+    }
+
+    ret = res_tbl_init("MR", &dev_res->mr_tbl, dev_attr->max_mr,
+                       sizeof(RdmaRmMR));
+    if (ret) {
+        goto cln_cqs;
+    }
+
+    ret = res_tbl_init("QP", &dev_res->qp_tbl, dev_attr->max_qp,
+                       sizeof(RdmaRmQP));
+    if (ret) {
+        goto cln_mrs;
+    }
+
+    ret = res_tbl_init("CQE_CTX", &dev_res->cqe_ctx_tbl, dev_attr->max_qp *
+                       dev_attr->max_qp_wr, sizeof(void *));
+    if (ret) {
+        goto cln_qps;
+    }
+
+    ret = res_tbl_init("UC", &dev_res->uc_tbl, MAX_UCS, sizeof(RdmaRmUC));
+    if (ret) {
+        goto cln_cqe_ctxs;
+    }
+
+    dev_res->qp_hash = g_hash_table_new_full(g_bytes_hash, g_bytes_equal,
+                                             destroy_qp_hash_key, NULL);
+    if (!dev_res->qp_hash) {
+        goto cln_ucs;
+    }
+
+    goto out;
+
+cln_ucs:
+    res_tbl_free(&dev_res->uc_tbl);
+
+cln_cqe_ctxs:
+    res_tbl_free(&dev_res->cqe_ctx_tbl);
+
+cln_qps:
+    res_tbl_free(&dev_res->qp_tbl);
+
+cln_mrs:
+    res_tbl_free(&dev_res->mr_tbl);
+
+cln_cqs:
+    res_tbl_free(&dev_res->cq_tbl);
+
+cln_pds:
+    res_tbl_free(&dev_res->pd_tbl);
+
+out:
+    if (ret) {
+        error_setg(errp, "Fail to initialize RM");
+    }
+
+    return ret;
+}
+
+void rdma_rm_fini(RdmaDeviceResources *dev_res)
+{
+    res_tbl_free(&dev_res->uc_tbl);
+    res_tbl_free(&dev_res->cqe_ctx_tbl);
+    res_tbl_free(&dev_res->qp_tbl);
+    res_tbl_free(&dev_res->cq_tbl);
+    res_tbl_free(&dev_res->mr_tbl);
+    res_tbl_free(&dev_res->pd_tbl);
+    g_hash_table_destroy(dev_res->qp_hash);
+}
diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
new file mode 100644
index 0000000000..82a1026629
--- /dev/null
+++ b/hw/rdma/rdma_rm.h
@@ -0,0 +1,69 @@
+/*
+ * RDMA device: Definitions of Resource Manager functions
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef RDMA_RM_H
+#define RDMA_RM_H
+
+#include <qapi/error.h>
+#include "rdma_backend_defs.h"
+#include "rdma_rm_defs.h"
+
+int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr,
+                 Error **errp);
+void rdma_rm_fini(RdmaDeviceResources *dev_res);
+
+int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                     uint32_t *pd_handle, uint32_t ctx_handle);
+RdmaRmPD *rdma_rm_get_pd(RdmaDeviceResources *dev_res, uint32_t pd_handle);
+void rdma_rm_dealloc_pd(RdmaDeviceResources *dev_res, uint32_t pd_handle);
+
+int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
+                     uint64_t guest_start, size_t guest_length, void *host_virt,
+                     int access_flags, uint32_t *mr_handle, uint32_t *lkey,
+                     uint32_t *rkey);
+RdmaRmMR *rdma_rm_get_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle);
+void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle);
+
+int rdma_rm_alloc_uc(RdmaDeviceResources *dev_res, uint32_t pfn,
+                     uint32_t *uc_handle);
+RdmaRmUC *rdma_rm_get_uc(RdmaDeviceResources *dev_res, uint32_t uc_handle);
+void rdma_rm_dealloc_uc(RdmaDeviceResources *dev_res, uint32_t uc_handle);
+
+int rdma_rm_alloc_cq(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                     uint32_t cqe, uint32_t *cq_handle, void *opaque);
+RdmaRmCQ *rdma_rm_get_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle);
+void rdma_rm_req_notify_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle,
+                           bool notify);
+void rdma_rm_dealloc_cq(RdmaDeviceResources *dev_res, uint32_t cq_handle);
+
+int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
+                     uint8_t qp_type, uint32_t max_send_wr,
+                     uint32_t max_send_sge, uint32_t send_cq_handle,
+                     uint32_t max_recv_wr, uint32_t max_recv_sge,
+                     uint32_t recv_cq_handle, void *opaque, uint32_t *qpn);
+RdmaRmQP *rdma_rm_get_qp(RdmaDeviceResources *dev_res, uint32_t qpn);
+int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                      uint32_t qp_handle, uint32_t attr_mask,
+                      union ibv_gid *dgid, uint32_t dqpn,
+                      enum ibv_qp_state qp_state, uint32_t qkey,
+                      uint32_t rq_psn, uint32_t sq_psn);
+void rdma_rm_dealloc_qp(RdmaDeviceResources *dev_res, uint32_t qp_handle);
+
+int rdma_rm_alloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t *cqe_ctx_id,
+                          void *ctx);
+void *rdma_rm_get_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id);
+void rdma_rm_dealloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id);
+
+#endif
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
new file mode 100644
index 0000000000..e327b7177a
--- /dev/null
+++ b/hw/rdma/rdma_rm_defs.h
@@ -0,0 +1,106 @@
+/*
+ * RDMA device: Definitions of Resource Manager structures
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef RDMA_RM_DEFS_H
+#define RDMA_RM_DEFS_H
+
+#include "rdma_backend_defs.h"
+
+#define MAX_PORTS             1
+#define MAX_PORT_GIDS         1
+#define MAX_PORT_PKEYS        1
+#define MAX_PKEYS             1
+#define MAX_GIDS              2048
+#define MAX_UCS               512
+#define MAX_MR_SIZE           (1UL << 27)
+#define MAX_QP                1024
+#define MAX_SGE               4
+#define MAX_CQ                2048
+#define MAX_MR                1024
+#define MAX_PD                1024
+#define MAX_QP_RD_ATOM        16
+#define MAX_QP_INIT_RD_ATOM   16
+#define MAX_AH                64
+
+#define MAX_RMRESTBL_NAME_SZ 16
+typedef struct RdmaRmResTbl {
+    char name[MAX_RMRESTBL_NAME_SZ];
+    unsigned long *bitmap;
+    size_t tbl_sz;
+    size_t res_sz;
+    void *tbl;
+    QemuMutex lock;
+} RdmaRmResTbl;
+
+typedef struct RdmaRmPD {
+    uint32_t ctx_handle;
+    RdmaBackendPD backend_pd;
+} RdmaRmPD;
+
+typedef struct RdmaRmCQ {
+    void *opaque;
+    bool notify;
+    RdmaBackendCQ backend_cq;
+} RdmaRmCQ;
+
+typedef struct RdmaRmUserMR {
+    uint64_t host_virt;
+    uint64_t guest_start;
+    size_t length;
+} RdmaRmUserMR;
+
+/* MR (DMA region) */
+typedef struct RdmaRmMR {
+    uint32_t pd_handle;
+    uint32_t lkey;
+    uint32_t rkey;
+    RdmaBackendMR backend_mr;
+    RdmaRmUserMR user_mr;
+    uint64_t addr;
+    size_t length;
+} RdmaRmMR;
+
+typedef struct RdmaRmUC {
+    uint64_t uc_handle;
+} RdmaRmUC;
+
+typedef struct RdmaRmQP {
+    uint32_t qp_type;
+    enum ibv_qp_state qp_state;
+    uint32_t qpn;
+    void *opaque;
+    uint32_t send_cq_handle;
+    uint32_t recv_cq_handle;
+    RdmaBackendQP backend_qp;
+} RdmaRmQP;
+
+typedef struct RdmaRmPort {
+    enum ibv_port_state state;
+    union ibv_gid gid_tbl[MAX_PORT_GIDS];
+    int *pkey_tbl; /* TODO: Not yet supported */
+} RdmaRmPort;
+
+typedef struct RdmaDeviceResources {
+    RdmaRmPort ports[MAX_PORTS];
+    RdmaRmResTbl pd_tbl;
+    RdmaRmResTbl mr_tbl;
+    RdmaRmResTbl uc_tbl;
+    RdmaRmResTbl qp_tbl;
+    RdmaRmResTbl cq_tbl;
+    RdmaRmResTbl cqe_ctx_tbl;
+    GHashTable *qp_hash; /* Keeps mapping between real and emulated */
+} RdmaDeviceResources;
+
+#endif
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
new file mode 100644
index 0000000000..5ae9d59126
--- /dev/null
+++ b/hw/rdma/rdma_utils.h
@@ -0,0 +1,36 @@
+/*
+ * RDMA device: Debug utilities
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef RDMA_UTILS_H
+#define RDMA_UTILS_H
+
+#define pr_info(fmt, ...) \
+    fprintf(stdout, "%s: %-20s (%3d): " fmt, "pvrdma",  __func__, __LINE__,\
+           ## __VA_ARGS__)
+
+#define pr_err(fmt, ...) \
+    fprintf(stderr, "%s: Error at %-20s (%3d): " fmt, "pvrdma", __func__, \
+        __LINE__, ## __VA_ARGS__)
+
+#ifdef PVRDMA_DEBUG
+#define pr_dbg(fmt, ...) \
+    fprintf(stdout, "%s: %-20s (%3d): " fmt, "pvrdma", __func__, __LINE__,\
+           ## __VA_ARGS__)
+#else
+#define pr_dbg(fmt, ...)
+#endif
+
+#endif
diff --git a/hw/rdma/trace-events b/hw/rdma/trace-events
new file mode 100644
index 0000000000..421986adbe
--- /dev/null
+++ b/hw/rdma/trace-events
@@ -0,0 +1,5 @@
+# See docs/tracing.txt for syntax documentation.
+
+#hw/rdma/rdma_backend.c
+create_ah_cache_hit(uint64_t subnet, uint64_t net_id) "subnet = 0x%lx net_id = 0x%lx"
+create_ah_cache_miss(uint64_t subnet, uint64_t net_id) "subnet = 0x%lx net_id = 0x%lx"
diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
new file mode 100644
index 0000000000..8d667e5e42
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma.h
@@ -0,0 +1,123 @@
+/*
+ * QEMU VMWARE paravirtual RDMA device definitions
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef PVRDMA_PVRDMA_H
+#define PVRDMA_PVRDMA_H
+
+#include <rdma/vmw_pvrdma-abi.h>
+#include <hw/pci/pci.h>
+#include <hw/pci/msix.h>
+
+#include "../rdma_backend_defs.h"
+#include "../rdma_rm_defs.h"
+
+#include "pvrdma_dev_api.h"
+#include "pvrdma_ring.h"
+#include "pvrdma_dev_ring.h"
+
+/* BARs */
+#define RDMA_MSIX_BAR_IDX    0
+#define RDMA_REG_BAR_IDX     1
+#define RDMA_UAR_BAR_IDX     2
+#define RDMA_BAR0_MSIX_SIZE  (16 * 1024)
+#define RDMA_BAR1_REGS_SIZE  256
+#define RDMA_BAR2_UAR_SIZE   (0x1000 * MAX_UCS) /* each uc gets page */
+
+/* MSIX */
+#define RDMA_MAX_INTRS       3
+#define RDMA_MSIX_TABLE      0x0000
+#define RDMA_MSIX_PBA        0x2000
+
+/* Interrupts Vectors */
+#define INTR_VEC_CMD_RING            0
+#define INTR_VEC_CMD_ASYNC_EVENTS    1
+#define INTR_VEC_CMD_COMPLETION_Q    2
+
+/* HW attributes */
+#define PVRDMA_HW_NAME       "pvrdma"
+#define PVRDMA_HW_VERSION    17
+#define PVRDMA_FW_VERSION    14
+
+typedef struct DSRInfo {
+    dma_addr_t dma;
+    struct pvrdma_device_shared_region *dsr;
+
+    union pvrdma_cmd_req *req;
+    union pvrdma_cmd_resp *rsp;
+
+    struct pvrdma_ring *async_ring_state;
+    PvrdmaRing async;
+
+    struct pvrdma_ring *cq_ring_state;
+    PvrdmaRing cq;
+} DSRInfo;
+
+typedef struct PVRDMADev {
+    PCIDevice parent_obj;
+    MemoryRegion msix;
+    MemoryRegion regs;
+    __u32 regs_data[RDMA_BAR1_REGS_SIZE];
+    MemoryRegion uar;
+    __u32 uar_data[RDMA_BAR2_UAR_SIZE];
+    DSRInfo dsr_info;
+    int interrupt_mask;
+    struct ibv_device_attr dev_attr;
+    u64 node_guid;
+    char *backend_device_name;
+    u8 backend_gid_idx;
+    u8 backend_port_num;
+    RdmaBackendDev backend_dev;
+    RdmaDeviceResources rdma_dev_res;
+} PVRDMADev;
+#define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
+
+static inline int get_reg_val(PVRDMADev *dev, hwaddr addr, __u32 *val)
+{
+    int idx = addr >> 2;
+
+    if (idx > RDMA_BAR1_REGS_SIZE) {
+        return -EINVAL;
+    }
+
+    *val = dev->regs_data[idx];
+
+    return 0;
+}
+
+static inline int set_reg_val(PVRDMADev *dev, hwaddr addr, __u32 val)
+{
+    int idx = addr >> 2;
+
+    if (idx > RDMA_BAR1_REGS_SIZE) {
+        return -EINVAL;
+    }
+
+    dev->regs_data[idx] = val;
+
+    return 0;
+}
+
+static inline void post_interrupt(PVRDMADev *dev, unsigned vector)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+
+    if (likely(!dev->interrupt_mask)) {
+        msix_notify(pci_dev, vector);
+    }
+}
+
+int execute_command(PVRDMADev *dev);
+
+#endif
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
new file mode 100644
index 0000000000..a6268930de
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -0,0 +1,585 @@
+#include <qemu/osdep.h>
+#include <cpu.h>
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_ids.h"
+
+#include "../rdma_backend.h"
+#include "../rdma_rm.h"
+#include "../rdma_utils.h"
+
+#include "pvrdma_utils.h"
+#include "pvrdma.h"
+
+static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                      union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_query_port *cmd = &req->query_port;
+    struct pvrdma_cmd_query_port_resp *resp = &rsp->query_port_resp;
+    struct pvrdma_port_attr attrs = {0};
+
+    pr_dbg("port=%d\n", cmd->port_num);
+
+    if (rdma_backend_query_port(&dev->backend_dev,
+                                (struct ibv_port_attr *)&attrs)) {
+        return -ENOMEM;
+    }
+
+    memset(resp, 0, sizeof(*resp));
+    resp->hdr.response = cmd->hdr.response;
+    resp->hdr.ack = PVRDMA_CMD_QUERY_PORT_RESP;
+    resp->hdr.err = 0;
+
+    resp->attrs.state = attrs.state;
+    resp->attrs.max_mtu = attrs.max_mtu;
+    resp->attrs.active_mtu = attrs.active_mtu;
+    resp->attrs.phys_state = attrs.phys_state;
+    resp->attrs.gid_tbl_len = MIN(MAX_PORT_GIDS, attrs.gid_tbl_len);
+    resp->attrs.port_cap_flags = 0;
+    resp->attrs.max_msg_sz = 1024;
+    resp->attrs.bad_pkey_cntr = 0;
+    resp->attrs.qkey_viol_cntr = 0;
+    resp->attrs.pkey_tbl_len = MIN(MAX_PORT_PKEYS, attrs.pkey_tbl_len);
+    resp->attrs.lid = 0;
+    resp->attrs.sm_lid = 0;
+    resp->attrs.lmc = 0;
+    resp->attrs.max_vl_num = 0;
+    resp->attrs.sm_sl = 0;
+    resp->attrs.subnet_timeout = 0;
+    resp->attrs.init_type_reply = 0;
+    resp->attrs.active_width = 1;
+    resp->attrs.active_speed = 1;
+
+    return 0;
+}
+
+static int query_pkey(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                      union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_query_pkey *cmd = &req->query_pkey;
+    struct pvrdma_cmd_query_pkey_resp *resp = &rsp->query_pkey_resp;
+
+    pr_dbg("port=%d\n", cmd->port_num);
+    pr_dbg("index=%d\n", cmd->index);
+
+    memset(resp, 0, sizeof(*resp));
+    resp->hdr.response = cmd->hdr.response;
+    resp->hdr.ack = PVRDMA_CMD_QUERY_PKEY_RESP;
+    resp->hdr.err = 0;
+
+    resp->pkey = 0x7FFF;
+    pr_dbg("pkey=0x%x\n", resp->pkey);
+
+    return 0;
+}
+
+static int create_pd(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                     union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_create_pd *cmd = &req->create_pd;
+    struct pvrdma_cmd_create_pd_resp *resp = &rsp->create_pd_resp;
+
+    pr_dbg("context=0x%x\n", cmd->ctx_handle ? cmd->ctx_handle : 0);
+
+    memset(resp, 0, sizeof(*resp));
+    resp->hdr.response = cmd->hdr.response;
+    resp->hdr.ack = PVRDMA_CMD_CREATE_PD_RESP;
+    resp->hdr.err = rdma_rm_alloc_pd(&dev->rdma_dev_res, &dev->backend_dev,
+                                     &resp->pd_handle, cmd->ctx_handle);
+
+    pr_dbg("ret=%d\n", resp->hdr.err);
+    return resp->hdr.err;
+}
+
+static int destroy_pd(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                      union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_destroy_pd *cmd = &req->destroy_pd;
+
+    pr_dbg("pd_handle=%d\n", cmd->pd_handle);
+
+    rdma_rm_dealloc_pd(&dev->rdma_dev_res, cmd->pd_handle);
+
+    return 0;
+}
+
+static int create_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                     union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_create_mr *cmd = &req->create_mr;
+    struct pvrdma_cmd_create_mr_resp *resp = &rsp->create_mr_resp;
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    void *host_virt;
+
+    memset(resp, 0, sizeof(*resp));
+    resp->hdr.response = cmd->hdr.response;
+    resp->hdr.ack = PVRDMA_CMD_CREATE_MR_RESP;
+
+    pr_dbg("pd_handle=%d\n", cmd->pd_handle);
+    pr_dbg("access_flags=0x%x\n", cmd->access_flags);
+    pr_dbg("flags=0x%x\n", cmd->flags);
+
+    if (!(cmd->flags & PVRDMA_MR_FLAG_DMA)) {
+        host_virt = pvrdma_map_to_pdir(pci_dev, cmd->pdir_dma, cmd->nchunks,
+                                       cmd->length);
+        if (!host_virt) {
+            pr_dbg("Fail to map to pdir\n");
+            resp->hdr.err = -EINVAL;
+            goto out;
+        }
+    }
+
+    resp->hdr.err = rdma_rm_alloc_mr(&dev->rdma_dev_res, cmd->pd_handle,
+                                     cmd->start, cmd->length, host_virt,
+                                     cmd->access_flags, &resp->mr_handle,
+                                     &resp->lkey, &resp->rkey);
+    if (!resp->hdr.err) {
+        munmap(host_virt, cmd->length);
+    }
+
+out:
+    pr_dbg("ret=%d\n", resp->hdr.err);
+    return resp->hdr.err;
+}
+
+static int destroy_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                      union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_destroy_mr *cmd = &req->destroy_mr;
+
+    pr_dbg("mr_handle=%d\n", cmd->mr_handle);
+
+    rdma_rm_dealloc_mr(&dev->rdma_dev_res, cmd->mr_handle);
+
+    return 0;
+}
+
+static int create_cq_ring(PCIDevice *pci_dev , PvrdmaRing **ring, u64 pdir_dma,
+                          u32 nchunks, u32 cqe)
+{
+    u64 *dir, *tbl;
+    PvrdmaRing *r;
+    int rc = -EINVAL;
+    char ring_name[MAX_RING_NAME_SZ];
+
+    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
+    dir = pvrdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
+    if (!dir) {
+        pr_dbg("Fail to map to CQ page directory\n");
+        goto out;
+    }
+
+    tbl = pvrdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
+    if (!tbl) {
+        pr_dbg("Fail to map to CQ page table\n");
+        goto out;
+    }
+
+    r = malloc(sizeof(*r));
+    if (!r) {
+        pr_dbg("Fail allocate memory for CQ ring\n");
+        rc = -ENOMEM;
+        goto out;
+    }
+    *ring = r;
+
+    r->ring_state = (struct pvrdma_ring *)
+        pvrdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
+
+    if (!r->ring_state) {
+        pr_dbg("Fail to map to CQ ring state\n");
+        goto out_free_ring;
+    }
+
+    sprintf(ring_name, "cq_ring_%lx", pdir_dma);
+    rc = pvrdma_ring_init(r, ring_name, pci_dev, &r->ring_state[1],
+                          cqe, sizeof(struct pvrdma_cqe),
+                          /* first page is ring state */
+                          (dma_addr_t *)&tbl[1], nchunks - 1);
+    if (rc) {
+        goto out_unmap_ring_state;
+    }
+
+    goto out;
+
+out_unmap_ring_state:
+    /* ring_state was in slot 1, not 0 so need to jump back */
+    pvrdma_pci_dma_unmap(pci_dev, --r->ring_state, TARGET_PAGE_SIZE);
+
+out_free_ring:
+    free(r);
+    r = NULL;
+
+out:
+    pvrdma_pci_dma_unmap(pci_dev, tbl, TARGET_PAGE_SIZE);
+    pvrdma_pci_dma_unmap(pci_dev, dir, TARGET_PAGE_SIZE);
+
+    return rc;
+}
+
+static int create_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                     union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_create_cq *cmd = &req->create_cq;
+    struct pvrdma_cmd_create_cq_resp *resp = &rsp->create_cq_resp;
+    PvrdmaRing *ring;
+
+    memset(resp, 0, sizeof(*resp));
+    resp->hdr.response = cmd->hdr.response;
+    resp->hdr.ack = PVRDMA_CMD_CREATE_CQ_RESP;
+
+    resp->cqe = cmd->cqe;
+
+    resp->hdr.err = create_cq_ring(PCI_DEVICE(dev), &ring, cmd->pdir_dma,
+                                   cmd->nchunks, cmd->cqe);
+    if (resp->hdr.err) {
+        goto out;
+    }
+
+    pr_dbg("ring=%p\n", ring);
+
+    resp->hdr.err = rdma_rm_alloc_cq(&dev->rdma_dev_res, &dev->backend_dev,
+                                     cmd->cqe, &resp->cq_handle, ring);
+    resp->cqe = cmd->cqe;
+
+out:
+    pr_dbg("ret=%d\n", resp->hdr.err);
+    return resp->hdr.err;
+}
+
+static int destroy_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                      union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_destroy_cq *cmd = &req->destroy_cq;
+    RdmaRmCQ *cq;
+    PvrdmaRing *ring;
+
+    pr_dbg("cq_handle=%d\n", cmd->cq_handle);
+
+    cq = rdma_rm_get_cq(&dev->rdma_dev_res, cmd->cq_handle);
+    if (!cq) {
+        pr_dbg("Invalid CQ handle\n");
+        return -EINVAL;
+    }
+
+    ring = (PvrdmaRing *)cq->opaque;
+    pvrdma_ring_free(ring);
+    /* ring_state was in slot 1, not 0 so need to jump back */
+    pvrdma_pci_dma_unmap(PCI_DEVICE(dev), --ring->ring_state, TARGET_PAGE_SIZE);
+    free(ring);
+
+    rdma_rm_dealloc_cq(&dev->rdma_dev_res, cmd->cq_handle);
+
+    return 0;
+}
+
+static int create_qp_rings(PCIDevice *pci_dev, u64 pdir_dma, PvrdmaRing **rings,
+                           u32 scqe, u32 smax_sge, u32 spages, u32 rcqe,
+                           u32 rmax_sge, u32 rpages)
+{
+    u64 *dir, *tbl;
+    PvrdmaRing *sr, *rr;
+    int rc = -EINVAL;;
+    char ring_name[MAX_RING_NAME_SZ];
+    size_t wqe_sz;
+
+    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
+    dir = pvrdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
+    if (!dir) {
+        pr_dbg("Fail to map to CQ page directory\n");
+        goto out;
+    }
+
+    tbl = pvrdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
+    if (!tbl) {
+        pr_dbg("Fail to map to CQ page table\n");
+        goto out;
+    }
+
+    sr = malloc(2 * sizeof(*rr));
+    if (!sr) {
+        pr_dbg("Fail allocate memory for QP send and recv rings\n");
+        rc = -ENOMEM;
+        goto out;
+    }
+    rr = &sr[1];
+    pr_dbg("sring=%p\n", sr);
+    pr_dbg("rring=%p\n", rr);
+
+    *rings = sr;
+
+    pr_dbg("scqe=%d\n", scqe);
+    pr_dbg("smax_sge=%d\n", smax_sge);
+    pr_dbg("spages=%d\n", spages);
+    pr_dbg("rcqe=%d\n", rcqe);
+    pr_dbg("rmax_sge=%d\n", rmax_sge);
+    pr_dbg("rpages=%d\n", rpages);
+
+    /* Create send ring */
+    sr->ring_state = (struct pvrdma_ring *)
+        pvrdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
+    if (!sr->ring_state) {
+        pr_dbg("Fail to map to CQ ring state\n");
+        goto out_free_sr_mem;
+    }
+
+    wqe_sz = pow2roundup32(sizeof(struct pvrdma_sq_wqe_hdr) +
+                           sizeof(struct pvrdma_sge) * smax_sge - 1);
+
+    sprintf(ring_name, "qp_sring_%lx", pdir_dma);
+    rc = pvrdma_ring_init(sr, ring_name, pci_dev, sr->ring_state,
+                          scqe, wqe_sz, (dma_addr_t *)&tbl[1], spages);
+    if (rc) {
+        goto out_unmap_ring_state;
+    }
+
+    /* Create recv ring */
+    rr->ring_state = &sr->ring_state[1];
+    wqe_sz = pow2roundup32(sizeof(struct pvrdma_rq_wqe_hdr) +
+                           sizeof(struct pvrdma_sge) * rmax_sge - 1);
+    sprintf(ring_name, "qp_rring_%lx", pdir_dma);
+    rc = pvrdma_ring_init(rr, ring_name, pci_dev, rr->ring_state,
+                          rcqe, wqe_sz, (dma_addr_t *)&tbl[1 + spages], rpages);
+    if (rc) {
+        goto out_free_sr;
+    }
+
+    goto out;
+
+out_free_sr:
+    pvrdma_ring_free(sr);
+
+out_unmap_ring_state:
+    pvrdma_pci_dma_unmap(pci_dev, sr->ring_state, TARGET_PAGE_SIZE);
+
+out_free_sr_mem:
+    free(sr);
+    sr = NULL;
+
+out:
+    pvrdma_pci_dma_unmap(pci_dev, tbl, TARGET_PAGE_SIZE);
+    pvrdma_pci_dma_unmap(pci_dev, dir, TARGET_PAGE_SIZE);
+
+    return rc;
+}
+
+static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                     union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_create_qp *cmd = &req->create_qp;
+    struct pvrdma_cmd_create_qp_resp *resp = &rsp->create_qp_resp;
+    PvrdmaRing *rings;
+
+    memset(resp, 0, sizeof(*resp));
+    resp->hdr.response = cmd->hdr.response;
+    resp->hdr.ack = PVRDMA_CMD_CREATE_QP_RESP;
+
+    pr_dbg("total_chunks=%d\n", cmd->total_chunks);
+    pr_dbg("send_chunks=%d\n", cmd->send_chunks);
+
+    resp->hdr.err = create_qp_rings(PCI_DEVICE(dev), cmd->pdir_dma, &rings,
+                                    cmd->max_send_wr, cmd->max_send_sge,
+                                    cmd->send_chunks, cmd->max_recv_wr,
+                                    cmd->max_recv_sge, cmd->total_chunks -
+                                    cmd->send_chunks - 1);
+    if (resp->hdr.err) {
+        goto out;
+    }
+
+    pr_dbg("rings=%p\n", rings);
+
+    resp->hdr.err = rdma_rm_alloc_qp(&dev->rdma_dev_res, cmd->pd_handle,
+                                     cmd->qp_type, cmd->max_send_wr,
+                                     cmd->max_send_sge, cmd->send_cq_handle,
+                                     cmd->max_recv_wr, cmd->max_recv_sge,
+                                     cmd->recv_cq_handle, rings, &resp->qpn);
+
+    resp->max_send_wr = cmd->max_send_wr;
+    resp->max_recv_wr = cmd->max_recv_wr;
+    resp->max_send_sge = cmd->max_send_sge;
+    resp->max_recv_sge = cmd->max_recv_sge;
+    resp->max_inline_data = cmd->max_inline_data;
+
+out:
+    pr_dbg("ret=%d\n", resp->hdr.err);
+    return resp->hdr.err;
+}
+
+static int modify_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                     union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_modify_qp *cmd = &req->modify_qp;
+
+    pr_dbg("qp_handle=%d\n", cmd->qp_handle);
+
+    memset(rsp, 0, sizeof(*rsp));
+    rsp->hdr.response = cmd->hdr.response;
+    rsp->hdr.ack = PVRDMA_CMD_MODIFY_QP_RESP;
+
+    rsp->hdr.err = rdma_rm_modify_qp(&dev->rdma_dev_res, &dev->backend_dev,
+                                 cmd->qp_handle, cmd->attr_mask,
+                                 (union ibv_gid *)&cmd->attrs.ah_attr.grh.dgid,
+                                 cmd->attrs.dest_qp_num, cmd->attrs.qp_state,
+                                 cmd->attrs.qkey, cmd->attrs.rq_psn,
+                                 cmd->attrs.sq_psn);
+
+    pr_dbg("ret=%d\n", rsp->hdr.err);
+    return rsp->hdr.err;
+}
+
+static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                      union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_destroy_qp *cmd = &req->destroy_qp;
+    RdmaRmQP *qp;
+    PvrdmaRing *ring;
+
+    qp = rdma_rm_get_qp(&dev->rdma_dev_res, cmd->qp_handle);
+    if (!qp) {
+        pr_dbg("Invalid QP handle\n");
+        return -EINVAL;
+    }
+
+    rdma_rm_dealloc_qp(&dev->rdma_dev_res, cmd->qp_handle);
+
+    ring = (PvrdmaRing *)qp->opaque;
+    pr_dbg("sring=%p\n", &ring[0]);
+    pvrdma_ring_free(&ring[0]);
+    pr_dbg("rring=%p\n", &ring[1]);
+    pvrdma_ring_free(&ring[1]);
+
+    pvrdma_pci_dma_unmap(PCI_DEVICE(dev), ring->ring_state, TARGET_PAGE_SIZE);
+    free(ring);
+
+    return 0;
+}
+
+static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                       union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_create_bind *cmd = &req->create_bind;
+#ifdef PVRDMA_DEBUG
+    __be64 *subnet = (__be64 *)&cmd->new_gid[0];
+    __be64 *if_id = (__be64 *)&cmd->new_gid[8];
+#endif
+
+    pr_dbg("index=%d\n", cmd->index);
+
+    if (cmd->index > MAX_PORT_GIDS) {
+        return -EINVAL;
+    }
+
+    pr_dbg("gid[%d]=0x%llx,0x%llx\n", cmd->index,
+           (long long unsigned int)be64_to_cpu(*subnet),
+           (long long unsigned int)be64_to_cpu(*if_id));
+
+    /* Driver forces to one port only */
+    memcpy(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw, &cmd->new_gid,
+           sizeof(cmd->new_gid));
+
+    /* TODO: Since drivers stores node_guid at load_dsr phase then this
+     * assignment is not relevant, i need to figure out a way how to
+     * retrieve MAC of our netdev */
+    dev->node_guid = dev->rdma_dev_res.ports[0].gid_tbl[0].global.interface_id;
+    pr_dbg("dev->node_guid=0x%llx\n",
+           (long long unsigned int)be64_to_cpu(dev->node_guid));
+
+    return 0;
+}
+
+static int destroy_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                        union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_destroy_bind *cmd = &req->destroy_bind;
+
+    pr_dbg("clear index %d\n", cmd->index);
+
+    memset(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw, 0,
+           sizeof(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw));
+
+    return 0;
+}
+
+static int create_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                     union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_create_uc *cmd = &req->create_uc;
+    struct pvrdma_cmd_create_uc_resp *resp = &rsp->create_uc_resp;
+
+    pr_dbg("pfn=%d\n", cmd->pfn);
+
+    memset(resp, 0, sizeof(*resp));
+    resp->hdr.response = cmd->hdr.response;
+    resp->hdr.ack = PVRDMA_CMD_CREATE_UC_RESP;
+    resp->hdr.err = rdma_rm_alloc_uc(&dev->rdma_dev_res, cmd->pfn,
+                                     &resp->ctx_handle);
+
+    pr_dbg("ret=%d\n", resp->hdr.err);
+
+    return 0;
+}
+
+static int destroy_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                      union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_destroy_uc *cmd = &req->destroy_uc;
+
+    pr_dbg("ctx_handle=%d\n", cmd->ctx_handle);
+
+    rdma_rm_dealloc_uc(&dev->rdma_dev_res, cmd->ctx_handle);
+
+    return 0;
+}
+struct cmd_handler {
+    __u32 cmd;
+    int (*exec)(PVRDMADev *dev, union pvrdma_cmd_req *req,
+            union pvrdma_cmd_resp *rsp);
+};
+
+static struct cmd_handler cmd_handlers[] = {
+    {PVRDMA_CMD_QUERY_PORT, query_port},
+    {PVRDMA_CMD_QUERY_PKEY, query_pkey},
+    {PVRDMA_CMD_CREATE_PD, create_pd},
+    {PVRDMA_CMD_DESTROY_PD, destroy_pd},
+    {PVRDMA_CMD_CREATE_MR, create_mr},
+    {PVRDMA_CMD_DESTROY_MR, destroy_mr},
+    {PVRDMA_CMD_CREATE_CQ, create_cq},
+    {PVRDMA_CMD_RESIZE_CQ, NULL},
+    {PVRDMA_CMD_DESTROY_CQ, destroy_cq},
+    {PVRDMA_CMD_CREATE_QP, create_qp},
+    {PVRDMA_CMD_MODIFY_QP, modify_qp},
+    {PVRDMA_CMD_QUERY_QP, NULL},
+    {PVRDMA_CMD_DESTROY_QP, destroy_qp},
+    {PVRDMA_CMD_CREATE_UC, create_uc},
+    {PVRDMA_CMD_DESTROY_UC, destroy_uc},
+    {PVRDMA_CMD_CREATE_BIND, create_bind},
+    {PVRDMA_CMD_DESTROY_BIND, destroy_bind},
+};
+
+int execute_command(PVRDMADev *dev)
+{
+    int err = 0xFFFF;
+    DSRInfo *dsr_info;
+
+    dsr_info = &dev->dsr_info;
+
+    pr_dbg("cmd=%d\n", dsr_info->req->hdr.cmd);
+    if (dsr_info->req->hdr.cmd >= sizeof(cmd_handlers) /
+                      sizeof(struct cmd_handler)) {
+        pr_dbg("Unsupported command\n");
+        goto out;
+    }
+
+    if (!cmd_handlers[dsr_info->req->hdr.cmd].exec) {
+        pr_dbg("Unsupported command (not implemented yet)\n");
+        goto out;
+    }
+
+    err = cmd_handlers[dsr_info->req->hdr.cmd].exec(dev, dsr_info->req,
+                            dsr_info->rsp);
+out:
+    set_reg_val(dev, PVRDMA_REG_ERR, err);
+    post_interrupt(dev, INTR_VEC_CMD_RING);
+
+    return (err == 0) ? 0 : -EINVAL;
+}
diff --git a/hw/rdma/vmw/pvrdma_dev_api.h b/hw/rdma/vmw/pvrdma_dev_api.h
new file mode 100644
index 0000000000..3ba135734e
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma_dev_api.h
@@ -0,0 +1,580 @@
+/*
+ * Copyright (c) 2012-2016 VMware, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of EITHER the GNU General Public License
+ * version 2 as published by the Free Software Foundation or the BSD
+ * 2-Clause License. This program is distributed in the hope that it
+ * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
+ * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
+ * See the GNU General Public License version 2 for more details at
+ * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program available in the file COPYING in the main
+ * directory of this source tree.
+ *
+ * The BSD 2-Clause License
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+ * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
+ * OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef PVRDMA_DEV_API_H
+#define PVRDMA_DEV_API_H
+
+#include <linux/types.h>
+
+#include "pvrdma_ib_verbs.h"
+
+#define PVRDMA_VERSION            17
+#define PVRDMA_BOARD_ID            1
+#define PVRDMA_REV_ID            1
+
+/*
+ * Masks and accessors for page directory, which is a two-level lookup:
+ * page directory -> page table -> page. Only one directory for now, but we
+ * could expand that easily. 9 bits for tables, 9 bits for pages, gives one
+ * gigabyte for memory regions and so forth.
+ */
+
+#define PVRDMA_PDIR_SHIFT        18
+#define PVRDMA_PTABLE_SHIFT        9
+#define PVRDMA_PAGE_DIR_DIR(x)        (((x) >> PVRDMA_PDIR_SHIFT) & 0x1)
+#define PVRDMA_PAGE_DIR_TABLE(x)    (((x) >> PVRDMA_PTABLE_SHIFT) & 0x1ff)
+#define PVRDMA_PAGE_DIR_PAGE(x)        ((x) & 0x1ff)
+#define PVRDMA_PAGE_DIR_MAX_PAGES    (1 * 512 * 512)
+#define PVRDMA_MAX_FAST_REG_PAGES    128
+
+/*
+ * Max MSI-X vectors.
+ */
+
+#define PVRDMA_MAX_INTERRUPTS    3
+
+/* Register offsets within PCI resource on BAR1. */
+#define PVRDMA_REG_VERSION    0x00    /* R: Version of device. */
+#define PVRDMA_REG_DSRLOW    0x04    /* W: Device shared region low PA. */
+#define PVRDMA_REG_DSRHIGH    0x08    /* W: Device shared region high PA. */
+#define PVRDMA_REG_CTL        0x0c    /* W: PVRDMA_DEVICE_CTL */
+#define PVRDMA_REG_REQUEST    0x10    /* W: Indicate device request. */
+#define PVRDMA_REG_ERR        0x14    /* R: Device error. */
+#define PVRDMA_REG_ICR        0x18    /* R: Interrupt cause. */
+#define PVRDMA_REG_IMR        0x1c    /* R/W: Interrupt mask. */
+#define PVRDMA_REG_MACL        0x20    /* R/W: MAC address low. */
+#define PVRDMA_REG_MACH        0x24    /* R/W: MAC address high. */
+
+/* Object flags. */
+#define PVRDMA_CQ_FLAG_ARMED_SOL    BIT(0)    /* Armed for solicited-only. */
+#define PVRDMA_CQ_FLAG_ARMED        BIT(1)    /* Armed. */
+#define PVRDMA_MR_FLAG_DMA        BIT(0)    /* DMA region. */
+#define PVRDMA_MR_FLAG_FRMR        BIT(1)    /* Fast reg memory region. */
+
+/*
+ * Atomic operation capability (masked versions are extended atomic
+ * operations.
+ */
+
+#define PVRDMA_ATOMIC_OP_COMP_SWAP    BIT(0)    /* Compare and swap. */
+#define PVRDMA_ATOMIC_OP_FETCH_ADD    BIT(1)    /* Fetch and add. */
+#define PVRDMA_ATOMIC_OP_MASK_COMP_SWAP    BIT(2) /* Masked compare and swap. */
+#define PVRDMA_ATOMIC_OP_MASK_FETCH_ADD    BIT(3) /* Masked fetch and add. */
+
+/*
+ * Base Memory Management Extension flags to support Fast Reg Memory Regions
+ * and Fast Reg Work Requests. Each flag represents a verb operation and we
+ * must support all of them to qualify for the BMME device cap.
+ */
+
+#define PVRDMA_BMME_FLAG_LOCAL_INV    BIT(0)    /* Local Invalidate. */
+#define PVRDMA_BMME_FLAG_REMOTE_INV    BIT(1)    /* Remote Invalidate. */
+#define PVRDMA_BMME_FLAG_FAST_REG_WR    BIT(2)    /* Fast Reg Work Request. */
+
+/*
+ * GID types. The interpretation of the gid_types bit field in the device
+ * capabilities will depend on the device mode. For now, the device only
+ * supports RoCE as mode, so only the different GID types for RoCE are
+ * defined.
+ */
+
+#define PVRDMA_GID_TYPE_FLAG_ROCE_V1    BIT(0)
+#define PVRDMA_GID_TYPE_FLAG_ROCE_V2    BIT(1)
+
+enum pvrdma_pci_resource {
+    PVRDMA_PCI_RESOURCE_MSIX,    /* BAR0: MSI-X, MMIO. */
+    PVRDMA_PCI_RESOURCE_REG,    /* BAR1: Registers, MMIO. */
+    PVRDMA_PCI_RESOURCE_UAR,    /* BAR2: UAR pages, MMIO, 64-bit. */
+    PVRDMA_PCI_RESOURCE_LAST,    /* Last. */
+};
+
+enum pvrdma_device_ctl {
+    PVRDMA_DEVICE_CTL_ACTIVATE,    /* Activate device. */
+    PVRDMA_DEVICE_CTL_UNQUIESCE,    /* Unquiesce device. */
+    PVRDMA_DEVICE_CTL_RESET,    /* Reset device. */
+};
+
+enum pvrdma_intr_vector {
+    PVRDMA_INTR_VECTOR_RESPONSE,    /* Command response. */
+    PVRDMA_INTR_VECTOR_ASYNC,    /* Async events. */
+    PVRDMA_INTR_VECTOR_CQ,        /* CQ notification. */
+    /* Additional CQ notification vectors. */
+};
+
+enum pvrdma_intr_cause {
+    PVRDMA_INTR_CAUSE_RESPONSE    = (1 << PVRDMA_INTR_VECTOR_RESPONSE),
+    PVRDMA_INTR_CAUSE_ASYNC        = (1 << PVRDMA_INTR_VECTOR_ASYNC),
+    PVRDMA_INTR_CAUSE_CQ        = (1 << PVRDMA_INTR_VECTOR_CQ),
+};
+
+enum pvrdma_gos_bits {
+    PVRDMA_GOS_BITS_UNK,        /* Unknown. */
+    PVRDMA_GOS_BITS_32,        /* 32-bit. */
+    PVRDMA_GOS_BITS_64,        /* 64-bit. */
+};
+
+enum pvrdma_gos_type {
+    PVRDMA_GOS_TYPE_UNK,        /* Unknown. */
+    PVRDMA_GOS_TYPE_LINUX,        /* Linux. */
+};
+
+enum pvrdma_device_mode {
+    PVRDMA_DEVICE_MODE_ROCE,    /* RoCE. */
+    PVRDMA_DEVICE_MODE_IWARP,    /* iWarp. */
+    PVRDMA_DEVICE_MODE_IB,        /* InfiniBand. */
+};
+
+struct pvrdma_gos_info {
+    u32 gos_bits:2;            /* W: PVRDMA_GOS_BITS_ */
+    u32 gos_type:4;            /* W: PVRDMA_GOS_TYPE_ */
+    u32 gos_ver:16;            /* W: Guest OS version. */
+    u32 gos_misc:10;        /* W: Other. */
+    u32 pad;            /* Pad to 8-byte alignment. */
+};
+
+struct pvrdma_device_caps {
+    u64 fw_ver;                /* R: Query device. */
+    __be64 node_guid;
+    __be64 sys_image_guid;
+    u64 max_mr_size;
+    u64 page_size_cap;
+    u64 atomic_arg_sizes;            /* EX verbs. */
+    u32 ex_comp_mask;            /* EX verbs. */
+    u32 device_cap_flags2;            /* EX verbs. */
+    u32 max_fa_bit_boundary;        /* EX verbs. */
+    u32 log_max_atomic_inline_arg;        /* EX verbs. */
+    u32 vendor_id;
+    u32 vendor_part_id;
+    u32 hw_ver;
+    u32 max_qp;
+    u32 max_qp_wr;
+    u32 device_cap_flags;
+    u32 max_sge;
+    u32 max_sge_rd;
+    u32 max_cq;
+    u32 max_cqe;
+    u32 max_mr;
+    u32 max_pd;
+    u32 max_qp_rd_atom;
+    u32 max_ee_rd_atom;
+    u32 max_res_rd_atom;
+    u32 max_qp_init_rd_atom;
+    u32 max_ee_init_rd_atom;
+    u32 max_ee;
+    u32 max_rdd;
+    u32 max_mw;
+    u32 max_raw_ipv6_qp;
+    u32 max_raw_ethy_qp;
+    u32 max_mcast_grp;
+    u32 max_mcast_qp_attach;
+    u32 max_total_mcast_qp_attach;
+    u32 max_ah;
+    u32 max_fmr;
+    u32 max_map_per_fmr;
+    u32 max_srq;
+    u32 max_srq_wr;
+    u32 max_srq_sge;
+    u32 max_uar;
+    u32 gid_tbl_len;
+    u16 max_pkeys;
+    u8  local_ca_ack_delay;
+    u8  phys_port_cnt;
+    u8  mode;                /* PVRDMA_DEVICE_MODE_ */
+    u8  atomic_ops;                /* PVRDMA_ATOMIC_OP_* bits */
+    u8  bmme_flags;                /* FRWR Mem Mgmt Extensions */
+    u8  gid_types;                /* PVRDMA_GID_TYPE_FLAG_ */
+    u8  reserved[4];
+};
+
+struct pvrdma_ring_page_info {
+    u32 num_pages;                /* Num pages incl. header. */
+    u32 reserved;                /* Reserved. */
+    u64 pdir_dma;                /* Page directory PA. */
+};
+
+#pragma pack(push, 1)
+
+struct pvrdma_device_shared_region {
+    u32 driver_version;            /* W: Driver version. */
+    u32 pad;                /* Pad to 8-byte align. */
+    struct pvrdma_gos_info gos_info;    /* W: Guest OS information. */
+    u64 cmd_slot_dma;            /* W: Command slot address. */
+    u64 resp_slot_dma;            /* W: Response slot address. */
+    struct pvrdma_ring_page_info async_ring_pages;
+                        /* W: Async ring page info. */
+    struct pvrdma_ring_page_info cq_ring_pages;
+                        /* W: CQ ring page info. */
+    u32 uar_pfn;                /* W: UAR pageframe. */
+    u32 pad2;                /* Pad to 8-byte align. */
+    struct pvrdma_device_caps caps;        /* R: Device capabilities. */
+};
+
+#pragma pack(pop)
+
+/* Event types. Currently a 1:1 mapping with enum ib_event. */
+enum pvrdma_eqe_type {
+    PVRDMA_EVENT_CQ_ERR,
+    PVRDMA_EVENT_QP_FATAL,
+    PVRDMA_EVENT_QP_REQ_ERR,
+    PVRDMA_EVENT_QP_ACCESS_ERR,
+    PVRDMA_EVENT_COMM_EST,
+    PVRDMA_EVENT_SQ_DRAINED,
+    PVRDMA_EVENT_PATH_MIG,
+    PVRDMA_EVENT_PATH_MIG_ERR,
+    PVRDMA_EVENT_DEVICE_FATAL,
+    PVRDMA_EVENT_PORT_ACTIVE,
+    PVRDMA_EVENT_PORT_ERR,
+    PVRDMA_EVENT_LID_CHANGE,
+    PVRDMA_EVENT_PKEY_CHANGE,
+    PVRDMA_EVENT_SM_CHANGE,
+    PVRDMA_EVENT_SRQ_ERR,
+    PVRDMA_EVENT_SRQ_LIMIT_REACHED,
+    PVRDMA_EVENT_QP_LAST_WQE_REACHED,
+    PVRDMA_EVENT_CLIENT_REREGISTER,
+    PVRDMA_EVENT_GID_CHANGE,
+};
+
+/* Event queue element. */
+struct pvrdma_eqe {
+    u32 type;    /* Event type. */
+    u32 info;    /* Handle, other. */
+};
+
+/* CQ notification queue element. */
+struct pvrdma_cqne {
+    u32 info;    /* Handle */
+};
+
+enum {
+    PVRDMA_CMD_FIRST,
+    PVRDMA_CMD_QUERY_PORT = PVRDMA_CMD_FIRST,
+    PVRDMA_CMD_QUERY_PKEY,
+    PVRDMA_CMD_CREATE_PD,
+    PVRDMA_CMD_DESTROY_PD,
+    PVRDMA_CMD_CREATE_MR,
+    PVRDMA_CMD_DESTROY_MR,
+    PVRDMA_CMD_CREATE_CQ,
+    PVRDMA_CMD_RESIZE_CQ,
+    PVRDMA_CMD_DESTROY_CQ,
+    PVRDMA_CMD_CREATE_QP,
+    PVRDMA_CMD_MODIFY_QP,
+    PVRDMA_CMD_QUERY_QP,
+    PVRDMA_CMD_DESTROY_QP,
+    PVRDMA_CMD_CREATE_UC,
+    PVRDMA_CMD_DESTROY_UC,
+    PVRDMA_CMD_CREATE_BIND,
+    PVRDMA_CMD_DESTROY_BIND,
+    PVRDMA_CMD_MAX,
+};
+
+enum {
+    PVRDMA_CMD_FIRST_RESP = (1 << 31),
+    PVRDMA_CMD_QUERY_PORT_RESP = PVRDMA_CMD_FIRST_RESP,
+    PVRDMA_CMD_QUERY_PKEY_RESP,
+    PVRDMA_CMD_CREATE_PD_RESP,
+    PVRDMA_CMD_DESTROY_PD_RESP_NOOP,
+    PVRDMA_CMD_CREATE_MR_RESP,
+    PVRDMA_CMD_DESTROY_MR_RESP_NOOP,
+    PVRDMA_CMD_CREATE_CQ_RESP,
+    PVRDMA_CMD_RESIZE_CQ_RESP,
+    PVRDMA_CMD_DESTROY_CQ_RESP_NOOP,
+    PVRDMA_CMD_CREATE_QP_RESP,
+    PVRDMA_CMD_MODIFY_QP_RESP,
+    PVRDMA_CMD_QUERY_QP_RESP,
+    PVRDMA_CMD_DESTROY_QP_RESP,
+    PVRDMA_CMD_CREATE_UC_RESP,
+    PVRDMA_CMD_DESTROY_UC_RESP_NOOP,
+    PVRDMA_CMD_CREATE_BIND_RESP_NOOP,
+    PVRDMA_CMD_DESTROY_BIND_RESP_NOOP,
+    PVRDMA_CMD_MAX_RESP,
+};
+
+struct pvrdma_cmd_hdr {
+    u64 response;        /* Key for response lookup. */
+    u32 cmd;        /* PVRDMA_CMD_ */
+    u32 reserved;        /* Reserved. */
+};
+
+struct pvrdma_cmd_resp_hdr {
+    u64 response;        /* From cmd hdr. */
+    u32 ack;        /* PVRDMA_CMD_XXX_RESP */
+    u8 err;            /* Error. */
+    u8 reserved[3];        /* Reserved. */
+};
+
+struct pvrdma_cmd_query_port {
+    struct pvrdma_cmd_hdr hdr;
+    u8 port_num;
+    u8 reserved[7];
+};
+
+struct pvrdma_cmd_query_port_resp {
+    struct pvrdma_cmd_resp_hdr hdr;
+    struct pvrdma_port_attr attrs;
+};
+
+struct pvrdma_cmd_query_pkey {
+    struct pvrdma_cmd_hdr hdr;
+    u8 port_num;
+    u8 index;
+    u8 reserved[6];
+};
+
+struct pvrdma_cmd_query_pkey_resp {
+    struct pvrdma_cmd_resp_hdr hdr;
+    u16 pkey;
+    u8 reserved[6];
+};
+
+struct pvrdma_cmd_create_uc {
+    struct pvrdma_cmd_hdr hdr;
+    u32 pfn; /* UAR page frame number */
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_create_uc_resp {
+    struct pvrdma_cmd_resp_hdr hdr;
+    u32 ctx_handle;
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_destroy_uc {
+    struct pvrdma_cmd_hdr hdr;
+    u32 ctx_handle;
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_create_pd {
+    struct pvrdma_cmd_hdr hdr;
+    u32 ctx_handle;
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_create_pd_resp {
+    struct pvrdma_cmd_resp_hdr hdr;
+    u32 pd_handle;
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_destroy_pd {
+    struct pvrdma_cmd_hdr hdr;
+    u32 pd_handle;
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_create_mr {
+    struct pvrdma_cmd_hdr hdr;
+    u64 start;
+    u64 length;
+    u64 pdir_dma;
+    u32 pd_handle;
+    u32 access_flags;
+    u32 flags;
+    u32 nchunks;
+};
+
+struct pvrdma_cmd_create_mr_resp {
+    struct pvrdma_cmd_resp_hdr hdr;
+    u32 mr_handle;
+    u32 lkey;
+    u32 rkey;
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_destroy_mr {
+    struct pvrdma_cmd_hdr hdr;
+    u32 mr_handle;
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_create_cq {
+    struct pvrdma_cmd_hdr hdr;
+    u64 pdir_dma;
+    u32 ctx_handle;
+    u32 cqe;
+    u32 nchunks;
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_create_cq_resp {
+    struct pvrdma_cmd_resp_hdr hdr;
+    u32 cq_handle;
+    u32 cqe;
+};
+
+struct pvrdma_cmd_resize_cq {
+    struct pvrdma_cmd_hdr hdr;
+    u32 cq_handle;
+    u32 cqe;
+};
+
+struct pvrdma_cmd_resize_cq_resp {
+    struct pvrdma_cmd_resp_hdr hdr;
+    u32 cqe;
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_destroy_cq {
+    struct pvrdma_cmd_hdr hdr;
+    u32 cq_handle;
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_create_qp {
+    struct pvrdma_cmd_hdr hdr;
+    u64 pdir_dma;
+    u32 pd_handle;
+    u32 send_cq_handle;
+    u32 recv_cq_handle;
+    u32 srq_handle;
+    u32 max_send_wr;
+    u32 max_recv_wr;
+    u32 max_send_sge;
+    u32 max_recv_sge;
+    u32 max_inline_data;
+    u32 lkey;
+    u32 access_flags;
+    u16 total_chunks;
+    u16 send_chunks;
+    u16 max_atomic_arg;
+    u8 sq_sig_all;
+    u8 qp_type;
+    u8 is_srq;
+    u8 reserved[3];
+};
+
+struct pvrdma_cmd_create_qp_resp {
+    struct pvrdma_cmd_resp_hdr hdr;
+    u32 qpn;
+    u32 max_send_wr;
+    u32 max_recv_wr;
+    u32 max_send_sge;
+    u32 max_recv_sge;
+    u32 max_inline_data;
+};
+
+struct pvrdma_cmd_modify_qp {
+    struct pvrdma_cmd_hdr hdr;
+    u32 qp_handle;
+    u32 attr_mask;
+    struct pvrdma_qp_attr attrs;
+};
+
+struct pvrdma_cmd_query_qp {
+    struct pvrdma_cmd_hdr hdr;
+    u32 qp_handle;
+    u32 attr_mask;
+};
+
+struct pvrdma_cmd_query_qp_resp {
+    struct pvrdma_cmd_resp_hdr hdr;
+    struct pvrdma_qp_attr attrs;
+};
+
+struct pvrdma_cmd_destroy_qp {
+    struct pvrdma_cmd_hdr hdr;
+    u32 qp_handle;
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_destroy_qp_resp {
+    struct pvrdma_cmd_resp_hdr hdr;
+    u32 events_reported;
+    u8 reserved[4];
+};
+
+struct pvrdma_cmd_create_bind {
+    struct pvrdma_cmd_hdr hdr;
+    u32 mtu;
+    u32 vlan;
+    u32 index;
+    u8 new_gid[16];
+    u8 gid_type;
+    u8 reserved[3];
+};
+
+struct pvrdma_cmd_destroy_bind {
+    struct pvrdma_cmd_hdr hdr;
+    u32 index;
+    u8 dest_gid[16];
+    u8 reserved[4];
+};
+
+union pvrdma_cmd_req {
+    struct pvrdma_cmd_hdr hdr;
+    struct pvrdma_cmd_query_port query_port;
+    struct pvrdma_cmd_query_pkey query_pkey;
+    struct pvrdma_cmd_create_uc create_uc;
+    struct pvrdma_cmd_destroy_uc destroy_uc;
+    struct pvrdma_cmd_create_pd create_pd;
+    struct pvrdma_cmd_destroy_pd destroy_pd;
+    struct pvrdma_cmd_create_mr create_mr;
+    struct pvrdma_cmd_destroy_mr destroy_mr;
+    struct pvrdma_cmd_create_cq create_cq;
+    struct pvrdma_cmd_resize_cq resize_cq;
+    struct pvrdma_cmd_destroy_cq destroy_cq;
+    struct pvrdma_cmd_create_qp create_qp;
+    struct pvrdma_cmd_modify_qp modify_qp;
+    struct pvrdma_cmd_query_qp query_qp;
+    struct pvrdma_cmd_destroy_qp destroy_qp;
+    struct pvrdma_cmd_create_bind create_bind;
+    struct pvrdma_cmd_destroy_bind destroy_bind;
+};
+
+union pvrdma_cmd_resp {
+    struct pvrdma_cmd_resp_hdr hdr;
+    struct pvrdma_cmd_query_port_resp query_port_resp;
+    struct pvrdma_cmd_query_pkey_resp query_pkey_resp;
+    struct pvrdma_cmd_create_uc_resp create_uc_resp;
+    struct pvrdma_cmd_create_pd_resp create_pd_resp;
+    struct pvrdma_cmd_create_mr_resp create_mr_resp;
+    struct pvrdma_cmd_create_cq_resp create_cq_resp;
+    struct pvrdma_cmd_resize_cq_resp resize_cq_resp;
+    struct pvrdma_cmd_create_qp_resp create_qp_resp;
+    struct pvrdma_cmd_query_qp_resp query_qp_resp;
+    struct pvrdma_cmd_destroy_qp_resp destroy_qp_resp;
+};
+
+#endif /* PVRDMA_DEV_API_H */
diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.c
new file mode 100644
index 0000000000..c0900bccf2
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma_dev_ring.c
@@ -0,0 +1,140 @@
+#include <qemu/osdep.h>
+#include <hw/pci/pci.h>
+#include <cpu.h>
+
+#include "../rdma_utils.h"
+#include "pvrdma_ring.h"
+#include "pvrdma_dev_ring.h"
+#include "pvrdma_utils.h"
+
+int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
+              struct pvrdma_ring *ring_state, size_t max_elems, size_t elem_sz,
+              dma_addr_t *tbl, dma_addr_t npages)
+{
+    int i;
+    int rc = 0;
+
+    strncpy(ring->name, name, MAX_RING_NAME_SZ);
+    ring->name[MAX_RING_NAME_SZ - 1] = 0;
+    pr_dbg("Initializing %s ring\n", ring->name);
+    ring->dev = dev;
+    ring->ring_state = ring_state;
+    ring->max_elems = max_elems;
+    ring->elem_sz = elem_sz;
+    pr_dbg("ring->elem_sz=%ld\n", ring->elem_sz);
+    pr_dbg("npages=%ld\n", npages);
+    /* TODO: Give a moment to think if we want to redo driver settings
+    atomic_set(&ring->ring_state->prod_tail, 0);
+    atomic_set(&ring->ring_state->cons_head, 0);
+    */
+    ring->npages = npages;
+    ring->pages = malloc(npages * sizeof(void *));
+    for (i = 0; i < npages; i++) {
+        if (!tbl[i]) {
+            pr_err("npages=%ld but tbl[%d] is NULL\n", (long)npages, i);
+            continue;
+        }
+
+        ring->pages[i] = pvrdma_pci_dma_map(dev, tbl[i], TARGET_PAGE_SIZE);
+        if (!ring->pages[i]) {
+            rc = -ENOMEM;
+            pr_dbg("Fail to map to page %d\n", i);
+            goto out_free;
+        }
+        memset(ring->pages[i], 0, TARGET_PAGE_SIZE);
+    }
+
+    goto out;
+
+out_free:
+    while (i--) {
+        pvrdma_pci_dma_unmap(dev, ring->pages[i], TARGET_PAGE_SIZE);
+    }
+    free(ring->pages);
+
+out:
+    return rc;
+}
+
+void *pvrdma_ring_next_elem_read(PvrdmaRing *ring)
+{
+    unsigned int idx = 0, offset;
+
+    /*
+    pr_dbg("%s: t=%d, h=%d\n", ring->name, ring->ring_state->prod_tail,
+           ring->ring_state->cons_head);
+    */
+
+    if (!pvrdma_idx_ring_has_data(ring->ring_state, ring->max_elems, &idx)) {
+        pr_dbg("No more data in ring\n");
+        return NULL;
+    }
+
+    offset = idx * ring->elem_sz;
+    /*
+    pr_dbg("idx=%d\n", idx);
+    pr_dbg("offset=%d\n", offset);
+    */
+    return ring->pages[offset / TARGET_PAGE_SIZE] + (offset % TARGET_PAGE_SIZE);
+}
+
+void pvrdma_ring_read_inc(PvrdmaRing *ring)
+{
+    pvrdma_idx_ring_inc(&ring->ring_state->cons_head, ring->max_elems);
+    /*
+    pr_dbg("%s: t=%d, h=%d, m=%ld\n", ring->name,
+           ring->ring_state->prod_tail, ring->ring_state->cons_head,
+           ring->max_elems);
+    */
+}
+
+void *pvrdma_ring_next_elem_write(PvrdmaRing *ring)
+{
+    unsigned int idx, offset, tail;
+
+    /*
+    pr_dbg("%s: t=%d, h=%d\n", ring->name, ring->ring_state->prod_tail,
+           ring->ring_state->cons_head);
+    */
+
+    if (!pvrdma_idx_ring_has_space(ring->ring_state, ring->max_elems, &tail)) {
+        pr_dbg("CQ is full\n");
+        return NULL;
+    }
+
+    idx = pvrdma_idx(&ring->ring_state->prod_tail, ring->max_elems);
+    /* TODO: tail == idx */
+
+    offset = idx * ring->elem_sz;
+    return ring->pages[offset / TARGET_PAGE_SIZE] + (offset % TARGET_PAGE_SIZE);
+}
+
+void pvrdma_ring_write_inc(PvrdmaRing *ring)
+{
+    pvrdma_idx_ring_inc(&ring->ring_state->prod_tail, ring->max_elems);
+    /*
+    pr_dbg("%s: t=%d, h=%d, m=%ld\n", ring->name,
+           ring->ring_state->prod_tail, ring->ring_state->cons_head,
+           ring->max_elems);
+    */
+}
+
+void pvrdma_ring_free(PvrdmaRing *ring)
+{
+    if (!ring) {
+        return;
+    }
+
+    if (!ring->pages) {
+        return;
+    }
+
+    pr_dbg("ring->npages=%d\n", ring->npages);
+    while (ring->npages--) {
+        pvrdma_pci_dma_unmap(ring->dev, ring->pages[ring->npages],
+                             TARGET_PAGE_SIZE);
+    }
+
+    free(ring->pages);
+    ring->pages = NULL;
+}
diff --git a/hw/rdma/vmw/pvrdma_dev_ring.h b/hw/rdma/vmw/pvrdma_dev_ring.h
new file mode 100644
index 0000000000..a25c07d72e
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma_dev_ring.h
@@ -0,0 +1,43 @@
+/*
+ * QEMU VMWARE paravirtual RDMA ring utilities
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef PVRDMA_DEV_RING_H
+#define PVRDMA_DEV_RING_H
+
+#include <qemu/typedefs.h>
+#include "pvrdma_types.h"
+
+#define MAX_RING_NAME_SZ 32
+
+typedef struct PvrdmaRing {
+    char name[MAX_RING_NAME_SZ];
+    PCIDevice *dev;
+    size_t max_elems;
+    size_t elem_sz;
+    struct pvrdma_ring *ring_state; /* used only for unmap */
+    int npages;
+    void **pages;
+} PvrdmaRing;
+
+int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
+                     struct pvrdma_ring *ring_state, size_t max_elems,
+                     size_t elem_sz, dma_addr_t *tbl, dma_addr_t npages);
+void *pvrdma_ring_next_elem_read(PvrdmaRing *ring);
+void pvrdma_ring_read_inc(PvrdmaRing *ring);
+void *pvrdma_ring_next_elem_write(PvrdmaRing *ring);
+void pvrdma_ring_write_inc(PvrdmaRing *ring);
+void pvrdma_ring_free(PvrdmaRing *ring);
+
+#endif
diff --git a/hw/rdma/vmw/pvrdma_ib_verbs.h b/hw/rdma/vmw/pvrdma_ib_verbs.h
new file mode 100644
index 0000000000..f7399d8e83
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma_ib_verbs.h
@@ -0,0 +1,400 @@
+/*
+ * [PLEASE NOTE:  VMWARE, INC. ELECTS TO USE AND DISTRIBUTE THIS COMPONENT
+ * UNDER THE TERMS OF THE OpenIB.org BSD license.  THE ORIGINAL LICENSE TERMS
+ * ARE REPRODUCED BELOW ONLY AS A REFERENCE.]
+ *
+ * Copyright (c) 2004 Mellanox Technologies Ltd.  All rights reserved.
+ * Copyright (c) 2004 Infinicon Corporation.  All rights reserved.
+ * Copyright (c) 2004 Intel Corporation.  All rights reserved.
+ * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+ * Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
+ * Copyright (c) 2005, 2006, 2007 Cisco Systems.  All rights reserved.
+ * Copyright (c) 2015-2016 VMware, Inc.  All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#ifndef PVRDMA_IB_VERBS_H
+#define PVRDMA_IB_VERBS_H
+
+#include "pvrdma_types.h"
+#include <linux/types.h>
+
+union pvrdma_gid {
+    u8    raw[16];
+    struct {
+        __be64    subnet_prefix;
+        __be64    interface_id;
+    } global;
+};
+
+enum pvrdma_link_layer {
+    PVRDMA_LINK_LAYER_UNSPECIFIED,
+    PVRDMA_LINK_LAYER_INFINIBAND,
+    PVRDMA_LINK_LAYER_ETHERNET,
+};
+
+enum pvrdma_mtu {
+    PVRDMA_MTU_256  = 1,
+    PVRDMA_MTU_512  = 2,
+    PVRDMA_MTU_1024 = 3,
+    PVRDMA_MTU_2048 = 4,
+    PVRDMA_MTU_4096 = 5,
+};
+
+static inline int pvrdma_mtu_enum_to_int(enum pvrdma_mtu mtu)
+{
+    switch (mtu) {
+    case PVRDMA_MTU_256:    return  256;
+    case PVRDMA_MTU_512:    return  512;
+    case PVRDMA_MTU_1024:    return 1024;
+    case PVRDMA_MTU_2048:    return 2048;
+    case PVRDMA_MTU_4096:    return 4096;
+    default:        return   -1;
+    }
+}
+
+static inline enum pvrdma_mtu pvrdma_mtu_int_to_enum(int mtu)
+{
+    switch (mtu) {
+    case 256:    return PVRDMA_MTU_256;
+    case 512:    return PVRDMA_MTU_512;
+    case 1024:    return PVRDMA_MTU_1024;
+    case 2048:    return PVRDMA_MTU_2048;
+    case 4096:
+    default:    return PVRDMA_MTU_4096;
+    }
+}
+
+enum pvrdma_port_state {
+    PVRDMA_PORT_NOP            = 0,
+    PVRDMA_PORT_DOWN        = 1,
+    PVRDMA_PORT_INIT        = 2,
+    PVRDMA_PORT_ARMED        = 3,
+    PVRDMA_PORT_ACTIVE        = 4,
+    PVRDMA_PORT_ACTIVE_DEFER    = 5,
+};
+
+enum pvrdma_port_cap_flags {
+    PVRDMA_PORT_SM                = 1 <<  1,
+    PVRDMA_PORT_NOTICE_SUP            = 1 <<  2,
+    PVRDMA_PORT_TRAP_SUP            = 1 <<  3,
+    PVRDMA_PORT_OPT_IPD_SUP            = 1 <<  4,
+    PVRDMA_PORT_AUTO_MIGR_SUP        = 1 <<  5,
+    PVRDMA_PORT_SL_MAP_SUP            = 1 <<  6,
+    PVRDMA_PORT_MKEY_NVRAM            = 1 <<  7,
+    PVRDMA_PORT_PKEY_NVRAM            = 1 <<  8,
+    PVRDMA_PORT_LED_INFO_SUP        = 1 <<  9,
+    PVRDMA_PORT_SM_DISABLED            = 1 << 10,
+    PVRDMA_PORT_SYS_IMAGE_GUID_SUP        = 1 << 11,
+    PVRDMA_PORT_PKEY_SW_EXT_PORT_TRAP_SUP    = 1 << 12,
+    PVRDMA_PORT_EXTENDED_SPEEDS_SUP        = 1 << 14,
+    PVRDMA_PORT_CM_SUP            = 1 << 16,
+    PVRDMA_PORT_SNMP_TUNNEL_SUP        = 1 << 17,
+    PVRDMA_PORT_REINIT_SUP            = 1 << 18,
+    PVRDMA_PORT_DEVICE_MGMT_SUP        = 1 << 19,
+    PVRDMA_PORT_VENDOR_CLASS_SUP        = 1 << 20,
+    PVRDMA_PORT_DR_NOTICE_SUP        = 1 << 21,
+    PVRDMA_PORT_CAP_MASK_NOTICE_SUP        = 1 << 22,
+    PVRDMA_PORT_BOOT_MGMT_SUP        = 1 << 23,
+    PVRDMA_PORT_LINK_LATENCY_SUP        = 1 << 24,
+    PVRDMA_PORT_CLIENT_REG_SUP        = 1 << 25,
+    PVRDMA_PORT_IP_BASED_GIDS        = 1 << 26,
+    PVRDMA_PORT_CAP_FLAGS_MAX        = PVRDMA_PORT_IP_BASED_GIDS,
+};
+
+enum pvrdma_port_width {
+    PVRDMA_WIDTH_1X        = 1,
+    PVRDMA_WIDTH_4X        = 2,
+    PVRDMA_WIDTH_8X        = 4,
+    PVRDMA_WIDTH_12X    = 8,
+};
+
+static inline int pvrdma_width_enum_to_int(enum pvrdma_port_width width)
+{
+    switch (width) {
+    case PVRDMA_WIDTH_1X:    return  1;
+    case PVRDMA_WIDTH_4X:    return  4;
+    case PVRDMA_WIDTH_8X:    return  8;
+    case PVRDMA_WIDTH_12X:    return 12;
+    default:        return -1;
+    }
+}
+
+enum pvrdma_port_speed {
+    PVRDMA_SPEED_SDR    = 1,
+    PVRDMA_SPEED_DDR    = 2,
+    PVRDMA_SPEED_QDR    = 4,
+    PVRDMA_SPEED_FDR10    = 8,
+    PVRDMA_SPEED_FDR    = 16,
+    PVRDMA_SPEED_EDR    = 32,
+};
+
+struct pvrdma_port_attr {
+    enum pvrdma_port_state    state;
+    enum pvrdma_mtu        max_mtu;
+    enum pvrdma_mtu        active_mtu;
+    u32            gid_tbl_len;
+    u32            port_cap_flags;
+    u32            max_msg_sz;
+    u32            bad_pkey_cntr;
+    u32            qkey_viol_cntr;
+    u16            pkey_tbl_len;
+    u16            lid;
+    u16            sm_lid;
+    u8            lmc;
+    u8            max_vl_num;
+    u8            sm_sl;
+    u8            subnet_timeout;
+    u8            init_type_reply;
+    u8            active_width;
+    u8            active_speed;
+    u8            phys_state;
+    u8            reserved[2];
+};
+
+struct pvrdma_global_route {
+    union pvrdma_gid    dgid;
+    u32            flow_label;
+    u8            sgid_index;
+    u8            hop_limit;
+    u8            traffic_class;
+    u8            reserved;
+};
+
+struct pvrdma_grh {
+    __be32            version_tclass_flow;
+    __be16            paylen;
+    u8            next_hdr;
+    u8            hop_limit;
+    union pvrdma_gid    sgid;
+    union pvrdma_gid    dgid;
+};
+
+enum pvrdma_ah_flags {
+    PVRDMA_AH_GRH = 1,
+};
+
+enum pvrdma_rate {
+    PVRDMA_RATE_PORT_CURRENT    = 0,
+    PVRDMA_RATE_2_5_GBPS        = 2,
+    PVRDMA_RATE_5_GBPS        = 5,
+    PVRDMA_RATE_10_GBPS        = 3,
+    PVRDMA_RATE_20_GBPS        = 6,
+    PVRDMA_RATE_30_GBPS        = 4,
+    PVRDMA_RATE_40_GBPS        = 7,
+    PVRDMA_RATE_60_GBPS        = 8,
+    PVRDMA_RATE_80_GBPS        = 9,
+    PVRDMA_RATE_120_GBPS        = 10,
+    PVRDMA_RATE_14_GBPS        = 11,
+    PVRDMA_RATE_56_GBPS        = 12,
+    PVRDMA_RATE_112_GBPS        = 13,
+    PVRDMA_RATE_168_GBPS        = 14,
+    PVRDMA_RATE_25_GBPS        = 15,
+    PVRDMA_RATE_100_GBPS        = 16,
+    PVRDMA_RATE_200_GBPS        = 17,
+    PVRDMA_RATE_300_GBPS        = 18,
+};
+
+struct pvrdma_ah_attr {
+    struct pvrdma_global_route    grh;
+    u16                dlid;
+    u16                vlan_id;
+    u8                sl;
+    u8                src_path_bits;
+    u8                static_rate;
+    u8                ah_flags;
+    u8                port_num;
+    u8                dmac[6];
+    u8                reserved;
+};
+
+enum pvrdma_cq_notify_flags {
+    PVRDMA_CQ_SOLICITED        = 1 << 0,
+    PVRDMA_CQ_NEXT_COMP        = 1 << 1,
+    PVRDMA_CQ_SOLICITED_MASK    = PVRDMA_CQ_SOLICITED |
+                      PVRDMA_CQ_NEXT_COMP,
+    PVRDMA_CQ_REPORT_MISSED_EVENTS    = 1 << 2,
+};
+
+struct pvrdma_qp_cap {
+    u32    max_send_wr;
+    u32    max_recv_wr;
+    u32    max_send_sge;
+    u32    max_recv_sge;
+    u32    max_inline_data;
+    u32    reserved;
+};
+
+enum pvrdma_sig_type {
+    PVRDMA_SIGNAL_ALL_WR,
+    PVRDMA_SIGNAL_REQ_WR,
+};
+
+enum pvrdma_qp_type {
+    PVRDMA_QPT_SMI,
+    PVRDMA_QPT_GSI,
+    PVRDMA_QPT_RC,
+    PVRDMA_QPT_UC,
+    PVRDMA_QPT_UD,
+    PVRDMA_QPT_RAW_IPV6,
+    PVRDMA_QPT_RAW_ETHERTYPE,
+    PVRDMA_QPT_RAW_PACKET = 8,
+    PVRDMA_QPT_XRC_INI = 9,
+    PVRDMA_QPT_XRC_TGT,
+    PVRDMA_QPT_MAX,
+};
+
+enum pvrdma_qp_create_flags {
+    PVRDMA_QP_CREATE_IPOPVRDMA_UD_LSO        = 1 << 0,
+    PVRDMA_QP_CREATE_BLOCK_MULTICAST_LOOPBACK    = 1 << 1,
+};
+
+enum pvrdma_qp_attr_mask {
+    PVRDMA_QP_STATE            = 1 << 0,
+    PVRDMA_QP_CUR_STATE        = 1 << 1,
+    PVRDMA_QP_EN_SQD_ASYNC_NOTIFY    = 1 << 2,
+    PVRDMA_QP_ACCESS_FLAGS        = 1 << 3,
+    PVRDMA_QP_PKEY_INDEX        = 1 << 4,
+    PVRDMA_QP_PORT            = 1 << 5,
+    PVRDMA_QP_QKEY            = 1 << 6,
+    PVRDMA_QP_AV            = 1 << 7,
+    PVRDMA_QP_PATH_MTU        = 1 << 8,
+    PVRDMA_QP_TIMEOUT        = 1 << 9,
+    PVRDMA_QP_RETRY_CNT        = 1 << 10,
+    PVRDMA_QP_RNR_RETRY        = 1 << 11,
+    PVRDMA_QP_RQ_PSN        = 1 << 12,
+    PVRDMA_QP_MAX_QP_RD_ATOMIC    = 1 << 13,
+    PVRDMA_QP_ALT_PATH        = 1 << 14,
+    PVRDMA_QP_MIN_RNR_TIMER        = 1 << 15,
+    PVRDMA_QP_SQ_PSN        = 1 << 16,
+    PVRDMA_QP_MAX_DEST_RD_ATOMIC    = 1 << 17,
+    PVRDMA_QP_PATH_MIG_STATE    = 1 << 18,
+    PVRDMA_QP_CAP            = 1 << 19,
+    PVRDMA_QP_DEST_QPN        = 1 << 20,
+    PVRDMA_QP_ATTR_MASK_MAX        = PVRDMA_QP_DEST_QPN,
+};
+
+enum pvrdma_qp_state {
+    PVRDMA_QPS_RESET,
+    PVRDMA_QPS_INIT,
+    PVRDMA_QPS_RTR,
+    PVRDMA_QPS_RTS,
+    PVRDMA_QPS_SQD,
+    PVRDMA_QPS_SQE,
+    PVRDMA_QPS_ERR,
+};
+
+enum pvrdma_mig_state {
+    PVRDMA_MIG_MIGRATED,
+    PVRDMA_MIG_REARM,
+    PVRDMA_MIG_ARMED,
+};
+
+enum pvrdma_mw_type {
+    PVRDMA_MW_TYPE_1 = 1,
+    PVRDMA_MW_TYPE_2 = 2,
+};
+
+struct pvrdma_qp_attr {
+    enum pvrdma_qp_state    qp_state;
+    enum pvrdma_qp_state    cur_qp_state;
+    enum pvrdma_mtu        path_mtu;
+    enum pvrdma_mig_state    path_mig_state;
+    u32            qkey;
+    u32            rq_psn;
+    u32            sq_psn;
+    u32            dest_qp_num;
+    u32            qp_access_flags;
+    u16            pkey_index;
+    u16            alt_pkey_index;
+    u8            en_sqd_async_notify;
+    u8            sq_draining;
+    u8            max_rd_atomic;
+    u8            max_dest_rd_atomic;
+    u8            min_rnr_timer;
+    u8            port_num;
+    u8            timeout;
+    u8            retry_cnt;
+    u8            rnr_retry;
+    u8            alt_port_num;
+    u8            alt_timeout;
+    u8            reserved[5];
+    struct pvrdma_qp_cap    cap;
+    struct pvrdma_ah_attr    ah_attr;
+    struct pvrdma_ah_attr    alt_ah_attr;
+};
+
+enum pvrdma_send_flags {
+    PVRDMA_SEND_FENCE    = 1 << 0,
+    PVRDMA_SEND_SIGNALED    = 1 << 1,
+    PVRDMA_SEND_SOLICITED    = 1 << 2,
+    PVRDMA_SEND_INLINE    = 1 << 3,
+    PVRDMA_SEND_IP_CSUM    = 1 << 4,
+    PVRDMA_SEND_FLAGS_MAX    = PVRDMA_SEND_IP_CSUM,
+};
+
+enum pvrdma_access_flags {
+    PVRDMA_ACCESS_LOCAL_WRITE    = 1 << 0,
+    PVRDMA_ACCESS_REMOTE_WRITE    = 1 << 1,
+    PVRDMA_ACCESS_REMOTE_READ    = 1 << 2,
+    PVRDMA_ACCESS_REMOTE_ATOMIC    = 1 << 3,
+    PVRDMA_ACCESS_MW_BIND        = 1 << 4,
+    PVRDMA_ZERO_BASED        = 1 << 5,
+    PVRDMA_ACCESS_ON_DEMAND        = 1 << 6,
+    PVRDMA_ACCESS_FLAGS_MAX        = PVRDMA_ACCESS_ON_DEMAND,
+};
+
+enum ib_wc_status {
+    IB_WC_SUCCESS,
+    IB_WC_LOC_LEN_ERR,
+    IB_WC_LOC_QP_OP_ERR,
+    IB_WC_LOC_EEC_OP_ERR,
+    IB_WC_LOC_PROT_ERR,
+    IB_WC_WR_FLUSH_ERR,
+    IB_WC_MW_BIND_ERR,
+    IB_WC_BAD_RESP_ERR,
+    IB_WC_LOC_ACCESS_ERR,
+    IB_WC_REM_INV_REQ_ERR,
+    IB_WC_REM_ACCESS_ERR,
+    IB_WC_REM_OP_ERR,
+    IB_WC_RETRY_EXC_ERR,
+    IB_WC_RNR_RETRY_EXC_ERR,
+    IB_WC_LOC_RDD_VIOL_ERR,
+    IB_WC_REM_INV_RD_REQ_ERR,
+    IB_WC_REM_ABORT_ERR,
+    IB_WC_INV_EECN_ERR,
+    IB_WC_INV_EEC_STATE_ERR,
+    IB_WC_FATAL_ERR,
+    IB_WC_RESP_TIMEOUT_ERR,
+    IB_WC_GENERAL_ERR
+};
+
+#endif /* PVRDMA_IB_VERBS_H */
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
new file mode 100644
index 0000000000..33acb0f508
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -0,0 +1,644 @@
+#include <qemu/osdep.h>
+#include <qapi/error.h>
+#include <hw/hw.h>
+#include <hw/pci/pci.h>
+#include <hw/pci/pci_ids.h>
+#include <hw/pci/msi.h>
+#include <hw/pci/msix.h>
+#include <hw/qdev-core.h>
+#include <hw/qdev-properties.h>
+#include <cpu.h>
+#include "trace.h"
+
+#include "../rdma_rm.h"
+#include "../rdma_backend.h"
+#include "../rdma_utils.h"
+
+#include "pvrdma_utils.h"
+#include "pvrdma.h"
+#include "pvrdma_dev_api.h"
+#include "pvrdma_qp_ops.h"
+
+static Property pvrdma_dev_properties[] = {
+    DEFINE_PROP_STRING("backend-dev", PVRDMADev, backend_device_name),
+    DEFINE_PROP_UINT8("backend-port", PVRDMADev, backend_port_num, 1),
+    DEFINE_PROP_UINT8("backend-gid-idx", PVRDMADev, backend_gid_idx, 0),
+    DEFINE_PROP_UINT64("dev-caps-max-mr-size", PVRDMADev, dev_attr.max_mr_size,
+                       MAX_MR_SIZE),
+    DEFINE_PROP_INT32("dev-caps-max-qp", PVRDMADev, dev_attr.max_qp, MAX_QP),
+    DEFINE_PROP_INT32("dev-caps-max-sge", PVRDMADev, dev_attr.max_sge, MAX_SGE),
+    DEFINE_PROP_INT32("dev-caps-max-cq", PVRDMADev, dev_attr.max_cq, MAX_CQ),
+    DEFINE_PROP_INT32("dev-caps-max-mr", PVRDMADev, dev_attr.max_mr, MAX_MR),
+    DEFINE_PROP_INT32("dev-caps-max-pd", PVRDMADev, dev_attr.max_pd, MAX_PD),
+    DEFINE_PROP_INT32("dev-caps-qp-rd-atom", PVRDMADev, dev_attr.max_qp_rd_atom,
+                      MAX_QP_RD_ATOM),
+    DEFINE_PROP_INT32("dev-caps-max-qp-init-rd-atom", PVRDMADev,
+                      dev_attr.max_qp_init_rd_atom, MAX_QP_INIT_RD_ATOM),
+    DEFINE_PROP_INT32("dev-caps-max-ah", PVRDMADev, dev_attr.max_ah, MAX_AH),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void free_dev_ring(PCIDevice *pci_dev, PvrdmaRing *ring,
+                          void *ring_state)
+{
+    pvrdma_ring_free(ring);
+    pvrdma_pci_dma_unmap(pci_dev, ring_state, TARGET_PAGE_SIZE);
+}
+
+static int init_dev_ring(PvrdmaRing *ring, struct pvrdma_ring **ring_state,
+                         const char *name, PCIDevice *pci_dev,
+                         dma_addr_t dir_addr, u32 num_pages)
+{
+    __u64 *dir, *tbl;
+    int rc = 0;
+
+    pr_dbg("Initializing device ring %s\n", name);
+    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)dir_addr);
+    pr_dbg("num_pages=%d\n", num_pages);
+    dir = pvrdma_pci_dma_map(pci_dev, dir_addr, TARGET_PAGE_SIZE);
+    if (!dir) {
+        pr_err("Fail to map to page directory\n");
+        rc = -ENOMEM;
+        goto out;
+    }
+    tbl = pvrdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
+    if (!tbl) {
+        pr_err("Fail to map to page table\n");
+        rc = -ENOMEM;
+        goto out_free_dir;
+    }
+
+    *ring_state = pvrdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
+    if (!*ring_state) {
+        pr_err("Fail to map to ring state\n");
+        rc = -ENOMEM;
+        goto out_free_tbl;
+    }
+    /* RX ring is the second */
+    (struct pvrdma_ring *)(*ring_state)++;
+    rc = pvrdma_ring_init(ring, name, pci_dev,
+                          (struct pvrdma_ring *)*ring_state,
+                          (num_pages - 1) * TARGET_PAGE_SIZE /
+                          sizeof(struct pvrdma_cqne),
+                          sizeof(struct pvrdma_cqne),
+                          (dma_addr_t *)&tbl[1], (dma_addr_t)num_pages - 1);
+    if (rc) {
+        pr_err("Fail to initialize ring\n");
+        rc = -ENOMEM;
+        goto out_free_ring_state;
+    }
+
+    goto out_free_tbl;
+
+out_free_ring_state:
+    pvrdma_pci_dma_unmap(pci_dev, *ring_state, TARGET_PAGE_SIZE);
+
+out_free_tbl:
+    pvrdma_pci_dma_unmap(pci_dev, tbl, TARGET_PAGE_SIZE);
+
+out_free_dir:
+    pvrdma_pci_dma_unmap(pci_dev, dir, TARGET_PAGE_SIZE);
+
+out:
+    return rc;
+}
+
+static void free_dsr(PVRDMADev *dev)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+
+    if (!dev->dsr_info.dsr) {
+        return;
+    }
+
+    free_dev_ring(pci_dev, &dev->dsr_info.async,
+                  dev->dsr_info.async_ring_state);
+
+    free_dev_ring(pci_dev, &dev->dsr_info.cq, dev->dsr_info.cq_ring_state);
+
+    pvrdma_pci_dma_unmap(pci_dev, dev->dsr_info.req,
+                         sizeof(union pvrdma_cmd_req));
+
+    pvrdma_pci_dma_unmap(pci_dev, dev->dsr_info.rsp,
+                         sizeof(union pvrdma_cmd_resp));
+
+    pvrdma_pci_dma_unmap(pci_dev, dev->dsr_info.dsr,
+                         sizeof(struct pvrdma_device_shared_region));
+
+    dev->dsr_info.dsr = NULL;
+}
+
+static int load_dsr(PVRDMADev *dev)
+{
+    int rc = 0;
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    DSRInfo *dsr_info;
+    struct pvrdma_device_shared_region *dsr;
+
+    free_dsr(dev);
+
+    /* Map to DSR */
+    pr_dbg("dsr_dma=0x%llx\n", (long long unsigned int)dev->dsr_info.dma);
+    dev->dsr_info.dsr = pvrdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
+                                sizeof(struct pvrdma_device_shared_region));
+    if (!dev->dsr_info.dsr) {
+        pr_err("Fail to map to DSR\n");
+        rc = -ENOMEM;
+        goto out;
+    }
+
+    /* Shortcuts */
+    dsr_info = &dev->dsr_info;
+    dsr = dsr_info->dsr;
+
+    /* Map to command slot */
+    pr_dbg("cmd_dma=0x%llx\n", (long long unsigned int)dsr->cmd_slot_dma);
+    dsr_info->req = pvrdma_pci_dma_map(pci_dev, dsr->cmd_slot_dma,
+                                       sizeof(union pvrdma_cmd_req));
+    if (!dsr_info->req) {
+        pr_err("Fail to map to command slot address\n");
+        rc = -ENOMEM;
+        goto out_free_dsr;
+    }
+
+    /* Map to response slot */
+    pr_dbg("rsp_dma=0x%llx\n", (long long unsigned int)dsr->resp_slot_dma);
+    dsr_info->rsp = pvrdma_pci_dma_map(pci_dev, dsr->resp_slot_dma,
+                                       sizeof(union pvrdma_cmd_resp));
+    if (!dsr_info->rsp) {
+        pr_err("Fail to map to response slot address\n");
+        rc = -ENOMEM;
+        goto out_free_req;
+    }
+
+    /* Map to CQ notification ring */
+    rc = init_dev_ring(&dsr_info->cq, &dsr_info->cq_ring_state, "dev_cq",
+                       pci_dev, dsr->cq_ring_pages.pdir_dma,
+                       dsr->cq_ring_pages.num_pages);
+    if (rc) {
+        pr_err("Fail to map to initialize CQ ring\n");
+        rc = -ENOMEM;
+        goto out_free_rsp;
+    }
+
+    /* Map to event notification ring */
+    rc = init_dev_ring(&dsr_info->async, &dsr_info->async_ring_state,
+                       "dev_async", pci_dev, dsr->async_ring_pages.pdir_dma,
+                       dsr->async_ring_pages.num_pages);
+    if (rc) {
+        pr_err("Fail to map to initialize event ring\n");
+        rc = -ENOMEM;
+        goto out_free_rsp;
+    }
+
+    goto out;
+
+out_free_rsp:
+    pvrdma_pci_dma_unmap(pci_dev, dsr_info->rsp, sizeof(union pvrdma_cmd_resp));
+
+out_free_req:
+    pvrdma_pci_dma_unmap(pci_dev, dsr_info->req, sizeof(union pvrdma_cmd_req));
+
+out_free_dsr:
+    pvrdma_pci_dma_unmap(pci_dev, dsr_info->dsr,
+                         sizeof(struct pvrdma_device_shared_region));
+    dsr_info->dsr = NULL;
+
+out:
+    return rc;
+}
+
+static void init_dsr_dev_caps(PVRDMADev *dev)
+{
+    struct pvrdma_device_shared_region *dsr;
+
+    if (dev->dsr_info.dsr == NULL) {
+        pr_err("Can't initialized DSR\n");
+        return;
+    }
+
+    dsr = dev->dsr_info.dsr;
+
+    dsr->caps.fw_ver = PVRDMA_FW_VERSION;
+    pr_dbg("fw_ver=0x%lx\n", dsr->caps.fw_ver);
+
+    dsr->caps.mode = PVRDMA_DEVICE_MODE_ROCE;
+    pr_dbg("mode=%d\n", dsr->caps.mode);
+
+    dsr->caps.gid_types |= PVRDMA_GID_TYPE_FLAG_ROCE_V1;
+    pr_dbg("gid_types=0x%x\n", dsr->caps.gid_types);
+
+    dsr->caps.max_uar = RDMA_BAR2_UAR_SIZE;
+    pr_dbg("max_uar=%d\n", dsr->caps.max_uar);
+
+    dsr->caps.max_mr_size = dev->dev_attr.max_mr_size;
+    dsr->caps.max_qp = dev->dev_attr.max_qp;
+    dsr->caps.max_qp_wr = dev->dev_attr.max_qp_wr;
+    dsr->caps.max_sge = dev->dev_attr.max_sge;
+    dsr->caps.max_cq = dev->dev_attr.max_cq;
+    dsr->caps.max_cqe = dev->dev_attr.max_cqe;
+    dsr->caps.max_mr = dev->dev_attr.max_mr;
+    dsr->caps.max_pd = dev->dev_attr.max_pd;
+    dsr->caps.max_ah = dev->dev_attr.max_ah;
+
+    dsr->caps.gid_tbl_len = MAX_GIDS;
+    pr_dbg("gid_tbl_len=%d\n", dsr->caps.gid_tbl_len);
+
+    dsr->caps.sys_image_guid = 0;
+    pr_dbg("sys_image_guid=%llx\n", dsr->caps.sys_image_guid);
+
+    dsr->caps.node_guid = cpu_to_be64(dev->node_guid);
+    pr_dbg("node_guid=%llx\n",
+           (long long unsigned int)be64_to_cpu(dsr->caps.node_guid));
+
+    dsr->caps.phys_port_cnt = MAX_PORTS;
+    pr_dbg("phys_port_cnt=%d\n", dsr->caps.phys_port_cnt);
+
+    dsr->caps.max_pkeys = MAX_PKEYS;
+    pr_dbg("max_pkeys=%d\n", dsr->caps.max_pkeys);
+
+    pr_dbg("Initialized\n");
+}
+
+static void free_ports(PVRDMADev *dev)
+{
+    int i;
+
+    for (i = 0; i < MAX_PORTS; i++) {
+        free(dev->rdma_dev_res.ports[i].gid_tbl);
+    }
+}
+
+static int init_ports(PVRDMADev *dev, Error **errp)
+{
+    int i, ret = 0;
+
+    memset(dev->rdma_dev_res.ports, 0, sizeof(dev->rdma_dev_res.ports));
+
+    for (i = 0; i < MAX_PORTS; i++) {
+        dev->rdma_dev_res.ports[i].state = PVRDMA_PORT_DOWN;
+
+        dev->rdma_dev_res.ports[i].pkey_tbl =
+            malloc(sizeof(*dev->rdma_dev_res.ports[i].pkey_tbl) *
+                   MAX_PORT_PKEYS);
+        if (dev->rdma_dev_res.ports[i].gid_tbl == NULL) {
+            goto err_free_ports;
+        }
+
+        memset(dev->rdma_dev_res.ports[i].gid_tbl, 0,
+               sizeof(dev->rdma_dev_res.ports[i].gid_tbl));
+    }
+
+    return 0;
+
+err_free_ports:
+    free_ports(dev);
+
+    error_setg(errp, "Fail to initialize device's ports");
+
+    return ret;
+}
+
+static void activate_device(PVRDMADev *dev)
+{
+    set_reg_val(dev, PVRDMA_REG_ERR, 0);
+    pr_dbg("Device activated\n");
+}
+
+static int unquiesce_device(PVRDMADev *dev)
+{
+    pr_dbg("Device unquiesced\n");
+    return 0;
+}
+
+static int reset_device(PVRDMADev *dev)
+{
+    pr_dbg("Device reset complete\n");
+    return 0;
+}
+
+static uint64_t regs_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PVRDMADev *dev = opaque;
+    __u32 val;
+
+    /* pr_dbg("addr=0x%lx, size=%d\n", addr, size); */
+
+    if (get_reg_val(dev, addr, &val)) {
+        pr_dbg("Error trying to read REG value from address 0x%x\n",
+               (__u32)addr);
+        return -EINVAL;
+    }
+
+    trace_pvrdma_regs_read(addr, val);
+
+    return val;
+}
+
+static void regs_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PVRDMADev *dev = opaque;
+
+    /* pr_dbg("addr=0x%lx, val=0x%x, size=%d\n", addr, (uint32_t)val, size); */
+
+    if (set_reg_val(dev, addr, val)) {
+        pr_err("Error trying to set REG value, addr=0x%lx, val=0x%lx\n",
+               (uint64_t)addr, val);
+        return;
+    }
+
+    trace_pvrdma_regs_write(addr, val);
+
+    switch (addr) {
+    case PVRDMA_REG_DSRLOW:
+        dev->dsr_info.dma = val;
+        break;
+    case PVRDMA_REG_DSRHIGH:
+        dev->dsr_info.dma |= val << 32;
+        load_dsr(dev);
+        init_dsr_dev_caps(dev);
+        break;
+    case PVRDMA_REG_CTL:
+        switch (val) {
+        case PVRDMA_DEVICE_CTL_ACTIVATE:
+            activate_device(dev);
+            break;
+        case PVRDMA_DEVICE_CTL_UNQUIESCE:
+            unquiesce_device(dev);
+            break;
+        case PVRDMA_DEVICE_CTL_RESET:
+            reset_device(dev);
+            break;
+        }
+    break;
+    case PVRDMA_REG_IMR:
+        pr_dbg("Interrupt mask=0x%lx\n", val);
+        dev->interrupt_mask = val;
+        break;
+    case PVRDMA_REG_REQUEST:
+        if (val == 0) {
+            execute_command(dev);
+        }
+    break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps regs_ops = {
+    .read = regs_read,
+    .write = regs_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = sizeof(uint32_t),
+        .max_access_size = sizeof(uint32_t),
+    },
+};
+
+static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PVRDMADev *dev = opaque;
+
+    /* pr_dbg("addr=0x%lx, val=0x%x, size=%d\n", addr, (uint32_t)val, size); */
+
+    switch (addr & 0xFFF) { /* Mask with 0xFFF as each UC gets page */
+    case PVRDMA_UAR_QP_OFFSET:
+        pr_dbg("UAR QP command, addr=0x%x, val=0x%lx\n", (__u32)addr, val);
+        if (val & PVRDMA_UAR_QP_SEND) {
+            pvrdma_qp_send(dev, val & PVRDMA_UAR_HANDLE_MASK);
+        }
+        if (val & PVRDMA_UAR_QP_RECV) {
+            pvrdma_qp_recv(dev, val & PVRDMA_UAR_HANDLE_MASK);
+        }
+        break;
+    case PVRDMA_UAR_CQ_OFFSET:
+        /* pr_dbg("UAR CQ cmd, addr=0x%x, val=0x%lx\n", (__u32)addr, val); */
+        if (val & PVRDMA_UAR_CQ_ARM) {
+            rdma_rm_req_notify_cq(&dev->rdma_dev_res,
+                                  val & PVRDMA_UAR_HANDLE_MASK,
+                                  !!(val & PVRDMA_UAR_CQ_ARM_SOL));
+        }
+        if (val & PVRDMA_UAR_CQ_ARM_SOL) {
+            pr_dbg("UAR_CQ_ARM_SOL (%ld)\n", val & PVRDMA_UAR_HANDLE_MASK);
+        }
+        if (val & PVRDMA_UAR_CQ_POLL) {
+            pr_dbg("UAR_CQ_POLL (%ld)\n", val & PVRDMA_UAR_HANDLE_MASK);
+            pvrdma_cq_poll(&dev->rdma_dev_res, val & PVRDMA_UAR_HANDLE_MASK);
+        }
+        break;
+    default:
+        pr_err("Unsupported command, addr=0x%lx, val=0x%lx\n",
+               (uint64_t)addr, val);
+        break;
+    }
+}
+
+static const MemoryRegionOps uar_ops = {
+    .write = uar_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = sizeof(uint32_t),
+        .max_access_size = sizeof(uint32_t),
+    },
+};
+
+static void init_pci_config(PCIDevice *pdev)
+{
+    pdev->config[PCI_INTERRUPT_PIN] = 1;
+}
+
+static void init_bars(PCIDevice *pdev)
+{
+    PVRDMADev *dev = PVRDMA_DEV(pdev);
+
+    /* BAR 0 - MSI-X */
+    memory_region_init(&dev->msix, OBJECT(dev), "pvrdma-msix",
+                       RDMA_BAR0_MSIX_SIZE);
+    pci_register_bar(pdev, RDMA_MSIX_BAR_IDX, PCI_BASE_ADDRESS_SPACE_MEMORY,
+                     &dev->msix);
+
+    /* BAR 1 - Registers */
+    memset(&dev->regs_data, 0, sizeof(dev->regs_data));
+    memory_region_init_io(&dev->regs, OBJECT(dev), &regs_ops, dev,
+                          "pvrdma-regs", RDMA_BAR1_REGS_SIZE);
+    pci_register_bar(pdev, RDMA_REG_BAR_IDX, PCI_BASE_ADDRESS_SPACE_MEMORY,
+                     &dev->regs);
+
+    /* BAR 2 - UAR */
+    memset(&dev->uar_data, 0, sizeof(dev->uar_data));
+    memory_region_init_io(&dev->uar, OBJECT(dev), &uar_ops, dev, "rdma-uar",
+                          RDMA_BAR2_UAR_SIZE);
+    pci_register_bar(pdev, RDMA_UAR_BAR_IDX, PCI_BASE_ADDRESS_SPACE_MEMORY,
+                     &dev->uar);
+}
+
+static void init_regs(PCIDevice *pdev)
+{
+    PVRDMADev *dev = PVRDMA_DEV(pdev);
+
+    set_reg_val(dev, PVRDMA_REG_VERSION, PVRDMA_HW_VERSION);
+    set_reg_val(dev, PVRDMA_REG_ERR, 0xFFFF);
+}
+
+static void uninit_msix(PCIDevice *pdev, int used_vectors)
+{
+    PVRDMADev *dev = PVRDMA_DEV(pdev);
+    int i;
+
+    for (i = 0; i < used_vectors; i++) {
+        msix_vector_unuse(pdev, i);
+    }
+
+    msix_uninit(pdev, &dev->msix, &dev->msix);
+}
+
+static int init_msix(PCIDevice *pdev, Error **errp)
+{
+    PVRDMADev *dev = PVRDMA_DEV(pdev);
+    int i;
+    int rc;
+
+    rc = msix_init(pdev, RDMA_MAX_INTRS, &dev->msix, RDMA_MSIX_BAR_IDX,
+                   RDMA_MSIX_TABLE, &dev->msix, RDMA_MSIX_BAR_IDX,
+                   RDMA_MSIX_PBA, 0, NULL);
+
+    if (rc < 0) {
+        error_setg(errp, "Fail to initialize MSI-X");
+        return rc;
+    }
+
+    for (i = 0; i < RDMA_MAX_INTRS; i++) {
+        rc = msix_vector_use(PCI_DEVICE(dev), i);
+        if (rc < 0) {
+            error_setg(errp, "Fail mark MSI-X vercor %d", i);
+            uninit_msix(pdev, i);
+            return rc;
+        }
+    }
+
+    return 0;
+}
+
+static void init_dev_caps(PVRDMADev *dev)
+{
+    size_t pg_tbl_bytes = TARGET_PAGE_SIZE * (TARGET_PAGE_SIZE / sizeof(u64));
+    size_t wr_sz = MAX(sizeof(struct pvrdma_sq_wqe_hdr),
+                       sizeof(struct pvrdma_rq_wqe_hdr));
+
+    dev->dev_attr.max_qp_wr = pg_tbl_bytes /
+                              (wr_sz + sizeof(struct pvrdma_sge) * MAX_SGE) -
+                              TARGET_PAGE_SIZE; /* First page is ring state */
+    pr_dbg("max_qp_wr=%d\n", dev->dev_attr.max_qp_wr);
+
+    dev->dev_attr.max_cqe = pg_tbl_bytes / sizeof(struct pvrdma_cqe) -
+                            TARGET_PAGE_SIZE; /* First page is ring state */
+    pr_dbg("max_cqe=%d\n", dev->dev_attr.max_cqe);
+}
+
+static void pvrdma_realize(PCIDevice *pdev, Error **errp)
+{
+    int rc;
+    PVRDMADev *dev = PVRDMA_DEV(pdev);
+
+    pr_dbg("Initializing device %s %x.%x\n", pdev->name,
+           PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+
+    dev->dsr_info.dsr = NULL;
+
+    init_pci_config(pdev);
+
+    init_bars(pdev);
+
+    init_regs(pdev);
+
+    init_dev_caps(dev);
+
+    rc = init_msix(pdev, errp);
+    if (rc) {
+        goto out;
+    }
+
+    rc = rdma_backend_init(&dev->backend_dev, &dev->rdma_dev_res,
+                           dev->backend_device_name, dev->backend_port_num,
+                           dev->backend_gid_idx, &dev->dev_attr, errp);
+    if (rc) {
+        goto out;
+    }
+
+    rc = rdma_rm_init(&dev->rdma_dev_res, &dev->dev_attr, errp);
+    if (rc) {
+        goto out;
+    }
+
+    rc = init_ports(dev, errp);
+    if (rc) {
+        goto out;
+    }
+
+    rc = pvrdma_qp_ops_init();
+    if (rc) {
+        goto out;
+    }
+
+out:
+    if (rc) {
+        error_append_hint(errp, "Device fail to load\n");
+    }
+}
+
+static void pvrdma_exit(PCIDevice *pdev)
+{
+    PVRDMADev *dev = PVRDMA_DEV(pdev);
+
+    pr_dbg("Closing device %s %x.%x\n", pdev->name, PCI_SLOT(pdev->devfn),
+           PCI_FUNC(pdev->devfn));
+
+    pvrdma_qp_ops_fini();
+
+    free_ports(dev);
+
+    rdma_rm_fini(&dev->rdma_dev_res);
+
+    rdma_backend_fini(&dev->backend_dev);
+
+    free_dsr(dev);
+
+    if (msix_enabled(pdev)) {
+        uninit_msix(pdev, RDMA_MAX_INTRS);
+    }
+}
+
+static void pvrdma_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = pvrdma_realize;
+    k->exit = pvrdma_exit;
+    k->vendor_id = PCI_VENDOR_ID_VMWARE;
+    k->device_id = PCI_DEVICE_ID_VMWARE_PVRDMA;
+    k->revision = 0x00;
+    k->class_id = PCI_CLASS_NETWORK_OTHER;
+
+    dc->desc = "RDMA Device";
+    dc->props = pvrdma_dev_properties;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+}
+
+static const TypeInfo pvrdma_info = {
+    .name = PVRDMA_HW_NAME,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PVRDMADev),
+    .class_init = pvrdma_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    }
+};
+
+static void register_types(void)
+{
+    type_register_static(&pvrdma_info);
+}
+
+type_init(register_types)
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
new file mode 100644
index 0000000000..4b2d02a61f
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -0,0 +1,212 @@
+#include <qemu/osdep.h>
+
+#include "../rdma_utils.h"
+#include "../rdma_rm.h"
+#include "../rdma_backend.h"
+
+#include "pvrdma.h"
+#include "pvrdma_utils.h"
+#include "pvrdma_qp_ops.h"
+
+typedef struct CompHandlerCtx {
+    PVRDMADev *dev;
+    u32 cq_handle;
+    struct pvrdma_cqe cqe;
+} CompHandlerCtx;
+
+/* Send Queue WQE */
+typedef struct PvrdmaSqWqe {
+    struct pvrdma_sq_wqe_hdr hdr;
+    struct pvrdma_sge sge[0];
+} PvrdmaSqWqe;
+
+/* Recv Queue WQE */
+typedef struct PvrdmaRqWqe {
+    struct pvrdma_rq_wqe_hdr hdr;
+    struct pvrdma_sge sge[0];
+} PvrdmaRqWqe;
+
+/*
+ * 1. Put CQE on send CQ ring
+ * 2. Put CQ number on dsr completion ring
+ * 3. Interrupt host
+ */
+static int pvrdma_post_cqe(PVRDMADev *dev, u32 cq_handle,
+                           struct pvrdma_cqe *cqe)
+{
+    struct pvrdma_cqe *cqe1;
+    struct pvrdma_cqne *cqne;
+    PvrdmaRing *ring;
+    RdmaRmCQ *cq = rdma_rm_get_cq(&dev->rdma_dev_res, cq_handle);
+
+    if (unlikely(!cq)) {
+        pr_dbg("Invalid cqn %d\n", cq_handle);
+        return -EINVAL;
+    }
+
+    ring = (PvrdmaRing *)cq->opaque;
+    pr_dbg("ring=%p\n", ring);
+
+    /* Step #1: Put CQE on CQ ring */
+    pr_dbg("Writing CQE\n");
+    cqe1 = pvrdma_ring_next_elem_write(ring);
+    if (unlikely(!cqe1)) {
+        return -EINVAL;
+    }
+
+    cqe1->wr_id = cqe->wr_id;
+    cqe1->qp = cqe->qp;
+    cqe1->opcode = cqe->opcode;
+    cqe1->status = cqe->status;
+    cqe1->vendor_err = cqe->vendor_err;
+
+    pvrdma_ring_write_inc(ring);
+
+    /* Step #2: Put CQ number on dsr completion ring */
+    pr_dbg("Writing CQNE\n");
+    cqne = pvrdma_ring_next_elem_write(&dev->dsr_info.cq);
+    if (unlikely(!cqne)) {
+        return -EINVAL;
+    }
+
+    cqne->info = cq_handle;
+    pvrdma_ring_write_inc(&dev->dsr_info.cq);
+
+    pr_dbg("cq->notify=%d\n", cq->notify);
+    if (cq->notify) {
+        cq->notify = false;
+        post_interrupt(dev, INTR_VEC_CMD_COMPLETION_Q);
+    }
+
+    return 0;
+}
+
+static void pvrdma_qp_ops_comp_handler(int status, unsigned int vendor_err,
+                                       void *ctx)
+{
+    CompHandlerCtx *comp_ctx = (CompHandlerCtx *)ctx;
+
+    pr_dbg("cq_handle=%d\n", comp_ctx->cq_handle);
+    pr_dbg("wr_id=%lld\n", comp_ctx->cqe.wr_id);
+    pr_dbg("status=%d\n", status);
+    pr_dbg("vendor_err=0x%x\n", vendor_err);
+    comp_ctx->cqe.status = status;
+    comp_ctx->cqe.vendor_err = vendor_err;
+    pvrdma_post_cqe(comp_ctx->dev, comp_ctx->cq_handle, &comp_ctx->cqe);
+    free(ctx);
+}
+
+void pvrdma_qp_ops_fini(void)
+{
+    rdma_backend_unregister_comp_handler();
+}
+
+int pvrdma_qp_ops_init(void)
+{
+    rdma_backend_register_comp_handler(pvrdma_qp_ops_comp_handler);
+
+    return 0;
+}
+
+int pvrdma_qp_send(PVRDMADev *dev, __u32 qp_handle)
+{
+    RdmaRmQP *qp;
+    PvrdmaSqWqe *wqe;
+    PvrdmaRing *ring;
+
+    qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
+    if (unlikely(!qp)) {
+        return -EINVAL;
+    }
+
+    ring = (PvrdmaRing *)qp->opaque;
+    pr_dbg("sring=%p\n", ring);
+
+    if (qp->qp_state < IBV_QPS_RTS) {
+        pr_dbg("Invalid QP state for send (%d < %d) for qp %d\n", qp->qp_state,
+               IBV_QPS_RTS, qp_handle);
+        return -EINVAL;
+    }
+
+    wqe = (struct PvrdmaSqWqe *)pvrdma_ring_next_elem_read(ring);
+    while (wqe) {
+        CompHandlerCtx *comp_ctx;
+
+        pr_dbg("wr_id=%lld\n", wqe->hdr.wr_id);
+
+        /* Prepare CQE */
+        comp_ctx = malloc(sizeof(CompHandlerCtx));
+        comp_ctx->dev = dev;
+        comp_ctx->cq_handle = qp->send_cq_handle;
+        comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
+        comp_ctx->cqe.qp = qp_handle;
+        comp_ctx->cqe.opcode = wqe->hdr.opcode;
+
+        rdma_backend_post_send(&dev->backend_dev, &dev->rdma_dev_res,
+                               &qp->backend_qp, qp->qp_type,
+                               (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
+                               (union ibv_gid *)wqe->hdr.wr.ud.av.dgid,
+                               wqe->hdr.wr.ud.remote_qpn,
+                               wqe->hdr.wr.ud.remote_qkey, comp_ctx);
+
+        pvrdma_ring_read_inc(ring);
+
+        wqe = pvrdma_ring_next_elem_read(ring);
+    }
+
+    return 0;
+}
+
+int pvrdma_qp_recv(PVRDMADev *dev, __u32 qp_handle)
+{
+    RdmaRmQP *qp;
+    PvrdmaRqWqe *wqe;
+    PvrdmaRing *ring;
+
+    pr_dbg("qp_handle=%d\n", qp_handle);
+
+    qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
+    if (unlikely(!qp)) {
+        return -EINVAL;
+    }
+
+    ring = &((PvrdmaRing *)qp->opaque)[1];
+    pr_dbg("rring=%p\n", ring);
+
+    wqe = (struct PvrdmaRqWqe *)pvrdma_ring_next_elem_read(ring);
+    while (wqe) {
+        CompHandlerCtx *comp_ctx;
+
+        pr_dbg("wr_id=%lld\n", wqe->hdr.wr_id);
+
+        /* Prepare CQE */
+        comp_ctx = malloc(sizeof(CompHandlerCtx));
+        comp_ctx->dev = dev;
+        comp_ctx->cq_handle = qp->recv_cq_handle;
+        comp_ctx->cqe.qp = qp_handle;
+        comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
+
+        rdma_backend_post_recv(&dev->backend_dev, &dev->rdma_dev_res,
+                               &qp->backend_qp, qp->qp_type,
+                               (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
+                               comp_ctx);
+
+        pvrdma_ring_read_inc(ring);
+
+        wqe = pvrdma_ring_next_elem_read(ring);
+    }
+
+    return 0;
+}
+
+void pvrdma_cq_poll(RdmaDeviceResources *dev_res, __u32 cq_handle)
+{
+    RdmaRmCQ *cq;
+
+    cq = rdma_rm_get_cq(dev_res, cq_handle);
+    if (!cq) {
+        pr_dbg("Invalid CQ# %d\n", cq_handle);
+    }
+
+    rdma_backend_poll_cq(dev_res, &cq->backend_cq);
+}
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.h b/hw/rdma/vmw/pvrdma_qp_ops.h
new file mode 100644
index 0000000000..61ec036835
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma_qp_ops.h
@@ -0,0 +1,27 @@
+/*
+ * QEMU VMWARE paravirtual RDMA QP Operations
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef PVRDMA_QP_H
+#define PVRDMA_QP_H
+
+#include "pvrdma.h"
+
+int pvrdma_qp_ops_init(void);
+void pvrdma_qp_ops_fini(void);
+int pvrdma_qp_send(PVRDMADev *dev, __u32 qp_handle);
+int pvrdma_qp_recv(PVRDMADev *dev, __u32 qp_handle);
+void pvrdma_cq_poll(RdmaDeviceResources *dev_res, __u32 cq_handle);
+
+#endif
diff --git a/hw/rdma/vmw/pvrdma_ring.h b/hw/rdma/vmw/pvrdma_ring.h
new file mode 100644
index 0000000000..c616cc586c
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma_ring.h
@@ -0,0 +1,134 @@
+/*
+ * Copyright (c) 2012-2016 VMware, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of EITHER the GNU General Public License
+ * version 2 as published by the Free Software Foundation or the BSD
+ * 2-Clause License. This program is distributed in the hope that it
+ * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
+ * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
+ * See the GNU General Public License version 2 for more details at
+ * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program available in the file COPYING in the main
+ * directory of this source tree.
+ *
+ * The BSD 2-Clause License
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+ * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
+ * OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef PVRDMA_RING_H
+#define PVRDMA_RING_H
+
+#include <qemu/atomic.h>
+#include <linux/types.h>
+
+#define PVRDMA_INVALID_IDX -1 /* Invalid index. */
+
+struct pvrdma_ring {
+    int prod_tail;  /* Producer tail. */
+    int cons_head;  /* Consumer head. */
+};
+
+struct pvrdma_ring_state {
+    struct pvrdma_ring tx; /* Tx ring. */
+    struct pvrdma_ring rx; /* Rx ring. */
+};
+
+static inline int pvrdma_idx_valid(__u32 idx, __u32 max_elems)
+{
+    /* Generates fewer instructions than a less-than. */
+    return (idx & ~((max_elems << 1) - 1)) == 0;
+}
+
+static inline __s32 pvrdma_idx(int *var, __u32 max_elems)
+{
+    const unsigned int idx = atomic_read(var);
+
+    if (pvrdma_idx_valid(idx, max_elems)) {
+        return idx & (max_elems - 1);
+    }
+    return PVRDMA_INVALID_IDX;
+}
+
+static inline void pvrdma_idx_ring_inc(int *var, __u32 max_elems)
+{
+    __u32 idx = atomic_read(var) + 1; /* Increment. */
+
+    idx &= (max_elems << 1) - 1; /* Modulo size, flip gen. */
+    atomic_set(var, idx);
+}
+
+static inline __s32 pvrdma_idx_ring_has_space(const struct pvrdma_ring *r,
+                                              __u32 max_elems, __u32 *out_tail)
+{
+    const __u32 tail = atomic_read(&r->prod_tail);
+    const __u32 head = atomic_read(&r->cons_head);
+
+    if (pvrdma_idx_valid(tail, max_elems) &&
+        pvrdma_idx_valid(head, max_elems)) {
+        *out_tail = tail & (max_elems - 1);
+        return tail != (head ^ max_elems);
+    }
+    return PVRDMA_INVALID_IDX;
+}
+
+static inline __s32 pvrdma_idx_ring_has_data(const struct pvrdma_ring *r,
+                                             __u32 max_elems, __u32 *out_head)
+{
+    const __u32 tail = atomic_read(&r->prod_tail);
+    const __u32 head = atomic_read(&r->cons_head);
+
+    if (pvrdma_idx_valid(tail, max_elems) &&
+        pvrdma_idx_valid(head, max_elems)) {
+        *out_head = head & (max_elems - 1);
+        return tail != head;
+    }
+    return PVRDMA_INVALID_IDX;
+}
+
+static inline bool pvrdma_idx_ring_is_valid_idx(const struct pvrdma_ring *r,
+                                                __u32 max_elems, __u32 *idx)
+{
+    const __u32 tail = atomic_read(&r->prod_tail);
+    const __u32 head = atomic_read(&r->cons_head);
+
+    if (pvrdma_idx_valid(tail, max_elems) &&
+        pvrdma_idx_valid(head, max_elems) &&
+        pvrdma_idx_valid(*idx, max_elems)) {
+        if (tail > head && (*idx < tail && *idx >= head)) {
+            return true;
+        } else if (head > tail && (*idx >= head || *idx < tail)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+#endif /* PVRDMA_RING_H */
diff --git a/hw/rdma/vmw/pvrdma_types.h b/hw/rdma/vmw/pvrdma_types.h
new file mode 100644
index 0000000000..6cd2c81019
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma_types.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU VMWARE paravirtual RDMA interface definitions
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef PVRDMA_TYPES_H
+#define PVRDMA_TYPES_H
+
+/* TDOD: All defs here should be removed !!! */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <asm-generic/int-ll64.h>
+#include <include/sysemu/dma.h>
+#include <linux/types.h>
+
+typedef unsigned char uint8_t;
+typedef uint8_t           u8;
+typedef u8                __u8;
+typedef unsigned short    u16;
+typedef u16               __u16;
+typedef uint32_t          u32;
+typedef u32               __u32;
+typedef int32_t           __s32;
+typedef uint64_t          u64;
+typedef __u64 __bitwise   __be64;
+
+#endif
diff --git a/hw/rdma/vmw/pvrdma_utils.c b/hw/rdma/vmw/pvrdma_utils.c
new file mode 100644
index 0000000000..a84a2819d3
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma_utils.c
@@ -0,0 +1,135 @@
+#include <qemu/osdep.h>
+#include <qemu/error-report.h>
+
+#include <cpu.h>
+#include "../rdma_utils.h"
+#include "pvrdma_utils.h"
+
+void pvrdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len)
+{
+    pr_dbg("%p\n", buffer);
+    if (buffer) {
+        pci_dma_unmap(dev, buffer, len, DMA_DIRECTION_TO_DEVICE, 0);
+    }
+}
+
+void *pvrdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen)
+{
+    void *p;
+    hwaddr len = plen;
+
+    if (!addr) {
+        pr_dbg("addr is NULL\n");
+        return NULL;
+    }
+
+    p = pci_dma_map(dev, addr, &len, DMA_DIRECTION_TO_DEVICE);
+    if (!p) {
+        pr_dbg("Fail in pci_dma_map, addr=0x%llx, len=%ld\n",
+               (long long unsigned int)addr, len);
+        return NULL;
+    }
+
+    if (len != plen) {
+        pvrdma_pci_dma_unmap(dev, p, len);
+        return NULL;
+    }
+
+    pr_dbg("0x%llx -> %p (len=%ld)\n", (long long unsigned int)addr, p, len);
+
+    return p;
+}
+
+void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma, uint32_t nchunks,
+                         size_t length)
+{
+    uint64_t *dir = NULL, *tbl = NULL;
+    int tbl_idx, dir_idx, addr_idx;
+    void *host_virt = NULL, *curr_page;
+
+    if (!nchunks) {
+        pr_dbg("nchunks=0\n");
+        goto out;
+    }
+
+    dir = pvrdma_pci_dma_map(pdev, pdir_dma, TARGET_PAGE_SIZE);
+    if (!dir) {
+        error_report("PVRDMA: Fail to map to page directory");
+        goto out;
+    }
+
+    tbl = pvrdma_pci_dma_map(pdev, dir[0], TARGET_PAGE_SIZE);
+    if (!tbl) {
+        error_report("PVRDMA: Fail to map to page table 0");
+        goto out_unmap_dir;
+    }
+
+    curr_page = pvrdma_pci_dma_map(pdev, (dma_addr_t)tbl[0], TARGET_PAGE_SIZE);
+    if (!curr_page) {
+        error_report("PVRDMA: Fail to map the first page");
+        goto out_unmap_tbl;
+    }
+
+    host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
+    if (host_virt == MAP_FAILED) {
+        host_virt = NULL;
+        error_report("PVRDMA: Fail to remap memory for host_virt");
+        goto out_unmap_tbl;
+    }
+
+    pvrdma_pci_dma_unmap(pdev, curr_page, TARGET_PAGE_SIZE);
+
+    pr_dbg("host_virt=%p\n", host_virt);
+
+    dir_idx = 0;
+    tbl_idx = 1;
+    addr_idx = 1;
+    while (addr_idx < nchunks) {
+        if ((tbl_idx == (TARGET_PAGE_SIZE / sizeof(uint64_t)))) {
+            tbl_idx = 0;
+            dir_idx++;
+            pr_dbg("Mapping to table %d\n", dir_idx);
+            pvrdma_pci_dma_unmap(pdev, tbl, TARGET_PAGE_SIZE);
+            tbl = pvrdma_pci_dma_map(pdev, dir[dir_idx], TARGET_PAGE_SIZE);
+            if (!tbl) {
+                error_report("PVRDMA: Fail to map to page table %d", dir_idx);
+                goto out_unmap_host_virt;
+            }
+        }
+
+        pr_dbg("guest_dma[%d]=0x%lx\n", addr_idx, tbl[tbl_idx]);
+
+        curr_page = pvrdma_pci_dma_map(pdev, (dma_addr_t)tbl[tbl_idx],
+                                       TARGET_PAGE_SIZE);
+        if (!curr_page) {
+            error_report("PVRDMA: Fail to map to page %d, dir %d", tbl_idx,
+                         dir_idx);
+            goto out_unmap_host_virt;
+        }
+
+        mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
+               host_virt + TARGET_PAGE_SIZE * addr_idx);
+
+        pvrdma_pci_dma_unmap(pdev, curr_page, TARGET_PAGE_SIZE);
+
+        addr_idx++;
+
+        tbl_idx++;
+    }
+
+    goto out_unmap_tbl;
+
+out_unmap_host_virt:
+    munmap(host_virt, length);
+    host_virt = NULL;
+
+out_unmap_tbl:
+    pvrdma_pci_dma_unmap(pdev, tbl, TARGET_PAGE_SIZE);
+
+out_unmap_dir:
+    pvrdma_pci_dma_unmap(pdev, dir, TARGET_PAGE_SIZE);
+
+out:
+    return host_virt;
+
+}
diff --git a/hw/rdma/vmw/pvrdma_utils.h b/hw/rdma/vmw/pvrdma_utils.h
new file mode 100644
index 0000000000..d0d902b24d
--- /dev/null
+++ b/hw/rdma/vmw/pvrdma_utils.h
@@ -0,0 +1,26 @@
+/*
+ * QEMU VMWARE paravirtual RDMA address mapping utilities
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef PVRDMA_UTILS_H
+#define PVRDMA_UTILS_H
+
+#include <include/hw/pci/pci.h>
+
+void pvrdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);
+void *pvrdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen);
+void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma, uint32_t nchunks,
+                         size_t length);
+
+#endif
diff --git a/hw/rdma/vmw/trace-events b/hw/rdma/vmw/trace-events
new file mode 100644
index 0000000000..dd4dde311e
--- /dev/null
+++ b/hw/rdma/vmw/trace-events
@@ -0,0 +1,5 @@
+# See docs/tracing.txt for syntax documentation.
+
+# hw/rdma/vmw/pvrdma_main.c
+pvrdma_regs_read(uint64_t addr, uint64_t val) "regs[0x%lx] = 0x%lx"
+pvrdma_regs_write(uint64_t addr, uint64_t val) "regs[0x%lx] = 0x%lx"
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 35df1874a9..1dbf53627c 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -266,4 +266,7 @@
 #define PCI_VENDOR_ID_TEWS               0x1498
 #define PCI_DEVICE_ID_TEWS_TPCI200       0x30C8
 
+#define PCI_VENDOR_ID_VMWARE             0x15ad
+#define PCI_DEVICE_ID_VMWARE_PVRDMA      0x0820
+
 #endif
-- 
2.13.5
