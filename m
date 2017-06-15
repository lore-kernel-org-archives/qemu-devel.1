Received: from eggs.gnu.org ([2001:4830:134:3::10]:34644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dLPxw-0007uJ-60
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dLPxs-0001uV-4v
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:17:20 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:64416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dLPxr-0001tz-Oc
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:17:16 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 15 Jun 2017 10:17:08 +0200
Message-Id: <20170615081711.25347-2-laurent@vivier.eu>
In-Reply-To: <20170615081711.25347-1-laurent@vivier.eu>
References: <20170615081711.25347-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/4] target/m68k: fix V flag for CC_OP_SUBx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

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
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170614203905.19657-1-laurent@vivier.eu>
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
