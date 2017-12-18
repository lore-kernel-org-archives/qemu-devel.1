Received: from eggs.gnu.org ([2001:4830:134:3::10]:44458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFQ-0002hk-Ho
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFO-0004lR-HM
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:40 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:40289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzFO-0004l6-8e
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:38 -0500
Received: by mail-pl0-x243.google.com with SMTP id 62so3775023pld.7
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:30:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:30:21 -0800
Message-Id: <20171218173022.18418-9-richard.henderson@linaro.org>
In-Reply-To: <20171218173022.18418-1-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 8/9] target/arm: Add ZCR.LEN to tb->flags
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

This has a stub(-ish) implementation of ZCR, in that it does not
implement _EL[123], or wire up the system register properly.
However, it is enough for CONFIG_USER_ONLY.

We will need VQ in tb->flags in order to pass the true vector
size to the generic vector expanders.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 48 ++++++++++++++++++++++++++++++----------------
 target/arm/translate.h     |  1 +
 target/arm/cpu.c           |  2 ++
 target/arm/translate-a64.c |  5 ++---
 4 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 150b0d9d84..37b8cef2e2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -553,6 +553,12 @@ typedef struct CPUARMState {
         float_status fp_status;
         float_status fp_status_f16;
         float_status standard_fp_status;
+
+        /* TODO: For system mode, represent all of zcr_el{1,2,3}.
+         * In the meantime, the composite value exposed to el0.
+         * Only the low 4 bits are defined, and set via syscall.
+         */
+        uint32_t zcr_el;
     } vfp;
     uint64_t exclusive_addr;
     uint64_t exclusive_val;
@@ -2649,6 +2655,8 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 #define ARM_TBFLAG_TBI0_MASK (0x1ull << ARM_TBFLAG_TBI0_SHIFT)
 #define ARM_TBFLAG_TBI1_SHIFT 1        /* TBI1 for EL0/1  */
 #define ARM_TBFLAG_TBI1_MASK (0x1ull << ARM_TBFLAG_TBI1_SHIFT)
+#define ARM_TBFLAG_ZCR_LEN_SHIFT 2     /* Composite ZCR_EL1/2/3.LEN */
+#define ARM_TBFLAG_ZCR_LEN_MASK  (0xfull << ARM_TBFLAG_ZCR_LEN_SHIFT)
 
 /* some convenience accessor macros */
 #define ARM_TBFLAG_AARCH64_STATE(F) \
@@ -2685,6 +2693,8 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
     (((F) & ARM_TBFLAG_TBI0_MASK) >> ARM_TBFLAG_TBI0_SHIFT)
 #define ARM_TBFLAG_TBI1(F) \
     (((F) & ARM_TBFLAG_TBI1_MASK) >> ARM_TBFLAG_TBI1_SHIFT)
+#define ARM_TBFLAG_ZCR_LEN(F) \
+    (((F) & ARM_TBFLAG_ZCR_LEN_MASK) >> ARM_TBFLAG_ZCR_LEN_SHIFT)
 
 static inline bool bswap_code(bool sctlr_b)
 {
@@ -2818,34 +2828,39 @@ static inline uint32_t arm_regime_tbi1(CPUARMState *env, ARMMMUIdx mmu_idx)
 #endif
 
 static inline void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
-                                        target_ulong *cs_base, uint32_t *flags)
+                                        target_ulong *cs_base, uint32_t *pflags)
 {
     ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
+    uint32_t flags;
+
     if (is_a64(env)) {
         *pc = env->pc;
-        *flags = ARM_TBFLAG_AARCH64_STATE_MASK;
+        flags = ARM_TBFLAG_AARCH64_STATE_MASK;
         /* Get control bits for tagged addresses */
-        *flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
-        *flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
+        flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
+        flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
+        /* Get SVE vector length */
+        flags |= ((env->vfp.zcr_el << ARM_TBFLAG_ZCR_LEN_SHIFT)
+                  & ARM_TBFLAG_ZCR_LEN_MASK);
     } else {
         *pc = env->regs[15];
-        *flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
+        flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
             | (env->vfp.vec_len << ARM_TBFLAG_VECLEN_SHIFT)
             | (env->vfp.vec_stride << ARM_TBFLAG_VECSTRIDE_SHIFT)
             | (env->condexec_bits << ARM_TBFLAG_CONDEXEC_SHIFT)
             | (arm_sctlr_b(env) << ARM_TBFLAG_SCTLR_B_SHIFT);
         if (!(access_secure_reg(env))) {
-            *flags |= ARM_TBFLAG_NS_MASK;
+            flags |= ARM_TBFLAG_NS_MASK;
         }
         if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
             || arm_el_is_aa64(env, 1)) {
-            *flags |= ARM_TBFLAG_VFPEN_MASK;
+            flags |= ARM_TBFLAG_VFPEN_MASK;
         }
-        *flags |= (extract32(env->cp15.c15_cpar, 0, 2)
-                   << ARM_TBFLAG_XSCALE_CPAR_SHIFT);
+        flags |= (extract32(env->cp15.c15_cpar, 0, 2)
+                  << ARM_TBFLAG_XSCALE_CPAR_SHIFT);
     }
 
