Received: from eggs.gnu.org ([2001:4830:134:3::10]:49115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlL-00017S-Tk
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlK-0004Dp-R4
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ezRlK-0004DB-Jm
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:02 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlJ-0007ec-H5
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:50:01 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 18:49:51 +0000
Message-Id: <20180323184958.14252-4-peter.maydell@linaro.org>
In-Reply-To: <20180323184958.14252-1-peter.maydell@linaro.org>
References: <20180323184958.14252-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/10] hw/intc/arm_gicv3: Fix secure-GIC NS
 ICC_PMR and ICC_RPR accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If the GIC has the security extension support enabled, then a
non-secure access to ICC_PMR must take account of the non-secure
view of interrupt priorities, where real priorities 0x00..0x7f
are secure-only and not visible to the non-secure guest, and
priorities 0x80..0xff are shown to the guest as if they were
0x00..0xff. We had the logic here wrong:
 * on reads, the priority is in the secure range if bit 7
   is clear, not if it is set
 * on writes, we want to set bit 7, not mask everything else

Our ICC_RPR read code had the same error as ICC_PMR.

(Compare the GICv3 spec pseudocode functions ICC_RPR_EL1
and ICC_PMR_EL1.)

Fixes: https://bugs.launchpad.net/qemu/+bug/1748434
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 20180315133441.24149-1-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_cpuif.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 5cbafaf497..26f5eeda94 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -836,7 +836,7 @@ static uint64_t icc_pmr_read(CPUARMState *env, const ARMCPRegInfo *ri)
         /* NS access and Group 0 is inaccessible to NS: return the
          * NS view of the current priority
          */
-        if (value & 0x80) {
+        if ((value & 0x80) == 0) {
             /* Secure priorities not visible to NS */
             value = 0;
         } else if (value != 0xff) {
@@ -871,7 +871,7 @@ static void icc_pmr_write(CPUARMState *env, const ARMCPRegInfo *ri,
             /* Current PMR in the secure range, don't allow NS to change it */
             return;
         }
-        value = (value >> 1) & 0x80;
+        value = (value >> 1) | 0x80;
     }
     cs->icc_pmr_el1 = value;
     gicv3_cpuif_update(cs);
@@ -1609,7 +1609,7 @@ static uint64_t icc_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     if (arm_feature(env, ARM_FEATURE_EL3) &&
         !arm_is_secure(env) && (env->cp15.scr_el3 & SCR_FIQ)) {
         /* NS GIC access and Group 0 is inaccessible to NS */
-        if (prio & 0x80) {
+        if ((prio & 0x80) == 0) {
             /* NS mustn't see priorities in the Secure half of the range */
             prio = 0;
         } else if (prio != 0xff) {
-- 
2.16.2
