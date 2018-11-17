Received: from eggs.gnu.org ([2001:4830:134:3::10]:43919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO5UO-00014D-Cv
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 13:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO5UL-00021v-My
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 13:38:40 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54264 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gO5UL-000214-FL
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 13:38:37 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Sat, 17 Nov 2018 19:38:23 +0100
Message-Id: <1542479908-20067-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1542479908-20067-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1542479908-20067-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 06/11] target/mips: Guard check_insn with
 INSN_R5900 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com, laurent@vivier.eu

From: Fredrik Noring <noring@nocrew.org>

Explicitely mark handling of PREF instruction for R5900 as
treating the same as NOP.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index c79da3c..714f2e6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28357,9 +28357,12 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_PREF:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
-        check_insn(ctx, ISA_MIPS4 | ISA_MIPS32 |
-                   INSN_R5900);
-        /* Treat as NOP. */
+        if (ctx->insn_flags & INSN_R5900) {
+            /* Treat as NOP. */
+        } else {
+            check_insn(ctx, ISA_MIPS4 | ISA_MIPS32);
+            /* Treat as NOP. */
+        }
         break;
 
     /* Floating point (COP1). */
-- 
2.7.4
