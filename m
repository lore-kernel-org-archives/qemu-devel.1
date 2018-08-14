Received: from eggs.gnu.org ([2001:4830:134:3::10]:43617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1fpdT3-0002OF-QY
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1fpdSo-0006g8-NW
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:50:53 -0400
From: Roman Kapl <rka@sysgo.com>
Date: Tue, 14 Aug 2018 18:54:19 +0200
Message-Id: <20180814165419.9116-1-rka@sysgo.com>
Subject: [Qemu-devel] [PATCH] target/arm: crash on conditional instr in it
 block
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

Fix the 'skip on condtion' code to create a new label only if it does not
already exist. Previously multiple labels were created, but only the last one of
them was set.

Signed-off-by: Roman Kapl <rka@sysgo.com>
---
 target/arm/translate.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f845da7c63..f7c03a36e6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8480,6 +8480,16 @@ static void gen_srs(DisasContext *s,
     s->base.is_jmp = DISAS_UPDATE;
 }
 
+/* Skip this instruction if the condition is true */
+static void arm_conditional_skip(DisasContext *s, uint32_t cond)
+{
+    if (!s->condjmp) {
+        s->condlabel = gen_new_label();
+        s->condjmp = 1;
+    }
+    arm_gen_test_cc(cond, s->condlabel);
+}
+
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
     unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
@@ -8709,9 +8719,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     if (cond != 0xe) {
         /* if not always execute, we generate a conditional jump to
            next instruction */
-        s->condlabel = gen_new_label();
-        arm_gen_test_cc(cond ^ 1, s->condlabel);
-        s->condjmp = 1;
+        arm_conditional_skip(s, cond ^ 1);
     }
     if ((insn & 0x0f900000) == 0x03000000) {
         if ((insn & (1 << 21)) == 0) {
@@ -11205,9 +11213,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 /* Conditional branch.  */
                 op = (insn >> 22) & 0xf;
                 /* Generate a conditional jump to next instruction.  */
-                s->condlabel = gen_new_label();
-                arm_gen_test_cc(op ^ 1, s->condlabel);
-                s->condjmp = 1;
+                arm_conditional_skip(s, op ^ 1);
 
                 /* offset[11:1] = insn[10:0] */
                 offset = (insn & 0x7ff) << 1;
@@ -12131,8 +12137,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         case 1: case 3: case 9: case 11: /* czb */
             rm = insn & 7;
             tmp = load_reg(s, rm);
-            s->condlabel = gen_new_label();
-            s->condjmp = 1;
+            if (!s->condjmp) {
+                s->condlabel = gen_new_label();
+                s->condjmp = 1;
+            }
             if (insn & (1 << 11))
                 tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, s->condlabel);
             else
@@ -12295,9 +12303,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             break;
         }
         /* generate a conditional jump to next instruction */
-        s->condlabel = gen_new_label();
-        arm_gen_test_cc(cond ^ 1, s->condlabel);
-        s->condjmp = 1;
+        arm_conditional_skip(s, cond ^ 1);
 
         /* jump to the offset */
         val = (uint32_t)s->pc + 2;
@@ -12676,9 +12682,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         uint32_t cond = dc->condexec_cond;
 
         if (cond != 0x0e) {     /* Skip conditional when condition is AL. */
-            dc->condlabel = gen_new_label();
-            arm_gen_test_cc(cond ^ 1, dc->condlabel);
-            dc->condjmp = 1;
+            arm_conditional_skip(dc, cond ^ 1);
         }
     }
 
-- 
2.11.0
