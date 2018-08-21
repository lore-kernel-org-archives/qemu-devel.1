Received: from eggs.gnu.org ([2001:4830:134:3::10]:53393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6Np-00016P-5a
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6Nl-0008Lg-Gc
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35437 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs6Nl-0008Jw-77
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:37 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 15:06:51 +0200
Message-Id: <1534856848-12102-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534856848-12102-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534856848-12102-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 09/46] target/mips: Add emulation of nanoMIPS
 16-bit shift instructions
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

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of nanoMIPS 16-bit shift instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index b0bbf4c..e3fac1a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16765,6 +16765,21 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
     case NM_P16_MV:
         break;
     case NM_P16_SHIFT:
+        {
+            int shift = extract32(ctx->opcode, 0, 3);
+            uint32_t opc = 0;
+            shift = (shift == 0) ? 8 : shift;
+
+            switch (extract32(ctx->opcode, 3, 1)) {
+            case NM_SLL16:
+                opc = OPC_SLL;
+                break;
+            case NM_SRL16:
+                opc = OPC_SRL;
+                break;
+            }
+            gen_shift_imm(ctx, opc, rt, rs, shift);
+        }
         break;
     case NM_P16C:
         break;
-- 
2.7.4
