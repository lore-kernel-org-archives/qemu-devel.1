Received: from eggs.gnu.org ([209.51.188.92]:35118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGJVX-0002sd-UY
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGJVW-0006Oi-Lw
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:31:59 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGJVW-0006Mj-Aw
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:31:58 -0400
Received: by mail-pl1-x642.google.com with SMTP id y6so9945366pll.13
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 01:31:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 15 Apr 2019 22:31:50 -1000
Message-Id: <20190416083150.19649-3-richard.henderson@linaro.org>
In-Reply-To: <20190416083150.19649-1-richard.henderson@linaro.org>
References: <20190416083150.19649-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] tcg: Restart after TB code generation
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

If a TB generates too much code, try again with fewer insns.

Fixes: https://bugs.launchpad.net/bugs/1824853
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 39 +++++++++++++++++++++++++++++++++------
 tcg/tcg.c                 |  4 ++++
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fcdfe6c0ec..7086d5fd2a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1721,6 +1721,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
     tcg_ctx->tb_cflags = cflags;
+ tb_overflow:
 
 #ifdef CONFIG_PROFILER
     /* includes aborted translations because of exceptions */
@@ -1754,14 +1755,40 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     ti = profile_getclock();
 #endif
 
-    /* ??? Overflow could be handled better here.  In particular, we
-       don't need to re-do gen_intermediate_code, nor should we re-do
-       the tcg optimization currently hidden inside tcg_gen_code.  All
-       that should be required is to flush the TBs, allocate a new TB,
-       re-initialize it per above, and re-do the actual code generation.  */
     gen_code_size = tcg_gen_code(tcg_ctx, tb);
     if (unlikely(gen_code_size < 0)) {
-        goto buffer_overflow;
+        switch (gen_code_size) {
+        case -1:
+            /*
+             * Overflow of code_gen_buffer, or the current slice of it.
+             *
+             * TODO: We don't need to re-do gen_intermediate_code, nor
+             * should we re-do the tcg optimization currently hidden
+             * inside tcg_gen_code.  All that should be required is to
+             * flush the TBs, allocate a new TB, re-initialize it per
+             * above, and re-do the actual code generation.
+             */
+            goto buffer_overflow;
+
+        case -2:
+            /*
+             * The code generated for the TranslationBlock is too large.
+             * The maximum size allowed by the unwind info is 64k.
+             * There may be stricter constraints from relocations
+             * in the tcg backend.
+             *
+             * Try again with half as many insns as we attempted this time.
+             * If a single insn overflows, there's a bug somewhere...
+             */
+            max_insns = tb->icount;
+qemu_log("TB overflow: pc=%lx insns=%d\n", (unsigned long)pc, max_insns);
+            assert(max_insns > 1);
+            max_insns /= 2;
+            goto tb_overflow;
+
+        default:
+            g_assert_not_reached();
+        }
     }
     search_size = encode_search(tb, (void *)gen_code_buf + gen_code_size);
     if (unlikely(search_size < 0)) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 9b2bf7f439..aa0e94521b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3991,6 +3991,10 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         if (unlikely((void *)s->code_ptr > s->code_gen_highwater)) {
             return -1;
         }
+        /* Test for TB overflow, as seen by gen_insn_end_off.  */
+        if (unlikely(tcg_current_code_size(s) > UINT16_MAX)) {
+            return -2;
+        }
     }
     tcg_debug_assert(num_insns >= 0);
     s->gen_insn_end_off[num_insns] = tcg_current_code_size(s);
-- 
2.17.1
