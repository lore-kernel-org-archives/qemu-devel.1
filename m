Received: from eggs.gnu.org ([2001:4830:134:3::10]:58766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpHC-0000f2-5H
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpH7-0002ff-M8
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42251)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzpH6-0002Xj-TR
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Sep 2018 16:28:21 -0400
Message-Id: <20180911202823.21657-12-cota@braap.org>
In-Reply-To: <20180911202823.21657-1-cota@braap.org>
References: <20180911202823.21657-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 11/13] target/i386: move cpu_tmp1_i64 to
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
 target/i386/translate.c | 160 ++++++++++++++++++++--------------------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index cd880cc2a8..61a98ef872 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -79,8 +79,6 @@ static TCGv cpu_seg_base[6];
 static TCGv_i64 cpu_bndl[4];
 static TCGv_i64 cpu_bndu[4];
 
-static TCGv_i64 cpu_tmp1_i64;
-
 #include "exec/gen-icount.h"
 
 #ifdef TARGET_X86_64
@@ -143,6 +141,7 @@ typedef struct DisasContext {
     TCGv_ptr ptr1;
     TCGv_i32 tmp2_i32;
     TCGv_i32 tmp3_i32;
+    TCGv_i64 tmp1_i64;
 
     sigjmp_buf jmpbuf;
 } DisasContext;
@@ -2107,12 +2106,12 @@ static void gen_bndck(CPUX86State *env, DisasContext *s, int modrm,
 {
     TCGv ea = gen_lea_modrm_1(s, gen_lea_modrm_0(env, s, modrm));
 
-    tcg_gen_extu_tl_i64(cpu_tmp1_i64, ea);
+    tcg_gen_extu_tl_i64(s->tmp1_i64, ea);
     if (!CODE64(s)) {
-        tcg_gen_ext32u_i64(cpu_tmp1_i64, cpu_tmp1_i64);
+        tcg_gen_ext32u_i64(s->tmp1_i64, s->tmp1_i64);
     }
-    tcg_gen_setcond_i64(cond, cpu_tmp1_i64, cpu_tmp1_i64, bndv);
-    tcg_gen_extrl_i64_i32(s->tmp2_i32, cpu_tmp1_i64);
+    tcg_gen_setcond_i64(cond, s->tmp1_i64, s->tmp1_i64, bndv);
+    tcg_gen_extrl_i64_i32(s->tmp2_i32, s->tmp1_i64);
     gen_helper_bndck(cpu_env, s->tmp2_i32);
 }
 
@@ -2641,48 +2640,48 @@ static void gen_jmp(DisasContext *s, target_ulong eip)
 
 static inline void gen_ldq_env_A0(DisasContext *s, int offset)
 {
-    tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0, s->mem_index, MO_LEQ);
-    tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, offset);
+    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, s->mem_index, MO_LEQ);
+    tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset);
 }
 
 static inline void gen_stq_env_A0(DisasContext *s, int offset)
 {
-    tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env, offset);
-    tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0, s->mem_index, MO_LEQ);
+    tcg_gen_ld_i64(s->tmp1_i64, cpu_env, offset);
+    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0, s->mem_index, MO_LEQ);
 }
 
 static inline void gen_ldo_env_A0(DisasContext *s, int offset)
 {
     int mem_index = s->mem_index;
-    tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0, mem_index, MO_LEQ);
-    tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(0)));
+    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, mem_index, MO_LEQ);
+    tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(0)));
     tcg_gen_addi_tl(s->tmp0, s->A0, 8);
-    tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->tmp0, mem_index, MO_LEQ);
-    tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(1)));
+    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEQ);
+    tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(1)));
 }
 
 static inline void gen_sto_env_A0(DisasContext *s, int offset)
 {
     int mem_index = s->mem_index;
-    tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(0)));
-    tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0, mem_index, MO_LEQ);
+    tcg_gen_ld_i64(s->tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(0)));
+    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0, mem_index, MO_LEQ);
     tcg_gen_addi_tl(s->tmp0, s->A0, 8);
