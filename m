Received: from eggs.gnu.org ([209.51.188.92]:47576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2u6J-0000fh-Qj
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2u6I-0007SK-5Z
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1h2u6H-0007RZ-SI
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:30 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun, 10 Mar 2019 10:46:05 +0200
Message-Id: <20190310084610.23077-6-yuval.shaia@oracle.com>
In-Reply-To: <20190310084610.23077-1-yuval.shaia@oracle.com>
References: <20190310084610.23077-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v5 05/10] {hmp,
 hw/pvrdma}: Expose device internals via monitor interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

Allow interrogating device internals through HMP interface.
The exposed indicators can be used for troubleshooting by developers or
sysadmin.
There is no need to expose these attributes to a management system (e.x.
libvirt) because (1) most of them are not "device-management' related
info and (2) there is no guarantee the interface is stable.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 hmp-commands-info.hx      | 14 +++++++++++
 hmp.c                     | 27 ++++++++++++++++++++
 hmp.h                     |  1 +
 hw/rdma/Makefile.objs     |  2 +-
 hw/rdma/rdma.c            | 30 ++++++++++++++++++++++
 hw/rdma/rdma_rm.c         | 53 +++++++++++++++++++++++++++++++++++++++
 hw/rdma/rdma_rm.h         |  1 +
 hw/rdma/vmw/pvrdma_main.c | 26 +++++++++++++++++++
 include/hw/rdma/rdma.h    | 40 +++++++++++++++++++++++++++++
 9 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 hw/rdma/rdma.c
 create mode 100644 include/hw/rdma/rdma.h

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index cbee8b944d..c59444c461 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -202,6 +202,20 @@ STEXI
 @item info pic
 @findex info pic
 Show PIC state.
+ETEXI
+
+    {
+        .name       = "rdma",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show RDMA state",
+        .cmd        = hmp_info_rdma,
+    },
+
+STEXI
+@item info rdma
+@findex info rdma
+Show RDMA state.
 ETEXI
 
     {
diff --git a/hmp.c b/hmp.c
index 1e006eeb49..e24e3f9d5d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -51,6 +51,7 @@
 #include "qemu/error-report.h"
 #include "exec/ramlist.h"
 #include "hw/intc/intc.h"
+#include "hw/rdma/rdma.h"
 #include "migration/snapshot.h"
 #include "migration/misc.h"
 
@@ -968,6 +969,32 @@ void hmp_info_pic(Monitor *mon, const QDict *qdict)
                                    hmp_info_pic_foreach, mon);
 }
 
