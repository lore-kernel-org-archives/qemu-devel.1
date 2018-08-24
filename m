Received: from eggs.gnu.org ([2001:4830:134:3::10]:43550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI4K-0000nQ-7u
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI4F-0007ER-V7
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:48:28 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:49038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI4C-0007Bl-2v
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:48:21 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Fri, 24 Aug 2018 15:44:08 -0400
Message-Id: <71a1d563f19149e1987cfcbb5adb7a6e2e9216f2.1535133089.git.jancraig@amazon.com>
In-Reply-To: <cover.1535133088.git.jancraig@amazon.com>
References: <cover.1535133088.git.jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH 7/7] target/mips: Add MXU instructions S32LDD
 and S32LDDR
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
 target/mips/translate.c | 44 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ae6cfc3d7c..3faa95a66e 100644
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
@@ -3798,6 +3799,15 @@ typedef union {
         uint32_t special2:6;
     } S8LDD;
 
+    struct {
+        uint32_t op:6;
+        uint32_t xra:4;
+        uint32_t s12:10;
+        uint32_t sel:1;
+        uint32_t rb:5;
+        uint32_t special2:6;
+    } S32LDD;
+
     struct {
         uint32_t op:6;
         uint32_t xra:4;
@@ -3925,6 +3935,24 @@ static void gen_mxu(DisasContext *ctx, uint32_t opc)
         gen_store_mxu_gpr(t0, opcode->S8LDD.xra);
         break;
 
+    case OPC_MULT_G_2F_MXU_S32LDD:
+        gen_load_gpr(t0, opcode->S32LDD.rb);
+
+        tcg_gen_movi_tl(t1, opcode->S32LDD.s12);
+        tcg_gen_shli_tl(t1, t1, 2);
+        if (opcode->S32LDD.s12 & 0x200) {
+            tcg_gen_ori_tl(t1, t1, 0xFFFFF000);
+        }
+        tcg_gen_add_tl(t1, t0, t1);
+        tcg_gen_qemu_ld_tl(t1, t1, ctx->mem_idx, MO_SL);
+
+        if (opcode->S32LDD.sel == 1) {
+            /* S32LDDR */
+            tcg_gen_bswap32_tl(t1, t1);
+        }
+        gen_store_mxu_gpr(t1, opcode->S32LDD.xra);
+        break;
+
     case OPC_MXU_D16MUL:
         if (opcode->D16MUL.sel == 1) {
             /* D16MULE is not supported */
@@ -4093,7 +4121,7 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
 
     switch (opc) {
     case OPC_MULT_G_2E:
-    case OPC_MULT_G_2F:
+    case OPC_MULT_G_2F_MXU_S32LDD:
     case OPC_MULTU_G_2E:
     case OPC_MULTU_G_2F:
 #if defined(TARGET_MIPS64)
@@ -4116,7 +4144,7 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
 
     switch (opc) {
     case OPC_MULT_G_2E:
-    case OPC_MULT_G_2F:
+    case OPC_MULT_G_2F_MXU_S32LDD:
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
@@ -18153,7 +18181,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_DIV_G_2F:
     case OPC_DIVU_G_2F:
-    case OPC_MULT_G_2F:
     case OPC_MULTU_G_2F:
     case OPC_MOD_G_2F:
     case OPC_MODU_G_2F:
@@ -18170,6 +18197,15 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
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
     case OPC_CLO:
     case OPC_CLZ:
         check_insn(ctx, ISA_MIPS32);
-- 
2.18.0
