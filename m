Received: from eggs.gnu.org ([2001:4830:134:3::10]:36015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAta-0004ly-W7
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAtY-0006aw-3i
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:19:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55125 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkAtX-0006aD-RV
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:19:40 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:11:54 +0200
Message-Id: <1532967169-22265-22-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 21/76] target/mips: Add emulation of
 nanoMIPS 16-bit shift instructions
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

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of nanoMIPS 16-bit shift instructions.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7d31857..c985b93 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16541,6 +16541,21 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
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
