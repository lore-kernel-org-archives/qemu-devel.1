Received: from eggs.gnu.org ([2001:4830:134:3::10]:47336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQm-0008AK-Lh
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQk-0004M2-SE
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:52 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 16:00:06 +0100
Message-Id: <1506092407-26985-20-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 19/20] target/arm: Implement secure function
 return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Secure function return happens when a non-secure function has been
called using BLXNS and so has a particular magic LR value (either
0xfefffffe or 0xfeffffff). The function return via BX behaves
specially when the new PC value is this magic value, in the same
way that exception returns are handled.

Adjust our BX excret guards so that they recognize the function
return magic number as well, and perform the function-return
unstacking in do_v7m_exception_exit().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |   7 +++
 target/arm/helper.c    | 115 +++++++++++++++++++++++++++++++++++++++++++++----
 target/arm/translate.c |  14 +++++-
 3 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1746737..43106a2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -72,6 +72,13 @@ FIELD(V7M_EXCRET, DCRS, 5, 1)
 FIELD(V7M_EXCRET, S, 6, 1)
 FIELD(V7M_EXCRET, RES1, 7, 25) /* including the must-be-1 prefix */
 
+/* Minimum value which is a magic number for exception return */
+#define EXC_RETURN_MIN_MAGIC 0xff000000
+/* Minimum number which is a magic number for function or exception return
+ * when using v8M security extension
+ */
+#define FNC_RETURN_MIN_MAGIC 0xfefffffe
+
 /* We use a few fake FSR values for internal purposes in M profile.
  * M profile cores don't have A/R format FSRs, but currently our
  * get_phys_addr() code assumes A/R profile and reports failures via
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 30dc2a9..888fe0a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6167,7 +6167,17 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
      *  - if the return value is a magic value, do exception return (like BX)
      *  - otherwise bit 0 of the return value is the target security state
      */
