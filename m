Received: from eggs.gnu.org ([2001:4830:134:3::10]:58674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGy-0000QK-Sx
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGs-0002X6-W8
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzpGs-0002WS-Lp
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Sep 2018 16:28:15 -0400
Message-Id: <20180911202823.21657-6-cota@braap.org>
In-Reply-To: <20180911202823.21657-1-cota@braap.org>
References: <20180911202823.21657-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 05/13] target/i386: move cpu_tmp0 to
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
 target/i386/translate.c | 282 ++++++++++++++++++++--------------------
 1 file changed, 144 insertions(+), 138 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index bd27e65344..873231fb44 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -78,8 +78,8 @@ static TCGv cpu_regs[CPU_NB_REGS];
 static TCGv cpu_seg_base[6];
 static TCGv_i64 cpu_bndl[4];
 static TCGv_i64 cpu_bndu[4];
-/* local register indexes (only used inside old micro ops) */
-static TCGv cpu_tmp0, cpu_tmp4;
+
+static TCGv cpu_tmp4;
 static TCGv_ptr cpu_ptr0, cpu_ptr1;
 static TCGv_i32 cpu_tmp2_i32, cpu_tmp3_i32;
 static TCGv_i64 cpu_tmp1_i64;
@@ -139,6 +139,9 @@ typedef struct DisasContext {
     TCGv T0;
     TCGv T1;
 
+    /* TCG local register indexes (only used inside old micro ops) */
+    TCGv tmp0;
+
     sigjmp_buf jmpbuf;
 } DisasContext;
 
@@ -406,16 +409,17 @@ static inline void gen_op_jmp_v(TCGv dest)
     tcg_gen_st_tl(dest, cpu_env, offsetof(CPUX86State, eip));
 }
 
-static inline void gen_op_add_reg_im(TCGMemOp size, int reg, int32_t val)
+static inline
+void gen_op_add_reg_im(DisasContext *s, TCGMemOp size, int reg, int32_t val)
 {
-    tcg_gen_addi_tl(cpu_tmp0, cpu_regs[reg], val);
-    gen_op_mov_reg_v(size, reg, cpu_tmp0);
+    tcg_gen_addi_tl(s->tmp0, cpu_regs[reg], val);
+    gen_op_mov_reg_v(size, reg, s->tmp0);
 }
 
 static inline void gen_op_add_reg_T0(DisasContext *s, TCGMemOp size, int reg)
 {
-    tcg_gen_add_tl(cpu_tmp0, cpu_regs[reg], s->T0);
-    gen_op_mov_reg_v(size, reg, cpu_tmp0);
+    tcg_gen_add_tl(s->tmp0, cpu_regs[reg], s->T0);
+    gen_op_mov_reg_v(size, reg, s->tmp0);
 }
 
 static inline void gen_op_ld_v(DisasContext *s, int idx, TCGv t0, TCGv a0)
@@ -437,10 +441,10 @@ static inline void gen_op_st_rm_T0_A0(DisasContext *s, int idx, int d)
     }
 }
 
-static inline void gen_jmp_im(target_ulong pc)
+static inline void gen_jmp_im(DisasContext *s, target_ulong pc)
 {
-    tcg_gen_movi_tl(cpu_tmp0, pc);
-    gen_op_jmp_v(cpu_tmp0);
+    tcg_gen_movi_tl(s->tmp0, pc);
+    gen_op_jmp_v(s->tmp0);
 }
 
 /* Compute SEG:REG into A0.  SEG is selected from the override segment
@@ -556,18 +560,20 @@ static void gen_exts(TCGMemOp ot, TCGv reg)
     gen_ext_tl(reg, reg, ot, true);
 }
 
-static inline void gen_op_jnz_ecx(TCGMemOp size, TCGLabel *label1)
+static inline
+void gen_op_jnz_ecx(DisasContext *s, TCGMemOp size, TCGLabel *label1)
 {
-    tcg_gen_mov_tl(cpu_tmp0, cpu_regs[R_ECX]);
-    gen_extu(size, cpu_tmp0);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_tmp0, 0, label1);
+    tcg_gen_mov_tl(s->tmp0, cpu_regs[R_ECX]);
+    gen_extu(size, s->tmp0);
+    tcg_gen_brcondi_tl(TCG_COND_NE, s->tmp0, 0, label1);
 }
 
-static inline void gen_op_jz_ecx(TCGMemOp size, TCGLabel *label1)
+static inline
+void gen_op_jz_ecx(DisasContext *s, TCGMemOp size, TCGLabel *label1)
 {
-    tcg_gen_mov_tl(cpu_tmp0, cpu_regs[R_ECX]);
-    gen_extu(size, cpu_tmp0);
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_tmp0, 0, label1);
+    tcg_gen_mov_tl(s->tmp0, cpu_regs[R_ECX]);
+    gen_extu(size, s->tmp0);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, s->tmp0, 0, label1);
 }
 
 static void gen_helper_in_func(TCGMemOp ot, TCGv v, TCGv_i32 n)
@@ -627,7 +633,7 @@ static void gen_check_io(DisasContext *s, TCGMemOp ot, target_ulong cur_eip,
     }
     if(s->flags & HF_SVMI_MASK) {
         gen_update_cc_op(s);
-        gen_jmp_im(cur_eip);
+        gen_jmp_im(s, cur_eip);
         svm_flags |= (1 << (4 + ot));
         next_eip = s->pc - s->cs_base;
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
@@ -743,9 +749,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_SUBB;
-        t1 = gen_ext_tl(cpu_tmp0, cpu_cc_src, size, false);
+        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
         /* If no temporary was used, be careful not to alias t1 and t0.  */
