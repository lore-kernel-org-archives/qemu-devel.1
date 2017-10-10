Received: from eggs.gnu.org ([2001:4830:134:3::10]:60511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqJ-0002K0-Vj
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqJ-0004Sq-10
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:20 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:53904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1iqI-0004SJ-S8
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:18 -0400
Received: by mail-pf0-x234.google.com with SMTP id n73so8794153pfg.10
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:56:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Oct 2017 17:55:48 -0700
Message-Id: <20171010005600.28735-12-richard.henderson@linaro.org>
In-Reply-To: <20171010005600.28735-1-richard.henderson@linaro.org>
References: <20171010005600.28735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/23] translate-all: define and use
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

This gets rid of some ifdef checks while ensuring that the debug code
is compiled, which prevents bit rot.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ed65d68709..799b027e79 100644
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
2.13.6
