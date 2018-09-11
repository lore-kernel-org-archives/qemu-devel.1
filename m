Received: from eggs.gnu.org ([2001:4830:134:3::10]:58687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGy-0000QR-Vl
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGu-0002Xv-8e
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46231)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzpGt-0002XR-NM
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Sep 2018 16:28:19 -0400
Message-Id: <20180911202823.21657-10-cota@braap.org>
In-Reply-To: <20180911202823.21657-1-cota@braap.org>
References: <20180911202823.21657-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 09/13] target/i386: move cpu_tmp2_i32 to
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
 target/i386/translate.c | 347 ++++++++++++++++++++--------------------
 1 file changed, 174 insertions(+), 173 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index c51f61ca2c..ec68f7dba1 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -79,7 +79,7 @@ static TCGv cpu_seg_base[6];
 static TCGv_i64 cpu_bndl[4];
 static TCGv_i64 cpu_bndu[4];
 
-static TCGv_i32 cpu_tmp2_i32, cpu_tmp3_i32;
+static TCGv_i32 cpu_tmp3_i32;
 static TCGv_i64 cpu_tmp1_i64;
 
 #include "exec/gen-icount.h"
@@ -142,6 +142,7 @@ typedef struct DisasContext {
     TCGv tmp4;
     TCGv_ptr ptr0;
     TCGv_ptr ptr1;
+    TCGv_i32 tmp2_i32;
 
     sigjmp_buf jmpbuf;
 } DisasContext;
@@ -617,16 +618,16 @@ static void gen_check_io(DisasContext *s, TCGMemOp ot, target_ulong cur_eip,
     target_ulong next_eip;
 
     if (s->pe && (s->cpl > s->iopl || s->vm86)) {
-        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
         switch (ot) {
         case MO_8:
-            gen_helper_check_iob(cpu_env, cpu_tmp2_i32);
+            gen_helper_check_iob(cpu_env, s->tmp2_i32);
             break;
         case MO_16:
-            gen_helper_check_iow(cpu_env, cpu_tmp2_i32);
+            gen_helper_check_iow(cpu_env, s->tmp2_i32);
             break;
         case MO_32:
-            gen_helper_check_iol(cpu_env, cpu_tmp2_i32);
+            gen_helper_check_iol(cpu_env, s->tmp2_i32);
             break;
         default:
             tcg_abort();
@@ -637,8 +638,8 @@ static void gen_check_io(DisasContext *s, TCGMemOp ot, target_ulong cur_eip,
         gen_jmp_im(s, cur_eip);
         svm_flags |= (1 << (4 + ot));
         next_eip = s->pc - s->cs_base;
-        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-        gen_helper_svm_check_io(cpu_env, cpu_tmp2_i32,
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+        gen_helper_svm_check_io(cpu_env, s->tmp2_i32,
                                 tcg_const_i32(svm_flags),
                                 tcg_const_i32(next_eip - cur_eip));
     }
@@ -1136,13 +1137,13 @@ static inline void gen_ins(DisasContext *s, TCGMemOp ot)
        case of page fault. */
     tcg_gen_movi_tl(s->T0, 0);
     gen_op_st_v(s, ot, s->T0, s->A0);
-    tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[R_EDX]);
-    tcg_gen_andi_i32(cpu_tmp2_i32, cpu_tmp2_i32, 0xffff);
-    gen_helper_in_func(ot, s->T0, cpu_tmp2_i32);
+    tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
+    tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
+    gen_helper_in_func(ot, s->T0, s->tmp2_i32);
     gen_op_st_v(s, ot, s->T0, s->A0);
     gen_op_movl_T0_Dshift(s, ot);
     gen_op_add_reg_T0(s, s->aflag, R_EDI);
-    gen_bpt_io(s, cpu_tmp2_i32, ot);
+    gen_bpt_io(s, s->tmp2_i32, ot);
     if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
@@ -1156,13 +1157,13 @@ static inline void gen_outs(DisasContext *s, TCGMemOp ot)
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
 
-    tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[R_EDX]);
-    tcg_gen_andi_i32(cpu_tmp2_i32, cpu_tmp2_i32, 0xffff);
+    tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
+    tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
     tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T0);
-    gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
+    gen_helper_out_func(ot, s->tmp2_i32, cpu_tmp3_i32);
     gen_op_movl_T0_Dshift(s, ot);
     gen_op_add_reg_T0(s, s->aflag, R_ESI);
-    gen_bpt_io(s, cpu_tmp2_i32, ot);
+    gen_bpt_io(s, s->tmp2_i32, ot);
     if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
@@ -1421,7 +1422,7 @@ static void gen_shift_flags(DisasContext *s, TCGMemOp ot, TCGv result,
     tcg_temp_free(z_tl);
 
     /* Get the two potential CC_OP values into temporaries.  */
-    tcg_gen_movi_i32(cpu_tmp2_i32, (is_right ? CC_OP_SARB : CC_OP_SHLB) + ot);
+    tcg_gen_movi_i32(s->tmp2_i32, (is_right ? CC_OP_SARB : CC_OP_SHLB) + ot);
     if (s->cc_op == CC_OP_DYNAMIC) {
         oldop = cpu_cc_op;
     } else {
@@ -1433,7 +1434,7 @@ static void gen_shift_flags(DisasContext *s, TCGMemOp ot, TCGv result,
     z32 = tcg_const_i32(0);
     s32 = tcg_temp_new_i32();
     tcg_gen_trunc_tl_i32(s32, count);
-    tcg_gen_movcond_i32(TCG_COND_NE, cpu_cc_op, s32, z32, cpu_tmp2_i32, oldop);
+    tcg_gen_movcond_i32(TCG_COND_NE, cpu_cc_op, s32, z32, s->tmp2_i32, oldop);
     tcg_temp_free_i32(z32);
     tcg_temp_free_i32(s32);
 
@@ -1544,14 +1545,14 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp ot, int op1, int is_right)
     do_long:
 #ifdef TARGET_X86_64
     case MO_32:
-        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T1);
         if (is_right) {
-            tcg_gen_rotr_i32(cpu_tmp2_i32, cpu_tmp2_i32, cpu_tmp3_i32);
+            tcg_gen_rotr_i32(s->tmp2_i32, s->tmp2_i32, cpu_tmp3_i32);
         } else {
-            tcg_gen_rotl_i32(cpu_tmp2_i32, cpu_tmp2_i32, cpu_tmp3_i32);
+            tcg_gen_rotl_i32(s->tmp2_i32, s->tmp2_i32, cpu_tmp3_i32);
         }
-        tcg_gen_extu_i32_tl(s->T0, cpu_tmp2_i32);
+        tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
         break;
 #endif
     default:
@@ -1591,10 +1592,10 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp ot, int op1, int is_right)
     t0 = tcg_const_i32(0);
     t1 = tcg_temp_new_i32();
     tcg_gen_trunc_tl_i32(t1, s->T1);
-    tcg_gen_movi_i32(cpu_tmp2_i32, CC_OP_ADCOX); 
+    tcg_gen_movi_i32(s->tmp2_i32, CC_OP_ADCOX);
     tcg_gen_movi_i32(cpu_tmp3_i32, CC_OP_EFLAGS);
     tcg_gen_movcond_i32(TCG_COND_NE, cpu_cc_op, t1, t0,
-                        cpu_tmp2_i32, cpu_tmp3_i32);
+                        s->tmp2_i32, cpu_tmp3_i32);
     tcg_temp_free_i32(t0);
     tcg_temp_free_i32(t1);
 