-    tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(1)));
-    tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->tmp0, mem_index, MO_LEQ);
+    tcg_gen_ld_i64(s->tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(1)));
+    tcg_gen_qemu_st_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEQ);
 }
 
-static inline void gen_op_movo(int d_offset, int s_offset)
+static inline void gen_op_movo(DisasContext *s, int d_offset, int s_offset)
 {
-    tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env, s_offset + offsetof(ZMMReg, ZMM_Q(0)));
-    tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, d_offset + offsetof(ZMMReg, ZMM_Q(0)));
-    tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env, s_offset + offsetof(ZMMReg, ZMM_Q(1)));
-    tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, d_offset + offsetof(ZMMReg, ZMM_Q(1)));
+    tcg_gen_ld_i64(s->tmp1_i64, cpu_env, s_offset + offsetof(ZMMReg, ZMM_Q(0)));
+    tcg_gen_st_i64(s->tmp1_i64, cpu_env, d_offset + offsetof(ZMMReg, ZMM_Q(0)));
+    tcg_gen_ld_i64(s->tmp1_i64, cpu_env, s_offset + offsetof(ZMMReg, ZMM_Q(1)));
+    tcg_gen_st_i64(s->tmp1_i64, cpu_env, d_offset + offsetof(ZMMReg, ZMM_Q(1)));
 }
 
-static inline void gen_op_movq(int d_offset, int s_offset)
+static inline void gen_op_movq(DisasContext *s, int d_offset, int s_offset)
 {
-    tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env, s_offset);
-    tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, d_offset);
+    tcg_gen_ld_i64(s->tmp1_i64, cpu_env, s_offset);
+    tcg_gen_st_i64(s->tmp1_i64, cpu_env, d_offset);
 }
 
 static inline void gen_op_movl(DisasContext *s, int d_offset, int s_offset)
@@ -2691,10 +2690,10 @@ static inline void gen_op_movl(DisasContext *s, int d_offset, int s_offset)
     tcg_gen_st_i32(s->tmp2_i32, cpu_env, d_offset);
 }
 
-static inline void gen_op_movq_env_0(int d_offset)
+static inline void gen_op_movq_env_0(DisasContext *s, int d_offset)
 {
-    tcg_gen_movi_i64(cpu_tmp1_i64, 0);
-    tcg_gen_st_i64(cpu_tmp1_i64, cpu_env, d_offset);
+    tcg_gen_movi_i64(s->tmp1_i64, 0);
+    tcg_gen_st_i64(s->tmp1_i64, cpu_env, d_offset);
 }
 
 typedef void (*SSEFunc_i_ep)(TCGv_i32 val, TCGv_ptr env, TCGv_ptr reg);
@@ -3178,9 +3177,9 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 gen_ldq_env_A0(s, offsetof(CPUX86State, fpregs[reg].mmx));
             } else {
                 rm = (modrm & 7);
-                tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env,
+                tcg_gen_ld_i64(s->tmp1_i64, cpu_env,
                                offsetof(CPUX86State,fpregs[rm].mmx));
-                tcg_gen_st_i64(cpu_tmp1_i64, cpu_env,
+                tcg_gen_st_i64(s->tmp1_i64, cpu_env,
                                offsetof(CPUX86State,fpregs[reg].mmx));
             }
             break;
@@ -3195,7 +3194,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 gen_ldo_env_A0(s, offsetof(CPUX86State, xmm_regs[reg]));
             } else {
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movo(offsetof(CPUX86State,xmm_regs[reg]),
+                gen_op_movo(s, offsetof(CPUX86State, xmm_regs[reg]),
                             offsetof(CPUX86State,xmm_regs[rm]));
             }
             break;
@@ -3230,7 +3229,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                                 offsetof(CPUX86State, xmm_regs[reg].ZMM_L(3)));
             } else {
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movq(offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(0)),
+                gen_op_movq(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_Q(0)),
                             offsetof(CPUX86State,xmm_regs[rm].ZMM_Q(0)));
             }
             break;
