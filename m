Received: from eggs.gnu.org ([2001:4830:134:3::10]:38209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbh-0003td-3G
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbg-0003M8-3U
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:25 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbf-0003Lq-Rq
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:24 -0400
Received: by mail-pf0-x241.google.com with SMTP id q85so13698480pfq.2
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:25 -1000
Message-Id: <20170715094243.28371-17-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 16/34] target/i386: [tcg] Port to generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

From: Lluís Vilanova <vilanova@ac.upc.edu>

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Tested-by: Emilio G. Cota <cota@braap.org>
Message-Id: <150002267714.22386.5095442346868988808.stgit@frigg.lan>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 106 +++++++++---------------------------------------
 1 file changed, 19 insertions(+), 87 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 8e7212c..2bd667e 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8449,6 +8449,10 @@ static int i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu,
     return max_insns;
 }
 
+static void i386_tr_tb_start(DisasContextBase *db, CPUState *cpu)
+{
+}
+
 static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
@@ -8468,7 +8472,7 @@ static bool i386_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
         /* The address covered by the breakpoint must be included in
            [tb->pc, tb->pc + tb->size) in order to for it to be
            properly cleared -- thus we increment the PC here so that
-           the logic setting tb->size below does the right thing.  */
+           the generic logic setting tb->size later does the right thing.  */
         dc->base.pc_next += 1;
         return true;
     } else {
@@ -8532,94 +8536,22 @@ static void i386_tr_disas_log(const DisasContextBase *dcbase,
     log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size, disas_flags);
 }
 
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
-{
-    DisasContext dc1, *dc = &dc1;
-    int num_insns;
-    int max_insns;
-
-    /* generate intermediate code */
-    dc->base.singlestep_enabled = cs->singlestep_enabled;
-    dc->base.tb = tb;
-    dc->base.is_jmp = DISAS_NEXT;
-    dc->base.pc_first = tb->pc;
-    dc->base.pc_next = dc->base.pc_first;
-
-    max_insns = tb->cflags & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
-    max_insns = i386_tr_init_disas_context(&dc->base, cs, max_insns);
-
-    num_insns = 0;
-    gen_tb_start(tb);
-    for(;;) {
-        i386_tr_insn_start(&dc->base, cs);
-        num_insns++;
-
-        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc == dc->base.pc_next) {
-                    if (i386_tr_breakpoint_check(&dc->base, cs, bp)) {
-                        break;
-                    }
-                }
-            }
-
-            if (dc->base.is_jmp == DISAS_NORETURN) {
-                break;
-            }
-        }
-
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
-        }
-
-        i386_tr_translate_insn(&dc->base, cs);
-        /* stop translation if indicated */
-        if (dc->base.is_jmp) {
-            break;
-        }
-        /* if single step mode, we generate only one instruction and
-           generate an exception */
-        if (dc->base.singlestep_enabled) {
-            dc->base.is_jmp = DISAS_TOO_MANY;
-            break;
-        }
-        /* if too long translation, stop generation too */
-        if (tcg_op_buf_full() ||
-            num_insns >= max_insns) {
-            dc->base.is_jmp = DISAS_TOO_MANY;
-            break;
-        }
-        if (singlestep) {
-            dc->base.is_jmp = DISAS_TOO_MANY;
-            break;
-        }
-    }
-    i386_tr_tb_stop(&dc->base, cs);
-    if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
-    gen_tb_end(tb, num_insns);
+static const TranslatorOps i386_tr_ops = {
+    .init_disas_context = i386_tr_init_disas_context,
+    .tb_start           = i386_tr_tb_start,
+    .insn_start         = i386_tr_insn_start,
+    .breakpoint_check   = i386_tr_breakpoint_check,
+    .translate_insn     = i386_tr_translate_insn,
+    .tb_stop            = i386_tr_tb_stop,
+    .disas_log          = i386_tr_disas_log,
+};
 
-    tb->size = dc->base.pc_next - dc->base.pc_first;
-    tb->icount = num_insns;
+/* generate intermediate code for basic block 'tb'.  */
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+{
+    DisasContext dc;
 
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(dc->base.pc_first)) {
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        i386_tr_disas_log(&dc->base, cs);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
+    translator_loop(&i386_tr_ops, &dc.base, cpu, tb);
 }
 
 void restore_state_to_opc(CPUX86State *env, TranslationBlock *tb,
-- 
2.9.4
