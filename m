Received: from eggs.gnu.org ([2001:4830:134:3::10]:60515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9bBr-0005d0-W9
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9bBp-0001zq-B1
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:55:23 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f9bBo-0001ye-J3
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:55:20 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 20 Apr 2018 14:55:05 -0400
Message-Id: <1524250517-28032-7-git-send-email-cota@braap.org>
In-Reply-To: <1524250517-28032-1-git-send-email-cota@braap.org>
References: <1524250517-28032-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 06/18] target/mips: use lookup_and_goto_ptr on
 BS_STOP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

The TB after BS_STOP is not fixed (e.g. helper_mtc0_hwrena
changes hflags, which ends up changing the TB flags via
cpu_get_tb_cpu_state). This requires a full lookup (i.e.
with flags) via lookup_and_goto_ptr instead of gen_goto_tb,
since the latter only looks at the PC for in-page goto's. Fix it.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/mips/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d8e717d..69137d0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20343,7 +20343,8 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     } else {
         switch (ctx.bstate) {
         case BS_STOP:
-            gen_goto_tb(&ctx, 0, ctx.pc);
+            gen_save_pc(ctx.pc);
+            tcg_gen_lookup_and_goto_ptr();
             break;
         case BS_NONE:
             save_cpu_state(&ctx, 0);
-- 
2.7.4
