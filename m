Received: from eggs.gnu.org ([2001:4830:134:3::10]:33299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GB-0008LA-FD
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GA-0002CM-LP
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:47 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN1GA-0002C1-FE
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:46 -0400
Received: by mail-pg0-x244.google.com with SMTP id f127so17441063pgc.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:18:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 11:18:30 -0700
Message-Id: <20170619181839.25249-4-rth@twiddle.net>
In-Reply-To: <20170619181839.25249-1-rth@twiddle.net>
References: <20170619181839.25249-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 03/12] translate-all: consolidate tb init in
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
