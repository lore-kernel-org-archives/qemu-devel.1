Received: from eggs.gnu.org ([2001:4830:134:3::10]:43928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO5UO-00014K-Ef
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 13:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO5UL-000227-TJ
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 13:38:40 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54263 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gO5UL-000217-Ft
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 13:38:37 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Sat, 17 Nov 2018 19:38:21 +0100
Message-Id: <1542479908-20067-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1542479908-20067-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1542479908-20067-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 04/11] target/mips: Fix decoding mechanism of
 special R5900 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com, laurent@vivier.eu

From: Fredrik Noring <noring@nocrew.org>

MOVN, MOVZ, MFHI, MFLO, MTHI, MTLO, MULT, MULTU, DIV, DIVU, DMULT,
DMULTU, DDIV, DDIVU and JR are decoded in decode_opc_special_tx79
instead of the generic decode_opc_special_legacy.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 54 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3ddd700..a21b277 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23863,6 +23863,53 @@ static void decode_opc_special_r6(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void decode_opc_special_tx79(CPUMIPSState *env, DisasContext *ctx)
+{
+    int rs = extract32(ctx->opcode, 21, 5);
+    int rt = extract32(ctx->opcode, 16, 5);
+    int rd = extract32(ctx->opcode, 11, 5);
+    uint32_t op1 = MASK_SPECIAL(ctx->opcode);
+
+    switch (op1) {
+    case OPC_MOVN:         /* Conditional move */
+    case OPC_MOVZ:
+        gen_cond_move(ctx, op1, rd, rs, rt);
+        break;
+    case OPC_MFHI:          /* Move from HI/LO */
+    case OPC_MFLO:
+        gen_HILO(ctx, op1, 0, rd);
+        break;
+    case OPC_MTHI:
+    case OPC_MTLO:          /* Move to HI/LO */
+        gen_HILO(ctx, op1, 0, rs);
+        break;
+    case OPC_MULT:
+    case OPC_MULTU:
+        gen_mul_txx9(ctx, op1, rd, rs, rt);
+        break;
+    case OPC_DIV:
+    case OPC_DIVU:
+        gen_muldiv(ctx, op1, 0, rs, rt);
+        break;
+#if defined(TARGET_MIPS64)
+    case OPC_DMULT:
+    case OPC_DMULTU:
+    case OPC_DDIV:
+    case OPC_DDIVU:
+        check_insn_opc_user_only(ctx, INSN_R5900);
+        gen_muldiv(ctx, op1, 0, rs, rt);
+        break;
+#endif
+    case OPC_JR:
+        gen_compute_branch(ctx, op1, 4, rs, 0, 0, 4);
+        break;
+    default:            /* Invalid */
+        MIPS_INVAL("special_tx79");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
@@ -23878,7 +23925,7 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MOVN:         /* Conditional move */
     case OPC_MOVZ:
         check_insn(ctx, ISA_MIPS4 | ISA_MIPS32 |
-                   INSN_LOONGSON2E | INSN_LOONGSON2F | INSN_R5900);
+                   INSN_LOONGSON2E | INSN_LOONGSON2F);
         gen_cond_move(ctx, op1, rd, rs, rt);
         break;
     case OPC_MFHI:          /* Move from HI/LO */
@@ -23905,8 +23952,6 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
             check_insn(ctx, INSN_VR54XX);
             op1 = MASK_MUL_VR54XX(ctx->opcode);
             gen_mul_vr54xx(ctx, op1, rd, rs, rt);
-        } else if (ctx->insn_flags & INSN_R5900) {
-            gen_mul_txx9(ctx, op1, rd, rs, rt);
         } else {
             gen_muldiv(ctx, op1, rd & 3, rs, rt);
         }
@@ -23921,7 +23966,6 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_DDIV:
     case OPC_DDIVU:
         check_insn(ctx, ISA_MIPS3);
-        check_insn_opc_user_only(ctx, INSN_R5900);
         check_mips_64(ctx);
         gen_muldiv(ctx, op1, 0, rs, rt);
         break;
@@ -24148,6 +24192,8 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
     default:
         if (ctx->insn_flags & ISA_MIPS32R6) {
             decode_opc_special_r6(env, ctx);
+        } else if (ctx->insn_flags & INSN_R5900) {
+            decode_opc_special_tx79(env, ctx);
         } else {
             decode_opc_special_legacy(env, ctx);
         }
-- 
2.7.4
