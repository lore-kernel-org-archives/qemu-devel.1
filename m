Received: from eggs.gnu.org ([2001:4830:134:3::10]:56405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTM1-0006Jj-P1
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTLy-0004zQ-N6
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:19:05 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:50445)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gKTLy-0004yP-7G
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:19:02 -0500
Date: Wed, 7 Nov 2018 20:18:55 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <b7502a7707b8b75d500c96e81a76b03fdd67865c.1541616663.git.noring@nocrew.org>
References: <cover.1541616663.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1541616663.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v2 3/6] target/mips: Fix HI[ac] and LO[ac]
 32-bit truncation with MIPS64 DSP ASE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org

This change removes the 32-bit truncation of the HI[ac] and LO[ac]
special purpose registers when ac range from 1 to 3 for the instructions
MFHI, MFLO, MTHI and MTLO. The "MIPS Architecture for Programmers Volume
IV-e: MIPS DSP Module for MIPS64 Architecture" manual specifies that all
64 bits are copied in all cases:

   MFHI: GPR[rd]63..0 <- HI[ac]63..0
   MFLO: GPR[rd]63..0 <- LO[ac]63..0
   MTHI: HI[ac]63..0 <- GPR[rs]63..0
   MTLO: LO[ac]63..0 <- GPR[rs]63..0

Fixes: 4133498f8e53 ("Use correct acc value to index cpu_HI/cpu_LO rather than using a fix number")
Cc: Jia Liu <proljc@gmail.com>
Reported-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3ddd70043a..19ae7d2f1c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4409,49 +4409,21 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
 
     switch (opc) {
     case OPC_MFHI:
-#if defined(TARGET_MIPS64)
-        if (acc != 0) {
-            tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_HI[acc]);
-        } else
-#endif
-        {
-            tcg_gen_mov_tl(cpu_gpr[reg], cpu_HI[acc]);
-        }
+        tcg_gen_mov_tl(cpu_gpr[reg], cpu_HI[acc]);
         break;
     case OPC_MFLO:
-#if defined(TARGET_MIPS64)
-        if (acc != 0) {
-            tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_LO[acc]);
-        } else
-#endif
-        {
-            tcg_gen_mov_tl(cpu_gpr[reg], cpu_LO[acc]);
-        }
+        tcg_gen_mov_tl(cpu_gpr[reg], cpu_LO[acc]);
         break;
     case OPC_MTHI:
         if (reg != 0) {
-#if defined(TARGET_MIPS64)
-            if (acc != 0) {
-                tcg_gen_ext32s_tl(cpu_HI[acc], cpu_gpr[reg]);
-            } else
-#endif
-            {
-                tcg_gen_mov_tl(cpu_HI[acc], cpu_gpr[reg]);
-            }
+            tcg_gen_mov_tl(cpu_HI[acc], cpu_gpr[reg]);
         } else {
             tcg_gen_movi_tl(cpu_HI[acc], 0);
         }
         break;
     case OPC_MTLO:
         if (reg != 0) {
-#if defined(TARGET_MIPS64)
-            if (acc != 0) {
-                tcg_gen_ext32s_tl(cpu_LO[acc], cpu_gpr[reg]);
-            } else
-#endif
-            {
-                tcg_gen_mov_tl(cpu_LO[acc], cpu_gpr[reg]);
-            }
+            tcg_gen_mov_tl(cpu_LO[acc], cpu_gpr[reg]);
         } else {
             tcg_gen_movi_tl(cpu_LO[acc], 0);
         }
-- 
2.18.1
