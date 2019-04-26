Received: from eggs.gnu.org ([209.51.188.92]:60266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0i-0005dF-JV
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0b-0004ZP-QF
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:00 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:14 +1000
Message-Id: <20190426060627.18153-24-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/36] target/ppc: Style fixes for translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/translate.c | 504 +++++++++++++++++++++++++----------------
 1 file changed, 313 insertions(+), 191 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 93d77a2626..c280e0d306 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -42,8 +42,8 @@
 #define GDBSTUB_SINGLE_STEP 0x4
=20
 /* Include definitions for instructions classes and implementations flag=
s */
-//#define PPC_DEBUG_DISAS
-//#define DO_PPC_STATISTICS
+/* #define PPC_DEBUG_DISAS */
+/* #define DO_PPC_STATISTICS */
=20
 #ifdef PPC_DEBUG_DISAS
 #  define LOG_DISAS(...) qemu_log_mask(CPU_LOG_TB_IN_ASM, ## __VA_ARGS__=
)
@@ -54,9 +54,9 @@
 /* Code translation helpers                                             =
     */
=20
 /* global register indexes */
-static char cpu_reg_names[10*3 + 22*4 /* GPR */
-    + 10*4 + 22*5 /* SPE GPRh */
-    + 8*5 /* CRF */];
+static char cpu_reg_names[10 * 3 + 22 * 4   /* GPR */
+                          + 10 * 4 + 22 * 5 /* SPE GPRh */
+                          + 8 * 5           /* CRF */];
 static TCGv cpu_gpr[32];
 static TCGv cpu_gprh[32];
 static TCGv_i32 cpu_crf[8];
@@ -78,7 +78,7 @@ static TCGv_i32 cpu_access_type;
 void ppc_translate_init(void)
 {
     int i;
-    char* p;
+    char *p;
     size_t cpu_reg_names_size;
=20
     p =3D cpu_reg_names;
@@ -146,7 +146,8 @@ void ppc_translate_init(void)
                                    offsetof(CPUPPCState, fpscr), "fpscr"=
);
=20
     cpu_access_type =3D tcg_global_mem_new_i32(cpu_env,
-                                             offsetof(CPUPPCState, acces=
s_type), "access_type");
+                                             offsetof(CPUPPCState, acces=
s_type),
+                                             "access_type");
 }
=20
 /* internal defines */
@@ -246,8 +247,9 @@ static void gen_exception_err(DisasContext *ctx, uint=
32_t excp, uint32_t error)
 {
     TCGv_i32 t0, t1;
=20
-    /* These are all synchronous exceptions, we set the PC back to
-     * the faulting instruction
+    /*
+     * These are all synchronous exceptions, we set the PC back to the
+     * faulting instruction
      */
     if (ctx->exception =3D=3D POWERPC_EXCP_NONE) {
         gen_update_nip(ctx, ctx->base.pc_next - 4);
@@ -264,8 +266,9 @@ static void gen_exception(DisasContext *ctx, uint32_t=
 excp)
 {
     TCGv_i32 t0;
=20
-    /* These are all synchronous exceptions, we set the PC back to
-     * the faulting instruction
+    /*
+     * These are all synchronous exceptions, we set the PC back to the
+     * faulting instruction
      */
     if (ctx->exception =3D=3D POWERPC_EXCP_NONE) {
         gen_update_nip(ctx, ctx->base.pc_next - 4);
@@ -320,8 +323,9 @@ static void gen_debug_exception(DisasContext *ctx)
 {
     TCGv_i32 t0;
=20
-    /* These are all synchronous exceptions, we set the PC back to
-     * the faulting instruction
+    /*
+     * These are all synchronous exceptions, we set the PC back to the
+     * faulting instruction
      */
     if ((ctx->exception !=3D POWERPC_EXCP_BRANCH) &&
         (ctx->exception !=3D POWERPC_EXCP_SYNC)) {
@@ -602,9 +606,11 @@ static inline void gen_op_cmp(TCGv arg0, TCGv arg1, =
int s, int crf)
=20
     tcg_gen_movi_tl(t0, CRF_EQ);
     tcg_gen_movi_tl(t1, CRF_LT);
-    tcg_gen_movcond_tl((s ? TCG_COND_LT : TCG_COND_LTU), t0, arg0, arg1,=
 t1, t0);
+    tcg_gen_movcond_tl((s ? TCG_COND_LT : TCG_COND_LTU),
+                       t0, arg0, arg1, t1, t0);
     tcg_gen_movi_tl(t1, CRF_GT);
-    tcg_gen_movcond_tl((s ? TCG_COND_GT : TCG_COND_GTU), t0, arg0, arg1,=
 t1, t0);
+    tcg_gen_movcond_tl((s ? TCG_COND_GT : TCG_COND_GTU),
+                       t0, arg0, arg1, t1, t0);
=20
     tcg_gen_trunc_tl_i32(t, t0);
     tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
@@ -840,9 +846,11 @@ static inline void gen_op_arith_add(DisasContext *ct=
x, TCGv ret, TCGv arg1,
=20
     if (compute_ca) {
         if (NARROW_MODE(ctx)) {
-            /* Caution: a non-obvious corner case of the spec is that we
-               must produce the *entire* 64-bit addition, but produce th=
e
-               carry into bit 32.  */
+            /*
+             * Caution: a non-obvious corner case of the spec is that
+             * we must produce the *entire* 64-bit addition, but
+             * produce the carry into bit 32.
+             */
             TCGv t1 =3D tcg_temp_new();
             tcg_gen_xor_tl(t1, arg1, arg2);        /* add without carry =
*/
             tcg_gen_add_tl(t0, arg1, arg2);
@@ -1017,12 +1025,13 @@ static inline void gen_op_arith_divw(DisasContext=
 *ctx, TCGv ret, TCGv arg1,
     tcg_temp_free_i32(t2);
     tcg_temp_free_i32(t3);
=20
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, ret);
+    }
 }
 /* Div functions */
 #define GEN_INT_ARITH_DIVW(name, opc3, sign, compute_ov)                =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     gen_op_arith_divw(ctx, cpu_gpr[rD(ctx->opcode)],                    =
      \
                      cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],=
      \
@@ -1091,12 +1100,13 @@ static inline void gen_op_arith_divd(DisasContext=
 *ctx, TCGv ret, TCGv arg1,
     tcg_temp_free_i64(t2);
     tcg_temp_free_i64(t3);
=20
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, ret);
+    }
 }
=20
 #define GEN_INT_ARITH_DIVD(name, opc3, sign, compute_ov)                =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     gen_op_arith_divd(ctx, cpu_gpr[rD(ctx->opcode)],                    =
      \
                       cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]=
,     \
@@ -1219,8 +1229,9 @@ static void gen_mulhw(DisasContext *ctx)
     tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t1);
     tcg_temp_free_i32(t0);
     tcg_temp_free_i32(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* mulhwu  mulhwu.  */
@@ -1235,8 +1246,9 @@ static void gen_mulhwu(DisasContext *ctx)
     tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t1);
     tcg_temp_free_i32(t0);
     tcg_temp_free_i32(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* mullw  mullw. */
@@ -1255,8 +1267,9 @@ static void gen_mullw(DisasContext *ctx)
     tcg_gen_mul_i32(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
                     cpu_gpr[rB(ctx->opcode)]);
 #endif
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* mullwo  mullwo. */
@@ -1284,8 +1297,9 @@ static void gen_mullwo(DisasContext *ctx)
=20
     tcg_temp_free_i32(t0);
     tcg_temp_free_i32(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* mulli */
@@ -1325,8 +1339,9 @@ static void gen_mulld(DisasContext *ctx)
 {
     tcg_gen_mul_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
                    cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* mulldo  mulldo. */
@@ -1369,9 +1384,11 @@ static inline void gen_op_arith_subf(DisasContext =
*ctx, TCGv ret, TCGv arg1,
     if (compute_ca) {
         /* dest =3D ~arg1 + arg2 [+ ca].  */
         if (NARROW_MODE(ctx)) {
-            /* Caution: a non-obvious corner case of the spec is that we
-               must produce the *entire* 64-bit addition, but produce th=
e
-               carry into bit 32.  */
+            /*
+             * Caution: a non-obvious corner case of the spec is that
+             * we must produce the *entire* 64-bit addition, but
+             * produce the carry into bit 32.
+             */
             TCGv inv1 =3D tcg_temp_new();
             TCGv t1 =3D tcg_temp_new();
             tcg_gen_not_tl(inv1, arg1);
@@ -1404,8 +1421,10 @@ static inline void gen_op_arith_subf(DisasContext =
*ctx, TCGv ret, TCGv arg1,
             gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, cpu_ca32, 1);
         }
     } else if (add_ca) {
-        /* Since we're ignoring carry-out, we can simplify the
-           standard ~arg1 + arg2 + ca to arg2 - arg1 + ca - 1.  */
+        /*
+         * Since we're ignoring carry-out, we can simplify the
+         * standard ~arg1 + arg2 + ca to arg2 - arg1 + ca - 1.
+         */
         tcg_gen_sub_tl(t0, arg2, arg1);
         tcg_gen_add_tl(t0, t0, cpu_ca);
         tcg_gen_subi_tl(t0, t0, 1);
@@ -1493,7 +1512,7 @@ static void gen_nego(DisasContext *ctx)
=20
 /***                            Integer logical                         =
   ***/
 #define GEN_LOGICAL2(name, tcg_op, opc, type)                           =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     tcg_op(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],          =
      \
        cpu_gpr[rB(ctx->opcode)]);                                       =
      \
@@ -1502,7 +1521,7 @@ static void glue(gen_, name)(DisasContext *ctx)
 }
=20
 #define GEN_LOGICAL1(name, tcg_op, opc, type)                           =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     tcg_op(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);         =
      \
     if (unlikely(Rc(ctx->opcode) !=3D 0))                               =
        \
@@ -1517,14 +1536,16 @@ GEN_LOGICAL2(andc, tcg_gen_andc_tl, 0x01, PPC_INT=
EGER);
 /* andi. */
 static void gen_andi_(DisasContext *ctx)
 {
-    tcg_gen_andi_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], =
UIMM(ctx->opcode));
+    tcg_gen_andi_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],
+                    UIMM(ctx->opcode));
     gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
 }
=20
 /* andis. */
 static void gen_andis_(DisasContext *ctx)
 {
-    tcg_gen_andi_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], =
UIMM(ctx->opcode) << 16);
+    tcg_gen_andi_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],
+                    UIMM(ctx->opcode) << 16);
     gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
 }
