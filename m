Received: from eggs.gnu.org ([2001:4830:134:3::10]:47211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCS1-00043G-NR
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRz-0006gp-9H
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:13 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:49 +1000
Message-Id: <20170609052652.23200-18-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/20] xics: pass appropriate types to realize()
 handlers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

It makes more sense to pass an IPCState * to handlers of ICPStateClass
instead of a DeviceState *, if only to benefit from compile time type
checking. The same goes with ICSStateClass.

While here, we also change the declaration of ICPStateClass in xics.h
for consistency.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 10 ++++------
 hw/intc/xics_kvm.c    |  6 ++----
 hw/intc/xics_pnv.c    |  6 +++---
 include/hw/ppc/xics.h |  8 ++++----
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index aa2c4e7..f74a96e 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -356,7 +356,7 @@ static void icp_realize(DeviceState *dev, Error **errp)
     icp->xics = XICS_FABRIC(obj);
 
     if (icpc->realize) {
-        icpc->realize(dev, errp);
+        icpc->realize(icp, errp);
     }
 
     qemu_register_reset(icp_reset, dev);
@@ -606,10 +606,8 @@ static void ics_simple_initfn(Object *obj)
     ics->offset = XICS_IRQ_BASE;
 }
 
-static void ics_simple_realize(DeviceState *dev, Error **errp)
+static void ics_simple_realize(ICSState *ics, Error **errp)
 {
-    ICSState *ics = ICS_SIMPLE(dev);
-
     if (!ics->nr_irqs) {
         error_setg(errp, "Number of interrupts needs to be greater 0");
         return;
@@ -617,7 +615,7 @@ static void ics_simple_realize(DeviceState *dev, Error **errp)
     ics->irqs = g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
     ics->qirqs = qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_irqs);
 
-    qemu_register_reset(ics_simple_reset, dev);
+    qemu_register_reset(ics_simple_reset, ics);
 }
 
 static Property ics_simple_properties[] = {
@@ -664,7 +662,7 @@ static void ics_base_realize(DeviceState *dev, Error **errp)
 
 
     if (icsc->realize) {
-        icsc->realize(dev, errp);
+        icsc->realize(ics, errp);
     }
 }
 
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 45bf110..41c5b94 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -328,10 +328,8 @@ static void ics_kvm_reset(void *dev)
     ics_set_kvm_state(ics, 1);
 }
 
-static void ics_kvm_realize(DeviceState *dev, Error **errp)
+static void ics_kvm_realize(ICSState *ics, Error **errp)
 {
-    ICSState *ics = ICS_SIMPLE(dev);
-
     if (!ics->nr_irqs) {
         error_setg(errp, "Number of interrupts needs to be greater 0");
         return;
@@ -339,7 +337,7 @@ static void ics_kvm_realize(DeviceState *dev, Error **errp)
     ics->irqs = g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
     ics->qirqs = qemu_allocate_irqs(ics_kvm_set_irq, ics, ics->nr_irqs);
 
-    qemu_register_reset(ics_kvm_reset, dev);
+    qemu_register_reset(ics_kvm_reset, ics);
 }
 
 static void ics_kvm_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
index 12ae605..2a955a8 100644
--- a/hw/intc/xics_pnv.c
+++ b/hw/intc/xics_pnv.c
@@ -159,11 +159,11 @@ static const MemoryRegionOps pnv_icp_ops = {
     },
 };
 
-static void pnv_icp_realize(DeviceState *dev, Error **errp)
+static void pnv_icp_realize(ICPState *icp, Error **errp)
 {
-    PnvICPState *icp = PNV_ICP(dev);
+    PnvICPState *pnv_icp = PNV_ICP(icp);
 
-    memory_region_init_io(&icp->mmio, OBJECT(dev), &pnv_icp_ops,
+    memory_region_init_io(&pnv_icp->mmio, OBJECT(icp), &pnv_icp_ops,
                           icp, "icp-thread", 0x1000);
 }
 
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 3114532..797df82 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -65,9 +65,9 @@ typedef struct XICSFabric XICSFabric;
 struct ICPStateClass {
     DeviceClass parent_class;
 
-    void (*realize)(DeviceState *dev, Error **errp);
-    void (*pre_save)(ICPState *s);
-    int (*post_load)(ICPState *s, int version_id);
+    void (*realize)(ICPState *icp, Error **errp);
+    void (*pre_save)(ICPState *icp);
+    int (*post_load)(ICPState *icp, int version_id);
     void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);
     void (*reset)(ICPState *icp);
 };
@@ -113,7 +113,7 @@ struct PnvICPState {
 struct ICSStateClass {
     DeviceClass parent_class;
 
-    void (*realize)(DeviceState *dev, Error **errp);
+    void (*realize)(ICSState *s, Error **errp);
     void (*pre_save)(ICSState *s);
     int (*post_load)(ICSState *s, int version_id);
     void (*reject)(ICSState *s, uint32_t irq);
-- 
2.9.4
