Received: from eggs.gnu.org ([2001:4830:134:3::10]:58676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGy-0000QM-Su
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGs-0002WK-AM
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzpGs-0002Vr-1E
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Sep 2018 16:28:12 -0400
Message-Id: <20180911202823.21657-3-cota@braap.org>
In-Reply-To: <20180911202823.21657-1-cota@braap.org>
References: <20180911202823.21657-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 02/13] target/i386: move cpu_A0 to
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
 target/i386/translate.c | 472 ++++++++++++++++++++--------------------
 1 file changed, 236 insertions(+), 236 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index e9f512472e..c6b1baab9d 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -72,7 +72,6 @@
 //#define MACRO_TEST   1
 
 /* global register indexes */
-static TCGv cpu_A0;
 static TCGv cpu_cc_dst, cpu_cc_src, cpu_cc_src2;
 static TCGv_i32 cpu_cc_op;
 static TCGv cpu_regs[CPU_NB_REGS];
@@ -138,6 +137,7 @@ typedef struct DisasContext {
 
     /* TCG local temps */
     TCGv cc_srcT;
+    TCGv A0;
 
     sigjmp_buf jmpbuf;
 } DisasContext;
@@ -395,9 +395,9 @@ static inline void gen_op_mov_v_reg(TCGMemOp ot, TCGv t0, int reg)
 
 static void gen_add_A0_im(DisasContext *s, int val)
 {
-    tcg_gen_addi_tl(cpu_A0, cpu_A0, val);
+    tcg_gen_addi_tl(s->A0, s->A0, val);
     if (!CODE64(s)) {
-        tcg_gen_ext32u_tl(cpu_A0, cpu_A0);
+        tcg_gen_ext32u_tl(s->A0, s->A0);
     }
 }
 
