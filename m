Received: from eggs.gnu.org ([209.51.188.92]:34567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9f0-00051j-7q
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eu-0006pP-T4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9et-0006Wp-H5
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:40 -0400
Received: by mail-wm1-x344.google.com with SMTP id y5so180812wma.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.04
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:14 +0100
Message-Id: <20190429170030.11323-27-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/42] target/arm: Implement M-profile lazy FP
 state preservation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The M-profile architecture floating point system supports
lazy FP state preservation, where FP registers are not
pushed to the stack when an exception occurs but are instead
only saved if and when the first FP instruction in the exception
handler is executed. Implement this in QEMU, corresponding
to the check of LSPACT in the pseudocode ExecuteFPCheck().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-24-peter.maydell@linaro.org
---
 target/arm/cpu.h       |   3 ++
 target/arm/helper.h    |   2 +
 target/arm/translate.h |   1 +
 target/arm/helper.c    | 112 +++++++++++++++++++++++++++++++++++++++++
 target/arm/translate.c |  22 ++++++++
 5 files changed, 140 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ed3069341d2..0b10aefb93d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -57,6 +57,7 @@
 #define EXCP_NOCP           17   /* v7M NOCP UsageFault */
 #define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
 #define EXCP_STKOF          19   /* v8M STKOF UsageFault */
+#define EXCP_LAZYFP         20   /* v7M fault during lazy FP stacking */
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
 
 #define ARMV7M_EXCP_RESET   1
@@ -3172,6 +3173,8 @@ FIELD(TBFLAG_A32, NS, 6, 1)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
+/* For M profile only, set if FPCCR.LSPACT is set */
+FIELD(TBFLAG_A32, LSPACT, 18, 1)
 /* For M profile only, set if we must create a new FP context */
 FIELD(TBFLAG_A32, NEW_FP_CTXT_NEEDED, 19, 1)
 /* For M profile only, set if FPCCR.S does not match current security state */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index a09566f795c..0a3a80528c7 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -69,6 +69,8 @@ DEF_HELPER_2(v7m_blxns, void, env, i32)
 
 DEF_HELPER_3(v7m_tt, i32, env, i32, i32)
 
+DEF_HELPER_1(v7m_preserve_fp_state, void, env)
+
 DEF_HELPER_2(v8m_stackcheck, void, env, i32)
 
 DEF_HELPER_4(access_check_cp_reg, void, env, ptr, i32, i32)
diff --git a/target/arm/translate.h b/target/arm/translate.h
index ed8ae2e7e3b..c2348def0d1 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -42,6 +42,7 @@ typedef struct DisasContext {
     bool v8m_stackcheck; /* true if we need to perform v8M stack limit checks */
     bool v8m_fpccr_s_wrong; /* true if v8M FPCCR.S != v8m_secure */
     bool v7m_new_fp_ctxt_needed; /* ASPEN set but no active FP context */
+    bool v7m_lspact; /* FPCCR.LSPACT set */
     /* Immediate value in AArch32 SVC insn; must be set if is_jmp == DISAS_SWI
      * so that top level loop can generate correct syndrome information.
      */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 41531390853..b11f8aa14df 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7378,6 +7378,12 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
     g_assert_not_reached();
 }
 