@@ -1620,13 +1621,13 @@ static void gen_rot_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2,
         switch (ot) {
 #ifdef TARGET_X86_64
         case MO_32:
-            tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
+            tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
             if (is_right) {
-                tcg_gen_rotri_i32(cpu_tmp2_i32, cpu_tmp2_i32, op2);
+                tcg_gen_rotri_i32(s->tmp2_i32, s->tmp2_i32, op2);
             } else {
-                tcg_gen_rotli_i32(cpu_tmp2_i32, cpu_tmp2_i32, op2);
+                tcg_gen_rotli_i32(s->tmp2_i32, s->tmp2_i32, op2);
             }
-            tcg_gen_extu_i32_tl(s->T0, cpu_tmp2_i32);
+            tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
             break;
 #endif
         default:
@@ -2111,8 +2112,8 @@ static void gen_bndck(CPUX86State *env, DisasContext *s, int modrm,
         tcg_gen_ext32u_i64(cpu_tmp1_i64, cpu_tmp1_i64);
     }
     tcg_gen_setcond_i64(cond, cpu_tmp1_i64, cpu_tmp1_i64, bndv);
-    tcg_gen_extrl_i64_i32(cpu_tmp2_i32, cpu_tmp1_i64);
-    gen_helper_bndck(cpu_env, cpu_tmp2_i32);
+    tcg_gen_extrl_i64_i32(s->tmp2_i32, cpu_tmp1_i64);
+    gen_helper_bndck(cpu_env, s->tmp2_i32);
 }
 
 /* used for LEA and MOV AX, mem */
