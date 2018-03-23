Received: from eggs.gnu.org ([2001:4830:134:3::10]:49165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlO-000198-Pv
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlN-0004G7-JJ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ezRlN-0004FG-Aq
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:05 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlM-0007gb-9d
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:50:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 18:49:55 +0000
Message-Id: <20180323184958.14252-8-peter.maydell@linaro.org>
In-Reply-To: <20180323184958.14252-1-peter.maydell@linaro.org>
References: <20180323184958.14252-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/10] target/arm: Honour MDCR_EL2.TDE when
 routing exceptions due to BKPT/BRK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The MDCR_EL2.TDE bit allows the exception level targeted by debug
exceptions to be set to EL2 for code executing at EL0.  We handle
this in the arm_debug_target_el() function, but this is only used for
hardware breakpoint and watchpoint exceptions, not for the exception
generated when the guest executes an AArch32 BKPT or AArch64 BRK
instruction.  We don't have enough information for a translate-time
equivalent of arm_debug_target_el(), so instead make BKPT and BRK
call a special purpose helper which can do the routing, rather than
the generic exception_with_syndrome helper.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180320134114.30418-2-peter.maydell@linaro.org
---
 target/arm/helper.h        |  1 +
 target/arm/op_helper.c     |  8 ++++++++
 target/arm/translate-a64.c | 15 +++++++++++++--
 target/arm/translate.c     | 19 ++++++++++++++-----
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0d2094f2be..34e8cc8904 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -47,6 +47,7 @@ DEF_HELPER_FLAGS_3(sel_flags, TCG_CALL_NO_RWG_SE,
                    i32, i32, i32, i32)
 DEF_HELPER_2(exception_internal, void, env, i32)
 DEF_HELPER_4(exception_with_syndrome, void, env, i32, i32, i32)
+DEF_HELPER_2(exception_bkpt_insn, void, env, i32)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 7a88fd2c92..4b123d2bd6 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -483,6 +483,14 @@ void HELPER(exception_with_syndrome)(CPUARMState *env, uint32_t excp,
     raise_exception(env, excp, syndrome, target_el);
 }
 
+/* Raise an EXCP_BKPT with the specified syndrome register value,
+ * targeting the correct exception level for debug exceptions.
+ */
+void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
+{
+    raise_exception(env, EXCP_BKPT, syndrome, arm_debug_target_el(env));
+}
+
 uint32_t HELPER(cpsr_read)(CPUARMState *env)
 {
     return cpsr_read(env) & ~(CPSR_EXEC | CPSR_RESERVED);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 327513ef40..c91329249d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -321,6 +321,18 @@ static void gen_exception_insn(DisasContext *s, int offset, int excp,
     s->base.is_jmp = DISAS_NORETURN;
 }
 
+static void gen_exception_bkpt_insn(DisasContext *s, int offset,
+                                    uint32_t syndrome)
+{
+    TCGv_i32 tcg_syn;
+
+    gen_a64_set_pc_im(s->pc - offset);
+    tcg_syn = tcg_const_i32(syndrome);
+    gen_helper_exception_bkpt_insn(cpu_env, tcg_syn);
+    tcg_temp_free_i32(tcg_syn);
+    s->base.is_jmp = DISAS_NORETURN;
+}
+
 static void gen_ss_advance(DisasContext *s)
 {
     /* If the singlestep state is Active-not-pending, advance to
@@ -1839,8 +1851,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
             break;
         }
         /* BRK */
-        gen_exception_insn(s, 4, EXCP_BKPT, syn_aa64_bkpt(imm16),
-                           default_exception_el(s));
+        gen_exception_bkpt_insn(s, 4, syn_aa64_bkpt(imm16));
         break;
     case 2:
         if (op2_ll != 0) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ba6ab7d287..fc03b5b8c8 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1248,6 +1248,18 @@ static void gen_exception_insn(DisasContext *s, int offset, int excp,
     s->base.is_jmp = DISAS_NORETURN;
 }
 
+static void gen_exception_bkpt_insn(DisasContext *s, int offset, uint32_t syn)
+{
+    TCGv_i32 tcg_syn;
+
+    gen_set_condexec(s);
+    gen_set_pc_im(s, s->pc - offset);
+    tcg_syn = tcg_const_i32(syn);
+    gen_helper_exception_bkpt_insn(cpu_env, tcg_syn);
+    tcg_temp_free_i32(tcg_syn);
+    s->base.is_jmp = DISAS_NORETURN;
+}
+
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 static inline void gen_lookup_tb(DisasContext *s)
 {
@@ -8774,9 +8786,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             case 1:
                 /* bkpt */
                 ARCH(5);
-                gen_exception_insn(s, 4, EXCP_BKPT,
-                                   syn_aa32_bkpt(imm16, false),
-                                   default_exception_el(s));
+                gen_exception_bkpt_insn(s, 4, syn_aa32_bkpt(imm16, false));
                 break;
             case 2:
                 /* Hypervisor call (v7) */
@@ -11983,8 +11993,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         {
             int imm8 = extract32(insn, 0, 8);
             ARCH(5);
-            gen_exception_insn(s, 2, EXCP_BKPT, syn_aa32_bkpt(imm8, true),
-                               default_exception_el(s));
+            gen_exception_bkpt_insn(s, 2, syn_aa32_bkpt(imm8, true));
             break;
         }
 
-- 
2.16.2
