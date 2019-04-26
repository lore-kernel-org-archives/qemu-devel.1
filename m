Received: from eggs.gnu.org ([209.51.188.92]:48000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aT-0008WU-90
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aR-0006fl-W4
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:37 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aR-0006eX-QF
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:35 -0400
Received: by mail-pg1-x544.google.com with SMTP id 85so1943132pgc.3
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 10:24:15 -0700
Message-Id: <20190426172421.27133-10-richard.henderson@linaro.org>
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/15] tcg: Restart after TB code generation
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 38 ++++++++++++++++++++++++++++++++------
 tcg/tcg.c                 |  4 ++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 39532fd44c..20b59f93f4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1722,6 +1722,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
     tcg_ctx->tb_cflags = cflags;
+ tb_overflow:
 
 #ifdef CONFIG_PROFILER
     /* includes aborted translations because of exceptions */
@@ -1755,14 +1756,39 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
index c0730f119f..5d255166c0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3996,6 +3996,10 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
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
