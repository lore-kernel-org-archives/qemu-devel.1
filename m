Received: from eggs.gnu.org ([2001:4830:134:3::10]:47088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiW-0002DD-1B
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiU-00069e-CV
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiU-00069L-3m
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:46 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:01 +0200
Message-Id: <1506935300-132598-20-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 19/38] sh4: cleanup cpu type name composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, aurelien@aurel32.net
List-ID: <qemu-devel.nongnu.org>

introduce SUPERH_CPU_TYPE_NAME macro and use it to construct
cpu type names. While at it move cpu type_infos into one
array and register it directly with type_init_from_array()
instead of custom superh_cpu_register_types()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: aurelien@aurel32.net
---
 target/sh4/cpu-qom.h |  6 ++---
 target/sh4/cpu.h     |  3 +++
 target/sh4/cpu.c     | 63 +++++++++++++++++++++-------------------------------
 3 files changed, 31 insertions(+), 41 deletions(-)

diff --git a/target/sh4/cpu-qom.h b/target/sh4/cpu-qom.h
index 01abb20..17deeb6 100644
--- a/target/sh4/cpu-qom.h
+++ b/target/sh4/cpu-qom.h
@@ -24,9 +24,9 @@
 
 #define TYPE_SUPERH_CPU "superh-cpu"
 
-#define TYPE_SH7750R_CPU "sh7750r-" TYPE_SUPERH_CPU
-#define TYPE_SH7751R_CPU "sh7751r-" TYPE_SUPERH_CPU
-#define TYPE_SH7785_CPU "sh7785-" TYPE_SUPERH_CPU
+#define TYPE_SH7750R_CPU SUPERH_CPU_TYPE_NAME("sh7750r")
+#define TYPE_SH7751R_CPU SUPERH_CPU_TYPE_NAME("sh7751r")
+#define TYPE_SH7785_CPU  SUPERH_CPU_TYPE_NAME("sh7785")
 
 #define SUPERH_CPU_CLASS(klass) \
     OBJECT_CLASS_CHECK(SuperHCPUClass, (klass), TYPE_SUPERH_CPU)
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 79f85d3..a25a3f6 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -270,6 +270,9 @@ void cpu_load_tlb(CPUSH4State * env);
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_SUPERH_CPU, cpu_model)
 
+#define SUPERH_CPU_TYPE_SUFFIX "-" TYPE_SUPERH_CPU
+#define SUPERH_CPU_TYPE_NAME(model) model SUPERH_CPU_TYPE_SUFFIX
+
 #define cpu_signal_handler cpu_sh4_signal_handler
 #define cpu_list sh4_cpu_list
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 252440e..9198460 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -172,13 +172,6 @@ static void sh7750r_class_init(ObjectClass *oc, void *data)
     scc->cvr = 0x00110000;
 }
 
-static const TypeInfo sh7750r_type_info = {
-    .name = TYPE_SH7750R_CPU,
-    .parent = TYPE_SUPERH_CPU,
-    .class_init = sh7750r_class_init,
-    .instance_init = sh7750r_cpu_initfn,
-};
-
 static void sh7751r_cpu_initfn(Object *obj)
 {
     SuperHCPU *cpu = SUPERH_CPU(obj);
@@ -198,13 +191,6 @@ static void sh7751r_class_init(ObjectClass *oc, void *data)
     scc->cvr = 0x00110000; /* Neutered caches, should be 0x20480000 */
 }
 
-static const TypeInfo sh7751r_type_info = {
-    .name = TYPE_SH7751R_CPU,
-    .parent = TYPE_SUPERH_CPU,
-    .class_init = sh7751r_class_init,
-    .instance_init = sh7751r_cpu_initfn,
-};
-
 static void sh7785_cpu_initfn(Object *obj)
 {
     SuperHCPU *cpu = SUPERH_CPU(obj);
@@ -224,13 +210,6 @@ static void sh7785_class_init(ObjectClass *oc, void *data)
     scc->cvr = 0x71440211;
 }
 
-static const TypeInfo sh7785_type_info = {
-    .name = TYPE_SH7785_CPU,
-    .parent = TYPE_SUPERH_CPU,
-    .class_init = sh7785_class_init,
-    .instance_init = sh7785_cpu_initfn,
-};
-
 static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -303,22 +282,30 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
     dc->vmsd = &vmstate_sh_cpu;
 }
 
-static const TypeInfo superh_cpu_type_info = {
-    .name = TYPE_SUPERH_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(SuperHCPU),
-    .instance_init = superh_cpu_initfn,
-    .abstract = true,
-    .class_size = sizeof(SuperHCPUClass),
-    .class_init = superh_cpu_class_init,
-};
+#define DEFINE_SUPERH_CPU_TYPE(type_name, cinit, initfn) \
+    {                                                    \
+        .name = type_name,                               \
+        .parent = TYPE_SUPERH_CPU,                       \
+        .class_init = cinit,                             \
+        .instance_init = initfn,                         \
+    }
+static const TypeInfo superh_cpu_type_infos[] = {
+    {
+        .name = TYPE_SUPERH_CPU,
+        .parent = TYPE_CPU,
+        .instance_size = sizeof(SuperHCPU),
+        .instance_init = superh_cpu_initfn,
+        .abstract = true,
+        .class_size = sizeof(SuperHCPUClass),
+        .class_init = superh_cpu_class_init,
+    },
+    DEFINE_SUPERH_CPU_TYPE(TYPE_SH7750R_CPU, sh7750r_class_init,
+                           sh7750r_cpu_initfn),
+    DEFINE_SUPERH_CPU_TYPE(TYPE_SH7751R_CPU, sh7751r_class_init,
+                           sh7751r_cpu_initfn),
+    DEFINE_SUPERH_CPU_TYPE(TYPE_SH7785_CPU, sh7785_class_init,
+                           sh7785_cpu_initfn),
 
-static void superh_cpu_register_types(void)
-{
-    type_register_static(&superh_cpu_type_info);
-    type_register_static(&sh7750r_type_info);
-    type_register_static(&sh7751r_type_info);
-    type_register_static(&sh7785_type_info);
-}
+};
 
-type_init(superh_cpu_register_types)
+type_init_from_array(superh_cpu_type_infos)
-- 
2.7.4
