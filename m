Received: from eggs.gnu.org ([209.51.188.92]:34515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ew-0004yK-9K
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9et-0006o0-Ac
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:45471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9er-0006Y3-O8
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id s15so17081739wra.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.05
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:15 +0100
Message-Id: <20190429170030.11323-28-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/42] target/arm: Implement VLSTM for v7M CPUs
 with an FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Implement the VLSTM instruction for v7M for the FPU present case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-25-peter.maydell@linaro.org
---
 target/arm/cpu.h       |  2 +
 target/arm/helper.h    |  2 +
 target/arm/helper.c    | 84 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate.c | 15 +++++++-
 4 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0b10aefb93d..22bc6e00ab9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -58,6 +58,8 @@
 #define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
 #define EXCP_STKOF          19   /* v8M STKOF UsageFault */
 #define EXCP_LAZYFP         20   /* v7M fault during lazy FP stacking */
+#define EXCP_LSERR          21   /* v8M LSERR SecureFault */
+#define EXCP_UNALIGNED      22   /* v7M UNALIGNED UsageFault */
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
 
 #define ARMV7M_EXCP_RESET   1
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0a3a80528c7..62051ae6d51 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -71,6 +71,8 @@ DEF_HELPER_3(v7m_tt, i32, env, i32, i32)
 
 DEF_HELPER_1(v7m_preserve_fp_state, void, env)
 
+DEF_HELPER_2(v7m_vlstm, void, env, i32)
+
 DEF_HELPER_2(v8m_stackcheck, void, env, i32)
 
 DEF_HELPER_4(access_check_cp_reg, void, env, ptr, i32, i32)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b11f8aa14df..b821037c3b6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7384,6 +7384,12 @@ void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
     g_assert_not_reached();
 }
 
+void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
+{
+    /* translate.c should never generate calls here in user-only mode */
+    g_assert_not_reached();
+}
+
 uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
 {
     /* The TT instructions can be used by unprivileged code, but in
@@ -8400,6 +8406,74 @@ static void v7m_update_fpccr(CPUARMState *env, uint32_t frameptr,
     }
 }
 
+void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
+{
+    /* fptr is the value of Rn, the frame pointer we store the FP regs to */
+    bool s = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
+    bool lspact = env->v7m.fpccr[s] & R_V7M_FPCCR_LSPACT_MASK;
+
+    assert(env->v7m.secure);
+
+    if (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)) {
+        return;
+    }
+
+    /* Check access to the coprocessor is permitted */
+    if (!v7m_cpacr_pass(env, true, arm_current_el(env) != 0)) {
+        raise_exception_ra(env, EXCP_NOCP, 0, 1, GETPC());
+    }
+
+    if (lspact) {
+        /* LSPACT should not be active when there is active FP state */
+        raise_exception_ra(env, EXCP_LSERR, 0, 1, GETPC());
+    }
+
+    if (fptr & 7) {
+        raise_exception_ra(env, EXCP_UNALIGNED, 0, 1, GETPC());
+    }
+
+    /*
+     * Note that we do not use v7m_stack_write() here, because the
+     * accesses should not set the FSR bits for stacking errors if they
+     * fail. (In pseudocode terms, they are AccType_NORMAL, not AccType_STACK
+     * or AccType_LAZYFP). Faults in cpu_stl_data() will throw exceptions
+     * and longjmp out.
+     */
+    if (!(env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPEN_MASK)) {
+        bool ts = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_TS_MASK;
+        int i;
+
+        for (i = 0; i < (ts ? 32 : 16); i += 2) {
+            uint64_t dn = *aa32_vfp_dreg(env, i / 2);
+            uint32_t faddr = fptr + 4 * i;
+            uint32_t slo = extract64(dn, 0, 32);
+            uint32_t shi = extract64(dn, 32, 32);
+
+            if (i >= 16) {
+                faddr += 8; /* skip the slot for the FPSCR */
+            }
+            cpu_stl_data(env, faddr, slo);
+            cpu_stl_data(env, faddr + 4, shi);
+        }
+        cpu_stl_data(env, fptr + 0x40, vfp_get_fpscr(env));
+
+        /*
+         * If TS is 0 then s0 to s15 and FPSCR are UNKNOWN; we choose to
+         * leave them unchanged, matching our choice in v7m_preserve_fp_state.
+         */
+        if (ts) {
+            for (i = 0; i < 32; i += 2) {
+                *aa32_vfp_dreg(env, i / 2) = 0;
+            }
+            vfp_set_fpscr(env, 0);
+        }
+    } else {
+        v7m_update_fpccr(env, fptr, false);
+    }
+
+    env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
+}
+
 static bool v7m_push_stack(ARMCPU *cpu)
 {
     /* Do the "set up stack frame" part of exception entry,
@@ -9160,6 +9234,8 @@ static void arm_log_exception(int idx)
             [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
             [EXCP_STKOF] = "v8M STKOF UsageFault",
             [EXCP_LAZYFP] = "v7M exception during lazy FP stacking",
+            [EXCP_LSERR] = "v8M LSERR UsageFault",
+            [EXCP_UNALIGNED] = "v7M UNALIGNED UsageFault",
         };
 
         if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
@@ -9334,6 +9410,14 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_STKOF_MASK;
         break;
+    case EXCP_LSERR:
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
+        env->v7m.sfsr |= R_V7M_SFSR_LSERR_MASK;
+        break;
+    case EXCP_UNALIGNED:
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
+        env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_UNALIGNED_MASK;
+        break;
     case EXCP_SWI:
         /* The PC already points to the next instruction.  */
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SVC, env->v7m.secure);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4f29d09a28a..99b38dd5f2b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11818,7 +11818,20 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 if (!s->v8m_secure || (insn & 0x0040f0ff)) {
                     goto illegal_op;
                 }
-                /* Just NOP since FP support is not implemented */
+
+                if (arm_dc_feature(s, ARM_FEATURE_VFP)) {
+                    TCGv_i32 fptr = load_reg(s, rn);
+
+                    if (extract32(insn, 20, 1)) {
+                        /* VLLDM */
+                    } else {
+                        gen_helper_v7m_vlstm(cpu_env, fptr);
+                    }
+                    tcg_temp_free_i32(fptr);
+
+                    /* End the TB, because we have updated FP control bits */
+                    s->base.is_jmp = DISAS_UPDATE;
+                }
                 break;
             }
             if (arm_dc_feature(s, ARM_FEATURE_VFP) &&
-- 
2.20.1
