Received: from eggs.gnu.org ([2001:4830:134:3::10]:45180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFkP-00006d-Qe
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFkL-0001m7-Lt
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:34:33 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:47065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFkK-0001lA-2j
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:34:29 -0400
Date: Sun, 21 Oct 2018 17:34:21 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <31418c845a38988ae49a9e21d5b29bf5c23b1f55.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 08/38] target/mips: Define R5900 MMI2 opcode
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e233b87324..bd51443ac1 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2275,6 +2275,54 @@ enum {
     TX79_MMI1_QFSRV  = (0x1B << 6) | TX79_MMI_CLASS_MMI1,
 };
 
+/*
+ * TX79 Multimedia Instructions with opcode field = MMI and bits 5..0 = MMI2:
+ *
+ *  31    26                        10     6 5      0
+ * +--------+----------------------+--------+--------+
+ * |   MMI  |                      |function|  MMI2  |
+ * +--------+----------------------+--------+--------+
+ *
+ * function  bits 7..6
+ *     bits |   0   |   1   |   2   |   3
+ *    10..8 |   00  |   01  |   10  |   11
+ *   -------+-------+-------+-------+-------
+ *    0 000 | PMADDW|   *   | PSLLVW| PSRLVW
+ *    1 001 | PMSUBW|   *   |   *   |   *
+ *    2 010 | PMFHI | PMFLO | PINTH |   *
+ *    3 011 | PMULTW| PDIVW | PCPYLD|   *
+ *    4 100 | PMADDH| PHMADH|  PAND |  PXOR
+ *    5 101 | PMSUBH| PHMSBH|   *   |   *
+ *    6 110 |   *   |   *   | PEXEH | PREVH
+ *    7 111 | PMULTH| PDIVBW| PEXEW | PROT3W
+ */
+
+#define MASK_TX79_MMI2(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
+enum {
+    TX79_MMI2_PMADDW = (0x00 << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PSLLVW = (0x02 << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PSRLVW = (0x03 << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PMSUBW = (0x04 << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PMFHI  = (0x08 << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PMFLO  = (0x09 << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PINTH  = (0x0A << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PMULTW = (0x0C << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PDIVW  = (0x0D << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PCPYLD = (0x0E << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PMADDH = (0x10 << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PHMADH = (0x11 << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PAND   = (0x12 << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PXOR   = (0x13 << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PMSUBH = (0x14 << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PHMSBH = (0x15 << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PEXEH  = (0x1A << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PREVH  = (0x1B << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PMULTH = (0x1C << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PDIVBW = (0x1D << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PEXEW  = (0x1E << 6) | TX79_MMI_CLASS_MMI2,
+    TX79_MMI2_PROT3W = (0x1F << 6) | TX79_MMI_CLASS_MMI2,
+};
+
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_PC;
 static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
-- 
2.18.1
