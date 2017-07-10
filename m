Received: from eggs.gnu.org ([2001:4830:134:3::10]:60431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dUUhb-00005m-0W
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dUUhX-0002eX-1X
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:09:58 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:57286)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dUUhW-0002cD-F3
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:09:54 -0400
From: Jiang Biao <jiang.biao2@zte.com.cn>
Date: Mon, 10 Jul 2017 17:12:14 +0800
Message-Id: <1499677934-2249-1-git-send-email-jiang.biao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] tcg/mips: reserve a register for the
 guest_base.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jinguojie@loongson.cn, rth@twiddle.net, james.hogan@imgtec.com, jiang.yong5@zte.com.cn, wang.liang82@zte.com.cn, shi.zhongbing@zte.com.cn, zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn

Reserve a register for the guest_base using ppc code for reference.
By doing so, we do not have to recompute it for every memory load.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/mips/tcg-target.inc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 85756b8..1a8169f 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -85,6 +85,10 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #define TCG_TMP2  TCG_REG_T8
 #define TCG_TMP3  TCG_REG_T7
 
+#ifndef CONFIG_SOFTMMU
+#define TCG_GUEST_BASE_REG TCG_REG_S1
+#endif
+
 /* check if we really need so many registers :P */
 static const int tcg_target_reg_alloc_order[] = {
     /* Call saved registers.  */
@@ -1547,8 +1551,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
     } else if (guest_base == (int16_t)guest_base) {
         tcg_out_opc_imm(s, ALIAS_PADDI, base, addr_regl, guest_base);
     } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, guest_base);
-        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP0, addr_regl);
+        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_GUEST_BASE_REG, addr_regl);
     }
     tcg_out_qemu_ld_direct(s, data_regl, data_regh, base, opc, is_64);
 #endif
@@ -1652,8 +1655,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
     } else if (guest_base == (int16_t)guest_base) {
         tcg_out_opc_imm(s, ALIAS_PADDI, base, addr_regl, guest_base);
     } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, guest_base);
-        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP0, addr_regl);
+        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_GUEST_BASE_REG, addr_regl);
     }
     tcg_out_qemu_st_direct(s, data_regl, data_regh, base, opc);
 #endif
@@ -2452,6 +2454,13 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
     }
 
+#ifndef CONFIG_SOFTMMU
+    if (guest_base) {
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
+        tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
+    }
+#endif
+
     /* Call generated code */
     tcg_out_opc_reg(s, OPC_JR, 0, tcg_target_call_iarg_regs[1], 0);
     /* delay slot */
-- 
2.7.4
