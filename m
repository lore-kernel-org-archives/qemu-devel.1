Received: from eggs.gnu.org ([2001:4830:134:3::10]:38351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cQHhi-00032i-Nx
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cQHhh-0003s9-36
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:26 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cQHhg-0003ru-Rj
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:25 -0500
Received: by mail-pf0-x241.google.com with SMTP id b22so6624551pfd.3
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 09:56:24 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  8 Jan 2017 09:56:11 -0800
Message-Id: <20170108175620.6605-3-rth@twiddle.net>
In-Reply-To: <20170108175620.6605-1-rth@twiddle.net>
References: <20170108175620.6605-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 02/11] tcg-mips: Add mips64 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jin Guojie <jinguojie@loongson.cn>

From: Jin Guojie <jinguojie@loongson.cn>

Since the mips manual tables are in octal, reorg all of the opcodes
into that format for clarity.  Note that the 64-bit opcodes are as
yet unused.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: James Hogan <james.hogan@imgtec.com>
Tested-by: YunQiang Su <wzssyqa@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
Message-Id: <1483592275-4496-3-git-send-email-jinguojie@loongson.cn>
---
 tcg/mips/tcg-target.inc.c | 193 ++++++++++++++++++++++++++++------------------
 1 file changed, 118 insertions(+), 75 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 2b116ea..fb84ea5 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -254,81 +254,118 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 
 /* instruction opcodes */
 typedef enum {
-    OPC_J        = 0x02 << 26,
-    OPC_JAL      = 0x03 << 26,
-    OPC_BEQ      = 0x04 << 26,
-    OPC_BNE      = 0x05 << 26,
-    OPC_BLEZ     = 0x06 << 26,
-    OPC_BGTZ     = 0x07 << 26,
-    OPC_ADDIU    = 0x09 << 26,
-    OPC_SLTI     = 0x0A << 26,
-    OPC_SLTIU    = 0x0B << 26,
-    OPC_ANDI     = 0x0C << 26,
-    OPC_ORI      = 0x0D << 26,
-    OPC_XORI     = 0x0E << 26,
-    OPC_LUI      = 0x0F << 26,
-    OPC_LB       = 0x20 << 26,
-    OPC_LH       = 0x21 << 26,
-    OPC_LW       = 0x23 << 26,
-    OPC_LBU      = 0x24 << 26,
-    OPC_LHU      = 0x25 << 26,
-    OPC_LWU      = 0x27 << 26,
-    OPC_SB       = 0x28 << 26,
-    OPC_SH       = 0x29 << 26,
-    OPC_SW       = 0x2B << 26,
-
-    OPC_SPECIAL  = 0x00 << 26,
-    OPC_SLL      = OPC_SPECIAL | 0x00,
-    OPC_SRL      = OPC_SPECIAL | 0x02,
-    OPC_ROTR     = OPC_SPECIAL | (0x01 << 21) | 0x02,
-    OPC_SRA      = OPC_SPECIAL | 0x03,
-    OPC_SLLV     = OPC_SPECIAL | 0x04,
-    OPC_SRLV     = OPC_SPECIAL | 0x06,
-    OPC_ROTRV    = OPC_SPECIAL | (0x01 <<  6) | 0x06,
-    OPC_SRAV     = OPC_SPECIAL | 0x07,
-    OPC_JR_R5    = OPC_SPECIAL | 0x08,
-    OPC_JALR     = OPC_SPECIAL | 0x09,
-    OPC_MOVZ     = OPC_SPECIAL | 0x0A,
-    OPC_MOVN     = OPC_SPECIAL | 0x0B,
-    OPC_SYNC     = OPC_SPECIAL | 0x0F,
-    OPC_MFHI     = OPC_SPECIAL | 0x10,
-    OPC_MFLO     = OPC_SPECIAL | 0x12,
-    OPC_MULT     = OPC_SPECIAL | 0x18,
-    OPC_MUL_R6   = OPC_SPECIAL | (0x02 <<  6) | 0x18,
-    OPC_MUH      = OPC_SPECIAL | (0x03 <<  6) | 0x18,
-    OPC_MULTU    = OPC_SPECIAL | 0x19,
-    OPC_MULU     = OPC_SPECIAL | (0x02 <<  6) | 0x19,
-    OPC_MUHU     = OPC_SPECIAL | (0x03 <<  6) | 0x19,
-    OPC_DIV      = OPC_SPECIAL | 0x1A,
-    OPC_DIV_R6   = OPC_SPECIAL | (0x02 <<  6) | 0x1A,
-    OPC_MOD      = OPC_SPECIAL | (0x03 <<  6) | 0x1A,
-    OPC_DIVU     = OPC_SPECIAL | 0x1B,
-    OPC_DIVU_R6  = OPC_SPECIAL | (0x02 <<  6) | 0x1B,
-    OPC_MODU     = OPC_SPECIAL | (0x03 <<  6) | 0x1B,
-    OPC_ADDU     = OPC_SPECIAL | 0x21,
-    OPC_SUBU     = OPC_SPECIAL | 0x23,
-    OPC_AND      = OPC_SPECIAL | 0x24,
-    OPC_OR       = OPC_SPECIAL | 0x25,
-    OPC_XOR      = OPC_SPECIAL | 0x26,
-    OPC_NOR      = OPC_SPECIAL | 0x27,
-    OPC_SLT      = OPC_SPECIAL | 0x2A,
-    OPC_SLTU     = OPC_SPECIAL | 0x2B,
-    OPC_SELEQZ   = OPC_SPECIAL | 0x35,
-    OPC_SELNEZ   = OPC_SPECIAL | 0x37,
-
-    OPC_REGIMM   = 0x01 << 26,
-    OPC_BLTZ     = OPC_REGIMM | (0x00 << 16),
-    OPC_BGEZ     = OPC_REGIMM | (0x01 << 16),
-
-    OPC_SPECIAL2 = 0x1c << 26,
-    OPC_MUL_R5   = OPC_SPECIAL2 | 0x002,
-
-    OPC_SPECIAL3 = 0x1f << 26,
-    OPC_EXT      = OPC_SPECIAL3 | 0x000,
-    OPC_INS      = OPC_SPECIAL3 | 0x004,
-    OPC_WSBH     = OPC_SPECIAL3 | 0x0a0,
-    OPC_SEB      = OPC_SPECIAL3 | 0x420,
-    OPC_SEH      = OPC_SPECIAL3 | 0x620,
+    OPC_J        = 002 << 26,
+    OPC_JAL      = 003 << 26,
+    OPC_BEQ      = 004 << 26,
+    OPC_BNE      = 005 << 26,
+    OPC_BLEZ     = 006 << 26,
+    OPC_BGTZ     = 007 << 26,
+    OPC_ADDIU    = 011 << 26,
+    OPC_SLTI     = 012 << 26,
+    OPC_SLTIU    = 013 << 26,
+    OPC_ANDI     = 014 << 26,
+    OPC_ORI      = 015 << 26,
+    OPC_XORI     = 016 << 26,
+    OPC_LUI      = 017 << 26,
+    OPC_DADDIU   = 031 << 26,
+    OPC_LB       = 040 << 26,
+    OPC_LH       = 041 << 26,
+    OPC_LW       = 043 << 26,
+    OPC_LBU      = 044 << 26,
+    OPC_LHU      = 045 << 26,
+    OPC_LWU      = 047 << 26,
+    OPC_SB       = 050 << 26,
+    OPC_SH       = 051 << 26,
+    OPC_SW       = 053 << 26,
+    OPC_LD       = 067 << 26,
+    OPC_SD       = 077 << 26,
+
+    OPC_SPECIAL  = 000 << 26,
+    OPC_SLL      = OPC_SPECIAL | 000,
+    OPC_SRL      = OPC_SPECIAL | 002,
+    OPC_ROTR     = OPC_SPECIAL | 002 | (1 << 21),
+    OPC_SRA      = OPC_SPECIAL | 003,
+    OPC_SLLV     = OPC_SPECIAL | 004,
+    OPC_SRLV     = OPC_SPECIAL | 006,
+    OPC_ROTRV    = OPC_SPECIAL | 006 | 0100,
+    OPC_SRAV     = OPC_SPECIAL | 007,
+    OPC_JR_R5    = OPC_SPECIAL | 010,
+    OPC_JALR     = OPC_SPECIAL | 011,
+    OPC_MOVZ     = OPC_SPECIAL | 012,
+    OPC_MOVN     = OPC_SPECIAL | 013,
+    OPC_SYNC     = OPC_SPECIAL | 017,
+    OPC_MFHI     = OPC_SPECIAL | 020,
+    OPC_MFLO     = OPC_SPECIAL | 022,
+    OPC_DSLLV    = OPC_SPECIAL | 024,
+    OPC_DSRLV    = OPC_SPECIAL | 026,
+    OPC_DROTRV   = OPC_SPECIAL | 026 | 0100,
+    OPC_DSRAV    = OPC_SPECIAL | 027,
+    OPC_MULT     = OPC_SPECIAL | 030,
+    OPC_MUL_R6   = OPC_SPECIAL | 030 | 0200,
+    OPC_MUH      = OPC_SPECIAL | 030 | 0300,
+    OPC_MULTU    = OPC_SPECIAL | 031,
+    OPC_MULU     = OPC_SPECIAL | 031 | 0200,
+    OPC_MUHU     = OPC_SPECIAL | 031 | 0300,
+    OPC_DIV      = OPC_SPECIAL | 032,
+    OPC_DIV_R6   = OPC_SPECIAL | 032 | 0200,
+    OPC_MOD      = OPC_SPECIAL | 032 | 0300,
+    OPC_DIVU     = OPC_SPECIAL | 033,
+    OPC_DIVU_R6  = OPC_SPECIAL | 033 | 0200,
+    OPC_MODU     = OPC_SPECIAL | 033 | 0300,
+    OPC_DMULT    = OPC_SPECIAL | 034,
+    OPC_DMUL     = OPC_SPECIAL | 034 | 0200,
+    OPC_DMUH     = OPC_SPECIAL | 034 | 0300,
+    OPC_DMULTU   = OPC_SPECIAL | 035,
+    OPC_DMULU    = OPC_SPECIAL | 035 | 0200,
+    OPC_DMUHU    = OPC_SPECIAL | 035 | 0300,
+    OPC_DDIV     = OPC_SPECIAL | 036,
+    OPC_DDIV_R6  = OPC_SPECIAL | 036 | 0200,
+    OPC_DMOD     = OPC_SPECIAL | 036 | 0300,
+    OPC_DDIVU    = OPC_SPECIAL | 037,
+    OPC_DDIVU_R6 = OPC_SPECIAL | 037 | 0200,
+    OPC_DMODU    = OPC_SPECIAL | 037 | 0300,
+    OPC_ADDU     = OPC_SPECIAL | 041,
+    OPC_SUBU     = OPC_SPECIAL | 043,
+    OPC_AND      = OPC_SPECIAL | 044,
+    OPC_OR       = OPC_SPECIAL | 045,
+    OPC_XOR      = OPC_SPECIAL | 046,
+    OPC_NOR      = OPC_SPECIAL | 047,
+    OPC_SLT      = OPC_SPECIAL | 052,
+    OPC_SLTU     = OPC_SPECIAL | 053,
+    OPC_DADDU    = OPC_SPECIAL | 055,
+    OPC_DSUBU    = OPC_SPECIAL | 057,
+    OPC_SELEQZ   = OPC_SPECIAL | 065,
+    OPC_SELNEZ   = OPC_SPECIAL | 067,
+    OPC_DSLL     = OPC_SPECIAL | 070,
+    OPC_DSRL     = OPC_SPECIAL | 072,
+    OPC_DROTR    = OPC_SPECIAL | 072 | (1 << 21),
+    OPC_DSRA     = OPC_SPECIAL | 073,
+    OPC_DSLL32   = OPC_SPECIAL | 074,
+    OPC_DSRL32   = OPC_SPECIAL | 076,
+    OPC_DROTR32  = OPC_SPECIAL | 076 | (1 << 21),
+    OPC_DSRA32   = OPC_SPECIAL | 077,
+
+    OPC_REGIMM   = 001 << 26,
+    OPC_BLTZ     = OPC_REGIMM | (000 << 16),
+    OPC_BGEZ     = OPC_REGIMM | (001 << 16),
+
+    OPC_SPECIAL2 = 034 << 26,
+    OPC_MUL_R5   = OPC_SPECIAL2 | 002,
+
+    OPC_SPECIAL3 = 037 << 26,
+    OPC_EXT      = OPC_SPECIAL3 | 000,
+    OPC_DEXTM    = OPC_SPECIAL3 | 001,
+    OPC_DEXTU    = OPC_SPECIAL3 | 002,
+    OPC_DEXT     = OPC_SPECIAL3 | 003,
+    OPC_INS      = OPC_SPECIAL3 | 004,
+    OPC_DINSM    = OPC_SPECIAL3 | 005,
+    OPC_DINSU    = OPC_SPECIAL3 | 006,
+    OPC_DINS     = OPC_SPECIAL3 | 007,
+    OPC_WSBH     = OPC_SPECIAL3 | 00240,
+    OPC_DSBH     = OPC_SPECIAL3 | 00244,
+    OPC_DSHD     = OPC_SPECIAL3 | 00544,
+    OPC_SEB      = OPC_SPECIAL3 | 02040,
+    OPC_SEH      = OPC_SPECIAL3 | 03040,
 
     /* MIPS r6 doesn't have JR, JALR should be used instead */
     OPC_JR       = use_mips32r6_instructions ? OPC_JALR : OPC_JR_R5,
@@ -346,6 +383,12 @@ typedef enum {
     OPC_SYNC_ACQUIRE = OPC_SYNC | 0x11 << 5,
     OPC_SYNC_RELEASE = OPC_SYNC | 0x12 << 5,
     OPC_SYNC_RMB     = OPC_SYNC | 0x13 << 5,
+
+    /* Aliases for convenience.  */
+    ALIAS_PADD     = sizeof(void *) == 4 ? OPC_ADDU : OPC_DADDU,
+    ALIAS_PADDI    = sizeof(void *) == 4 ? OPC_ADDIU : OPC_DADDIU,
+    ALIAS_TSRL     = TARGET_LONG_BITS == 32 || TCG_TARGET_REG_BITS == 32
+                     ? OPC_SRL : OPC_DSRL,
 } MIPSInsn;
 
 /*
-- 
2.9.3
