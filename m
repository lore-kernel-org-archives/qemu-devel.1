Received: from eggs.gnu.org ([209.51.188.92]:54566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHX-0001a5-0k
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHQ-0000ko-Sd
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:06 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHQ-0000jO-I8
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:00 -0500
Received: by mail-wr1-x42d.google.com with SMTP id f14so10258692wrg.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.50.57
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:50:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:33 +0000
Message-Id: <20190305165051.26860-5-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/22] target/arm: Implement ARMv8.0-PredInv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190301200501.16533-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 13 ++++++++++-
 target/arm/cpu.c    |  1 +
 target/arm/cpu64.c  |  2 ++
 target/arm/helper.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 361e51143c7..c822f94236c 100644
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
@@ -3312,6 +3313,11 @@ static inline bool isar_feature_aa32_sb(const ARMISARegisters *id)
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
@@ -3455,6 +3461,11 @@ static inline bool isar_feature_aa64_sb(const ARMISARegisters *id)
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
index ef069c268df..96f0ff0ec72 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2022,6 +2022,7 @@ static void arm_max_initfn(Object *obj)
             t = FIELD_DP32(t, ID_ISAR6, DP, 1);
             t = FIELD_DP32(t, ID_ISAR6, FHM, 1);
             t = FIELD_DP32(t, ID_ISAR6, SB, 1);
+            t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);
             cpu->isar.id_isar6 = t;
 
             t = cpu->id_mmfr4;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 6788c0f6ff7..87337b63855 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -319,6 +319,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);
         cpu->isar.id_aa64isar1 = t;
 
         t = cpu->isar.id_aa64pfr0;
@@ -351,6 +352,7 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_ISAR6, DP, 1);
         u = FIELD_DP32(u, ID_ISAR6, FHM, 1);
         u = FIELD_DP32(u, ID_ISAR6, SB, 1);
+        u = FIELD_DP32(u, ID_ISAR6, SPECRES, 1);
         cpu->isar.id_isar6 = u;
 
         /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 49ff79a146b..2607d39ad1c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5719,6 +5719,50 @@ static const ARMCPRegInfo pauth_reginfo[] = {
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
@@ -6618,6 +6662,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
2.20.1
