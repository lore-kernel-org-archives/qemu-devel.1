Received: from eggs.gnu.org ([209.51.188.92]:35023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu8If-0003DV-IE
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu8Ib-0005ae-GA
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:07:01 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:37995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gu8Ib-0005YY-2L
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:06:57 -0500
Received: by mail-pl1-x62f.google.com with SMTP id e5so2408584plb.5
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 20:06:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 13 Feb 2019 20:06:49 -0800
Message-Id: <20190214040652.4811-2-richard.henderson@linaro.org>
In-Reply-To: <20190214040652.4811-1-richard.henderson@linaro.org>
References: <20190214040652.4811-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/4] target/arm: Split out recompute_hflags et
 al
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org

We will use these to minimize the computation for every call to
cpu_get_tb_cpu_state.  For now, the env->hflags variable is not used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       |  22 +++-
 target/arm/helper.h    |   3 +
 target/arm/internals.h |   3 +
 target/arm/helper.c    | 268 ++++++++++++++++++++++++-----------------
 4 files changed, 180 insertions(+), 116 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 47238e4245..8b0dea947b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -240,6 +240,9 @@ typedef struct CPUARMState {
     uint32_t pstate;
     uint32_t aarch64; /* 1 if CPU is in aarch64 state; inverse of PSTATE.nRW */
 
+    /* Cached TBFLAGS state.  See below for which bits are included.  */
+    uint32_t hflags;
+
     /* Frequently accessed CPSR bits are stored separately for efficiency.
        This contains all the other bits.  Use cpsr_{read,write} to access
        the whole CPSR.  */
@@ -3019,25 +3022,28 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 
 #include "exec/cpu-all.h"
 
-/* Bit usage in the TB flags field: bit 31 indicates whether we are
+/*
+ * Bit usage in the TB flags field: bit 31 indicates whether we are
  * in 32 or 64 bit mode. The meaning of the other bits depends on that.
  * We put flags which are shared between 32 and 64 bit mode at the top
  * of the word, and flags which apply to only one mode at the bottom.
+ *
+ * Unless otherwise noted, these bits are cached in env->hflags.
  */
 FIELD(TBFLAG_ANY, AARCH64_STATE, 31, 1)
 FIELD(TBFLAG_ANY, MMUIDX, 28, 3)
 FIELD(TBFLAG_ANY, SS_ACTIVE, 27, 1)
-FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)
+FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)     /* Not cached. */
 /* Target EL if we take a floating-point-disabled exception */
 FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
 FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
 
 /* Bit usage when in AArch32 state: */
-FIELD(TBFLAG_A32, THUMB, 0, 1)
+FIELD(TBFLAG_A32, THUMB, 0, 1)          /* Not cached. */
 FIELD(TBFLAG_A32, VECLEN, 1, 3)
 FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)
-FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
+FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
 /* We store the bottom two bits of the CPAR as TB flags and handle
  * checks on the other bits at runtime
@@ -3059,7 +3065,7 @@ FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
 FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
 FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
 FIELD(TBFLAG_A64, BT, 9, 1)
-FIELD(TBFLAG_A64, BTYPE, 10, 2)
+FIELD(TBFLAG_A64, BTYPE, 10, 2)         /* Not cached. */
 FIELD(TBFLAG_A64, TBID, 12, 2)
 
 static inline bool bswap_code(bool sctlr_b)
@@ -3144,6 +3150,12 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook, void
         *opaque);
 