@@ -431,7 +431,7 @@ static inline void gen_op_st_v(DisasContext *s, int idx, TCGv t0, TCGv a0)
 static inline void gen_op_st_rm_T0_A0(DisasContext *s, int idx, int d)
 {
     if (d == OR_TMP0) {
-        gen_op_st_v(s, idx, cpu_T0, cpu_A0);
+        gen_op_st_v(s, idx, cpu_T0, s->A0);
     } else {
         gen_op_mov_reg_v(idx, d, cpu_T0);
     }
@@ -453,7 +453,7 @@ static void gen_lea_v_seg(DisasContext *s, TCGMemOp aflag, TCGv a0,
 #ifdef TARGET_X86_64
     case MO_64:
         if (ovr_seg < 0) {
-            tcg_gen_mov_tl(cpu_A0, a0);
+            tcg_gen_mov_tl(s->A0, a0);
             return;
         }
         break;
@@ -464,14 +464,14 @@ static void gen_lea_v_seg(DisasContext *s, TCGMemOp aflag, TCGv a0,
             ovr_seg = def_seg;
         }
         if (ovr_seg < 0) {
-            tcg_gen_ext32u_tl(cpu_A0, a0);
+            tcg_gen_ext32u_tl(s->A0, a0);
             return;
         }
         break;
     case MO_16:
         /* 16 bit address */
-        tcg_gen_ext16u_tl(cpu_A0, a0);
-        a0 = cpu_A0;
+        tcg_gen_ext16u_tl(s->A0, a0);
+        a0 = s->A0;
         if (ovr_seg < 0) {
             if (s->addseg) {
                 ovr_seg = def_seg;
@@ -488,13 +488,13 @@ static void gen_lea_v_seg(DisasContext *s, TCGMemOp aflag, TCGv a0,
         TCGv seg = cpu_seg_base[ovr_seg];
 
         if (aflag == MO_64) {
-            tcg_gen_add_tl(cpu_A0, a0, seg);
+            tcg_gen_add_tl(s->A0, a0, seg);
         } else if (CODE64(s)) {
-            tcg_gen_ext32u_tl(cpu_A0, a0);
-            tcg_gen_add_tl(cpu_A0, cpu_A0, seg);
+            tcg_gen_ext32u_tl(s->A0, a0);
+            tcg_gen_add_tl(s->A0, s->A0, seg);
         } else {
-            tcg_gen_add_tl(cpu_A0, a0, seg);
-            tcg_gen_ext32u_tl(cpu_A0, cpu_A0);
+            tcg_gen_add_tl(s->A0, a0, seg);
+            tcg_gen_ext32u_tl(s->A0, s->A0);
         }
     }
 }
@@ -640,9 +640,9 @@ static void gen_check_io(DisasContext *s, TCGMemOp ot, target_ulong cur_eip,
 static inline void gen_movs(DisasContext *s, TCGMemOp ot)
 {
     gen_string_movl_A0_ESI(s);
-    gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+    gen_op_ld_v(s, ot, cpu_T0, s->A0);
     gen_string_movl_A0_EDI(s);
-    gen_op_st_v(s, ot, cpu_T0, cpu_A0);
+    gen_op_st_v(s, ot, cpu_T0, s->A0);
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_ESI);
     gen_op_add_reg_T0(s->aflag, R_EDI);
@@ -1072,7 +1072,7 @@ static inline void gen_stos(DisasContext *s, TCGMemOp ot)
 {
     gen_op_mov_v_reg(MO_32, cpu_T0, R_EAX);
     gen_string_movl_A0_EDI(s);
-    gen_op_st_v(s, ot, cpu_T0, cpu_A0);
+    gen_op_st_v(s, ot, cpu_T0, s->A0);
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_EDI);
 }
@@ -1080,7 +1080,7 @@ static inline void gen_stos(DisasContext *s, TCGMemOp ot)
 static inline void gen_lods(DisasContext *s, TCGMemOp ot)
 {
     gen_string_movl_A0_ESI(s);
-    gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+    gen_op_ld_v(s, ot, cpu_T0, s->A0);
     gen_op_mov_reg_v(ot, R_EAX, cpu_T0);
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_ESI);
@@ -1089,7 +1089,7 @@ static inline void gen_lods(DisasContext *s, TCGMemOp ot)
 static inline void gen_scas(DisasContext *s, TCGMemOp ot)
 {
     gen_string_movl_A0_EDI(s);
-    gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
+    gen_op_ld_v(s, ot, cpu_T1, s->A0);
     gen_op(s, OP_CMPL, ot, R_EAX);
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_EDI);
@@ -1098,7 +1098,7 @@ static inline void gen_scas(DisasContext *s, TCGMemOp ot)
 static inline void gen_cmps(DisasContext *s, TCGMemOp ot)
 {
     gen_string_movl_A0_EDI(s);
-    gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
+    gen_op_ld_v(s, ot, cpu_T1, s->A0);
     gen_string_movl_A0_ESI(s);
     gen_op(s, OP_CMPL, ot, OR_TMP0);
     gen_op_movl_T0_Dshift(ot);
@@ -1128,11 +1128,11 @@ static inline void gen_ins(DisasContext *s, TCGMemOp ot)
     /* Note: we must do this dummy write first to be restartable in
        case of page fault. */
     tcg_gen_movi_tl(cpu_T0, 0);
-    gen_op_st_v(s, ot, cpu_T0, cpu_A0);
+    gen_op_st_v(s, ot, cpu_T0, s->A0);
     tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[R_EDX]);
     tcg_gen_andi_i32(cpu_tmp2_i32, cpu_tmp2_i32, 0xffff);
     gen_helper_in_func(ot, cpu_T0, cpu_tmp2_i32);
-    gen_op_st_v(s, ot, cpu_T0, cpu_A0);
+    gen_op_st_v(s, ot, cpu_T0, s->A0);
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_EDI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
@@ -1147,7 +1147,7 @@ static inline void gen_outs(DisasContext *s, TCGMemOp ot)
         gen_io_start();
     }
     gen_string_movl_A0_ESI(s);
-    gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+    gen_op_ld_v(s, ot, cpu_T0, s->A0);
 
     tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[R_EDX]);
     tcg_gen_andi_i32(cpu_tmp2_i32, cpu_tmp2_i32, 0xffff);
@@ -1267,14 +1267,14 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
     if (d != OR_TMP0) {
         gen_op_mov_v_reg(ot, cpu_T0, d);
     } else if (!(s1->prefix & PREFIX_LOCK)) {
-        gen_op_ld_v(s1, ot, cpu_T0, cpu_A0);
+        gen_op_ld_v(s1, ot, cpu_T0, s1->A0);
     }
     switch(op) {
     case OP_ADCL:
         gen_compute_eflags_c(s1, cpu_tmp4);
         if (s1->prefix & PREFIX_LOCK) {
             tcg_gen_add_tl(cpu_T0, cpu_tmp4, cpu_T1);
-            tcg_gen_atomic_add_fetch_tl(cpu_T0, cpu_A0, cpu_T0,
+            tcg_gen_atomic_add_fetch_tl(cpu_T0, s1->A0, cpu_T0,
                                         s1->mem_index, ot | MO_LE);
         } else {
             tcg_gen_add_tl(cpu_T0, cpu_T0, cpu_T1);
@@ -1289,7 +1289,7 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
         if (s1->prefix & PREFIX_LOCK) {
             tcg_gen_add_tl(cpu_T0, cpu_T1, cpu_tmp4);
             tcg_gen_neg_tl(cpu_T0, cpu_T0);
-            tcg_gen_atomic_add_fetch_tl(cpu_T0, cpu_A0, cpu_T0,
+            tcg_gen_atomic_add_fetch_tl(cpu_T0, s1->A0, cpu_T0,
                                         s1->mem_index, ot | MO_LE);
         } else {
             tcg_gen_sub_tl(cpu_T0, cpu_T0, cpu_T1);
@@ -1301,7 +1301,7 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
         break;
     case OP_ADDL:
         if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_atomic_add_fetch_tl(cpu_T0, cpu_A0, cpu_T1,
+            tcg_gen_atomic_add_fetch_tl(cpu_T0, s1->A0, cpu_T1,
                                         s1->mem_index, ot | MO_LE);
         } else {
             tcg_gen_add_tl(cpu_T0, cpu_T0, cpu_T1);
@@ -1313,7 +1313,7 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
     case OP_SUBL:
         if (s1->prefix & PREFIX_LOCK) {
             tcg_gen_neg_tl(cpu_T0, cpu_T1);
-            tcg_gen_atomic_fetch_add_tl(s1->cc_srcT, cpu_A0, cpu_T0,
+            tcg_gen_atomic_fetch_add_tl(s1->cc_srcT, s1->A0, cpu_T0,
                                         s1->mem_index, ot | MO_LE);
             tcg_gen_sub_tl(cpu_T0, s1->cc_srcT, cpu_T1);
         } else {
@@ -1327,7 +1327,7 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
     default:
     case OP_ANDL:
         if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_atomic_and_fetch_tl(cpu_T0, cpu_A0, cpu_T1,
+            tcg_gen_atomic_and_fetch_tl(cpu_T0, s1->A0, cpu_T1,
                                         s1->mem_index, ot | MO_LE);
         } else {
             tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
@@ -1338,7 +1338,7 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
         break;
     case OP_ORL:
         if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_atomic_or_fetch_tl(cpu_T0, cpu_A0, cpu_T1,
+            tcg_gen_atomic_or_fetch_tl(cpu_T0, s1->A0, cpu_T1,
                                        s1->mem_index, ot | MO_LE);
         } else {
             tcg_gen_or_tl(cpu_T0, cpu_T0, cpu_T1);
@@ -1349,7 +1349,7 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
         break;
     case OP_XORL:
         if (s1->prefix & PREFIX_LOCK) {
-            tcg_gen_atomic_xor_fetch_tl(cpu_T0, cpu_A0, cpu_T1,
+            tcg_gen_atomic_xor_fetch_tl(cpu_T0, s1->A0, cpu_T1,
                                         s1->mem_index, ot | MO_LE);
         } else {
             tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_T1);
@@ -1372,13 +1372,13 @@ static void gen_inc(DisasContext *s1, TCGMemOp ot, int d, int c)
 {
     if (s1->prefix & PREFIX_LOCK) {
         tcg_gen_movi_tl(cpu_T0, c > 0 ? 1 : -1);
-        tcg_gen_atomic_add_fetch_tl(cpu_T0, cpu_A0, cpu_T0,
+        tcg_gen_atomic_add_fetch_tl(cpu_T0, s1->A0, cpu_T0,
                                     s1->mem_index, ot | MO_LE);
     } else {
         if (d != OR_TMP0) {
             gen_op_mov_v_reg(ot, cpu_T0, d);
         } else {
-            gen_op_ld_v(s1, ot, cpu_T0, cpu_A0);
+            gen_op_ld_v(s1, ot, cpu_T0, s1->A0);
         }
         tcg_gen_addi_tl(cpu_T0, cpu_T0, (c > 0 ? 1 : -1));
         gen_op_st_rm_T0_A0(s1, ot, d);
@@ -1441,7 +1441,7 @@ static void gen_shift_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
 
     /* load */
     if (op1 == OR_TMP0) {
-        gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+        gen_op_ld_v(s, ot, cpu_T0, s->A0);
     } else {
         gen_op_mov_v_reg(ot, cpu_T0, op1);
     }
@@ -1477,7 +1477,7 @@ static void gen_shift_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2,
 
     /* load */
     if (op1 == OR_TMP0)
-        gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+        gen_op_ld_v(s, ot, cpu_T0, s->A0);
     else
         gen_op_mov_v_reg(ot, cpu_T0, op1);
 
@@ -1517,7 +1517,7 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp ot, int op1, int is_right)
 
     /* load */
     if (op1 == OR_TMP0) {
-        gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+        gen_op_ld_v(s, ot, cpu_T0, s->A0);
     } else {
         gen_op_mov_v_reg(ot, cpu_T0, op1);
     }
@@ -1603,7 +1603,7 @@ static void gen_rot_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2,
 
     /* load */
     if (op1 == OR_TMP0) {
-        gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+        gen_op_ld_v(s, ot, cpu_T0, s->A0);
     } else {
         gen_op_mov_v_reg(ot, cpu_T0, op1);
     }
@@ -1681,7 +1681,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
 
     /* load */
     if (op1 == OR_TMP0)
-        gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+        gen_op_ld_v(s, ot, cpu_T0, s->A0);
     else
         gen_op_mov_v_reg(ot, cpu_T0, op1);
     
@@ -1737,7 +1737,7 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
 
     /* load */
     if (op1 == OR_TMP0) {
-        gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+        gen_op_ld_v(s, ot, cpu_T0, s->A0);
     } else {
         gen_op_mov_v_reg(ot, cpu_T0, op1);
     }
@@ -2052,7 +2052,7 @@ static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
 }
 
 /* Compute the address, with a minimum number of TCG ops.  */
-static TCGv gen_lea_modrm_1(AddressParts a)
+static TCGv gen_lea_modrm_1(DisasContext *s, AddressParts a)
 {
     TCGv ea = NULL;
 
@@ -2060,22 +2060,22 @@ static TCGv gen_lea_modrm_1(AddressParts a)
         if (a.scale == 0) {
             ea = cpu_regs[a.index];
         } else {
-            tcg_gen_shli_tl(cpu_A0, cpu_regs[a.index], a.scale);
-            ea = cpu_A0;
+            tcg_gen_shli_tl(s->A0, cpu_regs[a.index], a.scale);
+            ea = s->A0;
         }
         if (a.base >= 0) {
-            tcg_gen_add_tl(cpu_A0, ea, cpu_regs[a.base]);
-            ea = cpu_A0;
+            tcg_gen_add_tl(s->A0, ea, cpu_regs[a.base]);
+            ea = s->A0;
         }
     } else if (a.base >= 0) {
         ea = cpu_regs[a.base];
     }
     if (!ea) {
-        tcg_gen_movi_tl(cpu_A0, a.disp);
-        ea = cpu_A0;
+        tcg_gen_movi_tl(s->A0, a.disp);
+        ea = s->A0;
     } else if (a.disp != 0) {
-        tcg_gen_addi_tl(cpu_A0, ea, a.disp);
-        ea = cpu_A0;
+        tcg_gen_addi_tl(s->A0, ea, a.disp);
+        ea = s->A0;
     }
 
     return ea;
@@ -2084,7 +2084,7 @@ static TCGv gen_lea_modrm_1(AddressParts a)
 static void gen_lea_modrm(CPUX86State *env, DisasContext *s, int modrm)
 {
     AddressParts a = gen_lea_modrm_0(env, s, modrm);
-    TCGv ea = gen_lea_modrm_1(a);
+    TCGv ea = gen_lea_modrm_1(s, a);
     gen_lea_v_seg(s, s->aflag, ea, a.def_seg, s->override);
 }
 
@@ -2097,7 +2097,7 @@ static void gen_nop_modrm(CPUX86State *env, DisasContext *s, int modrm)
 static void gen_bndck(CPUX86State *env, DisasContext *s, int modrm,
                       TCGCond cond, TCGv_i64 bndv)
 {
-    TCGv ea = gen_lea_modrm_1(gen_lea_modrm_0(env, s, modrm));
+    TCGv ea = gen_lea_modrm_1(s, gen_lea_modrm_0(env, s, modrm));
 
     tcg_gen_extu_tl_i64(cpu_tmp1_i64, ea);
     if (!CODE64(s)) {
@@ -2111,7 +2111,7 @@ static void gen_bndck(CPUX86State *env, DisasContext *s, int modrm,
 /* used for LEA and MOV AX, mem */
 static void gen_add_A0_ds_seg(DisasContext *s)
 {
-    gen_lea_v_seg(s, s->aflag, cpu_A0, R_DS, s->override);
+    gen_lea_v_seg(s, s->aflag, s->A0, R_DS, s->override);
 }
 
 /* generate modrm memory load or store of 'reg'. TMP0 is used if reg ==
@@ -2138,9 +2138,9 @@ static void gen_ldst_modrm(CPUX86State *env, DisasContext *s, int modrm,
         if (is_store) {
             if (reg != OR_TMP0)
                 gen_op_mov_v_reg(ot, cpu_T0, reg);
-            gen_op_st_v(s, ot, cpu_T0, cpu_A0);
+            gen_op_st_v(s, ot, cpu_T0, s->A0);
         } else {
-            gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+            gen_op_ld_v(s, ot, cpu_T0, s->A0);
             if (reg != OR_TMP0)
                 gen_op_mov_reg_v(ot, reg, cpu_T0);
         }
@@ -2334,19 +2334,19 @@ static void gen_push_v(DisasContext *s, TCGv val)
     TCGMemOp d_ot = mo_pushpop(s, s->dflag);
     TCGMemOp a_ot = mo_stacksize(s);
     int size = 1 << d_ot;
-    TCGv new_esp = cpu_A0;
+    TCGv new_esp = s->A0;
 
-    tcg_gen_subi_tl(cpu_A0, cpu_regs[R_ESP], size);
+    tcg_gen_subi_tl(s->A0, cpu_regs[R_ESP], size);
 
     if (!CODE64(s)) {
         if (s->addseg) {
             new_esp = cpu_tmp4;
-            tcg_gen_mov_tl(new_esp, cpu_A0);
+            tcg_gen_mov_tl(new_esp, s->A0);
         }
-        gen_lea_v_seg(s, a_ot, cpu_A0, R_SS, -1);
+        gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
     }
 
-    gen_op_st_v(s, d_ot, val, cpu_A0);
+    gen_op_st_v(s, d_ot, val, s->A0);
     gen_op_mov_reg_v(a_ot, R_ESP, new_esp);
 }
 
@@ -2356,7 +2356,7 @@ static TCGMemOp gen_pop_T0(DisasContext *s)
     TCGMemOp d_ot = mo_pushpop(s, s->dflag);
 
     gen_lea_v_seg(s, mo_stacksize(s), cpu_regs[R_ESP], R_SS, -1);
-    gen_op_ld_v(s, d_ot, cpu_T0, cpu_A0);
+    gen_op_ld_v(s, d_ot, cpu_T0, s->A0);
 
     return d_ot;
 }
@@ -2379,9 +2379,9 @@ static void gen_pusha(DisasContext *s)
     int i;
 
     for (i = 0; i < 8; i++) {
-        tcg_gen_addi_tl(cpu_A0, cpu_regs[R_ESP], (i - 8) * size);
-        gen_lea_v_seg(s, s_ot, cpu_A0, R_SS, -1);
-        gen_op_st_v(s, d_ot, cpu_regs[7 - i], cpu_A0);
+        tcg_gen_addi_tl(s->A0, cpu_regs[R_ESP], (i - 8) * size);
+        gen_lea_v_seg(s, s_ot, s->A0, R_SS, -1);
+        gen_op_st_v(s, d_ot, cpu_regs[7 - i], s->A0);
     }
 
     gen_stack_update(s, -8 * size);
@@ -2399,9 +2399,9 @@ static void gen_popa(DisasContext *s)
         if (7 - i == R_ESP) {
             continue;
         }
-        tcg_gen_addi_tl(cpu_A0, cpu_regs[R_ESP], i * size);
-        gen_lea_v_seg(s, s_ot, cpu_A0, R_SS, -1);
-        gen_op_ld_v(s, d_ot, cpu_T0, cpu_A0);
+        tcg_gen_addi_tl(s->A0, cpu_regs[R_ESP], i * size);
+        gen_lea_v_seg(s, s_ot, s->A0, R_SS, -1);
+        gen_op_ld_v(s, d_ot, cpu_T0, s->A0);
         gen_op_mov_reg_v(d_ot, 7 - i, cpu_T0);
     }
 
@@ -2417,7 +2417,7 @@ static void gen_enter(DisasContext *s, int esp_addend, int level)
     /* Push BP; compute FrameTemp into T1.  */
     tcg_gen_subi_tl(cpu_T1, cpu_regs[R_ESP], size);
     gen_lea_v_seg(s, a_ot, cpu_T1, R_SS, -1);
-    gen_op_st_v(s, d_ot, cpu_regs[R_EBP], cpu_A0);
+    gen_op_st_v(s, d_ot, cpu_regs[R_EBP], s->A0);
 
     level &= 31;
     if (level != 0) {
@@ -2425,19 +2425,19 @@ static void gen_enter(DisasContext *s, int esp_addend, int level)
 
         /* Copy level-1 pointers from the previous frame.  */
         for (i = 1; i < level; ++i) {
-            tcg_gen_subi_tl(cpu_A0, cpu_regs[R_EBP], size * i);
-            gen_lea_v_seg(s, a_ot, cpu_A0, R_SS, -1);
-            gen_op_ld_v(s, d_ot, cpu_tmp0, cpu_A0);
+            tcg_gen_subi_tl(s->A0, cpu_regs[R_EBP], size * i);
+            gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
+            gen_op_ld_v(s, d_ot, cpu_tmp0, s->A0);
 
-            tcg_gen_subi_tl(cpu_A0, cpu_T1, size * i);
-            gen_lea_v_seg(s, a_ot, cpu_A0, R_SS, -1);
-            gen_op_st_v(s, d_ot, cpu_tmp0, cpu_A0);
+            tcg_gen_subi_tl(s->A0, cpu_T1, size * i);
+            gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
+            gen_op_st_v(s, d_ot, cpu_tmp0, s->A0);
         }
 
         /* Push the current FrameTemp as the last level.  */
-        tcg_gen_subi_tl(cpu_A0, cpu_T1, size * level);
-        gen_lea_v_seg(s, a_ot, cpu_A0, R_SS, -1);
-        gen_op_st_v(s, d_ot, cpu_T1, cpu_A0);
+        tcg_gen_subi_tl(s->A0, cpu_T1, size * level);
+        gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
+        gen_op_st_v(s, d_ot, cpu_T1, s->A0);
     }
 
     /* Copy the FrameTemp value to EBP.  */
@@ -2454,7 +2454,7 @@ static void gen_leave(DisasContext *s)
     TCGMemOp a_ot = mo_stacksize(s);
 
     gen_lea_v_seg(s, a_ot, cpu_regs[R_EBP], R_SS, -1);
-    gen_op_ld_v(s, d_ot, cpu_T0, cpu_A0);
+    gen_op_ld_v(s, d_ot, cpu_T0, s->A0);
 
     tcg_gen_addi_tl(cpu_T1, cpu_regs[R_EBP], 1 << d_ot);
 
@@ -2633,22 +2633,22 @@ static void gen_jmp(DisasContext *s, target_ulong eip)
 
 static inline void gen_ldq_env_A0(DisasContext *s, int offset)
 {
-    tcg_gen_qemu_ld_i64(cpu_tmp1_i64, cpu_A0, s->mem_index, MO_LEQ);
+    tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0, s->mem_index, MO_LEQ);
     tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, offset);
 }
 
 static inline void gen_stq_env_A0(DisasContext *s, int offset)
 {
     tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env, offset);
-    tcg_gen_qemu_st_i64(cpu_tmp1_i64, cpu_A0, s->mem_index, MO_LEQ);
+    tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0, s->mem_index, MO_LEQ);
 }
 
 static inline void gen_ldo_env_A0(DisasContext *s, int offset)
 {
     int mem_index = s->mem_index;
-    tcg_gen_qemu_ld_i64(cpu_tmp1_i64, cpu_A0, mem_index, MO_LEQ);
+    tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0, mem_index, MO_LEQ);
     tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(0)));
-    tcg_gen_addi_tl(cpu_tmp0, cpu_A0, 8);
+    tcg_gen_addi_tl(cpu_tmp0, s->A0, 8);
     tcg_gen_qemu_ld_i64(cpu_tmp1_i64, cpu_tmp0, mem_index, MO_LEQ);
     tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(1)));
 }
@@ -2657,8 +2657,8 @@ static inline void gen_sto_env_A0(DisasContext *s, int offset)
 {
     int mem_index = s->mem_index;
     tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(0)));
-    tcg_gen_qemu_st_i64(cpu_tmp1_i64, cpu_A0, mem_index, MO_LEQ);
-    tcg_gen_addi_tl(cpu_tmp0, cpu_A0, 8);
+    tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0, mem_index, MO_LEQ);
+    tcg_gen_addi_tl(cpu_tmp0, s->A0, 8);
     tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(1)));
     tcg_gen_qemu_st_i64(cpu_tmp1_i64, cpu_tmp0, mem_index, MO_LEQ);
 }
@@ -3128,7 +3128,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             } else {
                 tcg_gen_ld32u_tl(cpu_T0, cpu_env, offsetof(CPUX86State,
                     xmm_regs[reg].ZMM_L(0)));
-                gen_op_st_v(s, MO_32, cpu_T0, cpu_A0);
+                gen_op_st_v(s, MO_32, cpu_T0, s->A0);
             }
             break;
         case 0x6e: /* movd mm, ea */
@@ -3193,7 +3193,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
         case 0x210: /* movss xmm, ea */
             if (mod != 3) {
                 gen_lea_modrm(env, s, modrm);
-                gen_op_ld_v(s, MO_32, cpu_T0, cpu_A0);
+                gen_op_ld_v(s, MO_32, cpu_T0, s->A0);
                 tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xmm_regs[reg].ZMM_L(0)));
                 tcg_gen_movi_tl(cpu_T0, 0);
                 tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xmm_regs[reg].ZMM_L(1)));
