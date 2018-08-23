Received: from eggs.gnu.org ([2001:4830:134:3::10]:33555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fsqSI-0005F8-Dw
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fsqSG-0004p8-75
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:22 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57103 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fsqSF-0004na-MD
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:19 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 23 Aug 2018 16:18:45 +0200
Message-Id: <1535033941-861-31-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v5 30/46] target/mips: Add emulation of DSP ASE
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
Cc: peter.maydell@linaro.org

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of DSP ASE instructions for nanoMIPS - part 2.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d3635e7..59dcd87 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -19316,6 +19316,16 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 case NM_BC1NEZC:
                     gen_compute_branch_cp1_nm(ctx, OPC_BC1NEZ, rt, s);
                     break;
+                case NM_BPOSGE32C:
+                    check_dspr2(ctx);
+                    {
+                        int32_t imm = extract32(ctx->opcode, 1, 13) |
+                                      extract32(ctx->opcode, 0, 1) << 13;
+
+                        gen_compute_branch_nm(ctx, OPC_BPOSGE32, 4, -1, -2,
+                                              imm);
+                    }
+                    break;
                 default:
                     generate_exception_end(ctx, EXCP_RI);
                     break;
-- 
2.7.4
