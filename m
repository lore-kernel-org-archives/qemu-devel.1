Received: from eggs.gnu.org ([2001:4830:134:3::10]:54422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXtvM-0005PO-GI
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 15:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXtvI-0001XI-E5
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 15:19:04 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXtvI-0001Wg-5a
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 15:19:00 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so6568351ota.12
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 12:19:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 14 Dec 2018 14:18:55 -0600
Message-Id: <20181214201855.14476-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Convert ARM_TBFLAG_* to FIELDs
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

Use "register" TBFLAG_ANY to indicate shared state between
A32 and A64, and "registers" TBFLAG_A32 & TBFLAG_A64 for
fields that are specific to the given cpu state.

Move ARM_TBFLAG_BE to shared state, instead of its current
placement within "Bit usage when in AArch32 state".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 107 ++++++++-----------------------------
 target/arm/helper.c        |  49 ++++++++---------
 target/arm/translate-a64.c |  24 +++++----
 target/arm/translate.c     |  40 +++++++-------
 4 files changed, 79 insertions(+), 141 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1e22a9a8bd..6211e21046 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2954,106 +2954,41 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
  * We put flags which are shared between 32 and 64 bit mode at the top
  * of the word, and flags which apply to only one mode at the bottom.
  */
-#define ARM_TBFLAG_AARCH64_STATE_SHIFT 31
-#define ARM_TBFLAG_AARCH64_STATE_MASK  (1U << ARM_TBFLAG_AARCH64_STATE_SHIFT)
-#define ARM_TBFLAG_MMUIDX_SHIFT 28
-#define ARM_TBFLAG_MMUIDX_MASK (0x7 << ARM_TBFLAG_MMUIDX_SHIFT)
-#define ARM_TBFLAG_SS_ACTIVE_SHIFT 27
-#define ARM_TBFLAG_SS_ACTIVE_MASK (1 << ARM_TBFLAG_SS_ACTIVE_SHIFT)
-#define ARM_TBFLAG_PSTATE_SS_SHIFT 26
-#define ARM_TBFLAG_PSTATE_SS_MASK (1 << ARM_TBFLAG_PSTATE_SS_SHIFT)
+FIELD(TBFLAG_ANY, AARCH64_STATE, 31, 1)
+FIELD(TBFLAG_ANY, MMUIDX, 28, 3)
+FIELD(TBFLAG_ANY, SS_ACTIVE, 27, 1)
+FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)
 /* Target EL if we take a floating-point-disabled exception */
-#define ARM_TBFLAG_FPEXC_EL_SHIFT 24
-#define ARM_TBFLAG_FPEXC_EL_MASK (0x3 << ARM_TBFLAG_FPEXC_EL_SHIFT)
+FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
+FIELD(TBFLAG_ANY, BE, 23, 1)
 
 /* Bit usage when in AArch32 state: */
-#define ARM_TBFLAG_THUMB_SHIFT      0
-#define ARM_TBFLAG_THUMB_MASK       (1 << ARM_TBFLAG_THUMB_SHIFT)
-#define ARM_TBFLAG_VECLEN_SHIFT     1
-#define ARM_TBFLAG_VECLEN_MASK      (0x7 << ARM_TBFLAG_VECLEN_SHIFT)
-#define ARM_TBFLAG_VECSTRIDE_SHIFT  4
-#define ARM_TBFLAG_VECSTRIDE_MASK   (0x3 << ARM_TBFLAG_VECSTRIDE_SHIFT)
-#define ARM_TBFLAG_VFPEN_SHIFT      7
-#define ARM_TBFLAG_VFPEN_MASK       (1 << ARM_TBFLAG_VFPEN_SHIFT)
-#define ARM_TBFLAG_CONDEXEC_SHIFT   8
-#define ARM_TBFLAG_CONDEXEC_MASK    (0xff << ARM_TBFLAG_CONDEXEC_SHIFT)
-#define ARM_TBFLAG_SCTLR_B_SHIFT    16
-#define ARM_TBFLAG_SCTLR_B_MASK     (1 << ARM_TBFLAG_SCTLR_B_SHIFT)
+FIELD(TBFLAG_A32, THUMB, 0, 1)
+FIELD(TBFLAG_A32, VECLEN, 1, 3)
+FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)
+FIELD(TBFLAG_A32, VFPEN, 7, 1)
+FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
+FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
 /* We store the bottom two bits of the CPAR as TB flags and handle
  * checks on the other bits at runtime
  */
