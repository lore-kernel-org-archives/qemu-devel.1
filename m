Received: from eggs.gnu.org ([2001:4830:134:3::10]:58997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eQYTc-0006dZ-I7
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 07:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eQYTP-00065f-7C
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 07:55:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eQYTO-00064j-7r
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 07:55:19 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Sun, 17 Dec 2017 14:54:56 +0200
Message-Id: <20171217125457.3429-5-marcel@redhat.com>
In-Reply-To: <20171217125457.3429-1-marcel@redhat.com>
References: <20171217125457.3429-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH V2 4/5] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, pbonzini@redhat.com, mst@redhat.com

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
 Makefile.objs                       |   1 +
 configure                           |   9 +-
 default-configs/arm-softmmu.mak     |   2 +
 default-configs/i386-softmmu.mak    |   1 +
 default-configs/x86_64-softmmu.mak  |   1 +
 hw/net/Makefile.objs                |   7 +
 hw/net/pvrdma/pvrdma.h              | 179 +++++++
 hw/net/pvrdma/pvrdma_backend.c      | 986 ++++++++++++++++++++++++++++++++++++
 hw/net/pvrdma/pvrdma_backend.h      |  74 +++
 hw/net/pvrdma/pvrdma_backend_defs.h |  68 +++
 hw/net/pvrdma/pvrdma_cmd.c          | 338 ++++++++++++
 hw/net/pvrdma/pvrdma_defs.h         | 121 +++++
 hw/net/pvrdma/pvrdma_dev_api.h      | 580 +++++++++++++++++++++
 hw/net/pvrdma/pvrdma_dev_ring.c     | 138 +++++
 hw/net/pvrdma/pvrdma_dev_ring.h     |  42 ++
 hw/net/pvrdma/pvrdma_ib_verbs.h     | 399 +++++++++++++++
 hw/net/pvrdma/pvrdma_main.c         | 664 ++++++++++++++++++++++++
 hw/net/pvrdma/pvrdma_qp_ops.c       | 187 +++++++
 hw/net/pvrdma/pvrdma_qp_ops.h       |  26 +
 hw/net/pvrdma/pvrdma_ring.h         | 134 +++++
 hw/net/pvrdma/pvrdma_rm.c           | 791 +++++++++++++++++++++++++++++
 hw/net/pvrdma/pvrdma_rm.h           |  54 ++
 hw/net/pvrdma/pvrdma_rm_defs.h      | 111 ++++
 hw/net/pvrdma/pvrdma_types.h        |  37 ++
 hw/net/pvrdma/pvrdma_utils.c        | 133 +++++
 hw/net/pvrdma/pvrdma_utils.h        |  41 ++
 hw/net/pvrdma/trace-events          |   9 +
 include/hw/pci/pci_ids.h            |   3 +
 28 files changed, 5132 insertions(+), 4 deletions(-)
 create mode 100644 hw/net/pvrdma/pvrdma.h
 create mode 100644 hw/net/pvrdma/pvrdma_backend.c
 create mode 100644 hw/net/pvrdma/pvrdma_backend.h
 create mode 100644 hw/net/pvrdma/pvrdma_backend_defs.h
 create mode 100644 hw/net/pvrdma/pvrdma_cmd.c
 create mode 100644 hw/net/pvrdma/pvrdma_defs.h
 create mode 100644 hw/net/pvrdma/pvrdma_dev_api.h
 create mode 100644 hw/net/pvrdma/pvrdma_dev_ring.c
 create mode 100644 hw/net/pvrdma/pvrdma_dev_ring.h
 create mode 100644 hw/net/pvrdma/pvrdma_ib_verbs.h
 create mode 100644 hw/net/pvrdma/pvrdma_main.c
 create mode 100644 hw/net/pvrdma/pvrdma_qp_ops.c
 create mode 100644 hw/net/pvrdma/pvrdma_qp_ops.h
 create mode 100644 hw/net/pvrdma/pvrdma_ring.h
 create mode 100644 hw/net/pvrdma/pvrdma_rm.c
 create mode 100644 hw/net/pvrdma/pvrdma_rm.h
 create mode 100644 hw/net/pvrdma/pvrdma_rm_defs.h
 create mode 100644 hw/net/pvrdma/pvrdma_types.h
 create mode 100644 hw/net/pvrdma/pvrdma_utils.c
 create mode 100644 hw/net/pvrdma/pvrdma_utils.h
 create mode 100644 hw/net/pvrdma/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 285c6f3c15..728981be30 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -129,6 +129,7 @@ trace-events-subdirs += hw/block/dataplane
 trace-events-subdirs += hw/char
 trace-events-subdirs += hw/intc
 trace-events-subdirs += hw/net
+trace-events-subdirs += hw/net/pvrdma
 trace-events-subdirs += hw/virtio
 trace-events-subdirs += hw/audio
 trace-events-subdirs += hw/misc
diff --git a/configure b/configure
index 0e856bbc04..83068c5d65 100755
--- a/configure
+++ b/configure
@@ -1523,7 +1523,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   bluez           bluez stack connectivity
   kvm             KVM acceleration support
   hax             HAX acceleration support
-  rdma            RDMA-based migration support
+  rdma            Enable RDMA-based migration support and PVRDMA
   vde             support for vde network
   netmap          support for netmap network
   linux-aio       Linux AIO support
@@ -2847,15 +2847,16 @@ if test "$rdma" != "no" ; then
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
+	    "  (1) Fast: Install infiniband packages (devel) from your distro." \
             "  (2) Cleanest: Install libraries from www.openfabrics.org" \
             "  (3) Also: Install softiwarp if you don't have RDMA hardware"
     fi
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index d37edc4312..51b2052514 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -132,3 +132,5 @@ CONFIG_GPIO_KEY=y
 CONFIG_MSF2=y
 
 CONFIG_FW_CFG_DMA=y
+
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
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index 4171af0b5d..6645495574 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -46,3 +46,10 @@ common-obj-$(CONFIG_ROCKER) += rocker/rocker.o rocker/rocker_fp.o \
                                rocker/rocker_desc.o rocker/rocker_world.o \
                                rocker/rocker_of_dpa.o
 obj-$(call lnot,$(CONFIG_ROCKER)) += rocker/qmp-norocker.o