+static int hmp_info_rdma_foreach(Object *obj, void *opaque)
+{
+    RdmaProvider *rdma;
+    RdmaProviderClass *k;
+    Monitor *mon = opaque;
+
+    if (object_dynamic_cast(obj, INTERFACE_RDMA_PROVIDER)) {
+        rdma = RDMA_PROVIDER(obj);
+        k = RDMA_PROVIDER_GET_CLASS(obj);
+        if (k->print_statistics) {
+            k->print_statistics(mon, rdma);
+        } else {
+            monitor_printf(mon, "RDMA statistics not available for %s.\n",
+                           object_get_typename(obj));
+        }
+    }
+
+    return 0;
+}
+
+void hmp_info_rdma(Monitor *mon, const QDict *qdict)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   hmp_info_rdma_foreach, mon);
+}
+
 void hmp_info_pci(Monitor *mon, const QDict *qdict)
 {
     PciInfoList *info_list, *info;
diff --git a/hmp.h b/hmp.h
index 5f1addcca2..666949afc3 100644
--- a/hmp.h
+++ b/hmp.h
@@ -36,6 +36,7 @@ void hmp_info_spice(Monitor *mon, const QDict *qdict);
 void hmp_info_balloon(Monitor *mon, const QDict *qdict);
 void hmp_info_irq(Monitor *mon, const QDict *qdict);
 void hmp_info_pic(Monitor *mon, const QDict *qdict);
+void hmp_info_rdma(Monitor *mon, const QDict *qdict);
 void hmp_info_pci(Monitor *mon, const QDict *qdict);
 void hmp_info_block_jobs(Monitor *mon, const QDict *qdict);
 void hmp_info_tpm(Monitor *mon, const QDict *qdict);
diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
index bd36cbf51c..c354e60e5b 100644
--- a/hw/rdma/Makefile.objs
+++ b/hw/rdma/Makefile.objs
@@ -1,5 +1,5 @@
 ifeq ($(CONFIG_PVRDMA),y)
-obj-$(CONFIG_PCI) += rdma_utils.o rdma_backend.o rdma_rm.o
+obj-$(CONFIG_PCI) += rdma_utils.o rdma_backend.o rdma_rm.o rdma.o
 obj-$(CONFIG_PCI) += vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o \
                      vmw/pvrdma_qp_ops.o vmw/pvrdma_main.o
 endif
diff --git a/hw/rdma/rdma.c b/hw/rdma/rdma.c
new file mode 100644
index 0000000000..7bec0d0d2c
--- /dev/null
+++ b/hw/rdma/rdma.c
@@ -0,0 +1,30 @@
+/*
+ * RDMA device interface
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/rdma/rdma.h"
+#include "qemu/module.h"
+
+static const TypeInfo rdma_hmp_info = {
+    .name = INTERFACE_RDMA_PROVIDER,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(RdmaProviderClass),
+};
+
+static void rdma_register_types(void)
+{
+    type_register_static(&rdma_hmp_info);
+}
+
+type_init(rdma_register_types)
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 16109b9647..e019de1a14 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "monitor/monitor.h"
 
 #include "trace.h"
 #include "rdma_utils.h"
@@ -26,6 +27,58 @@
 #define PG_DIR_SZ { TARGET_PAGE_SIZE / sizeof(__u64) }
 #define PG_TBL_SZ { TARGET_PAGE_SIZE / sizeof(__u64) }
 
+void rdma_dump_device_counters(Monitor *mon, RdmaDeviceResources *dev_res)
+{
+    monitor_printf(mon, "\ttx               : %" PRId64 "\n",
+                   dev_res->stats.tx);
+    monitor_printf(mon, "\ttx_len           : %" PRId64 "\n",
+                   dev_res->stats.tx_len);
+    monitor_printf(mon, "\ttx_err           : %" PRId64 "\n",
+                   dev_res->stats.tx_err);
+    monitor_printf(mon, "\trx_bufs          : %" PRId64 "\n",
+                   dev_res->stats.rx_bufs);
+    monitor_printf(mon, "\trx_bufs_len      : %" PRId64 "\n",
+                   dev_res->stats.rx_bufs_len);
+    monitor_printf(mon, "\trx_bufs_err      : %" PRId64 "\n",
+                   dev_res->stats.rx_bufs_err);
+    monitor_printf(mon, "\tcomps            : %" PRId64 "\n",
+                   dev_res->stats.completions);
+    monitor_printf(mon, "\tmissing_comps    : %" PRId32 "\n",
+                   dev_res->stats.missing_cqe);
+    monitor_printf(mon, "\tpoll_cq (bk)     : %" PRId64 "\n",
+                   dev_res->stats.poll_cq_from_bk);
+    monitor_printf(mon, "\tpoll_cq_ppoll_to : %" PRId64 "\n",
+                   dev_res->stats.poll_cq_ppoll_to);
+    monitor_printf(mon, "\tpoll_cq (fe)     : %" PRId64 "\n",
+                   dev_res->stats.poll_cq_from_guest);
+    monitor_printf(mon, "\tpoll_cq_empty    : %" PRId64 "\n",
+                   dev_res->stats.poll_cq_from_guest_empty);
+    monitor_printf(mon, "\tmad_tx           : %" PRId64 "\n",
+                   dev_res->stats.mad_tx);
+    monitor_printf(mon, "\tmad_tx_err       : %" PRId64 "\n",
+                   dev_res->stats.mad_tx_err);
+    monitor_printf(mon, "\tmad_rx           : %" PRId64 "\n",
+                   dev_res->stats.mad_rx);
+    monitor_printf(mon, "\tmad_rx_err       : %" PRId64 "\n",
+                   dev_res->stats.mad_rx_err);
+    monitor_printf(mon, "\tmad_rx_bufs      : %" PRId64 "\n",
+                   dev_res->stats.mad_rx_bufs);
+    monitor_printf(mon, "\tmad_rx_bufs_err  : %" PRId64 "\n",
+                   dev_res->stats.mad_rx_bufs_err);
+    monitor_printf(mon, "\tPDs              : %" PRId32 "\n",
+                   dev_res->pd_tbl.used);
+    monitor_printf(mon, "\tMRs              : %" PRId32 "\n",
+                   dev_res->mr_tbl.used);
+    monitor_printf(mon, "\tUCs              : %" PRId32 "\n",
+                   dev_res->uc_tbl.used);
+    monitor_printf(mon, "\tQPs              : %" PRId32 "\n",
+                   dev_res->qp_tbl.used);
+    monitor_printf(mon, "\tCQs              : %" PRId32 "\n",
+                   dev_res->cq_tbl.used);
+    monitor_printf(mon, "\tCEQ_CTXs         : %" PRId32 "\n",
+                   dev_res->cqe_ctx_tbl.used);
+}
+
 static inline void res_tbl_init(const char *name, RdmaRmResTbl *tbl,
                                 uint32_t tbl_sz, uint32_t res_sz)
 {
diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
index 9ec87d2667..a527d306f6 100644
--- a/hw/rdma/rdma_rm.h
+++ b/hw/rdma/rdma_rm.h
@@ -20,6 +20,7 @@
 #include "rdma_backend_defs.h"
 #include "rdma_rm_defs.h"
 
+void rdma_dump_device_counters(Monitor *mon, RdmaDeviceResources *dev_res);
 int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr,
                  Error **errp);
 void rdma_rm_fini(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index f178ba1a53..8c240e2b69 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -25,6 +25,8 @@
 #include "cpu.h"
 #include "trace.h"
 #include "sysemu/sysemu.h"
+#include "monitor/monitor.h"
+#include "hw/rdma/rdma.h"
 
 #include "../rdma_rm.h"
 #include "../rdma_backend.h"
@@ -55,6 +57,26 @@ static Property pvrdma_dev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void pvrdma_print_statistics(Monitor *mon, RdmaProvider *obj)
+{
+    PVRDMADev *dev = PVRDMA_DEV(obj);
+    PCIDevice *pdev = PCI_DEVICE(dev);
+
+    monitor_printf(mon, "%s, %x.%x\n", pdev->name, PCI_SLOT(pdev->devfn),
+                   PCI_FUNC(pdev->devfn));
+    monitor_printf(mon, "\tcommands         : %" PRId64 "\n",
+                   dev->stats.commands);
+    monitor_printf(mon, "\tregs_reads       : %" PRId64 "\n",
+                   dev->stats.regs_reads);
+    monitor_printf(mon, "\tregs_writes      : %" PRId64 "\n",
+                   dev->stats.regs_writes);
+    monitor_printf(mon, "\tuar_writes       : %" PRId64 "\n",
+                   dev->stats.uar_writes);
+    monitor_printf(mon, "\tinterrupts       : %" PRId64 "\n",
+                   dev->stats.interrupts);
+    rdma_dump_device_counters(mon, &dev->rdma_dev_res);
+}
+
 static void free_dev_ring(PCIDevice *pci_dev, PvrdmaRing *ring,
                           void *ring_state)
 {
@@ -639,6 +661,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    RdmaProviderClass *ir = INTERFACE_RDMA_PROVIDER_CLASS(klass);
 
     k->realize = pvrdma_realize;
     k->exit = pvrdma_exit;
@@ -650,6 +673,8 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
     dc->desc = "RDMA Device";
     dc->props = pvrdma_dev_properties;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+
+    ir->print_statistics = pvrdma_print_statistics;
 }
 
 static const TypeInfo pvrdma_info = {
@@ -659,6 +684,7 @@ static const TypeInfo pvrdma_info = {
     .class_init = pvrdma_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { INTERFACE_RDMA_PROVIDER },
         { }
     }
 };
diff --git a/include/hw/rdma/rdma.h b/include/hw/rdma/rdma.h
new file mode 100644
index 0000000000..68290fb58c
--- /dev/null
+++ b/include/hw/rdma/rdma.h
@@ -0,0 +1,40 @@
+/*
+ * RDMA device interface
+ *
+ * Copyright (C) 2019 Oracle
+ * Copyright (C) 2019 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef RDMA_H
+#define RDMA_H
+
+#include "qom/object.h"
+
+#define INTERFACE_RDMA_PROVIDER "rdma"
+
+#define INTERFACE_RDMA_PROVIDER_CLASS(klass) \
+    OBJECT_CLASS_CHECK(RdmaProviderClass, (klass), \
+                       INTERFACE_RDMA_PROVIDER)
+#define RDMA_PROVIDER_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RdmaProviderClass, (obj), \
+                     INTERFACE_RDMA_PROVIDER)
+#define RDMA_PROVIDER(obj) \
+    INTERFACE_CHECK(RdmaProvider, (obj), \
+                    INTERFACE_RDMA_PROVIDER)
+
+typedef struct RdmaProvider RdmaProvider;
+
+typedef struct RdmaProviderClass {
+    InterfaceClass parent;
+
+    void (*print_statistics)(Monitor *mon, RdmaProvider *obj);
+} RdmaProviderClass;
+
+#endif
-- 
2.17.2
