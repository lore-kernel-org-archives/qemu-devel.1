Received: from eggs.gnu.org ([2001:4830:134:3::10]:60729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJQ0G-0002JQ-BA
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJQ0D-0007Pe-AM
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:55:28 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dJQ0D-0007PQ-5s
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:55:25 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri,  9 Jun 2017 15:55:22 -0400
Message-Id: <1497038122-26364-1-git-send-email-cota@braap.org>
In-Reply-To: <20170609195234.GA14509@flamenco>
References: <20170609195234.GA14509@flamenco>
Subject: [Qemu-devel] [PATCH] translate-all: consolidate tb init in
 tb_gen_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

We are partially initializing tb in tb_alloc. Instead, fully
initialize it in tb_gen_code, which is tb_alloc's only caller.

This saves an unnecessary write to tb->cflags.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 translate-all.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/translate-all.c b/translate-all.c
index 966747a..d4f364d 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -841,9 +841,6 @@ static TranslationBlock *tb_alloc(target_ulong pc)
         ctx->tbs = g_renew(TranslationBlock *, ctx->tbs, ctx->tbs_size);
     }
     ctx->tbs[ctx->nb_tbs++] = tb;
-    tb->pc = pc;
-    tb->cflags = 0;
-    tb->invalid = false;
     return tb;
 }
 
@@ -1287,9 +1284,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
     gen_code_buf = tcg_ctx.code_gen_ptr;
     tb->tc_ptr = gen_code_buf;
+    tb->pc = pc;
     tb->cs_base = cs_base;
     tb->flags = flags;
     tb->cflags = cflags;
+    tb->invalid = false;
 
 #ifdef CONFIG_PROFILER
     tcg_ctx.tb_count1++; /* includes aborted translations because of
-- 
2.7.4
