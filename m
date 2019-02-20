Received: from eggs.gnu.org ([209.51.188.92]:48857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwbdf-000720-Co
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 18:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwbdV-0005d7-A8
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 18:50:48 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:45427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwbdU-000458-QQ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 18:50:45 -0500
Received: by mail-pg1-x536.google.com with SMTP id y4so12732242pgc.12
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 15:50:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Feb 2019 15:50:17 -0800
Message-Id: <20190220235017.1060-3-richard.henderson@linaro.org>
In-Reply-To: <20190220235017.1060-1-richard.henderson@linaro.org>
References: <20190220235017.1060-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Implement ARMv8.0-PredRes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is named "Execution and Data prediction restriction instructions"
within the ARMv8.5 manual, and given the name "PredRes" by binutils.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 11 ++++++++++
 target/arm/cpu.c    |  1 +
 target/arm/cpu64.c  |  2 ++
 target/arm/helper.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 76d6a73c0e..202ff1f1ea 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1074,6 +1074,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_UMA     (1U << 9) /* v8 onward, AArch64 only */
 #define SCTLR_F       (1U << 10) /* up to v6 */
 #define SCTLR_SW      (1U << 10) /* v7, RES0 in v8 */
+#define SCTLR_EnRCTX  (1U << 10) /* in v8.0-specres */
 #define SCTLR_Z       (1U << 11) /* in v7, RES1 in v8 */
 #define SCTLR_EOS     (1U << 11) /* v8.5-ExS */
 #define SCTLR_I       (1U << 12)
@@ -3307,6 +3308,11 @@ static inline bool isar_feature_aa32_sb(const ARMISARegisters *id)
     return FIELD_EX32(id->id_isar6, ID_ISAR6, SB) != 0;
 }
 
+static inline bool isar_feature_aa32_specres(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, SPECRES) != 0;
+}
+
 static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
 {
     /*
@@ -3415,6 +3421,11 @@ static inline bool isar_feature_aa64_sb(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SB) != 0;
 }
 
+static inline bool isar_feature_aa64_specres(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SPECRES) != 0;
+}
+
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5cd27f2f64..c1d2848baa 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2028,6 +2028,7 @@ static void arm_max_initfn(Object *obj)
             t = cpu->isar.id_isar6;
             t = FIELD_DP32(t, ID_ISAR6, DP, 1);
             t = FIELD_DP32(t, ID_ISAR6, SB, 1);
+            t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);
             cpu->isar.id_isar6 = t;
 
             t = cpu->id_mmfr4;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 95c6ee4cda..5f273399db 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -344,6 +344,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);
         cpu->isar.id_aa64isar1 = t;
 
         t = cpu->isar.id_aa64pfr0;
@@ -375,6 +376,7 @@ static void aarch64_max_initfn(Object *obj)
         u = cpu->isar.id_isar6;
         u = FIELD_DP32(u, ID_ISAR6, DP, 1);
         u = FIELD_DP32(u, ID_ISAR6, SB, 1);
+        u = FIELD_DP32(u, ID_ISAR6, SPECRES, 1);
         cpu->isar.id_isar6 = u;
 
         /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a2ab300051..c34b1401bd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5884,6 +5884,50 @@ static const ARMCPRegInfo mte_reginfo[] = {
 };
 #endif
 
+static CPAccessResult access_specres(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el == 0) {
+        uint64_t sctlr = arm_sctlr(env, el);
+        if (!(sctlr & SCTLR_EnRCTX)) {
+            return CP_ACCESS_TRAP;
+        }
+    } else if (el == 1) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+        if (hcr & HCR_NV) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+    return CP_ACCESS_OK;
+}
+
+static const ARMCPRegInfo specres_reginfo[] = {
+    { .name = "CFP_RCTX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 3, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL0_W, .accessfn = access_specres },
+    { .name = "DVP_RCTX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 3, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL0_W, .accessfn = access_specres },
+    { .name = "CPP_RCTX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 3, .opc2 = 7,
+      .type = ARM_CP_NOP, .access = PL0_W, .accessfn = access_specres },
+    /*
+     * Note the AArch32 opcodes have a different OPC1.
+     */
+    { .name = "CFPRCTX", .state = ARM_CP_STATE_AA32,
+      .cp = 15, .opc1 = 0, .crn = 7, .crm = 3, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL0_W, .accessfn = access_specres },
+    { .name = "DVPRCTX", .state = ARM_CP_STATE_AA32,
+      .cp = 15, .opc1 = 0, .crn = 7, .crm = 3, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL0_W, .accessfn = access_specres },
+    { .name = "CPPRCTX", .state = ARM_CP_STATE_AA32,
+      .cp = 15, .opc1 = 0, .crn = 7, .crm = 3, .opc2 = 7,
+      .type = ARM_CP_NOP, .access = PL0_W, .accessfn = access_specres },
+    REGINFO_SENTINEL
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -6786,6 +6830,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, mte_reginfo);
     }
 #endif
+
+    /* All v8.0-a cpus support aarch64.  */
+    if (cpu_isar_feature(aa64_specres, cpu)) {
+        define_arm_cp_regs(cpu, specres_reginfo);
+    }
 }
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
-- 
2.17.2