@@ -2289,8 +2290,8 @@ static inline void gen_op_movl_seg_T0_vm(DisasContext *s, int seg_reg)
 static void gen_movl_seg_T0(DisasContext *s, int seg_reg)
 {
     if (s->pe && !s->vm86) {
-        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-        gen_helper_load_seg(cpu_env, tcg_const_i32(seg_reg), cpu_tmp2_i32);
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+        gen_helper_load_seg(cpu_env, tcg_const_i32(seg_reg), s->tmp2_i32);
         /* abort translation because the addseg value may change or
            because ss32 may change. For R_SS, translation must always
            stop as a special handling must be done to disable hardware
@@ -2684,10 +2685,10 @@ static inline void gen_op_movq(int d_offset, int s_offset)
     tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, d_offset);
 }
 
-static inline void gen_op_movl(int d_offset, int s_offset)
+static inline void gen_op_movl(DisasContext *s, int d_offset, int s_offset)
 {
-    tcg_gen_ld_i32(cpu_tmp2_i32, cpu_env, s_offset);
-    tcg_gen_st_i32(cpu_tmp2_i32, cpu_env, d_offset);
+    tcg_gen_ld_i32(s->tmp2_i32, cpu_env, s_offset);
+    tcg_gen_st_i32(s->tmp2_i32, cpu_env, d_offset);
 }
 
 static inline void gen_op_movq_env_0(int d_offset)
@@ -3150,8 +3151,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 0);
                 tcg_gen_addi_ptr(s->ptr0, cpu_env,
                                  offsetof(CPUX86State,fpregs[reg].mmx));
-                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-                gen_helper_movl_mm_T0_mmx(s->ptr0, cpu_tmp2_i32);
+                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+                gen_helper_movl_mm_T0_mmx(s->ptr0, s->tmp2_i32);
             }
             break;
         case 0x16e: /* movd xmm, ea */
@@ -3167,8 +3168,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 0);
                 tcg_gen_addi_ptr(s->ptr0, cpu_env,
                                  offsetof(CPUX86State,xmm_regs[reg]));
-                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-                gen_helper_movl_mm_T0_xmm(s->ptr0, cpu_tmp2_i32);
+                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+                gen_helper_movl_mm_T0_xmm(s->ptr0, s->tmp2_i32);
             }
             break;
         case 0x6f: /* movq mm, ea */
@@ -3213,7 +3214,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                                 offsetof(CPUX86State, xmm_regs[reg].ZMM_L(3)));
             } else {
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movl(offsetof(CPUX86State,xmm_regs[reg].ZMM_L(0)),
+                gen_op_movl(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_L(0)),
                             offsetof(CPUX86State,xmm_regs[rm].ZMM_L(0)));
             }
             break;
@@ -3252,14 +3253,14 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 gen_ldo_env_A0(s, offsetof(CPUX86State, xmm_regs[reg]));
             } else {
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movl(offsetof(CPUX86State,xmm_regs[reg].ZMM_L(0)),
+                gen_op_movl(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_L(0)),
                             offsetof(CPUX86State,xmm_regs[rm].ZMM_L(0)));
-                gen_op_movl(offsetof(CPUX86State,xmm_regs[reg].ZMM_L(2)),
+                gen_op_movl(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_L(2)),
                             offsetof(CPUX86State,xmm_regs[rm].ZMM_L(2)));
             }
-            gen_op_movl(offsetof(CPUX86State,xmm_regs[reg].ZMM_L(1)),
+            gen_op_movl(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_L(1)),
                         offsetof(CPUX86State,xmm_regs[reg].ZMM_L(0)));
-            gen_op_movl(offsetof(CPUX86State,xmm_regs[reg].ZMM_L(3)),
+            gen_op_movl(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_L(3)),
                         offsetof(CPUX86State,xmm_regs[reg].ZMM_L(2)));
             break;
         case 0x312: /* movddup */
@@ -3294,14 +3295,14 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 gen_ldo_env_A0(s, offsetof(CPUX86State, xmm_regs[reg]));
             } else {
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movl(offsetof(CPUX86State,xmm_regs[reg].ZMM_L(1)),
+                gen_op_movl(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_L(1)),
                             offsetof(CPUX86State,xmm_regs[rm].ZMM_L(1)));
-                gen_op_movl(offsetof(CPUX86State,xmm_regs[reg].ZMM_L(3)),
+                gen_op_movl(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_L(3)),
                             offsetof(CPUX86State,xmm_regs[rm].ZMM_L(3)));
             }
-            gen_op_movl(offsetof(CPUX86State,xmm_regs[reg].ZMM_L(0)),
+            gen_op_movl(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_L(0)),
                         offsetof(CPUX86State,xmm_regs[reg].ZMM_L(1)));
-            gen_op_movl(offsetof(CPUX86State,xmm_regs[reg].ZMM_L(2)),
+            gen_op_movl(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_L(2)),
                         offsetof(CPUX86State,xmm_regs[reg].ZMM_L(3)));
             break;
         case 0x178:
@@ -3398,7 +3399,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 gen_op_st_v(s, MO_32, s->T0, s->A0);
             } else {
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movl(offsetof(CPUX86State,xmm_regs[rm].ZMM_L(0)),
+                gen_op_movl(s, offsetof(CPUX86State, xmm_regs[rm].ZMM_L(0)),
                             offsetof(CPUX86State,xmm_regs[reg].ZMM_L(0)));
             }
             break;
@@ -3480,15 +3481,15 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             rm = (modrm & 7) | REX_B(s);
             tcg_gen_addi_ptr(s->ptr0, cpu_env,
                              offsetof(CPUX86State,xmm_regs[rm]));
-            gen_helper_movmskps(cpu_tmp2_i32, cpu_env, s->ptr0);
-            tcg_gen_extu_i32_tl(cpu_regs[reg], cpu_tmp2_i32);
+            gen_helper_movmskps(s->tmp2_i32, cpu_env, s->ptr0);
+            tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp2_i32);
             break;
         case 0x150: /* movmskpd */
             rm = (modrm & 7) | REX_B(s);
             tcg_gen_addi_ptr(s->ptr0, cpu_env,
                              offsetof(CPUX86State,xmm_regs[rm]));