+void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
+{
+    /* translate.c should never generate calls here in user-only mode */
+    g_assert_not_reached();
+}
+
 uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
 {
     /* The TT instructions can be used by unprivileged code, but in
@@ -7737,6 +7743,97 @@ pend_fault:
     return false;
 }
 
+void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
+{
+    /*
+     * Preserve FP state (because LSPACT was set and we are about
+     * to execute an FP instruction). This corresponds to the
+     * PreserveFPState() pseudocode.
+     * We may throw an exception if the stacking fails.
+     */
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
+    bool negpri = !(env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_HFRDY_MASK);
+    bool is_priv = !(env->v7m.fpccr[is_secure] & R_V7M_FPCCR_USER_MASK);
+    bool splimviol = env->v7m.fpccr[is_secure] & R_V7M_FPCCR_SPLIMVIOL_MASK;
+    uint32_t fpcar = env->v7m.fpcar[is_secure];
+    bool stacked_ok = true;
+    bool ts = is_secure && (env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_TS_MASK);
+    bool take_exception;
+
+    /* Take the iothread lock as we are going to touch the NVIC */
+    qemu_mutex_lock_iothread();
+
+    /* Check the background context had access to the FPU */
+    if (!v7m_cpacr_pass(env, is_secure, is_priv)) {
+        armv7m_nvic_set_pending_lazyfp(env->nvic, ARMV7M_EXCP_USAGE, is_secure);
+        env->v7m.cfsr[is_secure] |= R_V7M_CFSR_NOCP_MASK;
+        stacked_ok = false;
+    } else if (!is_secure && !extract32(env->v7m.nsacr, 10, 1)) {
+        armv7m_nvic_set_pending_lazyfp(env->nvic, ARMV7M_EXCP_USAGE, M_REG_S);
+        env->v7m.cfsr[M_REG_S] |= R_V7M_CFSR_NOCP_MASK;
+        stacked_ok = false;
+    }
+
+    if (!splimviol && stacked_ok) {
+        /* We only stack if the stack limit wasn't violated */
+        int i;
+        ARMMMUIdx mmu_idx;
+
+        mmu_idx = arm_v7m_mmu_idx_all(env, is_secure, is_priv, negpri);
+        for (i = 0; i < (ts ? 32 : 16); i += 2) {
+            uint64_t dn = *aa32_vfp_dreg(env, i / 2);
+            uint32_t faddr = fpcar + 4 * i;
+            uint32_t slo = extract64(dn, 0, 32);
+            uint32_t shi = extract64(dn, 32, 32);
+
+            if (i >= 16) {
+                faddr += 8; /* skip the slot for the FPSCR */
+            }
+            stacked_ok = stacked_ok &&
+                v7m_stack_write(cpu, faddr, slo, mmu_idx, STACK_LAZYFP) &&
+                v7m_stack_write(cpu, faddr + 4, shi, mmu_idx, STACK_LAZYFP);
+        }
+
+        stacked_ok = stacked_ok &&
+            v7m_stack_write(cpu, fpcar + 0x40,
+                            vfp_get_fpscr(env), mmu_idx, STACK_LAZYFP);
+    }
+
+    /*
+     * We definitely pended an exception, but it's possible that it
+     * might not be able to be taken now. If its priority permits us
+     * to take it now, then we must not update the LSPACT or FP regs,
+     * but instead jump out to take the exception immediately.
+     * If it's just pending and won't be taken until the current
+     * handler exits, then we do update LSPACT and the FP regs.
+     */
+    take_exception = !stacked_ok &&
+        armv7m_nvic_can_take_pending_exception(env->nvic);
+
+    qemu_mutex_unlock_iothread();
+
+    if (take_exception) {
+        raise_exception_ra(env, EXCP_LAZYFP, 0, 1, GETPC());
+    }
+
+    env->v7m.fpccr[is_secure] &= ~R_V7M_FPCCR_LSPACT_MASK;
+
+    if (ts) {
+        /* Clear s0 to s31 and the FPSCR */
+        int i;
+
+        for (i = 0; i < 32; i += 2) {
+            *aa32_vfp_dreg(env, i / 2) = 0;
+        }
+        vfp_set_fpscr(env, 0);
+    }
+    /*
+     * Otherwise s0 to s15 and FPSCR are UNKNOWN; we choose to leave them
+     * unchanged.
+     */
+}
+
 /* Write to v7M CONTROL.SPSEL bit for the specified security bank.
  * This may change the current stack pointer between Main and Process
  * stack pointers if it is done for the CONTROL register for the current
@@ -9062,6 +9159,7 @@ static void arm_log_exception(int idx)
             [EXCP_NOCP] = "v7M NOCP UsageFault",
             [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
             [EXCP_STKOF] = "v8M STKOF UsageFault",
+            [EXCP_LAZYFP] = "v7M exception during lazy FP stacking",
         };
 
         if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
@@ -9355,6 +9453,12 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
             return;
         }
         break;
+    case EXCP_LAZYFP:
+        /*
+         * We already pended the specific exception in the NVIC in the
+         * v7m_preserve_fp_state() helper function.
+         */
+        break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
         return; /* Never happens.  Keep compiler happy.  */
@@ -13483,6 +13587,14 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         flags = FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED, 1);
     }
 
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
+
+        if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
+            flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
+        }
+    }
+
     *pflags = flags;
     *cs_base = 0;
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index edb66e7be8e..4f29d09a28a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3424,6 +3424,27 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
         /* Handle M-profile lazy FP state mechanics */
 
+        /* Trigger lazy-state preservation if necessary */
+        if (s->v7m_lspact) {
+            /*
+             * Lazy state saving affects external memory and also the NVIC,
+             * so we must mark it as an IO operation for icount.
+             */
+            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+                gen_io_start();
+            }
+            gen_helper_v7m_preserve_fp_state(cpu_env);
+            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+                gen_io_end();
+            }
+            /*
+             * If the preserve_fp_state helper doesn't throw an exception
+             * then it will clear LSPACT; we don't need to repeat this for
+             * any further FP insns in this TB.
+             */
+            s->v7m_lspact = false;
+        }
+
         /* Update ownership of FP context: set FPCCR.S to match current state */
         if (s->v8m_fpccr_s_wrong) {
             TCGv_i32 tmp;
@@ -13390,6 +13411,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->v8m_fpccr_s_wrong = FIELD_EX32(tb_flags, TBFLAG_A32, FPCCR_S_WRONG);
     dc->v7m_new_fp_ctxt_needed =
         FIELD_EX32(tb_flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED);
+    dc->v7m_lspact = FIELD_EX32(tb_flags, TBFLAG_A32, LSPACT);
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
-- 
2.20.1
