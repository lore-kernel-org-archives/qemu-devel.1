Received: from eggs.gnu.org ([2001:4830:134:3::10]:47077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7P-0003vY-Rg
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7M-0005Hi-RW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:47 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:57608)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7M-0005HD-CZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:44 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 18 Jul 2017 12:55:51 +0100
Message-ID: <c69cbc8b31fbb723b12beeb59545762c12bd11f6.1500378931.git-series.james.hogan@imgtec.com>
In-Reply-To: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 6/14] target/mips: Decode MIPS32 EVA load &
 store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

Implement decoding of MIPS32 EVA loads and stores. These access the user
address space from kernel mode when implemented, so for each instruction
we need to check that EVA is available from Config5.EVA & check for
sufficient COP0 privilege (with the new check_eva()), and then override
the mem_idx used for the operation.

Unfortunately some Loongson 2E instructions use overlapping encodings,
so we must be careful not to prevent those from being decoded when EVA
is absent.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
Changes in v2:
- Fix typo in commit message (Yongbok).
- Use sextract32 (Yongbok).
---
 target/mips/translate.c | 106 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 0 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 428f71795a5c..91d57f368a97 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -427,6 +427,24 @@ enum {
     OPC_EXTR_W_DSP     = 0x38 | OPC_SPECIAL3,
     OPC_DEXTR_W_DSP    = 0x3C | OPC_SPECIAL3,
 
+    /* EVA */
+    OPC_LWLE           = 0x19 | OPC_SPECIAL3,
+    OPC_LWRE           = 0x1A | OPC_SPECIAL3,
+    OPC_CACHEE         = 0x1B | OPC_SPECIAL3,
+    OPC_SBE            = 0x1C | OPC_SPECIAL3,
+    OPC_SHE            = 0x1D | OPC_SPECIAL3,
+    OPC_SCE            = 0x1E | OPC_SPECIAL3,
+    OPC_SWE            = 0x1F | OPC_SPECIAL3,
+    OPC_SWLE           = 0x21 | OPC_SPECIAL3,
+    OPC_SWRE           = 0x22 | OPC_SPECIAL3,
+    OPC_PREFE          = 0x23 | OPC_SPECIAL3,
+    OPC_LBUE           = 0x28 | OPC_SPECIAL3,
+    OPC_LHUE           = 0x29 | OPC_SPECIAL3,
+    OPC_LBE            = 0x2C | OPC_SPECIAL3,
+    OPC_LHE            = 0x2D | OPC_SPECIAL3,
+    OPC_LLE            = 0x2E | OPC_SPECIAL3,
+    OPC_LWE            = 0x2F | OPC_SPECIAL3,
+
     /* R6 */
     R6_OPC_PREF        = 0x35 | OPC_SPECIAL3,
     R6_OPC_CACHE       = 0x25 | OPC_SPECIAL3,
@@ -1431,6 +1449,7 @@ typedef struct DisasContext {
     bool bp;
     uint64_t PAMask;
     bool mvh;
+    bool eva;
     int CP0_LLAddr_shift;
     bool ps;
     bool vp;
@@ -2216,29 +2235,47 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESL);
         gen_store_gpr(t0, rt);
         break;
+    case OPC_LWE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_LW:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
+    case OPC_LHE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_LH:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESW |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
+    case OPC_LHUE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_LHU:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUW |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
+    case OPC_LBE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_LB:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_SB);
         gen_store_gpr(t0, rt);
         break;
+    case OPC_LBUE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_LBU:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_UB);
         gen_store_gpr(t0, rt);
         break;
