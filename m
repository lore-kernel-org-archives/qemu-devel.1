Received: from eggs.gnu.org ([2001:4830:134:3::10]:34810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7Neb-0006dc-Ri
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7Neb-00055r-1B
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:09 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  2 Oct 2018 17:35:48 +0100
Message-Id: <20181002163556.10279-6-peter.maydell@linaro.org>
In-Reply-To: <20181002163556.10279-1-peter.maydell@linaro.org>
References: <20181002163556.10279-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/13] target/arm: Add some comments in Thumb
 decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Add some comments to the Thumb decoder indicating what bits
of the instruction have been decoded at various points in
the code.

This is not an exhaustive set of comments; we're gradually
adding comments as we work with particular bits of the code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Specifically, I figured these out as I was going through looking
for the insns which write SP. These comments turn out not to
be relevant to those instructions, but I don't want to throw
them away.
---
 target/arm/translate.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 25a8fe672f5..fcb33b8a503 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10623,6 +10623,10 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             tmp2 = load_reg(s, rm);
             if ((insn & 0x70) != 0)
                 goto illegal_op;
+            /*
+             * 0b1111_1010_0xxx_xxxx_1111_xxxx_0000_xxxx:
+             *  - MOV, MOVS (register-shifted register), flagsetting
+             */
             op = (insn >> 21) & 3;
             logic_cc = (insn & (1 << 20)) != 0;
             gen_arm_shift_reg(tmp, op, tmp2, logic_cc);
@@ -11674,7 +11678,11 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         rd = insn & 7;
         op = (insn >> 11) & 3;
         if (op == 3) {
-            /* add/subtract */
+            /*
+             * 0b0001_1xxx_xxxx_xxxx
+             *  - Add, subtract (three low registers)
+             *  - Add, subtract (two low registers and immediate)
+             */
             rn = (insn >> 3) & 7;
             tmp = load_reg(s, rn);
             if (insn & (1 << 10)) {
@@ -11711,7 +11719,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         }
         break;
     case 2: case 3:
-        /* arithmetic large immediate */
+        /*
+         * 0b001x_xxxx_xxxx_xxxx
+         *  - Add, subtract, compare, move (one low register and immediate)
+         */
         op = (insn >> 11) & 3;
         rd = (insn >> 8) & 0x7;
         if (op == 0) { /* mov */
@@ -11848,7 +11859,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             break;
         }
 
-        /* data processing register */
+        /*
+         * 0b0100_00xx_xxxx_xxxx
+         *  - Data-processing (two low registers)
+         */
         rd = insn & 7;
         rm = (insn >> 3) & 7;
         op = (insn >> 6) & 0xf;
-- 
2.19.0
