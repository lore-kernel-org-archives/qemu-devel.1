Received: from eggs.gnu.org ([2001:4830:134:3::10]:34121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6lZ-0000uO-7Z
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6lU-00070f-I3
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:13 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49377 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs6lT-0006xQ-Qz
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:32:08 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 15:31:27 +0200
Message-Id: <1534858316-12945-18-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v3 17/46] target/mips: Add emulation of nanoMIPS
 FP instructions
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

Add emulation of basic floating point arithmetic for nanoMIPS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 300 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 300 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 98df88e..f615d48 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16859,6 +16859,305 @@ static void gen_pool16c_nanomips_insn(DisasContext *ctx)
     }
 }
 
+static void gen_pool32f_nanomips_insn(DisasContext *ctx)
+{
+    int rt, rs, rd;
+
+    rt = extract32(ctx->opcode, 21, 5);
+    rs = extract32(ctx->opcode, 16, 5);
+    rd = extract32(ctx->opcode, 11, 5);
+
+    if (!(ctx->CP0_Config1 & (1 << CP0C1_FP))) {
+        generate_exception_end(ctx, EXCP_RI);
+        return;
+    }
+    check_cp1_enabled(ctx);
+    switch (extract32(ctx->opcode, 0, 3)) {
+    case NM_POOL32F_0:
+        switch (extract32(ctx->opcode, 3, 7)) {
+        case NM_RINT_S:
+            gen_farith(ctx, OPC_RINT_S, 0, rt, rs, 0);
+            break;
+        case NM_RINT_D:
+            gen_farith(ctx, OPC_RINT_D, 0, rt, rs, 0);
+            break;
+        case NM_CLASS_S:
+            gen_farith(ctx, OPC_CLASS_S, 0, rt, rs, 0);
+            break;
+        case NM_CLASS_D:
+            gen_farith(ctx, OPC_CLASS_D, 0, rt, rs, 0);
+            break;
+        case NM_ADD_S:
+            gen_farith(ctx, OPC_ADD_S, rt, rs, rd, 0);
+            break;
+        case NM_ADD_D:
+            gen_farith(ctx, OPC_ADD_D, rt, rs, rd, 0);
+            break;
+        case NM_SUB_S:
+            gen_farith(ctx, OPC_SUB_S, rt, rs, rd, 0);
+            break;
+        case NM_SUB_D:
+            gen_farith(ctx, OPC_SUB_D, rt, rs, rd, 0);
+            break;
+        case NM_MUL_S:
+            gen_farith(ctx, OPC_MUL_S, rt, rs, rd, 0);
+            break;
+        case NM_MUL_D:
+            gen_farith(ctx, OPC_MUL_D, rt, rs, rd, 0);
+            break;
+        case NM_DIV_S:
+            gen_farith(ctx, OPC_DIV_S, rt, rs, rd, 0);
+            break;
+        case NM_DIV_D:
+            gen_farith(ctx, OPC_DIV_D, rt, rs, rd, 0);
+            break;
+        case NM_SELEQZ_S:
+            gen_sel_s(ctx, OPC_SELEQZ_S, rd, rt, rs);
+            break;
+        case NM_SELEQZ_D:
+            gen_sel_d(ctx, OPC_SELEQZ_D, rd, rt, rs);
+            break;
+        case NM_SELNEZ_S:
+            gen_sel_s(ctx, OPC_SELNEZ_S, rd, rt, rs);
+            break;
+        case NM_SELNEZ_D:
+            gen_sel_d(ctx, OPC_SELNEZ_D, rd, rt, rs);
+            break;
+        case NM_SEL_S:
+            gen_sel_s(ctx, OPC_SEL_S, rd, rt, rs);
+            break;
+        case NM_SEL_D:
+            gen_sel_d(ctx, OPC_SEL_D, rd, rt, rs);
+            break;
+        case NM_MADDF_S:
+            gen_farith(ctx, OPC_MADDF_S, rt, rs, rd, 0);
+            break;
+        case NM_MADDF_D:
+            gen_farith(ctx, OPC_MADDF_D, rt, rs, rd, 0);
+            break;
+        case NM_MSUBF_S:
+            gen_farith(ctx, OPC_MSUBF_S, rt, rs, rd, 0);
+            break;
+        case NM_MSUBF_D:
+            gen_farith(ctx, OPC_MSUBF_D, rt, rs, rd, 0);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_POOL32F_3:
+        switch (extract32(ctx->opcode, 3, 3)) {
+        case NM_MIN_FMT:
+            switch (extract32(ctx->opcode, 9, 1)) {
+            case FMT_SDPS_S:
+                gen_farith(ctx, OPC_MIN_S, rt, rs, rd, 0);
+                break;
+            case FMT_SDPS_D:
+                gen_farith(ctx, OPC_MIN_D, rt, rs, rd, 0);
+                break;
+            }
+            break;
+        case NM_MAX_FMT:
+            switch (extract32(ctx->opcode, 9, 1)) {
+            case FMT_SDPS_S:
+                gen_farith(ctx, OPC_MAX_S, rt, rs, rd, 0);
+                break;
+            case FMT_SDPS_D:
+                gen_farith(ctx, OPC_MAX_D, rt, rs, rd, 0);
+                break;
+            }
+            break;
+        case NM_MINA_FMT:
+            switch (extract32(ctx->opcode, 9, 1)) {
+            case FMT_SDPS_S:
+                gen_farith(ctx, OPC_MINA_S, rt, rs, rd, 0);
+                break;
+            case FMT_SDPS_D:
+                gen_farith(ctx, OPC_MINA_D, rt, rs, rd, 0);
+                break;
+            }
+            break;
+        case NM_MAXA_FMT:
+            switch (extract32(ctx->opcode, 9, 1)) {
+            case FMT_SDPS_S:
+                gen_farith(ctx, OPC_MAXA_S, rt, rs, rd, 0);
+                break;
+            case FMT_SDPS_D:
+                gen_farith(ctx, OPC_MAXA_D, rt, rs, rd, 0);
+                break;
+            }
+            break;
+        case NM_POOL32FXF:
+            switch (extract32(ctx->opcode, 6, 8)) {
+            case NM_CFC1:
+                gen_cp1(ctx, OPC_CFC1, rt, rs);
+                break;
+            case NM_CTC1:
+                gen_cp1(ctx, OPC_CTC1, rt, rs);
+                break;
+            case NM_MFC1:
+                gen_cp1(ctx, OPC_MFC1, rt, rs);
+                break;
+            case NM_MTC1:
+                gen_cp1(ctx, OPC_MTC1, rt, rs);
+                break;
+            case NM_MFHC1:
+                gen_cp1(ctx, OPC_MFHC1, rt, rs);
+                break;
+            case NM_MTHC1:
+                gen_cp1(ctx, OPC_MTHC1, rt, rs);
+                break;
+            case NM_CVT_S_PL:
+                gen_farith(ctx, OPC_CVT_S_PL, -1, rs, rt, 0);
+                break;
+            case NM_CVT_S_PU:
+                gen_farith(ctx, OPC_CVT_S_PU, -1, rs, rt, 0);
+                break;
+            default:
+                switch (extract32(ctx->opcode, 6, 9)) {
+                case NM_CVT_L_S:
+                    gen_farith(ctx, OPC_CVT_L_S, -1, rs, rt, 0);
+                    break;
+                case NM_CVT_L_D:
+                    gen_farith(ctx, OPC_CVT_L_D, -1, rs, rt, 0);
+                    break;
+                case NM_CVT_W_S:
+                    gen_farith(ctx, OPC_CVT_W_S, -1, rs, rt, 0);
+                    break;
+                case NM_CVT_W_D:
+                    gen_farith(ctx, OPC_CVT_W_D, -1, rs, rt, 0);
+                    break;
+                case NM_RSQRT_S:
+                    gen_farith(ctx, OPC_RSQRT_S, -1, rs, rt, 0);
+                    break;
+                case NM_RSQRT_D:
+                    gen_farith(ctx, OPC_RSQRT_D, -1, rs, rt, 0);
+                    break;
+                case NM_SQRT_S:
+                    gen_farith(ctx, OPC_SQRT_S, -1, rs, rt, 0);
+                    break;
+                case NM_SQRT_D:
+                    gen_farith(ctx, OPC_SQRT_D, -1, rs, rt, 0);
+                    break;
+                case NM_RECIP_S:
+                    gen_farith(ctx, OPC_RECIP_S, -1, rs, rt, 0);
+                    break;
+                case NM_RECIP_D:
+                    gen_farith(ctx, OPC_RECIP_D, -1, rs, rt, 0);
+                    break;
+                case NM_FLOOR_L_S:
+                    gen_farith(ctx, OPC_FLOOR_L_S, -1, rs, rt, 0);
+                    break;
+                case NM_FLOOR_L_D:
+                    gen_farith(ctx, OPC_FLOOR_L_D, -1, rs, rt, 0);
+                    break;
+                case NM_FLOOR_W_S:
+                    gen_farith(ctx, OPC_FLOOR_W_S, -1, rs, rt, 0);
+                    break;
+                case NM_FLOOR_W_D:
+                    gen_farith(ctx, OPC_FLOOR_W_D, -1, rs, rt, 0);
+                    break;
+                case NM_CEIL_L_S:
+                    gen_farith(ctx, OPC_CEIL_L_S, -1, rs, rt, 0);
+                    break;
+                case NM_CEIL_L_D:
+                    gen_farith(ctx, OPC_CEIL_L_D, -1, rs, rt, 0);
+                    break;
+                case NM_CEIL_W_S:
+                    gen_farith(ctx, OPC_CEIL_W_S, -1, rs, rt, 0);
+                    break;
+                case NM_CEIL_W_D:
+                    gen_farith(ctx, OPC_CEIL_W_D, -1, rs, rt, 0);
+                    break;
+                case NM_TRUNC_L_S:
+                    gen_farith(ctx, OPC_TRUNC_L_S, -1, rs, rt, 0);
+                    break;
+                case NM_TRUNC_L_D:
+                    gen_farith(ctx, OPC_TRUNC_L_D, -1, rs, rt, 0);
+                    break;
+                case NM_TRUNC_W_S:
+                    gen_farith(ctx, OPC_TRUNC_W_S, -1, rs, rt, 0);
+                    break;
+                case NM_TRUNC_W_D:
+                    gen_farith(ctx, OPC_TRUNC_W_D, -1, rs, rt, 0);
+                    break;
+                case NM_ROUND_L_S:
+                    gen_farith(ctx, OPC_ROUND_L_S, -1, rs, rt, 0);
+                    break;
+                case NM_ROUND_L_D:
+                    gen_farith(ctx, OPC_ROUND_L_D, -1, rs, rt, 0);
+                    break;
+                case NM_ROUND_W_S:
+                    gen_farith(ctx, OPC_ROUND_W_S, -1, rs, rt, 0);
+                    break;
+                case NM_ROUND_W_D:
+                    gen_farith(ctx, OPC_ROUND_W_D, -1, rs, rt, 0);
+                    break;
+                case NM_MOV_S:
+                    gen_farith(ctx, OPC_MOV_S, -1, rs, rt, 0);
+                    break;
+                case NM_MOV_D:
+                    gen_farith(ctx, OPC_MOV_D, -1, rs, rt, 0);
+                    break;
+                case NM_ABS_S:
+                    gen_farith(ctx, OPC_ABS_S, -1, rs, rt, 0);
+                    break;
+                case NM_ABS_D:
+                    gen_farith(ctx, OPC_ABS_D, -1, rs, rt, 0);
+                    break;
+                case NM_NEG_S:
+                    gen_farith(ctx, OPC_NEG_S, -1, rs, rt, 0);
+                    break;
+                case NM_NEG_D:
+                    gen_farith(ctx, OPC_NEG_D, -1, rs, rt, 0);
+                    break;
+                case NM_CVT_D_S:
+                    gen_farith(ctx, OPC_CVT_D_S, -1, rs, rt, 0);
+                    break;
+                case NM_CVT_D_W:
+                    gen_farith(ctx, OPC_CVT_D_W, -1, rs, rt, 0);
+                    break;
+                case NM_CVT_D_L:
+                    gen_farith(ctx, OPC_CVT_D_L, -1, rs, rt, 0);
+                    break;
+                case NM_CVT_S_D:
+                    gen_farith(ctx, OPC_CVT_S_D, -1, rs, rt, 0);
+                    break;
+                case NM_CVT_S_W:
+                    gen_farith(ctx, OPC_CVT_S_W, -1, rs, rt, 0);
+                    break;
+                case NM_CVT_S_L:
+                    gen_farith(ctx, OPC_CVT_S_L, -1, rs, rt, 0);
+                    break;
+                default:
+                    generate_exception_end(ctx, EXCP_RI);
+                    break;
+                }
+                break;
+            }
+            break;
+        }
+        break;
+    case NM_POOL32F_5:
+        switch (extract32(ctx->opcode, 3, 3)) {
+        case NM_CMP_CONDN_S:
+            gen_r6_cmp_s(ctx, extract32(ctx->opcode, 6, 5), rt, rs, rd);
+            break;
+        case NM_CMP_CONDN_D:
+            gen_r6_cmp_d(ctx, extract32(ctx->opcode, 6, 5), rt, rs, rd);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     uint16_t insn;
@@ -17139,6 +17438,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_POOL32F:
+        gen_pool32f_nanomips_insn(ctx);
         break;
     case NM_POOL32S:
         break;
-- 
2.7.4
