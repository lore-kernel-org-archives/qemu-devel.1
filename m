Received: from eggs.gnu.org ([2001:4830:134:3::10]:48097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjyE-0003lR-Rw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjyB-0001ow-0m
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:50 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZjyA-0001oX-T9
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:46 -0400
Received: by mail-qk0-x241.google.com with SMTP id q66so10950557qki.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:28:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 13:27:22 -0700
Message-Id: <20170724202728.25960-27-rth@twiddle.net>
In-Reply-To: <20170724202728.25960-1-rth@twiddle.net>
References: <20170724202728.25960-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v15 26/32] target/arm: [tcg] Port to disas_log
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
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Benneé <alex.benee@linaro.org>
Message-Id: <150002582711.22386.191527630537864599.stgit@frigg.lan>
[rth: Move tb->size computation and use that result.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index bacc0303e5..c5e6ee8468 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12141,6 +12141,15 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
+static void arm_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
+    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size,
+                     dc->thumb | (dc->sctlr_b << 1));
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -12221,20 +12230,19 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 
     gen_tb_end(tb, dc->base.num_insns);
 
+    tb->size = dc->pc - dc->base.pc_first;
+    tb->icount = dc->base.num_insns;
+
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
         qemu_log_in_addr_range(dc->base.pc_first)) {
         qemu_log_lock();
         qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
-        log_target_disas(cs, dc->base.pc_first, dc->pc - dc->base.pc_first,
-                         dc->thumb | (dc->sctlr_b << 1));
+        arm_tr_disas_log(&dc->base, cs);
         qemu_log("\n");
         qemu_log_unlock();
     }
 #endif
-    tb->size = dc->pc - dc->base.pc_first;
-    tb->icount = dc->base.num_insns;
 }
 
 static const char *cpu_mode_names[16] = {
-- 
2.13.3
