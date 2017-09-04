Received: from eggs.gnu.org ([2001:4830:134:3::10]:52159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS7-0004mx-Mw
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS2-0004ad-3B
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:07 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqS1-0004RY-PM
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:01 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqRx-0005Qd-4H
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:25:57 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:35 +0100
Message-Id: <1504527967-29248-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/36] target/arm: Tighten up Thumb decode where
 new v8M insns will be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Tighten up the T32 decoder in the places where new v8M instructions
will be:
 * TT/TTT/TTA/TTAT are in what was nominally LDREX/STREX r15, ...
   which is UNPREDICTABLE:
   make the UNPREDICTABLE behaviour be to UNDEF
 * BXNS/BLXNS are distinguished from BX/BLX via the low 3 bits,
   which in previous architectural versions are SBZ:
   enforce the SBZ via UNDEF rather than ignoring it, and move
   the "ARCH(5)" UNDEF case up so we don't leak a TCG temporary
 * SG is in the encoding which would be LDRD/STRD with rn = r15;
   this is UNPREDICTABLE and we currently UNDEF:
   move this check further up the code so that we don't leak
   TCG temporaries in the UNDEF case and have a better place
   to put the SG decode.

This means that if a v8M binary is accidentally run on v7M
or if a test case hits something that we haven't implemented
yet the behaviour will be obvious (UNDEF) rather than obscure
(plough on treating it as a different instruction).

In the process, add some comments about the instruction patterns
at these points in the decode. Our Thumb and ARM decoders are
very difficult to understand currently, but gradually adding
comments like this should help to clarify what exactly has
been decoded when.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-5-git-send-email-peter.maydell@linaro.org
---
 target/arm/translate.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d1a5f56..3c14cb0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9735,10 +9735,23 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
         abort();
     case 4:
         if (insn & (1 << 22)) {
-            /* Other load/store, table branch.  */
+            /* 0b1110_100x_x1xx_xxxx_xxxx_xxxx_xxxx_xxxx
+             * - load/store doubleword, load/store exclusive, ldacq/strel,
+             *   table branch.
+             */
             if (insn & 0x01200000) {
-                /* Load/store doubleword.  */
+                /* 0b1110_1000_x11x_xxxx_xxxx_xxxx_xxxx_xxxx
+                 *  - load/store dual (post-indexed)
+                 * 0b1111_1001_x10x_xxxx_xxxx_xxxx_xxxx_xxxx
+                 *  - load/store dual (literal and immediate)
+                 * 0b1111_1001_x11x_xxxx_xxxx_xxxx_xxxx_xxxx
+                 *  - load/store dual (pre-indexed)
+                 */
                 if (rn == 15) {
+                    if (insn & (1 << 21)) {
+                        /* UNPREDICTABLE */
+                        goto illegal_op;
+                    }
                     addr = tcg_temp_new_i32();
                     tcg_gen_movi_i32(addr, s->pc & ~3);
                 } else {
@@ -9772,15 +9785,18 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                 }
                 if (insn & (1 << 21)) {
                     /* Base writeback.  */
-                    if (rn == 15)
-                        goto illegal_op;
                     tcg_gen_addi_i32(addr, addr, offset - 4);
                     store_reg(s, rn, addr);
                 } else {
                     tcg_temp_free_i32(addr);
                 }
             } else if ((insn & (1 << 23)) == 0) {
-                /* Load/store exclusive word.  */
+                /* 0b1110_1000_010x_xxxx_xxxx_xxxx_xxxx_xxxx
+                 * - load/store exclusive word
+                 */
+                if (rs == 15) {
+                    goto illegal_op;
+                }
                 addr = tcg_temp_local_new_i32();
                 load_reg_var(s, addr, rn);
                 tcg_gen_addi_i32(addr, addr, (insn & 0xff) << 2);
@@ -11137,7 +11153,9 @@ static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
             break;
         }
         if (insn & (1 << 10)) {
-            /* data processing extended or blx */
+            /* 0b0100_01xx_xxxx_xxxx
+             * - data processing extended, branch and exchange
+             */
             rd = (insn & 7) | ((insn >> 4) & 8);
             rm = (insn >> 3) & 0xf;
             op = (insn >> 8) & 3;
@@ -11160,10 +11178,21 @@ static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
                 tmp = load_reg(s, rm);
                 store_reg(s, rd, tmp);
                 break;
-            case 3:/* branch [and link] exchange thumb register */
-                tmp = load_reg(s, rm);
-                if (insn & (1 << 7)) {
+            case 3:
+            {
+                /* 0b0100_0111_xxxx_xxxx
+                 * - branch [and link] exchange thumb register
+                 */
+                bool link = insn & (1 << 7);
+
+                if (insn & 7) {
+                    goto undef;
+                }
+                if (link) {
                     ARCH(5);
+                }
+                tmp = load_reg(s, rm);
+                if (link) {
                     val = (uint32_t)s->pc | 1;
                     tmp2 = tcg_temp_new_i32();
                     tcg_gen_movi_i32(tmp2, val);
@@ -11175,6 +11204,7 @@ static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
                 }
                 break;
             }
+            }
             break;
         }
 
-- 
2.7.4
