Received: from eggs.gnu.org ([209.51.188.92]:34307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eo-0004pj-31
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9em-0006iu-Ck
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:33 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:46342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9ej-0006Ul-24
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:30 -0400
Received: by mail-wr1-x429.google.com with SMTP id t17so17057979wrw.13
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.59
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:10 +0100
Message-Id: <20190429170030.11323-23-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/42] target/arm: Activate M-profile floating
 point context when FPCCR.ASPEN is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The M-profile FPCCR.ASPEN bit indicates that automatic floating-point
context preservation is enabled. Before executing any floating-point
instruction, if FPCCR.ASPEN is set and the CONTROL FPCA/SFPA bits
indicate that there is no active floating point context then we
must create a new context (by initializing FPSCR and setting
FPCA/SFPA to indicate that the context is now active). In the
pseudocode this is handled by ExecuteFPCheck().

Implement this with a new TB flag which tracks whether we
need to create a new FP context.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-20-peter.maydell@linaro.org
---
 target/arm/cpu.h       |  2 ++
 target/arm/translate.h |  1 +
 target/arm/helper.c    | 13 +++++++++++++
 target/arm/translate.c | 29 +++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a2cf9aae3a1..d4996a4d204 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3153,6 +3153,8 @@ FIELD(TBFLAG_A32, NS, 6, 1)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
+/* For M profile only, set if we must create a new FP context */
+FIELD(TBFLAG_A32, NEW_FP_CTXT_NEEDED, 19, 1)
 /* For M profile only, set if FPCCR.S does not match current security state */
 FIELD(TBFLAG_A32, FPCCR_S_WRONG, 20, 1)
 /* For M profile only, Handler (ie not Thread) mode */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 93abff645ad..ed8ae2e7e3b 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -41,6 +41,7 @@ typedef struct DisasContext {
     bool v8m_secure; /* true if v8M and we're in Secure mode */
     bool v8m_stackcheck; /* true if we need to perform v8M stack limit checks */
     bool v8m_fpccr_s_wrong; /* true if v8M FPCCR.S != v8m_secure */
+    bool v7m_new_fp_ctxt_needed; /* ASPEN set but no active FP context */
     /* Immediate value in AArch32 SVC insn; must be set if is_jmp == DISAS_SWI
      * so that top level loop can generate correct syndrome information.
      */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8290f56c658..84e3790a9de 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13422,6 +13422,19 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
     }
 
+    if (arm_feature(env, ARM_FEATURE_M) &&
+        (env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
+        (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) ||
+         (env->v7m.secure &&
+          !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)))) {
+        /*
+         * ASPEN is set, but FPCA/SFPA indicate that there is no active
+         * FP context; we must create a new FP context before executing
+         * any FP insn.
+         */
+        flags = FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED, 1);
+    }
+
     *pflags = flags;
     *cs_base = 0;
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f0332ac19ec..edb66e7be8e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3438,6 +3438,33 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             /* Don't need to do this for any further FP insns in this TB */
             s->v8m_fpccr_s_wrong = false;
         }
+
+        if (s->v7m_new_fp_ctxt_needed) {
+            /*
+             * Create new FP context by updating CONTROL.FPCA, CONTROL.SFPA
+             * and the FPSCR.
+             */
+            TCGv_i32 control, fpscr;
+            uint32_t bits = R_V7M_CONTROL_FPCA_MASK;
+
+            fpscr = load_cpu_field(v7m.fpdscr[s->v8m_secure]);
+            gen_helper_vfp_set_fpscr(cpu_env, fpscr);
+            tcg_temp_free_i32(fpscr);
+            /*
+             * We don't need to arrange to end the TB, because the only
+             * parts of FPSCR which we cache in the TB flags are the VECLEN
+             * and VECSTRIDE, and those don't exist for M-profile.
+             */
+
+            if (s->v8m_secure) {
+                bits |= R_V7M_CONTROL_SFPA_MASK;
+            }
+            control = load_cpu_field(v7m.control[M_REG_S]);
+            tcg_gen_ori_i32(control, control, bits);
+            store_cpu_field(control, v7m.control[M_REG_S]);
+            /* Don't need to do this for any further FP insns in this TB */
+            s->v7m_new_fp_ctxt_needed = false;
+        }
     }
 
     if (extract32(insn, 28, 4) == 0xf) {
@@ -13361,6 +13388,8 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         regime_is_secure(env, dc->mmu_idx);
     dc->v8m_stackcheck = FIELD_EX32(tb_flags, TBFLAG_A32, STACKCHECK);
     dc->v8m_fpccr_s_wrong = FIELD_EX32(tb_flags, TBFLAG_A32, FPCCR_S_WRONG);
+    dc->v7m_new_fp_ctxt_needed =
+        FIELD_EX32(tb_flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED);
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
-- 
2.20.1
