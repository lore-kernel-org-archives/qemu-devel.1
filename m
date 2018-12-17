Received: from eggs.gnu.org ([2001:4830:134:3::10]:40869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYz8h-0005P1-N1
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:05:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYz8Q-0001Ul-3N
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:05:09 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42708 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gYz8N-0001RM-Gg
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:05:01 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 17 Dec 2018 21:04:39 +0100
Message-Id: <20181217200444.14812-2-aleksandar.markovic@rt-rk.com>
In-Reply-To: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
References: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/6] target/mips: MXU: Add missing
 opcodes/decoding for LX* instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jancraig@amazon.com, smarkovic@wavecomp.com, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add missing opcodes and decoding engine for LXB, LXH, LXW, LXBU,
and LXHU instructions. They were for some reason forgotten in
previous commits. The MXU opcode list and decoding engine should
be now complete.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 140 +++++++++++++++++++++++++++++-----------
 1 file changed, 102 insertions(+), 38 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e9c23a594b..e0c8d8c2f7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1663,12 +1663,21 @@ enum {
  *          =E2=94=82                               20..18
  *          =E2=94=9C=E2=94=80 100111 =E2=94=80 OPC_MXU__POOL16 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_D32SARW
  *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_S32ALN
- *          =E2=94=9C=E2=94=80 101000 =E2=94=80 OPC_MXU_LXB      =E2=94=9C=
=E2=94=80 010 =E2=94=80 OPC_MXU_S32ALNI
- *          =E2=94=9C=E2=94=80 101001 =E2=94=80 <not assigned>   =E2=94=9C=
=E2=94=80 011 =E2=94=80 OPC_MXU_S32NOR
- *          =E2=94=9C=E2=94=80 101010 =E2=94=80 OPC_MXU_S16LDD   =E2=94=9C=
=E2=94=80 100 =E2=94=80 OPC_MXU_S32AND
- *          =E2=94=9C=E2=94=80 101011 =E2=94=80 OPC_MXU_S16STD   =E2=94=9C=
=E2=94=80 101 =E2=94=80 OPC_MXU_S32OR
- *          =E2=94=9C=E2=94=80 101100 =E2=94=80 OPC_MXU_S16LDI   =E2=94=9C=
=E2=94=80 110 =E2=94=80 OPC_MXU_S32XOR
- *          =E2=94=9C=E2=94=80 101101 =E2=94=80 OPC_MXU_S16SDI   =E2=94=94=
=E2=94=80 111 =E2=94=80 OPC_MXU_S32LUI
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 010 =
=E2=94=80 OPC_MXU_S32ALNI
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 011 =
=E2=94=80 OPC_MXU_S32NOR
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 100 =
=E2=94=80 OPC_MXU_S32AND
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 101 =
=E2=94=80 OPC_MXU_S32OR
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 110 =
=E2=94=80 OPC_MXU_S32XOR
+ *          =E2=94=82                            =E2=94=94=E2=94=80 111 =
=E2=94=80 OPC_MXU_S32LUI
+ *          =E2=94=82
+ *          =E2=94=82                               7..5
+ *          =E2=94=9C=E2=94=80 101000 =E2=94=80 OPC_MXU__POOL17 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_LXB
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_LXH
+ *          =E2=94=9C=E2=94=80 101001 =E2=94=80 <not assigned>   =E2=94=9C=
=E2=94=80 011 =E2=94=80 OPC_MXU_LXW
+ *          =E2=94=9C=E2=94=80 101010 =E2=94=80 OPC_MXU_S16LDD   =E2=94=9C=
=E2=94=80 100 =E2=94=80 OPC_MXU_LXBU
+ *          =E2=94=9C=E2=94=80 101011 =E2=94=80 OPC_MXU_S16STD   =E2=94=94=
=E2=94=80 101 =E2=94=80 OPC_MXU_LXHU
+ *          =E2=94=9C=E2=94=80 101100 =E2=94=80 OPC_MXU_S16LDI
+ *          =E2=94=9C=E2=94=80 101101 =E2=94=80 OPC_MXU_S16SDI
  *          =E2=94=9C=E2=94=80 101110 =E2=94=80 OPC_MXU_S32M2I
  *          =E2=94=9C=E2=94=80 101111 =E2=94=80 OPC_MXU_S32I2M
  *          =E2=94=9C=E2=94=80 110000 =E2=94=80 OPC_MXU_D32SLL
@@ -1678,15 +1687,15 @@ enum {
  *          =E2=94=9C=E2=94=80 110100 =E2=94=80 OPC_MXU_Q16SLL   =E2=94=9C=
=E2=94=80 010 =E2=94=80 OPC_MXU_D32SARV
  *          =E2=94=9C=E2=94=80 110101 =E2=94=80 OPC_MXU_Q16SLR   =E2=94=9C=
=E2=94=80 011 =E2=94=80 OPC_MXU_Q16SLLV
  *          =E2=94=82                            =E2=94=9C=E2=94=80 100 =
=E2=94=80 OPC_MXU_Q16SLRV
- *          =E2=94=9C=E2=94=80 110110 =E2=94=80 OPC_MXU__POOL17 =E2=94=80=
=E2=94=B4=E2=94=80 101 =E2=94=80 OPC_MXU_Q16SARV
+ *          =E2=94=9C=E2=94=80 110110 =E2=94=80 OPC_MXU__POOL18 =E2=94=80=
=E2=94=B4=E2=94=80 101 =E2=94=80 OPC_MXU_Q16SARV
  *          =E2=94=82
  *          =E2=94=9C=E2=94=80 110111 =E2=94=80 OPC_MXU_Q16SAR
  *          =E2=94=82                               23..22
- *          =E2=94=9C=E2=94=80 111000 =E2=94=80 OPC_MXU__POOL18 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8MUL
+ *          =E2=94=9C=E2=94=80 111000 =E2=94=80 OPC_MXU__POOL19 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8MUL
  *          =E2=94=82                            =E2=94=94=E2=94=80 01 =E2=
=94=80 OPC_MXU_Q8MULSU
  *          =E2=94=82
  *          =E2=94=82                               20..18
- *          =E2=94=9C=E2=94=80 111001 =E2=94=80 OPC_MXU__POOL19 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_Q8MOVZ
+ *          =E2=94=9C=E2=94=80 111001 =E2=94=80 OPC_MXU__POOL20 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_Q8MOVZ
  *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_Q8MOVN
  *          =E2=94=82                            =E2=94=9C=E2=94=80 010 =
=E2=94=80 OPC_MXU_D16MOVZ
  *          =E2=94=82                            =E2=94=9C=E2=94=80 011 =
=E2=94=80 OPC_MXU_D16MOVN
@@ -1694,7 +1703,7 @@ enum {
  *          =E2=94=82                            =E2=94=94=E2=94=80 101 =
=E2=94=80 OPC_MXU_S32MOV
  *          =E2=94=82
  *          =E2=94=82                               23..22
- *          =E2=94=9C=E2=94=80 111010 =E2=94=80 OPC_MXU__POOL20 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8MAC
+ *          =E2=94=9C=E2=94=80 111010 =E2=94=80 OPC_MXU__POOL21 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8MAC
  *          =E2=94=82                            =E2=94=94=E2=94=80 10 =E2=
=94=80 OPC_MXU_Q8MACSU
  *          =E2=94=9C=E2=94=80 111011 =E2=94=80 OPC_MXU_Q16SCOP
  *          =E2=94=9C=E2=94=80 111100 =E2=94=80 OPC_MXU_Q8MADL
@@ -1750,7 +1759,7 @@ enum {
     OPC_MXU_S8SDI    =3D 0x25,
     OPC_MXU__POOL15  =3D 0x26,
     OPC_MXU__POOL16  =3D 0x27,
-    OPC_MXU_LXB      =3D 0x28,
+    OPC_MXU__POOL17  =3D 0x28,
     /* not assigned 0x29 */
     OPC_MXU_S16LDD   =3D 0x2A,
     OPC_MXU_S16STD   =3D 0x2B,
@@ -1764,11 +1773,11 @@ enum {
     OPC_MXU_D32SAR   =3D 0x33,
     OPC_MXU_Q16SLL   =3D 0x34,
     OPC_MXU_Q16SLR   =3D 0x35,
-    OPC_MXU__POOL17  =3D 0x36,
+    OPC_MXU__POOL18  =3D 0x36,
     OPC_MXU_Q16SAR   =3D 0x37,
-    OPC_MXU__POOL18  =3D 0x38,
-    OPC_MXU__POOL19  =3D 0x39,
-    OPC_MXU__POOL20  =3D 0x3A,
+    OPC_MXU__POOL19  =3D 0x38,
+    OPC_MXU__POOL20  =3D 0x39,
+    OPC_MXU__POOL21  =3D 0x3A,
     OPC_MXU_Q16SCOP  =3D 0x3B,
     OPC_MXU_Q8MADL   =3D 0x3C,
     OPC_MXU_S32SFL   =3D 0x3D,
@@ -1940,6 +1949,17 @@ enum {
 /*
  * MXU pool 17
  */
+enum {
+    OPC_MXU_LXB      =3D 0x00,
+    OPC_MXU_LXH      =3D 0x01,
+    OPC_MXU_LXW      =3D 0x03,
+    OPC_MXU_LXBU     =3D 0x04,
+    OPC_MXU_LXHU     =3D 0x05,
+};
+
+/*
+ * MXU pool 18
+ */
 enum {
     OPC_MXU_D32SLLV  =3D 0x00,
     OPC_MXU_D32SLRV  =3D 0x01,
@@ -1950,7 +1970,7 @@ enum {
 };
=20
 /*
- * MXU pool 18
+ * MXU pool 19
  */
 enum {
     OPC_MXU_Q8MUL    =3D 0x00,
@@ -1958,7 +1978,7 @@ enum {
 };
=20
 /*
- * MXU pool 19
+ * MXU pool 20
  */
 enum {
     OPC_MXU_Q8MOVZ   =3D 0x00,
@@ -1970,7 +1990,7 @@ enum {
 };
=20
 /*
- * MXU pool 20
+ * MXU pool 21
  */
 enum {
     OPC_MXU_Q8MAC    =3D 0x00,
@@ -25331,12 +25351,58 @@ static void decode_opc_mxu__pool16(CPUMIPSState=
 *env, DisasContext *ctx)
  * Decode MXU pool17
  *
  *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---+---------+-----+-----------+
+ *  |  SPECIAL2 |    rs   |    rt   |0 0|    rd   |x x x|MXU__POOL15|
+ *  +-----------+---------+---------+---+---------+-----+-----------+
+ *
+ */
+static void decode_opc_mxu__pool17(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode =3D extract32(ctx->opcode, 6, 2);
+
+    switch (opcode) {
+    case OPC_MXU_LXW:
+        /* TODO: Implement emulation of LXW instruction. */
+        MIPS_INVAL("OPC_MXU_LXW");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_LXH:
+        /* TODO: Implement emulation of LXH instruction. */
+        MIPS_INVAL("OPC_MXU_LXH");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_LXHU:
+        /* TODO: Implement emulation of LXHU instruction. */
+        MIPS_INVAL("OPC_MXU_LXHU");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_LXB:
+        /* TODO: Implement emulation of LXB instruction. */
+        MIPS_INVAL("OPC_MXU_LXB");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_LXBU:
+        /* TODO: Implement emulation of LXBU instruction. */
+        MIPS_INVAL("OPC_MXU_LXBU");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+/*
+ *
+ * Decode MXU pool18
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
  *  +-----------+---------+-----+-------+-------+-------+-----------+
- *  |  SPECIAL2 |    rb   |x x x|  XRd  |  XRa  |0 0 0 0|MXU__POOL17|
+ *  |  SPECIAL2 |    rb   |x x x|  XRd  |  XRa  |0 0 0 0|MXU__POOL18|
  *  +-----------+---------+-----+-------+-------+-------+-----------+
  *
  */
-static void decode_opc_mxu__pool17(CPUMIPSState *env, DisasContext *ctx)
+static void decode_opc_mxu__pool18(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opcode =3D extract32(ctx->opcode, 18, 3);
=20
@@ -25380,15 +25446,15 @@ static void decode_opc_mxu__pool17(CPUMIPSState=
 *env, DisasContext *ctx)
=20
 /*
  *
- * Decode MXU pool18
+ * Decode MXU pool19
  *
  *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
  *  +-----------+---+---+-------+-------+-------+-------+-----------+
- *  |  SPECIAL2 |0 0|x x|  XRd  |  XRc  |  XRb  |  XRa  |MXU__POOL18|
+ *  |  SPECIAL2 |0 0|x x|  XRd  |  XRc  |  XRb  |  XRa  |MXU__POOL19|
  *  +-----------+---+---+-------+-------+-------+-------+-----------+
  *
  */
-static void decode_opc_mxu__pool18(CPUMIPSState *env, DisasContext *ctx)
+static void decode_opc_mxu__pool19(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opcode =3D extract32(ctx->opcode, 22, 2);
=20
@@ -25406,15 +25472,15 @@ static void decode_opc_mxu__pool18(CPUMIPSState=
 *env, DisasContext *ctx)
=20
 /*
  *
- * Decode MXU pool19
+ * Decode MXU pool20
  *
  *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
  *  +-----------+---------+-----+-------+-------+-------+-----------+
- *  |  SPECIAL2 |0 0 0 0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL19|
+ *  |  SPECIAL2 |0 0 0 0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL20|
  *  +-----------+---------+-----+-------+-------+-------+-----------+
  *
  */
-static void decode_opc_mxu__pool19(CPUMIPSState *env, DisasContext *ctx)
+static void decode_opc_mxu__pool20(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opcode =3D extract32(ctx->opcode, 18, 3);
=20
@@ -25458,15 +25524,15 @@ static void decode_opc_mxu__pool19(CPUMIPSState=
 *env, DisasContext *ctx)
=20
 /*
  *
- * Decode MXU pool20
+ * Decode MXU pool21
  *
  *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
  *  +-----------+---+---+-------+-------+-------+-------+-----------+
- *  |  SPECIAL2 |an2|x x|  XRd  |  XRc  |  XRb  |  XRa  |MXU__POOL20|
+ *  |  SPECIAL2 |an2|x x|  XRd  |  XRc  |  XRb  |  XRa  |MXU__POOL21|
  *  +-----------+---+---+-------+-------+-------+-------+-----------+
  *
  */
-static void decode_opc_mxu__pool20(CPUMIPSState *env, DisasContext *ctx)
+static void decode_opc_mxu__pool21(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opcode =3D extract32(ctx->opcode, 22, 2);
=20
@@ -25669,10 +25735,8 @@ static void decode_opc_mxu(CPUMIPSState *env, Di=
sasContext *ctx)
         case OPC_MXU__POOL16:
             decode_opc_mxu__pool16(env, ctx);
             break;
-        case OPC_MXU_LXB:
-            /* TODO: Implement emulation of LXB instruction. */
-            MIPS_INVAL("OPC_MXU_LXB");
-            generate_exception_end(ctx, EXCP_RI);
+        case OPC_MXU__POOL17:
+            decode_opc_mxu__pool17(env, ctx);
             break;
         case OPC_MXU_S16LDD:
             /* TODO: Implement emulation of S16LDD instruction. */
@@ -25724,23 +25788,23 @@ static void decode_opc_mxu(CPUMIPSState *env, D=
isasContext *ctx)
             MIPS_INVAL("OPC_MXU_Q16SLR");
             generate_exception_end(ctx, EXCP_RI);
             break;
-        case OPC_MXU__POOL17:
-            decode_opc_mxu__pool17(env, ctx);
+        case OPC_MXU__POOL18:
+            decode_opc_mxu__pool18(env, ctx);
             break;
         case OPC_MXU_Q16SAR:
             /* TODO: Implement emulation of Q16SAR instruction. */
             MIPS_INVAL("OPC_MXU_Q16SAR");
             generate_exception_end(ctx, EXCP_RI);
             break;
-        case OPC_MXU__POOL18:
-            decode_opc_mxu__pool18(env, ctx);
-            break;
         case OPC_MXU__POOL19:
             decode_opc_mxu__pool19(env, ctx);
             break;
         case OPC_MXU__POOL20:
             decode_opc_mxu__pool20(env, ctx);
             break;
+        case OPC_MXU__POOL21:
+            decode_opc_mxu__pool21(env, ctx);
+            break;
         case OPC_MXU_Q16SCOP:
             /* TODO: Implement emulation of Q16SCOP instruction. */
             MIPS_INVAL("OPC_MXU_Q16SCOP");
--=20
2.17.1
