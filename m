Received: from eggs.gnu.org ([2001:4830:134:3::10]:41092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11K-0001GW-Ta
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11J-00018f-M2
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW11J-00018P-D4
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:37 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:51:53 +0200
Message-Id: <1500040339-119465-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 02/28] mips: MIPSCPU model subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

Register separate QOM types for each mips cpu model,
so it would be possible to reuse generic CPU creation
routines.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Aurelien Jarno <aurelien@aurel32.net>
CC: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/cpu-qom.h        |  2 ++
 target/mips/cpu.h            | 57 +++++++++++++++++++++++++++++++++++++++++++-
 target/mips/cpu.c            | 51 +++++++++++++++++++++++++++++++++++++++
 target/mips/translate.c      | 13 +++++-----
 target/mips/translate_init.c | 57 ++------------------------------------------
 5 files changed, 117 insertions(+), 63 deletions(-)

diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
index 3f5bf23..4b32401 100644
--- a/target/mips/cpu-qom.h
+++ b/target/mips/cpu-qom.h
@@ -35,6 +35,7 @@
 #define MIPS_CPU_GET_CLASS(obj) \
     OBJECT_GET_CLASS(MIPSCPUClass, (obj), TYPE_MIPS_CPU)
 
+typedef struct mips_def_t mips_def_t;
 /**
  * MIPSCPUClass:
  * @parent_realize: The parent class' realize handler.
@@ -49,6 +50,7 @@ typedef struct MIPSCPUClass {
 
     DeviceRealize parent_realize;
     void (*parent_reset)(CPUState *cpu);
+    const mips_def_t *cpu_def;
 } MIPSCPUClass;
 
 typedef struct MIPSCPU MIPSCPU;
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 9c32228..7c2e0bf 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -161,7 +161,62 @@ struct CPUMIPSMVPContext {
 #define CP0MVPC1_PCP1	0
 };
 
-typedef struct mips_def_t mips_def_t;
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
+    int insn_flags;
+    enum mips_mmu_types mmu_type;
+};
+
+extern const struct mips_def_t mips_defs[];
+extern const int mips_defs_number;
 
 #define MIPS_SHADOW_SET_MAX 16
 #define MIPS_TC_MAX 5
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 82afdaa..111b5ae 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -151,12 +151,37 @@ static void mips_cpu_initfn(Object *obj)
     CPUState *cs = CPU(obj);
     MIPSCPU *cpu = MIPS_CPU(obj);
     CPUMIPSState *env = &cpu->env;
+    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(obj);
 
     cs->env_ptr = env;
 
     if (tcg_enabled()) {
         mips_tcg_init();
     }
+
+    if (mcc->cpu_def) {
+        env->cpu_model = mcc->cpu_def;
+    }
+}
+
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
 }
 
 static void mips_cpu_class_init(ObjectClass *c, void *data)
@@ -171,6 +196,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     mcc->parent_reset = cc->reset;
     cc->reset = mips_cpu_reset;
 
+    cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work = mips_cpu_has_work;
     cc->do_interrupt = mips_cpu_do_interrupt;
     cc->cpu_exec_interrupt = mips_cpu_exec_interrupt;
@@ -203,9 +229,34 @@ static const TypeInfo mips_cpu_type_info = {
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
index 7b3ae81..ae7ca80 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20193,16 +20193,15 @@ void mips_tcg_init(void)
 
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
index c771ff1..16c214b 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -51,63 +51,9 @@
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
@@ -803,6 +749,7 @@ static const mips_def_t mips_defs[] =
 
 #endif
 };
+const int mips_defs_number = ARRAY_SIZE(mips_defs);
 
 static const mips_def_t *cpu_mips_find_by_name (const char *name)
 {
-- 
2.7.4
