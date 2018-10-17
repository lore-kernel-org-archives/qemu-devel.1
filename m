Received: from eggs.gnu.org ([2001:4830:134:3::10]:44759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2w-0001z6-1e
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2u-0006wO-7Z
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39658 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2t-0006gf-PU
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:28 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:53 +0200
Message-Id: <1539779635-15445-26-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 25/27] target/mips: Fix emulation of microMIPS
 R6 <SELEQZ|SELNEZ>.<D|S>
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

From: Matthew Fortune <matthew.fortune@mips.com>

Fix emulation of microMIPS R6 <SELEQZ|SELNEZ>.<D|S> instructions.
Their handling was permuted.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Matthew Fortune <matthew.fortune@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index aceda11..7f97f08 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -15642,15 +15642,15 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
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
@@ -15664,15 +15664,15 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
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
