Received: from eggs.gnu.org ([2001:4830:134:3::10]:41542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqL-0008MH-5d
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqI-0001V2-IS
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:21 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:34779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqI-0001UB-At
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:18 -0400
Received: by mail-pf0-x22c.google.com with SMTP id m1so13484072pfk.1
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:05:42 -0700
Message-Id: <20170906160612.22769-3-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 02/32] target/i386: Use generic DISAS_*
 enumerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

This target is not sophisticated in its use of cleanups at the
end of the translation loop.  For the most part, any condition
that exits the TB is dealt with by emitting the exiting opcode
right then and there.  Therefore the only is_jmp indicator that
is needed is DISAS_NORETURN.

For two stack segment modifying cases, we have not yet exited
the TB (therefore DISAS_NORETURN feels wrong), but intend to exit.
The caller of gen_movl_seg_T0 currently checks for any non-zero
value, therefore DISAS_TOO_MANY seems acceptable for that usage.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5fdadf98cf..26e8002433 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -31,6 +31,7 @@
 #include "trace-tcg.h"
 #include "exec/log.h"
 
+#define DISAS_TOO_MANY 5
 
 #define PREFIX_REPZ   0x01
 #define PREFIX_REPNZ  0x02
@@ -2153,6 +2154,7 @@ static inline void gen_goto_tb(DisasContext *s, int tb_num, target_ulong eip)
         tcg_gen_goto_tb(tb_num);
         gen_jmp_im(eip);
         tcg_gen_exit_tb((uintptr_t)s->tb + tb_num);
+        s->is_jmp = DISAS_NORETURN;
     } else {
         /* jump to another page */
         gen_jmp_im(eip);
@@ -2173,7 +2175,6 @@ static inline void gen_jcc(DisasContext *s, int b,
 
         gen_set_label(l1);
         gen_goto_tb(s, 1, val);
-        s->is_jmp = DISAS_TB_JUMP;
     } else {
         l1 = gen_new_label();
         l2 = gen_new_label();
@@ -2243,12 +2244,14 @@ static void gen_movl_seg_T0(DisasContext *s, int seg_reg)
            because ss32 may change. For R_SS, translation must always
            stop as a special handling must be done to disable hardware
            interrupts for the next instruction */
-        if (seg_reg == R_SS || (s->code32 && seg_reg < R_FS))
-            s->is_jmp = DISAS_TB_JUMP;
+        if (seg_reg == R_SS || (s->code32 && seg_reg < R_FS)) {
+            s->is_jmp = DISAS_TOO_MANY;
+        }
     } else {
         gen_op_movl_seg_T0_vm(seg_reg);
-        if (seg_reg == R_SS)
-            s->is_jmp = DISAS_TB_JUMP;
+        if (seg_reg == R_SS) {
+            s->is_jmp = DISAS_TOO_MANY;
+        }
     }
 }
 
@@ -2420,7 +2423,7 @@ static void gen_exception(DisasContext *s, int trapno, target_ulong cur_eip)
     gen_update_cc_op(s);
     gen_jmp_im(cur_eip);
     gen_helper_raise_exception(cpu_env, tcg_const_i32(trapno));
-    s->is_jmp = DISAS_TB_JUMP;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 /* Generate #UD for the current instruction.  The assumption here is that
@@ -2458,7 +2461,7 @@ static void gen_interrupt(DisasContext *s, int intno,
     gen_jmp_im(cur_eip);
     gen_helper_raise_interrupt(cpu_env, tcg_const_i32(intno),
                                tcg_const_i32(next_eip - cur_eip));
-    s->is_jmp = DISAS_TB_JUMP;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_debug(DisasContext *s, target_ulong cur_eip)
@@ -2466,7 +2469,7 @@ static void gen_debug(DisasContext *s, target_ulong cur_eip)
     gen_update_cc_op(s);
     gen_jmp_im(cur_eip);
     gen_helper_debug(cpu_env);
-    s->is_jmp = DISAS_TB_JUMP;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_set_hflag(DisasContext *s, uint32_t mask)
@@ -2541,7 +2544,7 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, TCGv jr)
     } else {
         tcg_gen_exit_tb(0);
     }
-    s->is_jmp = DISAS_TB_JUMP;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 static inline void
@@ -2580,7 +2583,6 @@ static void gen_jmp_tb(DisasContext *s, target_ulong eip, int tb_num)
     set_cc_op(s, CC_OP_DYNAMIC);
     if (s->jmp_opt) {
         gen_goto_tb(s, tb_num, eip);
-        s->is_jmp = DISAS_TB_JUMP;
     } else {
         gen_jmp_im(eip);
         gen_eob(s);
@@ -6943,7 +6945,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             gen_helper_pause(cpu_env, tcg_const_i32(s->pc - pc_start));
-            s->is_jmp = DISAS_TB_JUMP;
+            s->is_jmp = DISAS_NORETURN;
         }
         break;
     case 0x9b: /* fwait */
@@ -7188,7 +7190,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             gen_helper_hlt(cpu_env, tcg_const_i32(s->pc - pc_start));
-            s->is_jmp = DISAS_TB_JUMP;
+            s->is_jmp = DISAS_NORETURN;
         }
         break;
     case 0x100:
@@ -7371,7 +7373,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_helper_vmrun(cpu_env, tcg_const_i32(s->aflag - 1),
                              tcg_const_i32(s->pc - pc_start));
             tcg_gen_exit_tb(0);
-            s->is_jmp = DISAS_TB_JUMP;
+            s->is_jmp = DISAS_NORETURN;
             break;
 
         case 0xd9: /* VMMCALL */
-- 
2.13.5
