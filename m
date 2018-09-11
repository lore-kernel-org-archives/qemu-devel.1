Received: from eggs.gnu.org ([2001:4830:134:3::10]:58683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGy-0000QP-Tj
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGs-0002X1-Vb
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzpGs-0002WU-Nl
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Sep 2018 16:28:16 -0400
Message-Id: <20180911202823.21657-7-cota@braap.org>
In-Reply-To: <20180911202823.21657-1-cota@braap.org>
References: <20180911202823.21657-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 06/13] target/i386: move cpu_tmp4 to
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
 target/i386/translate.c | 78 ++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 873231fb44..0ad6ffc4af 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -79,7 +79,6 @@ static TCGv cpu_seg_base[6];
 static TCGv_i64 cpu_bndl[4];
 static TCGv_i64 cpu_bndu[4];
 
-static TCGv cpu_tmp4;
 static TCGv_ptr cpu_ptr0, cpu_ptr1;
 static TCGv_i32 cpu_tmp2_i32, cpu_tmp3_i32;
 static TCGv_i64 cpu_tmp1_i64;
@@ -141,6 +140,7 @@ typedef struct DisasContext {
 
     /* TCG local register indexes (only used inside old micro ops) */
     TCGv tmp0;
+    TCGv tmp4;
 
     sigjmp_buf jmpbuf;
 } DisasContext;
@@ -909,10 +909,10 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         size = s->cc_op - CC_OP_SUBB;
         switch (jcc_op) {
         case JCC_BE:
-            tcg_gen_mov_tl(cpu_tmp4, s->cc_srcT);
-            gen_extu(size, cpu_tmp4);
+            tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
+            gen_extu(size, s->tmp4);
             t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
-            cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = cpu_tmp4,
+            cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->tmp4,
                                .reg2 = t0, .mask = -1, .use_reg2 = true };
             break;
 
@@ -922,10 +922,10 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_LE:
             cond = TCG_COND_LE;
         fast_jcc_l:
-            tcg_gen_mov_tl(cpu_tmp4, s->cc_srcT);
-            gen_exts(size, cpu_tmp4);
+            tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
+            gen_exts(size, s->tmp4);
             t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, true);
-            cc = (CCPrepare) { .cond = cond, .reg = cpu_tmp4,
+            cc = (CCPrepare) { .cond = cond, .reg = s->tmp4,
                                .reg2 = t0, .mask = -1, .use_reg2 = true };
             break;
 
@@ -1277,32 +1277,32 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
     }
     switch(op) {
     case OP_ADCL:
-        gen_compute_eflags_c(s1, cpu_tmp4);
+        gen_compute_eflags_c(s1, s1->tmp4);
         if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_add_tl(s1->T0, cpu_tmp4, s1->T1);
+            tcg_gen_add_tl(s1->T0, s1->tmp4, s1->T1);
             tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
                                         s1->mem_index, ot | MO_LE);
         } else {
             tcg_gen_add_tl(s1->T0, s1->T0, s1->T1);
-            tcg_gen_add_tl(s1->T0, s1->T0, cpu_tmp4);
+            tcg_gen_add_tl(s1->T0, s1->T0, s1->tmp4);
             gen_op_st_rm_T0_A0(s1, ot, d);
         }
-        gen_op_update3_cc(s1, cpu_tmp4);
+        gen_op_update3_cc(s1, s1->tmp4);
         set_cc_op(s1, CC_OP_ADCB + ot);
         break;
     case OP_SBBL:
-        gen_compute_eflags_c(s1, cpu_tmp4);
+        gen_compute_eflags_c(s1, s1->tmp4);
         if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_add_tl(s1->T0, s1->T1, cpu_tmp4);