-        t0 = t1 == cpu_cc_src ? cpu_tmp0 : reg;
+        t0 = t1 == cpu_cc_src ? s->tmp0 : reg;
         tcg_gen_mov_tl(t0, s->cc_srcT);
         gen_extu(size, t0);
         goto add_sub;
@@ -753,7 +759,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_ADDB;
-        t1 = gen_ext_tl(cpu_tmp0, cpu_cc_src, size, false);
+        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
         t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
     add_sub:
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = t0,
@@ -905,7 +911,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_BE:
             tcg_gen_mov_tl(cpu_tmp4, s->cc_srcT);
             gen_extu(size, cpu_tmp4);
-            t0 = gen_ext_tl(cpu_tmp0, cpu_cc_src, size, false);
+            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
             cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = cpu_tmp4,
                                .reg2 = t0, .mask = -1, .use_reg2 = true };
             break;
@@ -918,7 +924,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         fast_jcc_l:
             tcg_gen_mov_tl(cpu_tmp4, s->cc_srcT);
             gen_exts(size, cpu_tmp4);
-            t0 = gen_ext_tl(cpu_tmp0, cpu_cc_src, size, true);
+            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, true);
             cc = (CCPrepare) { .cond = cond, .reg = cpu_tmp4,
                                .reg2 = t0, .mask = -1, .use_reg2 = true };
             break;
@@ -955,7 +961,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_L:
             gen_compute_eflags(s);
             if (reg == cpu_cc_src) {
-                reg = cpu_tmp0;
+                reg = s->tmp0;
             }
             tcg_gen_shri_tl(reg, cpu_cc_src, 4); /* CC_O -> CC_S */
             tcg_gen_xor_tl(reg, reg, cpu_cc_src);
@@ -966,7 +972,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_LE:
             gen_compute_eflags(s);
             if (reg == cpu_cc_src) {
-                reg = cpu_tmp0;
+                reg = s->tmp0;
             }
             tcg_gen_shri_tl(reg, cpu_cc_src, 4); /* CC_O -> CC_S */
             tcg_gen_xor_tl(reg, reg, cpu_cc_src);
@@ -1061,7 +1067,7 @@ static TCGLabel *gen_jz_ecx_string(DisasContext *s, target_ulong next_eip)
 {
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
-    gen_op_jnz_ecx(s->aflag, l1);
+    gen_op_jnz_ecx(s, s->aflag, l1);
     gen_set_label(l2);
     gen_jmp_tb(s, next_eip, 1);
     gen_set_label(l1);
@@ -1171,11 +1177,11 @@ static inline void gen_repz_ ## op(DisasContext *s, TCGMemOp ot,              \
     gen_update_cc_op(s);                                                      \
     l2 = gen_jz_ecx_string(s, next_eip);                                      \
     gen_ ## op(s, ot);                                                        \
-    gen_op_add_reg_im(s->aflag, R_ECX, -1);                                   \
+    gen_op_add_reg_im(s, s->aflag, R_ECX, -1);                                \
     /* a loop would cause two single step exceptions if ECX = 1               \
        before rep string_insn */                                              \
     if (s->repz_opt)                                                          \
-        gen_op_jz_ecx(s->aflag, l2);                                          \
+        gen_op_jz_ecx(s, s->aflag, l2);                                       \
     gen_jmp(s, cur_eip);                                                      \
 }
 
@@ -1189,11 +1195,11 @@ static inline void gen_repz_ ## op(DisasContext *s, TCGMemOp ot,              \
     gen_update_cc_op(s);                                                      \
     l2 = gen_jz_ecx_string(s, next_eip);                                      \
     gen_ ## op(s, ot);                                                        \
-    gen_op_add_reg_im(s->aflag, R_ECX, -1);                                   \
+    gen_op_add_reg_im(s, s->aflag, R_ECX, -1);                                \
     gen_update_cc_op(s);                                                      \
     gen_jcc1(s, (JCC_Z << 1) | (nz ^ 1), l2);                                 \
     if (s->repz_opt)                                                          \
-        gen_op_jz_ecx(s->aflag, l2);                                          \
+        gen_op_jz_ecx(s, s->aflag, l2);                                       \
     gen_jmp(s, cur_eip);                                                      \
 }
 