=20
@@ -1538,8 +1559,9 @@ static void gen_cntlzw(DisasContext *ctx)
     tcg_gen_extu_i32_tl(cpu_gpr[rA(ctx->opcode)], t);
     tcg_temp_free_i32(t);
=20
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* cnttzw */
@@ -1591,12 +1613,14 @@ static void gen_or(DisasContext *ctx)
     rb =3D rB(ctx->opcode);
     /* Optimisation for mr. ri case */
     if (rs !=3D ra || rs !=3D rb) {
-        if (rs !=3D rb)
+        if (rs !=3D rb) {
             tcg_gen_or_tl(cpu_gpr[ra], cpu_gpr[rs], cpu_gpr[rb]);
-        else
+        } else {
             tcg_gen_mov_tl(cpu_gpr[ra], cpu_gpr[rs]);
-        if (unlikely(Rc(ctx->opcode) !=3D 0))
+        }
+        if (unlikely(Rc(ctx->opcode) !=3D 0)) {
             gen_set_Rc0(ctx, cpu_gpr[ra]);
+        }
     } else if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rs]);
 #if defined(TARGET_PPC64)
@@ -1654,10 +1678,11 @@ static void gen_or(DisasContext *ctx)
             tcg_temp_free(t0);
         }
 #if !defined(CONFIG_USER_ONLY)
-        /* Pause out of TCG otherwise spin loops with smt_low eat too mu=
ch
-         * CPU and the kernel hangs.  This applies to all encodings othe=
r
-         * than no-op, e.g., miso(rs=3D26), yield(27), mdoio(29), mdoom(=
30),
-         * and all currently undefined.
+        /*
+         * Pause out of TCG otherwise spin loops with smt_low eat too
+         * much CPU and the kernel hangs.  This applies to all
+         * encodings other than no-op, e.g., miso(rs=3D26), yield(27),
+         * mdoio(29), mdoom(30), and all currently undefined.
          */
         gen_pause(ctx);
 #endif
