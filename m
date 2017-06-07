Received: from eggs.gnu.org ([2001:4830:134:3::10]:44956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIea6-0000hH-Lj
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIea2-0000fq-Fi
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:17:18 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:47262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIea2-0000dx-6J
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:17:14 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id BB1D23DCC5
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 19:17:12 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 07 Jun 2017 19:17:09 +0200
Message-ID: <149685582923.12025.13700165807436904935.stgit@bahia.lan>
In-Reply-To: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 3/5] xics: setup cpu at realize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

Until recently, spapr used to allocate ICPState objects for the lifetime
of the machine. They would only be associated to vCPUs in xics_cpu_setup()
when plugging a CPU core.

Now that ICPState objects have the same lifecycle as vCPUs, it is
possible to associate them during realization.

This patch hence open-codes xics_cpu_setup() in icp_realize(). The vCPU
is passed as a property. Note that vCPU now needs to be realized first
for the IRQs to be allocated. It also needs to resetted before ICPState
realization in order to synchronize with KVM.

Since ICPState objects are freed when unrealized, xics_cpu_destroy() isn't
needed anymore and can be safely dropped.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c          |   76 ++++++++++++++++++++---------------------------
 hw/ppc/pnv_core.c       |   16 ++++------
 hw/ppc/spapr_cpu_core.c |   21 ++++++-------
 include/hw/ppc/xics.h   |    2 -
 4 files changed, 48 insertions(+), 67 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index ec73f02144c9..330441ff7fe8 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -38,50 +38,6 @@
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
 
-void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
-{
-    CPUState *cs = CPU(cpu);
-    ICPState *icp = ICP(cpu->intc);
-
-    assert(icp);
-    assert(cs == icp->cs);
-
-    icp->output = NULL;
-    icp->cs = NULL;
-}
-
-void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu, ICPState *icp)
-{
-    CPUState *cs = CPU(cpu);
-    CPUPPCState *env = &cpu->env;
-    ICPStateClass *icpc;
-
-    assert(icp);
-
-    cpu->intc = OBJECT(icp);
-    icp->cs = cs;
-
-    icpc = ICP_GET_CLASS(icp);
-    if (icpc->cpu_setup) {
-        icpc->cpu_setup(icp, cpu);
-    }
-
-    switch (PPC_INPUT(env)) {
-    case PPC_FLAGS_INPUT_POWER7:
-        icp->output = env->irq_inputs[POWER7_INPUT_INT];
-        break;
-
-    case PPC_FLAGS_INPUT_970:
-        icp->output = env->irq_inputs[PPC970_INPUT_INT];
-        break;
-
-    default:
-        error_report("XICS interrupt controller does not support this CPU "
-                     "bus model");
-        abort();
-    }
-}
-
 void icp_pic_print_info(ICPState *icp, Monitor *mon)
 {
     int cpu_index = icp->cs ? icp->cs->cpu_index : -1;
@@ -343,6 +299,8 @@ static void icp_realize(DeviceState *dev, Error **errp)
 {
     ICPState *icp = ICP(dev);
     ICPStateClass *icpc = ICP_GET_CLASS(dev);
+    PowerPCCPU *cpu;
+    CPUPPCState *env;
     Object *obj;
     Error *err = NULL;
 
@@ -355,6 +313,36 @@ static void icp_realize(DeviceState *dev, Error **errp)
 
     icp->xics = XICS_FABRIC(obj);
 
+    obj = object_property_get_link(OBJECT(dev), "cs", &err);
+    if (!obj) {
+        error_setg(errp, "%s: required link 'xics' not found: %s",
+                   __func__, error_get_pretty(err));
+        return;
+    }
+
+    cpu = POWERPC_CPU(obj);
+    cpu->intc = OBJECT(icp);
+    icp->cs = CPU(obj);
+
+    if (icpc->cpu_setup) {
+        icpc->cpu_setup(icp, cpu);
+    }
+
+    env = &cpu->env;
+    switch (PPC_INPUT(env)) {
+    case PPC_FLAGS_INPUT_POWER7:
+        icp->output = env->irq_inputs[POWER7_INPUT_INT];
+        break;
+
+    case PPC_FLAGS_INPUT_970:
+        icp->output = env->irq_inputs[PPC970_INPUT_INT];
+        break;
+
+    default:
+        error_setg(errp, "XICS interrupt controller does not support this CPU bus model");
+        return;
+    }
+
     if (icpc->realize) {
         icpc->realize(dev, errp);
     }
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index e8a9a94d5a24..1393005e76f3 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -118,19 +118,19 @@ static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error **errp)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     Object *obj;
 
-    obj = object_new(TYPE_PNV_ICP);
-    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
-    object_unref(obj);
-    object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abort);
-    object_property_set_bool(obj, true, "realized", &local_err);
+    object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
-    object_property_set_bool(child, true, "realized", &local_err);
+    obj = object_new(TYPE_PNV_ICP);
+    object_property_add_child(child, "icp", obj, NULL);
+    object_unref(obj);
+    object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abort);
+    object_property_add_const_link(obj, "cs", child, &error_abort);
+    object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
-        object_unparent(obj);
         error_propagate(errp, local_err);
         return;
     }
@@ -141,8 +141,6 @@ static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
-
-    xics_cpu_setup(xi, cpu, ICP(obj));
 }
 
 static void pnv_core_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 029a14120edd..9a6259525953 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -53,9 +53,6 @@ static void spapr_cpu_reset(void *opaque)
 
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
-
-    xics_cpu_destroy(XICS_FABRIC(spapr), cpu);
     qemu_unregister_reset(spapr_cpu_reset, cpu);
 }
 
@@ -140,28 +137,28 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     CPUState *cs = CPU(child);
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-    Object *obj;
+    Object *obj = NULL;
 
-    obj = object_new(spapr->icp_type);
-    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
-    object_unref(obj);
-    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_abort);
-    object_property_set_bool(obj, true, "realized", &local_err);
+    object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
         goto error;
     }
 
-    object_property_set_bool(child, true, "realized", &local_err);
+    spapr_cpu_init(spapr, cpu, &local_err);
     if (local_err) {
         goto error;
     }
 
-    spapr_cpu_init(spapr, cpu, &local_err);
+    obj = object_new(spapr->icp_type);
+    object_property_add_child(child, "icp", obj, &error_abort);
+    object_unref(obj);
+    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_abort);
+    object_property_add_const_link(obj, "cs", child, &error_abort);
+    object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         goto error;
     }
 
-    xics_cpu_setup(XICS_FABRIC(spapr), cpu, ICP(obj));
     return;
 
 error:
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 40a506eacfb4..05767a15be9a 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -183,8 +183,6 @@ void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle);
 
 qemu_irq xics_get_qirq(XICSFabric *xi, int irq);
 ICPState *xics_icp_get(XICSFabric *xi, int server);
-void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu, ICPState *icp);
-void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu);
 
 /* Internal XICS interfaces */
 void icp_set_cppr(ICPState *icp, uint8_t cppr);
