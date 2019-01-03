Received: from eggs.gnu.org ([208.118.235.92]:38150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6U1-0004P3-4W
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6Tx-0007R2-AG
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:37 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46149 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf6Tw-0007Ni-Q3
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:33 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 18:07:42 +0100
Message-Id: <1546535297-11040-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 09/44] target/mips: MXU: Add handlers for
 logic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add translation handlers for four logic MXU instructions.

It should be noted that there is an error in MXU documentation (dated
June 2017) regarding opcodes for this group of instructions. This was
confirmed by running tests on hardware, and also by looking up other
related public source trees (binutils, Android NDK). In initial MXU
patches to QEMU, opcodes for MXU logic instructions were created to
be in accordance with the MXU documentation, therefore the error from
was propagated. This patch corrects that, changing the involved code.
Besides that, as MXU was designed and implemented only for 32-bit
CPUs, corresponding preprosessor conditions were added around MXU
code, which allows more flexible implementation of MXU handlers.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 239 +++++++++++++++++++++++++++++++++++++++++-=
------
 1 file changed, 205 insertions(+), 34 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e3a5a73..a339f72 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1678,11 +1678,11 @@ enum {
  *          =E2=94=9C=E2=94=80 100111 =E2=94=80 OPC_MXU__POOL16 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_D32SARW
  *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_S32ALN
  *          =E2=94=82                            =E2=94=9C=E2=94=80 010 =
=E2=94=80 OPC_MXU_S32ALNI
- *          =E2=94=82                            =E2=94=9C=E2=94=80 011 =
=E2=94=80 OPC_MXU_S32NOR
- *          =E2=94=82                            =E2=94=9C=E2=94=80 100 =
=E2=94=80 OPC_MXU_S32AND
- *          =E2=94=82                            =E2=94=9C=E2=94=80 101 =
=E2=94=80 OPC_MXU_S32OR
- *          =E2=94=82                            =E2=94=9C=E2=94=80 110 =
=E2=94=80 OPC_MXU_S32XOR
- *          =E2=94=82                            =E2=94=94=E2=94=80 111 =
=E2=94=80 OPC_MXU_S32LUI
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 011 =
=E2=94=80 OPC_MXU_S32LUI
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 100 =
=E2=94=80 OPC_MXU_S32NOR
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 101 =
=E2=94=80 OPC_MXU_S32AND
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 110 =
=E2=94=80 OPC_MXU_S32OR
+ *          =E2=94=82                            =E2=94=94=E2=94=80 111 =
=E2=94=80 OPC_MXU_S32XOR
  *          =E2=94=82
  *          =E2=94=82                               7..5
  *          =E2=94=9C=E2=94=80 101000 =E2=94=80 OPC_MXU__POOL17 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_LXB
@@ -1953,11 +1953,11 @@ enum {
     OPC_MXU_D32SARW  =3D 0x00,
     OPC_MXU_S32ALN   =3D 0x01,
     OPC_MXU_S32ALNI  =3D 0x02,
-    OPC_MXU_S32NOR   =3D 0x03,
-    OPC_MXU_S32AND   =3D 0x04,
-    OPC_MXU_S32OR    =3D 0x05,
-    OPC_MXU_S32XOR   =3D 0x06,
-    OPC_MXU_S32LUI   =3D 0x07,
+    OPC_MXU_S32LUI   =3D 0x03,
+    OPC_MXU_S32NOR   =3D 0x04,
+    OPC_MXU_S32AND   =3D 0x05,
+    OPC_MXU_S32OR    =3D 0x06,
+    OPC_MXU_S32XOR   =3D 0x07,
 };
=20
 /*
@@ -2455,9 +2455,11 @@ static TCGv_i32 fpu_fcr0, fpu_fcr31;
 static TCGv_i64 fpu_f64[32];
 static TCGv_i64 msa_wr_d[64];
=20
+#if !defined(TARGET_MIPS64)
 /* MXU registers */
 static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
 static TCGv mxu_CR;
+#endif
=20
 #include "exec/gen-icount.h"
=20
@@ -2581,10 +2583,12 @@ static const char * const msaregnames[] =3D {
     "w30.d0", "w30.d1", "w31.d0", "w31.d1",
 };
=20
+#if !defined(TARGET_MIPS64)
 static const char * const mxuregnames[] =3D {
     "XR1",  "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
     "XR9",  "XR10", "XR11", "XR12", "XR13", "XR14", "XR15", "MXU_CR",
 };
+#endif
=20
 #define LOG_DISAS(...)                                                  =
      \
     do {                                                                =
      \
@@ -2667,6 +2671,7 @@ static inline void gen_store_srsgpr (int from, int =
to)
     }
 }
=20
+#if !defined(TARGET_MIPS64)
 /* MXU General purpose registers moves. */
 static inline void gen_load_mxu_gpr(TCGv t, unsigned int reg)
 {
@@ -2695,6 +2700,7 @@ static inline void gen_store_mxu_cr(TCGv t)
     /* TODO: Add handling of RW rules for MXU_CR. */
     tcg_gen_mov_tl(mxu_CR, t);
 }