@@ -1447,27 +1453,27 @@ static void gen_shift_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
     }
 
     tcg_gen_andi_tl(s->T1, s->T1, mask);
-    tcg_gen_subi_tl(cpu_tmp0, s->T1, 1);
+    tcg_gen_subi_tl(s->tmp0, s->T1, 1);
 
     if (is_right) {
         if (is_arith) {
             gen_exts(ot, s->T0);
-            tcg_gen_sar_tl(cpu_tmp0, s->T0, cpu_tmp0);
+            tcg_gen_sar_tl(s->tmp0, s->T0, s->tmp0);
             tcg_gen_sar_tl(s->T0, s->T0, s->T1);
         } else {
             gen_extu(ot, s->T0);
-            tcg_gen_shr_tl(cpu_tmp0, s->T0, cpu_tmp0);
+            tcg_gen_shr_tl(s->tmp0, s->T0, s->tmp0);
             tcg_gen_shr_tl(s->T0, s->T0, s->T1);
         }
     } else {
-        tcg_gen_shl_tl(cpu_tmp0, s->T0, cpu_tmp0);
+        tcg_gen_shl_tl(s->tmp0, s->T0, s->tmp0);
         tcg_gen_shl_tl(s->T0, s->T0, s->T1);
     }
 
     /* store */
     gen_op_st_rm_T0_A0(s, ot, op1);
 
-    gen_shift_flags(s, ot, s->T0, cpu_tmp0, s->T1, is_right);
+    gen_shift_flags(s, ot, s->T0, s->tmp0, s->T1, is_right);
 }
 
 static void gen_shift_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2,
@@ -1640,9 +1646,9 @@ static void gen_rot_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2,
                 shift = mask + 1 - shift;
             }
             gen_extu(ot, s->T0);
-            tcg_gen_shli_tl(cpu_tmp0, s->T0, shift);
+            tcg_gen_shli_tl(s->tmp0, s->T0, shift);
             tcg_gen_shri_tl(s->T0, s->T0, mask + 1 - shift);
-            tcg_gen_or_tl(s->T0, s->T0, cpu_tmp0);
+            tcg_gen_or_tl(s->T0, s->T0, s->tmp0);
             break;
         }
     }
@@ -1751,9 +1757,9 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
            This means "shrdw C, B, A" shifts A:B:A >> C.  Build the B:A
            portion by constructing it as a 32-bit value.  */
         if (is_right) {
-            tcg_gen_deposit_tl(cpu_tmp0, s->T0, s->T1, 16, 16);
+            tcg_gen_deposit_tl(s->tmp0, s->T0, s->T1, 16, 16);
             tcg_gen_mov_tl(s->T1, s->T0);
-            tcg_gen_mov_tl(s->T0, cpu_tmp0);
+            tcg_gen_mov_tl(s->T0, s->tmp0);
         } else {
             tcg_gen_deposit_tl(s->T1, s->T0, s->T1, 16, 16);
         }
@@ -1761,35 +1767,35 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
 #ifdef TARGET_X86_64
     case MO_32:
         /* Concatenate the two 32-bit values and use a 64-bit shift.  */
-        tcg_gen_subi_tl(cpu_tmp0, count, 1);
+        tcg_gen_subi_tl(s->tmp0, count, 1);
         if (is_right) {
             tcg_gen_concat_tl_i64(s->T0, s->T0, s->T1);
-            tcg_gen_shr_i64(cpu_tmp0, s->T0, cpu_tmp0);
+            tcg_gen_shr_i64(s->tmp0, s->T0, s->tmp0);
             tcg_gen_shr_i64(s->T0, s->T0, count);
         } else {
             tcg_gen_concat_tl_i64(s->T0, s->T1, s->T0);
-            tcg_gen_shl_i64(cpu_tmp0, s->T0, cpu_tmp0);
+            tcg_gen_shl_i64(s->tmp0, s->T0, s->tmp0);
             tcg_gen_shl_i64(s->T0, s->T0, count);
-            tcg_gen_shri_i64(cpu_tmp0, cpu_tmp0, 32);
+            tcg_gen_shri_i64(s->tmp0, s->tmp0, 32);
             tcg_gen_shri_i64(s->T0, s->T0, 32);
         }
         break;
 #endif
     default:
