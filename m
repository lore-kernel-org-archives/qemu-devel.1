Received: from eggs.gnu.org ([2001:4830:134:3::10]:35075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8WJy-0003Eo-Sg
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8WJx-0000GX-LS
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:46 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d8WJx-0000Fk-Fn
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:45 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 10 May 2017 20:26:26 +0200
Message-Id: <20170510182636.17791-6-aurelien@aurel32.net>
In-Reply-To: <20170510182636.17791-1-aurelien@aurel32.net>
References: <20170510182636.17791-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v3 05/15] target/sh4: fix BS_STOP exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

When stopping the translation because the state has changed, goto_tb
should not be used as it might link TB with different flags.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 2e29936ad8..04bc18bf7c 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1901,8 +1901,9 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     } else {
 	switch (ctx.bstate) {
         case BS_STOP:
-            /* gen_op_interrupt_restart(); */
-            /* fall through */
+            tcg_gen_movi_i32(cpu_pc, ctx.pc);
+            tcg_gen_exit_tb(0);
+            break;
         case BS_NONE:
             if (ctx.envflags) {
                 gen_store_flags(ctx.envflags);
-- 
2.11.0
