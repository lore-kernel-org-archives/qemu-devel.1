Received: from eggs.gnu.org ([2001:4830:134:3::10]:46414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zK-0004RE-Pw
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zE-00030p-OF
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:42 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zE-0002zB-7h
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:50:04 -0400
Message-Id: <1499586614-20507-13-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 12/22] translate-all: report correct avg host
 TB size
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

Since commit 6e3b2bfd6 ("tcg: allocate TB structs before the
corresponding translated code") we are not fully utilizing
code_gen_buffer for translated code, and therefore are
incorrectly reporting the amount of translated code as well as
the average host TB size. Address this by:

- Making the conscious choice of misreporting the total translated code;
  doing otherwise would mislead users into thinking "-tb-size" is not
  honoured.

- Expanding tb_tree_stats to accurately count the bytes of translated code on
  the host, and using this for reporting the average tb host size,
  as well as the expansion ratio.

In the future we might want to consider reporting the accurate numbers for
the total translated code, together with a "bookkeeping/overhead" field to
account for the TB structs.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index aa3a08b..aa71292 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -898,9 +898,20 @@ static void page_flush_tb(void)
     }
 }
 
+static __attribute__((unused))
+gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
+{
+    const TranslationBlock *tb = value;
+    size_t *size = data;
+
+    *size += tb->tc_size;
+    return false;
+}
+
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
+    size_t host_size __attribute__((unused)) = 0;
     int nb_tbs __attribute__((unused));
 
     tb_lock();
@@ -913,12 +924,11 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     }
 
 #if defined(DEBUG_TB_FLUSH)
+    g_tree_foreach(tcg_ctx.tb_ctx.tb_tree, tb_host_size_iter, &host_size);
     nb_tbs = g_tree_nnodes(tcg_ctx.tb_ctx.tb_tree);
-    printf("qemu: flush code_size=%ld nb_tbs=%d avg_tb_size=%ld\n",
+    printf("qemu: flush code_size=%ld nb_tbs=%d avg_tb_size=%zu\n",
            (unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer),
-           nb_tbs, nb_tbs > 0 ?
-           ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)) /
-           nb_tbs : 0);
+           nb_tbs, nb_tbs > 0 ? host_size / nb_tbs : 0);
 #endif
     if ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)
         > tcg_ctx.code_gen_buffer_size) {
@@ -1847,6 +1857,7 @@ static void print_qht_statistics(FILE *f, fprintf_function cpu_fprintf,
 }
 
 struct tb_tree_stats {
+    size_t host_size;
     size_t target_size;
     size_t max_target_size;
     size_t direct_jmp_count;
@@ -1859,6 +1870,7 @@ static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
     const TranslationBlock *tb = value;
     struct tb_tree_stats *tst = data;
 
+    tst->host_size += tb->tc_size;
     tst->target_size += tb->size;
     if (tb->size > tst->max_target_size) {
         tst->max_target_size = tb->size;
@@ -1887,6 +1899,11 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     g_tree_foreach(tcg_ctx.tb_ctx.tb_tree, tb_tree_stats_iter, &tst);
     /* XXX: avoid using doubles ? */
     cpu_fprintf(f, "Translation buffer state:\n");
+    /*
+     * Report total code size including the padding and TB structs;
+     * otherwise users might think "-tb-size" is not honoured.
+     * For avg host size we use the precise numbers from tb_tree_stats though.
+     */
     cpu_fprintf(f, "gen code size       %td/%zd\n",
                 tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer,
                 tcg_ctx.code_gen_highwater - tcg_ctx.code_gen_buffer);
@@ -1894,12 +1911,9 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     cpu_fprintf(f, "TB avg target size  %zu max=%zu bytes\n",
                 nb_tbs ? tst.target_size / nb_tbs : 0,
                 tst.max_target_size);
-    cpu_fprintf(f, "TB avg host size    %td bytes (expansion ratio: %0.1f)\n",
-                nb_tbs ? (tcg_ctx.code_gen_ptr -
-                          tcg_ctx.code_gen_buffer) / nb_tbs : 0,
-                tst.target_size ? (double) (tcg_ctx.code_gen_ptr -
-                                            tcg_ctx.code_gen_buffer) /
-                                            tst.target_size : 0);
+    cpu_fprintf(f, "TB avg host size    %zu bytes (expansion ratio: %0.1f)\n",
+                nb_tbs ? tst.host_size / nb_tbs : 0,
+                tst.target_size ? (double)tst.host_size / tst.target_size : 0);
     cpu_fprintf(f, "cross page TB count %zu (%zu%%)\n", tst.cross_page,
             nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
     cpu_fprintf(f, "direct jump count   %zu (%zu%%) (2 jumps=%zu %zu%%)\n",
-- 
2.7.4
