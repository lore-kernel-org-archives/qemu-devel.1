Received: from eggs.gnu.org ([2001:4830:134:3::10]:44879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1froy9-0000xT-Jt
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1froks-0001Tr-NX
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51264 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1froko-0001Ng-OH
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:16 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 20 Aug 2018 20:16:16 +0200
Message-Id: <1534789014-8310-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v11 08/46] target/mips: Add emulation of
 nanoMIPS 16-bit branch instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, dnikolic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of nanoMIPS 16-bit branch instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 158 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 261680e..b0bbf4c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4564,6 +4564,128 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t1);
 }
 
+
+/* nanoMIPS Branches */
+static void gen_compute_branch_nm(DisasContext *ctx, uint32_t opc,
+                                int insn_bytes,
+                                int rs, int rt, int32_t offset)
+{
+    target_ulong btgt = -1;
+    int bcond_compute = 0;
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+    /* Load needed operands */
+    switch (opc) {
+    case OPC_BEQ:
+    case OPC_BNE:
+        /* Compare two registers */
+        if (rs != rt) {
+            gen_load_gpr(t0, rs);
+            gen_load_gpr(t1, rt);
+            bcond_compute = 1;
+        }
+        btgt = ctx->base.pc_next + insn_bytes + offset;
+        break;
+    case OPC_BGEZAL:
+        /* Compare to zero */
+        if (rs != 0) {
+            gen_load_gpr(t0, rs);
+            bcond_compute = 1;
+        }
+        btgt = ctx->base.pc_next + insn_bytes + offset;
+        break;
+    case OPC_BPOSGE32:
+        tcg_gen_andi_tl(t0, cpu_dspctrl, 0x3F);
+        bcond_compute = 1;
+        btgt = ctx->base.pc_next + insn_bytes + offset;
+        break;
+    case OPC_JR:
+    case OPC_JALR:
+        /* Jump to register */
+        if (offset != 0 && offset != 16) {
+            /* Hint = 0 is JR/JALR, hint 16 is JR.HB/JALR.HB, the
+               others are reserved. */
+            MIPS_INVAL("jump hint");
+            generate_exception_end(ctx, EXCP_RI);
+            goto out;
+        }
+        gen_load_gpr(btarget, rs);
+        break;
+    default:
+        MIPS_INVAL("branch/jump");
+        generate_exception_end(ctx, EXCP_RI);
+        goto out;
+    }
+    if (bcond_compute == 0) {
+        /* No condition to be computed */
+        switch (opc) {
+        case OPC_BEQ:     /* rx == rx        */
+            /* Always take */
+            ctx->hflags |= MIPS_HFLAG_B;
+            break;
+        case OPC_BGEZAL:  /* 0 >= 0          */
+            /* Always take and link */
+            tcg_gen_movi_tl(cpu_gpr[31],
+                            ctx->base.pc_next + insn_bytes);
+            ctx->hflags |= MIPS_HFLAG_B;
+            break;
+        case OPC_BNE:     /* rx != rx        */
+            tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 8);
+            /* Skip the instruction in the delay slot */
+            ctx->base.pc_next += 4;
+            goto out;
+        case OPC_JR:
+            ctx->hflags |= MIPS_HFLAG_BR;
+            break;
+        case OPC_JALR:
+            if (rt > 0) {
+                tcg_gen_movi_tl(cpu_gpr[rt],
+                                ctx->base.pc_next + insn_bytes);
+            }
+            ctx->hflags |= MIPS_HFLAG_BR;
+            break;
+        default:
+            MIPS_INVAL("branch/jump");
+            generate_exception_end(ctx, EXCP_RI);
+            goto out;
+        }
+    } else {
+        switch (opc) {
+        case OPC_BEQ:
+            tcg_gen_setcond_tl(TCG_COND_EQ, bcond, t0, t1);
+            goto not_likely;
+        case OPC_BNE:
+            tcg_gen_setcond_tl(TCG_COND_NE, bcond, t0, t1);
+            goto not_likely;
+        case OPC_BGEZAL:
+            tcg_gen_setcondi_tl(TCG_COND_GE, bcond, t0, 0);
+            tcg_gen_movi_tl(cpu_gpr[31],
+                            ctx->base.pc_next + insn_bytes);
+            goto not_likely;
+        case OPC_BPOSGE32:
+            tcg_gen_setcondi_tl(TCG_COND_GE, bcond, t0, 32);
+        not_likely:
+            ctx->hflags |= MIPS_HFLAG_BC;
+            break;
+        default:
+            MIPS_INVAL("conditional branch/jump");
+            generate_exception_end(ctx, EXCP_RI);
+            goto out;
+        }
+    }
+
+    ctx->btarget = btgt;
+
+ out:
+    if (insn_bytes == 2) {
+        ctx->hflags |= MIPS_HFLAG_B16;
+    }
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
+
 /* special3 bitfield operations */
 static void gen_bitops (DisasContext *ctx, uint32_t opc, int rt,
                         int rs, int lsb, int msb)
@@ -16729,14 +16851,50 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
     case NM_SWGP16:
         break;
     case NM_BC16:
+        gen_compute_branch_nm(ctx, OPC_BEQ, 2, 0, 0,
+                           (sextract32(ctx->opcode, 0, 1) << 10) |
+                           (extract32(ctx->opcode, 1, 9) << 1));
         break;
     case NM_BALC16:
+        gen_compute_branch_nm(ctx, OPC_BGEZAL, 2, 0, 0,
+                           (sextract32(ctx->opcode, 0, 1) << 10) |
+                           (extract32(ctx->opcode, 1, 9) << 1));
         break;
     case NM_BEQZC16:
+        gen_compute_branch_nm(ctx, OPC_BEQ, 2, rt, 0,
+                           (sextract32(ctx->opcode, 0, 1) << 7) |
+                           (extract32(ctx->opcode, 1, 6) << 1));
         break;
     case NM_BNEZC16:
+        gen_compute_branch_nm(ctx, OPC_BNE, 2, rt, 0,
+                           (sextract32(ctx->opcode, 0, 1) << 7) |
+                           (extract32(ctx->opcode, 1, 6) << 1));
         break;
     case NM_P16_BR:
+        switch (ctx->opcode & 0xf) {
+        case 0:
+            /* P16.JRC */
+            switch (extract32(ctx->opcode, 4, 1)) {
+            case NM_JRC:
+                gen_compute_branch_nm(ctx, OPC_JR, 2,
+                                   extract32(ctx->opcode, 5, 5), 0, 0);
+                break;
+            case NM_JALRC16:
+                gen_compute_branch_nm(ctx, OPC_JALR, 2,
+                                   extract32(ctx->opcode, 5, 5), 31, 0);
+                break;
+            }
+            break;
+        default:
+            {
+                /* P16.BRI */
+                uint32_t opc = extract32(ctx->opcode, 4, 3) <
+                               extract32(ctx->opcode, 7, 3) ? OPC_BEQ : OPC_BNE;
+                gen_compute_branch_nm(ctx, opc, 2, rs, rt,
+                                   extract32(ctx->opcode, 0, 4) << 1);
+            }
+            break;
+        }
         break;
     case NM_P16_SR:
         break;
-- 
2.7.4
