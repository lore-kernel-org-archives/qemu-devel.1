Received: from eggs.gnu.org ([2001:4830:134:3::10]:52066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frqlm-0003Hv-5A
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frqlb-0003r6-Jf
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:27:18 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1frqlU-0003Pt-AA
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:27:07 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 20 Aug 2018 22:26:00 +0200
Message-Id: <20180820202604.14218-4-laurent@vivier.eu>
In-Reply-To: <20180820202604.14218-1-laurent@vivier.eu>
References: <20180820202604.14218-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 3/7] sh4: fix use_icount with linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

This fixes java in a linux-user chroot:
  $ java --version
  qemu-sh4: .../accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Assertion `use_icount' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted (core dumped)

In gen_conditional_jump() in the GUSA_EXCLUSIVE part, we must reset
base.is_jmp to DISAS_NEXT after the gen_goto_tb() as it is done in
gen_delayed_conditional_jump() after the gen_jump().

Bug: https://bugs.launchpad.net/qemu/+bug/1768246
Fixes: 4834871bc95b67343248100e2a75ae0d287bc08b
       ("target/sh4: Convert to DisasJumpType")
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20180811082328.11268-1-laurent@vivier.eu>
---
 target/sh4/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 1b9a201d6d..ab254b0e8d 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -293,6 +293,7 @@ static void gen_conditional_jump(DisasContext *ctx, target_ulong dest,
            disallow it in use_goto_tb, but it handles exit + singlestep.  */
         gen_goto_tb(ctx, 0, dest);
         gen_set_label(l1);
+        ctx->base.is_jmp = DISAS_NEXT;
         return;
     }
 
-- 
2.17.1
