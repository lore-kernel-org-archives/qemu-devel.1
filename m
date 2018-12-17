Received: from eggs.gnu.org ([2001:4830:134:3::10]:40749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYz8U-0005EG-D2
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYz8R-0001WZ-QD
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:05:06 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42731 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gYz8R-0001V6-8a
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:05:03 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 17 Dec 2018 21:04:44 +0100
Message-Id: <20181217200444.14812-7-aleksandar.markovic@rt-rk.com>
In-Reply-To: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
References: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 6/6] target/mips: MXU: Add handlers for an
 align instruction
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

Add translation handler for S32ALNI MXU instruction.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 197 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 194 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 339de8c32b..96905b78ac 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -25147,6 +25147,199 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
 }
 
 
+/*
+ *                 MXU instruction category: align
+ *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *                       S32ALN     S32ALNI
+ */
+
+/*
+ *  S32ALNI XRc, XRb, XRa, optn3
+ *    Arrange bytes from XRb and XRc according to one of five sets of
+ *    rules determined by optn3, and place the result in XRa.
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+-----+---+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |optn3|0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL16|
+ *  +-----------+-----+---+-----+-------+-------+-------+-----------+
+ *
+ */
+static void gen_mxu_S32ALNI(DisasContext *ctx)
+{
+    uint32_t optn3, pad, XRc, XRb, XRa;
+
+    optn3 = extract32(ctx->opcode,  23, 3);
+    pad   = extract32(ctx->opcode,  21, 2);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to all 0s */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == 0)) {
+        /* XRb zero register -> just appropriatelly shift XRc into XRa */
+        switch (optn3) {
+        case MXU_OPTN3_PTN0:
+            tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
+            break;
+        case MXU_OPTN3_PTN1:
+        case MXU_OPTN3_PTN2:
+        case MXU_OPTN3_PTN3:
+            tcg_gen_shri_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1],
+                             8 * (4 - optn3));
+            break;
+        case MXU_OPTN3_PTN4:
+            tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
+            break;
+        }
+    } else if (unlikely(XRc == 0)) {
+        /* XRc zero register -> just appropriatelly shift XRb into XRa */
+        switch (optn3) {
+        case MXU_OPTN3_PTN0:
+            tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+            break;
+        case MXU_OPTN3_PTN1:
+        case MXU_OPTN3_PTN2:
+        case MXU_OPTN3_PTN3:
+            tcg_gen_shri_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], 8 * optn3);
+            break;
+        case MXU_OPTN3_PTN4:
+            tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
+            break;
+        }
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same -> just rotation or moving from any of them */
+        switch (optn3) {
+        case MXU_OPTN3_PTN0:
+        case MXU_OPTN3_PTN4:
+            tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+            break;
+        case MXU_OPTN3_PTN1:
+        case MXU_OPTN3_PTN2:
+        case MXU_OPTN3_PTN3:
+            tcg_gen_rotli_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], 8 * optn3);
+            break;
+        }
+    } else {
+        /* the most general case */
+        switch (optn3) {
+        case MXU_OPTN3_PTN0:
+            {
+                /*                                         */
+                /*         XRb                XRc          */
+                /*  +---------------+                      */
+                /*  | A   B   C   D |    E   F   G   H     */
+                /*  +-------+-------+                      */
+                /*          |                              */
+                /*         XRa                             */
+                /*                                         */
+
+                tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+            }
+            break;
+        case MXU_OPTN3_PTN1:
+            {
+                /*                                         */
+                /*         XRb                 XRc         */
+                /*      +-------------------+              */
+                /*    A | B   C   D       E | F   G   H    */
+                /*      +---------+---------+              */
+                /*                |                        */
+                /*               XRa                       */
+                /*                                         */
+
+                TCGv_i32 t0 = tcg_temp_new();
+                TCGv_i32 t1 = tcg_temp_new();
+
+                tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0x00FFFFFF);
+                tcg_gen_shli_i32(t0, t0, 8);
+
+                tcg_gen_andi_i32(t1, mxu_gpr[XRc - 1], 0xFF000000);
+                tcg_gen_shri_i32(t1, t1, 24);
+
+                tcg_gen_or_i32(mxu_gpr[XRa - 1], t0, t1);
+
+                tcg_temp_free(t1);
+                tcg_temp_free(t0);
+            }
+            break;
+        case MXU_OPTN3_PTN2:
+            {
+                /*                                         */
+                /*         XRb                 XRc         */
+                /*          +-------------------+          */
+                /*    A   B | C   D       E   F | G   H    */
+                /*          +---------+---------+          */
+                /*                    |                    */
+                /*                   XRa                   */
+                /*                                         */
+
+                TCGv_i32 t0 = tcg_temp_new();
+                TCGv_i32 t1 = tcg_temp_new();
+
+                tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0x0000FFFF);
+                tcg_gen_shli_i32(t0, t0, 16);
+
+                tcg_gen_andi_i32(t1, mxu_gpr[XRc - 1], 0xFFFF0000);
+                tcg_gen_shri_i32(t1, t1, 16);
+
+                tcg_gen_or_i32(mxu_gpr[XRa - 1], t0, t1);
+
+                tcg_temp_free(t1);
+                tcg_temp_free(t0);
+            }
+            break;
+        case MXU_OPTN3_PTN3:
+            {
+                /*                                         */
+                /*         XRb                 XRc         */
+                /*              +-------------------+      */
+                /*    A   B   C | D       E   F   G | H    */
+                /*              +---------+---------+      */
+                /*                        |                */
+                /*                       XRa               */
+                /*                                         */
+
+                TCGv_i32 t0 = tcg_temp_new();
+                TCGv_i32 t1 = tcg_temp_new();
+
+                tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0x000000FF);
+                tcg_gen_shli_i32(t0, t0, 24);
+
+                tcg_gen_andi_i32(t1, mxu_gpr[XRc - 1], 0xFFFFFF00);
+                tcg_gen_shri_i32(t1, t1, 8);
+
+                tcg_gen_or_i32(mxu_gpr[XRa - 1], t0, t1);
+
+                tcg_temp_free(t1);
+                tcg_temp_free(t0);
+            }
+            break;
+        case MXU_OPTN3_PTN4:
+            {
+                /*                                         */
+                /*         XRb                 XRc         */
+                /*                     +---------------+   */
+                /*    A   B   C   D    | E   F   G   H |   */
+                /*                     +-------+-------+   */
+                /*                             |           */
+                /*                            XRa          */
+                /*                                         */
+
+                tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
+            }
+            break;
+        }
+    }
+}
+
+
 /*
  * Decoding engine for MXU
  * =======================
@@ -25809,9 +26002,7 @@ static void decode_opc_mxu__pool16(CPUMIPSState *env, DisasContext *ctx)
         generate_exception_end(ctx, EXCP_RI);
         break;
     case OPC_MXU_S32ALNI:
-        /* TODO: Implement emulation of S32ALNI instruction. */
-        MIPS_INVAL("OPC_MXU_S32ALNI");
-        generate_exception_end(ctx, EXCP_RI);
+        gen_mxu_S32ALNI(ctx);
         break;
     case OPC_MXU_S32NOR:
         gen_mxu_S32NOR(ctx);
-- 
2.17.1
