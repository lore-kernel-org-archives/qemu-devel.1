Received: from eggs.gnu.org ([2001:4830:134:3::10]:41906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqm-0000LW-Qf
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqi-0002cX-CW
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:48 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:34783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqi-0002bQ-6n
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:44 -0400
Received: by mail-pf0-x234.google.com with SMTP id m1so13485760pfk.1
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:06:01 -0700
Message-Id: <20170906160612.22769-22-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/32] target/arm: [tcg,
 a64] Port to breakpoint_check
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

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Message-Id: <150002461630.22386.14827196109258040543.stgit@frigg.lan>
[rth: Use DISAS_TOO_MANY for "execute only one more" after bp.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 48 ++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1eab10696c..e94198280d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11267,6 +11267,30 @@ static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     tcg_gen_insn_start(dc->pc, 0, 0);
 }
 
+static bool aarch64_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
+                                        const CPUBreakpoint *bp)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    if (bp->flags & BP_CPU) {
+        gen_a64_set_pc_im(dc->pc);
+        gen_helper_check_breakpoints(cpu_env);
+        /* End the TB early; it likely won't be executed */
+        dc->base.is_jmp = DISAS_TOO_MANY;
+    } else {
+        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+        /* The address covered by the breakpoint must be
+           included in [tb->pc, tb->pc + tb->size) in order
+           to for it to be properly cleared -- thus we
+           increment the PC here so that the logic setting
+           tb->size below does the right thing.  */
+        dc->pc += 4;
+        dc->base.is_jmp = DISAS_NORETURN;
+    }
+
+    return true;
+}
+
 void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
                                TranslationBlock *tb)
 {
@@ -11303,25 +11327,15 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
             QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc == dc->pc) {
-                    if (bp->flags & BP_CPU) {
-                        gen_a64_set_pc_im(dc->pc);
-                        gen_helper_check_breakpoints(cpu_env);
-                        /* End the TB early; it likely won't be executed */
-                        dc->base.is_jmp = DISAS_UPDATE;
-                    } else {
-                        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
-                        /* The address covered by the breakpoint must be
-                           included in [dc->base.tb->pc, dc->base.tb->pc + dc->base.tb->size) in order
-                           to for it to be properly cleared -- thus we
-                           increment the PC here so that the logic setting
-                           dc->base.tb->size below does the right thing.  */
-                        dc->pc += 4;
-                        goto done_generating;
+                if (bp->pc == dc->base.pc_next) {
+                    if (aarch64_tr_breakpoint_check(&dc->base, cs, bp)) {
+                        break;
                     }
-                    break;
                 }
             }
+            if (dc->base.is_jmp > DISAS_TOO_MANY) {
+                break;
+            }
         }
 
         if (dc->base.num_insns == max_insns && (dc->base.tb->cflags & CF_LAST_IO)) {
@@ -11392,6 +11406,7 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
     } else {
         switch (dc->base.is_jmp) {
         case DISAS_NEXT:
+        case DISAS_TOO_MANY:
             gen_goto_tb(dc, 1, dc->pc);
             break;
         case DISAS_JUMP:
@@ -11429,7 +11444,6 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
         }
     }
 
-done_generating:
     gen_tb_end(tb, dc->base.num_insns);
 
 #ifdef DEBUG_DISAS
-- 
2.13.5