+#endif
=20
=20
 /* Tests */
@@ -24235,6 +24241,8 @@ static void decode_opc_special(CPUMIPSState *env,=
 DisasContext *ctx)
 }
=20
=20
+#if !defined(TARGET_MIPS64)
+
 /* MXU accumulate add/subtract 1-bit pattern 'aptn1' */
 #define MXU_APTN1_A    0
 #define MXU_APTN1_S    1
@@ -24650,6 +24658,172 @@ static void gen_mxu_s32ldd_s32lddr(DisasContext=
 *ctx)
=20
=20
 /*
+ *                 MXU instruction category: logic
+ *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *               S32NOR    S32AND    S32OR    S32XOR
+ */
+
+/*
+ *  S32NOR XRa, XRb, XRc
+ *    Update XRa with the result of logical bitwise 'nor' operation
+ *    applied to the content of XRb and XRc.
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |0 0 0 0 0| opc |  XRc  |  XRb  |  XRa  |MXU__POOL16|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ */
+static void gen_mxu_S32NOR(DisasContext *ctx)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad =3D extract32(ctx->opcode, 21, 5);
+    XRc =3D extract32(ctx->opcode, 14, 4);
+    XRb =3D extract32(ctx->opcode, 10, 4);
+    XRa =3D extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad !=3D 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa =3D=3D 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb =3D=3D 0) && (XRc =3D=3D 0))) {
+        /* both operands zero registers -> just set destination to all 1=
s */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0xFFFFFFFF);
+    } else if (unlikely(XRb =3D=3D 0)) {
+        /* XRb zero register -> just set destination to the negation of =
XRc */
+        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
+    } else if (unlikely(XRc =3D=3D 0)) {
+        /* XRa zero register -> just set destination to the negation of =
XRb */
+        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else if (unlikely(XRb =3D=3D XRc)) {
+        /* both operands same -> just set destination to the negation of=
 XRb */
+        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else {
+        /* the most general case */
+        tcg_gen_nor_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc =
- 1]);
+    }
+}
+
+/*
+ *  S32AND XRa, XRb, XRc
+ *    Update XRa with the result of logical bitwise 'and' operation
+ *    applied to the content of XRb and XRc.
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |0 0 0 0 0| opc |  XRc  |  XRb  |  XRa  |MXU__POOL16|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ */
+static void gen_mxu_S32AND(DisasContext *ctx)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad =3D extract32(ctx->opcode, 21, 5);
+    XRc =3D extract32(ctx->opcode, 14, 4);
+    XRb =3D extract32(ctx->opcode, 10, 4);
+    XRa =3D extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad !=3D 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa =3D=3D 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb =3D=3D 0) || (XRc =3D=3D 0))) {
+        /* one of operands zero register -> just set destination to all =
0s */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb =3D=3D XRc)) {
+        /* both operands same -> just set destination to one of them */
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else {
+        /* the most general case */
+        tcg_gen_and_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc =
- 1]);
+    }
+}
+
+/*
+ *  S32OR XRa, XRb, XRc
+ *    Update XRa with the result of logical bitwise 'or' operation
+ *    applied to the content of XRb and XRc.
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |0 0 0 0 0| opc |  XRc  |  XRb  |  XRa  |MXU__POOL16|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ */
+static void gen_mxu_S32OR(DisasContext *ctx)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad =3D extract32(ctx->opcode, 21, 5);
+    XRc =3D extract32(ctx->opcode, 14, 4);
+    XRb =3D extract32(ctx->opcode, 10, 4);
+    XRa =3D extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad !=3D 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa =3D=3D 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb =3D=3D 0) && (XRc =3D=3D 0))) {
+        /* both operands zero registers -> just set destination to all 0=
s */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb =3D=3D 0)) {
+        /* XRb zero register -> just set destination to the content of X=
Rc */
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
+    } else if (unlikely(XRc =3D=3D 0)) {
+        /* XRc zero register -> just set destination to the content of X=
Rb */
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else if (unlikely(XRb =3D=3D XRc)) {
+        /* both operands same -> just set destination to one of them */
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else {
+        /* the most general case */
+        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc -=
 1]);
+    }
+}
+
+/*
+ *  S32XOR XRa, XRb, XRc
+ *    Update XRa with the result of logical bitwise 'xor' operation
+ *    applied to the content of XRb and XRc.
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |0 0 0 0 0| opc |  XRc  |  XRb  |  XRa  |MXU__POOL16|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ */
+static void gen_mxu_S32XOR(DisasContext *ctx)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad =3D extract32(ctx->opcode, 21, 5);
+    XRc =3D extract32(ctx->opcode, 14, 4);
+    XRb =3D extract32(ctx->opcode, 10, 4);
+    XRa =3D extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad !=3D 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa =3D=3D 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb =3D=3D 0) && (XRc =3D=3D 0))) {
+        /* both operands zero registers -> just set destination to all 0=
s */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb =3D=3D 0)) {
+        /* XRb zero register -> just set destination to the content of X=
Rc */
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
+    } else if (unlikely(XRc =3D=3D 0)) {
+        /* XRc zero register -> just set destination to the content of X=
Rb */
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else if (unlikely(XRb =3D=3D XRc)) {
+        /* both operands same -> just set destination to all 0s */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
+    } else {
+        /* the most general case */
+        tcg_gen_xor_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc =
- 1]);
+    }
+}
+
+
+/*
  * Decoding engine for MXU
  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  */
