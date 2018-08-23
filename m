Received: from eggs.gnu.org ([2001:4830:134:3::10]:33631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fsqSK-0005Ha-LP
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fsqSG-0004pV-D2
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:24 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57096 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fsqSF-0004nU-K7
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:20 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 23 Aug 2018 16:18:33 +0200
Message-Id: <1535033941-861-19-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v5 18/46] target/mips: Add emulation of misc
 nanoMIPS instructions (pool32a0)
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

Add emulation of nanoMIPS instructions that are situated in pool32a0.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f615d48..429ad23 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16859,6 +16859,181 @@ static void gen_pool16c_nanomips_insn(DisasContext *ctx)
     }
 }
 
+static void gen_pool32a0_nanomips_insn(DisasContext *ctx)
+{
+    int rt = extract32(ctx->opcode, 21, 5);
+    int rs = extract32(ctx->opcode, 16, 5);
+    int rd = extract32(ctx->opcode, 11, 5);
+
+    switch (extract32(ctx->opcode, 3, 7)) {
+    case NM_P_TRAP:
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case NM_TEQ:
+            gen_trap(ctx, OPC_TEQ, rs, rt, -1);
+            break;
+        case NM_TNE:
+            gen_trap(ctx, OPC_TNE, rs, rt, -1);
+            break;
+        }
+        break;
+    case NM_RDHWR:
+        gen_rdhwr(ctx, rt, rs, extract32(ctx->opcode, 11, 3));
+        break;
+    case NM_SEB:
+        gen_bshfl(ctx, OPC_SEB, rs, rt);
+        break;
+    case NM_SEH:
+        gen_bshfl(ctx, OPC_SEH, rs, rt);
+        break;
+    case NM_SLLV:
+        gen_shift(ctx, OPC_SLLV, rd, rt, rs);
+        break;
+    case NM_SRLV:
+        gen_shift(ctx, OPC_SRLV, rd, rt, rs);
+        break;
+    case NM_SRAV:
+        gen_shift(ctx, OPC_SRAV, rd, rt, rs);
+        break;
+    case NM_ROTRV:
+        gen_shift(ctx, OPC_ROTRV, rd, rt, rs);
+        break;
+    case NM_ADD:
+        gen_arith(ctx, OPC_ADD, rd, rs, rt);
+        break;
+    case NM_ADDU:
+        gen_arith(ctx, OPC_ADDU, rd, rs, rt);
+        break;
+    case NM_SUB:
+        gen_arith(ctx, OPC_SUB, rd, rs, rt);
+        break;
+    case NM_SUBU:
+        gen_arith(ctx, OPC_SUBU, rd, rs, rt);
+        break;
+    case NM_P_CMOVE:
+        switch (extract32(ctx->opcode, 10, 1)) {
+        case NM_MOVZ:
+            gen_cond_move(ctx, OPC_MOVZ, rd, rs, rt);
+            break;
+        case NM_MOVN:
+            gen_cond_move(ctx, OPC_MOVN, rd, rs, rt);
+            break;
+        }
+        break;
+    case NM_AND:
+        gen_logic(ctx, OPC_AND, rd, rs, rt);
+        break;
+    case NM_OR:
+        gen_logic(ctx, OPC_OR, rd, rs, rt);
+        break;
+    case NM_NOR:
+        gen_logic(ctx, OPC_NOR, rd, rs, rt);
+        break;
+    case NM_XOR:
+        gen_logic(ctx, OPC_XOR, rd, rs, rt);
+        break;
+    case NM_SLT:
+        gen_slt(ctx, OPC_SLT, rd, rs, rt);
+        break;
+    case NM_P_SLTU:
+        if (rd == 0) {
+            /* P_DVP */
+#ifndef CONFIG_USER_ONLY
+            TCGv t0 = tcg_temp_new();
+            switch (extract32(ctx->opcode, 10, 1)) {
+            case NM_DVP:
+                if (ctx->vp) {
+                    check_cp0_enabled(ctx);
+                    gen_helper_dvp(t0, cpu_env);
+                    gen_store_gpr(t0, rt);
+                }
+                break;
+            case NM_EVP:
+                if (ctx->vp) {
+                    check_cp0_enabled(ctx);
+                    gen_helper_evp(t0, cpu_env);
+                    gen_store_gpr(t0, rt);
+                }
+                break;
+            }
+            tcg_temp_free(t0);
+#endif
+        } else {
+            gen_slt(ctx, OPC_SLTU, rd, rs, rt);
+        }
+        break;
+    case NM_SOV:
+        {
+            TCGv t0 = tcg_temp_new();
+            TCGv t1 = tcg_temp_new();
+            TCGv t2 = tcg_temp_new();
+
+            gen_load_gpr(t1, rs);
+            gen_load_gpr(t2, rt);
+            tcg_gen_add_tl(t0, t1, t2);
+            tcg_gen_ext32s_tl(t0, t0);
+            tcg_gen_xor_tl(t1, t1, t2);
+            tcg_gen_xor_tl(t2, t0, t2);
+            tcg_gen_andc_tl(t1, t2, t1);
+
+            /* operands of same sign, result different sign */
+            tcg_gen_setcondi_tl(TCG_COND_LT, t0, t1, 0);
+            gen_store_gpr(t0, rd);
+
+            tcg_temp_free(t0);
+            tcg_temp_free(t1);
+            tcg_temp_free(t2);
+        }
+        break;
+    case NM_MUL:
+        gen_r6_muldiv(ctx, R6_OPC_MUL, rd, rs, rt);
+        break;
+    case NM_MUH:
+        gen_r6_muldiv(ctx, R6_OPC_MUH, rd, rs, rt);
+        break;
+    case NM_MULU:
+        gen_r6_muldiv(ctx, R6_OPC_MULU, rd, rs, rt);
+        break;
+    case NM_MUHU:
+        gen_r6_muldiv(ctx, R6_OPC_MUHU, rd, rs, rt);
+        break;
+    case NM_DIV:
+        gen_r6_muldiv(ctx, R6_OPC_DIV, rd, rs, rt);
+        break;
+    case NM_MOD:
+        gen_r6_muldiv(ctx, R6_OPC_MOD, rd, rs, rt);
+        break;
+    case NM_DIVU:
+        gen_r6_muldiv(ctx, R6_OPC_DIVU, rd, rs, rt);
+        break;
+    case NM_MODU:
+        gen_r6_muldiv(ctx, R6_OPC_MODU, rd, rs, rt);
+        break;
+#ifndef CONFIG_USER_ONLY
+    case NM_MFC0:
+        check_cp0_enabled(ctx);
+        if (rt == 0) {
+            /* Treat as NOP. */
+            break;
+        }
+        gen_mfc0(ctx, cpu_gpr[rt], rs, extract32(ctx->opcode, 11, 3));
+        break;
+    case NM_MTC0:
+        check_cp0_enabled(ctx);
+        {
+            TCGv t0 = tcg_temp_new();
+
+            gen_load_gpr(t0, rt);
+            gen_mtc0(ctx, t0, rs, extract32(ctx->opcode, 11, 3));
+            tcg_temp_free(t0);
+        }
+        break;
+#endif
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 static void gen_pool32f_nanomips_insn(DisasContext *ctx)
 {
     int rt, rs, rd;
@@ -17224,6 +17399,16 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_POOL32A:
+        switch (ctx->opcode & 0x07) {
+        case NM_POOL32A0:
+            gen_pool32a0_nanomips_insn(ctx);
+            break;
+        case NM_POOL32A7:
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
         break;
     case NM_P_GP_W:
         switch (ctx->opcode & 0x03) {
-- 
2.7.4
