Received: from eggs.gnu.org ([2001:4830:134:3::10]:38318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbw-0004Km-RW
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbu-0003Tc-43
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:40 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbt-0003TQ-UG
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:38 -0400
Received: by mail-pg0-x244.google.com with SMTP id 123so1668491pgd.0
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:32 -1000
Message-Id: <20170715094243.28371-24-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 23/34] target/arm: [tcg,
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
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

From: Lluís Vilanova <vilanova@ac.upc.edu>

Incrementally paves the way towards using the generic instruction translation
loop.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <150002461630.22386.14827196109258040543.stgit@frigg.lan>
[rth: Use DISAS_TOO_MANY for "execute only one more" after bp.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 49 +++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index dca5825..1541bf0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11257,6 +11257,30 @@ static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
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
@@ -11293,26 +11317,15 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
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
-                        dc->base.is_jmp = DISAS_NORETURN;
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
@@ -11383,6 +11396,7 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
     } else {
         switch (dc->base.is_jmp) {
         case DISAS_NEXT:
+        case DISAS_TOO_MANY:
             gen_goto_tb(dc, 1, dc->pc);
             break;
         default:
@@ -11420,7 +11434,6 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
         }
     }
 
-done_generating:
     gen_tb_end(tb, dc->base.num_insns);
 
 #ifdef DEBUG_DISAS
-- 
2.9.4
