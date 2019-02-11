Received: from eggs.gnu.org ([209.51.188.92]:38167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOH-0005R5-0l
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOE-0004bQ-QE
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:32 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOE-0004Oo-9H
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:30 -0500
Received: by mail-pl1-x641.google.com with SMTP id b5so335702plr.4
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:36 -0800
Message-Id: <20190211235258.542-7-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 06/28] target/arm: Add MTE system registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

This is TFSRE0_EL1, TFSR_EL1, TFSR_EL2, TFSR_EL3,
RGSR_EL1, GCR_EL1, GMID_EL1, and PSTATE.TCO.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Add GMID; add access_mte.
---
 target/arm/cpu.h           |  5 +++
 target/arm/internals.h     |  6 ++++
 target/arm/translate.h     | 11 +++++++
 target/arm/helper.c        | 66 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 11 +++++++
 5 files changed, 99 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2776df6981..74633a7a78 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -495,6 +495,11 @@ typedef struct CPUARMState {
         uint64_t pmccfiltr_el0; /* Performance Monitor Filter Register */
         uint64_t vpidr_el2; /* Virtualization Processor ID Register */
         uint64_t vmpidr_el2; /* Virtualization Multiprocessor ID Register */
+#ifdef TARGET_AARCH64
+        uint64_t tfsr_el[4]; /* tfsrel0_el1 is index 0.  */
+        uint64_t gcr_el1;
+        uint64_t rgsr_el1;
+#endif
     } cp15;
 
     struct {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2922324f63..fbfa770c23 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1002,4 +1002,10 @@ static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
     return sctlr != 0;
 }
 
+/*
+ * The log2 of the words in the tag block, for GMID_EL1.BS.
+ * The is the maximum, 256 bytes, which manipulates 64-bits of tags.
+ */
+#define GMID_EL1_BS  6
+
 #endif
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 5a101e1c6d..a24757d3d7 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -204,6 +204,17 @@ static inline TCGv_i32 get_ahp_flag(void)
     return ret;
 }
 
+/* Set bits within PSTATE.  */
+static inline void set_pstate_bits(uint32_t bits)
+{
+    TCGv_i32 p = tcg_temp_new_i32();
+
+    tcg_gen_ld_i32(p, cpu_env, offsetof(CPUARMState, pstate));
+    tcg_gen_ori_i32(p, p, bits);
+    tcg_gen_st_i32(p, cpu_env, offsetof(CPUARMState, pstate));
+    tcg_temp_free_i32(p);
+}
+
 /* Clear bits within PSTATE.  */
 static inline void clear_pstate_bits(uint32_t bits)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index cbe3500f78..f8e4e6f8ae 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5732,6 +5732,69 @@ static const ARMCPRegInfo pauth_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, apib_key.hi) },
     REGINFO_SENTINEL
 };
+
+static CPAccessResult access_mte(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el < 2 &&
+        arm_feature(env, ARM_FEATURE_EL2) &&
+        !(arm_hcr_el2_eff(env) & HCR_ATA)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    if (el < 3 &&
+        arm_feature(env, ARM_FEATURE_EL3) &&
+        !(env->cp15.scr_el3 & SCR_ATA)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
+static uint64_t tco_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return env->pstate & PSTATE_TCO;
+}
+
+static void tco_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t val)
+{
+    env->pstate = (env->pstate & ~PSTATE_TCO) | (val & PSTATE_TCO);
+}
+
+static const ARMCPRegInfo mte_reginfo[] = {
+    { .name = "TFSRE0_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 6, .crm = 6, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[0]) },
+    { .name = "TFSR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 6, .crm = 5, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[1]) },
+    { .name = "TFSR_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 4, .crn = 6, .crm = 5, .opc2 = 0,
+      .access = PL2_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[2]) },
+    { .name = "TFSR_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 6, .crm = 6, .opc2 = 0,
+      .access = PL3_RW,
+      .fieldoffset = offsetof(CPUARMState, cp15.tfsr_el[3]) },
+    { .name = "RGSR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 5,
+      .access = PL1_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.rgsr_el1) },
+    { .name = "GCR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 6,
+      .access = PL1_RW, .accessfn = access_mte,
+      .fieldoffset = offsetof(CPUARMState, cp15.gcr_el1) },
+    { .name = "TCO", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 4, .crm = 2, .opc2 = 7,
+      .type = ARM_CP_NO_RAW,
+      .access = PL0_RW, .readfn = tco_read, .writefn = tco_write },
+    { .name = "GMID_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 4,
+      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = GMID_EL1_BS },
+    REGINFO_SENTINEL
+};
 #endif
 
 void register_cp_regs_for_features(ARMCPU *cpu)
@@ -6577,6 +6640,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         define_arm_cp_regs(cpu, pauth_reginfo);
     }
+    if (cpu_isar_feature(aa64_mte_insn_reg, cpu)) {
+        define_arm_cp_regs(cpu, mte_reginfo);
+    }
 #endif
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3950067b79..f397603688 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1666,6 +1666,17 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         s->base.is_jmp = DISAS_UPDATE;
         break;
 
+    case 0x1c: /* TCO */
+        if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        }
+        if (crm & 1) {
+            set_pstate_bits(PSTATE_TCO);
+        } else {
+            clear_pstate_bits(PSTATE_TCO);
+        }
+        break;
+
     default:
     do_unallocated:
         unallocated_encoding(s);
-- 
2.17.2