-            gen_helper_movmskpd(cpu_tmp2_i32, cpu_env, s->ptr0);
-            tcg_gen_extu_i32_tl(cpu_regs[reg], cpu_tmp2_i32);
+            gen_helper_movmskpd(s->tmp2_i32, cpu_env, s->ptr0);
+            tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp2_i32);
             break;
         case 0x02a: /* cvtpi2ps */
         case 0x12a: /* cvtpi2pd */
@@ -3522,8 +3523,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
             if (ot == MO_32) {
                 SSEFunc_0_epi sse_fn_epi = sse_op_table3ai[(b >> 8) & 1];
-                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-                sse_fn_epi(cpu_env, s->ptr0, cpu_tmp2_i32);
+                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+                sse_fn_epi(cpu_env, s->ptr0, s->tmp2_i32);
             } else {
 #ifdef TARGET_X86_64
                 SSEFunc_0_epl sse_fn_epl = sse_op_table3aq[(b >> 8) & 1];
@@ -3587,8 +3588,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             if (ot == MO_32) {
                 SSEFunc_i_ep sse_fn_i_ep =
                     sse_op_table3bi[((b >> 7) & 2) | (b & 1)];
-                sse_fn_i_ep(cpu_tmp2_i32, cpu_env, s->ptr0);
-                tcg_gen_extu_i32_tl(s->T0, cpu_tmp2_i32);
+                sse_fn_i_ep(s->tmp2_i32, cpu_env, s->ptr0);
+                tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
             } else {
 #ifdef TARGET_X86_64
                 SSEFunc_l_ep sse_fn_l_ep =
@@ -3668,15 +3669,15 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 rm = (modrm & 7) | REX_B(s);
                 tcg_gen_addi_ptr(s->ptr0, cpu_env,
                                  offsetof(CPUX86State, xmm_regs[rm]));
-                gen_helper_pmovmskb_xmm(cpu_tmp2_i32, cpu_env, s->ptr0);
+                gen_helper_pmovmskb_xmm(s->tmp2_i32, cpu_env, s->ptr0);
             } else {
                 rm = (modrm & 7);
                 tcg_gen_addi_ptr(s->ptr0, cpu_env,
                                  offsetof(CPUX86State, fpregs[rm].mmx));
-                gen_helper_pmovmskb_mmx(cpu_tmp2_i32, cpu_env, s->ptr0);
+                gen_helper_pmovmskb_mmx(s->tmp2_i32, cpu_env, s->ptr0);
             }
             reg = ((modrm >> 3) & 7) | rex_r;
-            tcg_gen_extu_i32_tl(cpu_regs[reg], cpu_tmp2_i32);
+            tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp2_i32);
             break;
 
         case 0x138:
@@ -3716,9 +3717,9 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                         break;
                     case 0x21: case 0x31: /* pmovsxbd, pmovzxbd */
                     case 0x24: case 0x34: /* pmovsxwq, pmovzxwq */
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
+                        tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
-                        tcg_gen_st_i32(cpu_tmp2_i32, cpu_env, op2_offset +
+                        tcg_gen_st_i32(s->tmp2_i32, cpu_env, op2_offset +
                                         offsetof(ZMMReg, ZMM_L(0)));
                         break;
                     case 0x22: case 0x32: /* pmovsxbq, pmovzxbq */
@@ -3780,9 +3781,9 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     ot = MO_64;
                 }
 
