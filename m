Received: from eggs.gnu.org ([2001:4830:134:3::10]:50026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEg-0005UM-Q8
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEe-00048S-9R
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:21 +1000
Message-Id: <20180618035324.19907-26-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 25/28] spapr_cpu_core: introduce
 spapr_create_vcpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

This moves some code out from spapr_cpu_core_realize() for clarity. No
functional change.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 73 +++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 30a7cf9e03..98a018c8d0 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -157,6 +157,49 @@ error:
     error_propagate(errp, local_err);
 }
 
+static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **errp)
+{
+    sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(sc);
+    CPUCore *cc = CPU_CORE(sc);
+    Object *obj;
+    char *id;
+    CPUState *cs;
+    PowerPCCPU *cpu;
+    Error *local_err = NULL;
+
+    obj = object_new(scc->cpu_type);
+
+    cs = CPU(obj);
+    cpu = POWERPC_CPU(obj);
+    cs->cpu_index = cc->core_id + i;
+    spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
+    if (local_err) {
+        goto err;
+    }
+
+    cpu->node_id = sc->node_id;
+
+    id = g_strdup_printf("thread[%d]", i);
+    object_property_add_child(OBJECT(sc), id, obj, &local_err);
+    g_free(id);
+    if (local_err) {
+        goto err;
+    }
+
+    object_unref(obj);
+    return cpu;
+
+err:
+    object_unref(obj);
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
+static void spapr_delete_vcpu(PowerPCCPU *cpu)
+{
+    object_unparent(OBJECT(cpu));
+}
+
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 {
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
@@ -166,10 +209,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
                                                   TYPE_SPAPR_MACHINE);
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
-    sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
     Error *local_err = NULL;
-    Object *obj;
     int i, j;
 
     if (!spapr) {
@@ -179,33 +220,10 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
     sc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
-        char *id;
-        CPUState *cs;
-        PowerPCCPU *cpu;
-
-        obj = object_new(scc->cpu_type);
-
-        cs = CPU(obj);
-        cpu = sc->threads[i] = POWERPC_CPU(obj);
-        cs->cpu_index = cc->core_id + i;
-        spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
-        if (local_err) {
-            object_unref(obj);
-            goto err;
-        }
-
-
-        /* Set NUMA node for the threads belonged to core  */
-        cpu->node_id = sc->node_id;
-
-        id = g_strdup_printf("thread[%d]", i);
-        object_property_add_child(OBJECT(sc), id, obj, &local_err);
-        g_free(id);
+        sc->threads[i] = spapr_create_vcpu(sc, i, &local_err);
         if (local_err) {
-            object_unref(obj);
             goto err;
         }
-        object_unref(obj);
     }
 
     for (j = 0; j < cc->nr_threads; j++) {
@@ -222,8 +240,7 @@ err_unrealize:
     }
 err:
     while (--i >= 0) {
-        obj = OBJECT(sc->threads[i]);
-        object_unparent(obj);
+        spapr_delete_vcpu(sc->threads[i]);
     }
     g_free(sc->threads);
     error_propagate(errp, local_err);
-- 
2.17.1
