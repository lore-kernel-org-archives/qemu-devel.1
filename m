Received: from eggs.gnu.org ([2001:4830:134:3::10]:43923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO5UO-00014G-EG
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 13:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO5UK-00020s-GE
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 13:38:40 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54245 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gO5UK-000200-8Z
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 13:38:36 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Sat, 17 Nov 2018 19:38:22 +0100
Message-Id: <1542479908-20067-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1542479908-20067-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1542479908-20067-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 05/11] target/mips: Guard
 check_insn_opc_user_only with INSN_R5900 check
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

Avoid using check_opc_user_only() as a decision making code wrt
various architectures. Use ctx->insn_flags checks instead.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index a21b277..c79da3c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28313,7 +28313,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
          break;
     case OPC_LL: /* Load and stores */
         check_insn(ctx, ISA_MIPS2);
-        check_insn_opc_user_only(ctx, INSN_R5900);
+        if (ctx->insn_flags & INSN_R5900) {
+            check_insn_opc_user_only(ctx, INSN_R5900);
+        }
         /* Fallthrough */
     case OPC_LWL:
     case OPC_LWR:
@@ -28339,7 +28341,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     case OPC_SC:
         check_insn(ctx, ISA_MIPS2);
          check_insn_opc_removed(ctx, ISA_MIPS32R6);
-        check_insn_opc_user_only(ctx, INSN_R5900);
+        if (ctx->insn_flags & INSN_R5900) {
+            check_insn_opc_user_only(ctx, INSN_R5900);
+        }
          gen_st_cond(ctx, op, rt, rs, imm);
          break;
     case OPC_CACHE:
@@ -28607,7 +28611,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
 #if defined(TARGET_MIPS64)
     /* MIPS64 opcodes */
     case OPC_LLD:
-        check_insn_opc_user_only(ctx, INSN_R5900);
+        if (ctx->insn_flags & INSN_R5900) {
+            check_insn_opc_user_only(ctx, INSN_R5900);
+        }
         /* fall through */
     case OPC_LDL:
     case OPC_LDR:
@@ -28631,7 +28637,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     case OPC_SCD:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         check_insn(ctx, ISA_MIPS3);
-        check_insn_opc_user_only(ctx, INSN_R5900);
+        if (ctx->insn_flags & INSN_R5900) {
+            check_insn_opc_user_only(ctx, INSN_R5900);
+        }
         check_mips_64(ctx);
         gen_st_cond(ctx, op, rt, rs, imm);
         break;
-- 
2.7.4