-#define ARM_TBFLAG_XSCALE_CPAR_SHIFT 17
-#define ARM_TBFLAG_XSCALE_CPAR_MASK (3 << ARM_TBFLAG_XSCALE_CPAR_SHIFT)
+FIELD(TBFLAG_A32, XSCALE_CPAR, 17, 2)
 /* Indicates whether cp register reads and writes by guest code should access
  * the secure or nonsecure bank of banked registers; note that this is not
  * the same thing as the current security state of the processor!
  */
-#define ARM_TBFLAG_NS_SHIFT         19
-#define ARM_TBFLAG_NS_MASK          (1 << ARM_TBFLAG_NS_SHIFT)
-#define ARM_TBFLAG_BE_DATA_SHIFT    20
-#define ARM_TBFLAG_BE_DATA_MASK     (1 << ARM_TBFLAG_BE_DATA_SHIFT)
+FIELD(TBFLAG_A32, NS, 19, 1)
 /* For M profile only, Handler (ie not Thread) mode */
-#define ARM_TBFLAG_HANDLER_SHIFT    21
-#define ARM_TBFLAG_HANDLER_MASK     (1 << ARM_TBFLAG_HANDLER_SHIFT)
+FIELD(TBFLAG_A32, HANDLER, 21, 1)
 /* For M profile only, whether we should generate stack-limit checks */
-#define ARM_TBFLAG_STACKCHECK_SHIFT 22
-#define ARM_TBFLAG_STACKCHECK_MASK  (1 << ARM_TBFLAG_STACKCHECK_SHIFT)
+FIELD(TBFLAG_A32, STACKCHECK, 22, 1)
 
 /* Bit usage when in AArch64 state */
