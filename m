Received: from eggs.gnu.org ([2001:4830:134:3::10]:47922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxm-00038u-PE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxl-00013t-Q3
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:22 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZjxl-00013E-LA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:21 -0400
Received: by mail-qk0-x242.google.com with SMTP id t2so10965342qkc.5
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:28:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 13:27:09 -0700
Message-Id: <20170724202728.25960-14-rth@twiddle.net>
In-Reply-To: <20170724202728.25960-1-rth@twiddle.net>
References: <20170724202728.25960-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v15 13/32] target/i386: [tcg] Port to disas_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, vilanova@ac.upc.edu

From: Lluís Vilanova <vilanova@ac.upc.edu>

Incrementally paves the way towards using the generic instruction translation
loop.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <150002243497.22386.8888053391875656102.stgit@frigg.lan>
[rth: Move tb->size computation and use that result.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 8238533c0e..8e7212cf92 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8517,6 +8517,21 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
+static void i386_tr_disas_log(const DisasContextBase *dcbase,
+                              CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    int disas_flags = !dc->code32;
+
+    qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
+#ifdef TARGET_X86_64
+    if (dc->code64) {
+        disas_flags = 2;
+    }
+#endif
+    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size, disas_flags);
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -8592,28 +8607,19 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         gen_io_end();
     gen_tb_end(tb, num_insns);
 
+    tb->size = dc->base.pc_next - dc->base.pc_first;
+    tb->icount = num_insns;
+
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(dc->base.pc_first)) {
-        int disas_flags;
         qemu_log_lock();
         qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
-#ifdef TARGET_X86_64
-        if (dc->code64)
-            disas_flags = 2;
-        else
-#endif
-            disas_flags = !dc->code32;
-        log_target_disas(cs, dc->base.pc_first, dc->base.pc_next - dc->base.pc_first,
-                         disas_flags);
+        i386_tr_disas_log(&dc->base, cs);
         qemu_log("\n");
         qemu_log_unlock();
     }
 #endif
-
-    tb->size = dc->base.pc_next - dc->base.pc_first;
-    tb->icount = num_insns;
 }
 
 void restore_state_to_opc(CPUX86State *env, TranslationBlock *tb,
-- 
2.13.3
