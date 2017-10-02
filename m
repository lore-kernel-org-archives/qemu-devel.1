Received: from eggs.gnu.org ([2001:4830:134:3::10]:47183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywig-0002NI-Kw
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywif-0006Fi-5y
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywie-0006EA-UO
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:57 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:09 +0200
Message-Id: <1506935300-132598-28-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 27/38] tricore: cleanup cpu type name
 composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, kbastian@mail.uni-paderborn.de
List-ID: <qemu-devel.nongnu.org>

introduce TRICORE_CPU_TYPE_NAME macro and use it to construct
cpu type names. While at it move cpu type_infos into one
array and register it directly with type_init_from_array()
instead of custom tricore_cpu_register_types()/cpu_register()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: kbastian@mail.uni-paderborn.de
---
 target/tricore/cpu.h |  2 ++
 target/tricore/cpu.c | 68 ++++++++++++++++------------------------------------
 2 files changed, 22 insertions(+), 48 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index bc53c40..f41d2ce 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -413,6 +413,8 @@ static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, target_ulong *pc,
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_TRICORE_CPU, cpu_model)
 
+#define TRICORE_CPU_TYPE_SUFFIX "-" TYPE_TRICORE_CPU
+#define TRICORE_CPU_TYPE_NAME(model) model TRICORE_CPU_TYPE_SUFFIX
 
 /* helpers.c */
 int cpu_tricore_handle_mmu_fault(CPUState *cpu, target_ulong address,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 871eb35..69d7720 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -120,7 +120,7 @@ static ObjectClass *tricore_cpu_class_by_name(const char *cpu_model)
     ObjectClass *oc;
     char *typename;
 
-    typename = g_strdup_printf("%s-" TYPE_TRICORE_CPU, cpu_model);
+    typename = g_strdup_printf(TRICORE_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
     if (!oc || !object_class_dynamic_cast(oc, TYPE_TRICORE_CPU) ||
@@ -151,19 +151,6 @@ static void tc27x_initfn(Object *obj)
     set_feature(&cpu->env, TRICORE_FEATURE_161);
 }
 
-typedef struct TriCoreCPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-    void (*class_init)(ObjectClass *oc, void *data);
-} TriCoreCPUInfo;
-
-static const TriCoreCPUInfo tricore_cpus[] = {
-    { .name = "tc1796",      .initfn = tc1796_initfn },
-    { .name = "tc1797",      .initfn = tc1797_initfn },
-    { .name = "tc27x",       .initfn = tc27x_initfn },
-    { .name = NULL }
-};
-
 static void tricore_cpu_class_init(ObjectClass *c, void *data)
 {
     TriCoreCPUClass *mcc = TRICORE_CPU_CLASS(c);
@@ -184,41 +171,26 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     cc->get_phys_page_attrs_debug = tricore_cpu_get_phys_page_attrs_debug;
 }
 
-static void cpu_register(const TriCoreCPUInfo *info)
-{
-    TypeInfo type_info = {
-        .parent = TYPE_TRICORE_CPU,
+#define DEFINE_TRICORE_CPU_TYPE(cpu_model, initfn) \
+    {                                              \
+        .parent = TYPE_TRICORE_CPU,                \
+        .instance_init = initfn,                   \
+        .name = TRICORE_CPU_TYPE_NAME(cpu_model),  \
+    }
+
+static const TypeInfo tricore_cpu_type_infos[] = {
+    {
+        .name = TYPE_TRICORE_CPU,
+        .parent = TYPE_CPU,
         .instance_size = sizeof(TriCoreCPU),
-        .instance_init = info->initfn,
+        .instance_init = tricore_cpu_initfn,
+        .abstract = true,
         .class_size = sizeof(TriCoreCPUClass),
-        .class_init = info->class_init,
-    };
-
-    type_info.name = g_strdup_printf("%s-" TYPE_TRICORE_CPU, info->name);
-    type_register(&type_info);
-    g_free((void *)type_info.name);
-}
-
-static const TypeInfo tricore_cpu_type_info = {
-    .name = TYPE_TRICORE_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(TriCoreCPU),
-    .instance_init = tricore_cpu_initfn,
-    .abstract = true,
-    .class_size = sizeof(TriCoreCPUClass),
-    .class_init = tricore_cpu_class_init,
+        .class_init = tricore_cpu_class_init,
+    },
+    DEFINE_TRICORE_CPU_TYPE("tc1796", tc1796_initfn),
+    DEFINE_TRICORE_CPU_TYPE("tc1797", tc1797_initfn),
+    DEFINE_TRICORE_CPU_TYPE("tc27x", tc27x_initfn),
 };
 
-static void tricore_cpu_register_types(void)
-{
-    const TriCoreCPUInfo *info = tricore_cpus;
-
-    type_register_static(&tricore_cpu_type_info);
-
-    while (info->name) {
-        cpu_register(info);
-        info++;
-    }
-}
-
-type_init(tricore_cpu_register_types)
+type_init_from_array(tricore_cpu_type_infos)
-- 
2.7.4
