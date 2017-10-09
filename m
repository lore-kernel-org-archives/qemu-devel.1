Received: from eggs.gnu.org ([2001:4830:134:3::10]:43444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e1YQP-0001Ij-W4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e1YQO-00047G-Bg
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:48:53 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Oct 2017 14:48:37 +0100
Message-Id: <1507556919-24992-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 7/9] target-arm: Simplify insn_crosses_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

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
---
 target/arm/translate.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8d3203e..5838e67 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11875,29 +11875,14 @@ static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
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