-                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[reg]);
+                tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[reg]);
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-                gen_helper_crc32(s->T0, cpu_tmp2_i32,
+                gen_helper_crc32(s->T0, s->tmp2_i32,
                                  s->T0, tcg_const_i32(8 << ot));
 
                 ot = mo_64_32(s->dflag);
@@ -3910,11 +3911,11 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
                 switch (ot) {
                 default:
-                    tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
+                    tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                     tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_regs[R_EDX]);
-                    tcg_gen_mulu2_i32(cpu_tmp2_i32, cpu_tmp3_i32,
-                                      cpu_tmp2_i32, cpu_tmp3_i32);
-                    tcg_gen_extu_i32_tl(cpu_regs[s->vex_v], cpu_tmp2_i32);
+                    tcg_gen_mulu2_i32(s->tmp2_i32, cpu_tmp3_i32,
+                                      s->tmp2_i32, cpu_tmp3_i32);
+                    tcg_gen_extu_i32_tl(cpu_regs[s->vex_v], s->tmp2_i32);
                     tcg_gen_extu_i32_tl(cpu_regs[reg], cpu_tmp3_i32);
                     break;
 #ifdef TARGET_X86_64
@@ -4162,13 +4163,13 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     break;
                 case 0x16:
                     if (ot == MO_32) { /* pextrd */
-                        tcg_gen_ld_i32(cpu_tmp2_i32, cpu_env,
+                        tcg_gen_ld_i32(s->tmp2_i32, cpu_env,
                                         offsetof(CPUX86State,
                                                 xmm_regs[reg].ZMM_L(val & 3)));
                         if (mod == 3) {
-                            tcg_gen_extu_i32_tl(cpu_regs[rm], cpu_tmp2_i32);
+                            tcg_gen_extu_i32_tl(cpu_regs[rm], s->tmp2_i32);
                         } else {
-                            tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
+                            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUL);
                         }
                     } else { /* pextrq */
@@ -4209,14 +4210,14 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     break;
                 case 0x21: /* insertps */
                     if (mod == 3) {
-                        tcg_gen_ld_i32(cpu_tmp2_i32, cpu_env,
+                        tcg_gen_ld_i32(s->tmp2_i32, cpu_env,
                                         offsetof(CPUX86State,xmm_regs[rm]
                                                 .ZMM_L((val >> 6) & 3)));
                     } else {
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
+                        tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                     }
-                    tcg_gen_st_i32(cpu_tmp2_i32, cpu_env,
+                    tcg_gen_st_i32(s->tmp2_i32, cpu_env,
                                     offsetof(CPUX86State,xmm_regs[reg]
                                             .ZMM_L((val >> 4) & 3)));
                     if ((val >> 0) & 1)
@@ -4239,12 +4240,12 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 case 0x22:
                     if (ot == MO_32) { /* pinsrd */
                         if (mod == 3) {
-                            tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[rm]);
+                            tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[rm]);
                         } else {
-                            tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
+                            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUL);
                         }
-                        tcg_gen_st_i32(cpu_tmp2_i32, cpu_env,
+                        tcg_gen_st_i32(s->tmp2_i32, cpu_env,
                                         offsetof(CPUX86State,
                                                 xmm_regs[reg].ZMM_L(val & 3)));
                     } else { /* pinsrq */
@@ -4321,9 +4322,9 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 if (ot == MO_64) {
                     tcg_gen_rotri_tl(s->T0, s->T0, b & 63);
                 } else {
-                    tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-                    tcg_gen_rotri_i32(cpu_tmp2_i32, cpu_tmp2_i32, b & 31);
-                    tcg_gen_extu_i32_tl(s->T0, cpu_tmp2_i32);
+                    tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+                    tcg_gen_rotri_i32(s->tmp2_i32, s->tmp2_i32, b & 31);
+                    tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
                 }
                 gen_op_mov_reg_v(ot, reg, s->T0);
                 break;
@@ -4880,11 +4881,11 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             default:
             case MO_32:
-                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
+                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_regs[R_EAX]);
-                tcg_gen_mulu2_i32(cpu_tmp2_i32, cpu_tmp3_i32,
-                                  cpu_tmp2_i32, cpu_tmp3_i32);
-                tcg_gen_extu_i32_tl(cpu_regs[R_EAX], cpu_tmp2_i32);
+                tcg_gen_mulu2_i32(s->tmp2_i32, cpu_tmp3_i32,
+                                  s->tmp2_i32, cpu_tmp3_i32);
+                tcg_gen_extu_i32_tl(cpu_regs[R_EAX], s->tmp2_i32);
                 tcg_gen_extu_i32_tl(cpu_regs[R_EDX], cpu_tmp3_i32);
                 tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
                 tcg_gen_mov_tl(cpu_cc_src, cpu_regs[R_EDX]);
@@ -4931,16 +4932,16 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             default:
             case MO_32:
-                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
+                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_regs[R_EAX]);
-                tcg_gen_muls2_i32(cpu_tmp2_i32, cpu_tmp3_i32,
-                                  cpu_tmp2_i32, cpu_tmp3_i32);
-                tcg_gen_extu_i32_tl(cpu_regs[R_EAX], cpu_tmp2_i32);
+                tcg_gen_muls2_i32(s->tmp2_i32, cpu_tmp3_i32,
+                                  s->tmp2_i32, cpu_tmp3_i32);
+                tcg_gen_extu_i32_tl(cpu_regs[R_EAX], s->tmp2_i32);
                 tcg_gen_extu_i32_tl(cpu_regs[R_EDX], cpu_tmp3_i32);
-                tcg_gen_sari_i32(cpu_tmp2_i32, cpu_tmp2_i32, 31);
+                tcg_gen_sari_i32(s->tmp2_i32, s->tmp2_i32, 31);
                 tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
-                tcg_gen_sub_i32(cpu_tmp2_i32, cpu_tmp2_i32, cpu_tmp3_i32);
-                tcg_gen_extu_i32_tl(cpu_cc_src, cpu_tmp2_i32);
+                tcg_gen_sub_i32(s->tmp2_i32, s->tmp2_i32, cpu_tmp3_i32);
+                tcg_gen_extu_i32_tl(cpu_cc_src, s->tmp2_i32);
                 set_cc_op(s, CC_OP_MULL);
                 break;
 #ifdef TARGET_X86_64
@@ -5061,13 +5062,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_ld_v(s, MO_16, s->T0, s->A0);
         do_lcall:
             if (s->pe && !s->vm86) {
-                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-                gen_helper_lcall_protected(cpu_env, cpu_tmp2_i32, s->T1,
+                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+                gen_helper_lcall_protected(cpu_env, s->tmp2_i32, s->T1,
                                            tcg_const_i32(dflag - 1),
                                            tcg_const_tl(s->pc - s->cs_base));
             } else {
-                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-                gen_helper_lcall_real(cpu_env, cpu_tmp2_i32, s->T1,
+                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+                gen_helper_lcall_real(cpu_env, s->tmp2_i32, s->T1,
                                       tcg_const_i32(dflag - 1),
                                       tcg_const_i32(s->pc - s->cs_base));
             }
@@ -5088,8 +5089,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_ld_v(s, MO_16, s->T0, s->A0);
         do_ljmp:
             if (s->pe && !s->vm86) {
-                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-                gen_helper_ljmp_protected(cpu_env, cpu_tmp2_i32, s->T1,
+                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+                gen_helper_ljmp_protected(cpu_env, s->tmp2_i32, s->T1,
                                           tcg_const_tl(s->pc - s->cs_base));
             } else {
                 gen_op_movl_seg_T0_vm(s, R_CS);
@@ -5208,15 +5209,15 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             break;
 #endif
         case MO_32:
-            tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
+            tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
             tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T1);
-            tcg_gen_muls2_i32(cpu_tmp2_i32, cpu_tmp3_i32,
-                              cpu_tmp2_i32, cpu_tmp3_i32);
-            tcg_gen_extu_i32_tl(cpu_regs[reg], cpu_tmp2_i32);
-            tcg_gen_sari_i32(cpu_tmp2_i32, cpu_tmp2_i32, 31);
+            tcg_gen_muls2_i32(s->tmp2_i32, cpu_tmp3_i32,
+                              s->tmp2_i32, cpu_tmp3_i32);
+            tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp2_i32);
+            tcg_gen_sari_i32(s->tmp2_i32, s->tmp2_i32, 31);
             tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[reg]);
-            tcg_gen_sub_i32(cpu_tmp2_i32, cpu_tmp2_i32, cpu_tmp3_i32);
-            tcg_gen_extu_i32_tl(cpu_cc_src, cpu_tmp2_i32);
+            tcg_gen_sub_i32(s->tmp2_i32, s->tmp2_i32, cpu_tmp3_i32);
+            tcg_gen_extu_i32_tl(cpu_cc_src, s->tmp2_i32);
             break;
         default:
             tcg_gen_ext16s_tl(s->T0, s->T0);
@@ -5820,14 +5821,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
                     switch(op >> 4) {
                     case 0:
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
+                        tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
-                        gen_helper_flds_FT0(cpu_env, cpu_tmp2_i32);
+                        gen_helper_flds_FT0(cpu_env, s->tmp2_i32);
                         break;
                     case 1:
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
+                        tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
-                        gen_helper_fildl_FT0(cpu_env, cpu_tmp2_i32);
+                        gen_helper_fildl_FT0(cpu_env, s->tmp2_i32);
                         break;
                     case 2:
                         tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0,
@@ -5836,9 +5837,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                         break;
                     case 3:
                     default:
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
+                        tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LESW);
-                        gen_helper_fildl_FT0(cpu_env, cpu_tmp2_i32);
+                        gen_helper_fildl_FT0(cpu_env, s->tmp2_i32);
                         break;
                     }
 
@@ -5859,14 +5860,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 case 0:
                     switch(op >> 4) {
                     case 0:
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
+                        tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
-                        gen_helper_flds_ST0(cpu_env, cpu_tmp2_i32);
+                        gen_helper_flds_ST0(cpu_env, s->tmp2_i32);
                         break;
                     case 1:
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
+                        tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
-                        gen_helper_fildl_ST0(cpu_env, cpu_tmp2_i32);
+                        gen_helper_fildl_ST0(cpu_env, s->tmp2_i32);
                         break;
                     case 2:
                         tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0,
@@ -5875,9 +5876,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                         break;
                     case 3:
                     default:
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
+                        tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LESW);
-                        gen_helper_fildl_ST0(cpu_env, cpu_tmp2_i32);
+                        gen_helper_fildl_ST0(cpu_env, s->tmp2_i32);
                         break;
                     }
                     break;
