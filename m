Received: from eggs.gnu.org ([2001:4830:134:3::10]:38154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbY-0003ln-SQ
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbX-0003Ir-Vh
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:16 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbX-0003Ia-PK
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:15 -0400
Received: by mail-pf0-x242.google.com with SMTP id q85so13698128pfq.2
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:21 -1000
Message-Id: <20170715094243.28371-13-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 12/34] target/i386: [tcg] Port to
 breakpoint_check
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

Incrementally paves the way towards using the generic instruction translation
loop.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Message-Id: <150002170871.22386.2172835658104140576.stgit@frigg.lan>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 6e1243a..a009710 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8455,6 +8455,26 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
 }
 
+static bool i386_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
+                                     const CPUBreakpoint *bp)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    /* If RF is set, suppress an internally generated breakpoint.  */
+    int flags = dc->base.tb->flags & HF_RF_MASK ? BP_GDB : BP_ANY;
+    if (bp->flags & flags) {
+        gen_debug(dc, dc->base.pc_next - dc->cs_base);
+        dc->base.is_jmp = DISAS_NORETURN;
+        /* The address covered by the breakpoint must be included in
+           [tb->pc, tb->pc + tb->size) in order to for it to be
+           properly cleared -- thus we increment the PC here so that
+           the logic setting tb->size below does the right thing.  */
+        dc->base.pc_next += 1;
+        return true;
+    } else {
+        return false;
+    }
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -8485,18 +8505,21 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         i386_tr_insn_start(&dc->base, cs);
         num_insns++;
 
-        /* If RF is set, suppress an internally generated breakpoint.  */
-        if (unlikely(cpu_breakpoint_test(cs, dc->base.pc_next,
-                                         tb->flags & HF_RF_MASK
-                                         ? BP_GDB : BP_ANY))) {
-            gen_debug(dc, dc->base.pc_next - dc->cs_base);
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            dc->base.pc_next += 1;
-            goto done_generating;
+        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
+            CPUBreakpoint *bp;
+            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
+                if (bp->pc == dc->base.pc_next) {
+                    if (i386_tr_breakpoint_check(&dc->base, cs, bp)) {
+                        break;
+                    }
+                }
+            }
+
+            if (dc->base.is_jmp == DISAS_NORETURN) {
+                break;
+            }
         }
+
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
             gen_io_start();
         }
@@ -8547,7 +8570,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     }
     if (tb->cflags & CF_LAST_IO)
         gen_io_end();
-done_generating:
     gen_tb_end(tb, num_insns);
 
 #ifdef DEBUG_DISAS
-- 
2.9.4
