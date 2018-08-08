Received: from eggs.gnu.org ([2001:4830:134:3::10]:33767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.ibm.com>) id 1fnQsJ-0006p9-UF
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.ibm.com>) id 1fnQsG-0002u1-T0
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:59:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.ibm.com>)
	id 1fnQsG-0002sB-Is
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:59:48 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w78Fxf5I059299
	for <qemu-devel@nongnu.org>; Wed, 8 Aug 2018 11:59:43 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kr2m9b1ug-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 11:59:42 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.ibm.com>;
	Wed, 8 Aug 2018 16:59:39 +0100
From: Bharata B Rao <bharata@linux.ibm.com>
Date: Wed,  8 Aug 2018 21:29:19 +0530
Message-Id: <20180808155919.12972-1-bharata@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] spapr_cpu_core: vmstate_[un]register per-CPU
 data from (un)realizefn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org, sathnaga@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.ibm.com>

VMStateDescription vmstate_spapr_cpu_state was added by commit
b94020268e0b6 (spapr_cpu_core: migrate per-CPU data) to migrate per-CPU
data with the required vmstate registration and unregistration calls.
However the unregistration is being done only from vcpu creation error path
and not from CPU delete path.

This causes migration to fail with the following error if migration is
attempted after a CPU unplug like this:
Unknown savevm section or instance 'spapr_cpu' 16
Additionally this leaves the source VM unresponsive after migration failure.

Fix this by ensuring the vmstate_unregister happens during CPU removal.
Fixing this becomes easier when vmstate (un)registration calls are moved to
vcpu (un)realize functions which is what this patch does.

Fixes: https://bugs.launchpad.net/qemu/+bug/1785972
Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 hw/ppc/spapr_cpu_core.c | 62 +++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 993759db47..bb88a3ce4e 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -113,26 +113,6 @@ const char *spapr_get_cpu_core_type(const char *cpu_type)
     return object_class_get_name(oc);
 }
 
-static void spapr_unrealize_vcpu(PowerPCCPU *cpu)
-{
-    qemu_unregister_reset(spapr_cpu_reset, cpu);
-    object_unparent(cpu->intc);
-    cpu_remove_sync(CPU(cpu));
-    object_unparent(OBJECT(cpu));
-}
-
-static void spapr_cpu_core_unrealize(DeviceState *dev, Error **errp)
-{
-    sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
-    CPUCore *cc = CPU_CORE(dev);
-    int i;
-
-    for (i = 0; i < cc->nr_threads; i++) {
-        spapr_unrealize_vcpu(sc->threads[i]);
-    }
-    g_free(sc->threads);
-}
-
 static bool slb_shadow_needed(void *opaque)
 {
     sPAPRCPUState *spapr_cpu = opaque;
@@ -207,10 +187,34 @@ static const VMStateDescription vmstate_spapr_cpu_state = {
     }
 };
 
+static void spapr_unrealize_vcpu(PowerPCCPU *cpu, sPAPRCPUCore *sc)
+{
+    if (!sc->pre_3_0_migration) {
+        vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_data);
+    }
+    qemu_unregister_reset(spapr_cpu_reset, cpu);
+    object_unparent(cpu->intc);
+    cpu_remove_sync(CPU(cpu));
+    object_unparent(OBJECT(cpu));
+}
+
+static void spapr_cpu_core_unrealize(DeviceState *dev, Error **errp)
+{
+    sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
+    CPUCore *cc = CPU_CORE(dev);
+    int i;
+
+    for (i = 0; i < cc->nr_threads; i++) {
+        spapr_unrealize_vcpu(sc->threads[i], sc);
+    }
+    g_free(sc->threads);
+}
+
 static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
-                               Error **errp)
+                               sPAPRCPUCore *sc, Error **errp)
 {
     CPUPPCState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
     Error *local_err = NULL;
 
     object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
@@ -233,6 +237,11 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
         goto error_unregister;
     }
 
+    if (!sc->pre_3_0_migration) {
+        vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
+                         cpu->machine_data);
+    }
+
     return;
 
 error_unregister:
@@ -272,10 +281,6 @@ static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **errp)
     }
 
     cpu->machine_data = g_new0(sPAPRCPUState, 1);
-    if (!sc->pre_3_0_migration) {
-        vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
-                         cpu->machine_data);
-    }
 
     object_unref(obj);
     return cpu;
@@ -290,9 +295,6 @@ static void spapr_delete_vcpu(PowerPCCPU *cpu, sPAPRCPUCore *sc)
 {
     sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
 
-    if (!sc->pre_3_0_migration) {
-        vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_data);
-    }
     cpu->machine_data = NULL;
     g_free(spapr_cpu);
     object_unparent(OBJECT(cpu));
@@ -325,7 +327,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     }
 
     for (j = 0; j < cc->nr_threads; j++) {
-        spapr_realize_vcpu(sc->threads[j], spapr, &local_err);
+        spapr_realize_vcpu(sc->threads[j], spapr, sc, &local_err);
         if (local_err) {
             goto err_unrealize;
         }
@@ -334,7 +336,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
 err_unrealize:
     while (--j >= 0) {
-        spapr_unrealize_vcpu(sc->threads[j]);
+        spapr_unrealize_vcpu(sc->threads[j], sc);
     }
 err:
     while (--i >= 0) {
-- 
2.14.3
