Received: from eggs.gnu.org ([2001:4830:134:3::10]:37267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1fqH2B-0008CH-GK
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1fqH29-0004Al-M9
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:05:47 -0400
From: Roman Kapl <rka@sysgo.com>
Date: Thu, 16 Aug 2018 14:05:33 +0200
Message-Id: <20180816120533.6587-1-rka@sysgo.com>
Subject: [Qemu-devel] [PATCH v2] target/arm: crash on conditional instr in
 it block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Roman Kapl <rka@sysgo.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

If an instruction is conditional (like CBZ) and it is executed conditionally
(using the ITx instruction), a jump to undefined label is generated.
CBZ in IT block is an unpredictable behavior, and honouring the condition code
is allowed by the spec in this case (constrained unpredictable, ARMv8, section
K1.1.7).

Fix the 'skip on condtion' code to create a new label only if it does not
already exist. Previously multiple labels were created, but only the last one of
them was set.

Signed-off-by: Roman Kapl <rka@sysgo.com>
---
v1 -> v2
 Split arm_conditional_skip into arm_gen_condlabel and arm_skip_unless to
 a) cover all usages
 b) do not force callers to ^1 the condition

 Add note about CBZ in IT block to the commit message.

 target/arm/translate.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f845da7c63..e54e0ca2ba 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8480,6 +8480,22 @@ static void gen_srs(DisasContext *s,
     s->base.is_jmp = DISAS_UPDATE;
 }
 
+/* Generate a labe used for skipping this instruction */
+static void arm_gen_condlabel(DisasContext *s)
+{
+    if (!s->condjmp) {
+        s->condlabel = gen_new_label();
+        s->condjmp = 1;
+    }
+}
+
+/* Skip this instruction if the ARM condition is false */
+static void arm_skip_unless(DisasContext *s, uint32_t cond)
+{
+    arm_gen_condlabel(s);
+    arm_gen_test_cc(cond, s->condlabel ^ 1);
+}
+
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
     unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
@@ -8709,9 +8725,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     if (cond != 0xe) {
         /* if not always execute, we generate a conditional jump to
            next instruction */
-        s->condlabel = gen_new_label();
-        arm_gen_test_cc(cond ^ 1, s->condlabel);
-        s->condjmp = 1;
+        arm_skip_unless(s, cond);
     }
     if ((insn & 0x0f900000) == 0x03000000) {
         if ((insn & (1 << 21)) == 0) {
@@ -11205,9 +11219,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 /* Conditional branch.  */
                 op = (insn >> 22) & 0xf;
                 /* Generate a conditional jump to next instruction.  */
-                s->condlabel = gen_new_label();
-                arm_gen_test_cc(op ^ 1, s->condlabel);
-                s->condjmp = 1;
+                arm_skip_unless(s, op);
 
                 /* offset[11:1] = insn[10:0] */
                 offset = (insn & 0x7ff) << 1;
@@ -12131,8 +12143,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         case 1: case 3: case 9: case 11: /* czb */
             rm = insn & 7;
             tmp = load_reg(s, rm);
-            s->condlabel = gen_new_label();
-            s->condjmp = 1;
+            arm_gen_condlabel(s);
             if (insn & (1 << 11))
                 tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, s->condlabel);
             else
@@ -12295,9 +12306,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             break;
         }
         /* generate a conditional jump to next instruction */
-        s->condlabel = gen_new_label();
-        arm_gen_test_cc(cond ^ 1, s->condlabel);
-        s->condjmp = 1;
+        arm_skip_unless(s, cond);
 
         /* jump to the offset */
         val = (uint32_t)s->pc + 2;
@@ -12676,9 +12685,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         uint32_t cond = dc->condexec_cond;
 
         if (cond != 0x0e) {     /* Skip conditional when condition is AL. */
-            dc->condlabel = gen_new_label();
-            arm_gen_test_cc(cond ^ 1, dc->condlabel);
-            dc->condjmp = 1;
+            arm_skip_unless(dc, cond);
         }
     }
 
-- 
2.11.0
