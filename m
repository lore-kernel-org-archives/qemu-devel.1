Received: from eggs.gnu.org ([2001:4830:134:3::10]:45849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmc-0008Nx-Jc
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmZ-00084l-Fg
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33346 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmZ-00083G-4C
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:07 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:34 +0200
Message-Id: <1540213077-15211-12-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 11/34] target/mips: Placeholder for R5900 LQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Fredrik Noring <noring@nocrew.org>

Add a placeholder for LQ instruction.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 19a8aba..2318116 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24420,6 +24420,11 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void decode_tx79_lq(CPUMIPSState *env, DisasContext *ctx)
+{
+    generate_exception_end(ctx, EXCP_RI);    /* TODO: TX79_LQ */
+}
+
 static void gen_tx79_sq(DisasContext *ctx, int base, int rt, int offset)
 {
     generate_exception_end(ctx, EXCP_RI);    /* TODO: TX79_SQ */
@@ -26425,8 +26430,12 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_MSA: /* OPC_MDMX */
-        /* MDMX: Not implemented. */
-        gen_msa(env, ctx);
+        if (ctx->insn_flags & INSN_R5900) {
+            decode_tx79_lq(env, ctx);    /* TX79_LQ */
+        } else {
+            /* MDMX: Not implemented. */
+            gen_msa(env, ctx);
+        }
         break;
     case OPC_PCREL:
         check_insn(ctx, ISA_MIPS32R6);
-- 
2.7.4