-    *flags |= (arm_to_core_mmu_idx(mmu_idx) << ARM_TBFLAG_MMUIDX_SHIFT);
+    flags |= (arm_to_core_mmu_idx(mmu_idx) << ARM_TBFLAG_MMUIDX_SHIFT);
 
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
      * states defined in the ARM ARM for software singlestep:
@@ -2855,26 +2870,27 @@ static inline void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
      *     1            1       Active-not-pending
      */
     if (arm_singlestep_active(env)) {
-        *flags |= ARM_TBFLAG_SS_ACTIVE_MASK;
+        flags |= ARM_TBFLAG_SS_ACTIVE_MASK;
         if (is_a64(env)) {
             if (env->pstate & PSTATE_SS) {
-                *flags |= ARM_TBFLAG_PSTATE_SS_MASK;
+                flags |= ARM_TBFLAG_PSTATE_SS_MASK;
             }
         } else {
             if (env->uncached_cpsr & PSTATE_SS) {
-                *flags |= ARM_TBFLAG_PSTATE_SS_MASK;
+                flags |= ARM_TBFLAG_PSTATE_SS_MASK;
             }
         }
     }
     if (arm_cpu_data_is_big_endian(env)) {
-        *flags |= ARM_TBFLAG_BE_DATA_MASK;
+        flags |= ARM_TBFLAG_BE_DATA_MASK;
     }
-    *flags |= fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
+    flags |= fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
 
     if (arm_v7m_is_handler_mode(env)) {
-        *flags |= ARM_TBFLAG_HANDLER_MASK;
+        flags |= ARM_TBFLAG_HANDLER_MASK;
     }
 
+    *pflags = flags;
     *cs_base = 0;
 }
 
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 3f4df91e5e..2b0a2d7aa6 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -34,6 +34,7 @@ typedef struct DisasContext {
     bool vfp_enabled; /* FP enabled via FPSCR.EN */
     int vec_len;
     int vec_stride;
+    int sve_len;      /* SVE vector length in bytes */
     bool v7m_handler_mode;
     bool v8m_secure; /* true if v8M and we're in Secure mode */
     /* Immediate value in AArch32 SVC insn; must be set if is_jmp == DISAS_SWI
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6cd8ae1459..10b68ea16f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -149,6 +149,8 @@ static void arm_cpu_reset(CPUState *s)
         env->cp15.sctlr_el[1] |= SCTLR_UCT | SCTLR_UCI | SCTLR_DZE;
         /* and to the FP/Neon instructions */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 20, 2, 3);
+        /* Set the SVE vector length to maximum.  */
+        env->vfp.zcr_el = ARM_MAX_VQ - 1;
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 487408a7a7..ecb72e4d9c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -549,9 +549,7 @@ static inline int vec_full_reg_offset(DisasContext *s, int regno)
 /* Return the byte size of the "whole" vector register, VL / 8.  */
 static inline int vec_full_reg_size(DisasContext *s)
 {
-    /* FIXME SVE: We should put the composite ZCR_EL* value into tb->flags.
-       In the meantime this is just the AdvSIMD length of 128.  */
-    return 128 / 8;
+    return s->sve_len;
 }
 
 /* Return a newly allocated pointer to the vector register.  */
@@ -12771,6 +12769,7 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
     dc->vec_len = 0;
     dc->vec_stride = 0;
+    dc->sve_len = (ARM_TBFLAG_ZCR_LEN(dc->base.tb->flags) + 1) * 16;
     dc->cp_regs = arm_cpu->cp_regs;
     dc->features = env->features;
 
-- 
2.14.3