@@ -3380,7 +3380,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             if (mod != 3) {
                 gen_lea_modrm(env, s, modrm);
                 tcg_gen_ld32u_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xmm_regs[reg].ZMM_L(0)));
-                gen_op_st_v(s, MO_32, cpu_T0, cpu_A0);
+                gen_op_st_v(s, MO_32, cpu_T0, s->A0);
             } else {
                 rm = (modrm & 7) | REX_B(s);
                 gen_op_movl(offsetof(CPUX86State,xmm_regs[rm].ZMM_L(0)),
@@ -3555,7 +3555,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 if ((b >> 8) & 1) {
                     gen_ldq_env_A0(s, offsetof(CPUX86State, xmm_t0.ZMM_Q(0)));
                 } else {
-                    gen_op_ld_v(s, MO_32, cpu_T0, cpu_A0);
+                    gen_op_ld_v(s, MO_32, cpu_T0, s->A0);
                     tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xmm_t0.ZMM_L(0)));
                 }
                 op2_offset = offsetof(CPUX86State,xmm_t0);
@@ -3694,13 +3694,13 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                         break;
                     case 0x21: case 0x31: /* pmovsxbd, pmovzxbd */
                     case 0x24: case 0x34: /* pmovsxwq, pmovzxwq */
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                         tcg_gen_st_i32(cpu_tmp2_i32, cpu_env, op2_offset +
                                         offsetof(ZMMReg, ZMM_L(0)));
                         break;
                     case 0x22: case 0x32: /* pmovsxbq, pmovzxbq */
