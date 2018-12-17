Received: from eggs.gnu.org ([2001:4830:134:3::10]:40730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYz8T-0005Dg-G8
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYz8Q-0001UU-3Y
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:05:05 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42707 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gYz8N-0001RI-Gf
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:05:01 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 17 Dec 2018 21:04:42 +0100
Message-Id: <20181217200444.14812-5-aleksandar.markovic@rt-rk.com>
In-Reply-To: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
References: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 4/6] target/mips: MXU: Add handlers for logic
 instructions
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

Add translation handlers for logic MXU instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 182 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 170 insertions(+), 12 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e3a5a73e59..c74a831a17 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24649,6 +24649,172 @@ static void gen_mxu_s32ldd_s32lddr(DisasContext *ctx)
 }
 
 
+/*
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
+    pad = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to all 1s */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0xFFFFFFFF);
+    } else if (unlikely(XRb == 0)) {
+        /* XRb zero register -> just set destination to the negation of XRc */
+        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
+    } else if (unlikely(XRc == 0)) {
+        /* XRa zero register -> just set destination to the negation of XRb */
+        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same -> just set destination to the negation of XRb */
+        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else {
+        /* the most general case */
+        tcg_gen_nor_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
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
+    pad = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) || (XRc == 0))) {
+        /* one of operands zero register -> just set destination to all 0s */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same -> just set destination to one of them */
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else {
+        /* the most general case */
+        tcg_gen_and_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
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
+ *  +-----------+---------+--+--+-------+-------+-------+-----------+
+ */
+static void gen_mxu_S32OR(DisasContext *ctx)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to all 0s */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == 0)) {
+        /* XRb zero register -> just set destination to the content of XRc */
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
+    } else if (unlikely(XRc == 0)) {
+        /* XRc zero register -> just set destination to the content of XRb */
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same -> just set destination to the content of XRb */
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else {
+        /* the most general case */
+        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
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
+    pad = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to all 0s */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == 0)) {
+        /* XRb zero register -> just set destination to the content of XRc */
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
+    } else if (unlikely(XRc == 0)) {
+        /* XRc zero register -> just set destination to the content of XRb */
+        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same -> just set destination to all 0s */
+        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
+    } else {
+        /* the most general case */
+        tcg_gen_xor_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
+    }
+}
+
+
 /*
  * Decoding engine for MXU
  * =======================
@@ -25334,24 +25500,16 @@ static void decode_opc_mxu__pool16(CPUMIPSState *env, DisasContext *ctx)
         generate_exception_end(ctx, EXCP_RI);
         break;
     case OPC_MXU_S32NOR:
-        /* TODO: Implement emulation of S32NOR instruction. */
-        MIPS_INVAL("OPC_MXU_S32NOR");
-        generate_exception_end(ctx, EXCP_RI);
+        gen_mxu_S32NOR(ctx);
         break;
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
+        gen_mxu_S32XOR(ctx);
         break;
     case OPC_MXU_S32LUI:
         /* TODO: Implement emulation of S32LUI instruction. */
-- 
2.17.1
