Received: from eggs.gnu.org ([2001:4830:134:3::10]:44155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxS-0003Io-K7
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxR-0004bx-Nb
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fxR-0004as-Gf
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxQ-0000fJ-Ep
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:03:36 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 17:03:32 +0100
Message-Id: <1507824216-29058-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/13] target-arm: Simplify insn_crosses_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Recent changes have left insn_crosses_page() more complicated
than it needed to be:
 * it's only called from thumb_tr_translate_insn() so we know
   for certain that we're looking at a Thumb insn
 * the caller's check for dc->pc >= dc->next_page_start - 3
   means that dc->pc can't possibly be 4 aligned, so there's
   no need to check that (the check was partly there to ensure
   that we didn't treat an ARM insn as Thumb, I think)
 * we now have thumb_insn_is_16bit() which lets us do a precise
   check of the length of the next insn, rather than opencoding
   an inaccurate check

Simplify it down to just loading the first half of the insn
and calling thumb_insn_is_16bit() on it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1507556919-24992-8-git-send-email-peter.maydell@linaro.org
---
 target/arm/translate.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 19c136c..a5abdfa 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11872,29 +11872,14 @@ static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
 {
     /* Return true if the insn at dc->pc might cross a page boundary.
      * (False positives are OK, false negatives are not.)
+     * We know this is a Thumb insn, and our caller ensures we are
+     * only called if dc->pc is less than 4 bytes from the page
+     * boundary, so we cross the page if the first 16 bits indicate
+     * that this is a 32 bit insn.
      */
-    uint16_t insn;
+    uint16_t insn = arm_lduw_code(env, s->pc, s->sctlr_b);
 
-    if ((s->pc & 3) == 0) {
-        /* At a 4-aligned address we can't be crossing a page */
-        return false;
-    }
-
-    /* This must be a Thumb insn */
-    insn = arm_lduw_code(env, s->pc, s->sctlr_b);
-
-    if ((insn >> 11) >= 0x1d) {
-        /* Top five bits 0b11101 / 0b11110 / 0b11111 : this is the
-         * First half of a 32-bit Thumb insn. Thumb-1 cores might
-         * end up actually treating this as two 16-bit insns (see the
-         * code at the start of disas_thumb2_insn()) but we don't bother
-         * to check for that as it is unlikely, and false positives here
-         * are harmless.
-         */
-        return true;
-    }
-    /* Definitely a 16-bit insn, can't be crossing a page. */
-    return false;
+    return !thumb_insn_is_16bit(s, insn);
 }
 
 static int arm_tr_init_disas_context(DisasContextBase *dcbase,
-- 
2.7.4
