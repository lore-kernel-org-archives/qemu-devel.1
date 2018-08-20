Received: from eggs.gnu.org ([2001:4830:134:3::10]:37145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUI-0003tn-MB
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUH-0005ap-Ly
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUH-0005YR-9E
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:41 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhTt-00034c-40
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:17 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:31:48 +0100
Message-Id: <20180820103212.2810-2-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/25] target/arm: Fix crash on conditional
 instruction in an IT block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Roman Kapl <rka@sysgo.com>

If an instruction is conditional (like CBZ) and it is executed
conditionally (using the ITx instruction), a jump to an undefined
label is generated, and QEMU crashes.

CBZ in IT block is an UNPREDICTABLE behavior, but we should not
crash.  Honouring the condition code is allowed by the spec in this
case (constrained unpredictable, ARMv8, section K1.1.7), and matches
what we do for other "UNPREDICTABLE inside an IT block" instructions.

Fix the 'skip on condition' code to create a new label only if it
does not already exist.  Previously multiple labels were created, but
only the last one of them was set.

Signed-off-by: Roman Kapl <rka@sysgo.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180816120533.6587-1-rka@sysgo.com
[PMM: fixed ^ 1 being applied to wrong argument, fixed typo]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f845da7c638..14aa2cd3cd5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8480,6 +8480,22 @@ static void gen_srs(DisasContext *s,
     s->base.is_jmp = DISAS_UPDATE;
 }
 
+/* Generate a label used for skipping this instruction */
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
+    arm_gen_test_cc(cond ^ 1, s->condlabel);
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
2.18.0
