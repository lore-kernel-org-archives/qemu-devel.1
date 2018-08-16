Received: from eggs.gnu.org ([2001:4830:134:3::10]:56135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJl7-0005S4-MX
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJku-0000ec-6U
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:15 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43435 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJkt-0000cv-Tq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:08 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:57:17 +0200
Message-Id: <1534431497-1385-25-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v9 24/84] target/mips: Add emulation of
 nanoMIPS 16-bit misc instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of misc nanoMIPS 16-bit instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 855802d..8551723 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16658,6 +16658,40 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
     op = extract32(ctx->opcode, 10, 6);
     switch (op) {
     case NM_P16_MV:
+        rt = NANOMIPS_EXTRACT_RD5(ctx->opcode);
+        if (rt != 0) {
+            /* MOVE */
+            rs = NANOMIPS_EXTRACT_RS5(ctx->opcode);
+            gen_arith(ctx, OPC_ADDU, rt, rs, 0);
+        } else {
+            /* P16.RI */
+            switch (extract32(ctx->opcode, 3, 2)) {
+            case NM_P16_SYSCALL:
+                if (extract32(ctx->opcode, 2, 1) == 0) {
+                    generate_exception_end(ctx, EXCP_SYSCALL);
+                } else {
+                    generate_exception_end(ctx, EXCP_RI);
+                }
+                break;
+            case NM_BREAK16:
+                generate_exception_end(ctx, EXCP_BREAK);
+                break;
+            case NM_SDBBP16:
+                if (is_uhi(extract32(ctx->opcode, 0, 3))) {
+                    gen_helper_do_semihosting(cpu_env);
+                } else {
+                    if (ctx->hflags & MIPS_HFLAG_SBRI) {
+                        generate_exception_end(ctx, EXCP_RI);
+                    } else {
+                        generate_exception_end(ctx, EXCP_DBp);
+                    }
+                }
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+        }
         break;
     case NM_P16_SHIFT:
         {
@@ -16737,6 +16771,13 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_LI16:
+        {
+            int imm = extract32(ctx->opcode, 0, 7);
+            imm = (imm == 0x7f ? -1 : imm);
+            if (rt != 0) {
+                tcg_gen_movi_tl(cpu_gpr[rt], imm);
+            }
+        }
         break;
     case NM_ANDI16:
         break;
-- 
2.7.4
