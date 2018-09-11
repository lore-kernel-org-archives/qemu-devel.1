Received: from eggs.gnu.org ([2001:4830:134:3::10]:58677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGy-0000QN-T0
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGt-0002Xb-Jk
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45809)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzpGt-0002XD-Cf
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Sep 2018 16:28:18 -0400
Message-Id: <20180911202823.21657-9-cota@braap.org>
In-Reply-To: <20180911202823.21657-1-cota@braap.org>
References: <20180911202823.21657-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 08/13] target/i386: move cpu_ptr1 to
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
 target/i386/translate.c | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 9531dafebe..c51f61ca2c 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -79,7 +79,6 @@ static TCGv cpu_seg_base[6];
 static TCGv_i64 cpu_bndl[4];
 static TCGv_i64 cpu_bndu[4];
 
-static TCGv_ptr cpu_ptr1;
 static TCGv_i32 cpu_tmp2_i32, cpu_tmp3_i32;
 static TCGv_i64 cpu_tmp1_i64;
 
@@ -142,6 +141,7 @@ typedef struct DisasContext {
     TCGv tmp0;
     TCGv tmp4;
     TCGv_ptr ptr0;
+    TCGv_ptr ptr1;
 
     sigjmp_buf jmpbuf;
 } DisasContext;
@@ -3473,8 +3473,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 op2_offset = offsetof(CPUX86State,fpregs[rm].mmx);
             }
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op2_offset);
-            tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op1_offset);
-            sse_fn_epp(cpu_env, s->ptr0, cpu_ptr1);
+            tcg_gen_addi_ptr(s->ptr1, cpu_env, op1_offset);
+            sse_fn_epp(cpu_env, s->ptr0, s->ptr1);
             break;
         case 0x050: /* movmskps */
             rm = (modrm & 7) | REX_B(s);
@@ -3503,14 +3503,14 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             }
             op1_offset = offsetof(CPUX86State,xmm_regs[reg]);
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
-            tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
+            tcg_gen_addi_ptr(s->ptr1, cpu_env, op2_offset);
             switch(b >> 8) {
             case 0x0:
-                gen_helper_cvtpi2ps(cpu_env, s->ptr0, cpu_ptr1);
+                gen_helper_cvtpi2ps(cpu_env, s->ptr0, s->ptr1);
                 break;
             default:
             case 0x1:
-                gen_helper_cvtpi2pd(cpu_env, s->ptr0, cpu_ptr1);
+                gen_helper_cvtpi2pd(cpu_env, s->ptr0, s->ptr1);
                 break;
             }
             break;
@@ -3548,19 +3548,19 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             }
             op1_offset = offsetof(CPUX86State,fpregs[reg & 7].mmx);
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
-            tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
+            tcg_gen_addi_ptr(s->ptr1, cpu_env, op2_offset);
             switch(b) {
             case 0x02c:
-                gen_helper_cvttps2pi(cpu_env, s->ptr0, cpu_ptr1);
+                gen_helper_cvttps2pi(cpu_env, s->ptr0, s->ptr1);
                 break;
             case 0x12c:
-                gen_helper_cvttpd2pi(cpu_env, s->ptr0, cpu_ptr1);
+                gen_helper_cvttpd2pi(cpu_env, s->ptr0, s->ptr1);
                 break;
             case 0x02d:
-                gen_helper_cvtps2pi(cpu_env, s->ptr0, cpu_ptr1);
+                gen_helper_cvtps2pi(cpu_env, s->ptr0, s->ptr1);
                 break;
             case 0x12d:
-                gen_helper_cvtpd2pi(cpu_env, s->ptr0, cpu_ptr1);
+                gen_helper_cvtpd2pi(cpu_env, s->ptr0, s->ptr1);
                 break;
             }
             break;
@@ -3749,8 +3749,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             }
 
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
-            tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
-            sse_fn_epp(cpu_env, s->ptr0, cpu_ptr1);
+            tcg_gen_addi_ptr(s->ptr1, cpu_env, op2_offset);
+            sse_fn_epp(cpu_env, s->ptr0, s->ptr1);
 
             if (b == 0x17) {
                 set_cc_op(s, CC_OP_EFLAGS);
@@ -4298,8 +4298,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             }
 
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
-            tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
-            sse_fn_eppi(cpu_env, s->ptr0, cpu_ptr1, tcg_const_i32(val));
+            tcg_gen_addi_ptr(s->ptr1, cpu_env, op2_offset);
+            sse_fn_eppi(cpu_env, s->ptr0, s->ptr1, tcg_const_i32(val));
             break;
 
         case 0x33a:
@@ -4421,17 +4421,17 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 goto illegal_op;
             }
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
-            tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
-            sse_fn_epp(cpu_env, s->ptr0, cpu_ptr1);
+            tcg_gen_addi_ptr(s->ptr1, cpu_env, op2_offset);
+            sse_fn_epp(cpu_env, s->ptr0, s->ptr1);
             break;
         case 0x70: /* pshufx insn */
         case 0xc6: /* pshufx insn */
             val = x86_ldub_code(env, s);
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
-            tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
+            tcg_gen_addi_ptr(s->ptr1, cpu_env, op2_offset);
             /* XXX: introduce a new table? */
             sse_fn_ppi = (SSEFunc_0_ppi)sse_fn_epp;
-            sse_fn_ppi(s->ptr0, cpu_ptr1, tcg_const_i32(val));
+            sse_fn_ppi(s->ptr0, s->ptr1, tcg_const_i32(val));
             break;
         case 0xc2:
             /* compare insns */
@@ -4441,8 +4441,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             sse_fn_epp = sse_op_table4[val][b1];
 
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
-            tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
-            sse_fn_epp(cpu_env, s->ptr0, cpu_ptr1);
+            tcg_gen_addi_ptr(s->ptr1, cpu_env, op2_offset);
+            sse_fn_epp(cpu_env, s->ptr0, s->ptr1);
             break;
         case 0xf7:
             /* maskmov : we must prepare A0 */
@@ -4453,15 +4453,15 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             gen_add_A0_ds_seg(s);
 
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
-            tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
+            tcg_gen_addi_ptr(s->ptr1, cpu_env, op2_offset);
             /* XXX: introduce a new table? */
             sse_fn_eppt = (SSEFunc_0_eppt)sse_fn_epp;
-            sse_fn_eppt(cpu_env, s->ptr0, cpu_ptr1, s->A0);
+            sse_fn_eppt(cpu_env, s->ptr0, s->ptr1, s->A0);
             break;
         default:
             tcg_gen_addi_ptr(s->ptr0, cpu_env, op1_offset);
-            tcg_gen_addi_ptr(cpu_ptr1, cpu_env, op2_offset);
-            sse_fn_epp(cpu_env, s->ptr0, cpu_ptr1);
+            tcg_gen_addi_ptr(s->ptr1, cpu_env, op2_offset);
+            sse_fn_epp(cpu_env, s->ptr0, s->ptr1);
             break;
         }
         if (b == 0x2e || b == 0x2f) {
@@ -8488,7 +8488,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     cpu_tmp3_i32 = tcg_temp_new_i32();
     dc->tmp4 = tcg_temp_new();
     dc->ptr0 = tcg_temp_new_ptr();
-    cpu_ptr1 = tcg_temp_new_ptr();
+    dc->ptr1 = tcg_temp_new_ptr();
     dc->cc_srcT = tcg_temp_local_new();
 }
 
-- 
2.17.1
