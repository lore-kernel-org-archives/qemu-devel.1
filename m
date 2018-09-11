Received: from eggs.gnu.org ([2001:4830:134:3::10]:58686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGy-0000QQ-VR
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGu-0002Y6-Aj
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzpGu-0002XV-4S
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Sep 2018 16:28:20 -0400
Message-Id: <20180911202823.21657-11-cota@braap.org>
In-Reply-To: <20180911202823.21657-1-cota@braap.org>
References: <20180911202823.21657-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 10/13] target/i386: move cpu_tmp3_i32 to
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/translate.c | 64 ++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index ec68f7dba1..cd880cc2a8 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -79,7 +79,6 @@ static TCGv cpu_seg_base[6];
 static TCGv_i64 cpu_bndl[4];
 static TCGv_i64 cpu_bndu[4];
 
-static TCGv_i32 cpu_tmp3_i32;
 static TCGv_i64 cpu_tmp1_i64;
 
 #include "exec/gen-icount.h"
@@ -143,6 +142,7 @@ typedef struct DisasContext {
     TCGv_ptr ptr0;
     TCGv_ptr ptr1;
     TCGv_i32 tmp2_i32;
+    TCGv_i32 tmp3_i32;
 
     sigjmp_buf jmpbuf;
 } DisasContext;
@@ -1159,8 +1159,8 @@ static inline void gen_outs(DisasContext *s, TCGMemOp ot)
 
     tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
     tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
-    tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T0);
-    gen_helper_out_func(ot, s->tmp2_i32, cpu_tmp3_i32);
+    tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T0);
+    gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
     gen_op_movl_T0_Dshift(s, ot);
     gen_op_add_reg_T0(s, s->aflag, R_ESI);
     gen_bpt_io(s, s->tmp2_i32, ot);
@@ -1426,8 +1426,8 @@ static void gen_shift_flags(DisasContext *s, TCGMemOp ot, TCGv result,
     if (s->cc_op == CC_OP_DYNAMIC) {
         oldop = cpu_cc_op;
     } else {
-        tcg_gen_movi_i32(cpu_tmp3_i32, s->cc_op);
-        oldop = cpu_tmp3_i32;
+        tcg_gen_movi_i32(s->tmp3_i32, s->cc_op);
+        oldop = s->tmp3_i32;
     }
 
     /* Conditionally store the CC_OP value.  */
@@ -1546,11 +1546,11 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp ot, int op1, int is_right)
 #ifdef TARGET_X86_64
     case MO_32:
         tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-        tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T1);
+        tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
         if (is_right) {
-            tcg_gen_rotr_i32(s->tmp2_i32, s->tmp2_i32, cpu_tmp3_i32);
+            tcg_gen_rotr_i32(s->tmp2_i32, s->tmp2_i32, s->tmp3_i32);
         } else {
-            tcg_gen_rotl_i32(s->tmp2_i32, s->tmp2_i32, cpu_tmp3_i32);
+            tcg_gen_rotl_i32(s->tmp2_i32, s->tmp2_i32, s->tmp3_i32);
         }
         tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
         break;
@@ -1593,9 +1593,9 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp ot, int op1, int is_right)
     t1 = tcg_temp_new_i32();
     tcg_gen_trunc_tl_i32(t1, s->T1);
     tcg_gen_movi_i32(s->tmp2_i32, CC_OP_ADCOX);
-    tcg_gen_movi_i32(cpu_tmp3_i32, CC_OP_EFLAGS);
+    tcg_gen_movi_i32(s->tmp3_i32, CC_OP_EFLAGS);
     tcg_gen_movcond_i32(TCG_COND_NE, cpu_cc_op, t1, t0,
-                        s->tmp2_i32, cpu_tmp3_i32);
+                        s->tmp2_i32, s->tmp3_i32);
     tcg_temp_free_i32(t0);
     tcg_temp_free_i32(t1);
 
@@ -3912,11 +3912,11 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 switch (ot) {
                 default:
                     tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                    tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_regs[R_EDX]);
-                    tcg_gen_mulu2_i32(s->tmp2_i32, cpu_tmp3_i32,
-                                      s->tmp2_i32, cpu_tmp3_i32);
+                    tcg_gen_trunc_tl_i32(s->tmp3_i32, cpu_regs[R_EDX]);
+                    tcg_gen_mulu2_i32(s->tmp2_i32, s->tmp3_i32,
+                                      s->tmp2_i32, s->tmp3_i32);
                     tcg_gen_extu_i32_tl(cpu_regs[s->vex_v], s->tmp2_i32);
