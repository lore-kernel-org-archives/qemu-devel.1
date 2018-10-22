Received: from eggs.gnu.org ([2001:4830:134:3::10]:45845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmc-0008Ns-Iq
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmY-00083R-Cr
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33264 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmX-00082e-Up
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:06 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:26 +0200
Message-Id: <1540213077-15211-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 03/34] target/mips: R5900 Multimedia Instruction
 overview note
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

Add a comment on R5900 MMI ASE (short overview).

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3a0bdd5..32d1d2d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1927,6 +1927,167 @@ enum {
     OPC_MXU_Q8MACSU  = 0x01,
 };
 
+/*
+ *     Overview of the TX79-specific instruction set
+ *     =============================================
+ *
+ * The R5900 and the C790 have 128-bit wide GPRs, where the upper 64 bits
+ * are only used by the specific quadword (128-bit) LQ/SQ load/store
+ * instructions and certain multimedia instructions (MMIs). These MMIs
+ * configure the 128-bit data path as two 64-bit, four 32-bit, eight 16-bit
+ * or sixteen 8-bit paths.
+ *
+ * Reference:
+ *
+ * The Toshiba TX System RISC TX79 Core Architecture manual,
+ * https://wiki.qemu.org/File:C790.pdf
+ *
+ *     Three-Operand Multiply and Multiply-Add (4 instructions)
+ *     --------------------------------------------------------
+ * MADD    [rd,] rs, rt      Multiply/Add
+ * MADDU   [rd,] rs, rt      Multiply/Add Unsigned
+ * MULT    [rd,] rs, rt      Multiply (3-operand)
+ * MULTU   [rd,] rs, rt      Multiply Unsigned (3-operand)
+ *
+ *     Multiply Instructions for Pipeline 1 (10 instructions)
+ *     ------------------------------------------------------
+ * MULT1   [rd,] rs, rt      Multiply Pipeline 1
+ * MULTU1  [rd,] rs, rt      Multiply Unsigned Pipeline 1
+ * DIV1    rs, rt            Divide Pipeline 1
+ * DIVU1   rs, rt            Divide Unsigned Pipeline 1
+ * MADD1   [rd,] rs, rt      Multiply-Add Pipeline 1
+ * MADDU1  [rd,] rs, rt      Multiply-Add Unsigned Pipeline 1
+ * MFHI1   rd                Move From HI1 Register
+ * MFLO1   rd                Move From LO1 Register
+ * MTHI1   rs                Move To HI1 Register
+ * MTLO1   rs                Move To LO1 Register
+ *
+ *     Arithmetic (19 instructions)
+ *     ----------------------------
+ * PADDB   rd, rs, rt        Parallel Add Byte
+ * PSUBB   rd, rs, rt        Parallel Subtract Byte
+ * PADDH   rd, rs, rt        Parallel Add Halfword
+ * PSUBH   rd, rs, rt        Parallel Subtract Halfword
+ * PADDW   rd, rs, rt        Parallel Add Word
+ * PSUBW   rd, rs, rt        Parallel Subtract Word
+ * PADSBH  rd, rs, rt        Parallel Add/Subtract Halfword
+ * PADDSB  rd, rs, rt        Parallel Add with Signed Saturation Byte
+ * PSUBSB  rd, rs, rt        Parallel Subtract with Signed Saturation Byte
+ * PADDSH  rd, rs, rt        Parallel Add with Signed Saturation Halfword
+ * PSUBSH  rd, rs, rt        Parallel Subtract with Signed Saturation Halfword
+ * PADDSW  rd, rs, rt        Parallel Add with Signed Saturation Word
+ * PSUBSW  rd, rs, rt        Parallel Subtract with Signed Saturation Word
+ * PADDUB  rd, rs, rt        Parallel Add with Unsigned saturation Byte
+ * PSUBUB  rd, rs, rt        Parallel Subtract with Unsigned saturation Byte
+ * PADDUH  rd, rs, rt        Parallel Add with Unsigned saturation Halfword
+ * PSUBUH  rd, rs, rt        Parallel Subtract with Unsigned saturation Halfword
+ * PADDUW  rd, rs, rt        Parallel Add with Unsigned saturation Word
+ * PSUBUW  rd, rs, rt        Parallel Subtract with Unsigned saturation Word
+ *
+ *     Min/Max (4 instructions)
+ *     ------------------------
+ * PMAXH   rd, rs, rt        Parallel Maximum Halfword
+ * PMINH   rd, rs, rt        Parallel Minimum Halfword
+ * PMAXW   rd, rs, rt        Parallel Maximum Word
+ * PMINW   rd, rs, rt        Parallel Minimum Word
+ *
+ *     Absolute (2 instructions)
+ *     -------------------------
+ * PABSH   rd, rt            Parallel Absolute Halfword
+ * PABSW   rd, rt            Parallel Absolute Word
+ *
+ *     Logical (4 instructions)
+ *     ------------------------
+ * PAND    rd, rs, rt        Parallel AND
+ * POR     rd, rs, rt        Parallel OR
+ * PXOR    rd, rs, rt        Parallel XOR
+ * PNOR    rd, rs, rt        Parallel NOR
+ *
+ *     Shift (9 instructions)
+ *     ----------------------
+ * PSLLH   rd, rt, sa        Parallel Shift Left Logical Halfword
+ * PSRLH   rd, rt, sa        Parallel Shift Right Logical Halfword
+ * PSRAH   rd, rt, sa        Parallel Shift Right Arithmetic Halfword
+ * PSLLW   rd, rt, sa        Parallel Shift Left Logical Word
+ * PSRLW   rd, rt, sa        Parallel Shift Right Logical Word
+ * PSRAW   rd, rt, sa        Parallel Shift Right Arithmetic Word
+ * PSLLVW  rd, rt, rs        Parallel Shift Left Logical Variable Word
+ * PSRLVW  rd, rt, rs        Parallel Shift Right Logical Variable Word
+ * PSRAVW  rd, rt, rs        Parallel Shift Right Arithmetic Variable Word
+ *
+ *     Compare (6 instructions)
+ *     ------------------------
+ * PCGTB   rd, rs, rt        Parallel Compare for Greater Than Byte
+ * PCEQB   rd, rs, rt        Parallel Compare for Equal Byte
+ * PCGTH   rd, rs, rt        Parallel Compare for Greater Than Halfword
+ * PCEQH   rd, rs, rt        Parallel Compare for Equal Halfword
+ * PCGTW   rd, rs, rt        Parallel Compare for Greater Than Word
+ * PCEQW   rd, rs, rt        Parallel Compare for Equal Word
+ *
+ *     LZC (1 instruction)
+ *     -------------------
+ * PLZCW   rd, rs            Parallel Leading Zero or One Count Word
+ *
+ *     Quadword Load and Store (2 instructions)
+ *     ----------------------------------------
+ * LQ      rt, offset(base)  Load Quadword
+ * SQ      rt, offset(base)  Store Quadword
+ *
+ *     Multiply and Divide (19 instructions)
+ *     -------------------------------------
+ * PMULTW  rd, rs, rt        Parallel Multiply Word
+ * PMULTUW rd, rs, rt        Parallel Multiply Unsigned Word
+ * PDIVW   rs, rt            Parallel Divide Word
+ * PDIVUW  rs, rt            Parallel Divide Unsigned Word
+ * PMADDW  rd, rs, rt        Parallel Multiply-Add Word
+ * PMADDUW rd, rs, rt        Parallel Multiply-Add Unsigned Word
+ * PMSUBW  rd, rs, rt        Parallel Multiply-Subtract Word
+ * PMULTH  rd, rs, rt        Parallel Multiply Halfword
+ * PMADDH  rd, rs, rt        Parallel Multiply-Add Halfword
+ * PMSUBH  rd, rs, rt        Parallel Multiply-Subtract Halfword
+ * PHMADH  rd, rs, rt        Parallel Horizontal Multiply-Add Halfword
+ * PHMSBH  rd, rs, rt        Parallel Horizontal Multiply-Subtract Halfword
+ * PDIVBW  rs, rt            Parallel Divide Broadcast Word
+ * PMFHI   rd                Parallel Move From HI Register
+ * PMFLO   rd                Parallel Move From LO Register
+ * PMTHI   rs                Parallel Move To HI Register
+ * PMTLO   rs                Parallel Move To LO Register
+ * PMFHL   rd                Parallel Move From HI/LO Register
+ * PMTHL   rs                Parallel Move To HI/LO Register
+ *
+ *     Pack/Extend (11 instructions)
+ *     -----------------------------
+ * PPAC5   rd, rt            Parallel Pack to 5 bits
+ * PPACB   rd, rs, rt        Parallel Pack to Byte
+ * PPACH   rd, rs, rt        Parallel Pack to Halfword
+ * PPACW   rd, rs, rt        Parallel Pack to Word
+ * PEXT5   rd, rt            Parallel Extend Upper from 5 bits
+ * PEXTUB  rd, rs, rt        Parallel Extend Upper from Byte
+ * PEXTLB  rd, rs, rt        Parallel Extend Lower from Byte
+ * PEXTUH  rd, rs, rt        Parallel Extend Upper from Halfword
+ * PEXTLH  rd, rs, rt        Parallel Extend Lower from Halfword
+ * PEXTUW  rd, rs, rt        Parallel Extend Upper from Word
+ * PEXTLW  rd, rs, rt        Parallel Extend Lower from Word
+ *
+ *     Others (16 instructions)
+ *     ------------------------
+ * PCPYH   rd, rt            Parallel Copy Halfword
+ * PCPYLD  rd, rs, rt        Parallel Copy Lower Doubleword
+ * PCPYUD  rd, rs, rt        Parallel Copy Upper Doubleword
+ * PREVH   rd, rt            Parallel Reverse Halfword
+ * PINTH   rd, rs, rt        Parallel Interleave Halfword
+ * PINTEH  rd, rs, rt        Parallel Interleave Even Halfword
+ * PEXEH   rd, rt            Parallel Exchange Even Halfword
+ * PEXCH   rd, rt            Parallel Exchange Center Halfword
+ * PEXEW   rd, rt            Parallel Exchange Even Word
+ * PEXCW   rd, rt            Parallel Exchange Center Word
+ * QFSRV   rd, rs, rt        Quadword Funnel Shift Right Variable
+ * MFSA    rd                Move from Shift Amount Register
+ * MTSA    rs                Move to Shift Amount Register
+ * MTSAB   rs, immediate     Move Byte Count to Shift Amount Register
+ * MTSAH   rs, immediate     Move Halfword Count to Shift Amount Register
+ * PROT3W  rd, rt            Parallel Rotate 3 Words
+ */
 
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_PC;
-- 
2.7.4
