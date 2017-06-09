Received: from eggs.gnu.org ([2001:4830:134:3::10]:49426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJCbv-000614-NM
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJCbu-0001co-Ca
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:37:27 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJCbu-0001ck-7R
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:37:26 -0400
Received: by mail-qt0-x244.google.com with SMTP id s33so13043720qtg.3
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 22:37:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  8 Jun 2017 22:37:14 -0700
Message-Id: <20170609053719.26251-3-rth@twiddle.net>
In-Reply-To: <20170609053719.26251-1-rth@twiddle.net>
References: <20170609053719.26251-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v5 2/7] tcg: allocate TB structs before the
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
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

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
used portion of code_gen_buffer when booting aarch64 Linux on a
host with 64-byte cache lines. However, it can allow for optimizations
in some host architectures, since TCG backends could safely assume that
the TB and the corresponding translated code are very close to each
other in memory. See this message by rth for a detailed explanation:

  https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05172.html
  Subject: Re: GSoC 2017 Proposal: TCG performance enhancements
  Message-ID: <1e67644b-4b30-887e-d329-1848e94c9484@twiddle.net>

Suggested-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Pranith Kumar <bobby.prani@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1496790745-314-3-git-send-email-cota@braap.org>
[rth: Simplify the arithmetic in tcg_tb_alloc]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/tb-context.h |  3 ++-
 tcg/tcg.c                 | 20 ++++++++++++++++++++
 tcg/tcg.h                 |  2 +-
 translate-all.c           | 39 ++++++++++++++++++++++++---------------
 4 files changed, 47 insertions(+), 17 deletions(-)

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
index 564292f..3559829 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -383,6 +383,26 @@ void tcg_context_init(TCGContext *s)
     }
 }
 
+/*
+ * Allocate TBs right before their corresponding translated code, making
+ * sure that TBs and code are on different cache lines.
+ */
+TranslationBlock *tcg_tb_alloc(TCGContext *s)
+{
+    uintptr_t align = qemu_icache_linesize;
+    TranslationBlock *tb;
+    void *next;
+
+    tb = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, align);
+    next = (void *)ROUND_UP((uintptr_t)(tb + 1), align);
+
+    if (unlikely(next > s->code_gen_highwater)) {
+        return NULL;
+    }
+    s->code_gen_ptr = next;
+    return tb;
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
index b3ee876..bb094ad 100644
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
+        tcg_ctx.tb_ctx.tbs_size = 64 * 1024;
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
@@ -850,8 +858,10 @@ void tb_free(TranslationBlock *tb)
        Ignore the hard cases and just back up if this TB happens to
        be the last one generated.  */
     if (tcg_ctx.tb_ctx.nb_tbs > 0 &&
-            tb == &tcg_ctx.tb_ctx.tbs[tcg_ctx.tb_ctx.nb_tbs - 1]) {
-        tcg_ctx.code_gen_ptr = tb->tc_ptr;
+            tb == tcg_ctx.tb_ctx.tbs[tcg_ctx.tb_ctx.nb_tbs - 1]) {
+        size_t struct_size = ROUND_UP(sizeof(*tb), qemu_icache_linesize);
+
+        tcg_ctx.code_gen_ptr = tb->tc_ptr - struct_size;
         tcg_ctx.tb_ctx.nb_tbs--;
     }
 }
@@ -1666,7 +1676,7 @@ static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
     m_max = tcg_ctx.tb_ctx.nb_tbs - 1;
     while (m_min <= m_max) {
         m = (m_min + m_max) >> 1;
-        tb = &tcg_ctx.tb_ctx.tbs[m];
+        tb = tcg_ctx.tb_ctx.tbs[m];
         v = (uintptr_t)tb->tc_ptr;
         if (v == tc_ptr) {
             return tb;
@@ -1676,7 +1686,7 @@ static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
             m_min = m + 1;
         }
     }
-    return &tcg_ctx.tb_ctx.tbs[m_max];
+    return tcg_ctx.tb_ctx.tbs[m_max];
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -1874,7 +1884,7 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     direct_jmp_count = 0;
     direct_jmp2_count = 0;
     for (i = 0; i < tcg_ctx.tb_ctx.nb_tbs; i++) {
-        tb = &tcg_ctx.tb_ctx.tbs[i];
+        tb = tcg_ctx.tb_ctx.tbs[i];
         target_code_size += tb->size;
         if (tb->size > max_target_code_size) {
             max_target_code_size = tb->size;
@@ -1894,8 +1904,7 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
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
2.9.4
