Received: from eggs.gnu.org ([2001:4830:134:3::10]:52416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMT-0004g9-Gn
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMS-0007QK-Db
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43652 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqfMR-0007P1-W4
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:20 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 17 Aug 2018 16:02:54 +0200
Message-Id: <1534514633-13725-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v10 06/65] target/mips: Add emulation of
 nanoMIPS 16-bit arithmetic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of nanoMIPS 16-bit arithmetic instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 76d18fa..6ce7236 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16603,9 +16603,151 @@ enum {
 #define NANOMIPS_EXTRACT_RD5(op) ((op >> 5) & 0x1f)
 #define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
 
+/* Implement nanoMIPS pseudocode decode_gpr(encoded_gpr, 'gpr3'). */
+static inline int decode_gpr_gpr3(int r)
+{
+    static const int map[] = { 16, 17, 18, 19,  4,  5,  6,  7 };
+
+    return map[r & 0x7];
+}
+
+/* Implement nanoMIPS pseudocode decode_gpr(encoded_gpr, 'gpr4'). */
+static inline int decode_gpr_gpr4(int r)
+{
+    static const int map[] = {  8,  9, 10, 11,  4,  5,  6,  7,
+                               16, 17, 18, 19, 20, 21, 22, 23 };
+
+    return map[r & 0xf];
+}
+
 
 static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
 {
+    uint32_t op;
+    int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD(ctx->opcode));
+    int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
+    int rd = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS1(ctx->opcode));
+    int imm;
+
+    /* make sure instructions are on a halfword boundary */
+    if (ctx->base.pc_next & 0x1) {
+        TCGv tmp = tcg_const_tl(ctx->base.pc_next);
+        tcg_gen_st_tl(tmp, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
+        tcg_temp_free(tmp);
+        generate_exception_end(ctx, EXCP_AdEL);
+        return 2;
+    }
+
+    op = extract32(ctx->opcode, 10, 6);
+    switch (op) {
+    case NM_P16_MV:
+        break;
+    case NM_P16_SHIFT:
+        break;
+    case NM_P16C:
+        break;
+    case NM_P16_A1:
+        switch (extract32(ctx->opcode, 6, 1)) {
+        case NM_ADDIUR1SP:
+            imm = extract32(ctx->opcode, 0, 6) << 2;
+            gen_arith_imm(ctx, OPC_ADDIU, rt, 29, imm);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_P16_A2:
+        switch (extract32(ctx->opcode, 3, 1)) {
+        case NM_ADDIUR2:
+            imm = extract32(ctx->opcode, 0, 3) << 2;
+            gen_arith_imm(ctx, OPC_ADDIU, rt, rs, imm);
+            break;
+        case NM_P_ADDIURS5:
+            rt = extract32(ctx->opcode, 5, 5);
+            if (rt != 0) {
+                /* imm = sign_extend(s[3] . s[2:0] , from_nbits = 4) */
+                imm = (sextract32(ctx->opcode, 4, 1) << 3) |
+                      (extract32(ctx->opcode, 0, 3));
+                gen_arith_imm(ctx, OPC_ADDIU, rt, rt, imm);
+            }
+            break;
+        }
+        break;
+    case NM_P16_ADDU:
+        switch (ctx->opcode & 0x1) {
+        case NM_ADDU16:
+            gen_arith(ctx, OPC_ADDU, rd, rs, rt);
+            break;
+        case NM_SUBU16:
+            gen_arith(ctx, OPC_SUBU, rd, rs, rt);
+            break;
+        }
+        break;
+    case NM_P16_4X4:
+        rt = (extract32(ctx->opcode, 9, 1) << 3) |
+              extract32(ctx->opcode, 5, 3);
+        rs = (extract32(ctx->opcode, 4, 1) << 3) |
+              extract32(ctx->opcode, 0, 3);
+        rt = decode_gpr_gpr4(rt);
+        rs = decode_gpr_gpr4(rs);
+        switch ((extract32(ctx->opcode, 7, 2) & 0x2) |
+                (extract32(ctx->opcode, 3, 1))) {
+        case NM_ADDU4X4:
+            gen_arith(ctx, OPC_ADDU, rt, rs, rt);
+            break;
+        case NM_MUL4X4:
+            gen_r6_muldiv(ctx, R6_OPC_MUL, rt, rs, rt);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_LI16:
+        break;
+    case NM_ANDI16:
+        break;
+    case NM_P16_LB:
+        break;
+    case NM_P16_LH:
+        break;
+    case NM_LW16:
+        break;
+    case NM_LWSP16:
+        break;
+    case NM_LW4X4:
+        break;
+    case NM_SW4X4:
+        break;
+    case NM_LWGP16:
+        break;
+    case NM_SWSP16:
+        break;
+    case NM_SW16:
+        break;
+    case NM_SWGP16:
+        break;
+    case NM_BC16:
+        break;
+    case NM_BALC16:
+        break;
+    case NM_BEQZC16:
+        break;
+    case NM_BNEZC16:
+        break;
+    case NM_P16_BR:
+        break;
+    case NM_P16_SR:
+        break;
+    case NM_MOVEP:
+        break;
+    case NM_MOVEPREV:
+        break;
+    default:
+        break;
+    }
+
     return 2;
 }
 
-- 
2.7.4
