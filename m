Received: from eggs.gnu.org ([2001:4830:134:3::10]:41665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqX-0008Sd-KS
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqT-0001xj-Lv
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:33 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:36480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqT-0001tQ-GT
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:29 -0400
Received: by mail-pf0-x233.google.com with SMTP id e199so13452448pfh.3
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:05:50 -0700
Message-Id: <20170906160612.22769-11-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/32] target/i386: [tcg] Port to
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
Cc: peter.maydell@linaro.org, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Richard Henderson <rth@twiddle.net>

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
index b7e5854513..4d4083fe30 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8456,6 +8456,26 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
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
@@ -8486,18 +8506,21 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
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
@@ -8548,7 +8571,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     }
     if (tb->cflags & CF_LAST_IO)
         gen_io_end();
-done_generating:
     gen_tb_end(tb, num_insns);
 
 #ifdef DEBUG_DISAS
-- 
2.13.5
