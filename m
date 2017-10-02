Received: from eggs.gnu.org ([2001:4830:134:3::10]:47081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiV-0002Co-Mx
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiP-00067p-BL
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiP-00067S-2K
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:41 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:07:57 +0200
Message-Id: <1506935300-132598-16-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 15/38] openrisc: cleanup cpu type name
 composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, shorne@gmail.com
List-ID: <qemu-devel.nongnu.org>

use new OPENRISC_CPU_TYPE_NAME to compose CPU type name and get
rid of intermediate OpenRISCCPUInfo/openrisc_cpu_register_types()
which is replaced by static TypeInfo array.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: shorne@gmail.com
---
 target/openrisc/cpu.h |  3 +++
 target/openrisc/cpu.c | 69 +++++++++++++++++----------------------------------
 2 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f51b89a..576cf66 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -390,6 +390,9 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_OPENRISC_CPU, cpu_model)
 
+#define OPENRISC_CPU_TYPE_SUFFIX "-" TYPE_OPENRISC_CPU
+#define OPENRISC_CPU_TYPE_NAME(model) model OPENRISC_CPU_TYPE_SUFFIX
+
 #include "exec/cpu-all.h"
 
 #define TB_FLAGS_DFLAG 1
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index af9cdcc..4dfb777 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -108,7 +108,7 @@ static ObjectClass *openrisc_cpu_class_by_name(const char *cpu_model)
     ObjectClass *oc;
     char *typename;
 
-    typename = g_strdup_printf("%s-" TYPE_OPENRISC_CPU, cpu_model);
+    typename = g_strdup_printf(OPENRISC_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
     if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_OPENRISC_CPU) ||
@@ -133,16 +133,6 @@ static void openrisc_any_initfn(Object *obj)
     cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_EVBARP;
 }
 
-typedef struct OpenRISCCPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-} OpenRISCCPUInfo;
-
-static const OpenRISCCPUInfo openrisc_cpus[] = {
-    { .name = "or1200",      .initfn = or1200_initfn },
-    { .name = "any",         .initfn = openrisc_any_initfn },
-};
-
 static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
 {
     OpenRISCCPUClass *occ = OPENRISC_CPU_CLASS(oc);
@@ -172,40 +162,6 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_num_core_regs = 32 + 3;
 }
 
-static void cpu_register(const OpenRISCCPUInfo *info)
-{
-    TypeInfo type_info = {
-        .parent = TYPE_OPENRISC_CPU,
-        .instance_size = sizeof(OpenRISCCPU),
-        .instance_init = info->initfn,
-        .class_size = sizeof(OpenRISCCPUClass),
-    };
-
-    type_info.name = g_strdup_printf("%s-" TYPE_OPENRISC_CPU, info->name);
-    type_register(&type_info);
-    g_free((void *)type_info.name);
-}
-
-static const TypeInfo openrisc_cpu_type_info = {
-    .name = TYPE_OPENRISC_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(OpenRISCCPU),
-    .instance_init = openrisc_cpu_initfn,
-    .abstract = true,
-    .class_size = sizeof(OpenRISCCPUClass),
-    .class_init = openrisc_cpu_class_init,
-};
-
-static void openrisc_cpu_register_types(void)
-{
-    int i;
-
-    type_register_static(&openrisc_cpu_type_info);
-    for (i = 0; i < ARRAY_SIZE(openrisc_cpus); i++) {
-        cpu_register(&openrisc_cpus[i]);
-    }
-}
-
 /* Sort alphabetically by type name, except for "any". */
 static gint openrisc_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
@@ -254,4 +210,25 @@ void cpu_openrisc_list(FILE *f, fprintf_function cpu_fprintf)
     g_slist_free(list);
 }
 
-type_init(openrisc_cpu_register_types)
+#define DEFINE_OPENRISC_CPU_TYPE(cpu_model, initfn) \
+    {                                               \
+        .parent = TYPE_OPENRISC_CPU,                \
+        .instance_init = initfn,                    \
+        .name = OPENRISC_CPU_TYPE_NAME(cpu_model),  \
+    }
+
+static const TypeInfo openrisc_cpus_type_infos[] = {
+    { /* base class should be registered first */
+        .name = TYPE_OPENRISC_CPU,
+        .parent = TYPE_CPU,
+        .instance_size = sizeof(OpenRISCCPU),
+        .instance_init = openrisc_cpu_initfn,
+        .abstract = true,
+        .class_size = sizeof(OpenRISCCPUClass),
+        .class_init = openrisc_cpu_class_init,
+    },
+    DEFINE_OPENRISC_CPU_TYPE("or1200", or1200_initfn),
+    DEFINE_OPENRISC_CPU_TYPE("any", openrisc_any_initfn),
+};
+
+type_init_from_array(openrisc_cpus_type_infos)
-- 
2.7.4