@@ -1671,12 +1696,15 @@ GEN_LOGICAL2(orc, tcg_gen_orc_tl, 0x0C, PPC_INTEG=
ER);
 static void gen_xor(DisasContext *ctx)
 {
     /* Optimisation for "set to zero" case */
-    if (rS(ctx->opcode) !=3D rB(ctx->opcode))
-        tcg_gen_xor_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)=
], cpu_gpr[rB(ctx->opcode)]);
-    else
+    if (rS(ctx->opcode) !=3D rB(ctx->opcode)) {
+        tcg_gen_xor_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)=
],
+                       cpu_gpr[rB(ctx->opcode)]);
+    } else {
         tcg_gen_movi_tl(cpu_gpr[rA(ctx->opcode)], 0);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    }
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* ori */
@@ -1699,7 +1727,8 @@ static void gen_oris(DisasContext *ctx)
         /* NOP */
         return;
     }
-    tcg_gen_ori_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], u=
imm << 16);
+    tcg_gen_ori_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],
+                   uimm << 16);
 }
=20
 /* xori */
@@ -1723,7 +1752,8 @@ static void gen_xoris(DisasContext *ctx)
         /* NOP */
         return;
     }
-    tcg_gen_xori_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], =
uimm << 16);
+    tcg_gen_xori_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],
+                    uimm << 16);
 }
=20
 /* popcntb : PowerPC 2.03 specification */
@@ -1798,8 +1828,9 @@ GEN_LOGICAL1(extsw, tcg_gen_ext32s_tl, 0x1E, PPC_64=
B);
 static void gen_cntlzd(DisasContext *ctx)
 {
     tcg_gen_clzi_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)],=
 64);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* cnttzd */
@@ -1838,7 +1869,7 @@ static void gen_rlwimi(DisasContext *ctx)
     uint32_t mb =3D MB(ctx->opcode);
     uint32_t me =3D ME(ctx->opcode);
