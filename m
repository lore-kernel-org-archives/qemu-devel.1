Received: from eggs.gnu.org ([2001:4830:134:3::10]:47854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1em2e5-0003Mp-BT
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:23:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1em2e0-0008Kn-QE
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:23:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1em2e0-0008KU-GD
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:23:04 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 14 Feb 2018 21:22:27 +0200
Message-Id: <20180214192230.70287-8-marcel@redhat.com>
In-Reply-To: <20180214192230.70287-1-marcel@redhat.com>
References: <20180214192230.70287-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V11 07/10] hw/rdma: Implementation of generic
 rdma device layers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, mst@redhat.com, dotanb@mellanox.com, yanjun.zhu@oracle.com, ghammer@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

This layer is composed of two sub-modules, backend and resource manager.
Backend sub-module is responsible for all the interaction with IB layers
such as ibverbs and umad (external libraries).
Resource manager is a collection of functions and structures to manage
RDMA resources such as QPs, CQs and MRs.

Reviewed-by: Dotan Barak <dotanb@mellanox.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 Makefile.objs          |   1 +
 configure              |   9 +-
 hw/rdma/Makefile.objs  |   2 +-
 hw/rdma/rdma_backend.c | 818 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/rdma/rdma_backend.h |  98 ++++++
 hw/rdma/rdma_rm.c      | 544 ++++++++++++++++++++++++++++++++
 hw/rdma/rdma_rm.h      |  69 +++++
 hw/rdma/trace-events   |   5 +
 8 files changed, 1541 insertions(+), 5 deletions(-)
 create mode 100644 hw/rdma/rdma_backend.c
 create mode 100644 hw/rdma/rdma_backend.h
 create mode 100644 hw/rdma/rdma_rm.c
 create mode 100644 hw/rdma/rdma_rm.h
 create mode 100644 hw/rdma/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 2efba6d768..f3a3d28304 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -130,6 +130,7 @@ trace-events-subdirs += hw/block/dataplane
 trace-events-subdirs += hw/char
 trace-events-subdirs += hw/intc
 trace-events-subdirs += hw/net
+trace-events-subdirs += hw/rdma
 trace-events-subdirs += hw/virtio
 trace-events-subdirs += hw/audio
 trace-events-subdirs += hw/misc
diff --git a/configure b/configure
index 913e14839d..ed45a3c4dd 100755
--- a/configure
+++ b/configure
@@ -1572,7 +1572,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   hax             HAX acceleration support
   hvf             Hypervisor.framework acceleration support
   whpx            Windows Hypervisor Platform acceleration support
-  rdma            RDMA-based migration support
+  rdma            Enable RDMA-based migration and PVRDMA support
   vde             support for vde network
   netmap          support for netmap network
   linux-aio       Linux AIO support
@@ -2923,15 +2923,16 @@ if test "$rdma" != "no" ; then
 #include <rdma/rdma_cma.h>
 int main(void) { return 0; }
 EOF
-  rdma_libs="-lrdmacm -libverbs"
+  rdma_libs="-lrdmacm -libverbs -libumad"
   if compile_prog "" "$rdma_libs" ; then
     rdma="yes"
+    libs_softmmu="$libs_softmmu $rdma_libs"
   else
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
diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
index cdffe4a9a3..6a59bf0d5b 100644
--- a/hw/rdma/Makefile.objs
+++ b/hw/rdma/Makefile.objs
@@ -1,3 +1,3 @@
 ifeq ($(CONFIG_RDMA),y)