-#define ARM_TBFLAG_TBI0_SHIFT 0        /* TBI0 for EL0/1 or TBI for EL2/3 */
-#define ARM_TBFLAG_TBI0_MASK (0x1ull << ARM_TBFLAG_TBI0_SHIFT)
-#define ARM_TBFLAG_TBI1_SHIFT 1        /* TBI1 for EL0/1  */
-#define ARM_TBFLAG_TBI1_MASK (0x1ull << ARM_TBFLAG_TBI1_SHIFT)
-#define ARM_TBFLAG_SVEEXC_EL_SHIFT  2
-#define ARM_TBFLAG_SVEEXC_EL_MASK   (0x3 << ARM_TBFLAG_SVEEXC_EL_SHIFT)
-#define ARM_TBFLAG_ZCR_LEN_SHIFT    4
-#define ARM_TBFLAG_ZCR_LEN_MASK     (0xf << ARM_TBFLAG_ZCR_LEN_SHIFT)
-#define ARM_TBFLAG_PAUTH_ACTIVE_SHIFT  8
-#define ARM_TBFLAG_PAUTH_ACTIVE_MASK   (1ull << ARM_TBFLAG_PAUTH_ACTIVE_SHIFT)
-
-/* some convenience accessor macros */
-#define ARM_TBFLAG_AARCH64_STATE(F) \
-    (((F) & ARM_TBFLAG_AARCH64_STATE_MASK) >> ARM_TBFLAG_AARCH64_STATE_SHIFT)
-#define ARM_TBFLAG_MMUIDX(F) \
-    (((F) & ARM_TBFLAG_MMUIDX_MASK) >> ARM_TBFLAG_MMUIDX_SHIFT)
-#define ARM_TBFLAG_SS_ACTIVE(F) \
-    (((F) & ARM_TBFLAG_SS_ACTIVE_MASK) >> ARM_TBFLAG_SS_ACTIVE_SHIFT)
-#define ARM_TBFLAG_PSTATE_SS(F) \
-    (((F) & ARM_TBFLAG_PSTATE_SS_MASK) >> ARM_TBFLAG_PSTATE_SS_SHIFT)
-#define ARM_TBFLAG_FPEXC_EL(F) \
-    (((F) & ARM_TBFLAG_FPEXC_EL_MASK) >> ARM_TBFLAG_FPEXC_EL_SHIFT)
-#define ARM_TBFLAG_THUMB(F) \
-    (((F) & ARM_TBFLAG_THUMB_MASK) >> ARM_TBFLAG_THUMB_SHIFT)
-#define ARM_TBFLAG_VECLEN(F) \
-    (((F) & ARM_TBFLAG_VECLEN_MASK) >> ARM_TBFLAG_VECLEN_SHIFT)
-#define ARM_TBFLAG_VECSTRIDE(F) \
-    (((F) & ARM_TBFLAG_VECSTRIDE_MASK) >> ARM_TBFLAG_VECSTRIDE_SHIFT)
-#define ARM_TBFLAG_VFPEN(F) \
-    (((F) & ARM_TBFLAG_VFPEN_MASK) >> ARM_TBFLAG_VFPEN_SHIFT)
-#define ARM_TBFLAG_CONDEXEC(F) \
-    (((F) & ARM_TBFLAG_CONDEXEC_MASK) >> ARM_TBFLAG_CONDEXEC_SHIFT)
-#define ARM_TBFLAG_SCTLR_B(F) \
-    (((F) & ARM_TBFLAG_SCTLR_B_MASK) >> ARM_TBFLAG_SCTLR_B_SHIFT)
-#define ARM_TBFLAG_XSCALE_CPAR(F) \
-    (((F) & ARM_TBFLAG_XSCALE_CPAR_MASK) >> ARM_TBFLAG_XSCALE_CPAR_SHIFT)
-#define ARM_TBFLAG_NS(F) \
-    (((F) & ARM_TBFLAG_NS_MASK) >> ARM_TBFLAG_NS_SHIFT)
-#define ARM_TBFLAG_BE_DATA(F) \
-    (((F) & ARM_TBFLAG_BE_DATA_MASK) >> ARM_TBFLAG_BE_DATA_SHIFT)
-#define ARM_TBFLAG_HANDLER(F) \
-    (((F) & ARM_TBFLAG_HANDLER_MASK) >> ARM_TBFLAG_HANDLER_SHIFT)
-#define ARM_TBFLAG_STACKCHECK(F) \
-    (((F) & ARM_TBFLAG_STACKCHECK_MASK) >> ARM_TBFLAG_STACKCHECK_SHIFT)
-#define ARM_TBFLAG_TBI0(F) \
-    (((F) & ARM_TBFLAG_TBI0_MASK) >> ARM_TBFLAG_TBI0_SHIFT)
-#define ARM_TBFLAG_TBI1(F) \
-    (((F) & ARM_TBFLAG_TBI1_MASK) >> ARM_TBFLAG_TBI1_SHIFT)
-#define ARM_TBFLAG_SVEEXC_EL(F) \
-    (((F) & ARM_TBFLAG_SVEEXC_EL_MASK) >> ARM_TBFLAG_SVEEXC_EL_SHIFT)
-#define ARM_TBFLAG_ZCR_LEN(F) \
-    (((F) & ARM_TBFLAG_ZCR_LEN_MASK) >> ARM_TBFLAG_ZCR_LEN_SHIFT)
-#define ARM_TBFLAG_PAUTH_ACTIVE(F) \
-    (((F) & ARM_TBFLAG_PAUTH_ACTIVE_MASK) >> ARM_TBFLAG_PAUTH_ACTIVE_SHIFT)
+FIELD(TBFLAG_A64, TBI0, 0, 1)
+FIELD(TBFLAG_A64, TBI1, 1, 1)
+FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
+FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
+FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
 
 static inline bool bswap_code(bool sctlr_b)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index affc539d25..27e7277244 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13070,13 +13070,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     int current_el = arm_current_el(env);
     int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags;