=20
-    if (sh =3D=3D (31-me) && mb <=3D me) {
+    if (sh =3D=3D (31 - me) && mb <=3D me) {
         tcg_gen_deposit_tl(t_ra, t_ra, t_rs, sh, me - mb + 1);
     } else {
         target_ulong mask;
@@ -2141,8 +2172,9 @@ static void gen_slw(DisasContext *ctx)
     tcg_temp_free(t1);
     tcg_temp_free(t0);
     tcg_gen_ext32u_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]=
);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* sraw & sraw. */
@@ -2150,8 +2182,9 @@ static void gen_sraw(DisasContext *ctx)
 {
     gen_helper_sraw(cpu_gpr[rA(ctx->opcode)], cpu_env,
                     cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* srawi & srawi. */
@@ -2206,8 +2239,9 @@ static void gen_srw(DisasContext *ctx)
     tcg_gen_shr_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
     tcg_temp_free(t1);
     tcg_temp_free(t0);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 #if defined(TARGET_PPC64)
@@ -2226,8 +2260,9 @@ static void gen_sld(DisasContext *ctx)
     tcg_gen_shl_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
     tcg_temp_free(t1);
     tcg_temp_free(t0);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* srad & srad. */
@@ -2235,8 +2270,9 @@ static void gen_srad(DisasContext *ctx)
 {
     gen_helper_srad(cpu_gpr[rA(ctx->opcode)], cpu_env,
                     cpu_gpr[rS(ctx->opcode)], cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
 /* sradi & sradi. */
 static inline void gen_sradi(DisasContext *ctx, int n)
@@ -2317,8 +2353,9 @@ static void gen_srd(DisasContext *ctx)
     tcg_gen_shr_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
     tcg_temp_free(t1);
     tcg_temp_free(t0);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
 #endif
=20
@@ -2463,7 +2500,7 @@ GEN_QEMU_STORE_64(st64r, BSWAP_MEMOP(MO_Q))
 #endif
=20
 #define GEN_LD(name, ldop, opc, type)                                   =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     gen_set_access_type(ctx, ACCESS_INT);                               =
      \
@@ -2474,7 +2511,7 @@ static void glue(gen_, name)(DisasContext *ctx)
 }
=20
 #define GEN_LDU(name, ldop, opc, type)                                  =
      \
-static void glue(gen_, name##u)(DisasContext *ctx)                      =
              \
+static void glue(gen_, name##u)(DisasContext *ctx)                      =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     if (unlikely(rA(ctx->opcode) =3D=3D 0 ||                            =
          \
@@ -2494,7 +2531,7 @@ static void glue(gen_, name##u)(DisasContext *ctx)
 }
=20
 #define GEN_LDUX(name, ldop, opc2, opc3, type)                          =
      \
-static void glue(gen_, name##ux)(DisasContext *ctx)                     =
              \
+static void glue(gen_, name##ux)(DisasContext *ctx)                     =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     if (unlikely(rA(ctx->opcode) =3D=3D 0 ||                            =
          \
@@ -2598,8 +2635,9 @@ static void gen_ld(DisasContext *ctx)
         /* ld - ldu */
         gen_qemu_ld64_i64(ctx, cpu_gpr[rD(ctx->opcode)], EA);
     }
-    if (Rc(ctx->opcode))
+    if (Rc(ctx->opcode)) {
         tcg_gen_mov_tl(cpu_gpr[rA(ctx->opcode)], EA);
+    }
     tcg_temp_free(EA);
 }
=20
@@ -2669,7 +2707,7 @@ static void gen_lq(DisasContext *ctx)
=20
 /***                              Integer store                         =
   ***/
 #define GEN_ST(name, stop, opc, type)                                   =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     gen_set_access_type(ctx, ACCESS_INT);                               =
      \
@@ -2680,7 +2718,7 @@ static void glue(gen_, name)(DisasContext *ctx)
 }
=20
 #define GEN_STU(name, stop, opc, type)                                  =
      \
-static void glue(gen_, stop##u)(DisasContext *ctx)                      =
              \
+static void glue(gen_, stop##u)(DisasContext *ctx)                      =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     if (unlikely(rA(ctx->opcode) =3D=3D 0)) {                           =
          \
@@ -2699,7 +2737,7 @@ static void glue(gen_, stop##u)(DisasContext *ctx)
 }
=20
 #define GEN_STUX(name, stop, opc2, opc3, type)                          =
      \
-static void glue(gen_, name##ux)(DisasContext *ctx)                     =
              \
+static void glue(gen_, name##ux)(DisasContext *ctx)                     =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     if (unlikely(rA(ctx->opcode) =3D=3D 0)) {                           =
          \
@@ -2847,8 +2885,9 @@ static void gen_std(DisasContext *ctx)
         EA =3D tcg_temp_new();
         gen_addr_imm_index(ctx, EA, 0x03);
         gen_qemu_st64_i64(ctx, cpu_gpr[rs], EA);
-        if (Rc(ctx->opcode))
+        if (Rc(ctx->opcode)) {
             tcg_gen_mov_tl(cpu_gpr[rA(ctx->opcode)], EA);
+        }
         tcg_temp_free(EA);
     }
 }
@@ -2916,10 +2955,11 @@ static void gen_stmw(DisasContext *ctx)
 /***                    Integer load and store strings                  =
   ***/
=20
 /* lswi */
-/* PowerPC32 specification says we must generate an exception if
- * rA is in the range of registers to be loaded.
- * In an other hand, IBM says this is valid, but rA won't be loaded.
- * For now, I'll follow the spec...
+/*
+ * PowerPC32 specification says we must generate an exception if rA is
+ * in the range of registers to be loaded.  In an other hand, IBM says
+ * this is valid, but rA won't be loaded.  For now, I'll follow the
+ * spec...
  */
 static void gen_lswi(DisasContext *ctx)
 {
@@ -2934,8 +2974,9 @@ static void gen_lswi(DisasContext *ctx)
         gen_align_no_le(ctx);
         return;
     }
-    if (nb =3D=3D 0)
+    if (nb =3D=3D 0) {
         nb =3D 32;
+    }
     nr =3D DIV_ROUND_UP(nb, 4);
     if (unlikely(lsw_reg_in_range(start, nr, ra))) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_LSWX);
@@ -2989,8 +3030,9 @@ static void gen_stswi(DisasContext *ctx)
     gen_set_access_type(ctx, ACCESS_INT);
     t0 =3D tcg_temp_new();
     gen_addr_register(ctx, t0);
-    if (nb =3D=3D 0)
+    if (nb =3D=3D 0) {
         nb =3D 32;
+    }
     t1 =3D tcg_const_i32(nb);
     t2 =3D tcg_const_i32(rS(ctx->opcode));
     gen_helper_stsw(cpu_env, t0, t1, t2);
@@ -3363,8 +3405,10 @@ static void gen_conditional_store(DisasContext *ct=
x, TCGMemOp memop)
=20
     gen_set_label(l1);
=20
-    /* Address mismatch implies failure.  But we still need to provide t=
he
-       memory barrier semantics of the instruction.  */
+    /*
+     * Address mismatch implies failure.  But we still need to provide
+     * the memory barrier semantics of the instruction.
+     */
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
=20
@@ -3639,8 +3683,9 @@ static void gen_rvwinkle(DisasContext *ctx)
 static inline void gen_update_cfar(DisasContext *ctx, target_ulong nip)
 {
 #if defined(TARGET_PPC64)
-    if (ctx->has_cfar)
+    if (ctx->has_cfar) {
         tcg_gen_movi_tl(cpu_cfar, nip);
+    }
 #endif
 }
=20
@@ -3732,17 +3777,19 @@ static void gen_bcond(DisasContext *ctx, int type=
)
=20
     if (type =3D=3D BCOND_LR || type =3D=3D BCOND_CTR || type =3D=3D BCO=
ND_TAR) {
         target =3D tcg_temp_local_new();
-        if (type =3D=3D BCOND_CTR)
+        if (type =3D=3D BCOND_CTR) {
             tcg_gen_mov_tl(target, cpu_ctr);
-        else if (type =3D=3D BCOND_TAR)
+        } else if (type =3D=3D BCOND_TAR) {
             gen_load_spr(target, SPR_TAR);
-        else
+        } else {
             tcg_gen_mov_tl(target, cpu_lr);
+        }
     } else {
         target =3D NULL;
     }
-    if (LK(ctx->opcode))
+    if (LK(ctx->opcode)) {
         gen_setlr(ctx, ctx->base.pc_next);
+    }
     l1 =3D gen_new_label();
     if ((bo & 0x4) =3D=3D 0) {
         /* Decrement and test CTR */
@@ -3857,7 +3904,7 @@ static void gen_bctar(DisasContext *ctx)
=20
 /***                      Condition register logical                    =
   ***/
 #define GEN_CRLOGIC(name, tcg_op, opc)                                  =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     uint8_t bitmask;                                                    =
      \
     int sh;                                                             =
      \
@@ -3918,7 +3965,8 @@ static void gen_rfi(DisasContext *ctx)
 #if defined(CONFIG_USER_ONLY)
     GEN_PRIV;
 #else
-    /* This instruction doesn't exist anymore on 64-bit server
+    /*
+     * This instruction doesn't exist anymore on 64-bit server
      * processors compliant with arch 2.x
      */
     if (is_book3s_arch2x(ctx)) {
@@ -4157,7 +4205,7 @@ static void gen_mfcr(DisasContext *ctx)
     if (likely(ctx->opcode & 0x00100000)) {
         crm =3D CRM(ctx->opcode);
         if (likely(crm && ((crm & (crm - 1)) =3D=3D 0))) {
-            crn =3D ctz32 (crm);
+            crn =3D ctz32(crm);
             tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], cpu_crf[7 - cr=
n]);
             tcg_gen_shli_tl(cpu_gpr[rD(ctx->opcode)],
                             cpu_gpr[rD(ctx->opcode)], crn * 4);
@@ -4222,7 +4270,8 @@ static inline void gen_op_mfspr(DisasContext *ctx)
             (*read_cb)(ctx, rD(ctx->opcode), sprn);
         } else {
             /* Privilege exception */
-            /* This is a hack to avoid warnings when running Linux:
+            /*
+             * This is a hack to avoid warnings when running Linux:
              * this OS breaks the PowerPC virtualisation model,
              * allowing userland application to read the PVR
              */
@@ -4245,8 +4294,9 @@ static inline void gen_op_mfspr(DisasContext *ctx)
                       "Trying to read invalid spr %d (0x%03x) at "
                       TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next =
- 4);
=20
-        /* The behaviour depends on MSR:PR and SPR# bit 0x10,
-         * it can generate a priv, a hv emu or a no-op
+        /*
+         * The behaviour depends on MSR:PR and SPR# bit 0x10, it can
+         * generate a priv, a hv emu or a no-op
          */
         if (sprn & 0x10) {
             if (ctx->pr) {
@@ -4280,7 +4330,7 @@ static void gen_mtcrf(DisasContext *ctx)
     if (likely((ctx->opcode & 0x00100000))) {
         if (crm && ((crm & (crm - 1)) =3D=3D 0)) {
             TCGv_i32 temp =3D tcg_temp_new_i32();
-            crn =3D ctz32 (crm);
+            crn =3D ctz32(crm);
             tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
             tcg_gen_shri_i32(temp, temp, crn * 4);
             tcg_gen_andi_i32(cpu_crf[7 - crn], temp, 0xf);
@@ -4309,14 +4359,17 @@ static void gen_mtmsrd(DisasContext *ctx)
     if (ctx->opcode & 0x00010000) {
         /* Special form that does not need any synchronisation */
         TCGv t0 =3D tcg_temp_new();
-        tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)], (1 << MSR_RI) | (1=
 << MSR_EE));
-        tcg_gen_andi_tl(cpu_msr, cpu_msr, ~(target_ulong)((1 << MSR_RI) =
| (1 << MSR_EE)));
+        tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
+                        (1 << MSR_RI) | (1 << MSR_EE));
+        tcg_gen_andi_tl(cpu_msr, cpu_msr,
+                        ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
         tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
         tcg_temp_free(t0);
     } else {
-        /* XXX: we need to update nip before the store
-         *      if we enter power saving mode, we will exit the loop
-         *      directly from ppc_store_msr
+        /*
+         * XXX: we need to update nip before the store if we enter
+         *      power saving mode, we will exit the loop directly from
+         *      ppc_store_msr
          */
         if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
@@ -4342,16 +4395,19 @@ static void gen_mtmsr(DisasContext *ctx)
    if (ctx->opcode & 0x00010000) {
         /* Special form that does not need any synchronisation */
         TCGv t0 =3D tcg_temp_new();
-        tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)], (1 << MSR_RI) | (1=
 << MSR_EE));
-        tcg_gen_andi_tl(cpu_msr, cpu_msr, ~(target_ulong)((1 << MSR_RI) =
| (1 << MSR_EE)));
+        tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
+                        (1 << MSR_RI) | (1 << MSR_EE));
+        tcg_gen_andi_tl(cpu_msr, cpu_msr,
+                        ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
         tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
         tcg_temp_free(t0);
     } else {
         TCGv msr =3D tcg_temp_new();
=20
-        /* XXX: we need to update nip before the store
-         *      if we enter power saving mode, we will exit the loop
-         *      directly from ppc_store_msr
+        /*
+         * XXX: we need to update nip before the store if we enter
+         *      power saving mode, we will exit the loop directly from
+         *      ppc_store_msr
          */
         if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
@@ -4415,8 +4471,9 @@ static void gen_mtspr(DisasContext *ctx)
                       TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next =
- 4);
=20
=20
-        /* The behaviour depends on MSR:PR and SPR# bit 0x10,
-         * it can generate a priv, a hv emu or a no-op
+        /*
+         * The behaviour depends on MSR:PR and SPR# bit 0x10, it can
+         * generate a priv, a hv emu or a no-op
          */
         if (sprn & 0x10) {
             if (ctx->pr) {
@@ -4526,36 +4583,40 @@ static void gen_dcbstep(DisasContext *ctx)
 /* dcbt */
 static void gen_dcbt(DisasContext *ctx)
 {
-    /* interpreted as no-op */
-    /* XXX: specification say this is treated as a load by the MMU
-     *      but does not generate any exception
+    /*
+     * interpreted as no-op
+     * XXX: specification say this is treated as a load by the MMU but
+     *      does not generate any exception
      */
 }
=20
 /* dcbtep */
 static void gen_dcbtep(DisasContext *ctx)
 {
-    /* interpreted as no-op */
-    /* XXX: specification say this is treated as a load by the MMU
-     *      but does not generate any exception
+    /*
+     * interpreted as no-op
+     * XXX: specification say this is treated as a load by the MMU but
+     *      does not generate any exception
      */
 }
=20
 /* dcbtst */
 static void gen_dcbtst(DisasContext *ctx)
 {
-    /* interpreted as no-op */
-    /* XXX: specification say this is treated as a load by the MMU
-     *      but does not generate any exception
+    /*
+     * interpreted as no-op
+     * XXX: specification say this is treated as a load by the MMU but
+     *      does not generate any exception
      */
 }
=20
 /* dcbtstep */
 static void gen_dcbtstep(DisasContext *ctx)
 {
-    /* interpreted as no-op */
-    /* XXX: specification say this is treated as a load by the MMU
-     *      but does not generate any exception
+    /*
+     * interpreted as no-op
+     * XXX: specification say this is treated as a load by the MMU but
+     *      does not generate any exception
      */
 }
=20
@@ -4653,8 +4714,9 @@ static void gen_icbiep(DisasContext *ctx)
 /* dcba */
 static void gen_dcba(DisasContext *ctx)
 {
-    /* interpreted as no-op */
-    /* XXX: specification say this is treated as a store by the MMU
+    /*
+     * interpreted as no-op
+     * XXX: specification say this is treated as a store by the MMU
      *      but does not generate any exception
      */
 }
@@ -5021,8 +5083,9 @@ static void gen_abs(DisasContext *ctx)
     gen_set_label(l1);
     tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
     gen_set_label(l2);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* abso - abso. */
@@ -5044,8 +5107,9 @@ static void gen_abso(DisasContext *ctx)
     gen_set_label(l2);
     tcg_gen_mov_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
     gen_set_label(l3);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* clcs */
@@ -5062,8 +5126,9 @@ static void gen_div(DisasContext *ctx)
 {
     gen_helper_div(cpu_gpr[rD(ctx->opcode)], cpu_env, cpu_gpr[rA(ctx->op=
code)],
                    cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* divo - divo. */
@@ -5071,8 +5136,9 @@ static void gen_divo(DisasContext *ctx)
 {
     gen_helper_divo(cpu_gpr[rD(ctx->opcode)], cpu_env, cpu_gpr[rA(ctx->o=
pcode)],
                     cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* divs - divs. */
@@ -5080,8 +5146,9 @@ static void gen_divs(DisasContext *ctx)
 {
     gen_helper_divs(cpu_gpr[rD(ctx->opcode)], cpu_env, cpu_gpr[rA(ctx->o=
pcode)],
                     cpu_gpr[rB(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* divso - divso. */
@@ -5089,8 +5156,9 @@ static void gen_divso(DisasContext *ctx)
 {
     gen_helper_divso(cpu_gpr[rD(ctx->opcode)], cpu_env,
                      cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)])=
;
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* doz - doz. */
@@ -5098,14 +5166,17 @@ static void gen_doz(DisasContext *ctx)
 {
     TCGLabel *l1 =3D gen_new_label();
     TCGLabel *l2 =3D gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GE, cpu_gpr[rB(ctx->opcode)], cpu_gpr[rA(=
ctx->opcode)], l1);
-    tcg_gen_sub_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rB(ctx->opcode)], c=
pu_gpr[rA(ctx->opcode)]);
+    tcg_gen_brcond_tl(TCG_COND_GE, cpu_gpr[rB(ctx->opcode)],
+                      cpu_gpr[rA(ctx->opcode)], l1);
+    tcg_gen_sub_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],
+                   cpu_gpr[rA(ctx->opcode)]);
     tcg_gen_br(l2);
     gen_set_label(l1);
     tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], 0);
     gen_set_label(l2);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* dozo - dozo. */
@@ -5118,7 +5189,8 @@ static void gen_dozo(DisasContext *ctx)
     TCGv t2 =3D tcg_temp_new();
     /* Start with XER OV disabled, the most likely case */
     tcg_gen_movi_tl(cpu_ov, 0);
-    tcg_gen_brcond_tl(TCG_COND_GE, cpu_gpr[rB(ctx->opcode)], cpu_gpr[rA(=
ctx->opcode)], l1);
+    tcg_gen_brcond_tl(TCG_COND_GE, cpu_gpr[rB(ctx->opcode)],
+                      cpu_gpr[rA(ctx->opcode)], l1);
     tcg_gen_sub_tl(t0, cpu_gpr[rB(ctx->opcode)], cpu_gpr[rA(ctx->opcode)=
]);
     tcg_gen_xor_tl(t1, cpu_gpr[rB(ctx->opcode)], cpu_gpr[rA(ctx->opcode)=
]);
     tcg_gen_xor_tl(t2, cpu_gpr[rA(ctx->opcode)], t0);
@@ -5134,8 +5206,9 @@ static void gen_dozo(DisasContext *ctx)
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* dozi */
@@ -5150,8 +5223,9 @@ static void gen_dozi(DisasContext *ctx)
     gen_set_label(l1);
     tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], 0);
     gen_set_label(l2);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* lscbx - lscbx. */
@@ -5169,8 +5243,9 @@ static void gen_lscbx(DisasContext *ctx)
     tcg_temp_free_i32(t3);
     tcg_gen_andi_tl(cpu_xer, cpu_xer, ~0x7F);
     tcg_gen_or_tl(cpu_xer, cpu_xer, t0);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, t0);
+    }
     tcg_temp_free(t0);
 }
=20
@@ -5196,8 +5271,9 @@ static void gen_maskg(DisasContext *ctx)
     tcg_temp_free(t1);
     tcg_temp_free(t2);
     tcg_temp_free(t3);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* maskir - maskir. */
@@ -5210,8 +5286,9 @@ static void gen_maskir(DisasContext *ctx)
     tcg_gen_or_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* mul - mul. */
@@ -5230,8 +5307,9 @@ static void gen_mul(DisasContext *ctx)
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
     tcg_temp_free(t2);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* mulo - mulo. */
@@ -5258,8 +5336,9 @@ static void gen_mulo(DisasContext *ctx)
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
     tcg_temp_free(t2);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* nabs - nabs. */
@@ -5273,8 +5352,9 @@ static void gen_nabs(DisasContext *ctx)
     gen_set_label(l1);
     tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
     gen_set_label(l2);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* nabso - nabso. */
@@ -5290,8 +5370,9 @@ static void gen_nabso(DisasContext *ctx)
     gen_set_label(l2);
     /* nabs never overflows */
     tcg_gen_movi_tl(cpu_ov, 0);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rD(ctx->opcode)]);
+    }
 }