-        tcg_gen_subi_tl(cpu_tmp0, count, 1);
+        tcg_gen_subi_tl(s->tmp0, count, 1);
         if (is_right) {
-            tcg_gen_shr_tl(cpu_tmp0, s->T0, cpu_tmp0);
+            tcg_gen_shr_tl(s->tmp0, s->T0, s->tmp0);
 
             tcg_gen_subfi_tl(cpu_tmp4, mask + 1, count);
             tcg_gen_shr_tl(s->T0, s->T0, count);
             tcg_gen_shl_tl(s->T1, s->T1, cpu_tmp4);
         } else {
-            tcg_gen_shl_tl(cpu_tmp0, s->T0, cpu_tmp0);
+            tcg_gen_shl_tl(s->tmp0, s->T0, s->tmp0);
             if (ot == MO_16) {
                 /* Only needed if count > 16, for Intel behaviour.  */
                 tcg_gen_subfi_tl(cpu_tmp4, 33, count);
                 tcg_gen_shr_tl(cpu_tmp4, s->T1, cpu_tmp4);
-                tcg_gen_or_tl(cpu_tmp0, cpu_tmp0, cpu_tmp4);
+                tcg_gen_or_tl(s->tmp0, s->tmp0, cpu_tmp4);
             }
 
             tcg_gen_subfi_tl(cpu_tmp4, mask + 1, count);
@@ -1806,7 +1812,7 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
     /* store */
     gen_op_st_rm_T0_A0(s, ot, op1);
 
-    gen_shift_flags(s, ot, s->T0, cpu_tmp0, count, is_right);
+    gen_shift_flags(s, ot, s->T0, s->tmp0, count, is_right);
     tcg_temp_free(count);
 }
 
@@ -2196,13 +2202,13 @@ static inline void gen_goto_tb(DisasContext *s, int tb_num, target_ulong eip)
     if (use_goto_tb(s, pc))  {
         /* jump to same page: we can use a direct jump */
         tcg_gen_goto_tb(tb_num);
-        gen_jmp_im(eip);
+        gen_jmp_im(s, eip);
         tcg_gen_exit_tb(s->base.tb, tb_num);
         s->base.is_jmp = DISAS_NORETURN;
     } else {
         /* jump to another page */
-        gen_jmp_im(eip);
-        gen_jr(s, cpu_tmp0);
+        gen_jmp_im(s, eip);
+        gen_jr(s, s->tmp0);
     }
 }
 
@@ -2224,11 +2230,11 @@ static inline void gen_jcc(DisasContext *s, int b,
         l2 = gen_new_label();
         gen_jcc1(s, b, l1);
 
-        gen_jmp_im(next_eip);
+        gen_jmp_im(s, next_eip);
         tcg_gen_br(l2);
 
         gen_set_label(l1);
-        gen_jmp_im(val);
+        gen_jmp_im(s, val);
         gen_set_label(l2);
         gen_eob(s);
     }
@@ -2312,7 +2318,7 @@ gen_svm_check_intercept_param(DisasContext *s, target_ulong pc_start,
     if (likely(!(s->flags & HF_SVMI_MASK)))
         return;
     gen_update_cc_op(s);
-    gen_jmp_im(pc_start - s->cs_base);
+    gen_jmp_im(s, pc_start - s->cs_base);
     gen_helper_svm_check_intercept_param(cpu_env, tcg_const_i32(type),
                                          tcg_const_i64(param));
 }
@@ -2325,7 +2331,7 @@ gen_svm_check_intercept(DisasContext *s, target_ulong pc_start, uint64_t type)
 
 static inline void gen_stack_update(DisasContext *s, int addend)
 {
-    gen_op_add_reg_im(mo_stacksize(s), R_ESP, addend);
+    gen_op_add_reg_im(s, mo_stacksize(s), R_ESP, addend);
 }
 
 /* Generate a push. It depends on ss32, addseg and dflag.  */
@@ -2427,11 +2433,11 @@ static void gen_enter(DisasContext *s, int esp_addend, int level)
         for (i = 1; i < level; ++i) {
             tcg_gen_subi_tl(s->A0, cpu_regs[R_EBP], size * i);
             gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
-            gen_op_ld_v(s, d_ot, cpu_tmp0, s->A0);
+            gen_op_ld_v(s, d_ot, s->tmp0, s->A0);
 
             tcg_gen_subi_tl(s->A0, s->T1, size * i);
             gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
-            gen_op_st_v(s, d_ot, cpu_tmp0, s->A0);
+            gen_op_st_v(s, d_ot, s->tmp0, s->A0);
         }
 
         /* Push the current FrameTemp as the last level.  */
@@ -2465,7 +2471,7 @@ static void gen_leave(DisasContext *s)
 static void gen_exception(DisasContext *s, int trapno, target_ulong cur_eip)
 {
     gen_update_cc_op(s);
-    gen_jmp_im(cur_eip);
+    gen_jmp_im(s, cur_eip);
     gen_helper_raise_exception(cpu_env, tcg_const_i32(trapno));
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -2502,7 +2508,7 @@ static void gen_interrupt(DisasContext *s, int intno,
                           target_ulong cur_eip, target_ulong next_eip)
 {
     gen_update_cc_op(s);
-    gen_jmp_im(cur_eip);
+    gen_jmp_im(s, cur_eip);
     gen_helper_raise_interrupt(cpu_env, tcg_const_i32(intno),
                                tcg_const_i32(next_eip - cur_eip));
     s->base.is_jmp = DISAS_NORETURN;
@@ -2511,7 +2517,7 @@ static void gen_interrupt(DisasContext *s, int intno,
 static void gen_debug(DisasContext *s, target_ulong cur_eip)
 {
     gen_update_cc_op(s);
-    gen_jmp_im(cur_eip);
+    gen_jmp_im(s, cur_eip);
     gen_helper_debug(cpu_env);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -2621,7 +2627,7 @@ static void gen_jmp_tb(DisasContext *s, target_ulong eip, int tb_num)
     if (s->jmp_opt) {
         gen_goto_tb(s, tb_num, eip);
     } else {
-        gen_jmp_im(eip);
+        gen_jmp_im(s, eip);
         gen_eob(s);
     }
 }
@@ -2648,8 +2654,8 @@ static inline void gen_ldo_env_A0(DisasContext *s, int offset)
     int mem_index = s->mem_index;
     tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0, mem_index, MO_LEQ);
     tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(0)));
