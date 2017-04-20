Received: from eggs.gnu.org ([2001:4830:134:3::10]:43700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F91-0008Ou-M7
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F90-00086W-5B
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F8z-00085i-T6
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8z-0006zO-0i
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:21 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:41:06 +0100
Message-Id: <1492706470-10921-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/24] arm: Move condition-failed codepath
 generation out of if()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Move the code to generate the "condition failed" instruction
codepath out of the if (singlestepping) {} else {}. This
will allow adding support for handling a new is_jmp type
which can't be neatly split into "singlestepping case"
versus "not singlestepping case".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-id: 1491844419-12485-6-git-send-email-peter.maydell@linaro.org
---
 target/arm/translate.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a1a0e73..87fd702 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11988,9 +11988,9 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
     /* At this stage dc->condjmp will only be set when the skipped
        instruction was a conditional branch or trap, and the PC has
        already been written.  */
+    gen_set_condexec(dc);
     if (unlikely(cs->singlestep_enabled || dc->ss_active)) {
         /* Unconditional and "condition passed" instruction codepath. */
-        gen_set_condexec(dc);
         switch (dc->is_jmp) {
         case DISAS_SWI:
             gen_ss_advance(dc);
@@ -12013,13 +12013,6 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
             /* FIXME: Single stepping a WFI insn will not halt the CPU. */
             gen_singlestep_exception(dc);
         }
-        if (dc->condjmp) {
-            /* "Condition failed" instruction codepath. */
-            gen_set_label(dc->condlabel);
-            gen_set_condexec(dc);
-            gen_set_pc_im(dc, dc->pc);
-            gen_singlestep_exception(dc);
-        }
     } else {
         /* While branches must always occur at the end of an IT block,
            there are a few other things that can cause us to terminate
@@ -12029,7 +12022,6 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
             - Hardware watchpoints.
            Hardware breakpoints have already been handled and skip this code.
          */
-        gen_set_condexec(dc);
         switch(dc->is_jmp) {
         case DISAS_NEXT:
             gen_goto_tb(dc, 1, dc->pc);
@@ -12069,11 +12061,17 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
             gen_exception(EXCP_SMC, syn_aa32_smc(), 3);
             break;
         }
-        if (dc->condjmp) {
-            gen_set_label(dc->condlabel);
-            gen_set_condexec(dc);
+    }
+
+    if (dc->condjmp) {
+        /* "Condition failed" instruction codepath for the branch/trap insn */
+        gen_set_label(dc->condlabel);
+        gen_set_condexec(dc);
+        if (unlikely(cs->singlestep_enabled || dc->ss_active)) {
+            gen_set_pc_im(dc, dc->pc);
+            gen_singlestep_exception(dc);
+        } else {
             gen_goto_tb(dc, 1, dc->pc);
-            dc->condjmp = 0;
         }
     }
 
-- 
2.7.4