=20
 /* rlmi - rlmi. */
@@ -5303,11 +5384,13 @@ static void gen_rlmi(DisasContext *ctx)
     tcg_gen_andi_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1F);
     tcg_gen_rotl_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
     tcg_gen_andi_tl(t0, t0, MASK(mb, me));
-    tcg_gen_andi_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], =
~MASK(mb, me));
+    tcg_gen_andi_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
+                    ~MASK(mb, me));
     tcg_gen_or_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], t0=
);
     tcg_temp_free(t0);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* rrib - rrib. */
@@ -5324,8 +5407,9 @@ static void gen_rrib(DisasContext *ctx)
     tcg_gen_or_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* sle - sle. */
@@ -5342,8 +5426,9 @@ static void gen_sle(DisasContext *ctx)
     gen_store_spr(SPR_MQ, t1);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* sleq - sleq. */
@@ -5364,8 +5449,9 @@ static void gen_sleq(DisasContext *ctx)
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* sliq - sliq. */
@@ -5381,8 +5467,9 @@ static void gen_sliq(DisasContext *ctx)
     gen_store_spr(SPR_MQ, t1);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* slliq - slliq. */
@@ -5399,8 +5486,9 @@ static void gen_slliq(DisasContext *ctx)
     tcg_gen_or_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* sllq - sllq. */
