Received: from eggs.gnu.org ([2001:4830:134:3::10]:44214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxU-0003Kl-Um
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxP-0004Zl-5G
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fxO-0004Z8-Sv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxN-0000dU-TE
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:03:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 17:03:28 +0100
Message-Id: <1507824216-29058-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 05/13] target/arm: Implement BLXNS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Implement the BLXNS instruction, which allows secure code to
call non-secure code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1507556919-24992-4-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.h    |  1 +
 target/arm/internals.h |  1 +
 target/arm/helper.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate.c | 17 +++++++++++++--
 4 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 64afbac..2cf6f74 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -64,6 +64,7 @@ DEF_HELPER_3(v7m_msr, void, env, i32, i32)
 DEF_HELPER_2(v7m_mrs, i32, env, i32)
 
 DEF_HELPER_2(v7m_bxns, void, env, i32)
+DEF_HELPER_2(v7m_blxns, void, env, i32)
 
 DEF_HELPER_4(access_check_cp_reg, void, env, ptr, i32, i32)
 DEF_HELPER_3(set_cp_reg, void, env, ptr, i32)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index fd9a7e8..1746737 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -60,6 +60,7 @@ static inline bool excp_is_internal(int excp)
 FIELD(V7M_CONTROL, NPRIV, 0, 1)
 FIELD(V7M_CONTROL, SPSEL, 1, 1)
 FIELD(V7M_CONTROL, FPCA, 2, 1)
+FIELD(V7M_CONTROL, SFPA, 3, 1)
 
 /* Bit definitions for v7M exception return payload */
 FIELD(V7M_EXCRET, ES, 0, 1)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9cc881e..47c5767 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5897,6 +5897,12 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
     g_assert_not_reached();
 }
 
+void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
+{
+    /* translate.c should never generate calls here in user-only mode */
+    g_assert_not_reached();
+}
+
 void switch_mode(CPUARMState *env, int mode)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
@@ -6189,6 +6195,59 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
     env->regs[15] = dest & ~1;
 }
 
+void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
+{
+    /* Handle v7M BLXNS:
+     *  - bit 0 of the destination address is the target security state
+     */
+
+    /* At this point regs[15] is the address just after the BLXNS */
+    uint32_t nextinst = env->regs[15] | 1;
+    uint32_t sp = env->regs[13] - 8;
+    uint32_t saved_psr;
+
+    /* translate.c will have made BLXNS UNDEF unless we're secure */
+    assert(env->v7m.secure);
+
+    if (dest & 1) {
+        /* target is Secure, so this is just a normal BLX,
+         * except that the low bit doesn't indicate Thumb/not.
+         */
+        env->regs[14] = nextinst;
+        env->thumb = 1;
+        env->regs[15] = dest & ~1;
+        return;
+    }
+
+    /* Target is non-secure: first push a stack frame */
+    if (!QEMU_IS_ALIGNED(sp, 8)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "BLXNS with misaligned SP is UNPREDICTABLE\n");
+    }
+
+    saved_psr = env->v7m.exception;
+    if (env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK) {
+        saved_psr |= XPSR_SFPA;
+    }
+
+    /* Note that these stores can throw exceptions on MPU faults */
+    cpu_stl_data(env, sp, nextinst);
+    cpu_stl_data(env, sp + 4, saved_psr);
+
+    env->regs[13] = sp;
+    env->regs[14] = 0xfeffffff;
+    if (arm_v7m_is_handler_mode(env)) {
+        /* Write a dummy value to IPSR, to avoid leaking the current secure
+         * exception number to non-secure code. This is guaranteed not
+         * to cause write_v7m_exception() to actually change stacks.
+         */
+        write_v7m_exception(env, 1);
+    }
+    switch_v7m_security_state(env, 0);
+    env->thumb = 1;
+    env->regs[15] = dest;
+}
+
 static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
                                 bool spsel)
 {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 61fd0ef..caf0d58 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1017,6 +1017,20 @@ static inline void gen_bxns(DisasContext *s, int rm)
     s->base.is_jmp = DISAS_EXIT;
 }
 
+static inline void gen_blxns(DisasContext *s, int rm)
+{
+    TCGv_i32 var = load_reg(s, rm);
+
+    /* We don't need to sync condexec state, for the same reason as bxns.
+     * We do however need to set the PC, because the blxns helper reads it.
+     * The blxns helper may throw an exception.
+     */
+    gen_set_pc_im(s, s->pc);
+    gen_helper_v7m_blxns(cpu_env, var);
+    tcg_temp_free_i32(var);
+    s->base.is_jmp = DISAS_EXIT;
+}
+
 /* Variant of store_reg which uses branch&exchange logic when storing
    to r15 in ARM architecture v7 and above. The source must be a temporary
    and will be marked as dead. */
@@ -11222,8 +11236,7 @@ static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
                         goto undef;
                     }
                     if (link) {
-                        /* BLXNS: not yet implemented */
-                        goto undef;
+                        gen_blxns(s, rm);
                     } else {
                         gen_bxns(s, rm);
                     }
-- 
2.7.4
