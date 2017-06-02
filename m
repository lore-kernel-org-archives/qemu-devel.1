Received: from eggs.gnu.org ([2001:4830:134:3::10]:48997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dGwAE-0001Sm-QN
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 19:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dGwAA-000722-Qg
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 19:39:30 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dGwAA-0006xc-Dr
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 19:39:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri,  2 Jun 2017 19:39:23 -0400
Message-Id: <1496446763-29756-1-git-send-email-cota@braap.org>
In-Reply-To: <1e67644b-4b30-887e-d329-1848e94c9484@twiddle.net>
References: <1e67644b-4b30-887e-d329-1848e94c9484@twiddle.net>
Subject: [Qemu-devel] [PATCH] tcg: allocate TB structs before the
 corresponding translated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>

Allocating an arbitrarily-sized array of tbs results in either
(a) a lot of memory wasted or (b) unnecessary flushes of the code
cache when we run out of TB structs in the array.

An obvious solution would be to just malloc a TB struct when needed,
and keep the TB array as an array of pointers (recall that tb_find_pc()
needs the TB array to run in O(log n)).

Perhaps a better solution, which is implemented in this patch, is to
allocate TB's right before the translated code they describe. This
results in some memory waste due to padding to have code and TBs in
separate cache lines--for instance, I measured 4.7% of padding in the
used portion of code_gen_buffer when booting Linux on aarch64.
However, it can allow for optimizations in some host architectures,
since TCG backends could safely assume that the TB and the corresponding
translated code are very close to each other in memory. See this message
by rth for a detailed explanation:

  https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05172.html
  Subject: Re: GSoC 2017 Proposal: TCG performance enhancements
  Message-ID: <1e67644b-4b30-887e-d329-1848e94c9484@twiddle.net>

Note: this patch applies on top of rth's tcg-next branch (a34a15462).

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   |  2 +-
 include/exec/tb-context.h |  3 ++-
 tcg/tcg.c                 | 16 ++++++++++++++++
 tcg/tcg.h                 |  2 +-
 translate-all.c           | 37 ++++++++++++++++++++++---------------
 5 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 87ae10b..e431548 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -363,7 +363,7 @@ struct TranslationBlock {
      */
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_list_first;
-};
+} QEMU_ALIGNED(64);
 
 void tb_free(TranslationBlock *tb);
 void tb_flush(CPUState *cpu);
diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index c7f17f2..25c2afe 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -31,8 +31,9 @@ typedef struct TBContext TBContext;
 
 struct TBContext {
 
-    TranslationBlock *tbs;
+    TranslationBlock **tbs;
     struct qht htable;
+    size_t tbs_size;
     int nb_tbs;
     /* any access to the tbs or the page table must use this lock */
     QemuMutex tb_lock;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index cb898f1..1e9da5b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -383,6 +383,22 @@ void tcg_context_init(TCGContext *s)
     }
 }
 
+/*
+ * Allocate TBs right before their corresponding translated code, making
+ * sure that TBs and code are on different cache lines.
+ */
+TranslationBlock *tcg_tb_alloc(TCGContext *s)
+{
+    void *aligned;
+
+    aligned = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, 64);
+    if (unlikely(aligned + sizeof(TranslationBlock) > s->code_gen_highwater)) {
+        return NULL;
+    }
+    s->code_gen_ptr += aligned - s->code_gen_ptr + sizeof(TranslationBlock);
+    return aligned;
+}
+
 void tcg_prologue_init(TCGContext *s)
 {
     size_t prologue_size, total_size;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 5ec48d1..9e37722 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -697,7 +697,6 @@ struct TCGContext {
        here, because there's too much arithmetic throughout that relies
        on addition and subtraction working on bytes.  Rely on the GCC
        extension that allows arithmetic on void*.  */
-    int code_gen_max_blocks;
     void *code_gen_prologue;
     void *code_gen_epilogue;
     void *code_gen_buffer;
@@ -756,6 +755,7 @@ static inline bool tcg_op_buf_full(void)
 /* tb_lock must be held for tcg_malloc_internal. */
 void *tcg_malloc_internal(TCGContext *s, int size);
 void tcg_pool_reset(TCGContext *s);
+TranslationBlock *tcg_tb_alloc(TCGContext *s);
 
 void tb_lock(void);
 void tb_unlock(void);
diff --git a/translate-all.c b/translate-all.c
index b3ee876..e36c4d0 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -781,12 +781,13 @@ static inline void code_gen_alloc(size_t tb_size)
         exit(1);
     }
 
-    /* Estimate a good size for the number of TBs we can support.  We
-       still haven't deducted the prologue from the buffer size here,
-       but that's minimal and won't affect the estimate much.  */
-    tcg_ctx.code_gen_max_blocks
-        = tcg_ctx.code_gen_buffer_size / CODE_GEN_AVG_BLOCK_SIZE;
-    tcg_ctx.tb_ctx.tbs = g_new(TranslationBlock, tcg_ctx.code_gen_max_blocks);
+    /* size this conservatively -- realloc later if needed */
+    tcg_ctx.tb_ctx.tbs_size =
+        tcg_ctx.code_gen_buffer_size / CODE_GEN_AVG_BLOCK_SIZE / 8;
+    if (unlikely(!tcg_ctx.tb_ctx.tbs_size)) {
+        tcg_ctx.tb_ctx.tbs_size = 1024;
+    }
+    tcg_ctx.tb_ctx.tbs = g_new(TranslationBlock *, tcg_ctx.tb_ctx.tbs_size);
 
     qemu_mutex_init(&tcg_ctx.tb_ctx.tb_lock);
 }