@@ -3243,7 +3242,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             } else {
                 /* movhlps */
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movq(offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(0)),
+                gen_op_movq(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_Q(0)),
                             offsetof(CPUX86State,xmm_regs[rm].ZMM_Q(1)));
             }
             break;
@@ -3270,10 +3269,10 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                                            xmm_regs[reg].ZMM_Q(0)));
             } else {
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movq(offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(0)),
+                gen_op_movq(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_Q(0)),
                             offsetof(CPUX86State,xmm_regs[rm].ZMM_Q(0)));
             }
-            gen_op_movq(offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(1)),
+            gen_op_movq(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_Q(1)),
                         offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(0)));
             break;
         case 0x016: /* movhps */
@@ -3285,7 +3284,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             } else {
                 /* movlhps */
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movq(offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(1)),
+                gen_op_movq(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_Q(1)),
                             offsetof(CPUX86State,xmm_regs[rm].ZMM_Q(0)));
             }
             break;
@@ -3361,10 +3360,10 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                                            xmm_regs[reg].ZMM_Q(0)));
             } else {
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movq(offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(0)),
+                gen_op_movq(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_Q(0)),
                             offsetof(CPUX86State,xmm_regs[rm].ZMM_Q(0)));
             }
-            gen_op_movq_env_0(offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(1)));
+            gen_op_movq_env_0(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_Q(1)));
             break;
         case 0x7f: /* movq ea, mm */
             if (mod != 3) {
@@ -3372,7 +3371,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 gen_stq_env_A0(s, offsetof(CPUX86State, fpregs[reg].mmx));
             } else {
                 rm = (modrm & 7);
-                gen_op_movq(offsetof(CPUX86State,fpregs[rm].mmx),
+                gen_op_movq(s, offsetof(CPUX86State, fpregs[rm].mmx),
                             offsetof(CPUX86State,fpregs[reg].mmx));
             }
             break;
@@ -3387,7 +3386,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 gen_sto_env_A0(s, offsetof(CPUX86State, xmm_regs[reg]));
             } else {
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movo(offsetof(CPUX86State,xmm_regs[rm]),
+                gen_op_movo(s, offsetof(CPUX86State, xmm_regs[rm]),
                             offsetof(CPUX86State,xmm_regs[reg]));
             }
             break;
@@ -3410,7 +3409,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                                            xmm_regs[reg].ZMM_Q(0)));
             } else {
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movq(offsetof(CPUX86State,xmm_regs[rm].ZMM_Q(0)),
+                gen_op_movq(s, offsetof(CPUX86State, xmm_regs[rm].ZMM_Q(0)),
                             offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(0)));
             }
             break;
@@ -3643,22 +3642,23 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                                            xmm_regs[reg].ZMM_Q(0)));
             } else {
                 rm = (modrm & 7) | REX_B(s);
-                gen_op_movq(offsetof(CPUX86State,xmm_regs[rm].ZMM_Q(0)),
+                gen_op_movq(s, offsetof(CPUX86State, xmm_regs[rm].ZMM_Q(0)),
                             offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(0)));
-                gen_op_movq_env_0(offsetof(CPUX86State,xmm_regs[rm].ZMM_Q(1)));
+                gen_op_movq_env_0(s,
+                                  offsetof(CPUX86State, xmm_regs[rm].ZMM_Q(1)));
             }
             break;
         case 0x2d6: /* movq2dq */
             gen_helper_enter_mmx(cpu_env);
             rm = (modrm & 7);
-            gen_op_movq(offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(0)),
+            gen_op_movq(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_Q(0)),
                         offsetof(CPUX86State,fpregs[rm].mmx));
-            gen_op_movq_env_0(offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(1)));
+            gen_op_movq_env_0(s, offsetof(CPUX86State, xmm_regs[reg].ZMM_Q(1)));
             break;
         case 0x3d6: /* movdq2q */
             gen_helper_enter_mmx(cpu_env);
             rm = (modrm & 7) | REX_B(s);
