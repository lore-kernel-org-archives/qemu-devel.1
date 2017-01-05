Received: from eggs.gnu.org ([2001:4830:134:3::10]:41374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0QE-0000dJ-L6
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0QB-0002Vj-Hu
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:17:06 -0500
Received: from [114.242.206.163] (port=60310 helo=mail.loongson.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0QA-0002RX-NV
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:17:03 -0500
From: Jin Guojie <jinguojie@loongson.cn>
Date: Thu,  5 Jan 2017 12:57:51 +0800
Message-Id: <1483592275-4496-7-git-send-email-jinguojie@loongson.cn>
In-Reply-To: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
References: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
Subject: [Qemu-devel] [PATCH v6 RESEND 06/10] tcg-mips: Adjust load/store
 functions for mips64
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

tcg_out_ldst: using a generic ALIAS_PADD to avoid ifdefs
tcg_out_ld: generates LD or LW
tcg_out_st: generates SD or SW

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: James Hogan <james.hogan@imgtec.com>
Tested-by: YunQiang Su <wzssyqa@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
---
 tcg/mips/tcg-target.inc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 18368f0..5cc8df3 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -697,7 +697,7 @@ static void tcg_out_ldst(TCGContext *s, MIPSInsn opc, TCGReg data,
     if (ofs != lo) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, ofs - lo);
         if (addr != TCG_REG_ZERO) {
-            tcg_out_opc_reg(s, OPC_ADDU, TCG_TMP0, TCG_TMP0, addr);
+            tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP0, TCG_TMP0, addr);
         }
         addr = TCG_TMP0;
     }
@@ -707,13 +707,21 @@ static void tcg_out_ldst(TCGContext *s, MIPSInsn opc, TCGReg data,
 static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
                               TCGReg arg1, intptr_t arg2)
 {
-    tcg_out_ldst(s, OPC_LW, arg, arg1, arg2);
+    MIPSInsn opc = OPC_LD;
+    if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
+        opc = OPC_LW;
+    }
+    tcg_out_ldst(s, opc, arg, arg1, arg2);
 }
 
 static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
                               TCGReg arg1, intptr_t arg2)
 {
-    tcg_out_ldst(s, OPC_SW, arg, arg1, arg2);
+    MIPSInsn opc = OPC_SD;
+    if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
+        opc = OPC_SW;
+    }
+    tcg_out_ldst(s, opc, arg, arg1, arg2);
 }
 
 static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
-- 
2.1.0
