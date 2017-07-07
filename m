Received: from eggs.gnu.org ([2001:4830:134:3::10]:56224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dTJd4-0005mZ-71
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 23:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dTJd1-0007EW-1x
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 23:08:26 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:46922)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dTJd0-0007Cw-NE
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 23:08:22 -0400
From: Jiang Biao <jiang.biao2@zte.com.cn>
Date: Fri, 7 Jul 2017 11:15:07 +0800
Message-Id: <1499397307-13605-1-git-send-email-jiang.biao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] tcg/mips: Bugfix for crash when running
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
---
 tcg/mips/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 8cff9a6..e6fedc9 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1540,7 +1540,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
 #else
     if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
         tcg_out_ext32u(s, base, addr_regl);
-        addr_regl = base;
+        tcg_out_mov(s, TCG_TYPE_PTR, addr_regl, base);
     }
     if (guest_base == 0 && data_regl != addr_regl) {
         base = addr_regl;
-- 
2.7.4
