Received: from eggs.gnu.org ([2001:4830:134:3::10]:56487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTMe-0006mc-R2
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:19:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTMV-0005Bb-GZ
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:19:40 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:1368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gKTMO-000594-8G
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:19:29 -0500
Date: Wed, 7 Nov 2018 20:19:14 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <e8e6bfd053f051d5195ec030f06749b24f867b13.1541616663.git.noring@nocrew.org>
References: <cover.1541616663.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1541616663.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v2 4/6] target/mips: Fix decoding mechanism of
 special R5900 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

MOVN, MOVZ, MFHI, MFLO, MTHI, MTLO, MULT, MULTU, DIV, DIVU, DMULT,
DMULTU, DDIV, DDIVU and JR are decoded in decode_opc_special_tx79
instead of the generic decode_opc_special_legacy.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 54 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 19ae7d2f1c..45ad70c097 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23835,6 +23835,53 @@ static void decode_opc_special_r6(CPUMIPSState *env, DisasContext *ctx)
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
@@ -23850,7 +23897,7 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MOVN:         /* Conditional move */
     case OPC_MOVZ:
         check_insn(ctx, ISA_MIPS4 | ISA_MIPS32 |
-                   INSN_LOONGSON2E | INSN_LOONGSON2F | INSN_R5900);
+                   INSN_LOONGSON2E | INSN_LOONGSON2F);
         gen_cond_move(ctx, op1, rd, rs, rt);
         break;
     case OPC_MFHI:          /* Move from HI/LO */
@@ -23877,8 +23924,6 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
             check_insn(ctx, INSN_VR54XX);
             op1 = MASK_MUL_VR54XX(ctx->opcode);
             gen_mul_vr54xx(ctx, op1, rd, rs, rt);
-        } else if (ctx->insn_flags & INSN_R5900) {
-            gen_mul_txx9(ctx, op1, rd, rs, rt);
         } else {
             gen_muldiv(ctx, op1, rd & 3, rs, rt);
         }
@@ -23893,7 +23938,6 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_DDIV:
     case OPC_DDIVU:
         check_insn(ctx, ISA_MIPS3);
-        check_insn_opc_user_only(ctx, INSN_R5900);
         check_mips_64(ctx);
         gen_muldiv(ctx, op1, 0, rs, rt);
         break;
@@ -24120,6 +24164,8 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
     default:
         if (ctx->insn_flags & ISA_MIPS32R6) {
             decode_opc_special_r6(env, ctx);
+        } else if (ctx->insn_flags & INSN_R5900) {
+            decode_opc_special_tx79(env, ctx);
         } else {
             decode_opc_special_legacy(env, ctx);
         }
-- 
2.18.1
