Received: from eggs.gnu.org ([2001:4830:134:3::10]:36656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dLF4P-0006z4-L7
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dLF4M-0008Ht-Gr
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:39:17 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dLF4M-0008H3-6c
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:39:14 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 14 Jun 2017 22:39:05 +0200
Message-Id: <20170614203905.19657-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] target/m68k: fix V flag for CC_OP_SUBx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

V flag for subtraction is:

   v = (res ^ src1) & (src1 ^ src2)

(see COMPUTE_CCR() in target/m68k/helper.c)

But gen_flush_flags() uses:

   v = (res ^ src2) & (src1 ^ src2)

The problem has been found with the following program:

        .global _start
_start:
        move.l  #-2147483648,%d0
        subq.l  #1,%d0
        jvc     1f
        move.l #1,%d1
        move.l #1,%d0
        trap #0
1:
        move.l #0,%d1
        move.l #1,%d0
        trap #0

It works fine (exit(1)) on real hardware, and with "-singlestep".

"-singlestep" uses gen_helper_flush_flags(), whereas
without "-singlestep", V flag is computed directly in
gen_flush_flags().

This patch updates gen_flush_flags() to have the same result
as with gen_helper_flush_flags().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ad4d4ef..52653f6 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -565,7 +565,7 @@ static void gen_flush_flags(DisasContext *s)
         t1 = tcg_temp_new();
         tcg_gen_add_i32(t0, QREG_CC_N, QREG_CC_V);
         gen_ext(t0, t0, s->cc_op - CC_OP_SUBB, 1);
-        tcg_gen_xor_i32(t1, QREG_CC_N, QREG_CC_V);
+        tcg_gen_xor_i32(t1, QREG_CC_N, t0);
         tcg_gen_xor_i32(QREG_CC_V, QREG_CC_V, t0);
         tcg_temp_free(t0);
         tcg_gen_and_i32(QREG_CC_V, QREG_CC_V, t1);
-- 
2.9.4
