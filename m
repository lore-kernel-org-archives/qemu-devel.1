Received: from eggs.gnu.org ([2001:4830:134:3::10]:43348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQg4q-0007E4-BE
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQg4n-0000zP-4Y
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQg4m-0000xJ-Qq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 29 Jun 2017 16:28:26 -0400
Message-Id: <1498768109-4092-5-git-send-email-cota@braap.org>
In-Reply-To: <1498768109-4092-1-git-send-email-cota@braap.org>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [RFC 4/7] translate-all: report correct avg host TB
 size
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
  doing otherwise would mislead users into thinking "tb-size" is not
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
index a18fbf7..9714777 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -894,9 +894,20 @@ static void page_flush_tb(void)
     }
 }
 
+static __attribute__((unused))
+gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
+{
+    const TranslationBlock *tb = value;
+    int *size = data;
+
+    *size += tb->out_size;
+    return false;
+}
+
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
+    int host_size __attribute__((unused));
     int nb_tbs __attribute__((unused));
 
     tb_lock();
@@ -909,12 +920,11 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     }
 
 #if defined(DEBUG_TB_FLUSH)
+    g_tree_foreach(tcg_ctx.tb_ctx.tb_tree, tb_host_size_iter, &host_size);
     nb_tbs = g_tree_nnodes(tcg_ctx.tb_ctx.tb_tree);
-    printf("qemu: flush code_size=%ld nb_tbs=%d avg_tb_size=%ld\n",
+    printf("qemu: flush code_size=%ld nb_tbs=%d avg_tb_size=%d\n",
            (unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer),
-           nb_tbs, nb_tbs > 0 ?
-           ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)) /
-           nb_tbs : 0);
+           nb_tbs, nb_tbs > 0 ? host_size / nb_tbs : 0);
 #endif
     if ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)
         > tcg_ctx.code_gen_buffer_size) {
@@ -1842,6 +1852,7 @@ static void print_qht_statistics(FILE *f, fprintf_function cpu_fprintf,
 }
 
 struct tb_tree_stats {
+    int host_size;
     int target_size;
     int max_target_size;
     int direct_jmp_count;
@@ -1854,6 +1865,7 @@ static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
     const TranslationBlock *tb = value;
     struct tb_tree_stats *tst = data;
 
+    tst->host_size += tb->out_size;
     tst->target_size += tb->size;
     if (tb->size > tst->max_target_size) {
         tst->max_target_size = tb->size;
@@ -1882,6 +1894,11 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
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
@@ -1889,12 +1906,9 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     cpu_fprintf(f, "TB avg target size  %d max=%d bytes\n",
                 nb_tbs ? tst.target_size / nb_tbs : 0,
                 tst.max_target_size);
-    cpu_fprintf(f, "TB avg host size    %td bytes (expansion ratio: %0.1f)\n",
-                nb_tbs ? (tcg_ctx.code_gen_ptr -
-                          tcg_ctx.code_gen_buffer) / nb_tbs : 0,
-                tst.target_size ? (double) (tcg_ctx.code_gen_ptr -
-                                            tcg_ctx.code_gen_buffer) /
-                                            tst.target_size : 0);
+    cpu_fprintf(f, "TB avg host size    %d bytes (expansion ratio: %0.1f)\n",
+                nb_tbs ? tst.host_size / nb_tbs : 0,
+                tst.target_size ? (double)tst.host_size / tst.target_size : 0);
     cpu_fprintf(f, "cross page TB count %d (%d%%)\n", tst.cross_page,
             nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
     cpu_fprintf(f, "direct jump count   %d (%d%%) (2 jumps=%d %d%%)\n",
-- 
2.7.4
