Received: from eggs.gnu.org ([2001:4830:134:3::10]:43604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8z-0008Og-BW
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8y-00084j-BT
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:21 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F8y-0007wI-3K
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:20 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8x-0006xt-3d
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:19 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:41:02 +0100
Message-Id: <1492706470-10921-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/24] arm: Don't implement BXJ on M-profile CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For M-profile CPUs, the BXJ instruction does not exist at all, and
the encoding should always UNDEF. We were accidentally implementing
it to behave like A-profile BXJ; correct the error.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-id: 1491844419-12485-2-git-send-email-peter.maydell@linaro.org
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