-                    tcg_gen_extu_i32_tl(cpu_regs[reg], cpu_tmp3_i32);
+                    tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp3_i32);
                     break;
 #ifdef TARGET_X86_64
                 case MO_64:
@@ -4882,11 +4882,11 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             default:
             case MO_32:
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_regs[R_EAX]);
-                tcg_gen_mulu2_i32(s->tmp2_i32, cpu_tmp3_i32,
-                                  s->tmp2_i32, cpu_tmp3_i32);
+                tcg_gen_trunc_tl_i32(s->tmp3_i32, cpu_regs[R_EAX]);
+                tcg_gen_mulu2_i32(s->tmp2_i32, s->tmp3_i32,
+                                  s->tmp2_i32, s->tmp3_i32);
                 tcg_gen_extu_i32_tl(cpu_regs[R_EAX], s->tmp2_i32);
-                tcg_gen_extu_i32_tl(cpu_regs[R_EDX], cpu_tmp3_i32);
+                tcg_gen_extu_i32_tl(cpu_regs[R_EDX], s->tmp3_i32);
                 tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
                 tcg_gen_mov_tl(cpu_cc_src, cpu_regs[R_EDX]);
                 set_cc_op(s, CC_OP_MULL);
@@ -4933,14 +4933,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             default:
             case MO_32:
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_regs[R_EAX]);
-                tcg_gen_muls2_i32(s->tmp2_i32, cpu_tmp3_i32,
-                                  s->tmp2_i32, cpu_tmp3_i32);
+                tcg_gen_trunc_tl_i32(s->tmp3_i32, cpu_regs[R_EAX]);
+                tcg_gen_muls2_i32(s->tmp2_i32, s->tmp3_i32,
+                                  s->tmp2_i32, s->tmp3_i32);
                 tcg_gen_extu_i32_tl(cpu_regs[R_EAX], s->tmp2_i32);
-                tcg_gen_extu_i32_tl(cpu_regs[R_EDX], cpu_tmp3_i32);
+                tcg_gen_extu_i32_tl(cpu_regs[R_EDX], s->tmp3_i32);
                 tcg_gen_sari_i32(s->tmp2_i32, s->tmp2_i32, 31);
                 tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
-                tcg_gen_sub_i32(s->tmp2_i32, s->tmp2_i32, cpu_tmp3_i32);
+                tcg_gen_sub_i32(s->tmp2_i32, s->tmp2_i32, s->tmp3_i32);
                 tcg_gen_extu_i32_tl(cpu_cc_src, s->tmp2_i32);
                 set_cc_op(s, CC_OP_MULL);
                 break;
@@ -5210,13 +5210,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 #endif
         case MO_32:
             tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-            tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T1);
-            tcg_gen_muls2_i32(s->tmp2_i32, cpu_tmp3_i32,
-                              s->tmp2_i32, cpu_tmp3_i32);
+            tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
+            tcg_gen_muls2_i32(s->tmp2_i32, s->tmp3_i32,
+                              s->tmp2_i32, s->tmp3_i32);
             tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp2_i32);
             tcg_gen_sari_i32(s->tmp2_i32, s->tmp2_i32, 31);
             tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[reg]);
-            tcg_gen_sub_i32(s->tmp2_i32, s->tmp2_i32, cpu_tmp3_i32);
+            tcg_gen_sub_i32(s->tmp2_i32, s->tmp2_i32, s->tmp3_i32);
             tcg_gen_extu_i32_tl(cpu_cc_src, s->tmp2_i32);
             break;
         default:
@@ -6417,8 +6417,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_io_start();
 	}
         tcg_gen_movi_i32(s->tmp2_i32, val);
-        tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T1);
-        gen_helper_out_func(ot, s->tmp2_i32, cpu_tmp3_i32);
+        tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
+        gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
         gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
@@ -6455,8 +6455,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_io_start();
 	}
         tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-        tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T1);
-        gen_helper_out_func(ot, s->tmp2_i32, cpu_tmp3_i32);
+        tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
+        gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
         gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
@@ -8486,7 +8486,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->tmp0 = tcg_temp_new();
     cpu_tmp1_i64 = tcg_temp_new_i64();
     dc->tmp2_i32 = tcg_temp_new_i32();
-    cpu_tmp3_i32 = tcg_temp_new_i32();
+    dc->tmp3_i32 = tcg_temp_new_i32();
     dc->tmp4 = tcg_temp_new();
     dc->ptr0 = tcg_temp_new_ptr();
     dc->ptr1 = tcg_temp_new_ptr();
-- 
2.17.1
