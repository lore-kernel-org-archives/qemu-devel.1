Received: from eggs.gnu.org ([2001:4830:134:3::10]:50595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOZ-0008MW-0h
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOW-00072k-FU
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:40 +1100
Message-Id: <20171017042152.29443-23-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 22/34] ppc: spapr: register 'host' core type
 along with the rest of core types
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

consolidate 'host' core type registration by moving it from
KVM specific code into spapr_cpu_core.c, similar like it's
done in x86 target.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c         |  5 ++++-
 include/hw/ppc/spapr_cpu_core.h |  1 -
 target/ppc/kvm.c                | 11 -----------
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 9810697221..7dbf9c31c5 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -221,7 +221,7 @@ static Property spapr_cpu_core_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
+static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_CLASS(oc);
@@ -259,6 +259,9 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
     DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
+#ifdef CONFIG_KVM
+    DEFINE_SPAPR_CPU_CORE_TYPE("host"),
+#endif
 };
 
 DEFINE_TYPES(spapr_cpu_core_type_infos)
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 264ce68785..42765de392 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -38,5 +38,4 @@ typedef struct sPAPRCPUCoreClass {
 } sPAPRCPUCoreClass;
 
 char *spapr_get_cpu_core_type(const char *model);
-void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
 #endif
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index c2152ed52c..cb5777afa0 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2508,17 +2508,6 @@ static int kvm_ppc_register_host_cpu_type(void)
     oc = object_class_by_name(type_info.name);
     g_assert(oc);
 
-#if defined(TARGET_PPC64)
-    type_info.name = g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "host");
-    type_info.parent = TYPE_SPAPR_CPU_CORE,
-    type_info.instance_size = sizeof(sPAPRCPUCore);
-    type_info.instance_init = NULL;
-    type_info.class_init = spapr_cpu_core_class_init;
-    type_info.class_data = (void *) POWERPC_CPU_TYPE_NAME("host");
-    type_register(&type_info);
-    g_free((void *)type_info.name);
-#endif
-
     /*
      * Update generic CPU family class alias (e.g. on a POWER8NVL host,
      * we want "POWER8" to be a "family" alias that points to the current
-- 
2.13.6
