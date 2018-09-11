Received: from eggs.gnu.org ([2001:4830:134:3::10]:58675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGy-0000QL-Ss
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGt-0002XL-8x
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55075)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzpGt-0002Wo-2S
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Sep 2018 16:28:17 -0400
Message-Id: <20180911202823.21657-8-cota@braap.org>
In-Reply-To: <20180911202823.21657-1-cota@braap.org>
References: <20180911202823.21657-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 07/13] target/i386: move cpu_ptr0 to
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
 target/i386/translate.c | 101 +++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 49 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0ad6ffc4af..9531dafebe 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -79,7 +79,7 @@ static TCGv cpu_seg_base[6];
 static TCGv_i64 cpu_bndl[4];
 static TCGv_i64 cpu_bndu[4];
 
-static TCGv_ptr cpu_ptr0, cpu_ptr1;
+static TCGv_ptr cpu_ptr1;
 static TCGv_i32 cpu_tmp2_i32, cpu_tmp3_i32;
 static TCGv_i64 cpu_tmp1_i64;
 
@@ -141,6 +141,7 @@ typedef struct DisasContext {
     /* TCG local register indexes (only used inside old micro ops) */
     TCGv tmp0;
     TCGv tmp4;
+    TCGv_ptr ptr0;
 
     sigjmp_buf jmpbuf;
 } DisasContext;
@@ -3147,27 +3148,27 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
 #endif
             {
                 gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 0);
-                tcg_gen_addi_ptr(cpu_ptr0, cpu_env, 
+                tcg_gen_addi_ptr(s->ptr0, cpu_env,
                                  offsetof(CPUX86State,fpregs[reg].mmx));
                 tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-                gen_helper_movl_mm_T0_mmx(cpu_ptr0, cpu_tmp2_i32);
+                gen_helper_movl_mm_T0_mmx(s->ptr0, cpu_tmp2_i32);
             }
             break;
         case 0x16e: /* movd xmm, ea */
 #ifdef TARGET_X86_64
             if (s->dflag == MO_64) {
                 gen_ldst_modrm(env, s, modrm, MO_64, OR_TMP0, 0);
-                tcg_gen_addi_ptr(cpu_ptr0, cpu_env, 
+                tcg_gen_addi_ptr(s->ptr0, cpu_env,
                                  offsetof(CPUX86State,xmm_regs[reg]));
-                gen_helper_movq_mm_T0_xmm(cpu_ptr0, s->T0);
+                gen_helper_movq_mm_T0_xmm(s->ptr0, s->T0);
             } else
 #endif
             {
                 gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 0);
-                tcg_gen_addi_ptr(cpu_ptr0, cpu_env, 
+                tcg_gen_addi_ptr(s->ptr0, cpu_env,
                                  offsetof(CPUX86State,xmm_regs[reg]));
                 tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-                gen_helper_movl_mm_T0_xmm(cpu_ptr0, cpu_tmp2_i32);
+                gen_helper_movl_mm_T0_xmm(s->ptr0, cpu_tmp2_i32);
             }
             break;
         case 0x6f: /* movq mm, ea */
@@ -3312,14 +3313,14 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     goto illegal_op;
                 field_length = x86_ldub_code(env, s) & 0x3F;
                 bit_index = x86_ldub_code(env, s) & 0x3F;
-                tcg_gen_addi_ptr(cpu_ptr0, cpu_env,
+                tcg_gen_addi_ptr(s->ptr0, cpu_env,
                     offsetof(CPUX86State,xmm_regs[reg]));
                 if (b1 == 1)
-                    gen_helper_extrq_i(cpu_env, cpu_ptr0,
+                    gen_helper_extrq_i(cpu_env, s->ptr0,
                                        tcg_const_i32(bit_index),
                                        tcg_const_i32(field_length));
                 else
-                    gen_helper_insertq_i(cpu_env, cpu_ptr0,
+                    gen_helper_insertq_i(cpu_env, s->ptr0,
                                          tcg_const_i32(bit_index),
                                          tcg_const_i32(field_length));
             }
@@ -3471,22 +3472,22 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 rm = (modrm & 7);
                 op2_offset = offsetof(CPUX86State,fpregs[rm].mmx);
             }
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op2_offset);
+            tcg_gen_addi_ptr(s->ptr0, cpu_env, op2_offset);
             tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op1_offset);
-            sse_fn_epp(cpu_env, cpu_ptr0, cpu_ptr1);
+            sse_fn_epp(cpu_env, s->ptr0, cpu_ptr1);
             break;
         case 0x050: /* movmskps */
             rm = (modrm & 7) | REX_B(s);
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, 
+            tcg_gen_addi_ptr(s->ptr0, cpu_env,
                              offsetof(CPUX86State,xmm_regs[rm]));