@@ -5428,8 +5516,9 @@ static void gen_sllq(DisasContext *ctx)
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* slq - slq. */
@@ -5451,8 +5540,9 @@ static void gen_slq(DisasContext *ctx)
     gen_set_label(l1);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* sraiq - sraiq. */
@@ -5474,8 +5564,9 @@ static void gen_sraiq(DisasContext *ctx)
     tcg_gen_sari_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], =
sh);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* sraq - sraq. */
@@ -5507,8 +5598,9 @@ static void gen_sraq(DisasContext *ctx)
     gen_set_label(l2);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* sre - sre. */
@@ -5525,8 +5617,9 @@ static void gen_sre(DisasContext *ctx)
     gen_store_spr(SPR_MQ, t1);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* srea - srea. */
@@ -5540,8 +5633,9 @@ static void gen_srea(DisasContext *ctx)
     tcg_gen_sar_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], t=
1);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* sreq */
@@ -5562,8 +5656,9 @@ static void gen_sreq(DisasContext *ctx)
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* sriq */
@@ -5579,8 +5674,9 @@ static void gen_sriq(DisasContext *ctx)
     gen_store_spr(SPR_MQ, t1);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* srliq */
@@ -5597,8 +5693,9 @@ static void gen_srliq(DisasContext *ctx)
     tcg_gen_or_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* srlq */
@@ -5627,8 +5724,9 @@ static void gen_srlq(DisasContext *ctx)
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* srq */
@@ -5650,8 +5748,9 @@ static void gen_srq(DisasContext *ctx)
     gen_set_label(l1);
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    if (unlikely(Rc(ctx->opcode) !=3D 0))
+    if (unlikely(Rc(ctx->opcode) !=3D 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
+    }
 }
=20
 /* PowerPC 602 specific instructions */
@@ -5769,8 +5868,9 @@ static void gen_mfsri(DisasContext *ctx)
     tcg_gen_extract_tl(t0, t0, 28, 4);
     gen_helper_load_sr(cpu_gpr[rd], cpu_env, t0);
     tcg_temp_free(t0);
