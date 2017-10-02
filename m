Received: from eggs.gnu.org ([2001:4830:134:3::10]:46887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiG-0001xO-0a
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiE-00061O-S5
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiE-00060k-KB
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:30 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:07:48 +0200
Message-Id: <1506935300-132598-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 06/38] lm32: cleanup cpu type name composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, michael@walle.cc
List-ID: <qemu-devel.nongnu.org>

introduce LM32_CPU_TYPE_NAME macro and consistently use it
to construct cpu type names. While at it replace dynamic
cpu type name composition with static data.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: michael@walle.cc
---
 target/lm32/cpu.h |  3 +++
 target/lm32/cpu.c | 74 +++++++++++++++++--------------------------------------
 2 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index de265b5..2279594 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -257,6 +257,9 @@ bool lm32_cpu_do_semihosting(CPUState *cs);
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_LM32_CPU, cpu_model)
 
+#define LM32_CPU_TYPE_SUFFIX "-" TYPE_LM32_CPU
+#define LM32_CPU_TYPE_NAME(model) model LM32_CPU_TYPE_SUFFIX
+
 #define cpu_list lm32_cpu_list
 #define cpu_signal_handler cpu_lm32_signal_handler
 
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index bf081f5..4d0da50 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -51,7 +51,7 @@ static void lm32_cpu_list_entry(gpointer data, gpointer user_data)
     const char *typename = object_class_get_name(oc);
     char *name;
 
-    name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_LM32_CPU));
+    name = g_strndup(typename, strlen(typename) - strlen(LM32_CPU_TYPE_SUFFIX));
     (*s->cpu_fprintf)(s->file, "  %s\n", name);
     g_free(name);
 }
@@ -221,32 +221,12 @@ static void lm32_full_cpu_initfn(Object *obj)
                   | LM32_FEATURE_CYCLE_COUNT;
 }
 
-typedef struct LM32CPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-} LM32CPUInfo;
-
-static const LM32CPUInfo lm32_cpus[] = {
-    {
-        .name = "lm32-basic",
-        .initfn = lm32_basic_cpu_initfn,
-    },
-    {
-        .name = "lm32-standard",
-        .initfn = lm32_standard_cpu_initfn,
-    },
-    {
-        .name = "lm32-full",
-        .initfn = lm32_full_cpu_initfn,
-    },
-};
-
 static ObjectClass *lm32_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
     char *typename;
 
-    typename = g_strdup_printf("%s-" TYPE_LM32_CPU, cpu_model);
+    typename = g_strdup_printf(LM32_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
     if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_LM32_CPU) ||
@@ -288,36 +268,26 @@ static void lm32_cpu_class_init(ObjectClass *oc, void *data)
     cc->disas_set_info = lm32_cpu_disas_set_info;
 }
 
-static void lm32_register_cpu_type(const LM32CPUInfo *info)
-{
-    TypeInfo type_info = {
-        .parent = TYPE_LM32_CPU,
-        .instance_init = info->initfn,
-    };
-
-    type_info.name = g_strdup_printf("%s-" TYPE_LM32_CPU, info->name);
-    type_register(&type_info);
-    g_free((void *)type_info.name);
-}
+#define DEFINE_LM32_CPU_TYPE(cpu_model, initfn) \
+    { \
+        .parent = TYPE_LM32_CPU, \
+        .name = LM32_CPU_TYPE_NAME(cpu_model), \
+        .instance_init = initfn, \
+    }
 
-static const TypeInfo lm32_cpu_type_info = {
-    .name = TYPE_LM32_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(LM32CPU),
-    .instance_init = lm32_cpu_initfn,
-    .abstract = true,
-    .class_size = sizeof(LM32CPUClass),
-    .class_init = lm32_cpu_class_init,
+static const TypeInfo lm32_cpus_type_infos[] = {
+    { /* base class should be registered first */
+         .name = TYPE_LM32_CPU,
+         .parent = TYPE_CPU,
+         .instance_size = sizeof(LM32CPU),
+         .instance_init = lm32_cpu_initfn,
+         .abstract = true,
+         .class_size = sizeof(LM32CPUClass),
+         .class_init = lm32_cpu_class_init,
+    },
+    DEFINE_LM32_CPU_TYPE("lm32-basic", lm32_basic_cpu_initfn),
+    DEFINE_LM32_CPU_TYPE("lm32-standard", lm32_standard_cpu_initfn),
+    DEFINE_LM32_CPU_TYPE("lm32-full", lm32_full_cpu_initfn),
 };
 
-static void lm32_cpu_register_types(void)
-{
-    int i;
-
-    type_register_static(&lm32_cpu_type_info);
-    for (i = 0; i < ARRAY_SIZE(lm32_cpus); i++) {
-        lm32_register_cpu_type(&lm32_cpus[i]);
-    }
-}
-
-type_init(lm32_cpu_register_types)
+type_init_from_array(lm32_cpus_type_infos)
-- 
2.7.4
