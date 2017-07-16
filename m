Received: from eggs.gnu.org ([2001:4830:134:3::10]:46210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmb-0001Ar-GR
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmW-0008N2-Hq
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41485)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmW-0008Mj-E5
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:44 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:06 -0400
Message-Id: <1500235468-15341-24-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 23/45] translate-all: define and use
 DEBUG_TB_FLUSH_GATE
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

This gets rid of some ifdef checks while ensuring that the debug code
is compiled, which prevents bit rot.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 80ac85a..c38448c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -65,6 +65,12 @@
 /* make various TB consistency checks */
 /* #define DEBUG_TB_CHECK */
 
+#ifdef DEBUG_TB_FLUSH
+#define DEBUG_TB_FLUSH_GATE 1
+#else
+#define DEBUG_TB_FLUSH_GATE 0
+#endif
+
 #if !defined(CONFIG_USER_ONLY)
 /* TB consistency checks only implemented for usermode emulation.  */
 #undef DEBUG_TB_CHECK
@@ -899,13 +905,13 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
         goto done;
     }
 
-#if defined(DEBUG_TB_FLUSH)
-    printf("qemu: flush code_size=%ld nb_tbs=%d avg_tb_size=%ld\n",
-           (unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer),
-           tcg_ctx.tb_ctx.nb_tbs, tcg_ctx.tb_ctx.nb_tbs > 0 ?
-           ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)) /
-           tcg_ctx.tb_ctx.nb_tbs : 0);
-#endif
+    if (DEBUG_TB_FLUSH_GATE) {
+        printf("qemu: flush code_size=%td nb_tbs=%d avg_tb_size=%td\n",
+               tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer,
+               tcg_ctx.tb_ctx.nb_tbs, tcg_ctx.tb_ctx.nb_tbs > 0 ?
+               (tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer) /
+               tcg_ctx.tb_ctx.nb_tbs : 0);
+    }
     if ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)
         > tcg_ctx.code_gen_buffer_size) {
         cpu_abort(cpu, "Internal error: code buffer overflow\n");
-- 
2.7.4
