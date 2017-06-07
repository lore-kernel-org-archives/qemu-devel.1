Received: from eggs.gnu.org ([2001:4830:134:3::10]:46625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dIiOJ-0007eh-R8
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dIiOI-0006Br-Uu
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:21:23 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dIiOI-00068D-PF
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:21:22 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed,  7 Jun 2017 23:20:58 +0200
Message-Id: <20170607212058.6124-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH] target/sh4: optimize cross-page and indirect
 jumps
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

Instead of unconditionally exiting to the exec loop for indirect jumps
or cross-page direct jumps, use the lookup_and_goto_ptr helper to jump
to the target if it is valid.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8bc132b27b..4f20537ef8 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -249,7 +249,7 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
         tcg_gen_movi_i32(cpu_pc, dest);
         if (ctx->singlestep_enabled)
             gen_helper_debug(cpu_env);
-        tcg_gen_exit_tb(0);
+        tcg_gen_lookup_and_goto_ptr(cpu_pc);
     }
 }
 
@@ -262,7 +262,7 @@ static void gen_jump(DisasContext * ctx)
         tcg_gen_discard_i32(cpu_delayed_pc);
 	if (ctx->singlestep_enabled)
             gen_helper_debug(cpu_env);
-	tcg_gen_exit_tb(0);
+        tcg_gen_lookup_and_goto_ptr(cpu_pc);
     } else {
 	gen_goto_tb(ctx, 0, ctx->delayed_pc);
     }
-- 
2.11.0