-                        tcg_gen_qemu_ld_tl(cpu_tmp0, cpu_A0,
+                        tcg_gen_qemu_ld_tl(cpu_tmp0, s->A0,
                                            s->mem_index, MO_LEUW);
                         tcg_gen_st16_tl(cpu_tmp0, cpu_env, op2_offset +
                                         offsetof(ZMMReg, ZMM_W(0)));
@@ -3789,11 +3789,11 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
 
                 gen_lea_modrm(env, s, modrm);
                 if ((b & 1) == 0) {
-                    tcg_gen_qemu_ld_tl(cpu_T0, cpu_A0,
+                    tcg_gen_qemu_ld_tl(cpu_T0, s->A0,
                                        s->mem_index, ot | MO_BE);
                     gen_op_mov_reg_v(ot, reg, cpu_T0);
                 } else {
-                    tcg_gen_qemu_st_tl(cpu_regs[reg], cpu_A0,
+                    tcg_gen_qemu_st_tl(cpu_regs[reg], s->A0,
                                        s->mem_index, ot | MO_BE);
                 }
                 break;
@@ -3825,23 +3825,23 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
                     /* Extract START, and shift the operand.
                        Shifts larger than operand size get zeros.  */
-                    tcg_gen_ext8u_tl(cpu_A0, cpu_regs[s->vex_v]);
-                    tcg_gen_shr_tl(cpu_T0, cpu_T0, cpu_A0);
+                    tcg_gen_ext8u_tl(s->A0, cpu_regs[s->vex_v]);
+                    tcg_gen_shr_tl(cpu_T0, cpu_T0, s->A0);
 
                     bound = tcg_const_tl(ot == MO_64 ? 63 : 31);
                     zero = tcg_const_tl(0);
-                    tcg_gen_movcond_tl(TCG_COND_LEU, cpu_T0, cpu_A0, bound,
+                    tcg_gen_movcond_tl(TCG_COND_LEU, cpu_T0, s->A0, bound,
                                        cpu_T0, zero);
                     tcg_temp_free(zero);
 
                     /* Extract the LEN into a mask.  Lengths larger than
                        operand size get all ones.  */
-                    tcg_gen_extract_tl(cpu_A0, cpu_regs[s->vex_v], 8, 8);
-                    tcg_gen_movcond_tl(TCG_COND_LEU, cpu_A0, cpu_A0, bound,
-                                       cpu_A0, bound);
+                    tcg_gen_extract_tl(s->A0, cpu_regs[s->vex_v], 8, 8);
+                    tcg_gen_movcond_tl(TCG_COND_LEU, s->A0, s->A0, bound,
+                                       s->A0, bound);
                     tcg_temp_free(bound);
                     tcg_gen_movi_tl(cpu_T1, 1);
-                    tcg_gen_shl_tl(cpu_T1, cpu_T1, cpu_A0);
+                    tcg_gen_shl_tl(cpu_T1, cpu_T1, s->A0);
                     tcg_gen_subi_tl(cpu_T1, cpu_T1, 1);
                     tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
 
@@ -3870,9 +3870,9 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                                        bound, bound, cpu_T1);
                     tcg_temp_free(bound);
                 }
-                tcg_gen_movi_tl(cpu_A0, -1);
-                tcg_gen_shl_tl(cpu_A0, cpu_A0, cpu_T1);
-                tcg_gen_andc_tl(cpu_T0, cpu_T0, cpu_A0);
+                tcg_gen_movi_tl(s->A0, -1);
+                tcg_gen_shl_tl(s->A0, s->A0, cpu_T1);
+                tcg_gen_andc_tl(cpu_T0, cpu_T0, s->A0);
                 gen_op_mov_reg_v(ot, reg, cpu_T0);
                 gen_op_update1_cc();
                 set_cc_op(s, CC_OP_BMILGB + ot);
@@ -4124,7 +4124,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     if (mod == 3) {
                         gen_op_mov_reg_v(ot, rm, cpu_T0);
                     } else {
-                        tcg_gen_qemu_st_tl(cpu_T0, cpu_A0,
+                        tcg_gen_qemu_st_tl(cpu_T0, s->A0,
                                            s->mem_index, MO_UB);
                     }
                     break;
@@ -4134,7 +4134,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     if (mod == 3) {
                         gen_op_mov_reg_v(ot, rm, cpu_T0);
                     } else {
-                        tcg_gen_qemu_st_tl(cpu_T0, cpu_A0,
+                        tcg_gen_qemu_st_tl(cpu_T0, s->A0,
                                            s->mem_index, MO_LEUW);
                     }
                     break;
@@ -4146,7 +4146,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                         if (mod == 3) {
                             tcg_gen_extu_i32_tl(cpu_regs[rm], cpu_tmp2_i32);
                         } else {
-                            tcg_gen_qemu_st_i32(cpu_tmp2_i32, cpu_A0,
+                            tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUL);
                         }
                     } else { /* pextrq */
@@ -4157,7 +4157,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                         if (mod == 3) {
                             tcg_gen_mov_i64(cpu_regs[rm], cpu_tmp1_i64);
                         } else {
-                            tcg_gen_qemu_st_i64(cpu_tmp1_i64, cpu_A0,
+                            tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0,
                                                 s->mem_index, MO_LEQ);
                         }
 #else
@@ -4171,7 +4171,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     if (mod == 3) {
                         gen_op_mov_reg_v(ot, rm, cpu_T0);
                     } else {
-                        tcg_gen_qemu_st_tl(cpu_T0, cpu_A0,
+                        tcg_gen_qemu_st_tl(cpu_T0, s->A0,
                                            s->mem_index, MO_LEUL);
                     }
                     break;
@@ -4179,7 +4179,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     if (mod == 3) {
                         gen_op_mov_v_reg(MO_32, cpu_T0, rm);
                     } else {
-                        tcg_gen_qemu_ld_tl(cpu_T0, cpu_A0,
+                        tcg_gen_qemu_ld_tl(cpu_T0, s->A0,
                                            s->mem_index, MO_UB);
                     }
                     tcg_gen_st8_tl(cpu_T0, cpu_env, offsetof(CPUX86State,
@@ -4191,7 +4191,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                                         offsetof(CPUX86State,xmm_regs[rm]
                                                 .ZMM_L((val >> 6) & 3)));
                     } else {
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                     }
                     tcg_gen_st_i32(cpu_tmp2_i32, cpu_env,
@@ -4219,7 +4219,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                         if (mod == 3) {
                             tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[rm]);
                         } else {
-                            tcg_gen_qemu_ld_i32(cpu_tmp2_i32, cpu_A0,
+                            tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUL);
                         }
                         tcg_gen_st_i32(cpu_tmp2_i32, cpu_env,
@@ -4230,7 +4230,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                         if (mod == 3) {
                             gen_op_mov_v_reg(ot, cpu_tmp1_i64, rm);
                         } else {
-                            tcg_gen_qemu_ld_i64(cpu_tmp1_i64, cpu_A0,
+                            tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0,
                                                 s->mem_index, MO_LEQ);
                         }
                         tcg_gen_st_i64(cpu_tmp1_i64, cpu_env,
@@ -4360,7 +4360,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 switch (sz) {
                 case 2:
                     /* 32 bit access */
-                    gen_op_ld_v(s, MO_32, cpu_T0, cpu_A0);
+                    gen_op_ld_v(s, MO_32, cpu_T0, s->A0);
                     tcg_gen_st32_tl(cpu_T0, cpu_env,
                                     offsetof(CPUX86State,xmm_t0.ZMM_L(0)));
                     break;
@@ -4426,15 +4426,15 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             /* maskmov : we must prepare A0 */
             if (mod != 3)
                 goto illegal_op;
-            tcg_gen_mov_tl(cpu_A0, cpu_regs[R_EDI]);
-            gen_extu(s->aflag, cpu_A0);
+            tcg_gen_mov_tl(s->A0, cpu_regs[R_EDI]);
+            gen_extu(s->aflag, s->A0);
             gen_add_A0_ds_seg(s);
 
             tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
             tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
             /* XXX: introduce a new table? */
             sse_fn_eppt = (SSEFunc_0_eppt)sse_fn_epp;
-            sse_fn_eppt(cpu_env, cpu_ptr0, cpu_ptr1, cpu_A0);
+            sse_fn_eppt(cpu_env, cpu_ptr0, cpu_ptr1, s->A0);
             break;
         default:
             tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
@@ -4673,7 +4673,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 rm = (modrm & 7) | REX_B(s);
                 if (mod != 3) {
                     gen_lea_modrm(env, s, modrm);
-                    gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
+                    gen_op_ld_v(s, ot, cpu_T1, s->A0);
                 } else if (op == OP_XORL && rm == reg) {
                     goto xor_zero;
                 } else {
@@ -4760,7 +4760,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             /* For those below that handle locked memory, don't load here.  */
             if (!(s->prefix & PREFIX_LOCK)
                 || op != 2) {
-                gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+                gen_op_ld_v(s, ot, cpu_T0, s->A0);
             }
         } else {
             gen_op_mov_v_reg(ot, cpu_T0, rm);
@@ -4779,12 +4779,12 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     goto illegal_op;
                 }
                 tcg_gen_movi_tl(cpu_T0, ~0);
-                tcg_gen_atomic_xor_fetch_tl(cpu_T0, cpu_A0, cpu_T0,
+                tcg_gen_atomic_xor_fetch_tl(cpu_T0, s->A0, cpu_T0,
                                             s->mem_index, ot | MO_LE);
             } else {
                 tcg_gen_not_tl(cpu_T0, cpu_T0);
                 if (mod != 3) {
-                    gen_op_st_v(s, ot, cpu_T0, cpu_A0);
+                    gen_op_st_v(s, ot, cpu_T0, s->A0);
                 } else {
                     gen_op_mov_reg_v(ot, rm, cpu_T0);
                 }
@@ -4802,7 +4802,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 t0 = tcg_temp_local_new();
                 label1 = gen_new_label();
 
-                tcg_gen_mov_tl(a0, cpu_A0);
+                tcg_gen_mov_tl(a0, s->A0);
                 tcg_gen_mov_tl(t0, cpu_T0);
 
                 gen_set_label(label1);
@@ -4822,7 +4822,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             } else {
                 tcg_gen_neg_tl(cpu_T0, cpu_T0);
                 if (mod != 3) {
-                    gen_op_st_v(s, ot, cpu_T0, cpu_A0);
+                    gen_op_st_v(s, ot, cpu_T0, s->A0);
                 } else {
                     gen_op_mov_reg_v(ot, rm, cpu_T0);
                 }
@@ -5001,7 +5001,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (mod != 3) {
             gen_lea_modrm(env, s, modrm);
             if (op >= 2 && op != 3 && op != 5)
-                gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+                gen_op_ld_v(s, ot, cpu_T0, s->A0);
         } else {
             gen_op_mov_v_reg(ot, cpu_T0, rm);
         }
@@ -5034,9 +5034,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_jr(s, cpu_T0);
             break;
         case 3: /* lcall Ev */
-            gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
+            gen_op_ld_v(s, ot, cpu_T1, s->A0);
             gen_add_A0_im(s, 1 << ot);
-            gen_op_ld_v(s, MO_16, cpu_T0, cpu_A0);
+            gen_op_ld_v(s, MO_16, cpu_T0, s->A0);
         do_lcall:
             if (s->pe && !s->vm86) {
                 tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
@@ -5061,9 +5061,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_jr(s, cpu_T0);
             break;
         case 5: /* ljmp Ev */
-            gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
+            gen_op_ld_v(s, ot, cpu_T1, s->A0);
             gen_add_A0_im(s, 1 << ot);
-            gen_op_ld_v(s, MO_16, cpu_T0, cpu_A0);
+            gen_op_ld_v(s, MO_16, cpu_T0, s->A0);
         do_ljmp:
             if (s->pe && !s->vm86) {
                 tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
@@ -5225,13 +5225,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         } else {
             gen_lea_modrm(env, s, modrm);
             if (s->prefix & PREFIX_LOCK) {
-                tcg_gen_atomic_fetch_add_tl(cpu_T1, cpu_A0, cpu_T0,
+                tcg_gen_atomic_fetch_add_tl(cpu_T1, s->A0, cpu_T0,
                                             s->mem_index, ot | MO_LE);
                 tcg_gen_add_tl(cpu_T0, cpu_T0, cpu_T1);
             } else {
-                gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
+                gen_op_ld_v(s, ot, cpu_T1, s->A0);
                 tcg_gen_add_tl(cpu_T0, cpu_T0, cpu_T1);
-                gen_op_st_v(s, ot, cpu_T0, cpu_A0);
+                gen_op_st_v(s, ot, cpu_T0, s->A0);
             }
             gen_op_mov_reg_v(ot, reg, cpu_T1);
         }
@@ -5258,7 +5258,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     goto illegal_op;
                 }
                 gen_lea_modrm(env, s, modrm);
-                tcg_gen_atomic_cmpxchg_tl(oldv, cpu_A0, cmpv, newv,
+                tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, cmpv, newv,
                                           s->mem_index, ot | MO_LE);
                 gen_op_mov_reg_v(ot, R_EAX, oldv);
             } else {
@@ -5267,7 +5267,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     gen_op_mov_v_reg(ot, oldv, rm);
                 } else {
                     gen_lea_modrm(env, s, modrm);
-                    gen_op_ld_v(s, ot, oldv, cpu_A0);
+                    gen_op_ld_v(s, ot, oldv, s->A0);
                     rm = 0; /* avoid warning */
                 }
                 gen_extu(ot, oldv);
@@ -5282,7 +5282,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                        must be before changing accumulator to ensure
                        idempotency if the store faults and the instruction
                        is restarted */
-                    gen_op_st_v(s, ot, newv, cpu_A0);
+                    gen_op_st_v(s, ot, newv, s->A0);
                     gen_op_mov_reg_v(ot, R_EAX, oldv);
                 }
             }
@@ -5306,9 +5306,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             gen_lea_modrm(env, s, modrm);
             if ((s->prefix & PREFIX_LOCK) && (tb_cflags(s->base.tb) & CF_PARALLEL)) {
-                gen_helper_cmpxchg16b(cpu_env, cpu_A0);
+                gen_helper_cmpxchg16b(cpu_env, s->A0);
             } else {
-                gen_helper_cmpxchg16b_unlocked(cpu_env, cpu_A0);
+                gen_helper_cmpxchg16b_unlocked(cpu_env, s->A0);
             }
         } else
 #endif        
@@ -5317,9 +5317,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             gen_lea_modrm(env, s, modrm);
             if ((s->prefix & PREFIX_LOCK) && (tb_cflags(s->base.tb) & CF_PARALLEL)) {
-                gen_helper_cmpxchg8b(cpu_env, cpu_A0);
+                gen_helper_cmpxchg8b(cpu_env, s->A0);
             } else {
-                gen_helper_cmpxchg8b_unlocked(cpu_env, cpu_A0);
+                gen_helper_cmpxchg8b_unlocked(cpu_env, s->A0);
             }
         }
         set_cc_op(s, CC_OP_EFLAGS);
@@ -5453,7 +5453,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         val = insn_get(env, s, ot);
         tcg_gen_movi_tl(cpu_T0, val);
         if (mod != 3) {
-            gen_op_st_v(s, ot, cpu_T0, cpu_A0);
+            gen_op_st_v(s, ot, cpu_T0, s->A0);
         } else {
             gen_op_mov_reg_v(ot, (modrm & 7) | REX_B(s), cpu_T0);
         }
@@ -5540,7 +5540,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_op_mov_reg_v(d_ot, reg, cpu_T0);
             } else {
                 gen_lea_modrm(env, s, modrm);
-                gen_op_ld_v(s, s_ot, cpu_T0, cpu_A0);
+                gen_op_ld_v(s, s_ot, cpu_T0, s->A0);
                 gen_op_mov_reg_v(d_ot, reg, cpu_T0);
             }
         }
@@ -5554,9 +5554,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         reg = ((modrm >> 3) & 7) | rex_r;
         {
             AddressParts a = gen_lea_modrm_0(env, s, modrm);
-            TCGv ea = gen_lea_modrm_1(a);
+            TCGv ea = gen_lea_modrm_1(s, a);
             gen_lea_v_seg(s, s->aflag, ea, -1, -1);
-            gen_op_mov_reg_v(dflag, reg, cpu_A0);
+            gen_op_mov_reg_v(dflag, reg, s->A0);
         }
         break;
 
@@ -5578,24 +5578,24 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 offset_addr = insn_get(env, s, s->aflag);
                 break;
             }
-            tcg_gen_movi_tl(cpu_A0, offset_addr);
+            tcg_gen_movi_tl(s->A0, offset_addr);
             gen_add_A0_ds_seg(s);
             if ((b & 2) == 0) {
-                gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+                gen_op_ld_v(s, ot, cpu_T0, s->A0);
                 gen_op_mov_reg_v(ot, R_EAX, cpu_T0);
             } else {
                 gen_op_mov_v_reg(ot, cpu_T0, R_EAX);
-                gen_op_st_v(s, ot, cpu_T0, cpu_A0);
+                gen_op_st_v(s, ot, cpu_T0, s->A0);
             }
         }
         break;
     case 0xd7: /* xlat */
-        tcg_gen_mov_tl(cpu_A0, cpu_regs[R_EBX]);
+        tcg_gen_mov_tl(s->A0, cpu_regs[R_EBX]);
         tcg_gen_ext8u_tl(cpu_T0, cpu_regs[R_EAX]);
-        tcg_gen_add_tl(cpu_A0, cpu_A0, cpu_T0);
-        gen_extu(s->aflag, cpu_A0);
+        tcg_gen_add_tl(s->A0, s->A0, cpu_T0);
+        gen_extu(s->aflag, s->A0);
         gen_add_A0_ds_seg(s);
-        gen_op_ld_v(s, MO_8, cpu_T0, cpu_A0);
+        gen_op_ld_v(s, MO_8, cpu_T0, s->A0);
         gen_op_mov_reg_v(MO_8, R_EAX, cpu_T0);
         break;
     case 0xb0 ... 0xb7: /* mov R, Ib */
@@ -5646,7 +5646,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_lea_modrm(env, s, modrm);
             gen_op_mov_v_reg(ot, cpu_T0, reg);
             /* for xchg, lock is implicit */
-            tcg_gen_atomic_xchg_tl(cpu_T1, cpu_A0, cpu_T0,
+            tcg_gen_atomic_xchg_tl(cpu_T1, s->A0, cpu_T0,
                                    s->mem_index, ot | MO_LE);
             gen_op_mov_reg_v(ot, reg, cpu_T1);
         }
@@ -5675,10 +5675,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (mod == 3)
             goto illegal_op;
         gen_lea_modrm(env, s, modrm);
-        gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
+        gen_op_ld_v(s, ot, cpu_T1, s->A0);
         gen_add_A0_im(s, 1 << ot);
         /* load the segment first to handle exceptions properly */
-        gen_op_ld_v(s, MO_16, cpu_T0, cpu_A0);
+        gen_op_ld_v(s, MO_16, cpu_T0, s->A0);
         gen_movl_seg_T0(s, op);
         /* then put the data */
         gen_op_mov_reg_v(ot, reg, cpu_T1);
@@ -5798,23 +5798,23 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 
                     switch(op >> 4) {
                     case 0:
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                         gen_helper_flds_FT0(cpu_env, cpu_tmp2_i32);
                         break;
                     case 1:
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                         gen_helper_fildl_FT0(cpu_env, cpu_tmp2_i32);
                         break;
                     case 2:
-                        tcg_gen_qemu_ld_i64(cpu_tmp1_i64, cpu_A0,
+                        tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0,
                                             s->mem_index, MO_LEQ);
                         gen_helper_fldl_FT0(cpu_env, cpu_tmp1_i64);
                         break;
                     case 3:
                     default:
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LESW);
                         gen_helper_fildl_FT0(cpu_env, cpu_tmp2_i32);
                         break;
@@ -5837,23 +5837,23 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 case 0:
                     switch(op >> 4) {
                     case 0:
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                         gen_helper_flds_ST0(cpu_env, cpu_tmp2_i32);
                         break;
                     case 1:
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                         gen_helper_fildl_ST0(cpu_env, cpu_tmp2_i32);
                         break;
                     case 2:
-                        tcg_gen_qemu_ld_i64(cpu_tmp1_i64, cpu_A0,
+                        tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0,
                                             s->mem_index, MO_LEQ);
                         gen_helper_fldl_ST0(cpu_env, cpu_tmp1_i64);
                         break;
                     case 3:
                     default:
-                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LESW);
                         gen_helper_fildl_ST0(cpu_env, cpu_tmp2_i32);
                         break;
@@ -5864,18 +5864,18 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     switch(op >> 4) {
                     case 1:
                         gen_helper_fisttl_ST0(cpu_tmp2_i32, cpu_env);
-                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                         break;
                     case 2:
                         gen_helper_fisttll_ST0(cpu_tmp1_i64, cpu_env);
-                        tcg_gen_qemu_st_i64(cpu_tmp1_i64, cpu_A0,
+                        tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0,
                                             s->mem_index, MO_LEQ);
                         break;
                     case 3:
                     default:
                         gen_helper_fistt_ST0(cpu_tmp2_i32, cpu_env);
-                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUW);
                         break;
                     }
@@ -5885,23 +5885,23 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     switch(op >> 4) {
                     case 0:
                         gen_helper_fsts_ST0(cpu_tmp2_i32, cpu_env);
-                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                         break;
                     case 1:
                         gen_helper_fistl_ST0(cpu_tmp2_i32, cpu_env);
-                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUL);
                         break;
                     case 2:
                         gen_helper_fstl_ST0(cpu_tmp1_i64, cpu_env);
-                        tcg_gen_qemu_st_i64(cpu_tmp1_i64, cpu_A0,
+                        tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0,
                                             s->mem_index, MO_LEQ);
                         break;
                     case 3:
                     default:
                         gen_helper_fist_ST0(cpu_tmp2_i32, cpu_env);
-                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, cpu_A0,
+                        tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
                                             s->mem_index, MO_LEUW);
                         break;
                     }