+    uint32_t flags = 0;
 
     if (is_a64(env)) {
         ARMCPU *cpu = arm_env_get_cpu(env);
 
         *pc = env->pc;
-        flags = ARM_TBFLAG_AARCH64_STATE_MASK;
+        flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
 
 #ifndef CONFIG_USER_ONLY
         /* Get control bits for tagged addresses.  Note that the
@@ -13089,8 +13089,8 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             p0 = aa64_va_parameters(env, 0, stage1, false);
             p1 = aa64_va_parameters(env, -1, stage1, false);
 
-            flags |= p0.tbi << ARM_TBFLAG_TBI0_SHIFT;
-            flags |= p1.tbi << ARM_TBFLAG_TBI1_SHIFT;
+            flags = FIELD_DP32(flags, TBFLAG_A64, TBI0, p0.tbi);
+            flags = FIELD_DP32(flags, TBFLAG_A64, TBI1, p1.tbi);
         }
 #endif
 
@@ -13106,8 +13106,8 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             } else {
                 zcr_len = sve_zcr_len_for_el(env, current_el);
             }
-            flags |= sve_el << ARM_TBFLAG_SVEEXC_EL_SHIFT;
-            flags |= zcr_len << ARM_TBFLAG_ZCR_LEN_SHIFT;
+            flags = FIELD_DP32(flags, TBFLAG_A64, SVEEXC_EL, sve_el);
+            flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
         }
 
         if (cpu_isar_feature(aa64_pauth, cpu)) {
@@ -13125,28 +13125,25 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 sctlr = env->cp15.sctlr_el[current_el];
             }
             if (sctlr & (SCTLR_EnIA | SCTLR_EnIB | SCTLR_EnDA | SCTLR_EnDB)) {
-                flags |= ARM_TBFLAG_PAUTH_ACTIVE_MASK;
+                flags = FIELD_DP32(flags, TBFLAG_A64, PAUTH_ACTIVE, 1);
             }
         }
     } else {
         *pc = env->regs[15];
-        flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
-            | (env->vfp.vec_len << ARM_TBFLAG_VECLEN_SHIFT)
-            | (env->vfp.vec_stride << ARM_TBFLAG_VECSTRIDE_SHIFT)
-            | (env->condexec_bits << ARM_TBFLAG_CONDEXEC_SHIFT)
-            | (arm_sctlr_b(env) << ARM_TBFLAG_SCTLR_B_SHIFT);
-        if (!(access_secure_reg(env))) {
-            flags |= ARM_TBFLAG_NS_MASK;
-        }
+        flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
+        flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
+        flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
+        flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
+        flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
+        flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
         if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
             || arm_el_is_aa64(env, 1)) {
-            flags |= ARM_TBFLAG_VFPEN_MASK;
+            flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
         }
-        flags |= (extract32(env->cp15.c15_cpar, 0, 2)
-                  << ARM_TBFLAG_XSCALE_CPAR_SHIFT);
+        flags = FIELD_DP32(flags, TBFLAG_A32, XSCALE_CPAR, env->cp15.c15_cpar);
     }
 
-    flags |= (arm_to_core_mmu_idx(mmu_idx) << ARM_TBFLAG_MMUIDX_SHIFT);
+    flags = FIELD_DP32(flags, TBFLAG_ANY, MMUIDX, arm_to_core_mmu_idx(mmu_idx));
 
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
      * states defined in the ARM ARM for software singlestep:
@@ -13156,24 +13153,24 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
      *     1            1       Active-not-pending
      */
     if (arm_singlestep_active(env)) {
-        flags |= ARM_TBFLAG_SS_ACTIVE_MASK;
+        flags = FIELD_DP32(flags, TBFLAG_ANY, SS_ACTIVE, 1);
         if (is_a64(env)) {
             if (env->pstate & PSTATE_SS) {
-                flags |= ARM_TBFLAG_PSTATE_SS_MASK;
+                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
             }
         } else {
             if (env->uncached_cpsr & PSTATE_SS) {
-                flags |= ARM_TBFLAG_PSTATE_SS_MASK;
+                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
             }
         }
     }
     if (arm_cpu_data_is_big_endian(env)) {
-        flags |= ARM_TBFLAG_BE_DATA_MASK;
+        flags = FIELD_DP32(flags, TBFLAG_ANY, BE, 1);
     }
-    flags |= fp_el << ARM_TBFLAG_FPEXC_EL_SHIFT;
+    flags = FIELD_DP32(flags, TBFLAG_ANY, FPEXC_EL, fp_el);
 
     if (arm_v7m_is_handler_mode(env)) {
-        flags |= ARM_TBFLAG_HANDLER_MASK;
+        flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
     }
 
     /* v8M always applies stack limit checks unless CCR.STKOFHFNMIGN is
@@ -13183,7 +13180,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         arm_feature(env, ARM_FEATURE_M) &&
         !((mmu_idx  & ARM_MMU_IDX_M_NEGPRI) &&
           (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))) {
-        flags |= ARM_TBFLAG_STACKCHECK_MASK;
+        flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
     }
 
     *pflags = flags;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5c06e429d4..af8ad1be8b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13769,7 +13769,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cpu->env_ptr;
     ARMCPU *arm_cpu = arm_env_get_cpu(env);
-    int bound;
+    uint32_t tb_flags = dc->base.tb->flags;
+    int bound, core_mmu_idx;
 
     dc->isar = &arm_cpu->isar;
     dc->pc = dc->base.pc_first;
@@ -13783,20 +13784,21 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
                                !arm_el_is_aa64(env, 3);
     dc->thumb = 0;
     dc->sctlr_b = 0;
-    dc->be_data = ARM_TBFLAG_BE_DATA(dc->base.tb->flags) ? MO_BE : MO_LE;
+    dc->be_data = FIELD_EX32(tb_flags, TBFLAG_ANY, BE) ? MO_BE : MO_LE;
     dc->condexec_mask = 0;
     dc->condexec_cond = 0;
-    dc->mmu_idx = core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(dc->base.tb->flags));
-    dc->tbi0 = ARM_TBFLAG_TBI0(dc->base.tb->flags);
-    dc->tbi1 = ARM_TBFLAG_TBI1(dc->base.tb->flags);
+    core_mmu_idx = FIELD_EX32(tb_flags, TBFLAG_ANY, MMUIDX);
+    dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
+    dc->tbi0 = FIELD_EX32(tb_flags, TBFLAG_A64, TBI0);
+    dc->tbi1 = FIELD_EX32(tb_flags, TBFLAG_A64, TBI1);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
 #endif
-    dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
-    dc->sve_excp_el = ARM_TBFLAG_SVEEXC_EL(dc->base.tb->flags);
-    dc->sve_len = (ARM_TBFLAG_ZCR_LEN(dc->base.tb->flags) + 1) * 16;
-    dc->pauth_active = ARM_TBFLAG_PAUTH_ACTIVE(dc->base.tb->flags);
+    dc->fp_excp_el = FIELD_EX32(tb_flags, TBFLAG_ANY, FPEXC_EL);
+    dc->sve_excp_el = FIELD_EX32(tb_flags, TBFLAG_A64, SVEEXC_EL);
+    dc->sve_len = (FIELD_EX32(tb_flags, TBFLAG_A64, ZCR_LEN) + 1) * 16;
+    dc->pauth_active = FIELD_EX32(tb_flags, TBFLAG_A64, PAUTH_ACTIVE);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
@@ -13817,8 +13819,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
      *   emit code to generate a software step exception
      *   end the TB
      */
-    dc->ss_active = ARM_TBFLAG_SS_ACTIVE(dc->base.tb->flags);
-    dc->pstate_ss = ARM_TBFLAG_PSTATE_SS(dc->base.tb->flags);
+    dc->ss_active = FIELD_EX32(tb_flags, TBFLAG_ANY, SS_ACTIVE);
+    dc->pstate_ss = FIELD_EX32(tb_flags, TBFLAG_ANY, PSTATE_SS);
     dc->is_ldex = false;
     dc->ss_same_el = (arm_debug_target_el(env) == dc->current_el);
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7c4675ffd8..5aa567351f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -13021,6 +13021,8 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUARMState *env = cs->env_ptr;
     ARMCPU *cpu = arm_env_get_cpu(env);
+    uint32_t tb_flags = dc->base.tb->flags;
+    uint32_t condexec, core_mmu_idx;
 
     dc->isar = &cpu->isar;
     dc->pc = dc->base.pc_first;
@@ -13032,26 +13034,28 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
      */
     dc->secure_routed_to_el3 = arm_feature(env, ARM_FEATURE_EL3) &&
                                !arm_el_is_aa64(env, 3);
-    dc->thumb = ARM_TBFLAG_THUMB(dc->base.tb->flags);
-    dc->sctlr_b = ARM_TBFLAG_SCTLR_B(dc->base.tb->flags);
-    dc->be_data = ARM_TBFLAG_BE_DATA(dc->base.tb->flags) ? MO_BE : MO_LE;
-    dc->condexec_mask = (ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) & 0xf) << 1;
-    dc->condexec_cond = ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) >> 4;
-    dc->mmu_idx = core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(dc->base.tb->flags));
+    dc->thumb = FIELD_EX32(tb_flags, TBFLAG_A32, THUMB);
+    dc->sctlr_b = FIELD_EX32(tb_flags, TBFLAG_A32, SCTLR_B);
+    dc->be_data = FIELD_EX32(tb_flags, TBFLAG_ANY, BE) ? MO_BE : MO_LE;
+    condexec = FIELD_EX32(tb_flags, TBFLAG_A32, CONDEXEC);
+    dc->condexec_mask = (condexec & 0xf) << 1;
+    dc->condexec_cond = condexec >> 4;
+    core_mmu_idx = FIELD_EX32(tb_flags, TBFLAG_ANY, MMUIDX);
+    dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
 #endif