-    tcg_gen_addi_tl(cpu_tmp0, s->A0, 8);
-    tcg_gen_qemu_ld_i64(cpu_tmp1_i64, cpu_tmp0, mem_index, MO_LEQ);
+    tcg_gen_addi_tl(s->tmp0, s->A0, 8);
+    tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->tmp0, mem_index, MO_LEQ);
     tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(1)));
 }
 
@@ -2658,9 +2664,9 @@ static inline void gen_sto_env_A0(DisasContext *s, int offset)
     int mem_index = s->mem_index;
     tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(0)));
     tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0, mem_index, MO_LEQ);
-    tcg_gen_addi_tl(cpu_tmp0, s->A0, 8);
+    tcg_gen_addi_tl(s->tmp0, s->A0, 8);
     tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(1)));
-    tcg_gen_qemu_st_i64(cpu_tmp1_i64, cpu_tmp0, mem_index, MO_LEQ);
+    tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->tmp0, mem_index, MO_LEQ);
 }
 
 static inline void gen_op_movo(int d_offset, int s_offset)
@@ -3713,9 +3719,9 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                                         offsetof(ZMMReg, ZMM_L(0)));
                         break;
                     case 0x22: case 0x32: /* pmovsxbq, pmovzxbq */
-                        tcg_gen_qemu_ld_tl(cpu_tmp0, s->A0,
+                        tcg_gen_qemu_ld_tl(s->tmp0, s->A0,
                                            s->mem_index, MO_LEUW);
-                        tcg_gen_st16_tl(cpu_tmp0, cpu_env, op2_offset +
+                        tcg_gen_st16_tl(s->tmp0, cpu_env, op2_offset +
                                         offsetof(ZMMReg, ZMM_W(0)));
                         break;
                     case 0x2a:            /* movntqda */
@@ -3999,7 +4005,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                         if (s->cc_op != CC_OP_ADCX && s->cc_op != CC_OP_ADOX) {
                             gen_compute_eflags(s);
                         }
-                        carry_in = cpu_tmp0;
+                        carry_in = s->tmp0;
                         tcg_gen_extract_tl(carry_in, cpu_cc_src,
                                            ctz32(b == 0x1f6 ? CC_C : CC_O), 1);
                     }
@@ -4902,8 +4908,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 tcg_gen_mul_tl(s->T0, s->T0, s->T1);
                 gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
                 tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-                tcg_gen_ext8s_tl(cpu_tmp0, s->T0);
-                tcg_gen_sub_tl(cpu_cc_src, s->T0, cpu_tmp0);
+                tcg_gen_ext8s_tl(s->tmp0, s->T0);
+                tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
                 set_cc_op(s, CC_OP_MULB);
                 break;
             case MO_16:
@@ -4914,8 +4920,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 tcg_gen_mul_tl(s->T0, s->T0, s->T1);
                 gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
                 tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-                tcg_gen_ext16s_tl(cpu_tmp0, s->T0);
-                tcg_gen_sub_tl(cpu_cc_src, s->T0, cpu_tmp0);
+                tcg_gen_ext16s_tl(s->tmp0, s->T0);
+                tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
                 tcg_gen_shri_tl(s->T0, s->T0, 16);
                 gen_op_mov_reg_v(MO_16, R_EDX, s->T0);
                 set_cc_op(s, CC_OP_MULW);
@@ -5215,8 +5221,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             /* XXX: use 32 bit mul which could be faster */
             tcg_gen_mul_tl(s->T0, s->T0, s->T1);
             tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-            tcg_gen_ext16s_tl(cpu_tmp0, s->T0);
-            tcg_gen_sub_tl(cpu_cc_src, s->T0, cpu_tmp0);
+            tcg_gen_ext16s_tl(s->tmp0, s->T0);
+            tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
             gen_op_mov_reg_v(ot, reg, s->T0);
             break;
         }
