Received: from eggs.gnu.org ([2001:4830:134:3::10]:35939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAtP-0004Xz-TG
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAtN-0006X1-6K
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:19:31 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55062 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkAtM-0006Wh-U0
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:19:29 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:11:53 +0200
Message-Id: <1532967169-22265-21-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 20/76] target/mips: Add emulation of
 nanoMIPS 16-bit branch instructions
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

Add emulation of nanoMIPS 16-bit branch instructions.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7e13df0..7d31857 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16627,14 +16627,50 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
     case NM_SWGP16:
         break;
     case NM_BC16:
+        gen_compute_branch(ctx, OPC_BEQ, 2, 0, 0,
+                           (sextract32(ctx->opcode, 0, 1) << 10) |
+                           (extract32(ctx->opcode, 1, 9) << 1), 0);
         break;
     case NM_BALC16:
+        gen_compute_branch(ctx, OPC_BGEZAL, 2, 0, 0,
+                           (sextract32(ctx->opcode, 0, 1) << 10) |
+                           (extract32(ctx->opcode, 1, 9) << 1), 0);
         break;
     case NM_BEQZC16:
+        gen_compute_branch(ctx, OPC_BEQ, 2, rt, 0,
+                           (sextract32(ctx->opcode, 0, 1) << 7) |
+                           (extract32(ctx->opcode, 1, 6) << 1), 0);
         break;
     case NM_BNEZC16:
+        gen_compute_branch(ctx, OPC_BNE, 2, rt, 0,
+                           (sextract32(ctx->opcode, 0, 1) << 7) |
+                           (extract32(ctx->opcode, 1, 6) << 1), 0);
         break;
     case NM_P16_BR:
+        switch (ctx->opcode & 0xf) {
+        case 0:
+            /* P16.JRC */
+            switch (extract32(ctx->opcode, 4, 1)) {
+            case NM_JRC:
+                gen_compute_branch(ctx, OPC_JR, 2,
+                                   extract32(ctx->opcode, 5, 5), 0, 0, 0);
+                break;
+            case NM_JALRC16:
+                gen_compute_branch(ctx, OPC_JALR, 2,
+                                   extract32(ctx->opcode, 5, 5), 31, 0, 0);
+                break;
+            }
+            break;
+        default:
+            {
+                /* P16.BRI */
+                uint32_t opc = extract32(ctx->opcode, 4, 3) <
+                               extract32(ctx->opcode, 7, 3) ? OPC_BEQ : OPC_BNE;
+                gen_compute_branch(ctx, opc, 2, rs, rt,
+                                   extract32(ctx->opcode, 0, 4) << 1, 0);
+            }
+            break;
+        }
         break;
     case NM_P16_SR:
         break;
-- 
2.7.4
