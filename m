Received: from eggs.gnu.org ([2001:4830:134:3::10]:48357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJK-00058L-8h
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJF-0005js-P4
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:30 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJE-0005h7-VM
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:25 -0400
Received: by mail-pf0-x243.google.com with SMTP id f20so17212350pfn.0
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:43 -0700
Message-Id: <20180509175458.15642-14-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 13/28] target/sparc: convert to DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>, Michael Clark <mjc@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, qemu-s390x@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5aa367a182..03c6510717 100644
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
@@ -3351,7 +3352,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
 
                 if (cond == 8) {
                     /* An unconditional trap ends the TB.  */
-                    dc->is_br = 1;
+                    dc->is_jmp = DISAS_NORETURN;
                     goto jmp_insn;
                 } else {
                     /* A conditional trap falls through to the next insn.  */
@@ -4331,7 +4332,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 save_state(dc);
                                 gen_op_next_insn();
                                 tcg_gen_exit_tb(0);
-                                dc->is_br = 1;
+                                dc->is_jmp = DISAS_NORETURN;
                                 break;
                             case 0x6: /* V9 wrfprs */
                                 tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
@@ -4340,7 +4341,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 save_state(dc);
                                 gen_op_next_insn();
                                 tcg_gen_exit_tb(0);
-                                dc->is_br = 1;
+                                dc->is_jmp = DISAS_NORETURN;
                                 break;
                             case 0xf: /* V9 sir, nop if user */
 #if !defined(CONFIG_USER_ONLY)
@@ -4468,7 +4469,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                             save_state(dc);
                             gen_op_next_insn();
                             tcg_gen_exit_tb(0);
-                            dc->is_br = 1;
+                            dc->is_jmp = DISAS_NORETURN;
 #endif
                         }
                         break;
@@ -4624,7 +4625,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 save_state(dc);
                                 gen_op_next_insn();
                                 tcg_gen_exit_tb(0);
-                                dc->is_br = 1;
+                                dc->is_jmp = DISAS_NORETURN;
                                 break;
                             case 1: // htstate
                                 // XXX gen_op_wrhtstate();
@@ -5690,7 +5691,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
     } else if (dc->npc == JUMP_PC) {
         /* we can do a static jump */
         gen_branch2(dc, dc->jump_pc[0], dc->jump_pc[1], cpu_cond);
-        dc->is_br = 1;
+        dc->is_jmp = DISAS_NORETURN;
     } else {
         dc->pc = dc->npc;
         dc->npc = dc->npc + 4;
@@ -5752,6 +5753,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
     pc_start = tb->pc;
     dc->pc = pc_start;
     last_pc = dc->pc;
+    dc->is_jmp = DISAS_NEXT;
     dc->npc = (target_ulong) tb->cs_base;
     dc->cc_op = CC_OP_DYNAMIC;
     dc->mem_idx = tb->flags & TB_FLAG_MMU_MASK;
@@ -5796,7 +5798,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
             }
             gen_helper_debug(cpu_env);
             tcg_gen_exit_tb(0);
-            dc->is_br = 1;
+            dc->is_jmp = DISAS_NORETURN;
             goto exit_gen_loop;
         }
 
@@ -5808,8 +5810,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
 
         disas_sparc_insn(dc, insn);
 
-        if (dc->is_br)
+        if (dc->is_jmp == DISAS_NORETURN) {
             break;
+        }
         /* if the next PC is different, we abort now */
         if (dc->pc != (last_pc + 4))
             break;
@@ -5830,7 +5833,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
     if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
-    if (!dc->is_br) {
+    if (dc->is_jmp != DISAS_NORETURN) {
         if (dc->pc != DYNAMIC_PC &&
             (dc->npc != DYNAMIC_PC && dc->npc != JUMP_PC)) {
             /* static PC and NPC: we can use direct chaining */
-- 
2.17.0
