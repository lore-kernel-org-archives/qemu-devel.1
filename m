Received: from eggs.gnu.org ([2001:4830:134:3::10]:32790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxdCk-0000sY-2N
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxdCj-0006vj-5T
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:34:18 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 18:13:36 +0100
Message-Id: <1491844419-12485-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
References: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 6/9] arm: Abstract out "are we
 singlestepping" test to utility function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

We now test for "are we singlestepping" in several places and
it's not a trivial check because we need to care about both
architectural singlestep and QEMU gdbstub singlestep. We're
also about to add another place that needs to make this check,
so pull the condition out into a function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 87fd702..f28c4ca 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -309,6 +309,17 @@ static void gen_singlestep_exception(DisasContext *s)
     }
 }
 
+static inline bool is_singlestepping(DisasContext *s)
+{
+    /* Return true if we are singlestepping either because of
+     * architectural singlestep or QEMU gdbstub singlestep. This does
+     * not include the command line '-singlestep' mode which is rather
+     * misnamed as it only means "one instruction per TB" and doesn't
+     * affect the code we generate.
+     */
+    return s->singlestep_enabled || s->ss_active;
+}
+
 static void gen_smul_dual(TCGv_i32 a, TCGv_i32 b)
 {
     TCGv_i32 tmp1 = tcg_temp_new_i32();
@@ -4104,7 +4115,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
 
 static inline void gen_jmp (DisasContext *s, uint32_t dest)
 {
-    if (unlikely(s->singlestep_enabled || s->ss_active)) {
+    if (unlikely(is_singlestepping(s))) {
         /* An indirect jump so that we still trigger the debug exception.  */
         if (s->thumb)
             dest |= 1;
@@ -11970,9 +11981,8 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
             ((dc->pc >= next_page_start - 3) && insn_crosses_page(env, dc));
 
     } while (!dc->is_jmp && !tcg_op_buf_full() &&
-             !cs->singlestep_enabled &&
+             !is_singlestepping(dc) &&
              !singlestep &&
-             !dc->ss_active &&
              !end_of_page &&
              num_insns < max_insns);
 
@@ -11989,7 +11999,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
        instruction was a conditional branch or trap, and the PC has
        already been written.  */
     gen_set_condexec(dc);
-    if (unlikely(cs->singlestep_enabled || dc->ss_active)) {
+    if (unlikely(is_singlestepping(dc))) {
         /* Unconditional and "condition passed" instruction codepath. */
         switch (dc->is_jmp) {
         case DISAS_SWI:
@@ -12067,7 +12077,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
         /* "Condition failed" instruction codepath for the branch/trap insn */
         gen_set_label(dc->condlabel);
         gen_set_condexec(dc);
-        if (unlikely(cs->singlestep_enabled || dc->ss_active)) {
+        if (unlikely(is_singlestepping(dc))) {
             gen_set_pc_im(dc, dc->pc);
             gen_singlestep_exception(dc);
         } else {
-- 
2.7.4