-obj-$(CONFIG_PCI) += rdma_utils.o
+obj-$(CONFIG_PCI) += rdma_utils.o rdma_backend.o rdma_rm.o
 endif
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
new file mode 100644
index 0000000000..e306fba534
--- /dev/null
+++ b/hw/rdma/rdma_backend.c
@@ -0,0 +1,818 @@
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
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
+#define THR_NAME_LEN 16
+
+typedef struct BackendCtx {
+    uint64_t req_id;
+    void *up_ctx;
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
+static void poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
+{
+    int i, ne;
+    BackendCtx *bctx;
+    struct ibv_wc wc[2];
+
+    pr_dbg("Entering poll_cq loop on cq %p\n", ibcq);
+    do {
+        ne = ibv_poll_cq(ibcq, ARRAY_SIZE(wc), wc);
+
+        pr_dbg("Got %d completion(s) from cq %p\n", ne, ibcq);
+
+        for (i = 0; i < ne; i++) {
+            pr_dbg("wr_id=0x%lx\n", wc[i].wr_id);
+            pr_dbg("status=%d\n", wc[i].status);
+
+            bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
+            if (unlikely(!bctx)) {
+                pr_dbg("Error: Failed to find ctx for req %ld\n", wc[i].wr_id);
+                continue;
+            }
+            pr_dbg("Processing %s CQE\n", bctx->is_tx_req ? "send" : "recv");
+
+            comp_handler(wc[i].status, wc[i].vendor_err, bctx->up_ctx);
+
+            rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
+            g_free(bctx);
+        }
+    } while (ne > 0);
+
+    if (ne < 0) {
+        pr_dbg("Got error %d from ibv_poll_cq\n", ne);
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
+        rc = ibv_req_notify_cq(ev_cq, 0);
+        if (unlikely(rc)) {
+            pr_dbg("Error %d from ibv_req_notify_cq\n", rc);
+        }
+
+        poll_cq(backend_dev->rdma_dev_res, ev_cq);
+
+        ibv_ack_cq_events(ev_cq, 1);
+    }
+
+    pr_dbg("Going down\n");
+
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
+    poll_cq(rdma_dev_res, cq->ibcq);
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
+            g_bytes_unref(ah_key);
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
+
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
+
+    pr_dbg("num_sge=%d\n", num_sge);
+
+    for (ssge_idx = 0; ssge_idx < num_sge; ssge_idx++) {
+        mr = rdma_rm_get_mr(rdma_dev_res, ssge[ssge_idx].lkey);
+        if (unlikely(!mr)) {
+            pr_dbg("Invalid lkey 0x%x\n", ssge[ssge_idx].lkey);
+            return VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
+        }
+
+        dsge->addr = mr->user_mr.host_virt + ssge[ssge_idx].addr -
+                     mr->user_mr.guest_start;
+        dsge->length = ssge[ssge_idx].length;
+        dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
+
+        pr_dbg("ssge->addr=0x%lx\n", (uint64_t)ssge[ssge_idx].addr);
+        pr_dbg("dsge->addr=0x%lx\n", dsge->addr);
+        pr_dbg("dsge->length=%d\n", dsge->length);
+        pr_dbg("dsge->lkey=0x%x\n", dsge->lkey);
+
+        dsge++;
+    }
+
+    return 0;
+}
+
+void rdma_backend_post_send(RdmaBackendDev *backend_dev,
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
+    if (!qp->ibqp) { /* This field does not get initialized for QP0 and QP1 */
+        if (qp_type == IBV_QPT_SMI) {
+            pr_dbg("QP0 unsupported\n");
+            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
+        } else if (qp_type == IBV_QPT_GSI) {
+            pr_dbg("QP1\n");
+            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
+        }
+        pr_dbg("qp->ibqp is NULL for qp_type %d!!!\n", qp_type);
+        return;
+    }
+
+    pr_dbg("num_sge=%d\n", num_sge);
+    if (!num_sge) {
+        pr_dbg("num_sge=0\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
+        return;
+    }
+
+    bctx = g_malloc0(sizeof(*bctx));
+    bctx->up_ctx = ctx;
+    bctx->is_tx_req = 1;
+
+    rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
+    if (unlikely(rc)) {
+        pr_dbg("Failed to allocate cqe_ctx\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        goto out_free_bctx;
+    }
+
+    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge);
+    if (rc) {
+        pr_dbg("Error: Failed to build host SGE array\n");
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
+    wr.sg_list = new_sge;
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
+    rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, bctx_id);
+
+out_free_bctx:
+    g_free(bctx);
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
+    if (!qp->ibqp) { /* This field does not get initialized for QP0 and QP1 */
+        if (qp_type == IBV_QPT_SMI) {
+            pr_dbg("QP0 unsupported\n");
+            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
+        }
+        if (qp_type == IBV_QPT_GSI) {
+            pr_dbg("QP1\n");
+            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
+        }
+        return;
+    }
+
+    pr_dbg("num_sge=%d\n", num_sge);
+    if (!num_sge) {
+        pr_dbg("num_sge=0\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
+        return;
+    }
+
+    bctx = g_malloc0(sizeof(*bctx));
+    bctx->up_ctx = ctx;
+    bctx->is_tx_req = 0;
+
+    rc = rdma_rm_alloc_cqe_ctx(rdma_dev_res, &bctx_id, bctx);
+    if (unlikely(rc)) {
+        pr_dbg("Failed to allocate cqe_ctx\n");
+        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        goto out_free_bctx;
+    }
+
+    rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge);
+    if (rc) {
+        pr_dbg("Error: Failed to build host SGE array\n");
+        comp_handler(IBV_WC_GENERAL_ERR, rc, ctx);
+        goto out_dealloc_cqe_ctx;
+    }
+
+    wr.num_sge = num_sge;
+    wr.sg_list = new_sge;
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
+    g_free(bctx);
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
+    mr->ibmr = ibv_reg_mr(pd->ibpd, (void *)addr, length, access);
+    if (mr->ibmr) {
+        pr_dbg("lkey=0x%x\n", mr->ibmr->lkey);
+        pr_dbg("rkey=0x%x\n", mr->ibmr->rkey);
+        mr->ibpd = pd->ibpd;
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
+    int rc;
+
+    pr_dbg("cqe=%d\n", cqe);
+
+    pr_dbg("dev->channel=%p\n", backend_dev->channel);
+    cq->ibcq = ibv_create_cq(backend_dev->context, cqe + 1, NULL,
+                             backend_dev->channel, 0);
+
+    if (cq->ibcq) {
+        rc = ibv_req_notify_cq(cq->ibcq, 0);
+        if (rc) {
+            pr_dbg("Error %d from ibv_req_notify_cq\n", rc);
+        }
+        cq->backend_dev = backend_dev;
+    }
+
+    return cq->ibcq ? 0 : -EIO;
+}
+
+void rdma_backend_destroy_cq(RdmaBackendCQ *cq)
+{
+    if (cq->ibcq) {
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
+    switch (qp_type) {
+    case IBV_QPT_GSI:
+        pr_dbg("QP1 unsupported\n");
+        return 0;
+
+    case IBV_QPT_RC:
+        /* fall through */
+    case IBV_QPT_UD:
+        /* do nothing */
+        break;
+
+    default:
+        pr_dbg("Unsupported QP type %d\n", qp_type);
+        return -EIO;
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
+    qp->ibqp = ibv_create_qp(pd->ibpd, &attr);
+    if (likely(!qp->ibqp)) {
+        pr_dbg("Error from ibv_create_qp\n");
+        return -EIO;
+    }
+
+    qp->ibpd = pd->ibpd;
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
+
+    switch (qp_type) {
+    case IBV_QPT_RC:
+        attr_mask |= IBV_QP_ACCESS_FLAGS;
+        break;
+
+    case IBV_QPT_UD:
+        attr.qkey = qkey;
+        attr_mask |= IBV_QP_QKEY;
+        break;
+
+    default:
+        pr_dbg("Unsupported QP type %d\n", qp_type);
+        return -EIO;
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
+                              uint32_t dqpn, uint32_t rq_psn, uint32_t qkey,
+                              bool use_qkey)
+{
+    struct ibv_qp_attr attr = {0};
+    union ibv_gid ibv_gid = {
+        .global.interface_id = dgid->global.interface_id,
+        .global.subnet_prefix = dgid->global.subnet_prefix
+    };
+    int rc, attr_mask;
+
+    attr.qp_state = IBV_QPS_RTR;
+    attr_mask = IBV_QP_STATE;
+
+    switch (qp_type) {
+    case IBV_QPT_RC:
+        pr_dbg("dgid=0x%lx,%lx\n",
+               be64_to_cpu(ibv_gid.global.subnet_prefix),
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
+        break;
+
+    case IBV_QPT_UD:
+        if (use_qkey) {
+            pr_dbg("qkey=0x%x\n", qkey);
+            attr.qkey = qkey;
+            attr_mask |= IBV_QP_QKEY;
+        }
+        break;
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
+                              uint32_t sq_psn, uint32_t qkey, bool use_qkey)
+{
+    struct ibv_qp_attr attr = {0};
+    int rc, attr_mask;
+
+    pr_dbg("qpn=0x%x\n", qp->ibqp->qp_num);
+    pr_dbg("sq_psn=0x%x\n", sq_psn);
+
+    attr.qp_state = IBV_QPS_RTS;
+    attr.sq_psn = sq_psn;
+    attr_mask = IBV_QP_STATE | IBV_QP_SQ_PSN;
+
+    switch (qp_type) {
+    case IBV_QPT_RC:
+        attr.timeout       = 14;
+        attr.retry_cnt     = 7;
+        attr.rnr_retry     = 7;
+        attr.max_rd_atomic = 1;
+
+        attr_mask |= IBV_QP_TIMEOUT | IBV_QP_RETRY_CNT | IBV_QP_RNR_RETRY |
+                     IBV_QP_MAX_QP_RD_ATOMIC;
+        break;
+
+    case IBV_QPT_UD:
+        if (use_qkey) {
+            pr_dbg("qkey=0x%x\n", qkey);
+            attr.qkey = qkey;
+            attr_mask |= IBV_QP_QKEY;
+        }
+        break;
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
+        warn_report("%s = 0x%lx is higher than host device capability 0x%lx", \
+                    #member, (uint64_t)req->member, (uint64_t)dev.member); \
+        req->member = dev.member; \
+    } \
+    pr_dbg("%s="fmt"\n", #member, req->member); })
+
+static int init_device_caps(RdmaBackendDev *backend_dev,
+                            struct ibv_device_attr *dev_attr)
+{
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
+    char thread_name[THR_NAME_LEN] = {0};
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
+        return -EIO;
+    }
+
+    if (num_ibv_devices == 0) {
+        error_setg(errp, "No IB devices were found");
+        ret = -ENXIO;
+        goto out_free_dev_list;
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
+            goto out_free_dev_list;
+        }
+    } else {
+        backend_dev->ib_dev = *dev_list;
+    }
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
+    ret = ibv_query_port(backend_dev->context, backend_dev->port_num,
+                         &port_attr);
+    if (ret) {
+        error_setg(errp, "Error %d from ibv_query_port", ret);
+        ret = -EIO;
+        goto out_destroy_comm_channel;
+    }
+
+    if (backend_dev->backend_gid_idx > port_attr.gid_tbl_len) {
+        error_setg(errp, "Invalid backend_gid_idx, should be less than %d",
+                   port_attr.gid_tbl_len);
+        goto out_destroy_comm_channel;
+    }
+
+    ret = init_device_caps(backend_dev, dev_attr);
+    if (ret) {
+        error_setg(errp, "Failed to initialize device capabilities");
+        ret = -EIO;
+        goto out_destroy_comm_channel;
+    }
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
+    snprintf(thread_name, sizeof(thread_name), "rdma_comp_%s",
+             ibv_get_device_name(backend_dev->ib_dev));
+    backend_dev->comp_thread.run = true;
+    qemu_thread_create(&backend_dev->comp_thread.thread, thread_name,
+                       comp_handler_thread, backend_dev, QEMU_THREAD_DETACHED);
+
+    ah_cache_init();
+
+    goto out_free_dev_list;
+
+out_destroy_comm_channel:
+    ibv_destroy_comp_channel(backend_dev->channel);
+
+out_close_device:
+    ibv_close_device(backend_dev->context);
+
+out_free_dev_list:
+    ibv_free_device_list(dev_list);
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
index 0000000000..68f2b05ca7
--- /dev/null
+++ b/hw/rdma/rdma_backend.h
@@ -0,0 +1,98 @@
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
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
+/* Add definition for QP0 and QP1 as there is no userspace enums for them */
+enum ibv_special_qp_type {
+    IBV_QPT_SMI = 0,
+    IBV_QPT_GSI = 1,
+};
+
+static inline union ibv_gid *rdma_backend_gid(RdmaBackendDev *dev)
+{
+    return &dev->gid;
+}
+
+static inline uint32_t rdma_backend_qpn(const RdmaBackendQP *qp)
+{
+    return qp->ibqp ? qp->ibqp->qp_num : 0;
+}
+
+static inline uint32_t rdma_backend_mr_lkey(const RdmaBackendMR *mr)
+{
+    return mr->ibmr ? mr->ibmr->lkey : 0;
+}
+
+static inline uint32_t rdma_backend_mr_rkey(const RdmaBackendMR *mr)
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
+                              uint32_t dqpn, uint32_t rq_psn, uint32_t qkey,
+                              bool use_qkey);
+int rdma_backend_qp_state_rts(RdmaBackendQP *qp, uint8_t qp_type,
+                              uint32_t sq_psn, uint32_t qkey, bool use_qkey);
+void rdma_backend_destroy_qp(RdmaBackendQP *qp);
+
+void rdma_backend_post_send(RdmaBackendDev *backend_dev,
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
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
new file mode 100644
index 0000000000..b5fc45ddab
--- /dev/null
+++ b/hw/rdma/rdma_rm.c
@@ -0,0 +1,544 @@
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
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
+static inline void res_tbl_init(const char *name, RdmaRmResTbl *tbl,
+                                uint32_t tbl_sz, uint32_t res_sz)
+{
+    tbl->tbl = g_malloc(tbl_sz * res_sz);
+
+    strncpy(tbl->name, name, MAX_RM_TBL_NAME);
+    tbl->name[MAX_RM_TBL_NAME - 1] = 0;
+
+    tbl->bitmap = bitmap_new(tbl_sz);
+    tbl->tbl_sz = tbl_sz;
+    tbl->res_sz = res_sz;
+    qemu_mutex_init(&tbl->lock);
+}
+
+static inline void res_tbl_free(RdmaRmResTbl *tbl)
+{
+    qemu_mutex_destroy(&tbl->lock);
+    g_free(tbl->tbl);
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
+        pr_dbg("Failed to alloc, bitmap is full\n");
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
+        return -EINVAL;
+    }
+
+    mr = res_tbl_alloc(&dev_res->mr_tbl, mr_handle);
+    if (!mr) {
+        pr_dbg("Failed to allocate obj in table\n");
+        return -ENOMEM;
+    }
+
+    if (!host_virt) {
+        /* TODO: This is my guess but not so sure that this needs to be
+         * done */
+        length = TARGET_PAGE_SIZE;
+        addr = (uint64_t)g_malloc(length);
+    } else {
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
+    int rc;
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
+    return 0;
+
+out_dealloc_cq:
+    rdma_rm_dealloc_cq(dev_res, *cq_handle);
+
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
+    int rc;
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
+    qp->qp_state = IBV_QPS_RESET;
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
+    if (qp->qp_type == IBV_QPT_SMI) {
+        pr_dbg("QP0 unsupported\n");
+        return -EPERM;
+    } else if (qp->qp_type == IBV_QPT_GSI) {
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
+            ret = rdma_backend_qp_state_rtr(backend_dev, &qp->backend_qp,
+                                            qp->qp_type, dgid, dqpn, rq_psn,
+                                            qkey, attr_mask & IBV_QP_QKEY);
+            if (ret) {
+                return -EIO;
+            }
+        }
+
+        if (qp->qp_state == IBV_QPS_RTS) {
+            ret = rdma_backend_qp_state_rts(&qp->backend_qp, qp->qp_type,
+                                            sq_psn, qkey,
+                                            attr_mask & IBV_QP_QKEY);
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
+    g_hash_table_remove(dev_res->qp_hash, key);
+    g_bytes_unref(key);
+
+    if (!qp) {
+        return;
+    }
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
+    dev_res->qp_hash = g_hash_table_new_full(g_bytes_hash, g_bytes_equal,
+                                             destroy_qp_hash_key, NULL);
+    if (!dev_res->qp_hash) {
+        return -ENOMEM;
+    }
+
+    res_tbl_init("PD", &dev_res->pd_tbl, dev_attr->max_pd, sizeof(RdmaRmPD));
+    res_tbl_init("CQ", &dev_res->cq_tbl, dev_attr->max_cq, sizeof(RdmaRmCQ));
+    res_tbl_init("MR", &dev_res->mr_tbl, dev_attr->max_mr, sizeof(RdmaRmMR));
+    res_tbl_init("QP", &dev_res->qp_tbl, dev_attr->max_qp, sizeof(RdmaRmQP));
+    res_tbl_init("CQE_CTX", &dev_res->cqe_ctx_tbl, dev_attr->max_qp *
+                       dev_attr->max_qp_wr, sizeof(void *));
+    res_tbl_init("UC", &dev_res->uc_tbl, MAX_UCS, sizeof(RdmaRmUC));
+
+    return 0;
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
index 0000000000..be95c1b0f4
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
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
diff --git a/hw/rdma/trace-events b/hw/rdma/trace-events
new file mode 100644
index 0000000000..c4c202e647
--- /dev/null
+++ b/hw/rdma/trace-events
@@ -0,0 +1,5 @@
+# See docs/tracing.txt for syntax documentation.
+
+#hw/rdma/rdma_backend.c
+create_ah_cache_hit(uint64_t subnet, uint64_t net_id) "subnet = 0x%"PRIx64" net_id = 0x%"PRIx64
+create_ah_cache_miss(uint64_t subnet, uint64_t net_id) "subnet = 0x%"PRIx64" net_id = 0x%"PRIx64
-- 
2.13.5
