Received: from eggs.gnu.org ([2001:4830:134:3::10]:58849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e9WKB-0001sq-3B
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e9WK4-0006zu-SS
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:11:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e9WK4-0006em-K6
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:11:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e9WJr-0007Gi-Rd
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:11:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 13:11:25 +0000
Message-Id: <1509455489-14101-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1509455489-14101-1-git-send-email-peter.maydell@linaro.org>
References: <1509455489-14101-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 1/5] fix WFI/WFE length in syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Stefano Stabellini <sstabellini@kernel.org>

WFI/E are often, but not always, 4 bytes long. When they are, we need to
set ARM_EL_IL_SHIFT in the syndrome register.

Pass the instruction length to HELPER(wfi), use it to decrement pc
appropriately and to pass an is_16bit flag to syn_wfx, which sets
ARM_EL_IL_SHIFT if needed.

Set dc->insn in both arm_tr_translate_insn and thumb_tr_translate_insn.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
Message-id: alpine.DEB.2.10.1710241055160.574@sstabellini-ThinkPad-X260
[PMM: move setting of dc->insn for Thumb so it is correct for 32 bit insns]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        |  2 +-
 target/arm/internals.h     |  3 ++-
 target/arm/op_helper.c     |  7 ++++---
 target/arm/psci.c          |  2 +-
 target/arm/translate-a64.c |  7 ++++++-
 target/arm/translate.c     | 10 +++++++++-
 6 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 2cf6f74..439d228 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -48,7 +48,7 @@ DEF_HELPER_FLAGS_3(sel_flags, TCG_CALL_NO_RWG_SE,
 DEF_HELPER_2(exception_internal, void, env, i32)
 DEF_HELPER_4(exception_with_syndrome, void, env, i32, i32, i32)
 DEF_HELPER_1(setend, void, env)
-DEF_HELPER_1(wfi, void, env)
+DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 43106a2..d9cc75e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -428,9 +428,10 @@ static inline uint32_t syn_breakpoint(int same_el)
         | ARM_EL_IL | 0x22;
 }
 
-static inline uint32_t syn_wfx(int cv, int cond, int ti)
+static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
 {
     return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
+           (is_16bit ? 0 : (1 << ARM_EL_IL_SHIFT)) |
            (cv << 24) | (cond << 20) | ti;
 }
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 138d0df..a40a84a 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -463,7 +463,7 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
     return 0;
 }
 
-void HELPER(wfi)(CPUARMState *env)
+void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
 {
     CPUState *cs = CPU(arm_env_get_cpu(env));
     int target_el = check_wfx_trap(env, false);
@@ -476,8 +476,9 @@ void HELPER(wfi)(CPUARMState *env)
     }
 
     if (target_el) {
-        env->pc -= 4;
-        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0), target_el);
+        env->pc -= insn_len;
+        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0, insn_len == 2),
+                        target_el);
     }
 
     cs->exception_index = EXCP_HLT;
diff --git a/target/arm/psci.c b/target/arm/psci.c
index fc34b26..eb7b88e 100644
--- a/target/arm/psci.c
+++ b/target/arm/psci.c
@@ -189,7 +189,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
         } else {
             env->regs[0] = 0;
         }
-        helper_wfi(env);
+        helper_wfi(env, 4);
         break;
     case QEMU_PSCI_0_1_FN_MIGRATE:
     case QEMU_PSCI_0_2_FN_MIGRATE:
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e98fbcf..caca05a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11400,17 +11400,22 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_helper_yield(cpu_env);
             break;
         case DISAS_WFI:
+        {
             /* This is a special case because we don't want to just halt the CPU
              * if trying to debug across a WFI.
              */
+            TCGv_i32 tmp = tcg_const_i32(4);
+
             gen_a64_set_pc_im(dc->pc);
-            gen_helper_wfi(cpu_env);
+            gen_helper_wfi(cpu_env, tmp);
+            tcg_temp_free_i32(tmp);
             /* The helper doesn't necessarily throw an exception, but we
              * must go back to the main loop to check for interrupts anyway.
              */
             tcg_gen_exit_tb(0);
             break;
         }
+        }
     }
 
     /* Functions above can change dc->pc, so re-align db->pc_next */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6ba4ae9..df57dbb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12125,6 +12125,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
+    dc->insn = insn;
     dc->pc += 4;
     disas_arm_insn(dc, insn);
 
@@ -12200,6 +12201,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         insn = insn << 16 | insn2;
         dc->pc += 2;
     }
+    dc->insn = insn;
 
     if (dc->condexec_mask && !thumb_insn_is_unconditional(dc, insn)) {
         uint32_t cond = dc->condexec_cond;
@@ -12326,12 +12328,18 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             /* nothing more to generate */
             break;
         case DISAS_WFI:
-            gen_helper_wfi(cpu_env);
+        {
+            TCGv_i32 tmp = tcg_const_i32((dc->thumb &&
+                                          !(dc->insn & (1U << 31))) ? 2 : 4);
+
+            gen_helper_wfi(cpu_env, tmp);
+            tcg_temp_free_i32(tmp);
             /* The helper doesn't necessarily throw an exception, but we
              * must go back to the main loop to check for interrupts anyway.
              */
             tcg_gen_exit_tb(0);
             break;
+        }
         case DISAS_WFE:
             gen_helper_wfe(cpu_env);
             break;
-- 
2.7.4
