Received: from eggs.gnu.org ([209.51.188.92]:58765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wRx-0006E8-0r
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wRp-0004L1-Rc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:04:51 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1wRp-0004K1-Ga
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:04:45 -0500
Received: by mail-pf1-x444.google.com with SMTP id j5so11902586pfa.2
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:04:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 09:04:19 -0800
Message-Id: <20190307170440.3113-2-richard.henderson@linaro.org>
In-Reply-To: <20190307170440.3113-1-richard.henderson@linaro.org>
References: <20190307170440.3113-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 01/22] target/arm: Add MTE_ACTIVE to tb_flags
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

When MTE is fully enabled, i.e. access to tags are enabled and
tag checks affect the PE, then arrange to perform the check
while stripping the TBI.

The check is not yet implemented, just the plumbing to that point.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Clean TBI bits exactly.
    Fix license to lgpl 2.1.
v3: Remove stub helper_mte_check; moved to a later patch.
---
 target/arm/cpu.h           | 12 +++++++++
 target/arm/internals.h     | 18 ++++++++++++++
 target/arm/translate.h     |  2 ++
 target/arm/helper.c        | 51 ++++++++++++++++++++++++++++++--------
 target/arm/translate-a64.c |  1 +
 5 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5f23c62132..0cf9eacebe 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1214,6 +1214,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_BTYPE (3U << 10)
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
+#define PSTATE_TCO (1U << 25)
 #define PSTATE_V (1U << 28)
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
@@ -3127,6 +3128,7 @@ FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
 FIELD(TBFLAG_A64, BT, 9, 1)
 FIELD(TBFLAG_A64, BTYPE, 10, 2)
 FIELD(TBFLAG_A64, TBID, 12, 2)
+FIELD(TBFLAG_A64, MTE_ACTIVE, 14, 1)
 
 static inline bool bswap_code(bool sctlr_b)
 {
@@ -3507,6 +3509,16 @@ static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
 }
 
+static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
+}
+
+static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 587a1ddf58..6c018e773c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -983,4 +983,22 @@ static inline int exception_target_el(CPUARMState *env)
     return target_el;
 }
 
+/* Determine if allocation tags are available.  */
+static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
+                                                 uint64_t sctlr)
+{
+    if (el < 3
+        && arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_ATA)) {
+        return false;
+    }
+    if (el < 2
+        && arm_feature(env, ARM_FEATURE_EL2)
+        && !(arm_hcr_el2_eff(env) & HCR_ATA)) {
+        return false;
+    }
+    sctlr &= (el == 0 ? SCTLR_ATA0 : SCTLR_ATA);
+    return sctlr != 0;
+}
+
 #endif
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 912cc2a4a5..e07c2c3330 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -70,6 +70,8 @@ typedef struct DisasContext {
     bool ss_same_el;
     /* True if v8.3-PAuth is active.  */
     bool pauth_active;
+    /* True if v8.5-MTE tag checks affect the PE.  */
+    bool mte_active;
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
     bool bt;
     /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2607d39ad1..90d15578ca 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1863,6 +1863,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         valid_mask |= SCR_API | SCR_APK;
     }
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        valid_mask |= SCR_ATA;
+    }
 
     /* Clear all-context RES0 bits.  */
     value &= valid_mask;
@@ -4050,22 +4053,31 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
 
-    if (raw_read(env, ri) == value) {
-        /* Skip the TLB flush if nothing actually changed; Linux likes
-         * to do a lot of pointless SCTLR writes.
-         */
-        return;
-    }
-
     if (arm_feature(env, ARM_FEATURE_PMSA) && !cpu->has_mpu) {
         /* M bit is RAZ/WI for PMSA with no MPU implemented */
         value &= ~SCTLR_M;
     }
 
-    raw_write(env, ri, value);
+    if (!cpu_isar_feature(aa64_mte, cpu)) {
+        if (ri->opc1 == 6) { /* SCTLR_EL3 */
+            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
+        } else {
+            value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
+                       SCTLR_ATA0 | SCTLR_ATA);
+        }
+    }
+
     /* ??? Lots of these bits are not implemented.  */
-    /* This may enable/disable the MMU, so do a TLB flush.  */
-    tlb_flush(CPU(cpu));
+
+    if (raw_read(env, ri) != value) {
+        /*
+         * This may enable/disable the MMU, so do a TLB flush.
+         * Skip the TLB flush if nothing actually changed;
+         * Linux likes to do a lot of pointless SCTLR writes.
+         */
+        raw_write(env, ri, value);
+        tlb_flush(CPU(cpu));
+    }
 }
 
 static CPAccessResult fpexc32_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4561,6 +4573,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         valid_mask |= HCR_API | HCR_APK;
     }
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        valid_mask |= HCR_ATA;
+    }
 
     /* Clear RES0 bits.  */
     value &= valid_mask;
@@ -12869,6 +12884,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     if (is_a64(env)) {
         ARMCPU *cpu = arm_env_get_cpu(env);
         uint64_t sctlr;
+        int tbid;
 
         *pc = env->pc;
         flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
@@ -12877,7 +12893,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         {
             ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
             ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
-            int tbii, tbid;
+            int tbii;
 
             /* FIXME: ARMv8.1-VHE S2 translation regime.  */
             if (regime_el(env, stage1) < 2) {
@@ -12930,6 +12946,19 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             }
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         }
+
+        /*
+         * If MTE is enabled, and tag checks affect the PE,
+         * then we check the tag as we strip the TBI field.
+         * Note that if TBI is disabled, all accesses are unchecked.
+         */
+        if (tbid
+            && cpu_isar_feature(aa64_mte, cpu)
+            && allocation_tag_access_enabled(env, current_el, sctlr)
+            && !(env->pstate & PSTATE_TCO)
+            && (sctlr & (current_el == 0 ? SCTLR_TCF0 : SCTLR_TCF))) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, MTE_ACTIVE, 1);
+        }
     } else {
         *pc = env->regs[15];
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1959046343..d971b57037 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14351,6 +14351,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pauth_active = FIELD_EX32(tb_flags, TBFLAG_A64, PAUTH_ACTIVE);
     dc->bt = FIELD_EX32(tb_flags, TBFLAG_A64, BT);
     dc->btype = FIELD_EX32(tb_flags, TBFLAG_A64, BTYPE);
+    dc->mte_active = FIELD_EX32(tb_flags, TBFLAG_A64, MTE_ACTIVE);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.17.2
