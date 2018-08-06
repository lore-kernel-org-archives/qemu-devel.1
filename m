Received: from eggs.gnu.org ([2001:4830:134:3::10]:34176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmj81-0007p5-Sd
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmj7x-0000Gy-Dl
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:17:09 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56193 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fmj7x-0000Fb-5A
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:17:05 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  6 Aug 2018 19:00:07 +0200
Message-Id: <1533574847-19294-41-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 40/80] target/mips: Add emulation of DSP ASE
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of DSP ASE instructions for nanoMIPS - part 2.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 78b1c72..ba90c02 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -18988,6 +18988,16 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 case NM_BC1NEZC:
                     gen_compute_branch1_r6(ctx, OPC_BC1NEZ, rt, s, 0);
                     break;
+                case NM_BPOSGE32C:
+                    check_dspr2(ctx);
+                    {
+                        int32_t imm = extract32(ctx->opcode, 1, 13) |
+                                      extract32(ctx->opcode, 0, 1) << 13;
+
+                        gen_compute_branch(ctx, OPC_BPOSGE32, 4, -1, -2,
+                                           imm, 4);
+                    }
+                    break;
                 default:
                     generate_exception_end(ctx, EXCP_RI);
                     break;
-- 
2.7.4
