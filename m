Received: from eggs.gnu.org ([2001:4830:134:3::10]:44959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0m1-0001nO-VP
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0m1-0007Kn-1S
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:22 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dL0m0-0007Kc-Tb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:20 -0400
Received: by mail-qt0-x242.google.com with SMTP id o21so39043165qtb.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 22:23:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 13 Jun 2017 22:23:04 -0700
Message-Id: <20170614052311.13785-4-rth@twiddle.net>
In-Reply-To: <20170614052311.13785-1-rth@twiddle.net>
References: <20170614052311.13785-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 03/10] translate-all: consolidate tb init in
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

We are partially initializing tb in tb_alloc. Instead, fully
initialize it in tb_gen_code, which is tb_alloc's only caller.

This saves an unnecessary write to tb->cflags.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1497038122-26364-1-git-send-email-cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 translate-all.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/translate-all.c b/translate-all.c
index bb094ad..46c5592 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -843,9 +843,6 @@ static TranslationBlock *tb_alloc(target_ulong pc)
         ctx->tbs = g_renew(TranslationBlock *, ctx->tbs, ctx->tbs_size);
     }
     ctx->tbs[ctx->nb_tbs++] = tb;
-    tb->pc = pc;
-    tb->cflags = 0;
-    tb->invalid = false;
     return tb;
 }
 
@@ -1289,9 +1286,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
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
2.9.4
