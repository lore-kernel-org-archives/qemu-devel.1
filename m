Received: from eggs.gnu.org ([2001:4830:134:3::10]:45002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFjU-0007uz-O7
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFjR-0001P3-JK
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:33:36 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:40592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFjR-0001On-7y
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:33:33 -0400
Date: Sun, 21 Oct 2018 17:33:20 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <533e7a49e3e75c38b6e5afbb222f794aa9d49a56.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 04/38] target/mips: Define R5900 MMI class,
 and LQ and SQ opcode constants
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
 target/mips/translate.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 32d1d2d83f..e205c3eaef 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2087,8 +2087,48 @@ enum {
  * MTSAB   rs, immediate     Move Byte Count to Shift Amount Register
  * MTSAH   rs, immediate     Move Halfword Count to Shift Amount Register
  * PROT3W  rd, rt            Parallel Rotate 3 Words
+ *
+ *     The TX79-specific Multimedia Instruction encodings
+ *     ==================================================
+ *
+ * TX79 Multimedia Instruction encoding table keys:
+ *
+ *     *   This code is reserved for future use. An attempt to execute it
+ *         causes a Reserved Instruction exception.
+ *     %   This code indicates an instruction class. The instruction word
+ *         must be further decoded by examining additional tables that show
+ *         the values for other instruction fields.
+ *     #   This code is reserved for the unsupported instructions DMULT,
+ *         DMULTU, DDIV, DDIVU, LL, LLD, SC, SCD, LWC2 and SWC2. An attempt
+ *         to execute it causes a Reserved Instruction exception.
+ *
+ * TX79 Multimedia Instructions encoded by opcode field (MMI, LQ, SQ):
+ *
+ *  31    26                                        0
+ * +--------+----------------------------------------+
+ * | opcode |                                        |
+ * +--------+----------------------------------------+
+ *
+ *   opcode  bits 28..26
+ *     bits |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7
+ *   31..29 |  000  |  001  |  010  |  011  |  100  |  101  |  110  |  111
+ *   -------+-------+-------+-------+-------+-------+-------+-------+-------
+ *    0 000 |SPECIAL| REGIMM|   J   |  JAL  |  BEQ  |  BNE  |  BLEZ |  BGTZ
+ *    1 001 |  ADDI | ADDIU |  SLTI | SLTIU |  ANDI |  ORI  |  XORI |  LUI
+ *    2 010 |  COP0 |  COP1 |   *   |   *   |  BEQL |  BNEL | BLEZL | BGTZL
+ *    3 011 | DADDI | DADDIU|  LDL  |  LDR  |  MMI% |   *   |   LQ  |   SQ
+ *    4 100 |   LB  |   LH  |  LWL  |   LW  |  LBU  |  LHU  |  LWR  |  LWU
+ *    5 101 |   SB  |   SH  |  SWL  |   SW  |  SDL  |  SDR  |  SWR  | CACHE
+ *    6 110 |   #   |  LWC1 |   #   |  PREF |   #   |  LDC1 |   #   |   LD
+ *    7 111 |   #   |  SWC1 |   #   |   *   |   #   |  SDC1 |   #   |   SD
  */
 
+enum {
+    TX79_CLASS_MMI = 0x1C << 26,    /* Same as OPC_SPECIAL2 */
+    TX79_LQ        = 0x1E << 26,    /* Same as OPC_MSA */
+    TX79_SQ        = 0x1F << 26,    /* Same as OPC_SPECIAL3 */
+};
+
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_PC;
 static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
-- 
2.18.1