+            tcg_gen_add_tl(s1->T0, s1->T1, s1->tmp4);
             tcg_gen_neg_tl(s1->T0, s1->T0);
             tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
                                         s1->mem_index, ot | MO_LE);
         } else {
             tcg_gen_sub_tl(s1->T0, s1->T0, s1->T1);
-            tcg_gen_sub_tl(s1->T0, s1->T0, cpu_tmp4);
+            tcg_gen_sub_tl(s1->T0, s1->T0, s1->tmp4);
             gen_op_st_rm_T0_A0(s1, ot, d);
         }
-        gen_op_update3_cc(s1, cpu_tmp4);
+        gen_op_update3_cc(s1, s1->tmp4);
         set_cc_op(s1, CC_OP_SBBB + ot);
         break;
     case OP_ADDL:
@@ -1492,15 +1492,15 @@ static void gen_shift_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2,
         if (is_right) {
             if (is_arith) {
                 gen_exts(ot, s->T0);
-                tcg_gen_sari_tl(cpu_tmp4, s->T0, op2 - 1);
+                tcg_gen_sari_tl(s->tmp4, s->T0, op2 - 1);
                 tcg_gen_sari_tl(s->T0, s->T0, op2);
             } else {
                 gen_extu(ot, s->T0);
-                tcg_gen_shri_tl(cpu_tmp4, s->T0, op2 - 1);
+                tcg_gen_shri_tl(s->tmp4, s->T0, op2 - 1);
                 tcg_gen_shri_tl(s->T0, s->T0, op2);
             }
         } else {
-            tcg_gen_shli_tl(cpu_tmp4, s->T0, op2 - 1);
+            tcg_gen_shli_tl(s->tmp4, s->T0, op2 - 1);
             tcg_gen_shli_tl(s->T0, s->T0, op2);
         }
     }
@@ -1510,7 +1510,7 @@ static void gen_shift_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2,
 
     /* update eflags if non zero shift */
     if (op2 != 0) {
-        tcg_gen_mov_tl(cpu_cc_src, cpu_tmp4);
+        tcg_gen_mov_tl(cpu_cc_src, s->tmp4);
         tcg_gen_mov_tl(cpu_cc_dst, s->T0);
         set_cc_op(s, (is_right ? CC_OP_SARB : CC_OP_SHLB) + ot);
     }
@@ -1786,25 +1786,25 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
         if (is_right) {
             tcg_gen_shr_tl(s->tmp0, s->T0, s->tmp0);
 
-            tcg_gen_subfi_tl(cpu_tmp4, mask + 1, count);
+            tcg_gen_subfi_tl(s->tmp4, mask + 1, count);
             tcg_gen_shr_tl(s->T0, s->T0, count);
-            tcg_gen_shl_tl(s->T1, s->T1, cpu_tmp4);
+            tcg_gen_shl_tl(s->T1, s->T1, s->tmp4);
         } else {
             tcg_gen_shl_tl(s->tmp0, s->T0, s->tmp0);
             if (ot == MO_16) {
                 /* Only needed if count > 16, for Intel behaviour.  */
-                tcg_gen_subfi_tl(cpu_tmp4, 33, count);
-                tcg_gen_shr_tl(cpu_tmp4, s->T1, cpu_tmp4);
-                tcg_gen_or_tl(s->tmp0, s->tmp0, cpu_tmp4);
+                tcg_gen_subfi_tl(s->tmp4, 33, count);
+                tcg_gen_shr_tl(s->tmp4, s->T1, s->tmp4);
+                tcg_gen_or_tl(s->tmp0, s->tmp0, s->tmp4);
             }
 
-            tcg_gen_subfi_tl(cpu_tmp4, mask + 1, count);
+            tcg_gen_subfi_tl(s->tmp4, mask + 1, count);
             tcg_gen_shl_tl(s->T0, s->T0, count);
-            tcg_gen_shr_tl(s->T1, s->T1, cpu_tmp4);
+            tcg_gen_shr_tl(s->T1, s->T1, s->tmp4);
         }