+/**
+ * arm_rebuild_hflags:
+ * Rebuild the cached TBFLAGS for arbitrary changed processor state.
+ */
+void arm_rebuild_hflags(CPUARMState *env);
+
 /**
  * aa32_vfp_dreg:
  * Return a pointer to the Dn register within env in 32-bit mode.
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 53a38188c6..e3c98913e6 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -653,6 +653,9 @@ DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, i32)
+DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a4bd1becb7..8c1b813364 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -968,4 +968,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data);
 
+uint32_t rebuild_hflags_a32(CPUARMState *env, int el);
+uint32_t rebuild_hflags_a64(CPUARMState *env, int el);
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 520ceea7a4..7a77f53ba8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13745,122 +13745,15 @@ ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
 }
 #endif
 
-void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
-                          target_ulong *cs_base, uint32_t *pflags)
+static uint32_t common_hflags(CPUARMState *env, int el, ARMMMUIdx mmu_idx,
+                              int fp_el, uint32_t flags)
 {
-    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    int current_el = arm_current_el(env);
-    int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags = 0;
-
-    if (is_a64(env)) {
-        ARMCPU *cpu = arm_env_get_cpu(env);
-        uint64_t sctlr;
-
-        *pc = env->pc;
-        flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
-
-        /* Get control bits for tagged addresses.  */
-        {
-            ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
-            ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
-            int tbii, tbid;
-
-            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-            if (regime_el(env, stage1) < 2) {
-                ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
-                tbid = (p1.tbi << 1) | p0.tbi;
-                tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
-            } else {
-                tbid = p0.tbi;
-                tbii = tbid & !p0.tbid;
-            }
-
-            flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
-            flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
-        }
-
-        if (cpu_isar_feature(aa64_sve, cpu)) {
-            int sve_el = sve_exception_el(env, current_el);
-            uint32_t zcr_len;
-
-            /* If SVE is disabled, but FP is enabled,
-             * then the effective len is 0.
-             */
-            if (sve_el != 0 && fp_el == 0) {
-                zcr_len = 0;
-            } else {
-                zcr_len = sve_zcr_len_for_el(env, current_el);
-            }
-            flags = FIELD_DP32(flags, TBFLAG_A64, SVEEXC_EL, sve_el);
-            flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
-        }
-
-        if (current_el == 0) {
-            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-            sctlr = env->cp15.sctlr_el[1];
-        } else {
-            sctlr = env->cp15.sctlr_el[current_el];
-        }
-        if (cpu_isar_feature(aa64_pauth, cpu)) {
-            /*
-             * In order to save space in flags, we record only whether
-             * pauth is "inactive", meaning all insns are implemented as
-             * a nop, or "active" when some action must be performed.
-             * The decision of which action to take is left to a helper.
-             */
-            if (sctlr & (SCTLR_EnIA | SCTLR_EnIB | SCTLR_EnDA | SCTLR_EnDB)) {
-                flags = FIELD_DP32(flags, TBFLAG_A64, PAUTH_ACTIVE, 1);
-            }
-        }
-
-        if (cpu_isar_feature(aa64_bti, cpu)) {
-            /* Note that SCTLR_EL[23].BT == SCTLR_BT1.  */
-            if (sctlr & (current_el == 0 ? SCTLR_BT0 : SCTLR_BT1)) {
-                flags = FIELD_DP32(flags, TBFLAG_A64, BT, 1);
-            }
-            flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
-        }
-    } else {
-        *pc = env->regs[15];
-        flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
-        flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
-        flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
-        flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
-        flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
-        flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
-        if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
-            || arm_el_is_aa64(env, 1)) {
-            flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
-        }
-        flags = FIELD_DP32(flags, TBFLAG_A32, XSCALE_CPAR, env->cp15.c15_cpar);
-    }
-
     flags = FIELD_DP32(flags, TBFLAG_ANY, MMUIDX, arm_to_core_mmu_idx(mmu_idx));
+    flags = FIELD_DP32(flags, TBFLAG_ANY, FPEXC_EL, fp_el);
 
-    /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
-     * states defined in the ARM ARM for software singlestep:
-     *  SS_ACTIVE   PSTATE.SS   State
-     *     0            x       Inactive (the TB flag for SS is always 0)
-     *     1            0       Active-pending
-     *     1            1       Active-not-pending
-     */
-    if (arm_singlestep_active(env)) {
-        flags = FIELD_DP32(flags, TBFLAG_ANY, SS_ACTIVE, 1);
-        if (is_a64(env)) {
-            if (env->pstate & PSTATE_SS) {
-                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
-            }
-        } else {
-            if (env->uncached_cpsr & PSTATE_SS) {
-                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
-            }
-        }
-    }
     if (arm_cpu_data_is_big_endian(env)) {
         flags = FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
     }
-    flags = FIELD_DP32(flags, TBFLAG_ANY, FPEXC_EL, fp_el);
 
     if (arm_v7m_is_handler_mode(env)) {
         flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
@@ -13876,8 +13769,161 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
     }
 
