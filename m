Received: from eggs.gnu.org ([2001:4830:134:3::10]:49362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Vl-0003CK-V0
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Uh-0005ns-V2
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:58:25 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57104 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8Uh-0005mi-9p
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:57:19 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:54:47 +0200
Message-Id: <1532004912-13899-16-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 15/40] target/mips: Add emulation of misc
 nanoMIPS instructions (pool p_lsx)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of nanoMIPS instructions situated in pool p_lsx, and
emulation of LSA instruction as well.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index af7825a..f3753bb 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16855,6 +16855,132 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
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
@@ -17157,7 +17283,7 @@ static void gen_pool32f_nanomips_insn(DisasContext *ctx)
 static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     uint16_t insn;
-    int rt, rs;
+    int rt, rs, rd;
     uint32_t op;
 
     insn = cpu_lduw_code(env, ctx->base.pc_next + 2);
@@ -17165,6 +17291,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 
     rt = (ctx->opcode >> 21) & 0x1f;
     rs = (ctx->opcode >> 16) & 0x1f;
+    rd = (ctx->opcode >> 11) & 0x1f;
 
     op = (ctx->opcode >> 26) & 0x3f;
     switch (op) {
@@ -17226,6 +17353,16 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
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
2.7.4