+
+ifeq ($(CONFIG_RDMA),y)
+obj-$(CONFIG_PVRDMA) += pvrdma/pvrdma_dev_ring.o pvrdma/pvrdma_rm.o \
+                        pvrdma/pvrdma_utils.o pvrdma/pvrdma_qp_ops.o \
+                        pvrdma/pvrdma_backend.o pvrdma/pvrdma_cmd.o \
+                        pvrdma/pvrdma_main.o
+endif
diff --git a/hw/net/pvrdma/pvrdma.h b/hw/net/pvrdma/pvrdma.h
new file mode 100644
index 0000000000..0d63653787
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma.h
@@ -0,0 +1,179 @@
+/*
+ * QEMU VMWARE paravirtual RDMA interface definitions
+ *
+ * Developed by Oracle & Redhat
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
+#include <glib.h>
+#include <rdma/vmw_pvrdma-abi.h>
+#include <infiniband/verbs.h>
+#include <qemu/osdep.h>
+#include <hw/pci/pci.h>
+#include <hw/pci/msix.h>
+#include "pvrdma_backend_defs.h"
+#include "pvrdma_rm_defs.h"
+#include "pvrdma_defs.h"
+#include "pvrdma_dev_api.h"
+#include "pvrdma_ring.h"
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
+typedef struct HWResourceIDs {
+    unsigned long *local_bitmap;
+    __u32 *hw_map;
+} HWResourceIDs;
+
+typedef struct DSRInfo {
+    dma_addr_t dma;
+    struct pvrdma_device_shared_region *dsr;
+
+    union pvrdma_cmd_req *req;
+    union pvrdma_cmd_resp *rsp;
+
+    struct pvrdma_ring *async_ring_state;
+    Ring async;
+
+    struct pvrdma_ring *cq_ring_state;
+    Ring cq;
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
+    RmPort ports[MAX_PORTS];
+    struct ibv_device_attr dev_attr;
+    BackendDevice backend_dev;
+    u64 node_guid;
+    char *backend_device_name;
+    u8 backend_gid_idx;
+    RmResTbl pd_tbl;
+    RmResTbl mr_tbl;
+    RmResTbl uc_tbl;
+    RmResTbl qp_tbl;
+    GHashTable *qp_hash; /* Keeps mapping between real and emulated */
+    RmResTbl cq_tbl;
+    RmResTbl cqe_ctx_tbl;
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
+static inline int get_uar_val(PVRDMADev *dev, hwaddr addr, __u32 *val)
+{
+    int idx = addr >> 2;
+
+    if (idx > RDMA_BAR2_UAR_SIZE) {
+        return -EINVAL;
+    }
+
+    *val = dev->uar_data[idx];
+
+    return 0;
+}
+static inline int set_uar_val(PVRDMADev *dev, hwaddr addr, __u32 val)
+{
+    int idx = addr >> 2;
+
+    if (idx > RDMA_BAR2_UAR_SIZE) {
+        return -EINVAL;
+    }
+
+    dev->uar_data[idx] = val;
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
diff --git a/hw/net/pvrdma/pvrdma_backend.c b/hw/net/pvrdma/pvrdma_backend.c
new file mode 100644
index 0000000000..cdff157790
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_backend.c
@@ -0,0 +1,986 @@
+#include <qemu/osdep.h>
+#include <sys/ioctl.h>
+#include <infiniband/verbs.h>
+#include <infiniband/umad.h>
+
+#include <qemu/error-report.h>
+#include <qapi/qmp/qnum.h>
+#include "qapi/error.h"
+#include <hw/pci/pci.h>
+#include <cpu.h>
+#include <qemu/atomic.h>
+
+#include "trace.h"
+
+#include "pvrdma.h"
+#include "pvrdma_ib_verbs.h"
+#include "pvrdma_rm.h"
+#include "pvrdma_backend.h"
+#include "pvrdma_utils.h"
+
+typedef struct BackendCtx {
+    void *up_ctx;
+    uint64_t req_id;
+    bool is_tx_req;
+} BackendCtx;
+
+static void (*comp_handler)(int status, unsigned int vendor_err,
+                            void *ctx) = 0;
+
+static void poll_cq(PVRDMADev *dev, struct ibv_cq *ibcq, bool one_poll)
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
+        bctx = rm_get_cqe_ctx(dev, wc[i].wr_id);
+        if (unlikely(!bctx)) {
+            pr_dbg("Error: Fail to find ctx for req %ld\n", wc[i].wr_id);
+            continue;
+        }
+        pr_dbg("Processing %s CQE\n", bctx->is_tx_req ? "send" : "recv");
+
+        comp_handler(wc[i].status, wc[i].vendor_err, bctx->up_ctx);
+
+        rm_dealloc_cqe_ctx(dev, wc[i].wr_id);
+        free(bctx);
+    }
+}
+
+static void *mad_handler_thread(void *arg)
+{
+    PVRDMADev *dev = (PVRDMADev *)arg;
+    int rc;
+    QObject *o_ctx_id;
+    unsigned long cqe_ctx_id;
+    BackendCtx *bctx;
+    /*
+    int len;
+    void *mad;
+    */
+
+    pr_dbg("Starting\n");
+
+    dev->backend_dev.mad_thread.run = false;
+
+    while (dev->backend_dev.mad_thread.run) {
+        /* Get next buffer to pust MAD into */
+        o_ctx_id = qlist_pop(dev->backend_dev.mad_agent.recv_mads_list);
+        if (!o_ctx_id) {
+            /* pr_dbg("Error: No more free MADs buffers\n"); */
+            sleep(5);
+            continue;
+        }
+        cqe_ctx_id = qnum_get_uint(qobject_to_qnum(o_ctx_id));
+        bctx = rm_get_cqe_ctx(dev, cqe_ctx_id);
+        if (unlikely(!bctx)) {
+            pr_dbg("Error: Fail to find ctx for %ld\n", cqe_ctx_id);
+            continue;
+        }
+
+        pr_dbg("Calling umad_recv\n");
+        /*
+        mad = pvrdma_pci_dma_map(PCI_DEVICE(dev), bctx->req.sge[0].addr,
+                                 bctx->req.sge[0].length);
+
+        len = bctx->req.sge[0].length;
+
+        do {
+            rc = umad_recv(dev->backend_dev.mad_agent.port_id, mad, &len, 5000);
+        } while ( (rc != ETIMEDOUT) && dev->backend_dev.mad_thread.run);
+        pr_dbg("umad_recv, rc=%d\n", rc);
+
+        pvrdma_pci_dma_unmap(PCI_DEVICE(dev), mad, bctx->req.sge[0].length);
+        */
+        rc = -1;
+
+        /* rc is used as vendor_err */
+        comp_handler(rc > 0 ? IB_WC_SUCCESS : IB_WC_GENERAL_ERR, rc,
+                     bctx->up_ctx);
+
+        rm_dealloc_cqe_ctx(dev, cqe_ctx_id);
+        free(bctx);
+    }
+
+    pr_dbg("Going down\n");
+    /* TODO: Post cqe for all remaining MADs in list */
+
+    qlist_destroy_obj(QOBJECT(dev->backend_dev.mad_agent.recv_mads_list));
+
+    return NULL;
+}
+
+static void *comp_handler_thread(void *arg)
+{
+    PVRDMADev *dev = (PVRDMADev *)arg;
+    int rc;
+    struct ibv_cq *ev_cq;
+    void *ev_ctx;
+
+    pr_dbg("Starting\n");
+
+    while (dev->backend_dev.comp_thread.run) {
+        pr_dbg("Waiting for completion on channel %p\n",
+               dev->backend_dev.channel);
+        rc = ibv_get_cq_event(dev->backend_dev.channel, &ev_cq, &ev_ctx);
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
+        poll_cq(dev, ev_cq, false);
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
+void backend_register_comp_handler(void (*handler)(int status,
+                                   unsigned int vendor_err, void *ctx))
+{
+    comp_handler = handler;
+}
+
+int backend_query_port(BackendDevice *dev, struct pvrdma_port_attr *attrs)
+{
+    int rc;
+    struct ibv_port_attr port_attr;
+
+    rc = ibv_query_port(dev->context, dev->port_num, &port_attr);
+    if (rc) {
+        pr_dbg("Error %d from ibv_query_port\n", rc);
+        return -EIO;
+    }
+
+    attrs->state = port_attr.state;
+    attrs->max_mtu = port_attr.max_mtu;
+    attrs->active_mtu = port_attr.active_mtu;
+    attrs->gid_tbl_len = port_attr.gid_tbl_len;
+    attrs->pkey_tbl_len = port_attr.pkey_tbl_len;
+    attrs->phys_state = port_attr.phys_state;
+
+    return 0;
+}
+
+void backend_poll_cq(PVRDMADev *dev, BackendCQ *cq)
+{
+    poll_cq(dev, cq->ibcq, true);
+}
+
+static GHashTable *ah_hash;
+
+static struct ibv_ah *create_ah(BackendDevice *dev, struct ibv_pd *pd,
+                                union ibv_gid *dgid, uint8_t sgid_idx)
+{
+    GBytes *ah_key = g_bytes_new(dgid, sizeof(*dgid));
+    struct ibv_ah *ah = g_hash_table_lookup(ah_hash, ah_key);
+
+    if (ah) {
+        trace_create_ah_cache_hit(be64_to_cpu(dgid->global.subnet_prefix),
+                                  be64_to_cpu(dgid->global.interface_id));
+    } else {
+        struct ibv_ah_attr ah_attr = {
+            .is_global     = 1,
+            .port_num      = dev->port_num,
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
+static void destroy_ah(gpointer data)
+{
+    struct ibv_ah *ah = data;
+    ibv_destroy_ah(ah);
+}
+
+static void ah_cache_init(void)
+{
+    ah_hash = g_hash_table_new_full(g_bytes_hash, g_bytes_equal,
+                                    NULL, destroy_ah);
+}
+
+static int send_mad(PVRDMADev *dev, struct pvrdma_sge *sge, u32 num_sge)
+{
+    int ret = -1;
+
+    /*
+     * TODO: Currently QP1 is not supported
+     *
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    char mad_msg[1024];
+    void *hdr, *msg;
+    struct ib_user_mad *umad = (struct ib_user_mad *)&mad_msg;
+
+    umad->length = sge[0].length + sge[1].length;
+
+    if (num_sge != 2)
+        return -EINVAL;
+
+    pr_dbg("msg_len=%d\n", umad->length);
+
+    hdr = pvrdma_pci_dma_map(pci_dev, sge[0].addr, sge[0].length);
+    msg = pvrdma_pci_dma_map(pci_dev, sge[1].addr, sge[1].length);
+
+    memcpy(&mad_msg[64], hdr, sge[0].length);
+    memcpy(&mad_msg[sge[0].length+64], msg, sge[1].length);
+
+    pvrdma_pci_dma_unmap(pci_dev, msg, sge[1].length);
+    pvrdma_pci_dma_unmap(pci_dev, hdr, sge[0].length);
+
+    ret = umad_send(dev->backend_dev.mad_agent.port_id,
+                    dev->backend_dev.mad_agent.agent_id,
+                    mad_msg, umad->length, 10, 10);
+    */
+    if (ret) {
+        pr_dbg("Fail to send MAD message, err=%d\n", ret);
+    }
+
+    return ret;
+}
+
+static int build_host_sge_array(PVRDMADev *dev, struct ibv_sge *dsge,
+                                struct pvrdma_sge *ssge, u8 num_sge)
+{
+    RmMR *mr;
+    int ssge_idx;
+    int ret = 0;
+
+    pr_dbg("num_sge=%d\n", num_sge);
+
+    for (ssge_idx = 0; ssge_idx < num_sge; ssge_idx++) {
+        mr = rm_get_mr(dev, ssge[ssge_idx].lkey);
+        if (unlikely(!mr)) {
+            ret = VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
+            pr_dbg("Invalid lkey %d\n", ssge[ssge_idx].lkey);
+            goto out;
+        }
+
+        dsge->addr = mr->user_mr.host_virt + ssge[ssge_idx].addr -
+                     mr->user_mr.guest_start;
+        dsge->length = ssge[ssge_idx].length;
+        dsge->lkey = backend_mr_lkey(mr->backend_mr);
+
+        pr_dbg("ssge->addr=0x%lx\n", (u64)ssge[ssge_idx].addr);
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
+void backend_send_wqe(PVRDMADev *dev, BackendQP* qp, u8 qp_type,
+                      struct PvrdmaSqWqe *wqe, void *ctx)
+{
+    BackendCtx *bctx;
+    struct ibv_sge sge[MAX_SGE];
+    u32 bctx_id;
+    int rc;
+    struct ibv_send_wr wr = {0}, *bad_wr;
+
+    if (!qp->ibqp && qp_type == 0) {
+        pr_dbg("QP0 is not supported\n");
+        comp_handler(IB_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
+        return;
+    }
+
+    if ((!wqe->hdr.num_sge)) {
+        pr_dbg("num_sge=0\n");
+        comp_handler(IB_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
+        return;
+    }
+
+    pr_dbg("wqe->hdr.num_sge=%d\n", wqe->hdr.num_sge);
+
+    if (!qp->ibqp && qp_type == 1) {
+        pr_dbg("QP1\n");
+        rc = send_mad(dev, wqe->sge, wqe->hdr.num_sge);
+        if (!rc) {
+            comp_handler(IB_WC_SUCCESS, 0, ctx);
+        } else {
+            comp_handler(IB_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
+        }
+        return;
+    }
+
+    if (qp_type == IBV_QPT_UD) {
+        wr.wr.ud.ah = create_ah(&dev->backend_dev, qp->ibpd,
+                                (union ibv_gid *)wqe->hdr.wr.ud.av.dgid,
+                                dev->backend_gid_idx);
+        if (!wr.wr.ud.ah) {
+            pr_dbg("Fail to create ibv_ah\n");
+            comp_handler(IB_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
+            return;
+        }
+        wr.wr.ud.remote_qpn = wqe->hdr.wr.ud.remote_qpn;
+        wr.wr.ud.remote_qkey = wqe->hdr.wr.ud.remote_qkey;
+    }
+
+    bctx = malloc(sizeof(*bctx));
+    if (unlikely(!bctx)) {
+        pr_dbg("Fail to allocate request ctx\n");
+        comp_handler(IB_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        return;
+    }
+    memset(bctx, 0, sizeof(*bctx));
+
+    bctx->up_ctx = ctx;
+    bctx->is_tx_req = 1;
+
+    rc = rm_alloc_cqe_ctx(dev, &bctx_id, bctx);
+    if (unlikely(rc)) {
+        pr_dbg("Fail to allocate cqe_ctx\n");
+        comp_handler(IB_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        goto out_free_bctx;
+    }
+
+    rc = build_host_sge_array(dev, sge, &wqe->sge[0], wqe->hdr.num_sge);
+    if (rc) {
+        pr_dbg("Error: Fail to build host SGE array\n");
+        comp_handler(IB_WC_GENERAL_ERR, rc, ctx);
+        goto out_dealloc_cqe_ctx;
+    }
+
+    wr.num_sge = wqe->hdr.num_sge;
+    wr.opcode = IBV_WR_SEND;
+    wr.send_flags = IBV_SEND_SIGNALED;
+    wr.sg_list = &sge[0];
+    wr.wr_id = bctx_id;
+
+    rc = ibv_post_send(qp->ibqp, &wr, &bad_wr);
+    pr_dbg("ibv_post_send=%d\n", rc);
+    if (rc) {
+        pr_dbg("Fail (%d, %d) to post send WQE to qpn %d\n", rc, errno,
+                qp->ibqp->qp_num);
+        goto out_dealloc_cqe_ctx;
+    }
+
+    return;
+
+out_dealloc_cqe_ctx:
+    rm_dealloc_cqe_ctx(dev, bctx_id);
+
+out_free_bctx:
+    free(bctx);
+}
+
+void backend_recv_wqe(PVRDMADev *dev, BackendQP* qp, u8 qp_type,
+                      struct PvrdmaRqWqe *wqe, void *ctx)
+{
+    BackendCtx *bctx;
+    struct ibv_sge sge[MAX_SGE];
+    u32 bctx_id;
+    int rc;
+    struct ibv_recv_wr wr = {0}, *bad_wr;
+
+    if (!qp->ibqp && qp_type == 0) {
+        pr_dbg("QP0 is not supported\n");
+        comp_handler(IB_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
+        return;
+    }
+
+    if ((!wqe->hdr.num_sge)) {
+        pr_dbg("num_sge=0\n");
+        comp_handler(IB_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
+        return;
+    }
+
+    pr_dbg("wqe->hdr.num_sge=%d\n", wqe->hdr.num_sge);
+
+    if (!qp->ibqp && qp_type == 1) {
+        pr_dbg("QP1\n");
+        /*
+        sge = &wqe->sge[0];
+        bctx->req.sge[0].addr = (uintptr_t)sge->addr;
+        bctx->req.sge[0].length = sge->length;
+        qlist_append(dev->backend_dev.mad_agent.recv_mads_list,
+                     qnum_from_uint(bctx->req.req_id));
+        */
+        comp_handler(IB_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
+        return;
+    }
+
+    bctx = malloc(sizeof(*bctx));
+    if (unlikely(!bctx)) {
+        pr_dbg("Fail to allocate request ctx\n");
+        comp_handler(IB_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        return;
+    }
+    memset(bctx, 0, sizeof(*bctx));
+
+    bctx->up_ctx = ctx;
+    bctx->is_tx_req = 0;
+
+    rc = rm_alloc_cqe_ctx(dev, &bctx_id, bctx);
+    if (unlikely(rc)) {
+        pr_dbg("Fail to allocate cqe_ctx\n");
+        comp_handler(IB_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
+        goto out_free_bctx;
+    }
+
+    rc = build_host_sge_array(dev, sge, &wqe->sge[0], wqe->hdr.num_sge);
+    if (rc) {
+        pr_dbg("Error: Fail to build host SGE array\n");
+        comp_handler(IB_WC_GENERAL_ERR, rc, ctx);
+        goto out_dealloc_cqe_ctx;
+    }
+
+    wr.num_sge = wqe->hdr.num_sge;
+    wr.sg_list = &sge[0];
+    wr.wr_id = bctx_id;
+    rc = ibv_post_recv(qp->ibqp, &wr, &bad_wr);
+    pr_dbg("ibv_post_recv=%d\n", rc);
+    if (rc) {
+        pr_dbg("Fail (%d, %d) to post recv WQE to qpn %d\n", rc, errno,
+                qp->ibqp->qp_num);
+        goto out_dealloc_cqe_ctx;
+    }
+
+    return;
+
+out_dealloc_cqe_ctx:
+    rm_dealloc_cqe_ctx(dev, bctx_id);
+
+out_free_bctx:
+    free(bctx);
+}
+
+int backend_create_pd(BackendDevice *dev, BackendPD *pd)
+{
+    pd->ibpd = ibv_alloc_pd(dev->context);
+
+    return pd->ibpd ? 0 : -EIO;
+}
+
+void backend_destroy_pd(BackendPD *pd)
+{
+    if (pd->ibpd) {
+        ibv_dealloc_pd(pd->ibpd);
+    }
+}
+
+int backend_create_mr(BackendMR *mr, BackendPD *pd, u64 addr, size_t length,
+                      int access)
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
+void backend_destroy_mr(BackendMR *mr)
+{
+    if (mr->ibmr) {
+        ibv_dereg_mr(mr->ibmr);
+    }
+}
+
+int backend_create_cq(BackendDevice *dev, BackendCQ *cq, int cqe)
+{
+    pr_dbg("cqe=%d\n", cqe);
+
+    pr_dbg("dev->channel=%p\n", dev->channel);
+    cq->ibcq = ibv_create_cq(dev->context, cqe + 1, NULL, dev->channel, 0);
+
+    if (cq->ibcq) {
+        if (ibv_req_notify_cq(cq->ibcq, 0)) {
+            pr_dbg("---> ibv_req_notify_cq\n");
+        }
+    }
+
+    cq->dev = dev;
+
+    return cq->ibcq ? 0 : -EIO;
+}
+
+void backend_destroy_cq(BackendCQ *cq)
+{
+    PVRDMADev *dev = PVRDMA_DEV(cq->dev->dev);
+
+    if (cq->ibcq) {
+        ibv_req_notify_cq(cq->ibcq, 0);
+
+        /* Cleanup the queue before destruction */
+        poll_cq(dev, cq->ibcq, false);
+
+        ibv_destroy_cq(cq->ibcq);
+    }
+}
+
+int backend_create_qp(BackendQP *qp, u8 qp_type, BackendPD *pd, BackendCQ *scq,
+                      BackendCQ *rcq, u32 max_send_wr, u32 max_recv_wr,
+                      u32 max_send_sge, u32 max_recv_sge)
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
+int backend_qp_state_init(BackendDevice *dev, BackendQP *qp, u8 qp_type,
+                          u32 qkey)
+{
+    struct ibv_qp_attr attr = {0};
+    int rc, attr_mask;
+
+    if (!qp->ibqp && qp_type == 0) {
+        pr_dbg("QP0 is not supported\n");
+        return -EPERM;
+    }
+
+    if (!qp->ibqp && qp_type == 1) {
+        pr_dbg("QP1\n");
+        return 0;
+    }
+
+    attr_mask = IBV_QP_STATE | IBV_QP_PKEY_INDEX | IBV_QP_PORT;
+    attr.qp_state        = IBV_QPS_INIT;
+    attr.pkey_index      = 0;
+    attr.port_num        = dev->port_num;
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
+int backend_qp_state_rtr(BackendDevice *dev, BackendQP *qp, u8 qp_type,
+                         u8 gid_idx, union pvrdma_gid *dgid, u32 dqpn,
+                         u32 rq_psn, u32 qkey)
+{
+    struct ibv_qp_attr attr = {0};
+    union ibv_gid ibv_gid = {
+        .global.interface_id = dgid->global.interface_id,
+        .global.subnet_prefix = dgid->global.subnet_prefix
+    };
+    int rc, attr_mask;
+
+    if (!qp->ibqp && qp_type == 0) {
+        pr_dbg("QP0 is not supported\n");
+        return -EPERM;
+    }
+
+    if (!qp->ibqp && qp_type == 1) {
+        pr_dbg("QP1\n");
+        return 0;
+    }
+
+
+    pr_dbg("dgid=0x%lx,%lx\n", be64_to_cpu(ibv_gid.global.subnet_prefix),
+           be64_to_cpu(ibv_gid.global.interface_id));
+    pr_dbg("dqpn=0x%x\n", dqpn);
+    pr_dbg("sgid_idx=%d\n", gid_idx);
+    pr_dbg("sport_num=%d\n", dev->port_num);
+
+    attr.qp_state = IBV_QPS_RTR;
+    attr_mask = IBV_QP_STATE;
+
+    if (qp_type == IBV_QPT_RC) {
+        attr.path_mtu               = IBV_MTU_1024;
+        attr.dest_qp_num            = dqpn;
+        attr.max_dest_rd_atomic     = 1;
+        attr.min_rnr_timer          = 12;
+        attr.ah_attr.port_num       = dev->port_num;
+        attr.ah_attr.is_global      = 1;
+        attr.ah_attr.grh.hop_limit  = 1;
+        attr.ah_attr.grh.dgid       = ibv_gid;
+        attr.ah_attr.grh.sgid_index = gid_idx;
+        attr.rq_psn                 = rq_psn;
+
+        attr_mask |= IBV_QP_AV | IBV_QP_PATH_MTU | IBV_QP_DEST_QPN |
+                     IBV_QP_RQ_PSN | IBV_QP_MAX_DEST_RD_ATOMIC |
+                     IBV_QP_MIN_RNR_TIMER;
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
+int backend_qp_state_rts(BackendQP *qp, u8 qp_type, u32 sq_psn, u32 qkey)
+{
+    struct ibv_qp_attr attr = {0};
+    int rc, attr_mask;
+
+    if (!qp->ibqp && qp_type == 0) {
+        pr_dbg("QP0 is not supported\n");
+        return -EPERM;
+    }
+
+    if (!qp->ibqp && qp_type == 1) {
+        pr_dbg("QP1\n");
+        return 0;
+    }
+
+    attr.qp_state = IBV_QPS_RTS;
+    attr_mask = IBV_QP_STATE | IBV_QP_SQ_PSN;
+
+    if (qp_type == IBV_QPT_RC) {
+        attr.timeout       = 14;
+        attr.retry_cnt     = 7;
+        attr.rnr_retry     = 7;
+        attr.max_rd_atomic = 1;
+        attr.sq_psn        = sq_psn;
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
+void backend_destroy_qp(BackendQP *qp)
+{
+    if (qp->ibqp) {
+        ibv_destroy_qp(qp->ibqp);
+    }
+}
+
+static void dummy_comp_handler(int status, unsigned int vendor_err, void *ctx)
+{
+    pr_err("No completion handler is registered\n");
+}
+
+#define CHK_ATTR(req, dev, member, fmt) ({ \
+    pr_dbg("%s="fmt","fmt"\n", #member, dev.member, req.member); \
+    if (req.member > dev.member) { \
+        warn_report("Setting of %s to 0x%lx higher than host device capability 0x%lx", \
+                    #member, (uint64_t)req.member, (uint64_t)dev.member); \
+        req.member = dev.member; \
+    } \
+    pr_dbg("%s="fmt"\n", #member, req.member); })
+
+static int init_device_caps(PVRDMADev *dev)
+{
+    memset(&dev->backend_dev.dev_attr, 0, sizeof(dev->backend_dev.dev_attr));
+
+    if (ibv_query_device(dev->backend_dev.context,
+                         &dev->backend_dev.dev_attr)) {
+        return -EIO;
+    }
+
+    CHK_ATTR(dev->dev_attr, dev->backend_dev.dev_attr, max_mr_size, "%ld");
+    CHK_ATTR(dev->dev_attr, dev->backend_dev.dev_attr, max_qp, "%d");
+    CHK_ATTR(dev->dev_attr, dev->backend_dev.dev_attr, max_sge, "%d");
+    CHK_ATTR(dev->dev_attr, dev->backend_dev.dev_attr, max_qp_wr, "%d");
+    CHK_ATTR(dev->dev_attr, dev->backend_dev.dev_attr, max_cq, "%d");
+    CHK_ATTR(dev->dev_attr, dev->backend_dev.dev_attr, max_cqe, "%d");
+    CHK_ATTR(dev->dev_attr, dev->backend_dev.dev_attr, max_mr, "%d");
+    CHK_ATTR(dev->dev_attr, dev->backend_dev.dev_attr, max_pd, "%d");
+    CHK_ATTR(dev->dev_attr, dev->backend_dev.dev_attr, max_qp_rd_atom, "%d");
+    CHK_ATTR(dev->dev_attr, dev->backend_dev.dev_attr, max_qp_init_rd_atom,
+             "%d");
+    CHK_ATTR(dev->dev_attr, dev->backend_dev.dev_attr, max_ah, "%d");
+
+    return 0;
+}
+
+static int mad_init(PVRDMADev *dev, int port_num)
+{
+    char thread_name[80] = {0};
+
+    dev->backend_dev.mad_agent.recv_mads_list = qlist_new();
+
+    pr_dbg("Registering MAD agent for device %s, port %d\n",
+           dev->backend_dev.context->device->name, port_num);
+
+    dev->backend_dev.mad_agent.port_id =
+        umad_open_port(dev->backend_dev.context->device->name, port_num);
+
+    if (dev->backend_dev.mad_agent.port_id < 0) {
+        pr_err("Fail to register MAD agent, id=%d\n",
+               dev->backend_dev.mad_agent.port_id);
+        return -EIO;
+    }
+    pr_dbg("MAD Agent port ID %d\n", dev->backend_dev.mad_agent.port_id);
+
+    dev->backend_dev.mad_agent.agent_id =
+        umad_register(dev->backend_dev.mad_agent.port_id, 0x03, 1, 0, NULL);
+
+    if (dev->backend_dev.mad_agent.agent_id < 0) {
+        pr_err("Fail to register MAD agent, id=%d\n",
+               dev->backend_dev.mad_agent.port_id);
+        umad_close_port(dev->backend_dev.mad_agent.port_id);
+        return -EIO;
+    }
+    pr_dbg("MAD Agent ID %d\n", dev->backend_dev.mad_agent.agent_id);
+
+    sprintf(thread_name, "pvrdma_mad_%s",
+            ibv_get_device_name(dev->backend_dev.ib_dev));
+    dev->backend_dev.mad_thread.run = true;
+    qemu_thread_create(&dev->backend_dev.mad_thread.thread, thread_name,
+                       mad_handler_thread, dev, QEMU_THREAD_DETACHED);
+
+    return 0;
+}
+
+static void mad_fini(PVRDMADev *dev)
+{
+    int ret;
+
+    pr_dbg("Closing MAD agent, port %d, agent %d\n",
+           dev->backend_dev.mad_agent.port_id,
+           dev->backend_dev.mad_agent.agent_id);
+
+    ret = umad_unregister(dev->backend_dev.mad_agent.port_id,
+                          dev->backend_dev.mad_agent.agent_id);
+    if (!ret) {
+        pr_dbg("Fail to unregister MAD agent\n");
+    }
+
+    ret = umad_close_port(dev->backend_dev.mad_agent.port_id);
+    if (!ret) {
+        pr_dbg("Fail to close MAD port\n");
+    }
+}
+
+int backend_init(PVRDMADev *dev, Error **errp)
+{
+    int i;
+    int ret = 0;
+    int num_ibv_devices;
+    char thread_name[80] = {0};
+    struct ibv_device **dev_list;
+    struct ibv_port_attr port_attr;
+
+    backend_register_comp_handler(dummy_comp_handler);
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
+    if (dev->backend_device_name) {
+        for (i = 0; dev_list[i]; ++i) {
+            if (!strcmp(ibv_get_device_name(dev_list[i]),
+                        dev->backend_device_name)) {
+                break;
+            }
+        }
+
+        dev->backend_dev.ib_dev = dev_list[i];
+        if (!dev->backend_dev.ib_dev) {
+            error_setg(errp, "Failed to find IB device %s",
+                       dev->backend_device_name);
+            ret = -EIO;
+            goto out;
+        }
+    } else {
+        dev->backend_dev.ib_dev = *dev_list;
+    }
+    ibv_free_device_list(dev_list);
+
+    pr_dbg("Using backend device %s, port %d, gid_idx %d\n",
+           ibv_get_device_name(dev->backend_dev.ib_dev),
+           dev->backend_dev.port_num, dev->backend_gid_idx);
+
+    dev->backend_dev.context = ibv_open_device(dev->backend_dev.ib_dev);
+    if (!dev->backend_dev.context) {
+        error_setg(errp, "Failed to open IB device");
+        ret = -EIO;
+        goto out;
+    }
+
+    dev->backend_dev.channel =
+        ibv_create_comp_channel(dev->backend_dev.context);
+    if (!dev->backend_dev.channel) {
+        error_setg(errp, "Failed to create IB communication channel");
+        ret = -EIO;
+        goto out_close_device;
+    }
+    pr_dbg("dev->backend_dev.channel=%p\n", dev->backend_dev.channel);
+
+    ret = ibv_query_gid(dev->backend_dev.context, dev->backend_dev.port_num,
+                         dev->backend_gid_idx, &dev->backend_dev.gid);
+    if (ret) {
+        error_setg(errp, "Failed to query gid %d", dev->backend_gid_idx);
+        ret = -EIO;
+        goto out_destroy_comm_channel;
+    }
+    pr_dbg("subnet_prefix=0x%lx\n",
+           be64_to_cpu(dev->backend_dev.gid.global.subnet_prefix));
+    pr_dbg("interface_id=0x%lx\n",
+           be64_to_cpu(dev->backend_dev.gid.global.interface_id));
+
+    ret = ibv_query_port(dev->backend_dev.context, dev->backend_dev.port_num,
+                         &port_attr);
+    if (ret) {
+        error_setg(errp, "Error %d from ibv_query_port", ret);
+        ret = -EIO;
+        goto out_destroy_comm_channel;
+    }
+
+    ret = init_device_caps(dev);
+    if (ret) {
+        error_setg(errp, "Fail to initialize device capabilities");
+        ret = -EIO;
+        goto out_destroy_comm_channel;
+    }
+
+    ret = mad_init(dev, dev->backend_dev.port_num);
+    if (ret) {
+        error_setg(errp, "Fail to initialize umad agent");
+        ret = -EIO;
+        goto out_destroy_comm_channel;
+    }
+
+    sprintf(thread_name, "pvrdma_comp_%s",
+            ibv_get_device_name(dev->backend_dev.ib_dev));
+    dev->backend_dev.comp_thread.run = true;
+    qemu_thread_create(&dev->backend_dev.comp_thread.thread, thread_name,
+                       comp_handler_thread, dev, QEMU_THREAD_DETACHED);
+
+    ah_cache_init();
+
+    goto out;
+
+out_destroy_comm_channel:
+    ibv_destroy_comp_channel(dev->backend_dev.channel);
+
+out_close_device:
+    ibv_close_device(dev->backend_dev.context);
+
+out:
+    return ret;
+}
+
+void backend_fini(PVRDMADev *dev)
+{
+    dev->backend_dev.mad_thread.run = false;
+    dev->backend_dev.comp_thread.run = false;
+    mad_fini(dev);
+    g_hash_table_destroy(ah_hash);
+    ibv_destroy_comp_channel(dev->backend_dev.channel);
+    ibv_close_device(dev->backend_dev.context);
+}
diff --git a/hw/net/pvrdma/pvrdma_backend.h b/hw/net/pvrdma/pvrdma_backend.h
new file mode 100644
index 0000000000..c17618030a
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_backend.h
@@ -0,0 +1,74 @@
+/*
+ * QEMU VMWARE paravirtual RDMA QP Operations
+ *
+ * Developed by Oracle & Redhat
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
+#ifndef PVRDMA_BACKEND_H
+#define PVRDMA_BACKEND_H
+
+#include "pvrdma.h"
+#include "pvrdma_backend_defs.h"
+
+static inline union pvrdma_gid *backend_gid(BackendDevice *dev)
+{
+    return (union pvrdma_gid *)&dev->gid;
+}
+
+static inline u32 backend_qpn(BackendQP *qp)
+{
+    return qp->ibqp ? qp->ibqp->qp_num : 0;
+}
+
+static inline u32 backend_mr_lkey(BackendMR *mr)
+{
+    return mr->ibmr->lkey;
+}
+
+static inline u32 backend_mr_rkey(BackendMR *mr)
+{
+    return mr->ibmr->rkey;
+}
+
+int backend_init(PVRDMADev *dev, Error **errp);
+void backend_fini(PVRDMADev *dev);
+void backend_register_comp_handler(void (*handler)(int status,
+                                   unsigned int vendor_err, void *ctx));
+
+int backend_query_port(BackendDevice *dev, struct pvrdma_port_attr *attrs);
+int backend_create_pd(BackendDevice *dev, BackendPD *pd);
+void backend_destroy_pd(BackendPD *pd);
+
+int backend_create_mr(BackendMR *mr, BackendPD *pd, u64 addr, size_t length,
+                      int access);
+void backend_destroy_mr(BackendMR *mr);
+
+int backend_create_cq(BackendDevice *dev, BackendCQ *cq, int cqe);
+void backend_destroy_cq(BackendCQ *cq);
+void backend_poll_cq(PVRDMADev *dev, BackendCQ *cq);
+int backend_create_qp(BackendQP *qp, u8 qp_type, BackendPD *pd, BackendCQ *scq,
+                      BackendCQ *rcq, u32 max_send_wr, u32 max_recv_wr,
+                      u32 max_send_sge, u32 max_recv_sge);
+
+int backend_qp_state_init(BackendDevice *dev, BackendQP *qp, u8 qp_type,
+                          u32 qkey);
+int backend_qp_state_rtr(BackendDevice *dev, BackendQP *qp, u8 qp_type,
+                         u8 gid_idx, union pvrdma_gid *dgid, u32 dqpn,
+                         u32 rq_psn, u32 qkey);
+int backend_qp_state_rts(BackendQP *qp, u8 qp_type, u32 sq_psn, u32 qkey);
+void backend_destroy_qp(BackendQP *qp);
+
+void backend_send_wqe(PVRDMADev *dev, BackendQP* qp, u8 qp_type,
+                      struct PvrdmaSqWqe *wqe, void *ctx);
+void backend_recv_wqe(PVRDMADev *dev, BackendQP* qp, u8 qp_type,
+                      struct PvrdmaRqWqe *wqe, void *ctx);
+
+#endif
diff --git a/hw/net/pvrdma/pvrdma_backend_defs.h b/hw/net/pvrdma/pvrdma_backend_defs.h
new file mode 100644
index 0000000000..9c1b4d1c26
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_backend_defs.h
@@ -0,0 +1,68 @@
+/*
+ * QEMU VMWARE paravirtual RDMA QP Operations
+ *
+ * Developed by Oracle & Redhat
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
+#ifndef PVRDMA_BACKEND_DEFS_H
+#define PVRDMA_BACKEND_DEFS_H
+
+#include <qapi/qmp/qlist.h>
+
+#include <infiniband/verbs.h>
+
+#include "pvrdma_types.h"
+
+typedef struct BackendThread {
+    QemuThread thread;
+    QemuMutex mutex;
+    bool run;
+} BackendThread;
+
+typedef struct BackendMadAgent {
+    int port_id;
+    int agent_id;
+    QList *recv_mads_list;
+} BackendMadAgent;
+
+typedef struct BackendDevice {
+    PCIDevice *dev;
+    BackendThread comp_thread;
+    BackendThread mad_thread;
+    struct ibv_device *ib_dev;
+    struct ibv_context *context;
+    struct ibv_comp_channel *channel;
+    uint8_t port_num;
+    union ibv_gid gid;
+    BackendMadAgent mad_agent;
+    struct ibv_device_attr dev_attr;
+} BackendDevice;
+
+typedef struct BackendPD {
+    struct ibv_pd *ibpd;
+} BackendPD;
+
+typedef struct BackendMR {
+    struct ibv_pd *ibpd;
+    struct ibv_mr *ibmr;
+} BackendMR;
+
+typedef struct BackendCQ {
+    BackendDevice *dev;
+    struct ibv_cq *ibcq;
+} BackendCQ;
+
+typedef struct BackendQP {
+    struct ibv_pd *ibpd;
+    struct ibv_qp *ibqp;
+} BackendQP;
+
+#endif
diff --git a/hw/net/pvrdma/pvrdma_cmd.c b/hw/net/pvrdma/pvrdma_cmd.c
new file mode 100644
index 0000000000..244ae030cf
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_cmd.c
@@ -0,0 +1,338 @@
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_ids.h"
+#include "pvrdma_utils.h"
+#include "pvrdma.h"
+#include "pvrdma_rm.h"
+#include "pvrdma_backend.h"
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
+    if (backend_query_port(&dev->backend_dev, &attrs)) {
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
+    resp->hdr.err = rm_alloc_pd(dev, &resp->pd_handle, cmd->ctx_handle);
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
+    rm_dealloc_pd(dev, cmd->pd_handle);
+
+    return 0;
+}
+
+static int create_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                     union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_create_mr *cmd = &req->create_mr;
+    struct pvrdma_cmd_create_mr_resp *resp = &rsp->create_mr_resp;
+
+    pr_dbg("pd_handle=%d\n", cmd->pd_handle);
+    pr_dbg("access_flags=0x%x\n", cmd->access_flags);
+    pr_dbg("flags=0x%x\n", cmd->flags);
+
+    memset(resp, 0, sizeof(*resp));
+    resp->hdr.response = cmd->hdr.response;
+    resp->hdr.ack = PVRDMA_CMD_CREATE_MR_RESP;
+    resp->hdr.err = rm_alloc_mr(dev, cmd, resp);
+
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
+    rm_dealloc_mr(dev, cmd->mr_handle);
+
+    return 0;
+}
+
+static int create_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                     union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_create_cq *cmd = &req->create_cq;
+    struct pvrdma_cmd_create_cq_resp *resp = &rsp->create_cq_resp;
+
+    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)cmd->pdir_dma);
+    pr_dbg("context=0x%x\n", cmd->ctx_handle ? cmd->ctx_handle : 0);
+    pr_dbg("cqe=%d\n", cmd->cqe);
+    pr_dbg("nchunks=%d\n", cmd->nchunks);
+
+    memset(resp, 0, sizeof(*resp));
+    resp->hdr.response = cmd->hdr.response;
+    resp->hdr.ack = PVRDMA_CMD_CREATE_CQ_RESP;
+    resp->hdr.err = rm_alloc_cq(dev, cmd, resp);
+
+    pr_dbg("ret=%d\n", resp->hdr.err);
+    return resp->hdr.err;
+}
+
+static int destroy_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                      union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_destroy_cq *cmd = &req->destroy_cq;
+
+    pr_dbg("cq_handle=%d\n", cmd->cq_handle);
+
+    rm_dealloc_cq(dev, cmd->cq_handle);
+
+    return 0;
+}
+
+static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                     union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_create_qp *cmd = &req->create_qp;
+    struct pvrdma_cmd_create_qp_resp *resp = &rsp->create_qp_resp;
+
+    pr_dbg("pd_handle=%d\n", cmd->pd_handle);
+    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)cmd->pdir_dma);
+    pr_dbg("total_chunks=%d\n", cmd->total_chunks);
+    pr_dbg("send_chunks=%d\n", cmd->send_chunks);
+
+    memset(resp, 0, sizeof(*resp));
+    resp->hdr.response = cmd->hdr.response;
+    resp->hdr.ack = PVRDMA_CMD_CREATE_QP_RESP;
+    resp->hdr.err = rm_alloc_qp(dev, cmd, resp);
+
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
+    rsp->hdr.err = rm_modify_qp(dev, cmd->qp_handle, cmd);
+
+    pr_dbg("ret=%d\n", rsp->hdr.err);
+    return rsp->hdr.err;
+}
+
+static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                      union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_destroy_qp *cmd = &req->destroy_qp;
+
+    pr_dbg("qp_handle=%d\n", cmd->qp_handle);
+
+    rm_dealloc_qp(dev, cmd->qp_handle);
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
+    memcpy(dev->ports[0].gid_tbl[cmd->index].raw, &cmd->new_gid,
+           sizeof(cmd->new_gid));
+
+    /* TODO: Since drivers stores node_guid at load_dsr phase then this
+     * assignment is not relevant, i need to figure out a way how to
+     * retrieve MAC of our netdev */
+    dev->node_guid = dev->ports[0].gid_tbl[0].global.interface_id;
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
+    memset(dev->ports[0].gid_tbl[cmd->index].raw, 0,
+           sizeof(dev->ports[0].gid_tbl[cmd->index].raw));
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
+    resp->hdr.err = rm_alloc_uc(dev, cmd->pfn, &resp->ctx_handle);
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
+    rm_dealloc_uc(dev, cmd->ctx_handle);
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
+        pr_err("Unsupported command\n");
+        goto out;
+    }
+
+    if (!cmd_handlers[dsr_info->req->hdr.cmd].exec) {
+        pr_err("Unsupported command (not implemented yet)\n");
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
diff --git a/hw/net/pvrdma/pvrdma_defs.h b/hw/net/pvrdma/pvrdma_defs.h
new file mode 100644
index 0000000000..0ab65c4070
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_defs.h
@@ -0,0 +1,121 @@
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
+#ifndef PVRDMA_DEFS_H
+#define PVRDMA_DEFS_H
+
+#include "pvrdma_types.h"
+#include "pvrdma_ib_verbs.h"
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
+#define PVRDMA_ATOMIC_OP_COMP_SWAP    BIT(0) /* Compare and swap. */
+#define PVRDMA_ATOMIC_OP_FETCH_ADD    BIT(1) /* Fetch and add. */
+#define PVRDMA_ATOMIC_OP_MASK_COMP_SWAP    BIT(2) /* Masked compare and swap. */
+#define PVRDMA_ATOMIC_OP_MASK_FETCH_ADD    BIT(3) /* Masked fetch and add. */
+
+/*
+ * Base Memory Management Extension flags to support Fast Reg Memory Regions
+ * and Fast Reg Work Requests. Each flag represents a verb operation and we
+ * must support all of them to qualify for the BMME device cap.
+ */
+
+#define PVRDMA_BMME_FLAG_LOCAL_INV    BIT(0) /* Local Invalidate. */
+#define PVRDMA_BMME_FLAG_REMOTE_INV    BIT(1) /* Remote Invalidate. */
+#define PVRDMA_BMME_FLAG_FAST_REG_WR    BIT(2) /* Fast Reg Work Request. */
+
+/*
+ * GID types. The interpretation of the gid_types bit field in the device
+ * capabilities will depend on the device mode. For now, the device only
+ * supports RoCE as mode, so only the different GID types for RoCE are
+ * defined.
+ */
+
+#define PVRDMA_GID_TYPE_FLAG_ROCE_V1 BIT(0)
+#define PVRDMA_GID_TYPE_FLAG_ROCE_V2 BIT(1)
+
+#endif /* PVRDMA_DEFS_H */
diff --git a/hw/net/pvrdma/pvrdma_dev_api.h b/hw/net/pvrdma/pvrdma_dev_api.h
new file mode 100644
index 0000000000..3ba135734e
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_dev_api.h
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
diff --git a/hw/net/pvrdma/pvrdma_dev_ring.c b/hw/net/pvrdma/pvrdma_dev_ring.c
new file mode 100644
index 0000000000..7002436ae1
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_dev_ring.c
@@ -0,0 +1,138 @@
+#include <qemu/osdep.h>
+#include <hw/pci/pci.h>
+#include <cpu.h>
+#include "pvrdma_ring.h"
+#include "pvrdma_dev_ring.h"
+#include "pvrdma_utils.h"
+
+int ring_init(Ring *ring, const char *name, PCIDevice *dev,
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
+            pr_err("Fail to map to page %d\n", i);
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
+void *ring_next_elem_read(Ring *ring)
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
+void ring_read_inc(Ring *ring)
+{
+    pvrdma_idx_ring_inc(&ring->ring_state->cons_head, ring->max_elems);
+    /*
+    pr_dbg("%s: t=%d, h=%d, m=%ld\n", ring->name,
+           ring->ring_state->prod_tail, ring->ring_state->cons_head,
+           ring->max_elems);
+    */
+}
+
+void *ring_next_elem_write(Ring *ring)
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
+void ring_write_inc(Ring *ring)
+{
+    pvrdma_idx_ring_inc(&ring->ring_state->prod_tail, ring->max_elems);
+    /*
+    pr_dbg("%s: t=%d, h=%d, m=%ld\n", ring->name,
+           ring->ring_state->prod_tail, ring->ring_state->cons_head,
+           ring->max_elems);
+    */
+}
+
+void ring_free(Ring *ring)
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
diff --git a/hw/net/pvrdma/pvrdma_dev_ring.h b/hw/net/pvrdma/pvrdma_dev_ring.h
new file mode 100644
index 0000000000..25d024088d
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_dev_ring.h
@@ -0,0 +1,42 @@
+/*
+ * QEMU VMWARE paravirtual RDMA interface definitions
+ *
+ * Developed by Oracle & Redhat
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
+#define MAX_RING_NAME_SZ 16
+
+typedef struct Ring {
+    char name[MAX_RING_NAME_SZ];
+    PCIDevice *dev;
+    size_t max_elems;
+    size_t elem_sz;
+    struct pvrdma_ring *ring_state;
+    int npages;
+    void **pages;
+} Ring;
+
+int ring_init(Ring *ring, const char *name, PCIDevice *dev,
+              struct pvrdma_ring *ring_state, size_t max_elems, size_t elem_sz,
+              dma_addr_t *tbl, dma_addr_t npages);
+void *ring_next_elem_read(Ring *ring);
+void ring_read_inc(Ring *ring);
+void *ring_next_elem_write(Ring *ring);
+void ring_write_inc(Ring *ring);
+void ring_free(Ring *ring);
+
+#endif
diff --git a/hw/net/pvrdma/pvrdma_ib_verbs.h b/hw/net/pvrdma/pvrdma_ib_verbs.h
new file mode 100644
index 0000000000..b3c2060800
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_ib_verbs.h
@@ -0,0 +1,399 @@
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
diff --git a/hw/net/pvrdma/pvrdma_main.c b/hw/net/pvrdma/pvrdma_main.c
new file mode 100644
index 0000000000..55fdf9b6f7
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_main.c
@@ -0,0 +1,664 @@
+#include <qemu/osdep.h>
+#include "qapi/error.h"
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
+#include "pvrdma.h"
+#include "pvrdma_defs.h"
+#include "pvrdma_utils.h"
+#include "pvrdma_dev_api.h"
+#include "pvrdma_rm.h"
+#include "pvrdma_backend.h"
+#include "pvrdma_qp_ops.h"
+
+static Property pvrdma_dev_properties[] = {
+    DEFINE_PROP_STRING("backend-dev", PVRDMADev, backend_device_name),
+    DEFINE_PROP_UINT8("backend-port", PVRDMADev, backend_dev.port_num, 1),
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
+static void free_dev_ring(PCIDevice *pci_dev, Ring *ring, void *ring_state)
+{
+    ring_free(ring);
+    pvrdma_pci_dma_unmap(pci_dev, ring_state, TARGET_PAGE_SIZE);
+}
+
+static int init_dev_ring(Ring *ring, struct pvrdma_ring **ring_state,
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
+    rc = ring_init(ring, name, pci_dev, (struct pvrdma_ring *)*ring_state,
+                   (num_pages - 1) * TARGET_PAGE_SIZE /
+                   sizeof(struct pvrdma_cqne), sizeof(struct pvrdma_cqne),
+                   (dma_addr_t *)&tbl[1], (dma_addr_t)num_pages - 1);
+    if (rc != 0) {
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
+    if (rc != 0) {
+        pr_err("Fail to map to initialize CQ ring\n");
+        rc = -ENOMEM;
+        goto out_free_rsp;
+    }
+
+    /* Map to event notification ring */
+    rc = init_dev_ring(&dsr_info->async, &dsr_info->async_ring_state,
+                       "dev_async", pci_dev, dsr->async_ring_pages.pdir_dma,
+                       dsr->async_ring_pages.num_pages);
+    if (rc != 0) {
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
+        free(dev->ports[i].gid_tbl);
+    }
+}
+
+static int init_ports(PVRDMADev *dev, Error **errp)
+{
+    int i, ret = 0;
+
+    memset(dev->ports, 0, sizeof(dev->ports));
+
+    for (i = 0; i < MAX_PORTS; i++) {
+        dev->ports[i].state = PVRDMA_PORT_DOWN;
+
+        dev->ports[i].pkey_tbl = malloc(sizeof(*dev->ports[i].pkey_tbl) *
+                                        MAX_PORT_PKEYS);
+        if (dev->ports[i].gid_tbl == NULL) {
+            goto err_free_ports;
+        }
+
+        memset(dev->ports[i].gid_tbl, 0, sizeof(dev->ports[i].gid_tbl));
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
+static uint64_t uar_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PVRDMADev *dev = opaque;
+    __u32 val;
+
+    pr_dbg("addr=0x%lx, size=%d\n", addr, size);
+
+    if (get_uar_val(dev, addr, &val)) {
+        pr_dbg("Error trying to read UAR value from address 0x%x\n",
+               (__u32)addr);
+        return -EINVAL;
+    }
+
+    pr_dbg("uar[0x%x]=0x%x\n", (__u32)addr, val);
+
+    return val;
+}
+
+static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    PVRDMADev *dev = opaque;
+
+    /* pr_dbg("addr=0x%lx, val=0x%x, size=%d\n", addr, (uint32_t)val, size); */
+
+    /*
+    if (set_uar_val(dev, addr, val)) {
+        pr_err("Error trying to set UAR value, addr=0x%x, val=0x%lx\n",
+               (__u32)addr, val);
+        return;
+    }
+    */
+
+    /* pr_dbg("uar[0x%x]=0x%lx\n", (__u32)addr, val); */
+
+    switch (addr & 0xFFF) { /* Mask with 0xFFF as each UC gets page */
+    case PVRDMA_UAR_QP_OFFSET:
+        pr_dbg("UAR QP command, addr=0x%x, val=0x%lx\n", (__u32)addr, val);
+        if (val & PVRDMA_UAR_QP_SEND) {
+            qp_send(dev, val & PVRDMA_UAR_HANDLE_MASK);
+        }
+        if (val & PVRDMA_UAR_QP_RECV) {
+            qp_recv(dev, val & PVRDMA_UAR_HANDLE_MASK);
+        }
+        break;
+    case PVRDMA_UAR_CQ_OFFSET:
+        /* pr_dbg("UAR CQ cmd, addr=0x%x, val=0x%lx\n", (__u32)addr, val); */
+        if (val & PVRDMA_UAR_CQ_ARM) {
+            rm_req_notify_cq(dev, val & PVRDMA_UAR_HANDLE_MASK,
+                             val & ~PVRDMA_UAR_HANDLE_MASK);
+        }
+        if (val & PVRDMA_UAR_CQ_ARM_SOL) {
+            pr_dbg("UAR_CQ_ARM_SOL (%ld)\n", val & PVRDMA_UAR_HANDLE_MASK);
+        }
+        if (val & PVRDMA_UAR_CQ_POLL) {
+            pr_dbg("UAR_CQ_POLL (%ld)\n", val & PVRDMA_UAR_HANDLE_MASK);
+            cq_poll(dev, val & PVRDMA_UAR_HANDLE_MASK);
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
+    .read = uar_read,
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
+    size_t wr_sz = MAX(sizeof(struct pvrdma_sq_wqe_hdr),
+                       sizeof(struct pvrdma_rq_wqe_hdr));
+
+    /* Currently supported ring size is one page */
+    dev->dev_attr.max_qp_wr = TARGET_PAGE_SIZE /
+                              (wr_sz + sizeof(struct pvrdma_sge) * MAX_SGE);
+    pr_dbg("max_qp_wr=%d\n", dev->dev_attr.max_qp_wr);
+
+    dev->dev_attr.max_cqe = TARGET_PAGE_SIZE / sizeof(struct pvrdma_cqe);
+    /* TODO: Currently driver enforce 512 */
+    dev->dev_attr.max_cqe = 512;
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
+    if (rc != 0) {
+        goto out;
+    }
+
+    rc = backend_init(dev, errp);
+    if (rc != 0) {
+        goto out;
+    }
+
+    rc = rm_init(dev, errp);
+    if (rc != 0) {
+        goto out;
+    }
+
+    rc = init_ports(dev, errp);
+    if (rc != 0) {
+        goto out;
+    }
+
+    rc = qp_ops_init();
+    if (rc != 0) {
+        goto out;
+    }
+
+out:
+    if (rc != 0) {
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
+    qp_ops_fini();
+
+    free_ports(dev);
+
+    rm_fini(dev);
+
+    backend_fini(dev);
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
diff --git a/hw/net/pvrdma/pvrdma_qp_ops.c b/hw/net/pvrdma/pvrdma_qp_ops.c
new file mode 100644
index 0000000000..23ba3fceba
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_qp_ops.c
@@ -0,0 +1,187 @@
+#include "pvrdma.h"
+#include "pvrdma_rm.h"
+#include "pvrdma_utils.h"
+#include "pvrdma_qp_ops.h"
+#include "pvrdma_backend.h"
+
+typedef struct CompHandlerCtx {
+    PVRDMADev *dev;
+    u32 cq_handle;
+    struct pvrdma_cqe cqe;
+} CompHandlerCtx;
+
+/*
+ * 1. Put CQE on send CQ ring
+ * 2. Put CQ number on dsr completion ring
+ * 3. Interrupt host
+ */
+static int post_cqe(PVRDMADev *dev, u32 cq_handle, struct pvrdma_cqe *cqe)
+{
+    struct pvrdma_cqe *cqe1;
+    struct pvrdma_cqne *cqne;
+    RmCQ *cq = rm_get_cq(dev, cq_handle);
+
+    if (unlikely(!cq)) {
+        pr_dbg("Invalid cqn %d\n", cq_handle);
+        return -EINVAL;
+    }
+
+    /* Step #1: Put CQE on CQ ring */
+    pr_dbg("Writing CQE\n");
+    cqe1 = ring_next_elem_write(&cq->cq);
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
+    ring_write_inc(&cq->cq);
+
+    /* Step #2: Put CQ number on dsr completion ring */
+    pr_dbg("Writing CQNE\n");
+    cqne = ring_next_elem_write(&dev->dsr_info.cq);
+    if (unlikely(!cqne)) {
+        return -EINVAL;
+    }
+
+    cqne->info = cq_handle;
+    ring_write_inc(&dev->dsr_info.cq);
+
+    pr_dbg("cq->comp_type=%d\n", cq->comp_type);
+    if (cq->comp_type != CCT_NONE) {
+        cq->comp_type = CCT_NONE;
+        post_interrupt(dev, INTR_VEC_CMD_COMPLETION_Q);
+    }
+
+    return 0;
+}
+
+static void qp_ops_comp_handler(int status, unsigned int vendor_err, void *ctx)
+{
+    CompHandlerCtx *comp_ctx = (CompHandlerCtx *)ctx;
+
+    pr_dbg("cq_handle=%d\n", comp_ctx->cq_handle);
+    pr_dbg("wr_id=%lld\n", comp_ctx->cqe.wr_id);
+    pr_dbg("status=%d\n", status);
+    pr_dbg("vendor_err=0x%x\n", vendor_err);
+    comp_ctx->cqe.status = status;
+    comp_ctx->cqe.vendor_err = vendor_err;
+    post_cqe(comp_ctx->dev, comp_ctx->cq_handle, &comp_ctx->cqe);
+    free(ctx);
+}
+
+void qp_ops_fini(void)
+{
+}
+
+int qp_ops_init(void)
+{
+    backend_register_comp_handler(qp_ops_comp_handler);
+
+    return 0;
+}
+
+int qp_send(PVRDMADev *dev, __u32 qp_handle)
+{
+    RmQP *qp;
+    PvrdmaSqWqe *wqe;
+
+    qp = rm_get_qp(dev, qp_handle);
+    if (unlikely(!qp)) {
+        return -EINVAL;
+    }
+
+    if (qp->qp_state < PVRDMA_QPS_RTS) {
+        pr_dbg("Invalid QP state for send (%d < %d) for qp %d\n", qp->qp_state,
+               PVRDMA_QPS_RTS, qp_handle);
+        return -EINVAL;
+    }
+
+    pr_dbg("Peer: 0x%lx,0x%lx 0x%x\n",
+           be64_to_cpu(qp->dgid.global.subnet_prefix),
+           be64_to_cpu(qp->dgid.global.interface_id), qp->dqpn);
+
+    wqe = (struct PvrdmaSqWqe *)ring_next_elem_read(&qp->sq);
+    while (wqe) {
+        CompHandlerCtx *comp_ctx;
+
+        pr_dbg("wr_id=%lld\n", wqe->hdr.wr_id);
+        wqe->hdr.num_sge = MIN(wqe->hdr.num_sge, qp->init_args.max_send_sge);
+
+        /* Prepare CQE */
+        comp_ctx = malloc(sizeof(CompHandlerCtx));
+        comp_ctx->dev = dev;
+        comp_ctx->cq_handle = qp->init_args.send_cq_handle;
+        comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
+        comp_ctx->cqe.qp = qp_handle;
+        comp_ctx->cqe.opcode = wqe->hdr.opcode;
+
+        backend_send_wqe(dev, qp->backend_qp, qp->init_args.qp_type, wqe,
+                         comp_ctx);
+
+        ring_read_inc(&qp->sq);
+
+        wqe = ring_next_elem_read(&qp->sq);
+    }
+
+    return 0;
+}
+
+int qp_recv(PVRDMADev *dev, __u32 qp_handle)
+{
+    RmQP *qp;
+    PvrdmaRqWqe *wqe;
+
+    qp = rm_get_qp(dev, qp_handle);
+    if (unlikely(!qp)) {
+        return -EINVAL;
+    }
+
+    /*
+    if (qp->qp_state < PVRDMA_QPS_RTR) {
+        pr_dbg("Invalid QP state for receive\n");
+        return -EINVAL;
+    }
+    */
+
+    wqe = (struct PvrdmaRqWqe *)ring_next_elem_read(&qp->rq);
+    while (wqe) {
+        CompHandlerCtx *comp_ctx;
+
+        pr_dbg("wr_id=%lld\n", wqe->hdr.wr_id);
+        wqe->hdr.num_sge = MIN(wqe->hdr.num_sge,
+                       qp->init_args.max_send_sge);
+
+        /* Prepare CQE */
+        comp_ctx = malloc(sizeof(CompHandlerCtx));
+        comp_ctx->dev = dev;
+        comp_ctx->cq_handle = qp->init_args.recv_cq_handle;
+        comp_ctx->cqe.qp = qp_handle;
+        comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
+
+        backend_recv_wqe(dev, qp->backend_qp, qp->init_args.qp_type, wqe,
+                         comp_ctx);
+
+        ring_read_inc(&qp->rq);
+
+        wqe = ring_next_elem_read(&qp->rq);
+    }
+
+    return 0;
+}
+
+void cq_poll(PVRDMADev *dev, __u32 cq_handle)
+{
+    RmCQ *cq;
+
+    cq = rm_get_cq(dev, cq_handle);
+    if (!cq) {
+        pr_dbg("Invalid CQ# %d\n", cq_handle);
+    }
+
+    backend_poll_cq(dev, cq->backend_cq);
+}
diff --git a/hw/net/pvrdma/pvrdma_qp_ops.h b/hw/net/pvrdma/pvrdma_qp_ops.h
new file mode 100644
index 0000000000..d4b84eb842
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_qp_ops.h
@@ -0,0 +1,26 @@
+/*
+ * QEMU VMWARE paravirtual RDMA QP Operations
+ *
+ * Developed by Oracle & Redhat
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
+int qp_ops_init(void);
+void qp_ops_fini(void);
+int qp_send(PVRDMADev *dev, __u32 qp_handle);
+int qp_recv(PVRDMADev *dev, __u32 qp_handle);
+void cq_poll(PVRDMADev *dev, __u32 cq_handle);
+
+#endif
diff --git a/hw/net/pvrdma/pvrdma_ring.h b/hw/net/pvrdma/pvrdma_ring.h
new file mode 100644
index 0000000000..c616cc586c
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_ring.h
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
diff --git a/hw/net/pvrdma/pvrdma_rm.c b/hw/net/pvrdma/pvrdma_rm.c
new file mode 100644
index 0000000000..07b5ce1ccc
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_rm.c
@@ -0,0 +1,791 @@
+#include "pvrdma_backend.h"
+#include "pvrdma_utils.h"
+#include "pvrdma_rm_defs.h"
+#include "pvrdma_rm.h"
+#include <qemu/bitmap.h>
+#include <qemu/atomic.h>
+#include "qapi/error.h"
+#include <qemu/cutils.h>
+#include "qemu/error-report.h"
+#include <cpu.h>
+
+/* Page directory and page tables */
+#define PG_DIR_SZ { TARGET_PAGE_SIZE / sizeof(__u64) }
+#define PG_TBL_SZ { TARGET_PAGE_SIZE / sizeof(__u64) }
+
+static inline int res_tbl_init(const char *name, RmResTbl *tbl, u32 tbl_sz,
+                               u32 res_sz)
+{
+    tbl->tbl = malloc(tbl_sz * res_sz);
+    if (!tbl->tbl) {
+        return -ENOMEM;
+    }
+
+    strncpy(tbl->name, name, MAX_RING_NAME_SZ);
+    tbl->name[MAX_RING_NAME_SZ - 1] = 0;
+
+    tbl->bitmap = bitmap_new(tbl_sz);
+    tbl->tbl_sz = tbl_sz;
+    tbl->res_sz = res_sz;
+    qemu_mutex_init(&tbl->lock);
+
+    return 0;
+}
+
+static inline void res_tbl_free(RmResTbl *tbl)
+{
+    qemu_mutex_destroy(&tbl->lock);
+    free(tbl->tbl);
+    bitmap_zero_extend(tbl->bitmap, tbl->tbl_sz, 0);
+}
+
+static inline void *res_tbl_get(RmResTbl *tbl, u32 handle)
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
+static inline void *res_tbl_alloc(RmResTbl *tbl, u32 *handle)
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
+static inline void res_tbl_dealloc(RmResTbl *tbl, u32 handle)
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
+int rm_alloc_pd(PVRDMADev *dev, __u32 *pd_handle, __u32 ctx_handle)
+{
+    RmPD *pd;
+    int ret = -ENOMEM;
+
+    pd = res_tbl_alloc(&dev->pd_tbl, pd_handle);
+    if (!pd) {
+        goto out;
+    }
+
+    pd->backend_pd = malloc(sizeof *pd->backend_pd);
+    if (!pd->backend_pd) {
+        goto out_tbl_dealloc;
+    }
+
+    ret = backend_create_pd(&dev->backend_dev, pd->backend_pd);
+    if (ret) {
+        ret = -EIO;
+        goto out_free_backend_pd;
+    }
+
+    pd->ctx_handle = ctx_handle;
+
+    return 0;
+
+out_free_backend_pd:
+    free(pd->backend_pd);
+
+out_tbl_dealloc:
+    res_tbl_dealloc(&dev->pd_tbl, *pd_handle);
+
+out:
+    return ret;
+}
+
+RmPD *rm_get_pd(PVRDMADev *dev, __u32 pd_handle)
+{
+    return res_tbl_get(&dev->pd_tbl, pd_handle);
+}
+
+void rm_dealloc_pd(PVRDMADev *dev, __u32 pd_handle)
+{
+    RmPD *pd = rm_get_pd(dev, pd_handle);
+
+    if (pd) {
+        backend_destroy_pd(pd->backend_pd);
+        free(pd->backend_pd);
+        res_tbl_dealloc(&dev->pd_tbl, pd_handle);
+    }
+}
+
+static int init_user_mr(PCIDevice *pdev, RmMR *mr, u64 guest_start,
+                        u64 guest_length, u64 pdir_dma, u32 nchunks)
+{
+    mr->user_mr.host_virt = (u64)map_to_pdir(pdev, pdir_dma, nchunks,
+                                             guest_length);
+    if (!mr->user_mr.host_virt) {
+        return -EINVAL;
+    }
+    pr_dbg("host_virt=0x%lx\n", mr->user_mr.host_virt);
+
+    mr->user_mr.length = guest_length;
+    mr->user_mr.guest_start = guest_start;
+    pr_dbg("guest_start=0x%lx\n", mr->user_mr.guest_start);
+
+    return 0;
+}
+
+int rm_alloc_mr(PVRDMADev *dev, struct pvrdma_cmd_create_mr *cmd,
+                struct pvrdma_cmd_create_mr_resp *resp)
+{
+    RmMR *mr;
+    int ret = 0;
+    RmPD *pd;
+    u64 addr;
+    size_t length;
+    PCIDevice *pdev = PCI_DEVICE(dev);
+
+    pr_dbg("length=%ld\n", cmd->length);
+
+    pd = rm_get_pd(dev, cmd->pd_handle);
+    if (!pd) {
+        pr_dbg("Invalid PD\n");
+        ret = -EINVAL;
+        goto out;
+    }
+
+    pr_dbg("flags=0x%x\n", cmd->flags);
+    pr_dbg("start=0x%lx\n", cmd->start);
+    pr_dbg("nchunks=%d\n", cmd->nchunks);
+
+    mr = res_tbl_alloc(&dev->mr_tbl, &resp->mr_handle);
+    if (!mr) {
+        pr_dbg("Fail to allocate obj in table\n");
+        ret = -ENOMEM;
+        goto out;
+    }
+
+    mr->backend_mr = malloc(sizeof *mr->backend_mr);
+    if (!mr->backend_mr) {
+        pr_dbg("Fail to allocate memory\n");
+        ret = -ENOMEM;
+        goto out_dealloc_mr;
+    }
+
+    if (cmd->flags == PVRDMA_MR_FLAG_DMA) {
+        /* TODO: This is my guess but not so sure that this needs to be
+         * done */
+        length = mr->length = TARGET_PAGE_SIZE;
+        addr = mr->addr = (u64)malloc(length);
+    } else {
+        mr->addr = 0;
+        ret = init_user_mr(pdev, mr, cmd->start, cmd->length, cmd->pdir_dma,
+                           cmd->nchunks);
+        if (ret) {
+            goto out_free_backend_mr;
+        }
+        length = mr->user_mr.length;
+        addr = mr->user_mr.host_virt;
+    }
+
+    ret = backend_create_mr(mr->backend_mr, pd->backend_pd, addr, length,
+                            cmd->access_flags);
+    if (ret) {
+        pr_dbg("Fail in backend_create_mr, err=%d\n", ret);
+        ret = -EIO;
+        goto out_unmap_pdir;
+    }
+
+    if (cmd->flags == PVRDMA_MR_FLAG_DMA) {
+        resp->lkey = mr->lkey = backend_mr_lkey(mr->backend_mr);
+        resp->rkey = mr->rkey = backend_mr_rkey(mr->backend_mr);
+    } else {
+        /* We keep mr_handle in lkey so send and recv get get mr ptr */
+        resp->lkey = resp->mr_handle;
+        resp->rkey = -1;
+    }
+
+    mr->pd_handle = cmd->pd_handle;
+
+    return 0;
+
+out_unmap_pdir:
+    munmap((void *)mr->user_mr.host_virt, cmd->length);
+
+out_free_backend_mr:
+    free(mr->backend_mr);
+
+out_dealloc_mr:
+    res_tbl_dealloc(&dev->mr_tbl, resp->mr_handle);
+
+out:
+    return ret;
+}
+
+RmMR *rm_get_mr(PVRDMADev *dev, __u32 mr_handle)
+{
+    return res_tbl_get(&dev->mr_tbl, mr_handle);
+}
+
+void rm_dealloc_mr(PVRDMADev *dev, __u32 mr_handle)
+{
+    RmMR *mr = rm_get_mr(dev, mr_handle);
+
+    if (mr) {
+        backend_destroy_mr(mr->backend_mr);
+        munmap((void *)mr->user_mr.host_virt, mr->user_mr.length);
+        free((void *)mr->addr);
+        free(mr->backend_mr);
+        res_tbl_dealloc(&dev->mr_tbl, mr_handle);
+    }
+}
+
+int rm_alloc_uc(PVRDMADev *dev, u32 pfn, u32 *uc_handle)
+{
+    RmUC *uc;
+
+    /* TODO: Need to make sure pfn is between bar start address and
+     * bsd+RDMA_BAR2_UAR_SIZE
+    if (pfn > RDMA_BAR2_UAR_SIZE) {
+        pr_err("pfn out of range (%d > %d)\n", pfn, RDMA_BAR2_UAR_SIZE);
+        return -ENOMEM;
+    }
+    */
+
+    uc = res_tbl_alloc(&dev->uc_tbl, uc_handle);
+    if (!uc) {
+        return -ENOMEM;
+    }
+
+    return 0;
+}
+
+RmUC *rm_get_uc(PVRDMADev *dev, u32 uc_handle)
+{
+    return res_tbl_get(&dev->uc_tbl, uc_handle);
+}
+
+void rm_dealloc_uc(PVRDMADev *dev, u32 uc_handle)
+{
+    RmUC *uc = rm_get_uc(dev, uc_handle);
+
+    if (uc) {
+        res_tbl_dealloc(&dev->uc_tbl, uc_handle);
+    }
+}
+
+RmCQ *rm_get_cq(PVRDMADev *dev, __u32 cq_handle)
+{
+    return res_tbl_get(&dev->cq_tbl, cq_handle);
+}
+
+int rm_alloc_cq(PVRDMADev *dev, struct pvrdma_cmd_create_cq *cmd,
+                struct pvrdma_cmd_create_cq_resp *resp)
+{
+    int rc = -ENOMEM;
+    RmCQ *cq;
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    __u64 *dir = 0, *tbl = 0;
+    char ring_name[MAX_RING_NAME_SZ];
+    u32 cqe;
+
+    cq = res_tbl_alloc(&dev->cq_tbl, &resp->cq_handle);
+    if (!cq) {
+        return -ENOMEM;
+    }
+
+    memcpy(&cq->init_args, cmd, sizeof(*cmd));
+    cq->comp_type = CCT_NONE;
+
+    /* Get pointer to CQ */
+    dir = pvrdma_pci_dma_map(pci_dev, cq->init_args.pdir_dma, TARGET_PAGE_SIZE);
+    if (!dir) {
+        pr_err("Fail to map to CQ page directory\n");
+        goto out_free_cq;
+    }
+    tbl = pvrdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
+    if (!tbl) {
+        pr_err("Fail to map to CQ page table\n");
+        goto out_free_cq;
+    }
+
+    cq->ring_state = (struct pvrdma_ring *)
+            pvrdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
+    if (!cq->ring_state) {
+        pr_err("Fail to map to CQ header page\n");
+        goto out_free_cq;
+    }
+
+    sprintf(ring_name, "cq%d", resp->cq_handle);
+    cqe = MIN(cmd->cqe, dev->dsr_info.dsr->caps.max_cqe);
+    rc = ring_init(&cq->cq, ring_name, pci_dev, &cq->ring_state[1],
+                   cqe, sizeof(struct pvrdma_cqe), (dma_addr_t *)&tbl[1],
+                   cmd->nchunks - 1 /* first page is ring state */);
+    if (rc != 0) {
+        pr_err("Fail to initialize CQ ring\n");
+        goto out_free_ring_state;
+    }
+
+    cq->backend_cq = malloc(sizeof *cq->backend_cq);
+    if (!cq->backend_cq) {
+        goto out_free_ring_state;
+    }
+
+    rc = backend_create_cq(&dev->backend_dev, cq->backend_cq, cqe);
+    if (rc) {
+        rc = -EIO;
+        goto out_free_backend_cq;
+    }
+
+    resp->cqe = cmd->cqe;
+
+    goto out;
+
+out_free_backend_cq:
+    free(cq->backend_cq);
+
+out_free_ring_state:
+    pvrdma_pci_dma_unmap(pci_dev, cq->ring_state, TARGET_PAGE_SIZE);
+
+out_free_cq:
+    rm_dealloc_cq(dev, resp->cq_handle);
+
+out:
+    pvrdma_pci_dma_unmap(pci_dev, tbl, TARGET_PAGE_SIZE);
+    pvrdma_pci_dma_unmap(pci_dev, dir, TARGET_PAGE_SIZE);
+
+    return rc;
+}
+
+void rm_req_notify_cq(PVRDMADev *dev, __u32 cq_handle, u32 flags)
+{
+    RmCQ *cq;
+
+    pr_dbg("cq_handle=%d, flags=0x%x\n", cq_handle, flags);
+
+    cq = rm_get_cq(dev, cq_handle);
+    if (!cq) {
+        return;
+    }
+
+    cq->comp_type = (flags & PVRDMA_UAR_CQ_ARM_SOL) ? CCT_SOLICITED :
+                     CCT_NEXT_COMP;
+    pr_dbg("comp_type=%d\n", cq->comp_type);
+}
+
+void rm_dealloc_cq(PVRDMADev *dev, __u32 cq_handle)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    RmCQ *cq;
+
+    cq = rm_get_cq(dev, cq_handle);
+    if (!cq) {
+        return;
+    }
+
+    backend_destroy_cq(cq->backend_cq);
+    free(cq->backend_cq);
+
+    ring_free(&cq->cq);
+
+    pvrdma_pci_dma_unmap(pci_dev, cq->ring_state, TARGET_PAGE_SIZE);
+
+    res_tbl_dealloc(&dev->cq_tbl, cq_handle);
+}
+
+RmQP *rm_get_qp(PVRDMADev *dev, u32 qpn)
+{
+    GBytes *key = g_bytes_new(&qpn, sizeof(qpn));
+
+    RmQP *qp = g_hash_table_lookup(dev->qp_hash, key);
+
+    g_bytes_unref(key);
+
+    return qp;
+}
+
+int rm_alloc_qp(PVRDMADev *dev, struct pvrdma_cmd_create_qp *cmd,
+                struct pvrdma_cmd_create_qp_resp *resp)
+{
+    int rc = 0;
+    RmQP *qp;
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    __u64 *dir = 0, *tbl = 0;
+    int wqe_size;
+    char ring_name[MAX_RING_NAME_SZ];
+    RmCQ *scq, *rcq;
+    RmPD *pd;
+    u32 rm_qpn;
+
+    pd = rm_get_pd(dev, cmd->pd_handle);
+    if (!pd) {
+        pr_err("Invalid pd handle (%d)\n", cmd->pd_handle);
+        return -EINVAL;
+    }
+
+    scq = rm_get_cq(dev, cmd->send_cq_handle);
+    rcq = rm_get_cq(dev, cmd->recv_cq_handle);
+
+    if (!scq || !rcq) {
+        pr_err("Invalid send_cqn or recv_cqn (%d, %d)\n",
+               cmd->send_cq_handle, cmd->recv_cq_handle);
+        return -EINVAL;
+    }
+
+    qp = res_tbl_alloc(&dev->qp_tbl, &rm_qpn);
+    if (!qp) {
+        return -ENOMEM;
+    }
+    qp->qpn = rm_qpn;
+    pr_dbg("rm_qpn=%d\n", qp->qpn);
+
+    memcpy(&qp->init_args, cmd, sizeof(*cmd));
+
+    qp->qp_state = PVRDMA_QPS_ERR;
+
+    /* Get pointer to send & recv rings */
+    dir = pvrdma_pci_dma_map(pci_dev, qp->init_args.pdir_dma, TARGET_PAGE_SIZE);
+    if (!dir) {
+        pr_err("Fail to map to QP page directory\n");
+        rc = -ENOMEM;
+        goto out_free_qp;
+    }
+    tbl = pvrdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
+    if (!tbl) {
+        pr_err("Fail to map to QP page table\n");
+        rc = -ENOMEM;
+        goto out_free_dir;
+    }
+
+    /* Send ring */
+    qp->sq_ring_state = (struct pvrdma_ring *)
+            pvrdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
+    if (!qp->sq_ring_state) {
+        pr_err("Fail to map to QP header page\n");
+        rc = -ENOMEM;
+        goto out_free_tbl;
+    }
+
+    wqe_size = roundup_pow_of_two(sizeof(struct pvrdma_sq_wqe_hdr) +
+                                  sizeof(struct pvrdma_sge) *
+                                  qp->init_args.max_send_sge - 1);
+    sprintf(ring_name, "qp%d_sq", rm_qpn);
+    rc = ring_init(&qp->sq, ring_name, pci_dev, qp->sq_ring_state,
+                   qp->init_args.max_send_wr, wqe_size,
+                   (dma_addr_t *)&tbl[1], cmd->send_chunks);
+    if (rc != 0) {
+        pr_err("Fail to initialize SQ ring\n");
+        rc = -ENOMEM;
+        goto out_free_ring_state;
+    }
+
+    /* Recv ring */
+    qp->rq_ring_state = &qp->sq_ring_state[1];
+    wqe_size = roundup_pow_of_two(sizeof(struct pvrdma_rq_wqe_hdr) +
+                                  sizeof(struct pvrdma_sge) *
+                                  qp->init_args.max_recv_sge - 1);
+    pr_dbg("wqe_size=%d\n", wqe_size);
+    pr_dbg("pvrdma_rq_wqe_hdr=%ld\n", sizeof(struct pvrdma_rq_wqe_hdr));
+    pr_dbg("pvrdma_sge=%ld\n", sizeof(struct pvrdma_sge));
+    pr_dbg("init_args.max_recv_sge=%d\n", qp->init_args.max_recv_sge);
+    sprintf(ring_name, "qp%d_rq", rm_qpn);
+    rc = ring_init(&qp->rq, ring_name, pci_dev, qp->rq_ring_state,
+                   qp->init_args.max_recv_wr, wqe_size,
+                   (dma_addr_t *)&tbl[2], cmd->total_chunks -
+                   cmd->send_chunks - 1 /* first page is ring state */);
+    if (rc != 0) {
+        pr_err("Fail to initialize RQ ring\n");
+        rc = -ENOMEM;
+        goto out_free_send_ring;
+    }
+
+    qp->backend_qp = malloc(sizeof *qp->backend_qp);
+    if (!qp->backend_qp) {
+        rc = -ENOMEM;
+        goto out_free_recv_ring;
+    }
+
+    rc = backend_create_qp(qp->backend_qp, qp->init_args.qp_type,
+                           pd->backend_pd, scq->backend_cq, rcq->backend_cq,
+                           qp->init_args.max_send_wr, qp->init_args.max_recv_wr,
+                           qp->init_args.max_send_sge,
+                           qp->init_args.max_recv_sge);
+    if (rc) {
+        rc = -EIO;
+        goto out_free_backend_qp;
+    }
+
+    resp->qpn = backend_qpn(qp->backend_qp);
+    pr_dbg("rm_qpn=%d, backend_qpn=0x%x\n", rm_qpn, resp->qpn);
+    g_hash_table_insert(dev->qp_hash, g_bytes_new(&resp->qpn, sizeof(rm_qpn)),
+                        qp);
+
+    resp->max_send_wr = cmd->max_send_wr;
+    resp->max_recv_wr = cmd->max_recv_wr;
+    resp->max_send_sge = cmd->max_send_sge;
+    resp->max_recv_sge = cmd->max_recv_sge;
+    resp->max_inline_data = cmd->max_inline_data;
+
+    return 0;
+
+out_free_backend_qp:
+    free(qp->backend_qp);
+
+out_free_recv_ring:
+    ring_free(&qp->rq);
+
+out_free_send_ring:
+    ring_free(&qp->sq);
+
+out_free_ring_state:
+    pvrdma_pci_dma_unmap(pci_dev, qp->sq_ring_state, TARGET_PAGE_SIZE);
+
+out_free_tbl:
+    pvrdma_pci_dma_unmap(pci_dev, tbl, TARGET_PAGE_SIZE);
+
+out_free_dir:
+    pvrdma_pci_dma_unmap(pci_dev, dir, TARGET_PAGE_SIZE);
+
+out_free_qp:
+    res_tbl_dealloc(&dev->qp_tbl, qp->qpn);
+
+    return rc;
+}
+
+int rm_modify_qp(PVRDMADev *dev, __u32 qp_handle,
+                 struct pvrdma_cmd_modify_qp *modify_qp_args)
+{
+    RmQP *qp;
+    int ret;
+    struct pvrdma_qp_attr *attrs = &modify_qp_args->attrs;
+    u32 qkey = 0;
+
+    pr_dbg("qpn=%d\n", qp_handle);
+
+    qp = rm_get_qp(dev, qp_handle);
+    if (!qp) {
+        return -EINVAL;
+    }
+
+    pr_dbg("qp_type=%d\n", qp->init_args.qp_type);
+
+    if (modify_qp_args->attr_mask & PVRDMA_QP_PORT) {
+        qp->port_num = attrs->port_num;
+        pr_dbg("port_num=%d\n", qp->port_num);
+    }
+    if (modify_qp_args->attr_mask & PVRDMA_QP_DEST_QPN) {
+        qp->dqpn = attrs->dest_qp_num;
+        pr_dbg("dqpn=%d\n", qp->dqpn);
+    }
+    if (modify_qp_args->attr_mask & PVRDMA_QP_AV) {
+        qp->dgid = attrs->ah_attr.grh.dgid;
+        pr_dbg("dgid.if_id  0x%lx\n",
+               be64_to_cpu(qp->dgid.global.interface_id));
+        pr_dbg("dgid.subnet 0x%lx\n",
+               be64_to_cpu(qp->dgid.global.subnet_prefix));
+        qp->port_num = attrs->ah_attr.port_num;
+        pr_dbg("port_num=%d\n", qp->port_num);
+    }
+    if (modify_qp_args->attr_mask & PVRDMA_QP_QKEY) {
+        qkey = attrs->qkey;
+        pr_dbg("qkey=%u\n", qkey);
+    }
+
+    /* Do state change only after all configuration above are done */
+    if (modify_qp_args->attr_mask & PVRDMA_QP_STATE) {
+        qp->qp_state = attrs->qp_state;
+        pr_dbg("qp_state=%d\n", qp->qp_state);
+
+        if (qp->qp_state == PVRDMA_QPS_INIT) {
+            ret = backend_qp_state_init(&dev->backend_dev, qp->backend_qp,
+                                        qp->init_args.qp_type, qkey);
+            if (ret) {
+                return -EIO;
+            }
+        }
+
+        if (qp->qp_state == PVRDMA_QPS_RTR) {
+            ret = backend_qp_state_rtr(&dev->backend_dev, qp->backend_qp,
+                                       qp->init_args.qp_type,
+                                       dev->backend_gid_idx, &qp->dgid,
+                                       qp->dqpn, attrs->rq_psn, qkey);
+            if (ret) {
+                return -EIO;
+            }
+        }
+
+        if (qp->qp_state == PVRDMA_QPS_RTS) {
+            ret = backend_qp_state_rts(qp->backend_qp, qp->init_args.qp_type,
+                                       attrs->sq_psn, qkey);
+            if (ret) {
+                return -EIO;
+            }
+        }
+    }
+
+    return 0;
+}
+
+void rm_dealloc_qp(PVRDMADev *dev, __u32 qp_handle)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    RmQP *qp;
+
+    qp = rm_get_qp(dev, qp_handle);
+    if (!qp) {
+        return;
+    }
+
+    backend_destroy_qp(qp->backend_qp);
+    free(qp->backend_qp);
+
+    ring_free(&qp->rq);
+    ring_free(&qp->sq);
+
+    pvrdma_pci_dma_unmap(pci_dev, qp->sq_ring_state, TARGET_PAGE_SIZE);
+
+    res_tbl_dealloc(&dev->qp_tbl, qp->qpn);
+}
+
+void *rm_get_cqe_ctx(PVRDMADev *dev, u32 cqe_ctx_id)
+{
+    void **cqe_ctx;
+
+    cqe_ctx = res_tbl_get(&dev->cqe_ctx_tbl, cqe_ctx_id);
+    if (!cqe_ctx) {
+        return NULL;
+    }
+
+    pr_dbg("ctx=%p\n", *cqe_ctx);
+
+    return *cqe_ctx;
+}
+
+int rm_alloc_cqe_ctx(PVRDMADev *dev, u32 *cqe_ctx_id, void *ctx)
+{
+    void **cqe_ctx;
+
+    cqe_ctx = res_tbl_alloc(&dev->cqe_ctx_tbl, cqe_ctx_id);
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
+void rm_dealloc_cqe_ctx(PVRDMADev *dev, u32 cqe_ctx_id)
+{
+    res_tbl_dealloc(&dev->cqe_ctx_tbl, cqe_ctx_id);
+}
+
+static void delete_qp_num(gpointer data)
+{
+    g_bytes_unref(data);
+}
+
+int rm_init(PVRDMADev *dev, Error **errp)
+{
+    int ret = 0;
+
+    ret = res_tbl_init("PD", &dev->pd_tbl, dev->dev_attr.max_pd,
+                       sizeof(RmPD));
+    if (ret != 0) {
+        goto out;
+    }
+
+    ret = res_tbl_init("CQ", &dev->cq_tbl, dev->dev_attr.max_cq,
+                       sizeof(RmCQ));
+    if (ret != 0) {
+        goto cln_pds;
+    }
+
+    ret = res_tbl_init("MR", &dev->mr_tbl, dev->dev_attr.max_mr,
+                       sizeof(RmMR));
+    if (ret != 0) {
+        goto cln_cqs;
+    }
+
+    ret = res_tbl_init("QP", &dev->qp_tbl, dev->dev_attr.max_qp,
+                       sizeof(RmQP));
+    if (ret != 0) {
+        goto cln_mrs;
+    }
+
+    ret = res_tbl_init("CQE_CTX", &dev->cqe_ctx_tbl,
+                       dev->dev_attr.max_qp *
+                       dev->dev_attr.max_qp_wr, sizeof(void *));
+    if (ret != 0) {
+        goto cln_qps;
+    }
+
+    ret = res_tbl_init("UC", &dev->uc_tbl, MAX_UCS, sizeof(RmUC));
+    if (ret != 0) {
+        goto cln_cqe_ctxs;
+    }
+
+    dev->qp_hash = g_hash_table_new_full(g_bytes_hash, g_bytes_equal, NULL,
+                                         delete_qp_num);
+    if (!dev->qp_hash) {
+        goto cln_ucs;
+    }
+
+    goto out;
+
+cln_ucs:
+    res_tbl_free(&dev->uc_tbl);
+
+cln_cqe_ctxs:
+    res_tbl_free(&dev->cqe_ctx_tbl);
+
+cln_qps:
+    res_tbl_free(&dev->qp_tbl);
+
+cln_mrs:
+    res_tbl_free(&dev->mr_tbl);
+
+cln_cqs:
+    res_tbl_free(&dev->cq_tbl);
+
+cln_pds:
+    res_tbl_free(&dev->pd_tbl);
+
+out:
+    if (ret != 0) {
+        error_setg(errp, "Fail to initialize RM");
+    }
+
+    return ret;
+}
+
+void rm_fini(PVRDMADev *dev)
+{
+    res_tbl_free(&dev->uc_tbl);
+    res_tbl_free(&dev->cqe_ctx_tbl);
+    res_tbl_free(&dev->qp_tbl);
+    res_tbl_free(&dev->cq_tbl);
+    res_tbl_free(&dev->mr_tbl);
+    res_tbl_free(&dev->pd_tbl);
+    g_hash_table_destroy(dev->qp_hash);
+}
diff --git a/hw/net/pvrdma/pvrdma_rm.h b/hw/net/pvrdma/pvrdma_rm.h
new file mode 100644
index 0000000000..f655a9a35a
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_rm.h
@@ -0,0 +1,54 @@
+/*
+ * QEMU VMWARE paravirtual RDMA - Resource Manager
+ *
+ * Developed by Oracle & Redhat
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
+#ifndef PVRDMA_RM_H
+#define PVRDMA_RM_H
+
+#include "pvrdma.h"
+#include "pvrdma_rm_defs.h"
+
+int rm_init(PVRDMADev *dev, Error **errp);
+void rm_fini(PVRDMADev *dev);
+
+int rm_alloc_pd(PVRDMADev *dev, __u32 *pd_handle, __u32 ctx_handle);
+RmPD *rm_get_pd(PVRDMADev *dev, __u32 pd_handle);
+void rm_dealloc_pd(PVRDMADev *dev, __u32 pd_handle);
+
+int rm_alloc_mr(PVRDMADev *dev, struct pvrdma_cmd_create_mr *cmd,
+        struct pvrdma_cmd_create_mr_resp *resp);
+RmMR *rm_get_mr(PVRDMADev *dev, __u32 mr_handle);
+void rm_dealloc_mr(PVRDMADev *dev, __u32 mr_handle);
+
+int rm_alloc_uc(PVRDMADev *dev, u32 pfn, u32 *uc_handle);
+RmUC *rm_get_uc(PVRDMADev *dev, u32 uc_handle);
+void rm_dealloc_uc(PVRDMADev *dev, u32 uc_handle);
+
+int rm_alloc_cq(PVRDMADev *dev, struct pvrdma_cmd_create_cq *cmd,
+        struct pvrdma_cmd_create_cq_resp *resp);
+RmCQ *rm_get_cq(PVRDMADev *dev, __u32 cq_handle);
+void rm_req_notify_cq(PVRDMADev *dev, __u32 cq_handle, u32 flags);
+void rm_dealloc_cq(PVRDMADev *dev, __u32 cq_handle);
+
+int rm_alloc_qp(PVRDMADev *dev, struct pvrdma_cmd_create_qp *cmd,
+        struct pvrdma_cmd_create_qp_resp *resp);
+RmQP *rm_get_qp(PVRDMADev *dev, u32 qpn);
+int rm_modify_qp(PVRDMADev *dev, __u32 qp_handle,
+         struct pvrdma_cmd_modify_qp *modify_qp_args);
+void rm_dealloc_qp(PVRDMADev *dev, __u32 qp_handle);
+
+int rm_alloc_cqe_ctx(PVRDMADev *dev, u32 *cqe_ctx_id, void *ctx);
+void *rm_get_cqe_ctx(PVRDMADev *dev, u32 cqe_ctx_id);
+void rm_dealloc_cqe_ctx(PVRDMADev *dev, u32 cqe_ctx_id);
+
+#endif
diff --git a/hw/net/pvrdma/pvrdma_rm_defs.h b/hw/net/pvrdma/pvrdma_rm_defs.h
new file mode 100644
index 0000000000..e1a3501083
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_rm_defs.h
@@ -0,0 +1,111 @@
+/*
+ * QEMU VMWARE paravirtual RDMA - Resource Manager
+ *
+ * Developed by Oracle & Redhat
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
+#ifndef PVRDMA_RM_DEFS_H
+#define PVRDMA_RM_DEFS_H
+
+#include "pvrdma_dev_api.h"
+#include "pvrdma_backend_defs.h"
+#include "pvrdma_dev_ring.h"
+
+#define MAX_PORTS             1 /* Driver force to 1 see pvrdma_add_gid */
+#define MAX_PORT_GIDS         1
+#define MAX_PORT_PKEYS        1
+#define MAX_PKEYS             1
+#define MAX_GIDS              2048
+#define MAX_UCS               1024
+#define MAX_MR_SIZE           (1UL << 32)
+#define MAX_QP                1024
+#define MAX_SGE               4
+#define MAX_CQ                2048
+#define MAX_MR                2048
+#define MAX_PD                1024
+#define MAX_QP_RD_ATOM        16
+#define MAX_QP_INIT_RD_ATOM   16
+#define MAX_AH                64
+
+#define MAX_RMRESTBL_NAME_SZ 16
+typedef struct RmResTbl {
+    char name[MAX_RMRESTBL_NAME_SZ];
+    unsigned long *bitmap;
+    size_t tbl_sz;
+    size_t res_sz;
+    void *tbl;
+    QemuMutex lock;
+} RmResTbl;
+
+enum cq_comp_type {
+    CCT_NONE,
+    CCT_SOLICITED,
+    CCT_NEXT_COMP,
+};
+
+typedef struct RmPD {
+    __u32 ctx_handle;
+    BackendPD *backend_pd;
+} RmPD;
+
+typedef struct RmCQ {
+    struct pvrdma_cmd_create_cq init_args;
+    struct pvrdma_ring *ring_state;
+    Ring cq;
+    enum cq_comp_type comp_type;
+    BackendCQ *backend_cq;
+} RmCQ;
+
+typedef struct RmUserMR {
+    u64 host_virt;
+    u64 guest_start;
+    size_t length;
+} RmUserMR;
+
+/* MR (DMA region) */
+typedef struct RmMR {
+    __u32 pd_handle;
+    __u32 lkey;
+    __u32 rkey;
+    BackendMR *backend_mr;
+    RmUserMR user_mr;
+    /* Next two are used only if PVRDMA_MR_FLAG_DMA is used */
+    u64 addr;
+    size_t length;
+} RmMR;
+
+typedef struct RmUC {
+    u64 uc_handle;
+} RmUC;
+
+typedef struct RmQP {
+    struct pvrdma_cmd_create_qp init_args;
+    enum pvrdma_qp_state qp_state;
+    u8 port_num;
+    union pvrdma_gid dgid;
+    u32 qpn;
+    u32 dqpn;
+
+    struct pvrdma_ring *sq_ring_state;
+    Ring sq;
+    struct pvrdma_ring *rq_ring_state;
+    Ring rq;
+
+    BackendQP *backend_qp;
+} RmQP;
+
+typedef struct RmPort {
+    enum pvrdma_port_state state;
+    union pvrdma_gid gid_tbl[MAX_PORT_GIDS];
+    int *pkey_tbl; /* TODO: Not yet supported */
+} RmPort;
+
+#endif
diff --git a/hw/net/pvrdma/pvrdma_types.h b/hw/net/pvrdma/pvrdma_types.h
new file mode 100644
index 0000000000..22c78e4733
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_types.h
@@ -0,0 +1,37 @@
+/*
+ * QEMU VMWARE paravirtual RDMA interface definitions
+ *
+ * Developed by Oracle & Redhat
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
diff --git a/hw/net/pvrdma/pvrdma_utils.c b/hw/net/pvrdma/pvrdma_utils.c
new file mode 100644
index 0000000000..44c7ba12a4
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_utils.c
@@ -0,0 +1,133 @@
+#include <qemu/osdep.h>
+#include <qemu/error-report.h>
+#include <cpu.h>
+#include <hw/pci/pci.h>
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
+void *map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma, uint32_t nchunks,
+                  size_t length)
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
+            error_report("PVRDMA: Fail to map to page %d, dir %d", tbl_idx, dir_idx);
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
diff --git a/hw/net/pvrdma/pvrdma_utils.h b/hw/net/pvrdma/pvrdma_utils.h
new file mode 100644
index 0000000000..a09e39946c
--- /dev/null
+++ b/hw/net/pvrdma/pvrdma_utils.h
@@ -0,0 +1,41 @@
+/*
+ * QEMU VMWARE paravirtual RDMA interface definitions
+ *
+ * Developed by Oracle & Redhat
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
+void pvrdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);
+void *pvrdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen);
+void *map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma, uint32_t nchunks,
+                  size_t length);
+
+#endif
diff --git a/hw/net/pvrdma/trace-events b/hw/net/pvrdma/trace-events
new file mode 100644
index 0000000000..bbc52286bc
--- /dev/null
+++ b/hw/net/pvrdma/trace-events
@@ -0,0 +1,9 @@
+# See docs/tracing.txt for syntax documentation.
+
+# hw/net/pvrdma/pvrdma_main.c
+pvrdma_regs_read(uint64_t addr, uint64_t val) "regs[0x%lx] = 0x%lx"
+pvrdma_regs_write(uint64_t addr, uint64_t val) "regs[0x%lx] = 0x%lx"
+
+#hw/net/pvrdma/pvrdma_backend.c
+create_ah_cache_hit(uint64_t subnet, uint64_t net_id) "subnet = 0x%lx net_id = 0x%lx"
+create_ah_cache_miss(uint64_t subnet, uint64_t net_id) "subnet = 0x%lx net_id = 0x%lx"
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
