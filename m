Received: from eggs.gnu.org ([2001:4830:134:3::10]:56049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmj0o-0000bC-Um
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmj0n-0001Ra-L8
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:09:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47061 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fmj0n-0001Nm-7n
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:09:41 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  6 Aug 2018 18:59:49 +0200
Message-Id: <1533574847-19294-23-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 22/80] target/mips: Add emulation of
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

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
index c4f1224..7a3d45b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16613,6 +16613,40 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
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
@@ -16692,6 +16726,13 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
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