@@ -5911,53 +5911,53 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 }
                 break;
             case 0x0c: /* fldenv mem */
-                gen_helper_fldenv(cpu_env, cpu_A0, tcg_const_i32(dflag - 1));
+                gen_helper_fldenv(cpu_env, s->A0, tcg_const_i32(dflag - 1));
                 break;
             case 0x0d: /* fldcw mem */
-                tcg_gen_qemu_ld_i32(cpu_tmp2_i32, cpu_A0,
+                tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0,
                                     s->mem_index, MO_LEUW);
                 gen_helper_fldcw(cpu_env, cpu_tmp2_i32);
                 break;
             case 0x0e: /* fnstenv mem */
-                gen_helper_fstenv(cpu_env, cpu_A0, tcg_const_i32(dflag - 1));
+                gen_helper_fstenv(cpu_env, s->A0, tcg_const_i32(dflag - 1));
                 break;
             case 0x0f: /* fnstcw mem */
                 gen_helper_fnstcw(cpu_tmp2_i32, cpu_env);
-                tcg_gen_qemu_st_i32(cpu_tmp2_i32, cpu_A0,
+                tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
                                     s->mem_index, MO_LEUW);
                 break;
             case 0x1d: /* fldt mem */
-                gen_helper_fldt_ST0(cpu_env, cpu_A0);
+                gen_helper_fldt_ST0(cpu_env, s->A0);
                 break;
             case 0x1f: /* fstpt mem */
