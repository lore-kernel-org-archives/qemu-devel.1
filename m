Received: from eggs.gnu.org ([2001:4830:134:3::10]:39955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhfBP-0000CT-0e
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhfBO-0006BS-8k
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:03:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 19:03:37 +0100
Message-Id: <20180723180337.17378-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0?] hw/intc/arm_gicv3: Check correct
 HCR_EL2 bit when routing IRQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

In icc_dir_write() we were incorrectly checking HCR_EL2.FMO
when determining whether IRQ should be routed to EL2; this should
be HCR_EL2.IMO (compare the GICv3 pseudocode ICC_DIR_EL1[]).
Use the correct mask.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Cut-n-paste bug we've had since forever. Linux always sets
FMO and IMO to the same thing, so we haven't noticed this.
Probably should go into 3.0, though...

 hw/intc/arm_gicv3_cpuif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 5c89be1af07..2a60568d82c 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1550,7 +1550,7 @@ static void icc_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * tested in cases where we know !IsSecure is true.
      */
     route_fiq_to_el2 = env->cp15.hcr_el2 & HCR_FMO;
-    route_irq_to_el2 = env->cp15.hcr_el2 & HCR_FMO;
+    route_irq_to_el2 = env->cp15.hcr_el2 & HCR_IMO;
 
     switch (arm_current_el(env)) {
     case 3:
-- 
2.17.1
