Received: from eggs.gnu.org ([2001:4830:134:3::10]:39003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1Hsa-000446-46
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1HsY-0000Wc-1P
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:41:08 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f1HsX-0000Vm-P5
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:41:05 -0400
Received: by mail-pg0-x242.google.com with SMTP id y16so1015364pgv.1
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 13:41:05 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 28 Mar 2018 13:40:18 -0700
Message-Id: <1522269619-48636-2-git-send-email-mjc@sifive.com>
In-Reply-To: <1522269619-48636-1-git-send-email-mjc@sifive.com>
References: <1522269619-48636-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/2] RISC-V: Convert cpu definition to future
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Igor Mammedov <imammedo@redhat.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

- Model borrowed from target/sh4/cpu.c
- Rewrote riscv_cpu_list to use object_class_get_list
- Dropped 'struct RISCVCPUInfo' and used TypeInfo array
- Replaced riscv_cpu_register_types with DEFINE_TYPES
- Marked base class as abstract
- Fixes -cpu list

Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 target/riscv/cpu.c | 123 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 54 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9de34d7..5a527fb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -115,6 +115,8 @@ static void riscv_any_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
+#if defined(TARGET_RISCV32)
+
 static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -141,6 +143,8 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
+#elif defined(TARGET_RISCV64)
+
 static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -167,20 +171,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
-static const RISCVCPUInfo riscv_cpus[] = {
-    { 96, TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init },
-    { 32, TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init },
-    { 32, TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init },
-    { 32, TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init },
-    { 32, TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init },
-    { 32, TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init },
-    { 64, TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cpu_init },
-    { 64, TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cpu_init },
-    { 64, TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init },
-    { 64, TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init },
-    { 64, TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init },
-    { 0, NULL, NULL }
-};
+#endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
@@ -366,28 +357,6 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->vmsd = &vmstate_riscv_cpu;
 }
 
-static void cpu_register(const RISCVCPUInfo *info)
-{
-    TypeInfo type_info = {
-        .name = info->name,
-        .parent = TYPE_RISCV_CPU,
-        .instance_size = sizeof(RISCVCPU),
-        .instance_init = info->initfn,
-    };
-
-    type_register(&type_info);
-}
-
-static const TypeInfo riscv_cpu_type_info = {
-    .name = TYPE_RISCV_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(RISCVCPU),
-    .instance_init = riscv_cpu_init,
-    .abstract = false,
-    .class_size = sizeof(RISCVCPUClass),
-    .class_init = riscv_cpu_class_init,
-};
-
 char *riscv_isa_string(RISCVCPU *cpu)
 {
     int i;
@@ -403,30 +372,76 @@ char *riscv_isa_string(RISCVCPU *cpu)
     return isa_str;
 }
 
-void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+typedef struct RISCVCPUListState {
+    fprintf_function cpu_fprintf;
+    FILE *file;
+} RISCVCPUListState;
+
+static gint riscv_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
-    const RISCVCPUInfo *info = riscv_cpus;
+    ObjectClass *class_a = (ObjectClass *)a;
+    ObjectClass *class_b = (ObjectClass *)b;
+    const char *name_a, *name_b;
 
-    while (info->name) {
-        if (info->bit_widths & TARGET_LONG_BITS) {
-            (*cpu_fprintf)(f, "%s\n", info->name);
-        }
-        info++;
-    }
+    name_a = object_class_get_name(class_a);
+    name_b = object_class_get_name(class_b);
+    return strcmp(name_a, name_b);
 }
 
-static void riscv_cpu_register_types(void)
+static void riscv_cpu_list_entry(gpointer data, gpointer user_data)
 {
-    const RISCVCPUInfo *info = riscv_cpus;
+    RISCVCPUListState *s = user_data;
+    const char *typename = object_class_get_name(OBJECT_CLASS(data));
+    int len = strlen(typename) - strlen(RISCV_CPU_TYPE_SUFFIX);
 
-    type_register_static(&riscv_cpu_type_info);
+    (*s->cpu_fprintf)(s->file, "%.*s\n", len, typename);
+}
 
-    while (info->name) {
-        if (info->bit_widths & TARGET_LONG_BITS) {
-            cpu_register(info);
-        }
-        info++;
-    }
+void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+{
+    RISCVCPUListState s = {
+        .cpu_fprintf = cpu_fprintf,
+        .file = f,
+    };
+    GSList *list;
+
+    list = object_class_get_list(TYPE_RISCV_CPU, false);
+    list = g_slist_sort(list, riscv_cpu_list_compare);
+    g_slist_foreach(list, riscv_cpu_list_entry, &s);
+    g_slist_free(list);
 }
 
-type_init(riscv_cpu_register_types)
+#define DEFINE_CPU(type_name, initfn)      \
+    {                                      \
+        .name = type_name,                 \
+        .parent = TYPE_RISCV_CPU,          \
+        .instance_init = initfn            \
+    }
+
+static const TypeInfo riscv_cpu_type_infos[] = {
+    {
+        .name = TYPE_RISCV_CPU,
+        .parent = TYPE_CPU,
+        .instance_size = sizeof(RISCVCPU),
+        .instance_init = riscv_cpu_init,
+        .abstract = true,
+        .class_size = sizeof(RISCVCPUClass),
+        .class_init = riscv_cpu_class_init,
+    },
+    DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
+#if defined(TARGET_RISCV32)
+    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init)
+#elif defined(TARGET_RISCV64)
+    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init)
+#endif
+};
+
+DEFINE_TYPES(riscv_cpu_type_infos)
-- 
2.7.0
