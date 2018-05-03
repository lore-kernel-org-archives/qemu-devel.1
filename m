Received: from eggs.gnu.org ([2001:4830:134:3::10]:53241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEBvi-0004YK-Vr
	for qemu-devel@nongnu.org; Thu, 03 May 2018 06:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEBvh-0004lr-S8
	for qemu-devel@nongnu.org; Thu, 03 May 2018 06:57:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  3 May 2018 11:57:30 +0100
Message-Id: <20180503105730.5958-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Implement v8M VLLDM and VLSTM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-stable@nongnu.org

For v8M the instructions VLLDM and VLSTM support lazy saving
and restoring of the secure floating-point registers. Even
if the floating point extension is not implemented, these
instructions must act as NOPs in Secure state, so they can
be used as part of the secure-to-nonsecure call sequence.

Fixes: https://bugs.launchpad.net/qemu/+bug/1768295
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Worth cc'ing stable on this one because gcc and clang will
emit this insn when calling functions with the cmse_nonsecure_call
attribute.

 target/arm/translate.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9bc2ce1a0b..ad208867a7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10795,8 +10795,23 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         /* Coprocessor.  */
         if (arm_dc_feature(s, ARM_FEATURE_M)) {
             /* We don't currently implement M profile FP support,
-             * so this entire space should give a NOCP fault.
+             * so this entire space should give a NOCP fault, with
+             * the exception of the v8M VLLDM and VLSTM insns, which
+             * must be NOPs in Secure state and UNDEF in Nonsecure state.
              */
+            if (arm_dc_feature(s, ARM_FEATURE_V8) &&
+                (insn & 0xffa00f00) == 0xec200a00) {
+                /* 0b1110_1100_0x1x_xxxx_xxxx_1010_xxxx_xxxx
+                 *  - VLLDM, VLSTM
+                 * We choose to UNDEF if the RAZ bits are non-zero.
+                 */
+                if (!s->v8m_secure || (insn & 0x0040f0ff)) {
+                    goto illegal_op;
+                }
+                /* Just NOP since FP support is not implemented */
+                break;
+            }
+            /* All other insns: NOCP */
             gen_exception_insn(s, 4, EXCP_NOCP, syn_uncategorized(),
                                default_exception_el(s));
             break;
-- 
2.17.0