-        tcg_gen_movi_tl(cpu_tmp4, 0);
-        tcg_gen_movcond_tl(TCG_COND_EQ, s->T1, count, cpu_tmp4,
-                           cpu_tmp4, s->T1);
+        tcg_gen_movi_tl(s->tmp4, 0);
+        tcg_gen_movcond_tl(TCG_COND_EQ, s->T1, count, s->tmp4,
+                           s->tmp4, s->T1);
         tcg_gen_or_tl(s->T0, s->T0, s->T1);
         break;
     }
@@ -2346,7 +2346,7 @@ static void gen_push_v(DisasContext *s, TCGv val)
 
     if (!CODE64(s)) {
         if (s->addseg) {
-            new_esp = cpu_tmp4;
+            new_esp = s->tmp4;
             tcg_gen_mov_tl(new_esp, s->A0);
         }
         gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
@@ -5068,8 +5068,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                                       tcg_const_i32(dflag - 1),
                                       tcg_const_i32(s->pc - s->cs_base));
             }
-            tcg_gen_ld_tl(cpu_tmp4, cpu_env, offsetof(CPUX86State, eip));
-            gen_jr(s, cpu_tmp4);
+            tcg_gen_ld_tl(s->tmp4, cpu_env, offsetof(CPUX86State, eip));
+            gen_jr(s, s->tmp4);
             break;
         case 4: /* jmp Ev */
             if (dflag == MO_16) {
@@ -5092,8 +5092,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_op_movl_seg_T0_vm(s, R_CS);
                 gen_op_jmp_v(s->T1);
             }
-            tcg_gen_ld_tl(cpu_tmp4, cpu_env, offsetof(CPUX86State, eip));
-            gen_jr(s, cpu_tmp4);
+            tcg_gen_ld_tl(s->tmp4, cpu_env, offsetof(CPUX86State, eip));
+            gen_jr(s, s->tmp4);
             break;
         case 6: /* push Ev */
             gen_push_v(s, s->T0);
@@ -6821,9 +6821,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                                             s->mem_index, ot | MO_LE);
                 break;
             }
-            tcg_gen_shr_tl(cpu_tmp4, s->T0, s->T1);
+            tcg_gen_shr_tl(s->tmp4, s->T0, s->T1);
         } else {
-            tcg_gen_shr_tl(cpu_tmp4, s->T0, s->T1);
+            tcg_gen_shr_tl(s->tmp4, s->T0, s->T1);
             switch (op) {
             case 0: /* bt */
                 /* Data already loaded; nothing to do.  */
@@ -6867,13 +6867,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                We can get that same Z value (and the new C value) by leaving
                CC_DST alone, setting CC_SRC, and using a CC_OP_SAR of the
                same width.  */
-            tcg_gen_mov_tl(cpu_cc_src, cpu_tmp4);
+            tcg_gen_mov_tl(cpu_cc_src, s->tmp4);
             set_cc_op(s, ((s->cc_op - CC_OP_MULB) & 3) + CC_OP_SARB);
             break;
         default:
             /* Otherwise, generate EFLAGS and replace the C bit.  */
             gen_compute_eflags(s);
-            tcg_gen_deposit_tl(cpu_cc_src, cpu_cc_src, cpu_tmp4,
+            tcg_gen_deposit_tl(cpu_cc_src, cpu_cc_src, s->tmp4,
                                ctz32(CC_C), 1);
             break;
         }
@@ -8483,7 +8483,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     cpu_tmp1_i64 = tcg_temp_new_i64();
     cpu_tmp2_i32 = tcg_temp_new_i32();
     cpu_tmp3_i32 = tcg_temp_new_i32();
-    cpu_tmp4 = tcg_temp_new();
+    dc->tmp4 = tcg_temp_new();
     cpu_ptr0 = tcg_temp_new_ptr();
     cpu_ptr1 = tcg_temp_new_ptr();
     dc->cc_srcT = tcg_temp_local_new();
-- 
2.17.1
