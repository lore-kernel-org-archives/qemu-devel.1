Received: from eggs.gnu.org ([2001:4830:134:3::10]:42819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cG4KF-0001gs-4K
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 08:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cG4KB-00010X-TE
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 08:37:59 -0500
Received: from [114.242.206.163] (port=49150 helo=loongson.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cG4KA-0000wE-VI
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 08:37:55 -0500
From: Jin Guojie <jinguojie@loongson.cn>
Date: Sun, 11 Dec 2016 21:36:19 +0800
Message-Id: <1481463385-15898-5-git-send-email-jinguojie@loongson.cn>
In-Reply-To: <1481463385-15898-1-git-send-email-jinguojie@loongson.cn>
References: <1481463385-15898-1-git-send-email-jinguojie@loongson.cn>
Subject: [Qemu-devel] [PATCH v6 04/10] tcg-mips: Add bswap32u and bswap64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, James Hogan <james.hogan@imgtec.com>, YunQiang Su <wzssyqa@gmail.com>, Richard Henderson <rth@twiddle.net>, Jin Guojie <jinguojie@loongson.cn>

Without the mips32r2 instructions to perform swapping, bswap is quite large,
dominating the size of each reverse-endian qemu_ld/qemu_st operation.

Create two subroutines in the prologue block.  The subroutines require extra
reserved registers (TCG_TMP[2, 3]).  Using these within qemu_ld means that
we need not place additional restrictions on the qemu_ld outputs.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: James Hogan <james.hogan@imgtec.com>
Tested-by: YunQiang Su <wzssyqa@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
---
 tcg/mips/tcg-target.inc.c | 102 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 3 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 2d91d0c..ec139cd 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -125,6 +125,8 @@ static const TCGReg tcg_target_call_oarg_regs[2] = {
 
 static tcg_insn_unit *tb_ret_addr;
 static tcg_insn_unit *bswap32_addr;
+static tcg_insn_unit *bswap32u_addr;
+static tcg_insn_unit *bswap64_addr;
 
 static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc, tcg_insn_unit *target)
 {
@@ -622,7 +624,10 @@ static void tcg_out_bswap32u(TCGContext *s, TCGReg ret, TCGReg arg)
         tcg_out_opc_reg(s, OPC_DSHD, ret, 0, ret);
         tcg_out_dsrl(s, ret, ret, 32);
     } else {
-        abort();
+        tcg_out_bswap_subr(s, bswap32u_addr);
+        /* delay slot -- never omit the insn, like tcg_out_mov might.  */
+        tcg_out_opc_reg(s, OPC_OR, TCG_TMP0, arg, TCG_REG_ZERO);
+        tcg_out_mov(s, TCG_TYPE_I32, ret, TCG_TMP3);
     }
 }
 
@@ -632,7 +637,10 @@ static void tcg_out_bswap64(TCGContext *s, TCGReg ret, TCGReg arg)
         tcg_out_opc_reg(s, OPC_DSBH, ret, 0, arg);
         tcg_out_opc_reg(s, OPC_DSHD, ret, 0, ret);
     } else {
-        abort();
+        tcg_out_bswap_subr(s, bswap64_addr);
+        /* delay slot -- never omit the insn, like tcg_out_mov might.  */
+        tcg_out_opc_reg(s, OPC_OR, TCG_TMP0, arg, TCG_REG_ZERO);
+        tcg_out_mov(s, TCG_TYPE_I32, ret, TCG_TMP3);
     }
 }
 
@@ -2279,7 +2287,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
         return;
     }
 
-    /* Bswap subroutine: Input in TCG_TMP0, output in TCG_TMP3;
+    /* Bswap subroutines: Input in TCG_TMP0, output in TCG_TMP3;
        clobbers TCG_TMP1, TCG_TMP2.  */
 
     /*
@@ -2305,6 +2313,94 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_opc_reg(s, OPC_JR, 0, TCG_REG_RA, 0);
     /* t3 = dcba -- delay slot */
     tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP1);
