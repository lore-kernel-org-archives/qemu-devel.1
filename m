Received: from eggs.gnu.org ([2001:4830:134:3::10]:46906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiH-0001yN-0g
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiC-0005za-6l
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiB-0005zB-V9
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:28 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:07:46 +0200
Message-Id: <1506935300-132598-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 04/38] cris: cleanup cpu type name composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, edgar.iglesias@gmail.com
List-ID: <qemu-devel.nongnu.org>

replace ambiguous TYPE macro with a new CRIS_CPU_TYPE_NAME
and use it consistently in the code.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: edgar.iglesias@gmail.com
---
 target/cris/cpu.h |  3 ++
 target/cris/cpu.c | 93 +++++++++++++++++++++++--------------------------------
 2 files changed, 42 insertions(+), 54 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 5d822de..b64fa35 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -269,6 +269,9 @@ enum {
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_CRIS_CPU, cpu_model)
 
+#define CRIS_CPU_TYPE_SUFFIX "-" TYPE_CRIS_CPU
+#define CRIS_CPU_TYPE_NAME(name) (name CRIS_CPU_TYPE_SUFFIX)
+
 #define cpu_signal_handler cpu_cris_signal_handler
 
 /* MMU modes definitions */
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 88d93f2..8681c84 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -71,11 +71,11 @@ static ObjectClass *cris_cpu_class_by_name(const char *cpu_model)
 
 #if defined(CONFIG_USER_ONLY)
     if (strcasecmp(cpu_model, "any") == 0) {
-        return object_class_by_name("crisv32-" TYPE_CRIS_CPU);
+        return object_class_by_name(CRIS_CPU_TYPE_NAME("crisv32"));
     }
 #endif
 
-    typename = g_strdup_printf("%s-" TYPE_CRIS_CPU, cpu_model);
+    typename = g_strdup_printf(CRIS_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
     if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_CRIS_CPU) ||
@@ -108,7 +108,7 @@ static void cris_cpu_list_entry(gpointer data, gpointer user_data)
     const char *typename = object_class_get_name(oc);
     char *name;
 
-    name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_CRIS_CPU));
+    name = g_strndup(typename, strlen(typename) - strlen(CRIS_CPU_TYPE_SUFFIX));
     (*s->cpu_fprintf)(s->file, "  %s\n", name);
     g_free(name);
 }
@@ -259,38 +259,6 @@ static void crisv32_cpu_class_init(ObjectClass *oc, void *data)
     ccc->vr = 32;
 }
 
-#define TYPE(model) model "-" TYPE_CRIS_CPU
-
-static const TypeInfo cris_cpu_model_type_infos[] = {
-    {
-        .name = TYPE("crisv8"),
-        .parent = TYPE_CRIS_CPU,
-        .class_init = crisv8_cpu_class_init,
-    }, {
-        .name = TYPE("crisv9"),
-        .parent = TYPE_CRIS_CPU,
-        .class_init = crisv9_cpu_class_init,
-    }, {
-        .name = TYPE("crisv10"),
-        .parent = TYPE_CRIS_CPU,
-        .class_init = crisv10_cpu_class_init,
-    }, {
-        .name = TYPE("crisv11"),
-        .parent = TYPE_CRIS_CPU,
-        .class_init = crisv11_cpu_class_init,
-    }, {
-        .name = TYPE("crisv17"),
-        .parent = TYPE_CRIS_CPU,
-        .class_init = crisv17_cpu_class_init,
-    }, {
-        .name = TYPE("crisv32"),
-        .parent = TYPE_CRIS_CPU,
-        .class_init = crisv32_cpu_class_init,
-    }
-};
-
-#undef TYPE
-
 static void cris_cpu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -324,24 +292,41 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
     cc->disas_set_info = cris_disas_set_info;
 }
 
-static const TypeInfo cris_cpu_type_info = {
-    .name = TYPE_CRIS_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(CRISCPU),
-    .instance_init = cris_cpu_initfn,
-    .abstract = true,
-    .class_size = sizeof(CRISCPUClass),
-    .class_init = cris_cpu_class_init,
-};
-
-static void cris_cpu_register_types(void)
-{
-    int i;
-
-    type_register_static(&cris_cpu_type_info);
-    for (i = 0; i < ARRAY_SIZE(cris_cpu_model_type_infos); i++) {
-        type_register_static(&cris_cpu_model_type_infos[i]);
+static const TypeInfo cris_cpu_model_type_infos[] = {
+    {
+        .name = TYPE_CRIS_CPU,
+        .parent = TYPE_CPU,
+        .instance_size = sizeof(CRISCPU),
+        .instance_init = cris_cpu_initfn,
+        .abstract = true,
+        .class_size = sizeof(CRISCPUClass),
+        .class_init = cris_cpu_class_init,
+    },
+    {
+        .name = CRIS_CPU_TYPE_NAME("crisv8"),
+        .parent = TYPE_CRIS_CPU,
+        .class_init = crisv8_cpu_class_init,
+    }, {
+        .name = CRIS_CPU_TYPE_NAME("crisv9"),
+        .parent = TYPE_CRIS_CPU,
+        .class_init = crisv9_cpu_class_init,
+    }, {
+        .name = CRIS_CPU_TYPE_NAME("crisv10"),
+        .parent = TYPE_CRIS_CPU,
+        .class_init = crisv10_cpu_class_init,
+    }, {
+        .name = CRIS_CPU_TYPE_NAME("crisv11"),
+        .parent = TYPE_CRIS_CPU,
+        .class_init = crisv11_cpu_class_init,
+    }, {
+        .name = CRIS_CPU_TYPE_NAME("crisv17"),
+        .parent = TYPE_CRIS_CPU,
+        .class_init = crisv17_cpu_class_init,
+    }, {
+        .name = CRIS_CPU_TYPE_NAME("crisv32"),
+        .parent = TYPE_CRIS_CPU,
+        .class_init = crisv32_cpu_class_init,
     }
-}
+};
 
-type_init(cris_cpu_register_types)
+type_init_from_array(cris_cpu_model_type_infos)
-- 
2.7.4
