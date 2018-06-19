Received: from eggs.gnu.org ([2001:4830:134:3::10]:46708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5j6-0002fP-R2
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5j5-0000Pa-Oi
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:32 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:31 -0500
Message-Id: <20180619014319.28272-66-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 065/113] target/arm: Implement v8M VLLDM and
 VLSTM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

For v8M the instructions VLLDM and VLSTM support lazy saving
and restoring of the secure floating-point registers. Even
if the floating point extension is not implemented, these
instructions must act as NOPs in Secure state, so they can
be used as part of the secure-to-nonsecure call sequence.

Fixes: https://bugs.launchpad.net/qemu/+bug/1768295
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180503105730.5958-1-peter.maydell@linaro.org
(cherry picked from commit b1e5336a9899016c53d59eba53ebf6abcc21995c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f120932f44..a8e8168a06 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10511,8 +10511,23 @@ static int disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
2.11.0