-            gen_helper_movmskps(cpu_tmp2_i32, cpu_env, cpu_ptr0);
+            gen_helper_movmskps(cpu_tmp2_i32, cpu_env, s->ptr0);
             tcg_gen_extu_i32_tl(cpu_regs[reg], cpu_tmp2_i32);
             break;
         case 0x150: /* movmskpd */
             rm = (modrm & 7) | REX_B(s);
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, 
+            tcg_gen_addi_ptr(s->ptr0, cpu_env,
                              offsetof(CPUX86State,xmm_regs[rm]));
-            gen_helper_movmskpd(cpu_tmp2_i32, cpu_env, cpu_ptr0);
+            gen_helper_movmskpd(cpu_tmp2_i32, cpu_env, s->ptr0);
             tcg_gen_extu_i32_tl(cpu_regs[reg], cpu_tmp2_i32);
             break;
         case 0x02a: /* cvtpi2ps */
@@ -3501,15 +3502,15 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 op2_offset = offsetof(CPUX86State,fpregs[rm].mmx);
             }
             op1_offset = offsetof(CPUX86State,xmm_regs[reg]);
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
+            tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
             tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
             switch(b >> 8) {
             case 0x0:
-                gen_helper_cvtpi2ps(cpu_env, cpu_ptr0, cpu_ptr1);
+                gen_helper_cvtpi2ps(cpu_env, s->ptr0, cpu_ptr1);
                 break;
             default:
             case 0x1:
-                gen_helper_cvtpi2pd(cpu_env, cpu_ptr0, cpu_ptr1);
+                gen_helper_cvtpi2pd(cpu_env, s->ptr0, cpu_ptr1);
                 break;
             }
             break;
@@ -3518,15 +3519,15 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             ot = mo_64_32(s->dflag);
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
             op1_offset = offsetof(CPUX86State,xmm_regs[reg]);
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
+            tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
             if (ot == MO_32) {
                 SSEFunc_0_epi sse_fn_epi = sse_op_table3ai[(b >> 8) & 1];
                 tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
-                sse_fn_epi(cpu_env, cpu_ptr0, cpu_tmp2_i32);
+                sse_fn_epi(cpu_env, s->ptr0, cpu_tmp2_i32);
             } else {
 #ifdef TARGET_X86_64
                 SSEFunc_0_epl sse_fn_epl = sse_op_table3aq[(b >> 8) & 1];
-                sse_fn_epl(cpu_env, cpu_ptr0, s->T0);
+                sse_fn_epl(cpu_env, s->ptr0, s->T0);
 #else
                 goto illegal_op;
 #endif
@@ -3546,20 +3547,20 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 op2_offset = offsetof(CPUX86State,xmm_regs[rm]);
             }
             op1_offset = offsetof(CPUX86State,fpregs[reg & 7].mmx);
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
+            tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
             tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
             switch(b) {
             case 0x02c:
-                gen_helper_cvttps2pi(cpu_env, cpu_ptr0, cpu_ptr1);
+                gen_helper_cvttps2pi(cpu_env, s->ptr0, cpu_ptr1);
                 break;
             case 0x12c:
-                gen_helper_cvttpd2pi(cpu_env, cpu_ptr0, cpu_ptr1);
+                gen_helper_cvttpd2pi(cpu_env, s->ptr0, cpu_ptr1);
                 break;
             case 0x02d:
-                gen_helper_cvtps2pi(cpu_env, cpu_ptr0, cpu_ptr1);
+                gen_helper_cvtps2pi(cpu_env, s->ptr0, cpu_ptr1);
                 break;
             case 0x12d:
-                gen_helper_cvtpd2pi(cpu_env, cpu_ptr0, cpu_ptr1);
+                gen_helper_cvtpd2pi(cpu_env, s->ptr0, cpu_ptr1);
                 break;
             }
             break;
