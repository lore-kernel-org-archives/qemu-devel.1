Received: from eggs.gnu.org ([2001:4830:134:3::10]:56276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOf-0002TO-7n
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOd-0000lC-Nf
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:49987)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSKOd-0000j8-7T
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:49:59 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Jun 2018 12:49:31 +0200
Message-Id: <20180611104935.20499-6-laurent@vivier.eu>
In-Reply-To: <20180611104935.20499-1-laurent@vivier.eu>
References: <20180611104935.20499-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 5/9] target/m68k: Rename DISAS_UPDATE and
 gen_lookup_tb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

The name gen_lookup_tb is at odds with tcg_gen_lookup_and_goto_tb.
For these cases, we do indeed want to exit back to the main loop.
Similarly, DISAS_UPDATE performs no actual update, whereas DISAS_EXIT
does what it says.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180512050250.12774-6-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4b92a20c05..0cbd715550 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -198,7 +198,7 @@ static void do_writebacks(DisasContext *s)
 
 /* is_jmp field values */
 #define DISAS_JUMP      DISAS_TARGET_0 /* only pc was modified dynamically */
-#define DISAS_UPDATE    DISAS_TARGET_1 /* cpu state was modified dynamically */
+#define DISAS_EXIT      DISAS_TARGET_1 /* cpu state was modified dynamically */
 
 #if defined(CONFIG_USER_ONLY)
 #define IS_USER(s) 1
@@ -1446,11 +1446,11 @@ static void gen_jmpcc(DisasContext *s, int cond, TCGLabel *l1)
 }
 
 /* Force a TB lookup after an instruction that changes the CPU state.  */
-static void gen_lookup_tb(DisasContext *s)
+static void gen_exit_tb(DisasContext *s)
 {
     update_cc_op(s);
     tcg_gen_movi_i32(QREG_PC, s->pc);
-    s->is_jmp = DISAS_UPDATE;
+    s->is_jmp = DISAS_EXIT;
 }
 
 #define SRC_EA(env, result, opsize, op_sign, addrp) do {                \
@@ -4604,7 +4604,7 @@ DISAS_INSN(move_to_sr)
         return;
     }
     gen_move_to_sr(env, s, insn, false);
-    gen_lookup_tb(s);
+    gen_exit_tb(s);
 }
 
 DISAS_INSN(move_from_usp)
@@ -4680,7 +4680,7 @@ DISAS_INSN(cf_movec)
         reg = DREG(ext, 12);
     }
     gen_helper_cf_movec_to(cpu_env, tcg_const_i32(ext & 0xfff), reg);
-    gen_lookup_tb(s);
+    gen_exit_tb(s);
 }
 
 DISAS_INSN(m68k_movec)
@@ -4705,7 +4705,7 @@ DISAS_INSN(m68k_movec)
     } else {
         gen_helper_m68k_movec_from(reg, cpu_env, tcg_const_i32(ext & 0xfff));
     }
-    gen_lookup_tb(s);
+    gen_exit_tb(s);
 }
 
 DISAS_INSN(intouch)
@@ -5749,7 +5749,7 @@ DISAS_INSN(to_macsr)
     TCGv val;
     SRC_EA(env, val, OS_LONG, 0, NULL);
     gen_helper_set_macsr(cpu_env, val);
-    gen_lookup_tb(s);
+    gen_exit_tb(s);
 }
 
 DISAS_INSN(to_mask)
@@ -6144,9 +6144,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             tcg_gen_lookup_and_goto_ptr();
             break;
         default:
-        case DISAS_UPDATE:
-            update_cc_op(dc);
-            /* indicate that the hash table must be used to find the next TB */
+        case DISAS_EXIT:
+            /* We updated CC_OP and PC in gen_exit_tb, but also modified
+               other state that may require returning to the main loop.  */
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_NORETURN:
-- 
2.14.4
