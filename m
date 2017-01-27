Received: from eggs.gnu.org ([2001:4830:134:3::10]:59569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vq-00011N-5i
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vp-00056S-EZ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:30 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vp-00055y-87
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:29 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vo-0003Sa-C1
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:28 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:32:16 +0000
Message-Id: <1485531137-2362-22-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/22] arm_gicv3: Fix broken logic in ELRSR
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix a broken expression in the calculation of ELRSR
register bits: instead of "(lr & ICH_LR_EL2_HW) == 1"
we want to check for != 0, because the HW bit is not
bit 0 so a test for == 1 is always false.

Fixes: https://bugs.launchpad.net/bugs/1658506

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 1485255993-6322-1-git-send-email-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_cpuif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index a9ee7fd..c25ee03 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -2430,7 +2430,7 @@ static uint64_t ich_elrsr_read(CPUARMState *env, const ARMCPRegInfo *ri)
         uint64_t lr = cs->ich_lr_el2[i];
 
         if ((lr & ICH_LR_EL2_STATE_MASK) == 0 &&
-            ((lr & ICH_LR_EL2_HW) == 1 || (lr & ICH_LR_EL2_EOI) == 0)) {
+            ((lr & ICH_LR_EL2_HW) != 0 || (lr & ICH_LR_EL2_EOI) == 0)) {
             value |= (1 << i);
         }
     }
-- 
2.7.4