-            gen_op_movq(offsetof(CPUX86State,fpregs[reg & 7].mmx),
+            gen_op_movq(s, offsetof(CPUX86State, fpregs[reg & 7].mmx),
                         offsetof(CPUX86State,xmm_regs[rm].ZMM_Q(0)));
             break;
         case 0xd7: /* pmovmskb */
@@ -4174,13 +4174,13 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                         }
                     } else { /* pextrq */
 #ifdef TARGET_X86_64
-                        tcg_gen_ld_i64(cpu_tmp1_i64, cpu_env,
+                        tcg_gen_ld_i64(s->tmp1_i64, cpu_env,
                                         offsetof(CPUX86State,
                                                 xmm_regs[reg].ZMM_Q(val & 1)));
                         if (mod == 3) {
-                            tcg_gen_mov_i64(cpu_regs[rm], cpu_tmp1_i64);
+                            tcg_gen_mov_i64(cpu_regs[rm], s->tmp1_i64);
                         } else {
-                            tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0,
+                            tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
                                                 s->mem_index, MO_LEQ);
                         }
 #else
@@ -4251,12 +4251,12 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     } else { /* pinsrq */
 #ifdef TARGET_X86_64
                         if (mod == 3) {
-                            gen_op_mov_v_reg(ot, cpu_tmp1_i64, rm);
+                            gen_op_mov_v_reg(ot, s->tmp1_i64, rm);
                         } else {
-                            tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0,
+                            tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
                                                 s->mem_index, MO_LEQ);
                         }
-                        tcg_gen_st_i64(cpu_tmp1_i64, cpu_env,
+                        tcg_gen_st_i64(s->tmp1_i64, cpu_env,
                                         offsetof(CPUX86State,
                                                 xmm_regs[reg].ZMM_Q(val & 1)));
 #else
@@ -5831,9 +5831,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                         gen_helper_fildl_FT0(cpu_env, s->tmp2_i32);
                         break;
                     case 2:
-                        tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0,
+                        tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
                                             s->mem_index, MO_LEQ);
-                        gen_helper_fldl_FT0(cpu_env, cpu_tmp1_i64);
+                        gen_helper_fldl_FT0(cpu_env, s->tmp1_i64);
                         break;
                     case 3:
                     default:
@@ -5870,9 +5870,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                         gen_helper_fildl_ST0(cpu_env, s->tmp2_i32);
                         break;
                     case 2:
-                        tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0,
+                        tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
                                             s->mem_index, MO_LEQ);
-                        gen_helper_fldl_ST0(cpu_env, cpu_tmp1_i64);
+                        gen_helper_fldl_ST0(cpu_env, s->tmp1_i64);
                         break;
                     case 3:
                     default:
@@ -5891,8 +5891,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                                             s->mem_index, MO_LEUL);
                         break;
                     case 2:
-                        gen_helper_fisttll_ST0(cpu_tmp1_i64, cpu_env);
-                        tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0,
+                        gen_helper_fisttll_ST0(s->tmp1_i64, cpu_env);
+                        tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
                                             s->mem_index, MO_LEQ);
                         break;
                     case 3:
@@ -5917,8 +5917,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                                             s->mem_index, MO_LEUL);
                         break;
                     case 2:
-                        gen_helper_fstl_ST0(cpu_tmp1_i64, cpu_env);
-                        tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0,
+                        gen_helper_fstl_ST0(s->tmp1_i64, cpu_env);
+                        tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
                                             s->mem_index, MO_LEQ);
                         break;
                     case 3:
@@ -5975,12 +5975,12 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_helper_fpop(cpu_env);
                 break;
             case 0x3d: /* fildll */
-                tcg_gen_qemu_ld_i64(cpu_tmp1_i64, s->A0, s->mem_index, MO_LEQ);
-                gen_helper_fildll_ST0(cpu_env, cpu_tmp1_i64);
+                tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, s->mem_index, MO_LEQ);
+                gen_helper_fildll_ST0(cpu_env, s->tmp1_i64);
                 break;
             case 0x3f: /* fistpll */
