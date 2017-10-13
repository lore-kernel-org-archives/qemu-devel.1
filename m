Received: from eggs.gnu.org ([2001:4830:134:3::10]:58362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2vRM-00051c-Um
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2vRI-0003PT-E8
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:35:32 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:33834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e2vRI-0003Or-5F
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:35:28 -0400
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5805313FDA5
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 10:35:26 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 13 Oct 2017 10:35:19 +0200
Message-ID: <150788371922.25736.3447778326403865231.stgit@bahia>
In-Reply-To: <150788370618.25736.8030708425923435364.stgit@bahia>
References: <150788370618.25736.8030708425923435364.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/2] spapr_cpu_core: instantiate CPUs separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>

The current code assumes that only the CPU core object holds a
reference on each individual CPU object, and happily frees their
allocated memory when the core is unrealized. This is dangerous
as some other code can legitimely keep a pointer to a CPU if it
calls object_ref(), but it would end up with a dangling pointer.

Let's allocate all CPUs with object_new() and let QOM frees them
when their reference count reaches zero.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c                  |   10 +++-------
 hw/ppc/spapr_cpu_core.c         |   29 +++++++++--------------------
 include/hw/ppc/spapr_cpu_core.h |    2 +-
 3 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fd9813bde82f..ba391c6ed5de 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3153,12 +3153,10 @@ void spapr_core_release(DeviceState *dev)
 
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
@@ -3204,7 +3202,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
     sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(dev);
-    CPUState *cs = CPU(core->threads);
+    CPUState *cs = CPU(core->threads[0]);
     sPAPRDRConnector *drc;
     Error *local_err = NULL;
     int smt = kvmppc_smt_threads();
@@ -3249,13 +3247,11 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     core_slot->cpu = OBJECT(dev);
 
     if (smc->pre_2_10_has_unused_icps) {
-        sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
-        size_t size = object_type_get_instance_size(scc->cpu_type);
         int i;
 
         for (i = 0; i < cc->nr_threads; i++) {
             sPAPRCPUCore *sc = SPAPR_CPU_CORE(dev);
-            void *obj = sc->threads + i * size;
+            void *obj = sc->threads[i];
 
             cs = CPU(obj);
             pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 3a4c17401226..47c408b52ca1 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -79,21 +79,18 @@ const char *spapr_get_cpu_core_type(const char *cpu_type)
 static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
 {
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
-    sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
-    size_t size = object_type_get_instance_size(scc->cpu_type);
     CPUCore *cc = CPU_CORE(dev);
     int i;
 
     for (i = 0; i < cc->nr_threads; i++) {
-        void *obj = sc->threads + i * size;
-        DeviceState *dev = DEVICE(obj);
+        DeviceState *dev = DEVICE(sc->threads[i]);
         CPUState *cs = CPU(dev);
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
         spapr_cpu_destroy(cpu);
         object_unparent(cpu->intc);
         cpu_remove_sync(cs);
-        object_unparent(obj);
+        object_unparent(sc->threads[i]);
     }
     g_free(sc->threads);
 }
@@ -146,9 +143,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
-    size_t size;
     Error *local_err = NULL;
-    void *obj;
     int i, j;
 
     if (!spapr) {
@@ -156,17 +151,14 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    size = object_type_get_instance_size(scc->cpu_type);
-    sc->threads = g_malloc0(size * cc->nr_threads);
+    sc->threads = g_new(void *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
         char id[32];
         CPUState *cs;
         PowerPCCPU *cpu;
 
-        obj = sc->threads + i * size;
-
-        object_initialize(obj, size, scc->cpu_type);
-        cs = CPU(obj);
+        sc->threads[i] = object_new(scc->cpu_type);
+        cs = CPU(sc->threads[i]);
         cpu = POWERPC_CPU(cs);
         cs->cpu_index = cc->core_id + i;
         cpu->vcpu_id = (cc->core_id * spapr->vsmt / smp_threads) + i;
@@ -184,17 +176,15 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         cpu->node_id = sc->node_id;
 
         snprintf(id, sizeof(id), "thread[%d]", i);
-        object_property_add_child(OBJECT(sc), id, obj, &local_err);
+        object_property_add_child(OBJECT(sc), id, sc->threads[i], &local_err);
         if (local_err) {
             goto err;
         }
-        object_unref(obj);
+        object_unref(sc->threads[i]);
     }
 
     for (j = 0; j < cc->nr_threads; j++) {
-        obj = sc->threads + j * size;
-
-        spapr_cpu_core_realize_child(obj, spapr, &local_err);
+        spapr_cpu_core_realize_child(sc->threads[j], spapr, &local_err);
         if (local_err) {
             goto err;
         }
@@ -203,8 +193,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
 err:
     while (--i >= 0) {
-        obj = sc->threads + i * size;
-        object_unparent(obj);
+        object_unparent(sc->threads[i]);
     }
     g_free(sc->threads);
     error_propagate(errp, local_err);
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index f2d48d6a6786..f5b943a6682c 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -28,7 +28,7 @@ typedef struct sPAPRCPUCore {
     CPUCore parent_obj;
 
     /*< public >*/
-    void *threads;
+    void **threads;
     int node_id;
 } sPAPRCPUCore;
 