-    if (ra !=3D 0 && ra !=3D rd)
+    if (ra !=3D 0 && ra !=3D rd) {
         tcg_gen_mov_tl(cpu_gpr[ra], cpu_gpr[rd]);
+    }
 #endif /* defined(CONFIG_USER_ONLY) */
 }
=20
@@ -6147,9 +6247,10 @@ static void gen_dcread(DisasContext *ctx)
 /* icbt */
 static void gen_icbt_40x(DisasContext *ctx)
 {
-    /* interpreted as no-op */
-    /* XXX: specification say this is treated as a load by the MMU
-     *      but does not generate any exception
+    /*
+     * interpreted as no-op
+     * XXX: specification say this is treated as a load by the MMU but
+     *      does not generate any exception
      */
 }
=20
@@ -6440,7 +6541,7 @@ static void gen_tlbilx_booke206(DisasContext *ctx)
     t0 =3D tcg_temp_new();
     gen_addr_reg_index(ctx, t0);
=20
-    switch((ctx->opcode >> 21) & 0x3) {
+    switch ((ctx->opcode >> 21) & 0x3) {
     case 0:
         gen_helper_booke206_tlbilx0(cpu_env, t0);
         break;
@@ -6474,8 +6575,9 @@ static void gen_wrtee(DisasContext *ctx)
     tcg_gen_andi_tl(cpu_msr, cpu_msr, ~(1 << MSR_EE));
     tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
     tcg_temp_free(t0);
-    /* Stop translation to have a chance to raise an exception
-     * if we just set msr_ee to 1
+    /*
+     * Stop translation to have a chance to raise an exception if we
+     * just set msr_ee to 1
      */
     gen_stop_exception(ctx);
 #endif /* defined(CONFIG_USER_ONLY) */
@@ -6529,9 +6631,10 @@ static void gen_msync_4xx(DisasContext *ctx)
 /* icbt */
 static void gen_icbt_440(DisasContext *ctx)
 {
-    /* interpreted as no-op */
-    /* XXX: specification say this is treated as a load by the MMU
-     *      but does not generate any exception
+    /*
+     * interpreted as no-op
+     * XXX: specification say this is treated as a load by the MMU but
+     *      does not generate any exception
      */
 }
=20
@@ -6625,7 +6728,8 @@ static inline void gen_##name(DisasContext *ctx)   =
            \
         gen_exception_err(ctx, POWERPC_EXCP_FU, FSCR_IC_TM);   \
         return;                                                \
     }                                                          \
-    /* Because tbegin always fails in QEMU, these user         \
+    /*                                                         \
+     * Because tbegin always fails in QEMU, these user         \
      * space instructions all have a simple implementation:    \
      *                                                         \
      *     CR[0] =3D 0b0 || MSR[TS] || 0b0                       \
@@ -6641,17 +6745,18 @@ GEN_TM_NOOP(tabortwci);
 GEN_TM_NOOP(tabortdc);
 GEN_TM_NOOP(tabortdci);
 GEN_TM_NOOP(tsr);
+
 static inline void gen_cp_abort(DisasContext *ctx)
 {
-    // Do Nothing
+    /* Do Nothing */
 }
=20
 #define GEN_CP_PASTE_NOOP(name)                           \
 static inline void gen_##name(DisasContext *ctx)          \
 {                                                         \
-    /* Generate invalid exception until                   \
-     * we have an implementation of the copy              \
-     * paste facility                                     \
+    /*                                                    \
+     * Generate invalid exception until we have an        \
+     * implementation of the copy paste facility          \
      */                                                   \
     gen_invalid(ctx);                                     \
 }
@@ -6665,8 +6770,9 @@ static void gen_tcheck(DisasContext *ctx)
         gen_exception_err(ctx, POWERPC_EXCP_FU, FSCR_IC_TM);
         return;
     }
-    /* Because tbegin always fails, the tcheck implementation
-     * is simple:
+    /*
+     * Because tbegin always fails, the tcheck implementation is
+     * simple:
      *
      * CR[CRF] =3D TDOOMED || MSR[TS] || 0b0
      *         =3D 0b1 || 0b00 || 0b0
@@ -6678,7 +6784,7 @@ static void gen_tcheck(DisasContext *ctx)
 #define GEN_TM_PRIV_NOOP(name)                                 \
 static inline void gen_##name(DisasContext *ctx)               \
 {                                                              \
-    gen_priv_exception(ctx, POWERPC_EXCP_PRIV_OPC);           \
+    gen_priv_exception(ctx, POWERPC_EXCP_PRIV_OPC);            \
 }
=20
 #else
@@ -6691,7 +6797,8 @@ static inline void gen_##name(DisasContext *ctx)   =
            \
         gen_exception_err(ctx, POWERPC_EXCP_FU, FSCR_IC_TM);   \
         return;                                                \
     }                                                          \
-    /* Because tbegin always fails, the implementation is      \
+    /*                                                         \
+     * Because tbegin always fails, the implementation is      \
      * simple:                                                 \
      *                                                         \
      *   CR[0] =3D 0b0 || MSR[TS] || 0b0                         \
@@ -6973,8 +7080,10 @@ GEN_HANDLER2(slbmfev, "slbmfev", 0x1F, 0x13, 0x1A,=
 0x001F0001, PPC_SEGMENT_64B),
 GEN_HANDLER2(slbfee_, "slbfee.", 0x1F, 0x13, 0x1E, 0x001F0000, PPC_SEGME=
NT_64B),
 #endif
 GEN_HANDLER(tlbia, 0x1F, 0x12, 0x0B, 0x03FFFC01, PPC_MEM_TLBIA),
-/* XXX Those instructions will need to be handled differently for
- * different ISA versions */
+/*
+ * XXX Those instructions will need to be handled differently for
+ * different ISA versions
+ */
 GEN_HANDLER(tlbiel, 0x1F, 0x12, 0x08, 0x001F0001, PPC_MEM_TLBIE),
 GEN_HANDLER(tlbie, 0x1F, 0x12, 0x09, 0x001F0001, PPC_MEM_TLBIE),
 GEN_HANDLER_E(tlbiel, 0x1F, 0x12, 0x08, 0x00100001, PPC_NONE, PPC2_ISA30=
0),
@@ -7444,11 +7553,13 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, in=
t flags)
         );
 #endif
     for (i =3D 0; i < 32; i++) {
-        if ((i & (RGPL - 1)) =3D=3D 0)
+        if ((i & (RGPL - 1)) =3D=3D 0) {
             qemu_fprintf(f, "GPR%02d", i);
+        }
         qemu_fprintf(f, " %016" PRIx64, ppc_dump_gpr(env, i));
-        if ((i & (RGPL - 1)) =3D=3D (RGPL - 1))
+        if ((i & (RGPL - 1)) =3D=3D (RGPL - 1)) {
             qemu_fprintf(f, "\n");
+        }
     }
     qemu_fprintf(f, "CR ");
     for (i =3D 0; i < 8; i++)