@@ -828,13 +829,20 @@ bool tcg_enabled(void)
 static TranslationBlock *tb_alloc(target_ulong pc)
 {
     TranslationBlock *tb;
+    TBContext *ctx;
 
     assert_tb_locked();
 
-    if (tcg_ctx.tb_ctx.nb_tbs >= tcg_ctx.code_gen_max_blocks) {
+    tb = tcg_tb_alloc(&tcg_ctx);
+    if (unlikely(tb == NULL)) {
         return NULL;
     }
-    tb = &tcg_ctx.tb_ctx.tbs[tcg_ctx.tb_ctx.nb_tbs++];
+    ctx = &tcg_ctx.tb_ctx;
+    if (unlikely(ctx->nb_tbs == ctx->tbs_size)) {
+        ctx->tbs_size *= 2;
+        ctx->tbs = g_renew(TranslationBlock *, ctx->tbs, ctx->tbs_size);
+    }
+    ctx->tbs[ctx->nb_tbs++] = tb;
     tb->pc = pc;
     tb->cflags = 0;
     tb->invalid = false;
@@ -850,8 +858,8 @@ void tb_free(TranslationBlock *tb)
        Ignore the hard cases and just back up if this TB happens to
        be the last one generated.  */
     if (tcg_ctx.tb_ctx.nb_tbs > 0 &&
-            tb == &tcg_ctx.tb_ctx.tbs[tcg_ctx.tb_ctx.nb_tbs - 1]) {
-        tcg_ctx.code_gen_ptr = tb->tc_ptr;
+            tb == tcg_ctx.tb_ctx.tbs[tcg_ctx.tb_ctx.nb_tbs - 1]) {
+        tcg_ctx.code_gen_ptr = tb->tc_ptr - sizeof(TranslationBlock);
         tcg_ctx.tb_ctx.nb_tbs--;
     }
 }
@@ -1666,7 +1674,7 @@ static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
     m_max = tcg_ctx.tb_ctx.nb_tbs - 1;
     while (m_min <= m_max) {
         m = (m_min + m_max) >> 1;
-        tb = &tcg_ctx.tb_ctx.tbs[m];
+        tb = tcg_ctx.tb_ctx.tbs[m];
         v = (uintptr_t)tb->tc_ptr;
         if (v == tc_ptr) {
             return tb;
@@ -1676,7 +1684,7 @@ static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
             m_min = m + 1;
         }
     }
-    return &tcg_ctx.tb_ctx.tbs[m_max];
+    return tcg_ctx.tb_ctx.tbs[m_max];
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -1874,7 +1882,7 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     direct_jmp_count = 0;
     direct_jmp2_count = 0;
     for (i = 0; i < tcg_ctx.tb_ctx.nb_tbs; i++) {
-        tb = &tcg_ctx.tb_ctx.tbs[i];
+        tb = tcg_ctx.tb_ctx.tbs[i];
         target_code_size += tb->size;
         if (tb->size > max_target_code_size) {
             max_target_code_size = tb->size;
@@ -1894,8 +1902,7 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     cpu_fprintf(f, "gen code size       %td/%zd\n",
                 tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer,
                 tcg_ctx.code_gen_highwater - tcg_ctx.code_gen_buffer);
-    cpu_fprintf(f, "TB count            %d/%d\n",
-            tcg_ctx.tb_ctx.nb_tbs, tcg_ctx.code_gen_max_blocks);
+    cpu_fprintf(f, "TB count            %d\n", tcg_ctx.tb_ctx.nb_tbs);
     cpu_fprintf(f, "TB avg target size  %d max=%d bytes\n",
             tcg_ctx.tb_ctx.nb_tbs ? target_code_size /
                     tcg_ctx.tb_ctx.nb_tbs : 0,
-- 
2.7.4
