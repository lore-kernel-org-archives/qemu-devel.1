Received: from eggs.gnu.org ([2001:4830:134:3::10]:37171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQD-0005B6-A6
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQA-0001MH-SH
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:09 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d9TQA-0001HB-Hl
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat, 13 May 2017 11:32:38 +0200
Message-Id: <20170513093248.18230-6-aurelien@aurel32.net>
In-Reply-To: <20170513093248.18230-1-aurelien@aurel32.net>
References: <20170513093248.18230-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/15] target/sh4: fix BS_STOP exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

When stopping the translation because the state has changed, goto_tb
should not be used as it might link TB with different flags.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
