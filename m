Received: from eggs.gnu.org ([2001:4830:134:3::10]:43516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e1YQS-0001LV-EA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e1YQR-00049n-Ky
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:48:56 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Oct 2017 14:48:39 +0100
Message-Id: <1507556919-24992-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 9/9] target/arm: Implement SG instruction
 corner cases
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

The common situation of the SG instruction is that it is
executed from S&NSC memory by a CPU in NS state. That case
is handled by v7m_handle_execute_nsc(). However the instruction
also has defined behaviour in a couple of other cases:
 * SG instruction in NS memory (behaves as a NOP)
 * SG in S memory but CPU already secure (clears IT bits and
   does nothing else)
 * SG instruction in v8M without Security Extension (NOP)

These can be implemented in translate.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9d16760..3db6d73 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9781,7 +9781,28 @@ static int disas_thumb2_insn(DisasContext *s, uint32_t insn)
              * - load/store doubleword, load/store exclusive, ldacq/strel,
              *   table branch.
              */
-            if (insn & 0x01200000) {
+            if (insn == 0xe97fe97f && arm_dc_feature(s, ARM_FEATURE_M) &&
+                arm_dc_feature(s, ARM_FEATURE_V8)) {
+                /* 0b1110_1001_0111_1111_1110_1001_0111_111
+                 *  - SG (v8M only)
+                 * The bulk of the behaviour for this instruction is implemented
+                 * in v7m_handle_execute_nsc(), which deals with the insn when
+                 * it is executed by a CPU in non-secure state from memory
+                 * which is Secure & NonSecure-Callable.
+                 * Here we only need to handle the remaining cases:
+                 *  * in NS memory (including the "security extension not
+                 *    implemented" case) : NOP
+                 *  * in S memory but CPU already secure (clear IT bits)
+                 * We know that the attribute for the memory this insn is
+                 * in must match the current CPU state, because otherwise
+                 * get_phys_addr_pmsav8 would have generated an exception.
+                 */
+                if (s->v8m_secure) {
+                    /* Like the IT insn, we don't need to generate any code */
+                    s->condexec_cond = 0;
+                    s->condexec_mask = 0;
+                }
+            } else if (insn & 0x01200000) {
                 /* 0b1110_1000_x11x_xxxx_xxxx_xxxx_xxxx_xxxx
                  *  - load/store dual (post-indexed)
                  * 0b1111_1001_x10x_xxxx_xxxx_xxxx_xxxx_xxxx
-- 
2.7.4