@@ -5423,7 +5429,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_pop_update(s, ot);
         /* Note that reg == R_SS in gen_movl_seg_T0 always sets is_jmp.  */
         if (s->base.is_jmp) {
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             if (reg == R_SS) {
                 s->tf = 0;
                 gen_eob_inhibit_irq(s, true);
@@ -5438,7 +5444,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_movl_seg_T0(s, (b >> 3) & 7);
         gen_pop_update(s, ot);
         if (s->base.is_jmp) {
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
         }
         break;
@@ -5489,7 +5495,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_movl_seg_T0(s, reg);
         /* Note that reg == R_SS in gen_movl_seg_T0 always sets is_jmp.  */
         if (s->base.is_jmp) {
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             if (reg == R_SS) {
                 s->tf = 0;
                 gen_eob_inhibit_irq(s, true);
@@ -5696,7 +5702,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         /* then put the data */
         gen_op_mov_reg_v(ot, reg, s->T1);
         if (s->base.is_jmp) {
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
         }
         break;
@@ -6478,7 +6484,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     do_lret:
         if (s->pe && !s->vm86) {
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             gen_helper_lret_protected(cpu_env, tcg_const_i32(dflag - 1),
                                       tcg_const_i32(val));
         } else {
@@ -6691,7 +6697,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_pop_update(s, ot);
             set_cc_op(s, CC_OP_EFLAGS);
             /* abort translation because TF/AC flag may change */
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
         }
         break;
@@ -6779,9 +6785,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             AddressParts a = gen_lea_modrm_0(env, s, modrm);
             /* specific case: we need to add a displacement */
             gen_exts(ot, s->T1);
-            tcg_gen_sari_tl(cpu_tmp0, s->T1, 3 + ot);
-            tcg_gen_shli_tl(cpu_tmp0, cpu_tmp0, ot);
-            tcg_gen_add_tl(s->A0, gen_lea_modrm_1(s, a), cpu_tmp0);
+            tcg_gen_sari_tl(s->tmp0, s->T1, 3 + ot);
+            tcg_gen_shli_tl(s->tmp0, s->tmp0, ot);
+            tcg_gen_add_tl(s->A0, gen_lea_modrm_1(s, a), s->tmp0);
             gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
             if (!(s->prefix & PREFIX_LOCK)) {
                 gen_op_ld_v(s, ot, s->T0, s->A0);
@@ -6791,8 +6797,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
     bt_op:
         tcg_gen_andi_tl(s->T1, s->T1, (1 << (3 + ot)) - 1);
-        tcg_gen_movi_tl(cpu_tmp0, 1);
-        tcg_gen_shl_tl(cpu_tmp0, cpu_tmp0, s->T1);
+        tcg_gen_movi_tl(s->tmp0, 1);
+        tcg_gen_shl_tl(s->tmp0, s->tmp0, s->T1);
         if (s->prefix & PREFIX_LOCK) {
             switch (op) {
             case 0: /* bt */
@@ -6801,17 +6807,17 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_op_ld_v(s, ot, s->T0, s->A0);
                 break;
             case 1: /* bts */
-                tcg_gen_atomic_fetch_or_tl(s->T0, s->A0, cpu_tmp0,
+                tcg_gen_atomic_fetch_or_tl(s->T0, s->A0, s->tmp0,
                                            s->mem_index, ot | MO_LE);
                 break;
             case 2: /* btr */
-                tcg_gen_not_tl(cpu_tmp0, cpu_tmp0);
-                tcg_gen_atomic_fetch_and_tl(s->T0, s->A0, cpu_tmp0,
+                tcg_gen_not_tl(s->tmp0, s->tmp0);
+                tcg_gen_atomic_fetch_and_tl(s->T0, s->A0, s->tmp0,
                                             s->mem_index, ot | MO_LE);
                 break;
             default:
             case 3: /* btc */
-                tcg_gen_atomic_fetch_xor_tl(s->T0, s->A0, cpu_tmp0,
+                tcg_gen_atomic_fetch_xor_tl(s->T0, s->A0, s->tmp0,
                                             s->mem_index, ot | MO_LE);
                 break;
             }
@@ -6823,14 +6829,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 /* Data already loaded; nothing to do.  */
                 break;
             case 1: /* bts */
-                tcg_gen_or_tl(s->T0, s->T0, cpu_tmp0);
+                tcg_gen_or_tl(s->T0, s->T0, s->tmp0);
                 break;
             case 2: /* btr */
-                tcg_gen_andc_tl(s->T0, s->T0, cpu_tmp0);
+                tcg_gen_andc_tl(s->T0, s->T0, s->tmp0);
                 break;
             default:
             case 3: /* btc */
-                tcg_gen_xor_tl(s->T0, s->T0, cpu_tmp0);
+                tcg_gen_xor_tl(s->T0, s->T0, s->tmp0);
                 break;
             }
             if (op != 0) {
@@ -6983,7 +6989,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         if (prefixes & PREFIX_REPZ) {
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             gen_helper_pause(cpu_env, tcg_const_i32(s->pc - pc_start));
             s->base.is_jmp = DISAS_NORETURN;
         }
@@ -7011,7 +7017,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (CODE64(s))
             goto illegal_op;
         gen_update_cc_op(s);
-        gen_jmp_im(pc_start - s->cs_base);
+        gen_jmp_im(s, pc_start - s->cs_base);
         gen_helper_into(cpu_env, tcg_const_i32(s->pc - pc_start));
         break;
 #ifdef WANT_ICEBP
@@ -7045,7 +7051,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->vm86 ? s->iopl == 3 : s->cpl <= s->iopl) {
             gen_helper_sti(cpu_env);
             /* interruptions are enabled only the first insn after sti */
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob_inhibit_irq(s, true);
         } else {
             gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
@@ -7113,26 +7119,26 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             switch(b) {
             case 0: /* loopnz */
             case 1: /* loopz */
-                gen_op_add_reg_im(s->aflag, R_ECX, -1);
-                gen_op_jz_ecx(s->aflag, l3);
+                gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
+                gen_op_jz_ecx(s, s->aflag, l3);
                 gen_jcc1(s, (JCC_Z << 1) | (b ^ 1), l1);
                 break;
             case 2: /* loop */
-                gen_op_add_reg_im(s->aflag, R_ECX, -1);
-                gen_op_jnz_ecx(s->aflag, l1);
+                gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
+                gen_op_jnz_ecx(s, s->aflag, l1);
                 break;
             default:
             case 3: /* jcxz */
-                gen_op_jz_ecx(s->aflag, l1);
+                gen_op_jz_ecx(s, s->aflag, l1);
                 break;
             }
 
             gen_set_label(l3);
-            gen_jmp_im(next_eip);
+            gen_jmp_im(s, next_eip);
             tcg_gen_br(l2);
 
             gen_set_label(l1);
-            gen_jmp_im(tval);
+            gen_jmp_im(s, tval);
             gen_set_label(l2);
             gen_eob(s);
         }
@@ -7143,7 +7149,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
         } else {
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             if (b & 2) {
                 gen_helper_rdmsr(cpu_env);
             } else {
@@ -7153,7 +7159,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x131: /* rdtsc */
         gen_update_cc_op(s);
-        gen_jmp_im(pc_start - s->cs_base);
+        gen_jmp_im(s, pc_start - s->cs_base);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
@@ -7165,7 +7171,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x133: /* rdpmc */
         gen_update_cc_op(s);
-        gen_jmp_im(pc_start - s->cs_base);
+        gen_jmp_im(s, pc_start - s->cs_base);
         gen_helper_rdpmc(cpu_env);
         break;
     case 0x134: /* sysenter */
@@ -7194,7 +7200,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x105: /* syscall */
         /* XXX: is it usable in real mode ? */
         gen_update_cc_op(s);
-        gen_jmp_im(pc_start - s->cs_base);
+        gen_jmp_im(s, pc_start - s->cs_base);
         gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - pc_start));
         /* TF handling for the syscall insn is different. The TF bit is  checked
            after the syscall insn completes. This allows #DB to not be
@@ -7220,7 +7226,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 #endif
     case 0x1a2: /* cpuid */
         gen_update_cc_op(s);
-        gen_jmp_im(pc_start - s->cs_base);
+        gen_jmp_im(s, pc_start - s->cs_base);
         gen_helper_cpuid(cpu_env);
         break;
     case 0xf4: /* hlt */
@@ -7228,7 +7234,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
         } else {
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             gen_helper_hlt(cpu_env, tcg_const_i32(s->pc - pc_start));
             s->base.is_jmp = DISAS_NORETURN;
         }
@@ -7320,7 +7326,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             tcg_gen_mov_tl(s->A0, cpu_regs[R_EAX]);
             gen_extu(s->aflag, s->A0);
             gen_add_A0_ds_seg(s);
@@ -7332,7 +7338,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             gen_helper_mwait(cpu_env, tcg_const_i32(s->pc - pc_start));
             gen_eob(s);
             break;
@@ -7343,7 +7349,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_helper_clac(cpu_env);
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
             break;
 
@@ -7353,7 +7359,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_helper_stac(cpu_env);
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
             break;
 
@@ -7396,7 +7402,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[R_ECX]);
             gen_helper_xsetbv(cpu_env, cpu_tmp2_i32, cpu_tmp1_i64);
             /* End TB because translation flags may change.  */
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
             break;
 
@@ -7409,7 +7415,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             gen_helper_vmrun(cpu_env, tcg_const_i32(s->aflag - 1),
                              tcg_const_i32(s->pc - pc_start));
             tcg_gen_exit_tb(NULL, 0);
@@ -7421,7 +7427,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             gen_helper_vmmcall(cpu_env);
             break;
 
@@ -7434,7 +7440,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             gen_helper_vmload(cpu_env, tcg_const_i32(s->aflag - 1));
             break;
 
@@ -7447,7 +7453,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             gen_helper_vmsave(cpu_env, tcg_const_i32(s->aflag - 1));
             break;
 
@@ -7463,7 +7469,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             gen_update_cc_op(s);
             gen_helper_stgi(cpu_env);
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
             break;
 
@@ -7476,7 +7482,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             gen_helper_clgi(cpu_env);
             break;
 
@@ -7487,7 +7493,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             gen_helper_skinit(cpu_env);
             break;
 
@@ -7500,7 +7506,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             gen_helper_invlpga(cpu_env, tcg_const_i32(s->aflag - 1));
             break;
 
@@ -7574,7 +7580,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_CR0);
             gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
             gen_helper_lmsw(cpu_env, s->T0);
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
             break;
 
@@ -7584,10 +7590,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             gen_lea_modrm(env, s, modrm);
             gen_helper_invlpg(cpu_env, s->A0);
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
             break;
 
@@ -7613,7 +7619,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
+            gen_jmp_im(s, pc_start - s->cs_base);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                 gen_io_start();
             }
@@ -7688,11 +7694,11 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 a0 = NULL;
             }
             gen_op_mov_v_reg(ot, t1, reg);
-            tcg_gen_andi_tl(cpu_tmp0, t0, 3);
+            tcg_gen_andi_tl(s->tmp0, t0, 3);
             tcg_gen_andi_tl(t1, t1, 3);
             tcg_gen_movi_tl(t2, 0);
             label1 = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GE, cpu_tmp0, t1, label1);
+            tcg_gen_brcond_tl(TCG_COND_GE, s->tmp0, t1, label1);
             tcg_gen_andi_tl(t0, t0, ~3);
             tcg_gen_or_tl(t0, t0, t1);
             tcg_gen_movi_tl(t2, CC_Z);
@@ -7729,9 +7735,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             } else {
                 gen_helper_lsl(t0, cpu_env, s->T0);
             }
