Received: from eggs.gnu.org ([2001:4830:134:3::10]:53127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixK-0003ay-HD
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixJ-0004cI-Av
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:46 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:15 +1100
Message-Id: <20171215055435.24204-5-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/24] spapr_cpu_core: instantiate CPUs
 separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The current code assumes that only the CPU core object holds a
reference on each individual CPU object, and happily frees their
allocated memory when the core is unrealized. This is dangerous
as some other code can legitimely keep a pointer to a CPU if it
calls object_ref(), but it would end up with a dangling pointer.

Let's allocate all CPUs with object_new() and let QOM free them
when their reference count reaches zero. This greatly simplify the
code as we don't have to fiddle with the instance size anymore.

Signed-off-by: Greg Kurz <groug@kaod.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                  | 11 +++--------
 hw/ppc/spapr_cpu_core.c         | 19 +++++++------------
 include/hw/ppc/spapr_cpu_core.h |  2 +-
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8881f2f1e8..f1b96a4e92 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3180,12 +3180,10 @@ void spapr_core_release(DeviceState *dev)
 
     if (smc->pre_2_10_has_unused_icps) {
         sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
-        sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
-        size_t size = object_type_get_instance_size(scc->cpu_type);
         int i;
 
         for (i = 0; i < cc->nr_threads; i++) {
-            CPUState *cs = CPU(sc->threads + i * size);
+            CPUState *cs = CPU(sc->threads[i]);
 
             pre_2_10_vmstate_register_dummy_icp(cs->cpu_index);
         }
@@ -3231,7 +3229,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
     sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(dev);
-    CPUState *cs = CPU(core->threads);
+    CPUState *cs = CPU(core->threads[0]);
     sPAPRDRConnector *drc;
     Error *local_err = NULL;
     int smt = kvmppc_smt_threads();
@@ -3276,15 +3274,12 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     core_slot->cpu = OBJECT(dev);
 
     if (smc->pre_2_10_has_unused_icps) {
-        sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
-        size_t size = object_type_get_instance_size(scc->cpu_type);
         int i;
 
         for (i = 0; i < cc->nr_threads; i++) {
             sPAPRCPUCore *sc = SPAPR_CPU_CORE(dev);
-            void *obj = sc->threads + i * size;
 
-            cs = CPU(obj);
+            cs = CPU(sc->threads[i]);
             pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
         }
     }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 3a4c174012..588f9b4571 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -79,13 +79,11 @@ const char *spapr_get_cpu_core_type(const char *cpu_type)
 static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
 {
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
-    sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
-    size_t size = object_type_get_instance_size(scc->cpu_type);
     CPUCore *cc = CPU_CORE(dev);
     int i;
 
     for (i = 0; i < cc->nr_threads; i++) {
-        void *obj = sc->threads + i * size;
+        Object *obj = OBJECT(sc->threads[i]);
         DeviceState *dev = DEVICE(obj);
         CPUState *cs = CPU(dev);
         PowerPCCPU *cpu = POWERPC_CPU(cs);
@@ -146,9 +144,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
-    size_t size;
     Error *local_err = NULL;
-    void *obj;
+    Object *obj;
     int i, j;
 
     if (!spapr) {
@@ -156,18 +153,16 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    size = object_type_get_instance_size(scc->cpu_type);
-    sc->threads = g_malloc0(size * cc->nr_threads);
+    sc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
         char id[32];
         CPUState *cs;
         PowerPCCPU *cpu;
 
-        obj = sc->threads + i * size;
+        obj = object_new(scc->cpu_type);
 
-        object_initialize(obj, size, scc->cpu_type);
         cs = CPU(obj);
-        cpu = POWERPC_CPU(cs);
+        cpu = sc->threads[i] = POWERPC_CPU(obj);
         cs->cpu_index = cc->core_id + i;
         cpu->vcpu_id = (cc->core_id * spapr->vsmt / smp_threads) + i;
         if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
@@ -192,7 +187,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     }
 
     for (j = 0; j < cc->nr_threads; j++) {
-        obj = sc->threads + j * size;
+        obj = OBJECT(sc->threads[j]);
 
         spapr_cpu_core_realize_child(obj, spapr, &local_err);
         if (local_err) {
@@ -203,7 +198,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
 err:
     while (--i >= 0) {
-        obj = sc->threads + i * size;
+        obj = OBJECT(sc->threads[i]);
         object_unparent(obj);
     }
     g_free(sc->threads);
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index f2d48d6a67..1129f344aa 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -28,7 +28,7 @@ typedef struct sPAPRCPUCore {
     CPUCore parent_obj;
 
     /*< public >*/
-    void *threads;
+    PowerPCCPU **threads;
     int node_id;
 } sPAPRCPUCore;
 
-- 
2.14.3
