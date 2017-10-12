Received: from eggs.gnu.org ([2001:4830:134:3::10]:44243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxW-0003Mc-Lh
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxS-0004cV-L9
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fxS-0004as-E7
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:38 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxR-0000fc-3W
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:03:37 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 17:03:33 +0100
Message-Id: <1507824216-29058-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/13] target/arm: Support some Thumb insns
 being always unconditional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A few Thumb instructions are always unconditional even inside an
IT block (as opposed to being UNPREDICTABLE if used inside an
IT block): BKPT, the v8M SG instruction, and the A profile
HLT (debug halt) instruction.

This means we need to suppress the jump-over-instruction-on-condfail
code generation (though the IT state still advances as usual and
subsequent insns in the IT block may be conditional).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1507556919-24992-9-git-send-email-peter.maydell@linaro.org
---
 target/arm/translate.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a5abdfa..6634bad 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12112,6 +12112,52 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
        in init_disas_context by adjusting max_insns.  */
 }
 
+static bool thumb_insn_is_unconditional(DisasContext *s, uint32_t insn)
+{
+    /* Return true if this Thumb insn is always unconditional,
+     * even inside an IT block. This is true of only a very few
+     * instructions: BKPT, HLT, and SG.
+     *
+     * A larger class of instructions are UNPREDICTABLE if used
+     * inside an IT block; we do not need to detect those here, because
+     * what we do by default (perform the cc check and update the IT
+     * bits state machine) is a permitted CONSTRAINED UNPREDICTABLE
+     * choice for those situations.
+     *
+     * insn is either a 16-bit or a 32-bit instruction; the two are
+     * distinguishable because for the 16-bit case the top 16 bits
+     * are zeroes, and that isn't a valid 32-bit encoding.
+     */
+    if ((insn & 0xffffff00) == 0xbe00) {
+        /* BKPT */
+        return true;
+    }
+
+    if ((insn & 0xffffffc0) == 0xba80 && arm_dc_feature(s, ARM_FEATURE_V8) &&
+        !arm_dc_feature(s, ARM_FEATURE_M)) {
+        /* HLT: v8A only. This is unconditional even when it is going to
+         * UNDEF; see the v8A ARM ARM DDI0487B.a H3.3.
+         * For v7 cores this was a plain old undefined encoding and so
+         * honours its cc check. (We might be using the encoding as
+         * a semihosting trap, but we don't change the cc check behaviour
+         * on that account, because a debugger connected to a real v7A
+         * core and emulating semihosting traps by catching the UNDEF
+         * exception would also only see cases where the cc check passed.
+         * No guest code should be trying to do a HLT semihosting trap
+         * in an IT block anyway.
+         */
+        return true;
+    }
+
+    if (insn == 0xe97fe97f && arm_dc_feature(s, ARM_FEATURE_V8) &&
+        arm_dc_feature(s, ARM_FEATURE_M)) {
+        /* SG: v8M only */
+        return true;
+    }
+
+    return false;
+}
+
 static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
@@ -12133,7 +12179,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         dc->pc += 2;
     }
 
-    if (dc->condexec_mask) {
+    if (dc->condexec_mask && !thumb_insn_is_unconditional(dc, insn)) {
         uint32_t cond = dc->condexec_cond;
 
         if (cond != 0x0e) {     /* Skip conditional when condition is AL. */
-- 
2.7.4
