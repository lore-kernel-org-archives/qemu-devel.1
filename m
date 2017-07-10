Received: from eggs.gnu.org ([2001:4830:134:3::10]:37706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUTFV-0007y5-Ja
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUTFS-0007g6-JC
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:36:53 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUTFS-0007fu-D3
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:36:50 -0400
Received: by mail-pf0-x241.google.com with SMTP id z6so13400774pfk.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 00:36:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  9 Jul 2017 21:35:01 -1000
Message-Id: <20170710073501.5207-6-rth@twiddle.net>
In-Reply-To: <20170710073501.5207-1-rth@twiddle.net>
References: <20170710073501.5207-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 5/5] tcg/mips: Bugfix for crash when running
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
Cc: peter.maydell@linaro.org, Jiang Biao <jiang.biao2@zte.com.cn>

From: Jiang Biao <jiang.biao2@zte.com.cn>

When running a helloworld program with qemu-i386 in linux-user
mode on Loongson 3A3000, it will crash. This patch fix the bug.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Message-Id: <1499669979-25904-1-git-send-email-jiang.biao2@zte.com.cn>
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
2.9.4