@@ -3582,17 +3583,17 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 rm = (modrm & 7) | REX_B(s);
                 op2_offset = offsetof(CPUX86State,xmm_regs[rm]);
             }
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op2_offset);
+            tcg_gen_addi_ptr(s->ptr0, cpu_env, op2_offset);
             if (ot == MO_32) {
                 SSEFunc_i_ep sse_fn_i_ep =
                     sse_op_table3bi[((b >> 7) & 2) | (b & 1)];
-                sse_fn_i_ep(cpu_tmp2_i32, cpu_env, cpu_ptr0);
+                sse_fn_i_ep(cpu_tmp2_i32, cpu_env, s->ptr0);
                 tcg_gen_extu_i32_tl(s->T0, cpu_tmp2_i32);
             } else {
 #ifdef TARGET_X86_64
                 SSEFunc_l_ep sse_fn_l_ep =
                     sse_op_table3bq[((b >> 7) & 2) | (b & 1)];
-                sse_fn_l_ep(s->T0, cpu_env, cpu_ptr0);
+                sse_fn_l_ep(s->T0, cpu_env, s->ptr0);
 #else
                 goto illegal_op;
 #endif
@@ -3665,12 +3666,14 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 goto illegal_op;
             if (b1) {
                 rm = (modrm & 7) | REX_B(s);
-                tcg_gen_addi_ptr(cpu_ptr0, cpu_env, offsetof(CPUX86State,xmm_regs[rm]));
-                gen_helper_pmovmskb_xmm(cpu_tmp2_i32, cpu_env, cpu_ptr0);
+                tcg_gen_addi_ptr(s->ptr0, cpu_env,
+                                 offsetof(CPUX86State, xmm_regs[rm]));
+                gen_helper_pmovmskb_xmm(cpu_tmp2_i32, cpu_env, s->ptr0);
             } else {
                 rm = (modrm & 7);
-                tcg_gen_addi_ptr(cpu_ptr0, cpu_env, offsetof(CPUX86State,fpregs[rm].mmx));
-                gen_helper_pmovmskb_mmx(cpu_tmp2_i32, cpu_env, cpu_ptr0);
+                tcg_gen_addi_ptr(s->ptr0, cpu_env,
+                                 offsetof(CPUX86State, fpregs[rm].mmx));
+                gen_helper_pmovmskb_mmx(cpu_tmp2_i32, cpu_env, s->ptr0);
             }
             reg = ((modrm >> 3) & 7) | rex_r;
             tcg_gen_extu_i32_tl(cpu_regs[reg], cpu_tmp2_i32);
@@ -3745,9 +3748,9 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 goto unknown_op;
             }
 
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
+            tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
             tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
-            sse_fn_epp(cpu_env, cpu_ptr0, cpu_ptr1);
+            sse_fn_epp(cpu_env, s->ptr0, cpu_ptr1);
 
             if (b == 0x17) {
                 set_cc_op(s, CC_OP_EFLAGS);
@@ -4294,9 +4297,9 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 }
             }
 
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
+            tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
             tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
-            sse_fn_eppi(cpu_env, cpu_ptr0, cpu_ptr1, tcg_const_i32(val));
+            sse_fn_eppi(cpu_env, s->ptr0, cpu_ptr1, tcg_const_i32(val));
             break;
 
         case 0x33a:
@@ -4417,18 +4420,18 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             if (!(s->cpuid_ext2_features & CPUID_EXT2_3DNOW)) {
                 goto illegal_op;
             }
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
+            tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
             tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
-            sse_fn_epp(cpu_env, cpu_ptr0, cpu_ptr1);
+            sse_fn_epp(cpu_env, s->ptr0, cpu_ptr1);
             break;
         case 0x70: /* pshufx insn */
         case 0xc6: /* pshufx insn */
             val = x86_ldub_code(env, s);
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
+            tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
             tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
             /* XXX: introduce a new table? */
             sse_fn_ppi = (SSEFunc_0_ppi)sse_fn_epp;
-            sse_fn_ppi(cpu_ptr0, cpu_ptr1, tcg_const_i32(val));
+            sse_fn_ppi(s->ptr0, cpu_ptr1, tcg_const_i32(val));
             break;
         case 0xc2:
             /* compare insns */
@@ -4437,9 +4440,9 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 goto unknown_op;
             sse_fn_epp = sse_op_table4[val][b1];
 
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
+            tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
             tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
-            sse_fn_epp(cpu_env, cpu_ptr0, cpu_ptr1);
+            sse_fn_epp(cpu_env, s->ptr0, cpu_ptr1);
             break;
         case 0xf7:
             /* maskmov : we must prepare A0 */
@@ -4449,16 +4452,16 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             gen_extu(s->aflag, s->A0);
             gen_add_A0_ds_seg(s);
 
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
+            tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
             tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
             /* XXX: introduce a new table? */
             sse_fn_eppt = (SSEFunc_0_eppt)sse_fn_epp;
-            sse_fn_eppt(cpu_env, cpu_ptr0, cpu_ptr1, s->A0);
+            sse_fn_eppt(cpu_env, s->ptr0, cpu_ptr1, s->A0);
             break;
         default:
-            tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
+            tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
             tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
-            sse_fn_epp(cpu_env, cpu_ptr0, cpu_ptr1);
+            sse_fn_epp(cpu_env, s->ptr0, cpu_ptr1);
             break;
         }
         if (b == 0x2e || b == 0x2f) {
@@ -8484,7 +8487,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     cpu_tmp2_i32 = tcg_temp_new_i32();
     cpu_tmp3_i32 = tcg_temp_new_i32();
     dc->tmp4 = tcg_temp_new();
-    cpu_ptr0 = tcg_temp_new_ptr();
+    dc->ptr0 = tcg_temp_new_ptr();
     cpu_ptr1 = tcg_temp_new_ptr();
     dc->cc_srcT = tcg_temp_local_new();
 }
-- 
2.17.1