-    if (dest >= 0xff000000) {
+    uint32_t min_magic;
+
+    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+        /* Covers FNC_RETURN and EXC_RETURN magic */
+        min_magic = FNC_RETURN_MIN_MAGIC;
+    } else {
+        /* EXC_RETURN magic only */
+        min_magic = EXC_RETURN_MIN_MAGIC;
+    }
+
+    if (dest >= min_magic) {
         /* This is an exception return magic value; put it where
          * do_v7m_exception_exit() expects and raise EXCEPTION_EXIT.
          * Note that if we ever add gen_ss_advance() singlestep support to
@@ -6460,12 +6470,19 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     bool exc_secure = false;
     bool return_to_secure;
 
-    /* We can only get here from an EXCP_EXCEPTION_EXIT, and
-     * gen_bx_excret() enforces the architectural rule
-     * that jumps to magic addresses don't have magic behaviour unless
-     * we're in Handler mode (compare pseudocode BXWritePC()).
+    /* If we're not in Handler mode then jumps to magic exception-exit
+     * addresses don't have magic behaviour. However for the v8M
+     * security extensions the magic secure-function-return has to
+     * work in thread mode too, so to avoid doing an extra check in
+     * the generated code we allow exception-exit magic to also cause the
+     * internal exception and bring us here in thread mode. Correct code
+     * will never try to do this (the following insn fetch will always
+     * fault) so we the overhead of having taken an unnecessary exception
+     * doesn't matter.
      */
-    assert(arm_v7m_is_handler_mode(env));
+    if (!arm_v7m_is_handler_mode(env)) {
+        return;
+    }
 
     /* In the spec pseudocode ExceptionReturn() is called directly
      * from BXWritePC() and gets the full target PC value including
@@ -6753,6 +6770,78 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     qemu_log_mask(CPU_LOG_INT, "...successful exception return\n");
 }
 
+static bool do_v7m_function_return(ARMCPU *cpu)
+{
+    /* v8M security extensions magic function return.
+     * We may either:
+     *  (1) throw an exception (longjump)
+     *  (2) return true if we successfully handled the function return
+     *  (3) return false if we failed a consistency check and have
+     *      pended a UsageFault that needs to be taken now
+     *
+     * At this point the magic return value is split between env->regs[15]
+     * and env->thumb. We don't bother to reconstitute it because we don't
+     * need it (all values are handled the same way).
+     */
+    CPUARMState *env = &cpu->env;
+    uint32_t newpc, newpsr, newpsr_exc;
+
+    qemu_log_mask(CPU_LOG_INT, "...really v7M secure function return\n");
+
+    {
+        bool threadmode, spsel;
+        TCGMemOpIdx oi;
+        ARMMMUIdx mmu_idx;
+        uint32_t *frame_sp_p;
+        uint32_t frameptr;
+
+        /* Pull the return address and IPSR from the Secure stack */
+        threadmode = !arm_v7m_is_handler_mode(env);
+        spsel = env->v7m.control[M_REG_S] & R_V7M_CONTROL_SPSEL_MASK;
+
+        frame_sp_p = get_v7m_sp_ptr(env, true, threadmode, spsel);
+        frameptr = *frame_sp_p;
+
+        /* These loads may throw an exception (for MPU faults). We want to
+         * do them as secure, so work out what MMU index that is.
+         */
+        mmu_idx = arm_v7m_mmu_idx_for_secstate(env, true);
+        oi = make_memop_idx(MO_LE, arm_to_core_mmu_idx(mmu_idx));
+        newpc = helper_le_ldul_mmu(env, frameptr, oi, 0);
+        newpsr = helper_le_ldul_mmu(env, frameptr + 4, oi, 0);
+
+        /* Consistency checks on new IPSR */
+        newpsr_exc = newpsr & XPSR_EXCP;
+        if (!((env->v7m.exception == 0 && newpsr_exc == 0) ||
+              (env->v7m.exception == 1 && newpsr_exc != 0))) {
+            /* Pend the fault and tell our caller to take it */
+            env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
+            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE,
+                                    env->v7m.secure);
+            qemu_log_mask(CPU_LOG_INT,
+                          "...taking INVPC UsageFault: "
+                          "IPSR consistency check failed\n");
+            return false;
+        }
+
+        *frame_sp_p = frameptr + 8;
+    }
+
+    /* This invalidates frame_sp_p */
+    switch_v7m_security_state(env, true);
+    env->v7m.exception = newpsr_exc;
+    env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
+    if (newpsr & XPSR_SFPA) {
+        env->v7m.control[M_REG_S] |= R_V7M_CONTROL_SFPA_MASK;
+    }
+    xpsr_write(env, 0, XPSR_IT);
+    env->thumb = newpc & 1;
+    env->regs[15] = newpc & ~1;
+
+    qemu_log_mask(CPU_LOG_INT, "...function return successful\n");
+    return true;
+}
+
 static void arm_log_exception(int idx)
 {
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
@@ -7034,8 +7123,18 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     case EXCP_IRQ:
         break;
     case EXCP_EXCEPTION_EXIT:
-        do_v7m_exception_exit(cpu);
-        return;
+        if (env->regs[15] < EXC_RETURN_MIN_MAGIC) {
+            /* Must be v8M security extension function return */
+            assert(env->regs[15] >= FNC_RETURN_MIN_MAGIC);
+            assert(arm_feature(env, ARM_FEATURE_M_SECURITY));
+            if (do_v7m_function_return(cpu)) {
+                return;
+            }
+        } else {
+            do_v7m_exception_exit(cpu);
+            return;
+        }
+        break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
         return; /* Never happens.  Keep compiler happy.  */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 53694bb..f5cca07 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -960,7 +960,8 @@ static inline void gen_bx_excret(DisasContext *s, TCGv_i32 var)
      * s->base.is_jmp that we need to do the rest of the work later.
      */
     gen_bx(s, var);
-    if (s->v7m_handler_mode && arm_dc_feature(s, ARM_FEATURE_M)) {
+    if (arm_dc_feature(s, ARM_FEATURE_M_SECURITY) ||
+        (s->v7m_handler_mode && arm_dc_feature(s, ARM_FEATURE_M))) {
         s->base.is_jmp = DISAS_BX_EXCRET;
     }
 }
@@ -969,9 +970,18 @@ static inline void gen_bx_excret_final_code(DisasContext *s)
 {
     /* Generate the code to finish possible exception return and end the TB */
     TCGLabel *excret_label = gen_new_label();
+    uint32_t min_magic;
+
+    if (arm_dc_feature(s, ARM_FEATURE_M_SECURITY)) {
+        /* Covers FNC_RETURN and EXC_RETURN magic */
+        min_magic = FNC_RETURN_MIN_MAGIC;
+    } else {
+        /* EXC_RETURN magic only */
+        min_magic = EXC_RETURN_MIN_MAGIC;
+    }
 
     /* Is the new PC value in the magic range indicating exception return? */
-    tcg_gen_brcondi_i32(TCG_COND_GEU, cpu_R[15], 0xff000000, excret_label);
+    tcg_gen_brcondi_i32(TCG_COND_GEU, cpu_R[15], min_magic, excret_label);
     /* No: end the TB as we would for a DISAS_JMP */
     if (is_singlestepping(s)) {
         gen_singlestep_exception(s);
-- 
2.7.4
