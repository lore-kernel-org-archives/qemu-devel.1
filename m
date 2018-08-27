Received: from eggs.gnu.org ([2001:4830:134:3::10]:45330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIf0-0001zv-1f
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIew-00007O-6a
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:29 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=770980de4=jancraig@amazon.com>)
	id 1fuIev-00006I-SJ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:25 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Mon, 27 Aug 2018 10:38:06 -0400
Message-Id: <20180827143806.25048-7-jancraig@amazon.com>
In-Reply-To: <20180827143806.25048-1-jancraig@amazon.com>
References: <20180827143806.25048-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v2 6/6] target/mips: Add MXU instructions
 S32LDD and S32LDDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, aurelien@aurel32.net, Craig Janeczek <jancraig@amazon.com>

Adds support for emulating the S32LDD and S32LDDR MXU instructions.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 v1
    - initial patch
 v2
    - changed bitfield usage to extract32

 target/mips/translate.c | 43 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e2def36b03..2eb7c02741 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -347,7 +347,8 @@ enum {
     OPC_MSUB     = 0x04 | OPC_SPECIAL2,
     OPC_MSUBU    = 0x05 | OPC_SPECIAL2,
     /* Loongson 2F */
-    OPC_MULT_G_2F   = 0x10 | OPC_SPECIAL2,
+    /* opcode 0x10 overlaps loongson and MXU command */
+    OPC_MULT_G_2F_MXU_S32LDD   = 0x10 | OPC_SPECIAL2,
     OPC_DMULT_G_2F  = 0x11 | OPC_SPECIAL2,
     OPC_MULTU_G_2F  = 0x12 | OPC_SPECIAL2,
     OPC_DMULTU_G_2F = 0x13 | OPC_SPECIAL2,
@@ -3776,7 +3777,7 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
 static void gen_mxu(DisasContext *ctx, uint32_t opc)
 {
     TCGv t0, t1, t2, t3, t4, t5, t6, t7;
-    uint32_t rb, xra, xrb, xrc, xrd, s8, sel, optn2, optn3, aptn2;
+    uint32_t rb, xra, xrb, xrc, xrd, s8, s12, sel, optn2, optn3, aptn2;
 
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
@@ -3858,6 +3859,29 @@ static void gen_mxu(DisasContext *ctx, uint32_t opc)
         gen_store_mxu_gpr(t0, xra);
         break;
 
+    case OPC_MULT_G_2F_MXU_S32LDD:
+        xra = extract32(ctx->opcode, 6, 4);
+        s12 = extract32(ctx->opcode, 10, 10);
+        sel = extract32(ctx->opcode, 20, 1);
+        rb = extract32(ctx->opcode, 21, 5);
+
+        gen_load_gpr(t0, rb);
+
+        tcg_gen_movi_tl(t1, s12);
+        tcg_gen_shli_tl(t1, t1, 2);
+        if (s12 & 0x200) {
+            tcg_gen_ori_tl(t1, t1, 0xFFFFF000);
+        }
+        tcg_gen_add_tl(t1, t0, t1);
+        tcg_gen_qemu_ld_tl(t1, t1, ctx->mem_idx, MO_SL);
+
+        if (sel == 1) {
+            /* S32LDDR */
+            tcg_gen_bswap32_tl(t1, t1);
+        }
+        gen_store_mxu_gpr(t1, xra);
+        break;
+
     case OPC_MXU_D16MUL:
         xra = extract32(ctx->opcode, 6, 4);
         xrb = extract32(ctx->opcode, 10, 4);
@@ -4039,7 +4063,7 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
 
     switch (opc) {
     case OPC_MULT_G_2E:
-    case OPC_MULT_G_2F:
+    case OPC_MULT_G_2F_MXU_S32LDD:
     case OPC_MULTU_G_2E:
     case OPC_MULTU_G_2F:
 #if defined(TARGET_MIPS64)
@@ -4062,7 +4086,7 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
 
     switch (opc) {
     case OPC_MULT_G_2E:
-    case OPC_MULT_G_2F:
+    case OPC_MULT_G_2F_MXU_S32LDD:
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
@@ -18099,7 +18123,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_DIV_G_2F:
     case OPC_DIVU_G_2F:
-    case OPC_MULT_G_2F:
     case OPC_MULTU_G_2F:
     case OPC_MOD_G_2F:
     case OPC_MODU_G_2F:
@@ -18116,6 +18139,16 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         gen_mxu(ctx, op1);
         break;
 
+    case OPC_MULT_G_2F_MXU_S32LDD:
+        /* There is an overlap of opcodes between Loongson2F and MXU */
+        if (ctx->insn_flags & INSN_LOONGSON2F) {
+            check_insn(ctx, INSN_LOONGSON2F);
+            gen_loongson_integer(ctx, op1, rd, rs, rt);
+        } else {
+            gen_mxu(ctx, op1);
+        }
+        break;
+
     case OPC_CLO:
     case OPC_CLZ:
         check_insn(ctx, ISA_MIPS32);
-- 
2.18.0