-    dc->ns = ARM_TBFLAG_NS(dc->base.tb->flags);
-    dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
-    dc->vfp_enabled = ARM_TBFLAG_VFPEN(dc->base.tb->flags);
-    dc->vec_len = ARM_TBFLAG_VECLEN(dc->base.tb->flags);
-    dc->vec_stride = ARM_TBFLAG_VECSTRIDE(dc->base.tb->flags);
-    dc->c15_cpar = ARM_TBFLAG_XSCALE_CPAR(dc->base.tb->flags);
-    dc->v7m_handler_mode = ARM_TBFLAG_HANDLER(dc->base.tb->flags);
+    dc->ns = FIELD_EX32(tb_flags, TBFLAG_A32, NS);
+    dc->fp_excp_el = FIELD_EX32(tb_flags, TBFLAG_ANY, FPEXC_EL);
+    dc->vfp_enabled = FIELD_EX32(tb_flags, TBFLAG_A32, VFPEN);
+    dc->vec_len = FIELD_EX32(tb_flags, TBFLAG_A32, VECLEN);
+    dc->vec_stride = FIELD_EX32(tb_flags, TBFLAG_A32, VECSTRIDE);
+    dc->c15_cpar = FIELD_EX32(tb_flags, TBFLAG_A32, XSCALE_CPAR);
+    dc->v7m_handler_mode = FIELD_EX32(tb_flags, TBFLAG_A32, HANDLER);
     dc->v8m_secure = arm_feature(env, ARM_FEATURE_M_SECURITY) &&
         regime_is_secure(env, dc->mmu_idx);
