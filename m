Received: from eggs.gnu.org ([2001:4830:134:3::10]:33081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1erX5Q-0000J7-FT
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 17:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1erX5N-0004pv-AY
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 17:54:04 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1erX5N-0004mB-3G
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 17:54:01 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  1 Mar 2018 17:53:47 -0500
Message-Id: <1519944838-12430-4-git-send-email-cota@braap.org>
In-Reply-To: <1519944838-12430-1-git-send-email-cota@braap.org>
References: <1519944838-12430-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCHv1 03/14] target/sparc: convert to DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sparc/translate.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 71e0853..730e25d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -30,6 +30,7 @@
 #include "exec/helper-gen.h"
 
 #include "trace-tcg.h"
+#include "exec/translator.h"
 #include "exec/log.h"
 #include "asi.h"
 
@@ -69,7 +70,7 @@ typedef struct DisasContext {
     target_ulong pc;    /* current Program Counter: integer or DYNAMIC_PC */
     target_ulong npc;   /* next PC: integer or DYNAMIC_PC or JUMP_PC */
     target_ulong jump_pc[2]; /* used when JUMP_PC pc value is used */
-    int is_br;
+    DisasJumpType is_jmp;
     int mem_idx;
     bool fpu_enabled;
     bool address_mask_32bit;
@@ -995,7 +996,7 @@ static void gen_branch_a(DisasContext *dc, target_ulong pc1)
     gen_set_label(l1);
     gen_goto_tb(dc, 1, npc + 4, npc + 8);
 
-    dc->is_br = 1;
+    dc->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_branch_n(DisasContext *dc, target_ulong pc1)
@@ -1078,7 +1079,7 @@ static void gen_exception(DisasContext *dc, int which)
     t = tcg_const_i32(which);
     gen_helper_raise_exception(cpu_env, t);
     tcg_temp_free_i32(t);
-    dc->is_br = 1;
+    dc->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_check_align(TCGv addr, int mask)
@@ -3346,7 +3347,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
 
                 if (cond == 8) {
                     /* An unconditional trap ends the TB.  */
-                    dc->is_br = 1;
+                    dc->is_jmp = DISAS_NORETURN;
                     goto jmp_insn;
                 } else {
                     /* A conditional trap falls through to the next insn.  */
@@ -4326,7 +4327,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 save_state(dc);
                                 gen_op_next_insn();
                                 tcg_gen_exit_tb(0);
-                                dc->is_br = 1;
+                                dc->is_jmp = DISAS_NORETURN;
                                 break;
                             case 0x6: /* V9 wrfprs */
                                 tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
@@ -4335,7 +4336,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 save_state(dc);
                                 gen_op_next_insn();
                                 tcg_gen_exit_tb(0);
-                                dc->is_br = 1;
+                                dc->is_jmp = DISAS_NORETURN;
                                 break;
                             case 0xf: /* V9 sir, nop if user */
 #if !defined(CONFIG_USER_ONLY)
@@ -4463,7 +4464,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                             save_state(dc);
                             gen_op_next_insn();
                             tcg_gen_exit_tb(0);
-                            dc->is_br = 1;
+                            dc->is_jmp = DISAS_NORETURN;
 #endif
                         }
                         break;
@@ -4619,7 +4620,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 save_state(dc);
                                 gen_op_next_insn();
                                 tcg_gen_exit_tb(0);
-                                dc->is_br = 1;
+                                dc->is_jmp = DISAS_NORETURN;
                                 break;
                             case 1: // htstate
                                 // XXX gen_op_wrhtstate();
@@ -5685,7 +5686,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
     } else if (dc->npc == JUMP_PC) {
         /* we can do a static jump */
         gen_branch2(dc, dc->jump_pc[0], dc->jump_pc[1], cpu_cond);
-        dc->is_br = 1;
+        dc->is_jmp = DISAS_NORETURN;
     } else {
         dc->pc = dc->npc;
         dc->npc = dc->npc + 4;
@@ -5747,6 +5748,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
     pc_start = tb->pc;
     dc->pc = pc_start;
     last_pc = dc->pc;
+    dc->is_jmp = DISAS_NEXT;
     dc->npc = (target_ulong) tb->cs_base;
     dc->cc_op = CC_OP_DYNAMIC;
     dc->mem_idx = tb->flags & TB_FLAG_MMU_MASK;
@@ -5791,7 +5793,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
             }
             gen_helper_debug(cpu_env);
             tcg_gen_exit_tb(0);
-            dc->is_br = 1;
+            dc->is_jmp = DISAS_NORETURN;
             goto exit_gen_loop;
         }
 
@@ -5803,8 +5805,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
 
         disas_sparc_insn(dc, insn);
 
-        if (dc->is_br)
+        if (dc->is_jmp == DISAS_NORETURN) {
             break;
+        }
         /* if the next PC is different, we abort now */
         if (dc->pc != (last_pc + 4))
             break;
@@ -5825,7 +5828,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
     if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
-    if (!dc->is_br) {
+    if (dc->is_jmp != DISAS_NORETURN) {
         if (dc->pc != DYNAMIC_PC &&
             (dc->npc != DYNAMIC_PC && dc->npc != JUMP_PC)) {
             /* static PC and NPC: we can use direct chaining */
-- 
2.7.4