@@ -7456,12 +7567,13 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, in=
t flags)
     qemu_fprintf(f, "  [");
     for (i =3D 0; i < 8; i++) {
         char a =3D '-';
-        if (env->crf[i] & 0x08)
+        if (env->crf[i] & 0x08) {
             a =3D 'L';
-        else if (env->crf[i] & 0x04)
+        } else if (env->crf[i] & 0x04) {
             a =3D 'G';
-        else if (env->crf[i] & 0x02)
+        } else if (env->crf[i] & 0x02) {
             a =3D 'E';
+        }
         qemu_fprintf(f, " %c%c", a, env->crf[i] & 0x01 ? 'O' : ' ');
     }
     qemu_fprintf(f, " ]             RES " TARGET_FMT_lx "\n",
@@ -7543,8 +7655,9 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int =
flags)
     }
 #endif
=20
-    if (env->spr_cb[SPR_LPCR].name)
+    if (env->spr_cb[SPR_LPCR].name) {
         qemu_fprintf(f, " LPCR " TARGET_FMT_lx "\n", env->spr[SPR_LPCR])=
;
+    }
=20
     switch (env->mmu_model) {
     case POWERPC_MMU_32B:
@@ -7610,8 +7723,9 @@ void ppc_cpu_dump_statistics(CPUState *cs, int flag=
s)
                     t3 =3D ind_table(handler);
                     for (op3 =3D 0; op3 < 32; op3++) {
                         handler =3D t3[op3];
-                        if (handler->count =3D=3D 0)
+                        if (handler->count =3D=3D 0) {
                             continue;
+                        }
                         qemu_printf("%02x %02x %02x (%02x %04d) %16s: "
                                     "%016" PRIx64 " %" PRId64 "\n",
                                     op1, op2, op3, op1, (op3 << 5) | op2=
,
@@ -7619,8 +7733,9 @@ void ppc_cpu_dump_statistics(CPUState *cs, int flag=
s)
                                     handler->count, handler->count);
                     }
                 } else {
-                    if (handler->count =3D=3D 0)
+                    if (handler->count =3D=3D 0) {
                         continue;
+                    }
                     qemu_printf("%02x %02x    (%02x %04d) %16s: "
                                 "%016" PRIx64 " %" PRId64 "\n",
                                 op1, op2, op1, op2, handler->oname,
@@ -7628,8 +7743,9 @@ void ppc_cpu_dump_statistics(CPUState *cs, int flag=
s)
                 }
             }
         } else {
-            if (handler->count =3D=3D 0)
+            if (handler->count =3D=3D 0) {
                 continue;
+            }
             qemu_printf("%02x       (%02x     ) %16s: %016" PRIx64
                         " %" PRId64 "\n",
                         op1, op1, handler->oname,
@@ -7669,14 +7785,16 @@ static void ppc_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
         || (env->mmu_model & POWERPC_MMU_64B);
=20
     ctx->fpu_enabled =3D !!msr_fp;
-    if ((env->flags & POWERPC_FLAG_SPE) && msr_spe)
+    if ((env->flags & POWERPC_FLAG_SPE) && msr_spe) {
         ctx->spe_enabled =3D !!msr_spe;
-    else
+    } else {
         ctx->spe_enabled =3D false;
-    if ((env->flags & POWERPC_FLAG_VRE) && msr_vr)
+    }
+    if ((env->flags & POWERPC_FLAG_VRE) && msr_vr) {
         ctx->altivec_enabled =3D !!msr_vr;
-    else
+    } else {
         ctx->altivec_enabled =3D false;
+    }
     if ((env->flags & POWERPC_FLAG_VSX) && msr_vsx) {
         ctx->vsx_enabled =3D !!msr_vsx;
     } else {
@@ -7690,12 +7808,14 @@ static void ppc_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
     }
 #endif
     ctx->gtse =3D !!(env->spr[SPR_LPCR] & LPCR_GTSE);
-    if ((env->flags & POWERPC_FLAG_SE) && msr_se)
+    if ((env->flags & POWERPC_FLAG_SE) && msr_se) {
         ctx->singlestep_enabled =3D CPU_SINGLE_STEP;
-    else
+    } else {
         ctx->singlestep_enabled =3D 0;
-    if ((env->flags & POWERPC_FLAG_BE) && msr_be)
+    }
+    if ((env->flags & POWERPC_FLAG_BE) && msr_be) {
         ctx->singlestep_enabled |=3D CPU_BRANCH_STEP;
+    }
     if ((env->flags & POWERPC_FLAG_DE) && msr_de) {
         ctx->singlestep_enabled =3D 0;
         target_ulong dbcr0 =3D env->spr[SPR_BOOKE_DBCR0];
@@ -7710,7 +7830,7 @@ static void ppc_tr_init_disas_context(DisasContextB=
ase *dcbase, CPUState *cs)
     if (unlikely(ctx->base.singlestep_enabled)) {
         ctx->singlestep_enabled |=3D GDBSTUB_SINGLE_STEP;
     }
-#if defined (DO_SINGLE_STEP) && 0
+#if defined(DO_SINGLE_STEP) && 0
     /* Single step trace mode */
     msr_se =3D 1;
 #endif
@@ -7735,10 +7855,12 @@ static bool ppc_tr_breakpoint_check(DisasContextB=
ase *dcbase, CPUState *cs,
=20
     gen_debug_exception(ctx);
     dcbase->is_jmp =3D DISAS_NORETURN;
-    /* The address covered by the breakpoint must be included in
-       [tb->pc, tb->pc + tb->size) in order to for it to be
-       properly cleared -- thus we increment the PC here so that
-       the logic setting tb->size below does the right thing.  */
+    /*
+     * The address covered by the breakpoint must be included in
+     * [tb->pc, tb->pc + tb->size) in order to for it to be properly
+     * cleared -- thus we increment the PC here so that the logic
+     * setting tb->size below does the right thing.
+     */
     ctx->base.pc_next +=3D 4;
     return true;
 }
--=20
2.20.1
