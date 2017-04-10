Received: from eggs.gnu.org ([2001:4830:134:3::10]:54126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxWol-0001XC-FR
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxWok-00086Q-N6
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:45:07 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 11:39:47 +0100
Message-Id: <1491820793-5348-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1491820793-5348-1-git-send-email-peter.maydell@linaro.org>
References: <1491820793-5348-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/7] arm: Don't implement BXJ on M-profile CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

For M-profile CPUs, the BXJ instruction does not exist at all, and
the encoding should always UNDEF. We were accidentally implementing
it to behave like A-profile BXJ; correct the error.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index e32e38c..fe3f442 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10485,7 +10485,12 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                         }
                         break;
                     case 4: /* bxj */
-                        /* Trivial implementation equivalent to bx.  */
+                        /* Trivial implementation equivalent to bx.
+                         * This instruction doesn't exist at all for M-profile.
+                         */
+                        if (arm_dc_feature(s, ARM_FEATURE_M)) {
+                            goto illegal_op;
+                        }
                         tmp = load_reg(s, rn);
                         gen_bx(s, tmp);
                         break;
-- 
2.7.4
