Received: from eggs.gnu.org ([2001:4830:134:3::10]:37860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dul0U-0004Jb-VX
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dul0T-00084c-G7
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:50:03 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dul0T-00084I-Bg
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:50:01 -0400
Received: by mail-qk0-x243.google.com with SMTP id g128so2344763qke.0
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 12:50:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 20 Sep 2017 16:49:33 -0300
Message-Id: <20170920194934.23071-6-f4bug@amsat.org>
In-Reply-To: <20170920194934.23071-1-f4bug@amsat.org>
References: <20170920194934.23071-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 5/6] mips: MIPSCPU model subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, James Hogan <james.hogan@imgtec.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Igor Mammedov <imammedo@redhat.com>

Register separate QOM types for each mips cpu model,
so it would be possible to reuse generic CPU creation
routines.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: use internal.h, use void* to hold cpu_def in MIPSCPUClass,
 mark MIPSCPU abstract, address Eduardo Habkost review]
Tested-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/mips/cpu-qom.h        |  1 +
 target/mips/internal.h       | 59 ++++++++++++++++++++++++++++++++++++++++++++
 target/mips/cpu.c            | 50 ++++++++++++++++++++++++++++++++++++-
 target/mips/translate.c      | 13 +++++-----
 target/mips/translate_init.c | 58 ++-----------------------------------------
 5 files changed, 117 insertions(+), 64 deletions(-)

diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
index 3f5bf23823..ee58606afe 100644
--- a/target/mips/cpu-qom.h
+++ b/target/mips/cpu-qom.h
@@ -49,6 +49,7 @@ typedef struct MIPSCPUClass {
 
     DeviceRealize parent_realize;
     void (*parent_reset)(CPUState *cpu);
+    const struct mips_def_t *cpu_def;
 } MIPSCPUClass;
 
 typedef struct MIPSCPU MIPSCPU;
diff --git a/target/mips/internal.h b/target/mips/internal.h
index cf4c9db427..45ded3484c 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -7,6 +7,65 @@
 #ifndef MIPS_INTERNAL_H
 #define MIPS_INTERNAL_H
 
+
+/* MMU types, the first four entries have the same layout as the
+   CP0C0_MT field.  */
+enum mips_mmu_types {
+    MMU_TYPE_NONE,
+    MMU_TYPE_R4000,
+    MMU_TYPE_RESERVED,
+    MMU_TYPE_FMT,
+    MMU_TYPE_R3000,
+    MMU_TYPE_R6000,
+    MMU_TYPE_R8000
+};
+
+struct mips_def_t {
+    const char *name;
+    int32_t CP0_PRid;
+    int32_t CP0_Config0;
+    int32_t CP0_Config1;
+    int32_t CP0_Config2;
+    int32_t CP0_Config3;
+    int32_t CP0_Config4;
+    int32_t CP0_Config4_rw_bitmask;
+    int32_t CP0_Config5;
+    int32_t CP0_Config5_rw_bitmask;
+    int32_t CP0_Config6;
+    int32_t CP0_Config7;
+    target_ulong CP0_LLAddr_rw_bitmask;
+    int CP0_LLAddr_shift;
+    int32_t SYNCI_Step;
+    int32_t CCRes;
+    int32_t CP0_Status_rw_bitmask;
+    int32_t CP0_TCStatus_rw_bitmask;
+    int32_t CP0_SRSCtl;
+    int32_t CP1_fcr0;
+    int32_t CP1_fcr31_rw_bitmask;
+    int32_t CP1_fcr31;
+    int32_t MSAIR;
+    int32_t SEGBITS;
+    int32_t PABITS;
+    int32_t CP0_SRSConf0_rw_bitmask;
+    int32_t CP0_SRSConf0;
+    int32_t CP0_SRSConf1_rw_bitmask;
+    int32_t CP0_SRSConf1;
+    int32_t CP0_SRSConf2_rw_bitmask;
+    int32_t CP0_SRSConf2;
+    int32_t CP0_SRSConf3_rw_bitmask;
+    int32_t CP0_SRSConf3;
+    int32_t CP0_SRSConf4_rw_bitmask;
+    int32_t CP0_SRSConf4;
+    int32_t CP0_PageGrain_rw_bitmask;
+    int32_t CP0_PageGrain;
+    target_ulong CP0_EBaseWG_rw_bitmask;
+    int insn_flags;
+    enum mips_mmu_types mmu_type;
+};
+
+extern const struct mips_def_t mips_defs[];
+extern const int mips_defs_number;
+
 enum CPUMIPSMSADataFormat {
     DF_BYTE = 0,
     DF_HALF,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e3ef835599..1a9a3ed94d 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -146,14 +146,36 @@ static void mips_cpu_initfn(Object *obj)
     CPUState *cs = CPU(obj);
     MIPSCPU *cpu = MIPS_CPU(obj);
     CPUMIPSState *env = &cpu->env;
+    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(obj);
 
     cs->env_ptr = env;
+    env->cpu_model = mcc->cpu_def;
 
     if (tcg_enabled()) {
         mips_tcg_init();
     }
 }
 