+
+    if (TCG_TARGET_REG_BITS == 32) {
+        return;
+    }
+
+    /*
+     * bswap32u -- unsigned 32-bit swap.  a0 = ....abcd.
+     */
+    bswap32u_addr = align_code_ptr(s);
+    /* t1 = (0000)000d */
+    tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP1, TCG_TMP0, 0xff);
+    /* t3 = 000a */
+    tcg_out_opc_sa(s, OPC_SRL, TCG_TMP3, TCG_TMP0, 24);
+    /* t1 = (0000)d000 */
+    tcg_out_dsll(s, TCG_TMP1, TCG_TMP1, 24);
+    /* t2 = 00c0 */
+    tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP2, TCG_TMP0, 0xff00);
+    /* t3 = d00a */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP1);
+    /* t1 = 0abc */
+    tcg_out_opc_sa(s, OPC_SRL, TCG_TMP1, TCG_TMP0, 8);
+    /* t2 = 0c00 */
+    tcg_out_opc_sa(s, OPC_SLL, TCG_TMP2, TCG_TMP2, 8);
+    /* t1 = 00b0 */
+    tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP1, TCG_TMP1, 0xff00);
+    /* t3 = dc0a */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP2);
+    tcg_out_opc_reg(s, OPC_JR, 0, TCG_REG_RA, 0);
+    /* t3 = dcba -- delay slot */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP1);
+
+    /*
+     * bswap64 -- 64-bit swap.  a0 = abcdefgh
+     */
+    bswap64_addr = align_code_ptr(s);
+    /* t3 = h0000000 */
+    tcg_out_dsll(s, TCG_TMP3, TCG_TMP0, 56);
+    /* t1 = 0000000a */
+    tcg_out_dsrl(s, TCG_TMP1, TCG_TMP0, 56);
+
+    /* t2 = 000000g0 */
+    tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP2, TCG_TMP0, 0xff00);
+    /* t3 = h000000a */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP1);
+    /* t1 = 00000abc */
+    tcg_out_dsrl(s, TCG_TMP1, TCG_TMP0, 40);
+    /* t2 = 0g000000 */
+    tcg_out_dsll(s, TCG_TMP2, TCG_TMP2, 40);
+    /* t1 = 000000b0 */
+    tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP1, TCG_TMP1, 0xff00);
+
+    /* t3 = hg00000a */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP2);
+    /* t2 = 0000abcd */
+    tcg_out_dsrl(s, TCG_TMP2, TCG_TMP0, 32);
+    /* t3 = hg0000ba */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP1);
+
+    /* t1 = 000000c0 */
+    tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP1, TCG_TMP2, 0xff00);
+    /* t2 = 0000000d */
+    tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP2, TCG_TMP2, 0x00ff);
+    /* t1 = 00000c00 */
+    tcg_out_dsll(s, TCG_TMP1, TCG_TMP1, 8);
+    /* t2 = 0000d000 */
+    tcg_out_dsll(s, TCG_TMP2, TCG_TMP2, 24);
+
+    /* t3 = hg000cba */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP1);
+    /* t1 = 00abcdef */
+    tcg_out_dsrl(s, TCG_TMP1, TCG_TMP0, 16);
+    /* t3 = hg00dcba */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP2);
+
+    /* t2 = 0000000f */
+    tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP2, TCG_TMP1, 0x00ff);
+    /* t1 = 000000e0 */
+    tcg_out_opc_imm(s, OPC_ANDI, TCG_TMP1, TCG_TMP1, 0xff00);
+    /* t2 = 00f00000 */
+    tcg_out_dsll(s, TCG_TMP2, TCG_TMP2, 40);
+    /* t1 = 000e0000 */
+    tcg_out_dsll(s, TCG_TMP1, TCG_TMP1, 24);
+
+    /* t3 = hgf0dcba */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP2);
+    tcg_out_opc_reg(s, OPC_JR, 0, TCG_REG_RA, 0);
+    /* t3 = hgfedcba -- delay slot */
+    tcg_out_opc_reg(s, OPC_OR, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 }
 
 static void tcg_target_init(TCGContext *s)
-- 
2.1.0