@@ -25300,18 +25474,18 @@ static void decode_opc_mxu__pool15(CPUMIPSState=
 *env, DisasContext *ctx)
  *  |  SPECIAL2 |  s3 |0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL16|
  *  +-----------+-----+---+-----+-------+-------+-------+-----------+
  *
- *  S32NOR, S32AND, S32OR, S32XOR:
- *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
- *  +-----------+---------+-----+-------+-------+-------+-----------+
- *  |  SPECIAL2 |0 0 0 0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL16|
- *  +-----------+---------+-----+-------+-------+-------+-----------+
- *
  *  S32LUI:
  *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
  *  +-----------+-----+---+-----+-------+---------------+-----------+
  *  |  SPECIAL2 |optn3|0 0|x x x|  XRc  |       s8      |MXU__POOL16|
  *  +-----------+-----+---+-----+-------+---------------+-----------+
  *
+ *  S32NOR, S32AND, S32OR, S32XOR:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |0 0 0 0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL16|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *
  */
 static void decode_opc_mxu__pool16(CPUMIPSState *env, DisasContext *ctx)
 {
@@ -25333,30 +25507,22 @@ static void decode_opc_mxu__pool16(CPUMIPSState=
 *env, DisasContext *ctx)
         MIPS_INVAL("OPC_MXU_S32ALNI");
         generate_exception_end(ctx, EXCP_RI);
         break;
-    case OPC_MXU_S32NOR:
-        /* TODO: Implement emulation of S32NOR instruction. */
-        MIPS_INVAL("OPC_MXU_S32NOR");
+    case OPC_MXU_S32LUI:
+        /* TODO: Implement emulation of S32LUI instruction. */
+        MIPS_INVAL("OPC_MXU_S32LUI");
         generate_exception_end(ctx, EXCP_RI);
         break;
+    case OPC_MXU_S32NOR:
+        gen_mxu_S32NOR(ctx);
+        break;
     case OPC_MXU_S32AND:
-        /* TODO: Implement emulation of S32AND instruction. */
-        MIPS_INVAL("OPC_MXU_S32AND");
-        generate_exception_end(ctx, EXCP_RI);
+        gen_mxu_S32AND(ctx);
         break;
     case OPC_MXU_S32OR:
-        /* TODO: Implement emulation of S32OR instruction. */
-        MIPS_INVAL("OPC_MXU_S32OR");
-        generate_exception_end(ctx, EXCP_RI);
+        gen_mxu_S32OR(ctx);
         break;
     case OPC_MXU_S32XOR:
-        /* TODO: Implement emulation of S32XOR instruction. */
-        MIPS_INVAL("OPC_MXU_S32XOR");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
-    case OPC_MXU_S32LUI:
-        /* TODO: Implement emulation of S32LUI instruction. */
-        MIPS_INVAL("OPC_MXU_S32LUI");
-        generate_exception_end(ctx, EXCP_RI);
+        gen_mxu_S32XOR(ctx);
         break;
     default:
         MIPS_INVAL("decode_opc_mxu");
@@ -25854,6 +26020,8 @@ static void decode_opc_mxu(CPUMIPSState *env, Dis=
asContext *ctx)
     }
 }
=20
+#endif /* !defined(TARGET_MIPS64) */
+
=20
 static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *=
ctx)
 {
@@ -28098,8 +28266,10 @@ static void decode_opc(CPUMIPSState *env, DisasC=
ontext *ctx)
     case OPC_SPECIAL2:
         if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI=
)) {
             decode_mmi(env, ctx);
+#if !defined(TARGET_MIPS64)
         } else if (ctx->insn_flags & ASE_MXU) {
             decode_opc_mxu(env, ctx);
+#endif
         } else {
             decode_opc_special2_legacy(env, ctx);
         }
@@ -29108,7 +29278,7 @@ void mips_tcg_init(void)
     fpu_fcr31 =3D tcg_global_mem_new_i32(cpu_env,
                                        offsetof(CPUMIPSState, active_fpu=
.fcr31),
                                        "fcr31");
-
+#if !defined(TARGET_MIPS64)
     for (i =3D 0; i < NUMBER_OF_MXU_REGISTERS - 1; i++) {
         mxu_gpr[i] =3D tcg_global_mem_new(cpu_env,
                                         offsetof(CPUMIPSState,
@@ -29119,6 +29289,7 @@ void mips_tcg_init(void)
     mxu_CR =3D tcg_global_mem_new(cpu_env,
                                 offsetof(CPUMIPSState, active_tc.mxu_cr)=
,
                                 mxuregnames[NUMBER_OF_MXU_REGISTERS - 1]=
);
+#endif
 }
=20
 #include "translate_init.inc.c"
--=20
2.7.4
