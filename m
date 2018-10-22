Received: from eggs.gnu.org ([2001:4830:134:3::10]:45847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmc-0008Nv-JE
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmZ-00084K-95
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33311 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmY-000830-PM
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:07 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:28 +0200
Message-Id: <1540213077-15211-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 05/34] target/mips: Define R5900 MMI{0, 1, 2,
 3} subclasses and MMI opcode constants
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

Define MMI0, MMI1, MMI2, MMI3 subclass opcodes, and other opcodes of
instructions in MMI class.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e205c3e..ae98817 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2129,6 +2129,57 @@ enum {
     TX79_SQ        = 0x1F << 26,    /* Same as OPC_SPECIAL3 */
 };
 
+/*
+ * TX79 Multimedia Instructions with opcode field = MMI:
+ *
+ *  31    26                                 5      0
+ * +--------+-------------------------------+--------+
+ * |   MMI  |                               |function|
+ * +--------+-------------------------------+--------+
+ *
+ * function  bits 2..0
+ *     bits |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7
+ *     5..3 |  000  |  001  |  010  |  011  |  100  |  101  |  110  |  111
+ *   -------+-------+-------+-------+-------+-------+-------+-------+-------
+ *    0 000 |  MADD | MADDU |   *   |   *   | PLZCW |   *   |   *   |   *
+ *    1 001 | MMI0% | MMI2% |   *   |   *   |   *   |   *   |   *   |   *
+ *    2 010 | MFHI1 | MTHI1 | MFLO1 | MTLO1 |   *   |   *   |   *   |   *
+ *    3 011 | MULT1 | MULTU1|  DIV1 | DIVU1 |   *   |   *   |   *   |   *
+ *    4 100 | MADD1 | MADDU1|   *   |   *   |   *   |   *   |   *   |   *
+ *    5 101 | MMI1% | MMI3% |   *   |   *   |   *   |   *   |   *   |   *
+ *    6 110 | PMFHL | PMTHL |   *   |   *   | PSLLH |   *   | PSRLH | PSRAH
+ *    7 111 |   *   |   *   |   *   |   *   | PSLLW |   *   | PSRLW | PSRAW
+ */
+
+#define MASK_TX79_MMI(op) (MASK_OP_MAJOR(op) | ((op) & 0x3F))
+enum {
+    TX79_MMI_MADD       = 0x00 | TX79_CLASS_MMI, /* Same as OPC_MADD */
+    TX79_MMI_MADDU      = 0x01 | TX79_CLASS_MMI, /* Same as OPC_MADDU */
+    TX79_MMI_PLZCW      = 0x04 | TX79_CLASS_MMI,
+    TX79_MMI_CLASS_MMI0 = 0x08 | TX79_CLASS_MMI,
+    TX79_MMI_CLASS_MMI2 = 0x09 | TX79_CLASS_MMI,
+    TX79_MMI_MFHI1      = 0x10 | TX79_CLASS_MMI, /* Same minor as OPC_MFHI */
+    TX79_MMI_MTHI1      = 0x11 | TX79_CLASS_MMI, /* Same minor as OPC_MTHI */
+    TX79_MMI_MFLO1      = 0x12 | TX79_CLASS_MMI, /* Same minor as OPC_MFLO */
+    TX79_MMI_MTLO1      = 0x13 | TX79_CLASS_MMI, /* Same minor as OPC_MTLO */
+    TX79_MMI_MULT1      = 0x18 | TX79_CLASS_MMI, /* Same minor as OPC_MULT */
+    TX79_MMI_MULTU1     = 0x19 | TX79_CLASS_MMI, /* Same minor as OPC_MULTU */
+    TX79_MMI_DIV1       = 0x1A | TX79_CLASS_MMI, /* Same minor as OPC_DIV */
+    TX79_MMI_DIVU1      = 0x1B | TX79_CLASS_MMI, /* Same minor as OPC_DIVU */
+    TX79_MMI_MADD1      = 0x20 | TX79_CLASS_MMI,
+    TX79_MMI_MADDU1     = 0x21 | TX79_CLASS_MMI,
+    TX79_MMI_CLASS_MMI1 = 0x28 | TX79_CLASS_MMI,
+    TX79_MMI_CLASS_MMI3 = 0x29 | TX79_CLASS_MMI,
+    TX79_MMI_PMFHL      = 0x30 | TX79_CLASS_MMI,
+    TX79_MMI_PMTHL      = 0x31 | TX79_CLASS_MMI,
+    TX79_MMI_PSLLH      = 0x34 | TX79_CLASS_MMI,
+    TX79_MMI_PSRLH      = 0x36 | TX79_CLASS_MMI,
+    TX79_MMI_PSRAH      = 0x37 | TX79_CLASS_MMI,
+    TX79_MMI_PSLLW      = 0x3C | TX79_CLASS_MMI,
+    TX79_MMI_PSRLW      = 0x3E | TX79_CLASS_MMI,
+    TX79_MMI_PSRAW      = 0x3F | TX79_CLASS_MMI,
+};
+
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_PC;
 static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
-- 
2.7.4
