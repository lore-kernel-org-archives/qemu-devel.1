Received: from eggs.gnu.org ([2001:4830:134:3::10]:47528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fcuzG-00078s-QJ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fcuzD-0007lf-Az
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:55:34 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:36310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fcuzC-0007lB-Uf
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:55:31 -0400
Received: from player734.ha.ovh.net (unknown [10.109.108.80])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 304D3B976C
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 17:55:29 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 10 Jul 2018 17:55:14 +0200
Message-ID: <153123811483.256409.15360824885082888930.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] ppc/xics: split ICP into icp-base and icp class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Recent cleanup in commit a028dd423ee6 causes QEMU to crash during CPU
hotplug:

(qemu) device_add host-spapr-cpu-core,id=core1,core-id=1
Segmentation fault (core dumped)

When the hotplug path tries to reset the ICP device, we end
up calling:

static void icp_kvm_reset(DeviceState *dev)
{
    ICPStateClass *icpc = ICP_GET_CLASS(dev);

    icpc->parent_reset(dev);

but icpc->parent_reset is NULL.

Indeed, the TYPE_ICP class doesn't implement DeviceClass::reset, but
rather directly registers a reset handler with qemu_register_reset().
This is done this way because ICPs aren't SysBus devices but we want
machine reset to reset them anyway (commit 7ea6e0671754).

The crash also proves that ipc_kvm_reset() is obviously not called for
cold plugged devices, ie, TYPE_ICP_KVM should register its own handler
with qemu_register_reset().

The motivation of commit a028dd423ee6 to have cleaner object patterns
is good, but it means that all specialized ICP types should register
their own reset handler to be called at machine reset.

So this patchs converts the current TYPE_ICP class into an abstract
TYPE_ICP_BASE class that implements DeviceClass::reset instead of
calling qemu_register_reset().

The _new_ TYPE_ICP class is derived from TYPE_ICP_BASE to cover the
the pseries.kernel-irqchip=off case. It merely registers a reset
handler with qemu_register_reset(). Its device class functions
are renamed as icp_simple_* to avoid confusion with the base class.

All other specialized ICP types are also converted to register their
own reset handler as well.

This matches what we already have with ICS.

Since we support CPU hot unplug with spapr, unrealize functions
are added to TYPE_ICP and TYPE_ICP_KVM so that they can call
qemu_unregister_reset().

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Fixes: a028dd423ee6dfd091a8c63028240832bf10f671
Signed-off-by: Greg Kurz <groug@kaod.org>
---

I've successfully tested the following:
- pseries with in-kernel XICS
- pseries with emulated XICS
- powernv
- migration of pseries, including migration to QEMU 2.12 and back
---
 hw/intc/xics.c        |   97 ++++++++++++++++++++++++++++++++++++++++---------
 hw/intc/xics_kvm.c    |   27 +++++++++++---
 hw/intc/xics_pnv.c    |   27 +++++++++++---
 include/hw/ppc/xics.h |   12 ++++--
 4 files changed, 129 insertions(+), 34 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index b9f1a3c97214..b478b9120062 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -40,7 +40,7 @@
 
 void icp_pic_print_info(ICPState *icp, Monitor *mon)
 {
-    ICPStateClass *icpc = ICP_GET_CLASS(icp);
+    ICPStateClass *icpc = ICP_BASE_GET_CLASS(icp);
     int cpu_index = icp->cs ? icp->cs->cpu_index : -1;
 
     if (!icp->output) {
@@ -255,7 +255,7 @@ static void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
 static int icp_dispatch_pre_save(void *opaque)
 {
     ICPState *icp = opaque;
-    ICPStateClass *info = ICP_GET_CLASS(icp);
+    ICPStateClass *info = ICP_BASE_GET_CLASS(icp);
 
     if (info->pre_save) {
         info->pre_save(icp);
@@ -267,7 +267,7 @@ static int icp_dispatch_pre_save(void *opaque)
 static int icp_dispatch_post_load(void *opaque, int version_id)
 {
     ICPState *icp = opaque;
-    ICPStateClass *info = ICP_GET_CLASS(icp);
+    ICPStateClass *info = ICP_BASE_GET_CLASS(icp);
 
     if (info->post_load) {
         return info->post_load(icp, version_id);
@@ -291,9 +291,9 @@ static const VMStateDescription vmstate_icp_server = {
     },
 };
 
-static void icp_reset(void *dev)
+static void icp_base_reset(DeviceState *dev)
 {
-    ICPState *icp = ICP(dev);
+    ICPState *icp = ICP_BASE(dev);
 
     icp->xirr = 0;
     icp->pending_priority = 0xff;
@@ -303,9 +303,9 @@ static void icp_reset(void *dev)
     qemu_set_irq(icp->output, 0);
 }
 
-static void icp_realize(DeviceState *dev, Error **errp)
+static void icp_base_realize(DeviceState *dev, Error **errp)
 {
-    ICPState *icp = ICP(dev);
+    ICPState *icp = ICP_BASE(dev);
     PowerPCCPU *cpu;
     CPUPPCState *env;
     Object *obj;
@@ -345,31 +345,91 @@ static void icp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_register_reset(icp_reset, dev);
     vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
 }
 
-static void icp_unrealize(DeviceState *dev, Error **errp)
+static void icp_base_unrealize(DeviceState *dev, Error **errp)
 {
-    ICPState *icp = ICP(dev);
+    ICPState *icp = ICP_BASE(dev);
 
     vmstate_unregister(NULL, &vmstate_icp_server, icp);
-    qemu_unregister_reset(icp_reset, dev);
 }
 
-static void icp_class_init(ObjectClass *klass, void *data)
+static void icp_base_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->realize = icp_realize;
-    dc->unrealize = icp_unrealize;
+    dc->realize = icp_base_realize;
+    dc->unrealize = icp_base_unrealize;
+    dc->reset = icp_base_reset;
 }
 
-static const TypeInfo icp_info = {
-    .name = TYPE_ICP,
+static const TypeInfo icp_base_info = {
+    .name = TYPE_ICP_BASE,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(ICPState),
-    .class_init = icp_class_init,
+    .class_init = icp_base_class_init,
+    .class_size = sizeof(ICPStateClass),
+    .abstract = true,
+};
+
+static void icp_simple_reset(DeviceState *dev)
+{
+    ICPStateClass *icpc = ICP_BASE_GET_CLASS(dev);
+
+    icpc->parent_reset(dev);
+}
+
+static void icp_simple_reset_handler(void *dev)
+{
+    icp_simple_reset(dev);
+}
+
+static void icp_simple_realize(DeviceState *dev, Error **errp)
+{
+    ICPStateClass *icpc = ICP_BASE_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    icpc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    qemu_register_reset(icp_simple_reset_handler, dev);
+}
+
+static void icp_simple_unrealize(DeviceState *dev, Error **errp)
+{
+    ICPStateClass *icpc = ICP_BASE_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    icpc->parent_unrealize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    qemu_unregister_reset(icp_simple_reset_handler, dev);
+}
+
+static void icp_simple_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ICPStateClass *icpc = ICP_BASE_CLASS(klass);
+
+    device_class_set_parent_realize(dc, icp_simple_realize,
+                                    &icpc->parent_realize);
+    device_class_set_parent_unrealize(dc, icp_simple_unrealize,
+                                      &icpc->parent_unrealize);
+    device_class_set_parent_reset(dc, icp_simple_reset, &icpc->parent_reset);
+}
+
+static const TypeInfo icp_simple_info = {
+    .name = TYPE_ICP,
+    .parent = TYPE_ICP_BASE,
+    .instance_size = sizeof(ICPState),
+    .class_init = icp_simple_class_init,
     .class_size = sizeof(ICPStateClass),
 };
 
@@ -744,7 +804,8 @@ static void xics_register_types(void)
 {
     type_register_static(&ics_simple_info);
     type_register_static(&ics_base_info);
-    type_register_static(&icp_info);
+    type_register_static(&icp_simple_info);
+    type_register_static(&icp_base_info);
     type_register_static(&xics_fabric_info);
 }
 
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 30c3769a2084..72e700677059 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -116,17 +116,22 @@ static int icp_set_kvm_state(ICPState *icp, int version_id)
 
 static void icp_kvm_reset(DeviceState *dev)
 {
-    ICPStateClass *icpc = ICP_GET_CLASS(dev);
+    ICPStateClass *icpc = ICP_BASE_GET_CLASS(dev);
 
     icpc->parent_reset(dev);
 
-    icp_set_kvm_state(ICP(dev), 1);
+    icp_set_kvm_state(ICP_BASE(dev), 1);
+}
+
+static void icp_kvm_reset_handler(void *dev)
+{
+    icp_kvm_reset(dev);
 }
 
 static void icp_kvm_realize(DeviceState *dev, Error **errp)
 {
-    ICPState *icp = ICP(dev);
-    ICPStateClass *icpc = ICP_GET_CLASS(icp);
+    ICPState *icp = ICP_BASE(dev);
+    ICPStateClass *icpc = ICP_BASE_GET_CLASS(icp);
     Error *local_err = NULL;
     CPUState *cs;
     KVMEnabledICP *enabled_icp;
@@ -166,15 +171,25 @@ static void icp_kvm_realize(DeviceState *dev, Error **errp)
     enabled_icp = g_malloc(sizeof(*enabled_icp));
     enabled_icp->vcpu_id = vcpu_id;
     QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
+    qemu_register_reset(icp_kvm_reset_handler, icp);
+}
+
+static void icp_kvm_unrealize(DeviceState *dev, Error **errp)
+{
+    ICPState *icp = ICP_BASE(dev);
+
+    qemu_unregister_reset(icp_kvm_reset_handler, icp);
 }
 
 static void icp_kvm_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    ICPStateClass *icpc = ICP_CLASS(klass);
+    ICPStateClass *icpc = ICP_BASE_CLASS(klass);
 
     device_class_set_parent_realize(dc, icp_kvm_realize,
                                     &icpc->parent_realize);
+    device_class_set_parent_unrealize(dc, icp_kvm_unrealize,
+                                      &icpc->parent_unrealize);
     device_class_set_parent_reset(dc, icp_kvm_reset,
                                   &icpc->parent_reset);
 
@@ -185,7 +200,7 @@ static void icp_kvm_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo icp_kvm_info = {
     .name = TYPE_KVM_ICP,
-    .parent = TYPE_ICP,
+    .parent = TYPE_ICP_BASE,
     .instance_size = sizeof(ICPState),
     .class_init = icp_kvm_class_init,
     .class_size = sizeof(ICPStateClass),
diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
index fa48505f365e..a29ccb68df73 100644
--- a/hw/intc/xics_pnv.c
+++ b/hw/intc/xics_pnv.c
@@ -33,7 +33,7 @@
 
 static uint64_t pnv_icp_read(void *opaque, hwaddr addr, unsigned width)
 {
-    ICPState *icp = ICP(opaque);
+    ICPState *icp = ICP_BASE(opaque);
     PnvICPState *picp = PNV_ICP(opaque);
     bool byte0 = (width == 1 && (addr & 0x3) == 0);
     uint64_t val = 0xffffffff;
@@ -96,7 +96,7 @@ bad_access:
 static void pnv_icp_write(void *opaque, hwaddr addr, uint64_t val,
                               unsigned width)
 {
-    ICPState *icp = ICP(opaque);
+    ICPState *icp = ICP_BASE(opaque);
     PnvICPState *picp = PNV_ICP(opaque);
     bool byte0 = (width == 1 && (addr & 0x3) == 0);
 
@@ -145,6 +145,18 @@ bad_access:
     }
 }
 
+static void pnv_icp_reset(DeviceState *dev)
+{
+    ICPStateClass *icpc = ICP_BASE_GET_CLASS(dev);
+
+    icpc->parent_reset(dev);
+}
+
+static void pnv_icp_reset_handler(void *dev)
+{
+    pnv_icp_reset(dev);
+}
+
 static const MemoryRegionOps pnv_icp_ops = {
     .read = pnv_icp_read,
     .write = pnv_icp_write,
@@ -161,9 +173,9 @@ static const MemoryRegionOps pnv_icp_ops = {
 
 static void pnv_icp_realize(DeviceState *dev, Error **errp)
 {
-    ICPState *icp = ICP(dev);
+    ICPState *icp = ICP_BASE(dev);
     PnvICPState *pnv_icp = PNV_ICP(icp);
-    ICPStateClass *icpc = ICP_GET_CLASS(icp);
+    ICPStateClass *icpc = ICP_BASE_GET_CLASS(icp);
     Error *local_err = NULL;
 
     icpc->parent_realize(dev, &local_err);
@@ -174,21 +186,24 @@ static void pnv_icp_realize(DeviceState *dev, Error **errp)
 
     memory_region_init_io(&pnv_icp->mmio, OBJECT(icp), &pnv_icp_ops,
                           icp, "icp-thread", 0x1000);
+    qemu_register_reset(pnv_icp_reset_handler, icp);
 }
 
 static void pnv_icp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    ICPStateClass *icpc = ICP_CLASS(klass);
+    ICPStateClass *icpc = ICP_BASE_CLASS(klass);
 
     device_class_set_parent_realize(dc, pnv_icp_realize,
                                     &icpc->parent_realize);
+    device_class_set_parent_reset(dc, pnv_icp_reset,
+                                  &icpc->parent_reset);
     dc->desc = "PowerNV ICP";
 }
 
 static const TypeInfo pnv_icp_info = {
     .name          = TYPE_PNV_ICP,
-    .parent        = TYPE_ICP,
+    .parent        = TYPE_ICP_BASE,
     .instance_size = sizeof(PnvICPState),
     .class_init    = pnv_icp_class_init,
     .class_size    = sizeof(ICPStateClass),
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 6ac8a9392da6..6a2e45997f8f 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -48,6 +48,9 @@ typedef struct ICSState ICSState;
 typedef struct ICSIRQState ICSIRQState;
 typedef struct XICSFabric XICSFabric;
 
+#define TYPE_ICP_BASE "icp-base"
+#define ICP_BASE(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP_BASE)
+
 #define TYPE_ICP "icp"
 #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)
 
@@ -57,15 +60,16 @@ typedef struct XICSFabric XICSFabric;
 #define TYPE_PNV_ICP "pnv-icp"
 #define PNV_ICP(obj) OBJECT_CHECK(PnvICPState, (obj), TYPE_PNV_ICP)
 
-#define ICP_CLASS(klass) \
-     OBJECT_CLASS_CHECK(ICPStateClass, (klass), TYPE_ICP)
-#define ICP_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(ICPStateClass, (obj), TYPE_ICP)
+#define ICP_BASE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(ICPStateClass, (klass), TYPE_ICP_BASE)
+#define ICP_BASE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(ICPStateClass, (obj), TYPE_ICP_BASE)
 
 struct ICPStateClass {
     DeviceClass parent_class;
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     DeviceReset parent_reset;
 
     void (*pre_save)(ICPState *icp);