-    dc->v8m_stackcheck = ARM_TBFLAG_STACKCHECK(dc->base.tb->flags);
+    dc->v8m_stackcheck = FIELD_EX32(tb_flags, TBFLAG_A32, STACKCHECK);
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
@@ -13070,8 +13074,8 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
      *   emit code to generate a software step exception
      *   end the TB
      */
-    dc->ss_active = ARM_TBFLAG_SS_ACTIVE(dc->base.tb->flags);
-    dc->pstate_ss = ARM_TBFLAG_PSTATE_SS(dc->base.tb->flags);
+    dc->ss_active = FIELD_EX32(tb_flags, TBFLAG_ANY, SS_ACTIVE);
+    dc->pstate_ss = FIELD_EX32(tb_flags, TBFLAG_ANY, PSTATE_SS);
     dc->is_ldex = false;
     dc->ss_same_el = false; /* Can't be true since EL_d must be AArch64 */
 
@@ -13516,11 +13520,11 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
     DisasContext dc;
     const TranslatorOps *ops = &arm_translator_ops;
 
-    if (ARM_TBFLAG_THUMB(tb->flags)) {
+    if (FIELD_EX32(tb->flags, TBFLAG_A32, THUMB)) {
         ops = &thumb_translator_ops;
     }
 #ifdef TARGET_AARCH64
-    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
+    if (FIELD_EX32(tb->flags, TBFLAG_ANY, AARCH64_STATE)) {
         ops = &aarch64_translator_ops;
     }
 #endif
-- 
2.17.2
