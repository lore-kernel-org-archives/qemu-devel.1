Received: from eggs.gnu.org ([2001:4830:134:3::10]:53068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ68-0006wT-0g
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ67-00084u-86
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:25:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60188 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gAZ66-00084J-TS
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:25:43 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 11 Oct 2018 13:22:20 +0200
Message-Id: <1539256947-22807-16-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 15/22] target/mips: Fix emulation of
 microMIPS R6 SELEQZ.<D|S> SELNEZ.<D|S>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Matthew Fortune <matthew.fortune@mips.com>

Fix emulation of microMIPS R6 SELEQZ.<D|S> SELNEZ.<D|S> instructions.
Their handling was permuted.

Signed-off-by: Matthew Fortune <matthew.fortune@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 61989f4..34c20fc 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -15197,15 +15197,15 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             case 0x38:
                 /* cmovs */
                 switch ((ctx->opcode >> 6) & 0x7) {
-                case MOVN_FMT: /* SELNEZ_FMT */
+                case MOVN_FMT: /* SELEQZ_FMT */
                     if (ctx->insn_flags & ISA_MIPS32R6) {
-                        /* SELNEZ_FMT */
+                        /* SELEQZ_FMT */
                         switch ((ctx->opcode >> 9) & 0x3) {
                         case FMT_SDPS_S:
-                            gen_sel_s(ctx, OPC_SELNEZ_S, rd, rt, rs);
+                            gen_sel_s(ctx, OPC_SELEQZ_S, rd, rt, rs);
                             break;
                         case FMT_SDPS_D:
-                            gen_sel_d(ctx, OPC_SELNEZ_D, rd, rt, rs);
+                            gen_sel_d(ctx, OPC_SELEQZ_D, rd, rt, rs);
                             break;
                         default:
                             goto pool32f_invalid;
@@ -15219,15 +15219,15 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
                     check_insn_opc_removed(ctx, ISA_MIPS32R6);
                     FINSN_3ARG_SDPS(MOVN);
                     break;
-                case MOVZ_FMT: /* SELEQZ_FMT */
+                case MOVZ_FMT: /* SELNEZ_FMT */
                     if (ctx->insn_flags & ISA_MIPS32R6) {
-                        /* SELEQZ_FMT */
+                        /* SELNEZ_FMT */
                         switch ((ctx->opcode >> 9) & 0x3) {
                         case FMT_SDPS_S:
-                            gen_sel_s(ctx, OPC_SELEQZ_S, rd, rt, rs);
+                            gen_sel_s(ctx, OPC_SELNEZ_S, rd, rt, rs);
                             break;
                         case FMT_SDPS_D:
-                            gen_sel_d(ctx, OPC_SELEQZ_D, rd, rt, rs);
+                            gen_sel_d(ctx, OPC_SELNEZ_D, rd, rt, rs);
                             break;
                         default:
                             goto pool32f_invalid;
-- 
2.7.4
