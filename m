Received: from eggs.gnu.org ([2001:4830:134:3::10]:47232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gG8r1-000775-2f
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 16:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gG8qy-00020W-4i
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 16:37:11 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49552 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gG8qx-0001eY-KP
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 16:37:08 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 26 Oct 2018 22:35:47 +0200
Message-Id: <1540586148-11285-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540586148-11285-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540586148-11285-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/3] target/mips: Rename MMI-related opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, juergenurban@gmx.de, noring@nocrew.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Rename MMI-related opcodes.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 470 ++++++++++++++++++++++++------------------------
 1 file changed, 235 insertions(+), 235 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e38d50d..4b008d8 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2099,7 +2099,7 @@ enum {
  *     The TX79-specific Multimedia Instruction encodings
  *     ==================================================
  *
- * TX79 Multimedia Instruction encoding table keys:
+ * MMI Instruction encoding table keys:
  *
  *     *   This code is reserved for future use. An attempt to execute it
  *         causes a Reserved Instruction exception.
@@ -2110,7 +2110,7 @@ enum {
  *         DMULTU, DDIV, DDIVU, LL, LLD, SC, SCD, LWC2 and SWC2. An attempt
  *         to execute it causes a Reserved Instruction exception.
  *
- * TX79 Multimedia Instructions encoded by opcode field (MMI, LQ, SQ):
+ * MMI Instructions encoded by opcode field (MMI, LQ, SQ):
  *
  *  31    26                                        0
  * +--------+----------------------------------------+
@@ -2132,13 +2132,13 @@ enum {
  */
 
 enum {
-    TX79_CLASS_MMI = 0x1C << 26,    /* Same as OPC_SPECIAL2 */
-    TX79_LQ        = 0x1E << 26,    /* Same as OPC_MSA */
-    TX79_SQ        = 0x1F << 26,    /* Same as OPC_SPECIAL3 */
+    MMI_CLASS_MMI = 0x1C << 26,    /* Same as OPC_SPECIAL2 */
+    MMI_LQ        = 0x1E << 26,    /* Same as OPC_MSA */
+    MMI_SQ        = 0x1F << 26,    /* Same as OPC_SPECIAL3 */
 };
 
 /*
- * TX79 Multimedia Instructions with opcode field = MMI:
+ * MMI Instructions with opcode field = MMI:
  *
  *  31    26                                 5      0
  * +--------+-------------------------------+--------+
@@ -2161,35 +2161,35 @@ enum {
 
 #define MASK_MMI(op) (MASK_OP_MAJOR(op) | ((op) & 0x3F))
 enum {
-    TX79_MMI_MADD       = 0x00 | TX79_CLASS_MMI, /* Same as OPC_MADD */
-    TX79_MMI_MADDU      = 0x01 | TX79_CLASS_MMI, /* Same as OPC_MADDU */
-    TX79_MMI_PLZCW      = 0x04 | TX79_CLASS_MMI,
-    TX79_MMI_CLASS_MMI0 = 0x08 | TX79_CLASS_MMI,
-    TX79_MMI_CLASS_MMI2 = 0x09 | TX79_CLASS_MMI,
-    TX79_MMI_MFHI1      = 0x10 | TX79_CLASS_MMI, /* Same minor as OPC_MFHI */
-    TX79_MMI_MTHI1      = 0x11 | TX79_CLASS_MMI, /* Same minor as OPC_MTHI */
-    TX79_MMI_MFLO1      = 0x12 | TX79_CLASS_MMI, /* Same minor as OPC_MFLO */
-    TX79_MMI_MTLO1      = 0x13 | TX79_CLASS_MMI, /* Same minor as OPC_MTLO */
-    TX79_MMI_MULT1      = 0x18 | TX79_CLASS_MMI, /* Same minor as OPC_MULT */
-    TX79_MMI_MULTU1     = 0x19 | TX79_CLASS_MMI, /* Same minor as OPC_MULTU */
-    TX79_MMI_DIV1       = 0x1A | TX79_CLASS_MMI, /* Same minor as OPC_DIV */
-    TX79_MMI_DIVU1      = 0x1B | TX79_CLASS_MMI, /* Same minor as OPC_DIVU */
-    TX79_MMI_MADD1      = 0x20 | TX79_CLASS_MMI,
-    TX79_MMI_MADDU1     = 0x21 | TX79_CLASS_MMI,
-    TX79_MMI_CLASS_MMI1 = 0x28 | TX79_CLASS_MMI,
-    TX79_MMI_CLASS_MMI3 = 0x29 | TX79_CLASS_MMI,
-    TX79_MMI_PMFHL      = 0x30 | TX79_CLASS_MMI,
-    TX79_MMI_PMTHL      = 0x31 | TX79_CLASS_MMI,
-    TX79_MMI_PSLLH      = 0x34 | TX79_CLASS_MMI,
-    TX79_MMI_PSRLH      = 0x36 | TX79_CLASS_MMI,
-    TX79_MMI_PSRAH      = 0x37 | TX79_CLASS_MMI,
-    TX79_MMI_PSLLW      = 0x3C | TX79_CLASS_MMI,
-    TX79_MMI_PSRLW      = 0x3E | TX79_CLASS_MMI,
-    TX79_MMI_PSRAW      = 0x3F | TX79_CLASS_MMI,
+    MMI_OPC_MADD       = 0x00 | MMI_CLASS_MMI, /* Same as OPC_MADD */
+    MMI_OPC_MADDU      = 0x01 | MMI_CLASS_MMI, /* Same as OPC_MADDU */
+    MMI_OPC_PLZCW      = 0x04 | MMI_CLASS_MMI,
+    MMI_OPC_CLASS_MMI0 = 0x08 | MMI_CLASS_MMI,
+    MMI_OPC_CLASS_MMI2 = 0x09 | MMI_CLASS_MMI,
+    MMI_OPC_MFHI1      = 0x10 | MMI_CLASS_MMI, /* Same minor as OPC_MFHI */
+    MMI_OPC_MTHI1      = 0x11 | MMI_CLASS_MMI, /* Same minor as OPC_MTHI */
+    MMI_OPC_MFLO1      = 0x12 | MMI_CLASS_MMI, /* Same minor as OPC_MFLO */
+    MMI_OPC_MTLO1      = 0x13 | MMI_CLASS_MMI, /* Same minor as OPC_MTLO */
+    MMI_OPC_MULT1      = 0x18 | MMI_CLASS_MMI, /* Same minor as OPC_MULT */
+    MMI_OPC_MULTU1     = 0x19 | MMI_CLASS_MMI, /* Same minor as OPC_MULTU */
+    MMI_OPC_DIV1       = 0x1A | MMI_CLASS_MMI, /* Same minor as OPC_DIV */
+    MMI_OPC_DIVU1      = 0x1B | MMI_CLASS_MMI, /* Same minor as OPC_DIVU */
+    MMI_OPC_MADD1      = 0x20 | MMI_CLASS_MMI,
+    MMI_OPC_MADDU1     = 0x21 | MMI_CLASS_MMI,
+    MMI_OPC_CLASS_MMI1 = 0x28 | MMI_CLASS_MMI,
+    MMI_OPC_CLASS_MMI3 = 0x29 | MMI_CLASS_MMI,
+    MMI_OPC_PMFHL      = 0x30 | MMI_CLASS_MMI,
+    MMI_OPC_PMTHL      = 0x31 | MMI_CLASS_MMI,
+    MMI_OPC_PSLLH      = 0x34 | MMI_CLASS_MMI,
+    MMI_OPC_PSRLH      = 0x36 | MMI_CLASS_MMI,
+    MMI_OPC_PSRAH      = 0x37 | MMI_CLASS_MMI,
+    MMI_OPC_PSLLW      = 0x3C | MMI_CLASS_MMI,
+    MMI_OPC_PSRLW      = 0x3E | MMI_CLASS_MMI,
+    MMI_OPC_PSRAW      = 0x3F | MMI_CLASS_MMI,
 };
 
 /*
- * TX79 Multimedia Instructions with opcode field = MMI and bits 5..0 = MMI0:
+ * MMI Instructions with opcode field = MMI and bits 5..0 = MMI0:
  *
  *  31    26                        10     6 5      0
  * +--------+----------------------+--------+--------+
@@ -2212,35 +2212,35 @@ enum {
 
 #define MASK_MMI0(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
 enum {
-    TX79_MMI0_PADDW  = (0x00 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PSUBW  = (0x01 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PCGTW  = (0x02 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PMAXW  = (0x03 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PADDH  = (0x04 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PSUBH  = (0x05 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PCGTH  = (0x06 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PMAXH  = (0x07 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PADDB  = (0x08 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PSUBB  = (0x09 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PCGTB  = (0x0A << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PADDSW = (0x10 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PSUBSW = (0x11 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PEXTLW = (0x12 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PPACW  = (0x13 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PADDSH = (0x14 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PSUBSH = (0x15 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PEXTLH = (0x16 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PPACH  = (0x17 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PADDSB = (0x18 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PSUBSB = (0x19 << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PEXTLB = (0x1A << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PPACB  = (0x1B << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PEXT5  = (0x1E << 6) | TX79_MMI_CLASS_MMI0,
-    TX79_MMI0_PPAC5  = (0x1F << 6) | TX79_MMI_CLASS_MMI0,
+    MMI_OPC_0_PADDW  = (0x00 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PSUBW  = (0x01 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PCGTW  = (0x02 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PMAXW  = (0x03 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PADDH  = (0x04 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PSUBH  = (0x05 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PCGTH  = (0x06 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PMAXH  = (0x07 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PADDB  = (0x08 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PSUBB  = (0x09 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PCGTB  = (0x0A << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PADDSW = (0x10 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PSUBSW = (0x11 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PEXTLW = (0x12 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PPACW  = (0x13 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PADDSH = (0x14 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PSUBSH = (0x15 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PEXTLH = (0x16 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PPACH  = (0x17 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PADDSB = (0x18 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PSUBSB = (0x19 << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PEXTLB = (0x1A << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PPACB  = (0x1B << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PEXT5  = (0x1E << 6) | MMI_OPC_CLASS_MMI0,
+    MMI_OPC_0_PPAC5  = (0x1F << 6) | MMI_OPC_CLASS_MMI0,
 };
 
 /*
- * TX79 Multimedia Instructions with opcode field = MMI and bits 5..0 = MMI1:
+ * MMI Instructions with opcode field = MMI and bits 5..0 = MMI1:
  *
  *  31    26                        10     6 5      0
  * +--------+----------------------+--------+--------+
@@ -2263,28 +2263,28 @@ enum {
 
 #define MASK_MMI1(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
 enum {
-    TX79_MMI1_PABSW  = (0x01 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PCEQW  = (0x02 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PMINW  = (0x03 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PADSBH = (0x04 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PABSH  = (0x05 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PCEQH  = (0x06 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PMINH  = (0x07 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PCEQB  = (0x0A << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PADDUW = (0x10 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PSUBUW = (0x11 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PEXTUW = (0x12 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PADDUH = (0x14 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PSUBUH = (0x15 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PEXTUH = (0x16 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PADDUB = (0x18 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PSUBUB = (0x19 << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_PEXTUB = (0x1A << 6) | TX79_MMI_CLASS_MMI1,
-    TX79_MMI1_QFSRV  = (0x1B << 6) | TX79_MMI_CLASS_MMI1,
+    MMI_OPC_1_PABSW  = (0x01 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PCEQW  = (0x02 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PMINW  = (0x03 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PADSBH = (0x04 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PABSH  = (0x05 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PCEQH  = (0x06 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PMINH  = (0x07 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PCEQB  = (0x0A << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PADDUW = (0x10 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PSUBUW = (0x11 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PEXTUW = (0x12 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PADDUH = (0x14 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PSUBUH = (0x15 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PEXTUH = (0x16 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PADDUB = (0x18 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PSUBUB = (0x19 << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_PEXTUB = (0x1A << 6) | MMI_OPC_CLASS_MMI1,
+    MMI_OPC_1_QFSRV  = (0x1B << 6) | MMI_OPC_CLASS_MMI1,
 };
 
 /*
- * TX79 Multimedia Instructions with opcode field = MMI and bits 5..0 = MMI2:
+ * MMI Instructions with opcode field = MMI and bits 5..0 = MMI2:
  *
  *  31    26                        10     6 5      0
  * +--------+----------------------+--------+--------+
@@ -2307,32 +2307,32 @@ enum {
 
 #define MASK_MMI2(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
 enum {
-    TX79_MMI2_PMADDW = (0x00 << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PSLLVW = (0x02 << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PSRLVW = (0x03 << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PMSUBW = (0x04 << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PMFHI  = (0x08 << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PMFLO  = (0x09 << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PINTH  = (0x0A << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PMULTW = (0x0C << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PDIVW  = (0x0D << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PCPYLD = (0x0E << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PMADDH = (0x10 << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PHMADH = (0x11 << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PAND   = (0x12 << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PXOR   = (0x13 << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PMSUBH = (0x14 << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PHMSBH = (0x15 << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PEXEH  = (0x1A << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PREVH  = (0x1B << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PMULTH = (0x1C << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PDIVBW = (0x1D << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PEXEW  = (0x1E << 6) | TX79_MMI_CLASS_MMI2,
-    TX79_MMI2_PROT3W = (0x1F << 6) | TX79_MMI_CLASS_MMI2,
+    MMI_OPC_2_PMADDW = (0x00 << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PSLLVW = (0x02 << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PSRLVW = (0x03 << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PMSUBW = (0x04 << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PMFHI  = (0x08 << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PMFLO  = (0x09 << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PINTH  = (0x0A << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PMULTW = (0x0C << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PDIVW  = (0x0D << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PCPYLD = (0x0E << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PMADDH = (0x10 << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PHMADH = (0x11 << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PAND   = (0x12 << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PXOR   = (0x13 << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PMSUBH = (0x14 << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PHMSBH = (0x15 << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PEXEH  = (0x1A << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PREVH  = (0x1B << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PMULTH = (0x1C << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PDIVBW = (0x1D << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PEXEW  = (0x1E << 6) | MMI_OPC_CLASS_MMI2,
+    MMI_OPC_2_PROT3W = (0x1F << 6) | MMI_OPC_CLASS_MMI2,
 };
 
 /*
- * TX79 Multimedia Instructions with opcode field = MMI and bits 5..0 = MMI3:
+ * MMI Instructions with opcode field = MMI and bits 5..0 = MMI3:
  *
  *  31    26                        10     6 5      0
  * +--------+----------------------+--------+--------+
@@ -2355,19 +2355,19 @@ enum {
 
 #define MASK_MMI3(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
 enum {
-    TX79_MMI3_PMADDUW = (0x00 << 6) | TX79_MMI_CLASS_MMI3,
-    TX79_MMI3_PSRAVW  = (0x03 << 6) | TX79_MMI_CLASS_MMI3,
-    TX79_MMI3_PMTHI   = (0x08 << 6) | TX79_MMI_CLASS_MMI3,
-    TX79_MMI3_PMTLO   = (0x09 << 6) | TX79_MMI_CLASS_MMI3,
-    TX79_MMI3_PINTEH  = (0x0A << 6) | TX79_MMI_CLASS_MMI3,
-    TX79_MMI3_PMULTUW = (0x0C << 6) | TX79_MMI_CLASS_MMI3,
-    TX79_MMI3_PDIVUW  = (0x0D << 6) | TX79_MMI_CLASS_MMI3,
-    TX79_MMI3_PCPYUD  = (0x0E << 6) | TX79_MMI_CLASS_MMI3,
-    TX79_MMI3_POR     = (0x12 << 6) | TX79_MMI_CLASS_MMI3,
-    TX79_MMI3_PNOR    = (0x13 << 6) | TX79_MMI_CLASS_MMI3,
-    TX79_MMI3_PEXCH   = (0x1A << 6) | TX79_MMI_CLASS_MMI3,
-    TX79_MMI3_PCPYH   = (0x1B << 6) | TX79_MMI_CLASS_MMI3,
-    TX79_MMI3_PEXCW   = (0x1E << 6) | TX79_MMI_CLASS_MMI3,
+    MMI_OPC_3_PMADDUW = (0x00 << 6) | MMI_OPC_CLASS_MMI3,
+    MMI_OPC_3_PSRAVW  = (0x03 << 6) | MMI_OPC_CLASS_MMI3,
+    MMI_OPC_3_PMTHI   = (0x08 << 6) | MMI_OPC_CLASS_MMI3,
+    MMI_OPC_3_PMTLO   = (0x09 << 6) | MMI_OPC_CLASS_MMI3,
+    MMI_OPC_3_PINTEH  = (0x0A << 6) | MMI_OPC_CLASS_MMI3,
+    MMI_OPC_3_PMULTUW = (0x0C << 6) | MMI_OPC_CLASS_MMI3,
+    MMI_OPC_3_PDIVUW  = (0x0D << 6) | MMI_OPC_CLASS_MMI3,
+    MMI_OPC_3_PCPYUD  = (0x0E << 6) | MMI_OPC_CLASS_MMI3,
+    MMI_OPC_3_POR     = (0x12 << 6) | MMI_OPC_CLASS_MMI3,
+    MMI_OPC_3_PNOR    = (0x13 << 6) | MMI_OPC_CLASS_MMI3,
+    MMI_OPC_3_PEXCH   = (0x1A << 6) | MMI_OPC_CLASS_MMI3,
+    MMI_OPC_3_PCPYH   = (0x1B << 6) | MMI_OPC_CLASS_MMI3,
+    MMI_OPC_3_PEXCW   = (0x1E << 6) | MMI_OPC_CLASS_MMI3,
 };
 
 /* global register indices */
@@ -4281,8 +4281,8 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
 /* Arithmetic on HI/LO registers */
 static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
 {
-    if (reg == 0 && (opc == OPC_MFHI || opc == TX79_MMI_MFHI1 ||
-                     opc == OPC_MFLO || opc == TX79_MMI_MFLO1)) {
+    if (reg == 0 && (opc == OPC_MFHI || opc == MMI_OPC_MFHI1 ||
+                     opc == OPC_MFLO || opc == MMI_OPC_MFLO1)) {
         /* Treat as NOP. */
         return;
     }
@@ -4295,7 +4295,7 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
 
     switch (opc) {
     case OPC_MFHI:
-    case TX79_MMI_MFHI1:
+    case MMI_OPC_MFHI1:
 #if defined(TARGET_MIPS64)
         if (acc != 0) {
             tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_HI[acc]);
@@ -4306,7 +4306,7 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MFLO:
-    case TX79_MMI_MFLO1:
+    case MMI_OPC_MFLO1:
 #if defined(TARGET_MIPS64)
         if (acc != 0) {
             tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_LO[acc]);
@@ -4317,7 +4317,7 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MTHI:
-    case TX79_MMI_MTHI1:
+    case MMI_OPC_MTHI1:
         if (reg != 0) {
 #if defined(TARGET_MIPS64)
             if (acc != 0) {
@@ -4332,7 +4332,7 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MTLO:
-    case TX79_MMI_MTLO1:
+    case MMI_OPC_MTLO1:
         if (reg != 0) {
 #if defined(TARGET_MIPS64)
             if (acc != 0) {
@@ -4652,7 +4652,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
 
     switch (opc) {
     case OPC_DIV:
-    case TX79_MMI_DIV1:
+    case MMI_OPC_DIV1:
         {
             TCGv t2 = tcg_temp_new();
             TCGv t3 = tcg_temp_new();
@@ -4674,7 +4674,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
         }
         break;
     case OPC_DIVU:
-    case TX79_MMI_DIVU1:
+    case MMI_OPC_DIVU1:
         {
             TCGv t2 = tcg_const_tl(0);
             TCGv t3 = tcg_const_tl(1);
@@ -4858,7 +4858,7 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
     gen_load_gpr(t1, rt);
 
     switch (opc) {
-    case TX79_MMI_MULT1:
+    case MMI_OPC_MULT1:
         acc = 1;
         /* Fall through */
     case OPC_MULT:
@@ -4877,7 +4877,7 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i32(t3);
         }
         break;
-    case TX79_MMI_MULTU1:
+    case MMI_OPC_MULTU1:
         acc = 1;
         /* Fall through */
     case OPC_MULTU:
@@ -24686,32 +24686,32 @@ static void decode_tx79_mmi0(CPUMIPSState *env, DisasContext *ctx)
     uint32_t opc = MASK_MMI0(ctx->opcode);
 
     switch (opc) {
-    case TX79_MMI0_PADDW:     /* TODO: TX79_MMI0_PADDW */
-    case TX79_MMI0_PSUBW:     /* TODO: TX79_MMI0_PSUBW */
-    case TX79_MMI0_PCGTW:     /* TODO: TX79_MMI0_PCGTW */
-    case TX79_MMI0_PMAXW:     /* TODO: TX79_MMI0_PMAXW */
-    case TX79_MMI0_PADDH:     /* TODO: TX79_MMI0_PADDH */
-    case TX79_MMI0_PSUBH:     /* TODO: TX79_MMI0_PSUBH */
-    case TX79_MMI0_PCGTH:     /* TODO: TX79_MMI0_PCGTH */
-    case TX79_MMI0_PMAXH:     /* TODO: TX79_MMI0_PMAXH */
-    case TX79_MMI0_PADDB:     /* TODO: TX79_MMI0_PADDB */
-    case TX79_MMI0_PSUBB:     /* TODO: TX79_MMI0_PSUBB */
-    case TX79_MMI0_PCGTB:     /* TODO: TX79_MMI0_PCGTB */
-    case TX79_MMI0_PADDSW:    /* TODO: TX79_MMI0_PADDSW */
-    case TX79_MMI0_PSUBSW:    /* TODO: TX79_MMI0_PSUBSW */
-    case TX79_MMI0_PEXTLW:    /* TODO: TX79_MMI0_PEXTLW */
-    case TX79_MMI0_PPACW:     /* TODO: TX79_MMI0_PPACW */
-    case TX79_MMI0_PADDSH:    /* TODO: TX79_MMI0_PADDSH */
-    case TX79_MMI0_PSUBSH:    /* TODO: TX79_MMI0_PSUBSH */
-    case TX79_MMI0_PEXTLH:    /* TODO: TX79_MMI0_PEXTLH */
-    case TX79_MMI0_PPACH:     /* TODO: TX79_MMI0_PPACH */
-    case TX79_MMI0_PADDSB:    /* TODO: TX79_MMI0_PADDSB */
-    case TX79_MMI0_PSUBSB:    /* TODO: TX79_MMI0_PSUBSB */
-    case TX79_MMI0_PEXTLB:    /* TODO: TX79_MMI0_PEXTLB */
-    case TX79_MMI0_PPACB:     /* TODO: TX79_MMI0_PPACB */
-    case TX79_MMI0_PEXT5:     /* TODO: TX79_MMI0_PEXT5 */
-    case TX79_MMI0_PPAC5:     /* TODO: TX79_MMI0_PPAC5 */
-        generate_exception_end(ctx, EXCP_RI); /* TODO: TX79_MMI_CLASS_MMI0 */
+    case MMI_OPC_0_PADDW:     /* TODO: MMI_OPC_0_PADDW */
+    case MMI_OPC_0_PSUBW:     /* TODO: MMI_OPC_0_PSUBW */
+    case MMI_OPC_0_PCGTW:     /* TODO: MMI_OPC_0_PCGTW */
+    case MMI_OPC_0_PMAXW:     /* TODO: MMI_OPC_0_PMAXW */
+    case MMI_OPC_0_PADDH:     /* TODO: MMI_OPC_0_PADDH */
+    case MMI_OPC_0_PSUBH:     /* TODO: MMI_OPC_0_PSUBH */
+    case MMI_OPC_0_PCGTH:     /* TODO: MMI_OPC_0_PCGTH */
+    case MMI_OPC_0_PMAXH:     /* TODO: MMI_OPC_0_PMAXH */
+    case MMI_OPC_0_PADDB:     /* TODO: MMI_OPC_0_PADDB */
+    case MMI_OPC_0_PSUBB:     /* TODO: MMI_OPC_0_PSUBB */
+    case MMI_OPC_0_PCGTB:     /* TODO: MMI_OPC_0_PCGTB */
+    case MMI_OPC_0_PADDSW:    /* TODO: MMI_OPC_0_PADDSW */
+    case MMI_OPC_0_PSUBSW:    /* TODO: MMI_OPC_0_PSUBSW */
+    case MMI_OPC_0_PEXTLW:    /* TODO: MMI_OPC_0_PEXTLW */
+    case MMI_OPC_0_PPACW:     /* TODO: MMI_OPC_0_PPACW */
+    case MMI_OPC_0_PADDSH:    /* TODO: MMI_OPC_0_PADDSH */
+    case MMI_OPC_0_PSUBSH:    /* TODO: MMI_OPC_0_PSUBSH */
+    case MMI_OPC_0_PEXTLH:    /* TODO: MMI_OPC_0_PEXTLH */
+    case MMI_OPC_0_PPACH:     /* TODO: MMI_OPC_0_PPACH */
+    case MMI_OPC_0_PADDSB:    /* TODO: MMI_OPC_0_PADDSB */
+    case MMI_OPC_0_PSUBSB:    /* TODO: MMI_OPC_0_PSUBSB */
+    case MMI_OPC_0_PEXTLB:    /* TODO: MMI_OPC_0_PEXTLB */
+    case MMI_OPC_0_PPACB:     /* TODO: MMI_OPC_0_PPACB */
+    case MMI_OPC_0_PEXT5:     /* TODO: MMI_OPC_0_PEXT5 */
+    case MMI_OPC_0_PPAC5:     /* TODO: MMI_OPC_0_PPAC5 */
+        generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI0 */
         break;
     default:
         MIPS_INVAL("TX79 MMI class MMI0");
@@ -24725,25 +24725,25 @@ static void decode_tx79_mmi1(CPUMIPSState *env, DisasContext *ctx)
     uint32_t opc = MASK_MMI1(ctx->opcode);
 
     switch (opc) {
-    case TX79_MMI1_PABSW:     /* TODO: TX79_MMI1_PABSW */
-    case TX79_MMI1_PCEQW:     /* TODO: TX79_MMI1_PCEQW */
-    case TX79_MMI1_PMINW:     /* TODO: TX79_MMI1_PMINW */
-    case TX79_MMI1_PADSBH:    /* TODO: TX79_MMI1_PADSBH */
-    case TX79_MMI1_PABSH:     /* TODO: TX79_MMI1_PABSH */
-    case TX79_MMI1_PCEQH:     /* TODO: TX79_MMI1_PCEQH */
-    case TX79_MMI1_PMINH:     /* TODO: TX79_MMI1_PMINH */
-    case TX79_MMI1_PCEQB:     /* TODO: TX79_MMI1_PCEQB */
-    case TX79_MMI1_PADDUW:    /* TODO: TX79_MMI1_PADDUW */
-    case TX79_MMI1_PSUBUW:    /* TODO: TX79_MMI1_PSUBUW */
-    case TX79_MMI1_PEXTUW:    /* TODO: TX79_MMI1_PEXTUW */
-    case TX79_MMI1_PADDUH:    /* TODO: TX79_MMI1_PADDUH */
-    case TX79_MMI1_PSUBUH:    /* TODO: TX79_MMI1_PSUBUH */
-    case TX79_MMI1_PEXTUH:    /* TODO: TX79_MMI1_PEXTUH */
-    case TX79_MMI1_PADDUB:    /* TODO: TX79_MMI1_PADDUB */
-    case TX79_MMI1_PSUBUB:    /* TODO: TX79_MMI1_PSUBUB */
-    case TX79_MMI1_PEXTUB:    /* TODO: TX79_MMI1_PEXTUB */
-    case TX79_MMI1_QFSRV:     /* TODO: TX79_MMI1_QFSRV */
-        generate_exception_end(ctx, EXCP_RI); /* TODO: TX79_MMI_CLASS_MMI1 */
+    case MMI_OPC_1_PABSW:     /* TODO: MMI_OPC_1_PABSW */
+    case MMI_OPC_1_PCEQW:     /* TODO: MMI_OPC_1_PCEQW */
+    case MMI_OPC_1_PMINW:     /* TODO: MMI_OPC_1_PMINW */
+    case MMI_OPC_1_PADSBH:    /* TODO: MMI_OPC_1_PADSBH */
+    case MMI_OPC_1_PABSH:     /* TODO: MMI_OPC_1_PABSH */
+    case MMI_OPC_1_PCEQH:     /* TODO: MMI_OPC_1_PCEQH */
+    case MMI_OPC_1_PMINH:     /* TODO: MMI_OPC_1_PMINH */
+    case MMI_OPC_1_PCEQB:     /* TODO: MMI_OPC_1_PCEQB */
+    case MMI_OPC_1_PADDUW:    /* TODO: MMI_OPC_1_PADDUW */
+    case MMI_OPC_1_PSUBUW:    /* TODO: MMI_OPC_1_PSUBUW */
+    case MMI_OPC_1_PEXTUW:    /* TODO: MMI_OPC_1_PEXTUW */
+    case MMI_OPC_1_PADDUH:    /* TODO: MMI_OPC_1_PADDUH */
+    case MMI_OPC_1_PSUBUH:    /* TODO: MMI_OPC_1_PSUBUH */
+    case MMI_OPC_1_PEXTUH:    /* TODO: MMI_OPC_1_PEXTUH */
+    case MMI_OPC_1_PADDUB:    /* TODO: MMI_OPC_1_PADDUB */
+    case MMI_OPC_1_PSUBUB:    /* TODO: MMI_OPC_1_PSUBUB */
+    case MMI_OPC_1_PEXTUB:    /* TODO: MMI_OPC_1_PEXTUB */
+    case MMI_OPC_1_QFSRV:     /* TODO: MMI_OPC_1_QFSRV */
+        generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI1 */
         break;
     default:
         MIPS_INVAL("TX79 MMI class MMI1");
@@ -24757,29 +24757,29 @@ static void decode_tx79_mmi2(CPUMIPSState *env, DisasContext *ctx)
     uint32_t opc = MASK_MMI2(ctx->opcode);
 
     switch (opc) {
-    case TX79_MMI2_PMADDW:    /* TODO: TX79_MMI2_PMADDW */
-    case TX79_MMI2_PSLLVW:    /* TODO: TX79_MMI2_PSLLVW */
-    case TX79_MMI2_PSRLVW:    /* TODO: TX79_MMI2_PSRLVW */
-    case TX79_MMI2_PMSUBW:    /* TODO: TX79_MMI2_PMSUBW */
-    case TX79_MMI2_PMFHI:     /* TODO: TX79_MMI2_PMFHI */
-    case TX79_MMI2_PMFLO:     /* TODO: TX79_MMI2_PMFLO */
-    case TX79_MMI2_PINTH:     /* TODO: TX79_MMI2_PINTH */
-    case TX79_MMI2_PMULTW:    /* TODO: TX79_MMI2_PMULTW */
-    case TX79_MMI2_PDIVW:     /* TODO: TX79_MMI2_PDIVW */
-    case TX79_MMI2_PCPYLD:    /* TODO: TX79_MMI2_PCPYLD */
-    case TX79_MMI2_PMADDH:    /* TODO: TX79_MMI2_PMADDH */
-    case TX79_MMI2_PHMADH:    /* TODO: TX79_MMI2_PHMADH */
-    case TX79_MMI2_PAND:      /* TODO: TX79_MMI2_PAND */
-    case TX79_MMI2_PXOR:      /* TODO: TX79_MMI2_PXOR */
-    case TX79_MMI2_PMSUBH:    /* TODO: TX79_MMI2_PMSUBH */
-    case TX79_MMI2_PHMSBH:    /* TODO: TX79_MMI2_PHMSBH */
-    case TX79_MMI2_PEXEH:     /* TODO: TX79_MMI2_PEXEH */
-    case TX79_MMI2_PREVH:     /* TODO: TX79_MMI2_PREVH */
-    case TX79_MMI2_PMULTH:    /* TODO: TX79_MMI2_PMULTH */
-    case TX79_MMI2_PDIVBW:    /* TODO: TX79_MMI2_PDIVBW */
-    case TX79_MMI2_PEXEW:     /* TODO: TX79_MMI2_PEXEW */
-    case TX79_MMI2_PROT3W:    /* TODO: TX79_MMI2_PROT3W */
-        generate_exception_end(ctx, EXCP_RI); /* TODO: TX79_MMI_CLASS_MMI2 */
+    case MMI_OPC_2_PMADDW:    /* TODO: MMI_OPC_2_PMADDW */
+    case MMI_OPC_2_PSLLVW:    /* TODO: MMI_OPC_2_PSLLVW */
+    case MMI_OPC_2_PSRLVW:    /* TODO: MMI_OPC_2_PSRLVW */
+    case MMI_OPC_2_PMSUBW:    /* TODO: MMI_OPC_2_PMSUBW */
+    case MMI_OPC_2_PMFHI:     /* TODO: MMI_OPC_2_PMFHI */
+    case MMI_OPC_2_PMFLO:     /* TODO: MMI_OPC_2_PMFLO */
+    case MMI_OPC_2_PINTH:     /* TODO: MMI_OPC_2_PINTH */
+    case MMI_OPC_2_PMULTW:    /* TODO: MMI_OPC_2_PMULTW */
+    case MMI_OPC_2_PDIVW:     /* TODO: MMI_OPC_2_PDIVW */
+    case MMI_OPC_2_PCPYLD:    /* TODO: MMI_OPC_2_PCPYLD */
+    case MMI_OPC_2_PMADDH:    /* TODO: MMI_OPC_2_PMADDH */
+    case MMI_OPC_2_PHMADH:    /* TODO: MMI_OPC_2_PHMADH */
+    case MMI_OPC_2_PAND:      /* TODO: MMI_OPC_2_PAND */
+    case MMI_OPC_2_PXOR:      /* TODO: MMI_OPC_2_PXOR */
+    case MMI_OPC_2_PMSUBH:    /* TODO: MMI_OPC_2_PMSUBH */
+    case MMI_OPC_2_PHMSBH:    /* TODO: MMI_OPC_2_PHMSBH */
+    case MMI_OPC_2_PEXEH:     /* TODO: MMI_OPC_2_PEXEH */
+    case MMI_OPC_2_PREVH:     /* TODO: MMI_OPC_2_PREVH */
+    case MMI_OPC_2_PMULTH:    /* TODO: MMI_OPC_2_PMULTH */
+    case MMI_OPC_2_PDIVBW:    /* TODO: MMI_OPC_2_PDIVBW */
+    case MMI_OPC_2_PEXEW:     /* TODO: MMI_OPC_2_PEXEW */
+    case MMI_OPC_2_PROT3W:    /* TODO: MMI_OPC_2_PROT3W */
+        generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI2 */
         break;
     default:
         MIPS_INVAL("TX79 MMI class MMI2");
@@ -24793,20 +24793,20 @@ static void decode_tx79_mmi3(CPUMIPSState *env, DisasContext *ctx)
     uint32_t opc = MASK_MMI3(ctx->opcode);
 
     switch (opc) {
-    case TX79_MMI3_PMADDUW:    /* TODO: TX79_MMI3_PMADDUW */
-    case TX79_MMI3_PSRAVW:     /* TODO: TX79_MMI3_PSRAVW */
-    case TX79_MMI3_PMTHI:      /* TODO: TX79_MMI3_PMTHI */
-    case TX79_MMI3_PMTLO:      /* TODO: TX79_MMI3_PMTLO */
-    case TX79_MMI3_PINTEH:     /* TODO: TX79_MMI3_PINTEH */
-    case TX79_MMI3_PMULTUW:    /* TODO: TX79_MMI3_PMULTUW */
-    case TX79_MMI3_PDIVUW:     /* TODO: TX79_MMI3_PDIVUW */
-    case TX79_MMI3_PCPYUD:     /* TODO: TX79_MMI3_PCPYUD */
-    case TX79_MMI3_POR:        /* TODO: TX79_MMI3_POR */
-    case TX79_MMI3_PNOR:       /* TODO: TX79_MMI3_PNOR */
-    case TX79_MMI3_PEXCH:      /* TODO: TX79_MMI3_PEXCH */
-    case TX79_MMI3_PCPYH:      /* TODO: TX79_MMI3_PCPYH */
-    case TX79_MMI3_PEXCW:      /* TODO: TX79_MMI3_PEXCW */
-        generate_exception_end(ctx, EXCP_RI); /* TODO: TX79_MMI_CLASS_MMI3 */
+    case MMI_OPC_3_PMADDUW:    /* TODO: MMI_OPC_3_PMADDUW */
+    case MMI_OPC_3_PSRAVW:     /* TODO: MMI_OPC_3_PSRAVW */
+    case MMI_OPC_3_PMTHI:      /* TODO: MMI_OPC_3_PMTHI */
+    case MMI_OPC_3_PMTLO:      /* TODO: MMI_OPC_3_PMTLO */
+    case MMI_OPC_3_PINTEH:     /* TODO: MMI_OPC_3_PINTEH */
+    case MMI_OPC_3_PMULTUW:    /* TODO: MMI_OPC_3_PMULTUW */
+    case MMI_OPC_3_PDIVUW:     /* TODO: MMI_OPC_3_PDIVUW */
+    case MMI_OPC_3_PCPYUD:     /* TODO: MMI_OPC_3_PCPYUD */
+    case MMI_OPC_3_POR:        /* TODO: MMI_OPC_3_POR */
+    case MMI_OPC_3_PNOR:       /* TODO: MMI_OPC_3_PNOR */
+    case MMI_OPC_3_PEXCH:      /* TODO: MMI_OPC_3_PEXCH */
+    case MMI_OPC_3_PCPYH:      /* TODO: MMI_OPC_3_PCPYH */
+    case MMI_OPC_3_PEXCW:      /* TODO: MMI_OPC_3_PEXCW */
+        generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI3 */
         break;
     default:
         MIPS_INVAL("TX79 MMI class MMI3");
@@ -24823,48 +24823,48 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     int rd = extract32(ctx->opcode, 11, 5);
 
     switch (opc) {
-    case TX79_MMI_CLASS_MMI0:
+    case MMI_OPC_CLASS_MMI0:
         decode_tx79_mmi0(env, ctx);
         break;
-    case TX79_MMI_CLASS_MMI1:
+    case MMI_OPC_CLASS_MMI1:
         decode_tx79_mmi1(env, ctx);
         break;
-    case TX79_MMI_CLASS_MMI2:
+    case MMI_OPC_CLASS_MMI2:
         decode_tx79_mmi2(env, ctx);
         break;
-    case TX79_MMI_CLASS_MMI3:
+    case MMI_OPC_CLASS_MMI3:
         decode_tx79_mmi3(env, ctx);
         break;
-    case TX79_MMI_MULT1:
-    case TX79_MMI_MULTU1:
+    case MMI_OPC_MULT1:
+    case MMI_OPC_MULTU1:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
-    case TX79_MMI_DIV1:
-    case TX79_MMI_DIVU1:
+    case MMI_OPC_DIV1:
+    case MMI_OPC_DIVU1:
         gen_muldiv(ctx, opc, 1, rs, rt);
         break;
-    case TX79_MMI_MTLO1:
-    case TX79_MMI_MTHI1:
+    case MMI_OPC_MTLO1:
+    case MMI_OPC_MTHI1:
         gen_HILO(ctx, opc, 1, rs);
         break;
-    case TX79_MMI_MFLO1:
-    case TX79_MMI_MFHI1:
+    case MMI_OPC_MFLO1:
+    case MMI_OPC_MFHI1:
         gen_HILO(ctx, opc, 1, rd);
         break;
-    case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
-    case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
-    case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
-    case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
-    case TX79_MMI_MADDU1:        /* TODO: TX79_MMI_MADDU1 */
-    case TX79_MMI_PMFHL:         /* TODO: TX79_MMI_PMFHL */
-    case TX79_MMI_PMTHL:         /* TODO: TX79_MMI_PMTHL */
-    case TX79_MMI_PSLLH:         /* TODO: TX79_MMI_PSLLH */
-    case TX79_MMI_PSRLH:         /* TODO: TX79_MMI_PSRLH */
-    case TX79_MMI_PSRAH:         /* TODO: TX79_MMI_PSRAH */
-    case TX79_MMI_PSLLW:         /* TODO: TX79_MMI_PSLLW */
-    case TX79_MMI_PSRLW:         /* TODO: TX79_MMI_PSRLW */
-    case TX79_MMI_PSRAW:         /* TODO: TX79_MMI_PSRAW */
-        generate_exception_end(ctx, EXCP_RI);    /* TODO: TX79_CLASS_MMI */
+    case MMI_OPC_MADD:          /* TODO: MMI_OPC_MADD */
+    case MMI_OPC_MADDU:         /* TODO: MMI_OPC_MADDU */
+    case MMI_OPC_PLZCW:         /* TODO: MMI_OPC_PLZCW */
+    case MMI_OPC_MADD1:         /* TODO: MMI_OPC_MADD1 */
+    case MMI_OPC_MADDU1:        /* TODO: MMI_OPC_MADDU1 */
+    case MMI_OPC_PMFHL:         /* TODO: MMI_OPC_PMFHL */
+    case MMI_OPC_PMTHL:         /* TODO: MMI_OPC_PMTHL */
+    case MMI_OPC_PSLLH:         /* TODO: MMI_OPC_PSLLH */
+    case MMI_OPC_PSRLH:         /* TODO: MMI_OPC_PSRLH */
+    case MMI_OPC_PSRAH:         /* TODO: MMI_OPC_PSRAH */
+    case MMI_OPC_PSLLW:         /* TODO: MMI_OPC_PSLLW */
+    case MMI_OPC_PSRLW:         /* TODO: MMI_OPC_PSRLW */
+    case MMI_OPC_PSRAW:         /* TODO: MMI_OPC_PSRAW */
+        generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_CLASS_MMI */
         break;
     default:
         MIPS_INVAL("TX79 MMI class");
@@ -24875,12 +24875,12 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
 
 static void decode_tx79_lq(CPUMIPSState *env, DisasContext *ctx)
 {
-    generate_exception_end(ctx, EXCP_RI);    /* TODO: TX79_LQ */
+    generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_LQ */
 }
 
 static void gen_tx79_sq(DisasContext *ctx, int base, int rt, int offset)
 {
-    generate_exception_end(ctx, EXCP_RI);    /* TODO: TX79_SQ */
+    generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_SQ */
 }
 
 /*
@@ -26238,7 +26238,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_SPECIAL3:
         if (ctx->insn_flags & INSN_R5900) {
-            decode_tx79_sq(env, ctx);    /* TX79_SQ */
+            decode_tx79_sq(env, ctx);    /* MMI_SQ */
         } else {
             decode_opc_special3(env, ctx);
         }
@@ -26902,7 +26902,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_MSA: /* OPC_MDMX */
         if (ctx->insn_flags & INSN_R5900) {
-            decode_tx79_lq(env, ctx);    /* TX79_LQ */
+            decode_tx79_lq(env, ctx);    /* MMI_LQ */
         } else {
             /* MDMX: Not implemented. */
             gen_msa(env, ctx);
-- 
2.7.4