+static char *mips_cpu_type_name(const char *cpu_model)
+{
+    return g_strdup_printf("%s-" TYPE_MIPS_CPU, cpu_model);
+}
+
+static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
+{
+    ObjectClass *oc;
+    char *typename;
+
+    if (cpu_model == NULL) {
+        return NULL;
+    }
+
+    typename = mips_cpu_type_name(cpu_model);
+    oc = object_class_by_name(typename);
+    g_free(typename);
+    return oc;
+}
+
 static void mips_cpu_class_init(ObjectClass *c, void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(c);
@@ -166,6 +188,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     mcc->parent_reset = cc->reset;
     cc->reset = mips_cpu_reset;
 
+    cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work = mips_cpu_has_work;
     cc->do_interrupt = mips_cpu_do_interrupt;
     cc->cpu_exec_interrupt = mips_cpu_exec_interrupt;
@@ -193,14 +216,39 @@ static const TypeInfo mips_cpu_type_info = {
     .parent = TYPE_CPU,
     .instance_size = sizeof(MIPSCPU),
     .instance_init = mips_cpu_initfn,
-    .abstract = false,
+    .abstract = true,
     .class_size = sizeof(MIPSCPUClass),
     .class_init = mips_cpu_class_init,
 };
 
+static void mips_cpu_cpudef_class_init(ObjectClass *oc, void *data)
+{
+    MIPSCPUClass *mcc = MIPS_CPU_CLASS(oc);
+    mcc->cpu_def = data;
+}
+
+static void mips_register_cpudef_type(const struct mips_def_t *def)
+{
+    char *typename = mips_cpu_type_name(def->name);
+    TypeInfo ti = {
+        .name = typename,
+        .parent = TYPE_MIPS_CPU,
+        .class_init = mips_cpu_cpudef_class_init,
+        .class_data = (void *)def,
+    };
+
+    type_register(&ti);
+    g_free(typename);
+}
+
 static void mips_cpu_register_types(void)
 {
+    int i;
+
     type_register_static(&mips_cpu_type_info);
+    for (i = 0; i < mips_defs_number; i++) {
+        mips_register_cpudef_type(&mips_defs[i]);
+    }
 }
 
 type_init(mips_cpu_register_types)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 94c38e8755..f7128bc91d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20525,16 +20525,15 @@ void cpu_mips_realize_env(CPUMIPSState *env)
 
 MIPSCPU *cpu_mips_init(const char *cpu_model)
 {
+    ObjectClass *oc;
     MIPSCPU *cpu;
-    CPUMIPSState *env;
-    const mips_def_t *def;
 
-    def = cpu_mips_find_by_name(cpu_model);
-    if (!def)
+    oc = cpu_class_by_name(TYPE_MIPS_CPU, cpu_model);
+    if (oc == NULL) {
         return NULL;
-    cpu = MIPS_CPU(object_new(TYPE_MIPS_CPU));
-    env = &cpu->env;
-    env->cpu_model = def;
+    }
+
+    cpu = MIPS_CPU(object_new(object_class_get_name(oc)));
 
     object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
 
diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index 255d25bacd..8bbded46c4 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -51,64 +51,9 @@
 #define MIPS_CONFIG5                                              \
 ((0 << CP0C5_M))
 
-/* MMU types, the first four entries have the same layout as the
-   CP0C0_MT field.  */
-enum mips_mmu_types {
-    MMU_TYPE_NONE,
-    MMU_TYPE_R4000,
-    MMU_TYPE_RESERVED,
-    MMU_TYPE_FMT,
-    MMU_TYPE_R3000,
-    MMU_TYPE_R6000,
-    MMU_TYPE_R8000
-};
-
-struct mips_def_t {
-    const char *name;
-    int32_t CP0_PRid;
-    int32_t CP0_Config0;
-    int32_t CP0_Config1;
-    int32_t CP0_Config2;
-    int32_t CP0_Config3;
-    int32_t CP0_Config4;
-    int32_t CP0_Config4_rw_bitmask;
-    int32_t CP0_Config5;
-    int32_t CP0_Config5_rw_bitmask;
-    int32_t CP0_Config6;
-    int32_t CP0_Config7;
-    target_ulong CP0_LLAddr_rw_bitmask;
-    int CP0_LLAddr_shift;
-    int32_t SYNCI_Step;
-    int32_t CCRes;
-    int32_t CP0_Status_rw_bitmask;
-    int32_t CP0_TCStatus_rw_bitmask;
-    int32_t CP0_SRSCtl;
-    int32_t CP1_fcr0;
-    int32_t CP1_fcr31_rw_bitmask;
-    int32_t CP1_fcr31;
-    int32_t MSAIR;
-    int32_t SEGBITS;
-    int32_t PABITS;
-    int32_t CP0_SRSConf0_rw_bitmask;
-    int32_t CP0_SRSConf0;
-    int32_t CP0_SRSConf1_rw_bitmask;
-    int32_t CP0_SRSConf1;
-    int32_t CP0_SRSConf2_rw_bitmask;
-    int32_t CP0_SRSConf2;
-    int32_t CP0_SRSConf3_rw_bitmask;
-    int32_t CP0_SRSConf3;
-    int32_t CP0_SRSConf4_rw_bitmask;
-    int32_t CP0_SRSConf4;
-    int32_t CP0_PageGrain_rw_bitmask;
-    int32_t CP0_PageGrain;
-    target_ulong CP0_EBaseWG_rw_bitmask;
-    int insn_flags;
-    enum mips_mmu_types mmu_type;
-};
-
 /*****************************************************************************/
 /* MIPS CPU definitions */
-static const mips_def_t mips_defs[] =
+const mips_def_t mips_defs[] =
 {
     {
         .name = "4Kc",
@@ -808,6 +753,7 @@ static const mips_def_t mips_defs[] =
 
 #endif
 };
+const int mips_defs_number = ARRAY_SIZE(mips_defs);
 
 static const mips_def_t *cpu_mips_find_by_name (const char *name)
 {
-- 
2.14.1
