Received: from eggs.gnu.org ([2001:4830:134:3::10]:44704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gbV-0006V8-Qn
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gbU-0007vv-MU
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:25 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5gbU-0007vZ-DV
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:24 -0400
Received: by mail-pf0-x244.google.com with SMTP id d28so13078761pfe.2
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:21:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 20 Oct 2017 16:20:11 -0700
Message-Id: <20171020232023.15010-41-richard.henderson@linaro.org>
In-Reply-To: <20171020232023.15010-1-richard.henderson@linaro.org>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 40/52] translate-all: report correct avg
 host TB size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, f4bug@amsat.org, pbonzini@redhat.com

From: "Emilio G. Cota" <cota@braap.org>

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

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index e929ccb30b..7e2c0cdb98 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -921,6 +921,15 @@ static void page_flush_tb(void)
     }
 }
 
+static gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
+{
+    const TranslationBlock *tb = value;
+    size_t *size = data;
+
+    *size += tb->tc.size;
+    return false;
+}
+
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
@@ -935,11 +944,12 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 
     if (DEBUG_TB_FLUSH_GATE) {
         size_t nb_tbs = g_tree_nnodes(tcg_ctx.tb_ctx.tb_tree);
+        size_t host_size = 0;
 
-        printf("qemu: flush code_size=%td nb_tbs=%zu avg_tb_size=%td\n",
+        g_tree_foreach(tcg_ctx.tb_ctx.tb_tree, tb_host_size_iter, &host_size);
+        printf("qemu: flush code_size=%td nb_tbs=%zu avg_tb_size=%zu\n",
                tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer, nb_tbs,
-               nb_tbs > 0 ?
-               (tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer) / nb_tbs : 0);
+               nb_tbs > 0 ? host_size / nb_tbs : 0);
     }
     if ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)
         > tcg_ctx.code_gen_buffer_size) {
@@ -1882,6 +1892,7 @@ static void print_qht_statistics(FILE *f, fprintf_function cpu_fprintf,
 }
 
 struct tb_tree_stats {
+    size_t host_size;
     size_t target_size;
     size_t max_target_size;
     size_t direct_jmp_count;
@@ -1894,6 +1905,7 @@ static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
     const TranslationBlock *tb = value;
     struct tb_tree_stats *tst = data;
 
+    tst->host_size += tb->tc.size;
     tst->target_size += tb->size;
     if (tb->size > tst->max_target_size) {
         tst->max_target_size = tb->size;
@@ -1922,6 +1934,11 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
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
@@ -1929,12 +1946,9 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
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
2.13.6
