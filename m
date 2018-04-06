Received: from eggs.gnu.org ([2001:4830:134:3::10]:58416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4GsL-0002GC-7g
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4GsI-0003Tf-Nr
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:13 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58103)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f4GsI-0003TH-Jh
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  5 Apr 2018 22:12:55 -0400
Message-Id: <1522980788-1252-5-git-send-email-cota@braap.org>
In-Reply-To: <1522980788-1252-1-git-send-email-cota@braap.org>
References: <1522980788-1252-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/17] tcg: move
 tb_ctx.tb_phys_invalidate_count to tcg_ctx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Thereby making it per-TCGContext. Once we remove tb_lock, this will
avoid an atomic increment every time a TB is invalidated.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/tb-context.h |  1 -
 tcg/tcg.h                 |  3 +++
 accel/tcg/translate-all.c |  5 +++--
 tcg/tcg.c                 | 14 ++++++++++++++
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index d8472c8..8c9b49c 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -37,7 +37,6 @@ struct TBContext {
 
     /* statistics */
     unsigned tb_flush_count;
-    int tb_phys_invalidate_count;
 };
 
 extern TBContext tb_ctx;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 8bf29cc..9dd9448 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -694,6 +694,8 @@ struct TCGContext {
     /* Threshold to flush the translated code buffer.  */
     void *code_gen_highwater;
 
+    size_t tb_phys_invalidate_count;
+
     /* Track which vCPU triggers events */
     CPUState *cpu;                      /* *_trans */
 
@@ -852,6 +854,7 @@ size_t tcg_code_capacity(void);
 
 void tcg_tb_insert(TranslationBlock *tb);
 void tcg_tb_remove(TranslationBlock *tb);
+size_t tcg_tb_phys_invalidate_count(void);
 TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr);
 void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);
 size_t tcg_nb_tbs(void);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 449d4de..feac8ce 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1072,7 +1072,8 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
     /* suppress any remaining jumps to this TB */
     tb_jmp_unlink(tb);
 
-    tb_ctx.tb_phys_invalidate_count++;
+    atomic_set(&tcg_ctx->tb_phys_invalidate_count,
+               tcg_ctx->tb_phys_invalidate_count + 1);
 }
 
 #ifdef CONFIG_SOFTMMU
@@ -1857,7 +1858,7 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     cpu_fprintf(f, "\nStatistics:\n");
     cpu_fprintf(f, "TB flush count      %u\n",
                 atomic_read(&tb_ctx.tb_flush_count));
-    cpu_fprintf(f, "TB invalidate count %d\n", tb_ctx.tb_phys_invalidate_count);
+    cpu_fprintf(f, "TB invalidate count %zu\n", tcg_tb_phys_invalidate_count());
     cpu_fprintf(f, "TLB flush count     %zu\n", tlb_flush_count());
     tcg_dump_info(f, cpu_fprintf);
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b471708..a7b596e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -791,6 +791,20 @@ size_t tcg_code_capacity(void)
     return capacity;
 }
 
+size_t tcg_tb_phys_invalidate_count(void)
+{
+    unsigned int n_ctxs = atomic_read(&n_tcg_ctxs);
+    unsigned int i;
+    size_t total = 0;
+
+    for (i = 0; i < n_ctxs; i++) {
+        const TCGContext *s = atomic_read(&tcg_ctxs[i]);
+
+        total += atomic_read(&s->tb_phys_invalidate_count);
+    }
+    return total;
+}
+
 /* pool based memory allocation */
 void *tcg_malloc_internal(TCGContext *s, int size)
 {
-- 
2.7.4