@@ -5885,8 +5886,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     /* XXX: the corresponding CPUID bit must be tested ! */
                     switch(op >> 4) {
                     case 1:
-                        gen_helper_fisttl_ST0(cpu_tmp2_i32, cpu_env);
-                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
+                        gen_helper_fisttl_ST0(s->tmp2_i32, cpu_env);
+                        tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                         break;
                     case 2:
@@ -5896,8 +5897,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                         break;
                     case 3:
                     default:
-                        gen_helper_fistt_ST0(cpu_tmp2_i32, cpu_env);
-                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
+                        gen_helper_fistt_ST0(s->tmp2_i32, cpu_env);
+                        tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUW);
                         break;
                     }
@@ -5906,13 +5907,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 default:
                     switch(op >> 4) {
                     case 0:
-                        gen_helper_fsts_ST0(cpu_tmp2_i32, cpu_env);
-                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
+                        gen_helper_fsts_ST0(s->tmp2_i32, cpu_env);
+                        tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                         break;
                     case 1:
-                        gen_helper_fistl_ST0(cpu_tmp2_i32, cpu_env);
-                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
+                        gen_helper_fistl_ST0(s->tmp2_i32, cpu_env);
+                        tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                         break;
                     case 2:
@@ -5922,8 +5923,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                         break;
                     case 3:
                     default:
-                        gen_helper_fist_ST0(cpu_tmp2_i32, cpu_env);
-                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
+                        gen_helper_fist_ST0(s->tmp2_i32, cpu_env);
+                        tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUW);
                         break;
                     }
