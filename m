Received: from eggs.gnu.org ([2001:4830:134:3::10]:37013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAxL-0008Go-7M
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAxI-0000m4-3p
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:23:35 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34408 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkAxH-0000lQ-SR
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:23:32 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:12:12 +0200
Message-Id: <1532967169-22265-40-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 39/76] target/mips: Add emulation of DSP ASE
 for nanoMIPS - part 2
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

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of DSP ASE instructions for nanoMIPS - part 2.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2448a39..055be7e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -18742,6 +18742,18 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 case NM_BC1NEZC:
                     gen_compute_branch1_r6(ctx, OPC_BC1NEZ, rt, s, 0);
                     break;
+                case NM_BPOSGE32C:
+                    check_dsp(ctx);
+                    {
+                        int32_t imm = ctx->opcode;
+                        imm >>= 1;
+                        imm &= 0x1fff;
+                        imm |= (ctx->opcode & 1) << 13;
+
+                        gen_compute_branch(ctx, OPC_BPOSGE32, 4, -1, -2,
+                                           (int32_t)imm, 4);
+                    }
+                    break;
                 default:
                     generate_exception_end(ctx, EXCP_RI);
                     break;
-- 
2.7.4
