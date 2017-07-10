Received: from eggs.gnu.org ([2001:4830:134:3::10]:54490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dUSXV-0006h2-RJ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dUSXS-00078b-PP
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:51:25 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:46721)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dUSXQ-00076A-H9
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:51:22 -0400
From: Jiang Biao <jiang.biao2@zte.com.cn>
Date: Mon, 10 Jul 2017 14:59:39 +0800
Message-Id: <1499669979-25904-1-git-send-email-jiang.biao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH v3] tcg/mips: Bugfix for crash when running
 program with qemu-i386.
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

When running a helloworld program with qemu-i386 in linux-user
mode on Loongson 3A3000, it will crash. This patch fix the bug.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/mips/tcg-target.inc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 8cff9a6..85756b8 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1547,8 +1547,8 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
     } else if (guest_base == (int16_t)guest_base) {
         tcg_out_opc_imm(s, ALIAS_PADDI, base, addr_regl, guest_base);
     } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, base, guest_base);
-        tcg_out_opc_reg(s, ALIAS_PADD, base, base, addr_regl);
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, guest_base);
+        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP0, addr_regl);
     }
     tcg_out_qemu_ld_direct(s, data_regl, data_regh, base, opc, is_64);
 #endif
@@ -1652,8 +1652,8 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
     } else if (guest_base == (int16_t)guest_base) {
         tcg_out_opc_imm(s, ALIAS_PADDI, base, addr_regl, guest_base);
     } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, base, guest_base);
-        tcg_out_opc_reg(s, ALIAS_PADD, base, base, addr_regl);
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, guest_base);
+        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP0, addr_regl);
     }
     tcg_out_qemu_st_direct(s, data_regl, data_regh, base, opc);
 #endif
-- 
2.7.4