-                gen_helper_fistll_ST0(cpu_tmp1_i64, cpu_env);
-                tcg_gen_qemu_st_i64(cpu_tmp1_i64, s->A0, s->mem_index, MO_LEQ);
+                gen_helper_fistll_ST0(s->tmp1_i64, cpu_env);
+                tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0, s->mem_index, MO_LEQ);
                 gen_helper_fpop(cpu_env);
                 break;
             default:
@@ -7387,8 +7387,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_xgetbv(cpu_tmp1_i64, cpu_env, s->tmp2_i32);
-            tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], cpu_tmp1_i64);
+            gen_helper_xgetbv(s->tmp1_i64, cpu_env, s->tmp2_i32);
+            tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
             break;
 
         case 0xd1: /* xsetbv */
@@ -7401,10 +7401,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
                 break;
             }
-            tcg_gen_concat_tl_i64(cpu_tmp1_i64, cpu_regs[R_EAX],
+            tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_xsetbv(cpu_env, s->tmp2_i32, cpu_tmp1_i64);
+            gen_helper_xsetbv(cpu_env, s->tmp2_i32, s->tmp1_i64);
             /* End TB because translation flags may change.  */
             gen_jmp_im(s, s->pc - s->cs_base);
             gen_eob(s);
@@ -7564,17 +7564,17 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_rdpkru(cpu_tmp1_i64, cpu_env, s->tmp2_i32);
-            tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], cpu_tmp1_i64);
+            gen_helper_rdpkru(s->tmp1_i64, cpu_env, s->tmp2_i32);
+            tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
             break;
         case 0xef: /* wrpkru */
             if (prefixes & PREFIX_LOCK) {
                 goto illegal_op;
             }
-            tcg_gen_concat_tl_i64(cpu_tmp1_i64, cpu_regs[R_EAX],
+            tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
-            gen_helper_wrpkru(cpu_env, s->tmp2_i32, cpu_tmp1_i64);
+            gen_helper_wrpkru(cpu_env, s->tmp2_i32, s->tmp1_i64);
             break;
         CASE_MODRM_OP(6): /* lmsw */
             if (s->cpl != 0) {
@@ -8141,9 +8141,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_lea_modrm(env, s, modrm);
-            tcg_gen_concat_tl_i64(cpu_tmp1_i64, cpu_regs[R_EAX],
+            tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
-            gen_helper_xsave(cpu_env, s->A0, cpu_tmp1_i64);
+            gen_helper_xsave(cpu_env, s->A0, s->tmp1_i64);
             break;
 
         CASE_MODRM_MEM_OP(5): /* xrstor */
@@ -8153,9 +8153,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_lea_modrm(env, s, modrm);
-            tcg_gen_concat_tl_i64(cpu_tmp1_i64, cpu_regs[R_EAX],
+            tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
-            gen_helper_xrstor(cpu_env, s->A0, cpu_tmp1_i64);
+            gen_helper_xrstor(cpu_env, s->A0, s->tmp1_i64);
             /* XRSTOR is how MPX is enabled, which changes how
                we translate.  Thus we need to end the TB.  */
             gen_update_cc_op(s);
@@ -8181,9 +8181,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     goto illegal_op;
                 }
                 gen_lea_modrm(env, s, modrm);
-                tcg_gen_concat_tl_i64(cpu_tmp1_i64, cpu_regs[R_EAX],
+                tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
                                       cpu_regs[R_EDX]);
-                gen_helper_xsaveopt(cpu_env, s->A0, cpu_tmp1_i64);
+                gen_helper_xsaveopt(cpu_env, s->A0, s->tmp1_i64);
             }
             break;
 
@@ -8484,7 +8484,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->A0 = tcg_temp_new();
 
     dc->tmp0 = tcg_temp_new();
-    cpu_tmp1_i64 = tcg_temp_new_i64();
+    dc->tmp1_i64 = tcg_temp_new_i64();
     dc->tmp2_i32 = tcg_temp_new_i32();
     dc->tmp3_i32 = tcg_temp_new_i32();
     dc->tmp4 = tcg_temp_new();
-- 
2.17.1
