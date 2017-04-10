Received: from eggs.gnu.org ([2001:4830:134:3::10]:60955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxdCh-0000pA-55
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxdCg-0006u1-8R
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:34:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 18:13:33 +0100
Message-Id: <1491844419-12485-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
References: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/9] arm: Factor out "generate right kind of
 step exception"
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

We currently have two places that do:
            if (dc->ss_active) {
                gen_step_complete_exception(dc);
            } else {
                gen_exception_internal(EXCP_DEBUG);
            }

Factor this out into its own function, as we're about to add
a third place that needs the same logic.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/translate.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ddc62b6..870e320 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -296,6 +296,19 @@ static void gen_step_complete_exception(DisasContext *s)
     s->is_jmp = DISAS_EXC;
 }
 
+static void gen_singlestep_exception(DisasContext *s)
+{
+    /* Generate the right kind of exception for singlestep, which is
+     * either the architectural singlestep or EXCP_DEBUG for QEMU's
+     * gdb singlestepping.
+     */
+    if (s->ss_active) {
+        gen_step_complete_exception(s);
+    } else {
+        gen_exception_internal(EXCP_DEBUG);
+    }
+}
+
 static void gen_smul_dual(TCGv_i32 a, TCGv_i32 b)
 {
     TCGv_i32 tmp1 = tcg_temp_new_i32();
@@ -11998,24 +12011,15 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
             gen_set_pc_im(dc, dc->pc);
             /* fall through */
         default:
-            if (dc->ss_active) {
-                gen_step_complete_exception(dc);
-            } else {
-                /* FIXME: Single stepping a WFI insn will not halt
-                   the CPU.  */
-                gen_exception_internal(EXCP_DEBUG);
-            }
+            /* FIXME: Single stepping a WFI insn will not halt the CPU. */
+            gen_singlestep_exception(dc);
         }
         if (dc->condjmp) {
             /* "Condition failed" instruction codepath. */
             gen_set_label(dc->condlabel);
             gen_set_condexec(dc);
             gen_set_pc_im(dc, dc->pc);
-            if (dc->ss_active) {
-                gen_step_complete_exception(dc);
-            } else {
-                gen_exception_internal(EXCP_DEBUG);
-            }
+            gen_singlestep_exception(dc);
         }
     } else {
         /* While branches must always occur at the end of an IT block,
-- 
2.7.4