-            tcg_gen_andi_tl(cpu_tmp0, cpu_cc_src, CC_Z);
+            tcg_gen_andi_tl(s->tmp0, cpu_cc_src, CC_Z);
             label1 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_tmp0, 0, label1);
+            tcg_gen_brcondi_tl(TCG_COND_EQ, s->tmp0, 0, label1);
             gen_op_mov_reg_v(ot, reg, t0);
             gen_set_label(label1);
             set_cc_op(s, CC_OP_EFLAGS);
@@ -7981,7 +7987,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             case 4:
             case 8:
                 gen_update_cc_op(s);
-                gen_jmp_im(pc_start - s->cs_base);
+                gen_jmp_im(s, pc_start - s->cs_base);
                 if (b & 2) {
                     if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                         gen_io_start();
@@ -7992,7 +7998,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                         gen_io_end();
                     }
-                    gen_jmp_im(s->pc - s->cs_base);
+                    gen_jmp_im(s, s->pc - s->cs_base);
                     gen_eob(s);
                 } else {
                     if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
@@ -8035,7 +8041,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_op_mov_v_reg(ot, s->T0, rm);
                 tcg_gen_movi_i32(cpu_tmp2_i32, reg);
                 gen_helper_set_dr(cpu_env, cpu_tmp2_i32, s->T0);
-                gen_jmp_im(s->pc - s->cs_base);
+                gen_jmp_im(s, s->pc - s->cs_base);
                 gen_eob(s);
             } else {
                 gen_svm_check_intercept(s, pc_start, SVM_EXIT_READ_DR0 + reg);
@@ -8052,7 +8058,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_CR0);
             gen_helper_clts(cpu_env);
             /* abort block because static cpu state changed */
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
         }
         break;
