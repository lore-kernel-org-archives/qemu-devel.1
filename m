Received: from eggs.gnu.org ([209.51.188.92]:43948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzBN7-0003OJ-Ec
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 21:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzBN2-000574-19
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 21:24:24 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzBN1-00056E-Pe
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 21:24:23 -0500
Received: by mail-pl1-x643.google.com with SMTP id k2so8955939plt.3
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 18:24:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Feb 2019 18:24:15 -0800
Message-Id: <20190228022415.27878-4-richard.henderson@linaro.org>
In-Reply-To: <20190228022415.27878-1-richard.henderson@linaro.org>
References: <20190228022415.27878-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 3/3] target/arm: Implement ARMv8.0-PredRes
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
 target/arm/cpu.h    | 13 ++++++++++-
 target/arm/cpu.c    |  1 +
 target/arm/cpu64.c  |  2 ++
 target/arm/helper.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1a6ca35ea7..e1acc711cf 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1060,7 +1060,8 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_R       (1U << 9) /* up to v6; RAZ in v7 */
 #define SCTLR_UMA     (1U << 9) /* v8 onward, AArch64 only */
 #define SCTLR_F       (1U << 10) /* up to v6 */
-#define SCTLR_SW      (1U << 10) /* v7, RES0 in v8 */
+#define SCTLR_SW      (1U << 10) /* v7 */
+#define SCTLR_EnRCTX  (1U << 10) /* in v8.0-PredInv */
 #define SCTLR_Z       (1U << 11) /* in v7, RES1 in v8 */
 #define SCTLR_EOS     (1U << 11) /* v8.5-ExS */
 #define SCTLR_I       (1U << 12)
@@ -3294,6 +3295,11 @@ static inline bool isar_feature_aa32_sb(const ARMISARegisters *id)
     return FIELD_EX32(id->id_isar6, ID_ISAR6, SB) != 0;
 }
 
+static inline bool isar_feature_aa32_predinv(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar6, ID_ISAR6, SPECRES) != 0;
+}
+
 static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
 {
     /*
@@ -3397,6 +3403,11 @@ static inline bool isar_feature_aa64_sb(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SB) != 0;
 }
 
+static inline bool isar_feature_aa64_predinv(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SPECRES) != 0;
+}
+
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7940d49c1d..b78e1d610e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2004,6 +2004,7 @@ static void arm_max_initfn(Object *obj)
             t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
             t = FIELD_DP32(t, ID_ISAR6, DP, 1);
             t = FIELD_DP32(t, ID_ISAR6, SB, 1);
+            t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);
             cpu->isar.id_isar6 = t;
 
             t = cpu->id_mmfr4;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 168aa9e0f1..92c75cbfa6 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -318,6 +318,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);
         cpu->isar.id_aa64isar1 = t;
 
         t = cpu->isar.id_aa64pfr0;
@@ -349,6 +350,7 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_ISAR6, JSCVT, 1);
         u = FIELD_DP32(u, ID_ISAR6, DP, 1);
         u = FIELD_DP32(u, ID_ISAR6, SB, 1);
+        u = FIELD_DP32(u, ID_ISAR6, SPECRES, 1);
         cpu->isar.id_isar6 = u;
 
         /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8a71a80dfd..554f111ea8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5742,6 +5742,50 @@ static const ARMCPRegInfo pauth_reginfo[] = {
 };
 #endif
 
+static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
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
+static const ARMCPRegInfo predinv_reginfo[] = {
+    { .name = "CFP_RCTX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 3, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL0_W, .accessfn = access_predinv },
+    { .name = "DVP_RCTX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 3, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL0_W, .accessfn = access_predinv },
+    { .name = "CPP_RCTX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 3, .opc2 = 7,
+      .type = ARM_CP_NOP, .access = PL0_W, .accessfn = access_predinv },
+    /*
+     * Note the AArch32 opcodes have a different OPC1.
+     */
+    { .name = "CFPRCTX", .state = ARM_CP_STATE_AA32,
+      .cp = 15, .opc1 = 0, .crn = 7, .crm = 3, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL0_W, .accessfn = access_predinv },
+    { .name = "DVPRCTX", .state = ARM_CP_STATE_AA32,
+      .cp = 15, .opc1 = 0, .crn = 7, .crm = 3, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL0_W, .accessfn = access_predinv },
+    { .name = "CPPRCTX", .state = ARM_CP_STATE_AA32,
+      .cp = 15, .opc1 = 0, .crn = 7, .crm = 3, .opc2 = 7,
+      .type = ARM_CP_NOP, .access = PL0_W, .accessfn = access_predinv },
+    REGINFO_SENTINEL
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -6641,6 +6685,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, pauth_reginfo);
     }
 #endif
+
+    /*
+     * While all v8.0 cpus support aarch64, QEMU does have configurations
+     * that do not set ID_AA64ISAR1, e.g. user-only qemu-arm -cpu max,
+     * which will set ID_ISAR6.
+     */
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
+        ? cpu_isar_feature(aa64_predinv, cpu)
+        : cpu_isar_feature(aa32_predinv, cpu)) {
+        define_arm_cp_regs(cpu, predinv_reginfo);
+    }
 }
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
-- 
2.17.2
