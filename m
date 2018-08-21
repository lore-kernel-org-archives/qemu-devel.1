Received: from eggs.gnu.org ([2001:4830:134:3::10]:53571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6Nt-0001BE-D1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6Nn-0008QC-BR
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35477 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs6Nm-0008N2-OA
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:39 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 15:07:02 +0200
Message-Id: <1534856848-12102-21-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534856848-12102-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534856848-12102-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 20/46] target/mips: Add emulation of misc
 nanoMIPS instructions (p_lsx)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of nanoMIPS instructions situated in pool p_lsx, and
emulation of LSA instruction as well.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8381fbe..b00d28b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17115,6 +17115,125 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+
+static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
+{
+    TCGv t0, t1;
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    gen_load_gpr(t0, rs);
+    gen_load_gpr(t1, rt);
+
+    if ((extract32(ctx->opcode, 6, 1)) == 1) {
+        /* PP.LSXS instructions require shifting */
+        switch (extract32(ctx->opcode, 7, 4)) {
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
+    switch (extract32(ctx->opcode, 7, 4)) {
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
+            switch (extract32(ctx->opcode, 7, 4)) {
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
@@ -17418,7 +17537,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     uint16_t insn;
     uint32_t op;
-    int rt, rs;
+    int rt, rs, rd;
     int offset;
     int imm;
 
@@ -17427,6 +17546,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 
     rt = extract32(ctx->opcode, 21, 5);
     rs = extract32(ctx->opcode, 16, 5);
+    rd = extract32(ctx->opcode, 11, 5);
 
     op = extract32(ctx->opcode, 26, 6);
     switch (op) {
@@ -17486,6 +17606,16 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             break;
         case NM_POOL32A7:
             switch (extract32(ctx->opcode, 3, 3)) {
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
2.7.4