@@ -8149,7 +8155,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             /* XRSTOR is how MPX is enabled, which changes how
                we translate.  Thus we need to end the TB.  */
             gen_update_cc_op(s);
-            gen_jmp_im(s->pc - s->cs_base);
+            gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
             break;
 
@@ -8279,7 +8285,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (!(s->flags & HF_SMM_MASK))
             goto illegal_op;
         gen_update_cc_op(s);
-        gen_jmp_im(s->pc - s->cs_base);
+        gen_jmp_im(s, s->pc - s->cs_base);
         gen_helper_rsm(cpu_env);
         gen_eob(s);
         break;
@@ -8473,7 +8479,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->T1 = tcg_temp_new();
     dc->A0 = tcg_temp_new();
 
-    cpu_tmp0 = tcg_temp_new();
+    dc->tmp0 = tcg_temp_new();
     cpu_tmp1_i64 = tcg_temp_new_i64();
     cpu_tmp2_i32 = tcg_temp_new_i32();
     cpu_tmp3_i32 = tcg_temp_new_i32();
@@ -8550,7 +8556,7 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     if (dc->base.is_jmp == DISAS_TOO_MANY) {
-        gen_jmp_im(dc->base.pc_next - dc->cs_base);
+        gen_jmp_im(dc, dc->base.pc_next - dc->cs_base);
         gen_eob(dc);
     }
 }
-- 
2.17.1