@@ -5936,16 +5937,16 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_helper_fldenv(cpu_env, s->A0, tcg_const_i32(dflag - 1));
                 break;
             case 0x0d: /* fldcw mem */
-                tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
+                tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                     s->mem_index, MO_LEUW);
-                gen_helper_fldcw(cpu_env, cpu_tmp2_i32);
+                gen_helper_fldcw(cpu_env, s->tmp2_i32);
                 break;
             case 0x0e: /* fnstenv mem */
                 gen_helper_fstenv(cpu_env, s->A0, tcg_const_i32(dflag - 1));
                 break;
             case 0x0f: /* fnstcw mem */
-                gen_helper_fnstcw(cpu_tmp2_i32, cpu_env);
-                tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
+                gen_helper_fnstcw(s->tmp2_i32, cpu_env);
+                tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                     s->mem_index, MO_LEUW);
                 break;
             case 0x1d: /* fldt mem */
@@ -5962,8 +5963,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_helper_fsave(cpu_env, s->A0, tcg_const_i32(dflag - 1));
                 break;
             case 0x2f: /* fnstsw mem */
-                gen_helper_fnstsw(cpu_tmp2_i32, cpu_env);
-                tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
+                gen_helper_fnstsw(s->tmp2_i32, cpu_env);
+                tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                     s->mem_index, MO_LEUW);
                 break;
             case 0x3c: /* fbld */
@@ -6241,8 +6242,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             case 0x3c: /* df/4 */
                 switch(rm) {
                 case 0:
-                    gen_helper_fnstsw(cpu_tmp2_i32, cpu_env);
-                    tcg_gen_extu_i32_tl(s->T0, cpu_tmp2_i32);
+                    gen_helper_fnstsw(s->tmp2_i32, cpu_env);
+                    tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
                     gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
                     break;
                 default:
@@ -6394,10 +6395,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
-        tcg_gen_movi_i32(cpu_tmp2_i32, val);
-        gen_helper_in_func(ot, s->T1, cpu_tmp2_i32);
+        tcg_gen_movi_i32(s->tmp2_i32, val);
+        gen_helper_in_func(ot, s->T1, s->tmp2_i32);
         gen_op_mov_reg_v(ot, R_EAX, s->T1);
-        gen_bpt_io(s, cpu_tmp2_i32, ot);
+        gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
@@ -6415,10 +6416,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
-        tcg_gen_movi_i32(cpu_tmp2_i32, val);
+        tcg_gen_movi_i32(s->tmp2_i32, val);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T1);
-        gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
-        gen_bpt_io(s, cpu_tmp2_i32, ot);
+        gen_helper_out_func(ot, s->tmp2_i32, cpu_tmp3_i32);
+        gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
@@ -6433,10 +6434,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
-        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-        gen_helper_in_func(ot, s->T1, cpu_tmp2_i32);
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+        gen_helper_in_func(ot, s->T1, s->tmp2_i32);
         gen_op_mov_reg_v(ot, R_EAX, s->T1);
-        gen_bpt_io(s, cpu_tmp2_i32, ot);
+        gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
@@ -6453,10 +6454,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
-        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T1);
-        gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
-        gen_bpt_io(s, cpu_tmp2_i32, ot);
+        gen_helper_out_func(ot, s->tmp2_i32, cpu_tmp3_i32);
+        gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
@@ -6734,12 +6735,12 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         tcg_gen_ori_tl(cpu_cc_src, cpu_cc_src, CC_C);
         break;
     case 0xfc: /* cld */
-        tcg_gen_movi_i32(cpu_tmp2_i32, 1);
-        tcg_gen_st_i32(cpu_tmp2_i32, cpu_env, offsetof(CPUX86State, df));
+        tcg_gen_movi_i32(s->tmp2_i32, 1);
+        tcg_gen_st_i32(s->tmp2_i32, cpu_env, offsetof(CPUX86State, df));
         break;
     case 0xfd: /* std */
-        tcg_gen_movi_i32(cpu_tmp2_i32, -1);
-        tcg_gen_st_i32(cpu_tmp2_i32, cpu_env, offsetof(CPUX86State, df));
+        tcg_gen_movi_i32(s->tmp2_i32, -1);
+        tcg_gen_st_i32(s->tmp2_i32, cpu_env, offsetof(CPUX86State, df));
         break;
 
         /************************/
@@ -7071,11 +7072,11 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             goto illegal_op;
         gen_op_mov_v_reg(ot, s->T0, reg);
         gen_lea_modrm(env, s, modrm);
-        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
         if (ot == MO_16) {
-            gen_helper_boundw(cpu_env, s->A0, cpu_tmp2_i32);
+            gen_helper_boundw(cpu_env, s->A0, s->tmp2_i32);
         } else {
-            gen_helper_boundl(cpu_env, s->A0, cpu_tmp2_i32);
+            gen_helper_boundl(cpu_env, s->A0, s->tmp2_i32);
         }
         break;
     case 0x1c8 ... 0x1cf: /* bswap reg */
