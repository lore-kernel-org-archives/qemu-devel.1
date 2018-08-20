Received: from eggs.gnu.org ([2001:4830:134:3::10]:37063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUF-0003qn-3B
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUD-0005Y1-0K
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUC-0005PL-Nl
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUA-00039B-73
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:34 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:31:58 +0100
Message-Id: <20180820103212.2810-12-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/25] target/arm: Implement AArch32 ERET
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ARMv7VE introduced the ERET instruction, which is necessary to
return from an exception taken to Hyp mode. Implement this.
In A32 encoding it is a completely new encoding; in T32 it
is an adjustment of the behaviour of the existing
"SUBS PC, LR, #<imm8>" instruction.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180814124254.5229-10-peter.maydell@linaro.org
---
 target/arm/translate.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8405c08fd1a..bcfc29c5a6a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8901,6 +8901,25 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             tcg_temp_free_i32(tmp2);
             store_reg(s, rd, tmp);
             break;
+        case 0x6: /* ERET */
+            if (op1 != 3) {
+                goto illegal_op;
+            }
+            if (!arm_dc_feature(s, ARM_FEATURE_V7VE)) {
+                goto illegal_op;
+            }
+            if ((insn & 0x000fff0f) != 0x0000000e) {
+                /* UNPREDICTABLE; we choose to UNDEF */
+                goto illegal_op;
+            }
+
+            if (s->current_el == 2) {
+                tmp = load_cpu_field(elr_el[2]);
+            } else {
+                tmp = load_reg(s, 14);
+            }
+            gen_exception_return(s, tmp);
+            break;
         case 7:
         {
             int imm16 = extract32(insn, 0, 4) | (extract32(insn, 8, 12) << 4);
@@ -11158,8 +11177,16 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         if (rn != 14 || rd != 15) {
                             goto illegal_op;
                         }
-                        tmp = load_reg(s, rn);
-                        tcg_gen_subi_i32(tmp, tmp, insn & 0xff);
+                        if (s->current_el == 2) {
+                            /* ERET from Hyp uses ELR_Hyp, not LR */
+                            if (insn & 0xff) {
+                                goto illegal_op;
+                            }
+                            tmp = load_cpu_field(elr_el[2]);
+                        } else {
+                            tmp = load_reg(s, rn);
+                            tcg_gen_subi_i32(tmp, tmp, insn & 0xff);
+                        }
                         gen_exception_return(s, tmp);
                         break;
                     case 6: /* MRS */
-- 
2.18.0
