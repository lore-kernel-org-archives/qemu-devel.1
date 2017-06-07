Received: from eggs.gnu.org ([2001:4830:134:3::10]:40066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dIcty-0007o3-1N
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dIctx-00030w-8D
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:29:42 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  7 Jun 2017 16:29:29 +0100
Message-Id: <1496849369-30282-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] arm_gicv3: Fix ICC_BPR1 reset value when EL3
 not implemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

If EL3 is not implemented (ie only one security state) then the
one and only ICC_BPR1 register behaves like the Non-secure
ICC_BPR1 in an EL3-present configuration. In particular, its
reset value is GIC_MIN_BPR_NS, not GIC_MIN_BPR.

Correct the erroneous reset value; this fixes a problem where
we might hit the assert added in commit a89ff39ee901.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 09d8ba0..5cbafaf 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -2039,11 +2039,7 @@ static void icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     cs->icc_pmr_el1 = 0;
     cs->icc_bpr[GICV3_G0] = GIC_MIN_BPR;
     cs->icc_bpr[GICV3_G1] = GIC_MIN_BPR;
-    if (arm_feature(env, ARM_FEATURE_EL3)) {
-        cs->icc_bpr[GICV3_G1NS] = GIC_MIN_BPR_NS;
-    } else {
-        cs->icc_bpr[GICV3_G1NS] = GIC_MIN_BPR;
-    }
+    cs->icc_bpr[GICV3_G1NS] = GIC_MIN_BPR_NS;
     memset(cs->icc_apr, 0, sizeof(cs->icc_apr));
     memset(cs->icc_igrpen, 0, sizeof(cs->icc_igrpen));
     cs->icc_ctlr_el3 = ICC_CTLR_EL3_NDS | ICC_CTLR_EL3_A3V |
-- 
2.7.4