-    *pflags = flags;
+    if (arm_singlestep_active(env)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, SS_ACTIVE, 1);
+    }
+
+    return flags;
+}
+
+uint32_t rebuild_hflags_a32(CPUARMState *env, int el)
+{
+    uint32_t flags = 0;
+    ARMMMUIdx mmu_idx;
+    int fp_el;
+
+    flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
+    flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
+    flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
+    flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
+    if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
+        || arm_el_is_aa64(env, 1)) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+    }
+    flags = FIELD_DP32(flags, TBFLAG_A32, XSCALE_CPAR, env->cp15.c15_cpar);
+
+    mmu_idx = arm_mmu_idx(env);
+    fp_el = fp_exception_el(env, el);
+    return common_hflags(env, el, mmu_idx, fp_el, flags);
+}
+
+uint32_t rebuild_hflags_a64(CPUARMState *env, int el)
+{
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
+    ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
+    int fp_el = fp_exception_el(env, el);
+    uint32_t flags = 0;
+    uint64_t sctlr;
+    int tbii, tbid;
+
+    flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
+
+    /* Get control bits for tagged addresses.  */
+    /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+    if (regime_el(env, stage1) < 2) {
+        ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
+        tbid = (p1.tbi << 1) | p0.tbi;
+        tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
+    } else {
+        tbid = p0.tbi;
+        tbii = tbid & !p0.tbid;
+    }
+
+    flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
+    flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
+
+    if (cpu_isar_feature(aa64_sve, cpu)) {
+        int sve_el = sve_exception_el(env, el);
+        uint32_t zcr_len;
+
+        /* If SVE is disabled, but FP is enabled,
+         * then the effective len is 0.
+         */
+        if (sve_el != 0 && fp_el == 0) {
+            zcr_len = 0;
+        } else {
+            zcr_len = sve_zcr_len_for_el(env, el);
+        }
+        flags = FIELD_DP32(flags, TBFLAG_A64, SVEEXC_EL, sve_el);
+        flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
+    }
+
+    if (el == 0) {
+        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+        sctlr = env->cp15.sctlr_el[1];
+    } else {
+        sctlr = env->cp15.sctlr_el[el];
+    }
+    if (cpu_isar_feature(aa64_pauth, cpu)) {
+        /*
+         * In order to save space in flags, we record only whether
+         * pauth is "inactive", meaning all insns are implemented as
+         * a nop, or "active" when some action must be performed.
+         * The decision of which action to take is left to a helper.
+         */
+        if (sctlr & (SCTLR_EnIA | SCTLR_EnIB | SCTLR_EnDA | SCTLR_EnDB)) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, PAUTH_ACTIVE, 1);
+        }
+    }
+
+    if (cpu_isar_feature(aa64_bti, cpu)) {
+        /* Note that SCTLR_EL[23].BT == SCTLR_BT1.  */
+        if (sctlr & (el == 0 ? SCTLR_BT0 : SCTLR_BT1)) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, BT, 1);
+        }
+        flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
+    }
+
+    return common_hflags(env, el, mmu_idx, fp_el, flags);
+}
+
+void arm_rebuild_hflags(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+    env->hflags = (is_a64(env)
+                   ? rebuild_hflags_a64(env, el)
+                   : rebuild_hflags_a32(env, el));
+}
+
+void HELPER(rebuild_hflags_a32)(CPUARMState *env, uint32_t el)
+{
+    tcg_debug_assert(!is_a64(env));
+    env->hflags = rebuild_hflags_a32(env, el);
+}
+
+void HELPER(rebuild_hflags_a64)(CPUARMState *env, uint32_t el)
+{
+    tcg_debug_assert(is_a64(env));
+    env->hflags = rebuild_hflags_a64(env, el);
+}
+
+void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
+                          target_ulong *cs_base, uint32_t *pflags)
+{
+    int current_el = arm_current_el(env);
+    uint32_t flags;
+    uint32_t pstate_for_ss;
+
     *cs_base = 0;
+    if (is_a64(env)) {
+        *pc = env->pc;
+        flags = rebuild_hflags_a64(env, current_el);
+        flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
+        pstate_for_ss = env->pstate;
+    } else {
+        *pc = env->regs[15];
+        flags = rebuild_hflags_a32(env, current_el);
+        flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
+        flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
+        pstate_for_ss = env->uncached_cpsr;
+    }
+
+    /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
+     * states defined in the ARM ARM for software singlestep:
+     *  SS_ACTIVE   PSTATE.SS   State
+     *     0            x       Inactive (the TB flag for SS is always 0)
+     *     1            0       Active-pending
+     *     1            1       Active-not-pending
+     * SS_ACTIVE is set in hflags; PSTATE_SS is computed every TB.
+     */
+    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE)
+        && (pstate_for_ss & PSTATE_SS)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
+    }
+
+    *pflags = flags;
 }
 
 #ifdef TARGET_AARCH64
-- 
2.17.1