+    case OPC_LWLE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_LWL:
         t1 = tcg_temp_new();
         /* Do a byte access to possibly trigger a page
@@ -2262,6 +2299,9 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         tcg_gen_ext32s_tl(t0, t0);
         gen_store_gpr(t0, rt);
         break;
+    case OPC_LWRE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_LWR:
         t1 = tcg_temp_new();
         /* Do a byte access to possibly trigger a page
@@ -2286,6 +2326,9 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         tcg_gen_ext32s_tl(t0, t0);
         gen_store_gpr(t0, rt);
         break;
+    case OPC_LLE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_LL:
     case R6_OPC_LL:
         op_ld_ll(t0, t0, mem_idx, ctx);
@@ -2318,20 +2361,35 @@ static void gen_st (DisasContext *ctx, uint32_t opc, int rt,
         gen_helper_0e2i(sdr, t1, t0, mem_idx);
         break;
 #endif
+    case OPC_SWE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_SW:
         tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TEUL |
                            ctx->default_tcg_memop_mask);
         break;
+    case OPC_SHE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_SH:
         tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TEUW |
                            ctx->default_tcg_memop_mask);
         break;
+    case OPC_SBE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_SB:
         tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_8);
         break;
+    case OPC_SWLE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_SWL:
         gen_helper_0e2i(swl, t1, t0, mem_idx);
         break;
+    case OPC_SWRE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_SWR:
         gen_helper_0e2i(swr, t1, t0, mem_idx);
         break;
@@ -2364,6 +2422,9 @@ static void gen_st_cond (DisasContext *ctx, uint32_t opc, int rt,
         op_st_scd(t1, t0, rt, mem_idx, ctx);
         break;
 #endif
+    case OPC_SCE:
+        mem_idx = MIPS_HFLAG_UM;
+        /* fall through */
     case OPC_SC:
     case R6_OPC_SC:
         op_st_sc(t1, t0, rt, mem_idx, ctx);
@@ -18014,13 +18075,57 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
     uint32_t op1, op2;
+    int16_t imm;
 
     rs = (ctx->opcode >> 21) & 0x1f;
     rt = (ctx->opcode >> 16) & 0x1f;
     rd = (ctx->opcode >> 11) & 0x1f;
     sa = (ctx->opcode >> 6) & 0x1f;
+    imm = sextract32(ctx->opcode, 7, 9);
 
     op1 = MASK_SPECIAL3(ctx->opcode);
+
+    /*
+     * EVA loads and stores overlap Loongson 2E instructions decoded by
+     * decode_opc_special3_legacy(), so be careful to allow their decoding when
+     * EVA is absent.
+     */
+    if (ctx->eva) {
+        switch (op1) {
+        case OPC_LWLE ... OPC_LWRE:
+            check_insn_opc_removed(ctx, ISA_MIPS32R6);
+            /* fall through */
+        case OPC_LBUE ... OPC_LHUE:
+        case OPC_LBE ... OPC_LWE:
+            check_cp0_enabled(ctx);
+            gen_ld(ctx, op1, rt, rs, imm);
+            return;
+        case OPC_SWLE ... OPC_SWRE:
+            check_insn_opc_removed(ctx, ISA_MIPS32R6);
+            /* fall through */
+        case OPC_SBE ... OPC_SHE:
+        case OPC_SWE:
+            check_cp0_enabled(ctx);
+            gen_st(ctx, op1, rt, rs, imm);
+            return;
+        case OPC_SCE:
+            check_cp0_enabled(ctx);
+            gen_st_cond(ctx, op1, rt, rs, imm);
+            return;
+        case OPC_CACHEE:
+            check_cp0_enabled(ctx);
+            if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
+                gen_cache_operation(ctx, rt, rs, imm);
+            }
+            /* Treat as NOP. */
+            return;
+        case OPC_PREFE:
+            check_cp0_enabled(ctx);
+            /* Treat as NOP. */
+            return;
+        }
+    }
+
     switch (op1) {
     case OPC_EXT:
     case OPC_INS:
@@ -19916,6 +20021,7 @@ void gen_intermediate_code(CPUMIPSState *env, struct TranslationBlock *tb)
     ctx.bp = (env->CP0_Config3 >> CP0C3_BP) & 1;
     ctx.PAMask = env->PAMask;
     ctx.mvh = (env->CP0_Config5 >> CP0C5_MVH) & 1;
+    ctx.eva = (env->CP0_Config5 >> CP0C5_EVA) & 1;
     ctx.CP0_LLAddr_shift = env->CP0_LLAddr_shift;
     ctx.cmgcr = (env->CP0_Config3 >> CP0C3_CMGCR) & 1;
     /* Restore delay slot state from the tb context.  */
-- 
git-series 0.8.10