@@ -7264,8 +7265,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             } else {
                 gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_WRITE);
                 gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
-                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-                gen_helper_lldt(cpu_env, cpu_tmp2_i32);
+                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+                gen_helper_lldt(cpu_env, s->tmp2_i32);
             }
             break;
         case 1: /* str */
@@ -7285,8 +7286,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             } else {
                 gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_WRITE);
                 gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
-                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-                gen_helper_ltr(cpu_env, cpu_tmp2_i32);
+                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+                gen_helper_ltr(cpu_env, s->tmp2_i32);
             }
             break;
         case 4: /* verr */
@@ -7385,8 +7386,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                                  | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
-            tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_xgetbv(cpu_tmp1_i64, cpu_env, cpu_tmp2_i32);
+            tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
+            gen_helper_xgetbv(cpu_tmp1_i64, cpu_env, s->tmp2_i32);
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], cpu_tmp1_i64);
             break;
 
@@ -7402,8 +7403,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             tcg_gen_concat_tl_i64(cpu_tmp1_i64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
-            tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_xsetbv(cpu_env, cpu_tmp2_i32, cpu_tmp1_i64);
+            tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
+            gen_helper_xsetbv(cpu_env, s->tmp2_i32, cpu_tmp1_i64);
             /* End TB because translation flags may change.  */
             gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
@@ -7562,8 +7563,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (prefixes & PREFIX_LOCK) {
                 goto illegal_op;
             }
-            tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_rdpkru(cpu_tmp1_i64, cpu_env, cpu_tmp2_i32);
+            tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
+            gen_helper_rdpkru(cpu_tmp1_i64, cpu_env, s->tmp2_i32);
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], cpu_tmp1_i64);
             break;
         case 0xef: /* wrpkru */
@@ -7572,8 +7573,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             tcg_gen_concat_tl_i64(cpu_tmp1_i64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
-            tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_wrpkru(cpu_env, cpu_tmp2_i32, cpu_tmp1_i64);
+            tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
+            gen_helper_wrpkru(cpu_env, s->tmp2_i32, cpu_tmp1_i64);
             break;
         CASE_MODRM_OP(6): /* lmsw */
             if (s->cpl != 0) {
@@ -8042,14 +8043,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (b & 2) {
                 gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_DR0 + reg);
                 gen_op_mov_v_reg(ot, s->T0, rm);
-                tcg_gen_movi_i32(cpu_tmp2_i32, reg);
-                gen_helper_set_dr(cpu_env, cpu_tmp2_i32, s->T0);
+                tcg_gen_movi_i32(s->tmp2_i32, reg);
+                gen_helper_set_dr(cpu_env, s->tmp2_i32, s->T0);
                 gen_jmp_im(s, s->pc - s->cs_base);
                 gen_eob(s);
             } else {
                 gen_svm_check_intercept(s, pc_start, SVM_EXIT_READ_DR0 + reg);
-                tcg_gen_movi_i32(cpu_tmp2_i32, reg);
-                gen_helper_get_dr(s->T0, cpu_env, cpu_tmp2_i32);
+                tcg_gen_movi_i32(s->tmp2_i32, reg);
+                gen_helper_get_dr(s->T0, cpu_env, s->tmp2_i32);
                 gen_op_mov_reg_v(ot, rm, s->T0);
             }
         }
@@ -8116,8 +8117,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_lea_modrm(env, s, modrm);
-            tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0, s->mem_index, MO_LEUL);
-            gen_helper_ldmxcsr(cpu_env, cpu_tmp2_i32);
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0, s->mem_index, MO_LEUL);
+            gen_helper_ldmxcsr(cpu_env, s->tmp2_i32);
             break;
 
         CASE_MODRM_MEM_OP(3): /* stmxcsr */
@@ -8216,8 +8217,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 TCGv base, treg, src, dst;
 
                 /* Preserve hflags bits by testing CR4 at runtime.  */
-                tcg_gen_movi_i32(cpu_tmp2_i32, CR4_FSGSBASE_MASK);
-                gen_helper_cr4_testbit(cpu_env, cpu_tmp2_i32);
+                tcg_gen_movi_i32(s->tmp2_i32, CR4_FSGSBASE_MASK);
+                gen_helper_cr4_testbit(cpu_env, s->tmp2_i32);
 
                 base = cpu_seg_base[modrm & 8 ? R_GS : R_FS];
                 treg = cpu_regs[(modrm & 7) | REX_B(s)];
@@ -8484,7 +8485,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 
     dc->tmp0 = tcg_temp_new();
     cpu_tmp1_i64 = tcg_temp_new_i64();
-    cpu_tmp2_i32 = tcg_temp_new_i32();
+    dc->tmp2_i32 = tcg_temp_new_i32();
     cpu_tmp3_i32 = tcg_temp_new_i32();
     dc->tmp4 = tcg_temp_new();
     dc->ptr0 = tcg_temp_new_ptr();
-- 
2.17.1
