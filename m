Received: from eggs.gnu.org ([2001:4830:134:3::10]:35561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbwN-0005LA-DD
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbwH-00056a-3V
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:10:23 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:47081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbwG-0004xD-KG
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:10:16 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:05:59 +0100
Message-ID: <20180620120620.12806-15-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 14/35] target/mips: Add nanoMIPS p_lsx
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

Add nanoMIPS p_lsx and LSA instructions

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/translate.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index a581330..819cfd9 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16579,6 +16579,132 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+
+static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
+{
+    TCGv t0, t1;
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    tcg_gen_movi_tl(t1, 0);
+    if (rs == 0) {
+        tcg_gen_movi_tl(t0, 0);
+    } else {
+        gen_load_gpr(t0, rs);
+    }
+    if (rt == 0) {
+        tcg_gen_movi_tl(t1, 0);
+    } else {
+        gen_load_gpr(t1, rt);
+    }
+    if (((ctx->opcode >> 6) & 1) == 1) {
+        /* PP.LSXS instructions require shifting */
+        switch ((ctx->opcode >> 7) & 0xf) {
+        case NM_LHXS:
+        case NM_SHXS:
+        case NM_LHUXS:
+            tcg_gen_shli_tl(t0, t0, 1);
+            break;
+        case NM_LWXS:
+        case NM_SWXS:
+        case NM_LWC1XS:
+        case NM_SWC1XS:
+            tcg_gen_shli_tl(t0, t0, 2);
+            break;
+        case NM_LDC1XS:
+        case NM_SDC1XS:
+            tcg_gen_shli_tl(t0, t0, 3);
+            break;
+        }
+    }
+    gen_op_addr_add(ctx, t0, t0, t1);
+
+    switch ((ctx->opcode >> 7) & 0xf) {
+    case NM_LBX:
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
+                           MO_SB);
+        gen_store_gpr(t0, rd);
+        break;
+    case NM_LHX:
+    /*case NM_LHXS:*/
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
+                           MO_TESW);
+        gen_store_gpr(t0, rd);
+        break;
+    case NM_LWX:
+    /*case NM_LWXS:*/
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
+                           MO_TESL);
+        gen_store_gpr(t0, rd);
+        break;
+    case NM_LBUX:
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
+                           MO_UB);
+        gen_store_gpr(t0, rd);
+        break;
+    case NM_LHUX:
+    /*case NM_LHUXS:*/
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
+                           MO_TEUW);
+        gen_store_gpr(t0, rd);
+        break;
+    case NM_SBX:
+        gen_load_gpr(t1, rd);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
+                           MO_8);
+        break;
+    case NM_SHX:
+    /*case NM_SHXS:*/
+        gen_load_gpr(t1, rd);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
+                           MO_TEUW);
+        break;
+    case NM_SWX:
+    /*case NM_SWXS:*/
+        gen_load_gpr(t1, rd);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
+                           MO_TEUL);
+        break;
+    case NM_LWC1X:
+    /*case NM_LWC1XS:*/
+    case NM_LDC1X:
+    /*case NM_LDC1XS:*/
+    case NM_SWC1X:
+    /*case NM_SWC1XS:*/
+    case NM_SDC1X:
+    /*case NM_SDC1XS:*/
+        if (ctx->CP0_Config1 & (1 << CP0C1_FP)) {
+            check_cp1_enabled(ctx);
+            switch ((ctx->opcode >> 7) & 0xf) {
+            case NM_LWC1X:
+            /*case NM_LWC1XS:*/
+                gen_flt_ldst(ctx, OPC_LWC1, rd, t0);
+                break;
+            case NM_LDC1X:
+            /*case NM_LDC1XS:*/
+                gen_flt_ldst(ctx, OPC_LDC1, rd, t0);
+                break;
+            case NM_SWC1X:
+            /*case NM_SWC1XS:*/
+                gen_flt_ldst(ctx, OPC_SWC1, rd, t0);
+                break;
+            case NM_SDC1X:
+            /*case NM_SDC1XS:*/
+                gen_flt_ldst(ctx, OPC_SDC1, rd, t0);
+                break;
+            }
+        } else {
+            generate_exception_err(ctx, EXCP_CpU, 1);
+        }
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
 static void gen_pool32f_nanomips_insn(DisasContext *ctx)
 {
     int rt, rs, rd;
@@ -16881,7 +17007,7 @@ static void gen_pool32f_nanomips_insn(DisasContext *ctx)
 static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     uint16_t insn;
-    int rt, rs;
+    int rt, rs, rd;
     uint32_t op;
 
     insn = cpu_lduw_code(env, ctx->base.pc_next + 2);
@@ -16889,6 +17015,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 
     rt = (ctx->opcode >> 21) & 0x1f;
     rs = (ctx->opcode >> 16) & 0x1f;
+    rd = (ctx->opcode >> 11) & 0x1f;
 
     op = (ctx->opcode >> 26) & 0x3f;
     switch (op) {
@@ -16950,6 +17077,16 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         case NM_POOL32A7:
         {
             switch ((ctx->opcode >> 3) & 0x07) {
+            case NM_P_LSX:
+                gen_p_lsx(ctx, rd, rs, rt);
+                break;
+            case NM_LSA:
+                /* In nanoMIPS, the shift field directly encodes the shift
+                 * amount, meaning that the supported shift values are in
+                 * the range 0 to 3 (instead of 1 to 4 in MIPSR6). */
+                gen_lsa(ctx, OPC_LSA, rd, rs, rt,
+                        extract32(ctx->opcode, 9, 2) - 1);
+                break;
             case NM_POOL32AXF:
                 gen_pool32axf_nanomips_insn(env, ctx);
                 break;
-- 
1.9.1
