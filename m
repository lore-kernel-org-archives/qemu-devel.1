Received: from eggs.gnu.org ([2001:4830:134:3::10]:50613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOZ-0008MZ-4p
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOW-000732-LR
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:39 +1100
Message-Id: <20171017042152.29443-22-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 21/34] ppc: spapr: use cpu type name directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

replace sPAPRCPUCoreClass::cpu_class with cpu type name
since it were needed just to get that at points it were
accessed.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                  |  6 ++----
 hw/ppc/spapr_cpu_core.c         | 14 ++++++--------
 include/hw/ppc/spapr_cpu_core.h |  2 +-
 target/ppc/kvm.c                |  2 +-
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 112dd91348..2c32f33314 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3161,8 +3161,7 @@ void spapr_core_release(DeviceState *dev)
     if (smc->pre_2_10_has_unused_icps) {
         sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
         sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
-        const char *typename = object_class_get_name(scc->cpu_class);
-        size_t size = object_type_get_instance_size(typename);
+        size_t size = object_type_get_instance_size(scc->cpu_type);
         int i;
 
         for (i = 0; i < cc->nr_threads; i++) {
@@ -3258,8 +3257,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     if (smc->pre_2_10_has_unused_icps) {
         sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
-        const char *typename = object_class_get_name(scc->cpu_class);
-        size_t size = object_type_get_instance_size(typename);
+        size_t size = object_type_get_instance_size(scc->cpu_type);
         int i;
 
         for (i = 0; i < cc->nr_threads; i++) {
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 550d320b5b..9810697221 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -90,8 +90,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
 {
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
-    const char *typename = object_class_get_name(scc->cpu_class);
-    size_t size = object_type_get_instance_size(typename);
+    size_t size = object_type_get_instance_size(scc->cpu_type);
     CPUCore *cc = CPU_CORE(dev);
     int i;
 
@@ -152,8 +151,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
-    const char *typename = object_class_get_name(scc->cpu_class);
-    size_t size = object_type_get_instance_size(typename);
+    size_t size;
     Error *local_err = NULL;
     void *obj;
     int i, j;
@@ -164,6 +162,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    size = object_type_get_instance_size(scc->cpu_type);
     sc->threads = g_malloc0(size * cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
         char id[32];
@@ -172,7 +171,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
         obj = sc->threads + i * size;
 
-        object_initialize(obj, size, typename);
+        object_initialize(obj, size, scc->cpu_type);
         cs = CPU(obj);
         cpu = POWERPC_CPU(cs);
         cs->cpu_index = cc->core_id + i;
@@ -230,14 +229,13 @@ void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
     dc->realize = spapr_cpu_core_realize;
     dc->unrealize = spapr_cpu_core_unrealizefn;
     dc->props = spapr_cpu_core_properties;
-    scc->cpu_class = cpu_class_by_name(TYPE_POWERPC_CPU, data);
-    g_assert(scc->cpu_class);
+    scc->cpu_type = data;
 }
 
 #define DEFINE_SPAPR_CPU_CORE_TYPE(cpu_model) \
     {                                                   \
         .parent = TYPE_SPAPR_CPU_CORE,                  \
-        .class_data = (void *) cpu_model,               \
+        .class_data = (void *) POWERPC_CPU_TYPE_NAME(cpu_model), \
         .class_init = spapr_cpu_core_class_init,        \
         .name = SPAPR_CPU_CORE_TYPE_NAME(cpu_model),    \
     }
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 66dcf52587..264ce68785 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -34,7 +34,7 @@ typedef struct sPAPRCPUCore {
 
 typedef struct sPAPRCPUCoreClass {
     DeviceClass parent_class;
-    ObjectClass *cpu_class;
+    const char *cpu_type;
 } sPAPRCPUCoreClass;
 
 char *spapr_get_cpu_core_type(const char *model);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 171d3d8040..c2152ed52c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2514,7 +2514,7 @@ static int kvm_ppc_register_host_cpu_type(void)
     type_info.instance_size = sizeof(sPAPRCPUCore);
     type_info.instance_init = NULL;
     type_info.class_init = spapr_cpu_core_class_init;
-    type_info.class_data = (void *) "host";
+    type_info.class_data = (void *) POWERPC_CPU_TYPE_NAME("host");
     type_register(&type_info);
     g_free((void *)type_info.name);
 #endif
-- 
2.13.6