-                gen_helper_fstt_ST0(cpu_env, cpu_A0);
+                gen_helper_fstt_ST0(cpu_env, s->A0);
                 gen_helper_fpop(cpu_env);
                 break;
             case 0x2c: /* frstor mem */
-                gen_helper_frstor(cpu_env, cpu_A0, tcg_const_i32(dflag - 1));
+                gen_helper_frstor(cpu_env, s->A0, tcg_const_i32(dflag - 1));
                 break;
             case 0x2e: /* fnsave mem */
-                gen_helper_fsave(cpu_env, cpu_A0, tcg_const_i32(dflag - 1));
+                gen_helper_fsave(cpu_env, s->A0, tcg_const_i32(dflag - 1));
                 break;
             case 0x2f: /* fnstsw mem */
                 gen_helper_fnstsw(cpu_tmp2_i32, cpu_env);
-                tcg_gen_qemu_st_i32(cpu_tmp2_i32, cpu_A0,
+                tcg_gen_qemu_st_i32(cpu_tmp2_i32, s->A0,
                                     s->mem_index, MO_LEUW);
                 break;
             case 0x3c: /* fbld */
-                gen_helper_fbld_ST0(cpu_env, cpu_A0);
+                gen_helper_fbld_ST0(cpu_env, s->A0);
                 break;
             case 0x3e: /* fbstp */
-                gen_helper_fbst_ST0(cpu_env, cpu_A0);
+                gen_helper_fbst_ST0(cpu_env, s->A0);
                 gen_helper_fpop(cpu_env);
                 break;
             case 0x3d: /* fildll */
-                tcg_gen_qemu_ld_i64(cpu_tmp1_i64, cpu_A0, s->mem_index, MO_LEQ);
+                tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0, s->mem_index, MO_LEQ);
                 gen_helper_fildll_ST0(cpu_env, cpu_tmp1_i64);
                 break;
             case 0x3f: /* fistpll */
                 gen_helper_fistll_ST0(cpu_tmp1_i64, cpu_env);
-                tcg_gen_qemu_st_i64(cpu_tmp1_i64, cpu_A0, s->mem_index, MO_LEQ);
+                tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0, s->mem_index, MO_LEQ);
                 gen_helper_fpop(cpu_env);
                 break;
             default:
@@ -6471,13 +6471,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         } else {
             gen_stack_A0(s);
             /* pop offset */
-            gen_op_ld_v(s, dflag, cpu_T0, cpu_A0);
+            gen_op_ld_v(s, dflag, cpu_T0, s->A0);
             /* NOTE: keeping EIP updated is not a problem in case of
                exception */
             gen_op_jmp_v(cpu_T0);
             /* pop selector */
             gen_add_A0_im(s, 1 << dflag);
-            gen_op_ld_v(s, dflag, cpu_T0, cpu_A0);
+            gen_op_ld_v(s, dflag, cpu_T0, s->A0);
             gen_op_movl_seg_T0_vm(R_CS);
             /* add stack offset */
             gen_stack_update(s, val + (2 << dflag));
@@ -6732,7 +6732,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             s->rip_offset = 1;
             gen_lea_modrm(env, s, modrm);
             if (!(s->prefix & PREFIX_LOCK)) {
-                gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+                gen_op_ld_v(s, ot, cpu_T0, s->A0);
             }
         } else {
             gen_op_mov_v_reg(ot, cpu_T0, rm);
@@ -6768,10 +6768,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_exts(ot, cpu_T1);
             tcg_gen_sari_tl(cpu_tmp0, cpu_T1, 3 + ot);
             tcg_gen_shli_tl(cpu_tmp0, cpu_tmp0, ot);
-            tcg_gen_add_tl(cpu_A0, gen_lea_modrm_1(a), cpu_tmp0);
-            gen_lea_v_seg(s, s->aflag, cpu_A0, a.def_seg, s->override);
+            tcg_gen_add_tl(s->A0, gen_lea_modrm_1(s, a), cpu_tmp0);
+            gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
             if (!(s->prefix & PREFIX_LOCK)) {
-                gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+                gen_op_ld_v(s, ot, cpu_T0, s->A0);
             }
         } else {
             gen_op_mov_v_reg(ot, cpu_T0, rm);
@@ -6785,20 +6785,20 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             case 0: /* bt */
                 /* Needs no atomic ops; we surpressed the normal
                    memory load for LOCK above so do it now.  */
-                gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
+                gen_op_ld_v(s, ot, cpu_T0, s->A0);
                 break;
             case 1: /* bts */
-                tcg_gen_atomic_fetch_or_tl(cpu_T0, cpu_A0, cpu_tmp0,
+                tcg_gen_atomic_fetch_or_tl(cpu_T0, s->A0, cpu_tmp0,
                                            s->mem_index, ot | MO_LE);
                 break;
             case 2: /* btr */
                 tcg_gen_not_tl(cpu_tmp0, cpu_tmp0);
-                tcg_gen_atomic_fetch_and_tl(cpu_T0, cpu_A0, cpu_tmp0,
+                tcg_gen_atomic_fetch_and_tl(cpu_T0, s->A0, cpu_tmp0,
                                             s->mem_index, ot | MO_LE);
                 break;
             default:
             case 3: /* btc */
-                tcg_gen_atomic_fetch_xor_tl(cpu_T0, cpu_A0, cpu_tmp0,
+                tcg_gen_atomic_fetch_xor_tl(cpu_T0, s->A0, cpu_tmp0,
                                             s->mem_index, ot | MO_LE);
                 break;
             }
@@ -6822,7 +6822,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             if (op != 0) {
                 if (mod != 3) {
-                    gen_op_st_v(s, ot, cpu_T0, cpu_A0);
+                    gen_op_st_v(s, ot, cpu_T0, s->A0);
                 } else {
                     gen_op_mov_reg_v(ot, rm, cpu_T0);
                 }
@@ -7051,9 +7051,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_lea_modrm(env, s, modrm);
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
         if (ot == MO_16) {
-            gen_helper_boundw(cpu_env, cpu_A0, cpu_tmp2_i32);
+            gen_helper_boundw(cpu_env, s->A0, cpu_tmp2_i32);
         } else {
-            gen_helper_boundl(cpu_env, cpu_A0, cpu_tmp2_i32);
+            gen_helper_boundl(cpu_env, s->A0, cpu_tmp2_i32);
         }
         break;
     case 0x1c8 ... 0x1cf: /* bswap reg */
@@ -7293,13 +7293,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(cpu_T0,
                              cpu_env, offsetof(CPUX86State, gdt.limit));
-            gen_op_st_v(s, MO_16, cpu_T0, cpu_A0);
+            gen_op_st_v(s, MO_16, cpu_T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(cpu_T0, cpu_env, offsetof(CPUX86State, gdt.base));
             if (dflag == MO_16) {
                 tcg_gen_andi_tl(cpu_T0, cpu_T0, 0xffffff);
             }
-            gen_op_st_v(s, CODE64(s) + MO_32, cpu_T0, cpu_A0);
+            gen_op_st_v(s, CODE64(s) + MO_32, cpu_T0, s->A0);
             break;
 
         case 0xc8: /* monitor */
@@ -7308,10 +7308,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
-            tcg_gen_mov_tl(cpu_A0, cpu_regs[R_EAX]);
-            gen_extu(s->aflag, cpu_A0);
+            tcg_gen_mov_tl(s->A0, cpu_regs[R_EAX]);
+            gen_extu(s->aflag, s->A0);
             gen_add_A0_ds_seg(s);
-            gen_helper_monitor(cpu_env, cpu_A0);
+            gen_helper_monitor(cpu_env, s->A0);
             break;
 
         case 0xc9: /* mwait */
@@ -7348,13 +7348,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_IDTR_READ);
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(cpu_T0, cpu_env, offsetof(CPUX86State, idt.limit));
-            gen_op_st_v(s, MO_16, cpu_T0, cpu_A0);
+            gen_op_st_v(s, MO_16, cpu_T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(cpu_T0, cpu_env, offsetof(CPUX86State, idt.base));
             if (dflag == MO_16) {
                 tcg_gen_andi_tl(cpu_T0, cpu_T0, 0xffffff);
             }
-            gen_op_st_v(s, CODE64(s) + MO_32, cpu_T0, cpu_A0);
+            gen_op_st_v(s, CODE64(s) + MO_32, cpu_T0, s->A0);
             break;
 
         case 0xd0: /* xgetbv */
@@ -7498,9 +7498,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_GDTR_WRITE);
             gen_lea_modrm(env, s, modrm);
-            gen_op_ld_v(s, MO_16, cpu_T1, cpu_A0);
+            gen_op_ld_v(s, MO_16, cpu_T1, s->A0);
             gen_add_A0_im(s, 2);
-            gen_op_ld_v(s, CODE64(s) + MO_32, cpu_T0, cpu_A0);
+            gen_op_ld_v(s, CODE64(s) + MO_32, cpu_T0, s->A0);
             if (dflag == MO_16) {
                 tcg_gen_andi_tl(cpu_T0, cpu_T0, 0xffffff);
             }
@@ -7515,9 +7515,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_IDTR_WRITE);
             gen_lea_modrm(env, s, modrm);
-            gen_op_ld_v(s, MO_16, cpu_T1, cpu_A0);
+            gen_op_ld_v(s, MO_16, cpu_T1, s->A0);
             gen_add_A0_im(s, 2);
-            gen_op_ld_v(s, CODE64(s) + MO_32, cpu_T0, cpu_A0);
+            gen_op_ld_v(s, CODE64(s) + MO_32, cpu_T0, s->A0);
             if (dflag == MO_16) {
                 tcg_gen_andi_tl(cpu_T0, cpu_T0, 0xffffff);
             }
@@ -7573,7 +7573,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             gen_lea_modrm(env, s, modrm);
-            gen_helper_invlpg(cpu_env, cpu_A0);
+            gen_helper_invlpg(cpu_env, s->A0);
             gen_jmp_im(s->pc - s->cs_base);
             gen_eob(s);
             break;
@@ -7646,7 +7646,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_op_mov_reg_v(d_ot, reg, cpu_T0);
             } else {
                 gen_lea_modrm(env, s, modrm);
-                gen_op_ld_v(s, MO_32 | MO_SIGN, cpu_T0, cpu_A0);
+                gen_op_ld_v(s, MO_32 | MO_SIGN, cpu_T0, s->A0);
                 gen_op_mov_reg_v(d_ot, reg, cpu_T0);
             }
         } else
@@ -7667,9 +7667,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             rm = modrm & 7;
             if (mod != 3) {
                 gen_lea_modrm(env, s, modrm);
-                gen_op_ld_v(s, ot, t0, cpu_A0);
+                gen_op_ld_v(s, ot, t0, s->A0);
                 a0 = tcg_temp_local_new();
-                tcg_gen_mov_tl(a0, cpu_A0);
+                tcg_gen_mov_tl(a0, s->A0);
             } else {
                 gen_op_mov_v_reg(ot, t0, rm);
                 a0 = NULL;
@@ -7785,16 +7785,16 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 } else {
                     gen_lea_modrm(env, s, modrm);
                     if (CODE64(s)) {
-                        tcg_gen_qemu_ld_i64(cpu_bndl[reg], cpu_A0,
+                        tcg_gen_qemu_ld_i64(cpu_bndl[reg], s->A0,
                                             s->mem_index, MO_LEQ);
-                        tcg_gen_addi_tl(cpu_A0, cpu_A0, 8);
-                        tcg_gen_qemu_ld_i64(cpu_bndu[reg], cpu_A0,
+                        tcg_gen_addi_tl(s->A0, s->A0, 8);
+                        tcg_gen_qemu_ld_i64(cpu_bndu[reg], s->A0,
                                             s->mem_index, MO_LEQ);
                     } else {
-                        tcg_gen_qemu_ld_i64(cpu_bndl[reg], cpu_A0,
+                        tcg_gen_qemu_ld_i64(cpu_bndl[reg], s->A0,
                                             s->mem_index, MO_LEUL);
-                        tcg_gen_addi_tl(cpu_A0, cpu_A0, 4);
-                        tcg_gen_qemu_ld_i64(cpu_bndu[reg], cpu_A0,
+                        tcg_gen_addi_tl(s->A0, s->A0, 4);
+                        tcg_gen_qemu_ld_i64(cpu_bndu[reg], s->A0,
                                             s->mem_index, MO_LEUL);
                     }
                     /* bnd registers are now in-use */
@@ -7810,22 +7810,22 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     goto illegal_op;
                 }
                 if (a.base >= 0) {
-                    tcg_gen_addi_tl(cpu_A0, cpu_regs[a.base], a.disp);
+                    tcg_gen_addi_tl(s->A0, cpu_regs[a.base], a.disp);
                 } else {
-                    tcg_gen_movi_tl(cpu_A0, 0);
+                    tcg_gen_movi_tl(s->A0, 0);
                 }
-                gen_lea_v_seg(s, s->aflag, cpu_A0, a.def_seg, s->override);
+                gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
                 if (a.index >= 0) {
                     tcg_gen_mov_tl(cpu_T0, cpu_regs[a.index]);
                 } else {
                     tcg_gen_movi_tl(cpu_T0, 0);
                 }
                 if (CODE64(s)) {
-                    gen_helper_bndldx64(cpu_bndl[reg], cpu_env, cpu_A0, cpu_T0);
+                    gen_helper_bndldx64(cpu_bndl[reg], cpu_env, s->A0, cpu_T0);
                     tcg_gen_ld_i64(cpu_bndu[reg], cpu_env,
                                    offsetof(CPUX86State, mmx_t0.MMX_Q(0)));
                 } else {
-                    gen_helper_bndldx32(cpu_bndu[reg], cpu_env, cpu_A0, cpu_T0);
+                    gen_helper_bndldx32(cpu_bndu[reg], cpu_env, s->A0, cpu_T0);
                     tcg_gen_ext32u_i64(cpu_bndl[reg], cpu_bndu[reg]);
                     tcg_gen_shri_i64(cpu_bndu[reg], cpu_bndu[reg], 32);
                 }
@@ -7859,11 +7859,11 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     /* rip-relative generates #ud */
                     goto illegal_op;
                 }
-                tcg_gen_not_tl(cpu_A0, gen_lea_modrm_1(a));
+                tcg_gen_not_tl(s->A0, gen_lea_modrm_1(s, a));
                 if (!CODE64(s)) {
-                    tcg_gen_ext32u_tl(cpu_A0, cpu_A0);
+                    tcg_gen_ext32u_tl(s->A0, s->A0);
                 }
-                tcg_gen_extu_tl_i64(cpu_bndu[reg], cpu_A0);
+                tcg_gen_extu_tl_i64(cpu_bndu[reg], s->A0);
                 /* bnd registers are now in-use */
                 gen_set_hflag(s, HF_MPX_IU_MASK);
                 break;
@@ -7892,16 +7892,16 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 } else {
                     gen_lea_modrm(env, s, modrm);
                     if (CODE64(s)) {
-                        tcg_gen_qemu_st_i64(cpu_bndl[reg], cpu_A0,
+                        tcg_gen_qemu_st_i64(cpu_bndl[reg], s->A0,
                                             s->mem_index, MO_LEQ);
-                        tcg_gen_addi_tl(cpu_A0, cpu_A0, 8);
-                        tcg_gen_qemu_st_i64(cpu_bndu[reg], cpu_A0,
+                        tcg_gen_addi_tl(s->A0, s->A0, 8);
+                        tcg_gen_qemu_st_i64(cpu_bndu[reg], s->A0,
                                             s->mem_index, MO_LEQ);
                     } else {
-                        tcg_gen_qemu_st_i64(cpu_bndl[reg], cpu_A0,
+                        tcg_gen_qemu_st_i64(cpu_bndl[reg], s->A0,
                                             s->mem_index, MO_LEUL);
-                        tcg_gen_addi_tl(cpu_A0, cpu_A0, 4);
-                        tcg_gen_qemu_st_i64(cpu_bndu[reg], cpu_A0,
+                        tcg_gen_addi_tl(s->A0, s->A0, 4);
+                        tcg_gen_qemu_st_i64(cpu_bndu[reg], s->A0,
                                             s->mem_index, MO_LEUL);
                     }
                 }
@@ -7915,21 +7915,21 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     goto illegal_op;
                 }
                 if (a.base >= 0) {
-                    tcg_gen_addi_tl(cpu_A0, cpu_regs[a.base], a.disp);
+                    tcg_gen_addi_tl(s->A0, cpu_regs[a.base], a.disp);
                 } else {
-                    tcg_gen_movi_tl(cpu_A0, 0);
+                    tcg_gen_movi_tl(s->A0, 0);
                 }
-                gen_lea_v_seg(s, s->aflag, cpu_A0, a.def_seg, s->override);
+                gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
                 if (a.index >= 0) {
                     tcg_gen_mov_tl(cpu_T0, cpu_regs[a.index]);
                 } else {
                     tcg_gen_movi_tl(cpu_T0, 0);
                 }
                 if (CODE64(s)) {
-                    gen_helper_bndstx64(cpu_env, cpu_A0, cpu_T0,
+                    gen_helper_bndstx64(cpu_env, s->A0, cpu_T0,
                                         cpu_bndl[reg], cpu_bndu[reg]);
                 } else {
-                    gen_helper_bndstx32(cpu_env, cpu_A0, cpu_T0,
+                    gen_helper_bndstx32(cpu_env, s->A0, cpu_T0,
                                         cpu_bndl[reg], cpu_bndu[reg]);
                 }
             }
@@ -8069,7 +8069,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_lea_modrm(env, s, modrm);
-            gen_helper_fxsave(cpu_env, cpu_A0);
+            gen_helper_fxsave(cpu_env, s->A0);
             break;
 
         CASE_MODRM_MEM_OP(1): /* fxrstor */
@@ -8082,7 +8082,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_lea_modrm(env, s, modrm);
-            gen_helper_fxrstor(cpu_env, cpu_A0);
+            gen_helper_fxrstor(cpu_env, s->A0);
             break;
 
         CASE_MODRM_MEM_OP(2): /* ldmxcsr */
@@ -8094,7 +8094,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_lea_modrm(env, s, modrm);
-            tcg_gen_qemu_ld_i32(cpu_tmp2_i32, cpu_A0, s->mem_index, MO_LEUL);
+            tcg_gen_qemu_ld_i32(cpu_tmp2_i32, s->A0, s->mem_index, MO_LEUL);
             gen_helper_ldmxcsr(cpu_env, cpu_tmp2_i32);
             break;
 
@@ -8108,7 +8108,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(cpu_T0, cpu_env, offsetof(CPUX86State, mxcsr));
-            gen_op_st_v(s, MO_32, cpu_T0, cpu_A0);
+            gen_op_st_v(s, MO_32, cpu_T0, s->A0);
             break;
 
         CASE_MODRM_MEM_OP(4): /* xsave */
@@ -8120,7 +8120,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_lea_modrm(env, s, modrm);
             tcg_gen_concat_tl_i64(cpu_tmp1_i64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
-            gen_helper_xsave(cpu_env, cpu_A0, cpu_tmp1_i64);
+            gen_helper_xsave(cpu_env, s->A0, cpu_tmp1_i64);
             break;
 
         CASE_MODRM_MEM_OP(5): /* xrstor */
@@ -8132,7 +8132,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_lea_modrm(env, s, modrm);
             tcg_gen_concat_tl_i64(cpu_tmp1_i64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
-            gen_helper_xrstor(cpu_env, cpu_A0, cpu_tmp1_i64);
+            gen_helper_xrstor(cpu_env, s->A0, cpu_tmp1_i64);
             /* XRSTOR is how MPX is enabled, which changes how
                we translate.  Thus we need to end the TB.  */
             gen_update_cc_op(s);
@@ -8160,7 +8160,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_lea_modrm(env, s, modrm);
                 tcg_gen_concat_tl_i64(cpu_tmp1_i64, cpu_regs[R_EAX],
                                       cpu_regs[R_EDX]);
-                gen_helper_xsaveopt(cpu_env, cpu_A0, cpu_tmp1_i64);
+                gen_helper_xsaveopt(cpu_env, s->A0, cpu_tmp1_i64);
             }
             break;
 
@@ -8458,7 +8458,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 
     cpu_T0 = tcg_temp_new();
     cpu_T1 = tcg_temp_new();
-    cpu_A0 = tcg_temp_new();
+    dc->A0 = tcg_temp_new();
 
     cpu_tmp0 = tcg_temp_new();
     cpu_tmp1_i64 = tcg_temp_new_i64();
-- 
2.17.1
