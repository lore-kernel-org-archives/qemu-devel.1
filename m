Received: from eggs.gnu.org ([2001:4830:134:3::10]:52174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhvyx-0008Di-V0
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhvyx-0003A5-7r
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:00:00 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 12:59:46 +0100
Message-Id: <20180724115950.17316-2-peter.maydell@linaro.org>
In-Reply-To: <20180724115950.17316-1-peter.maydell@linaro.org>
References: <20180724115950.17316-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/5] target/arm: Mask virtual interrupts if
 HCR_EL2.TGE is set
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

If the "trap general exceptions" bit HCR_EL2.TGE is set, we
must mask all virtual interrupts (as per DDI0487C.a D1.14.3).
Implement this in arm_excp_unmasked().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e310ffc29d2..efb2a8d3f3d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2261,13 +2261,15 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
         break;
 
     case EXCP_VFIQ:
-        if (secure || !(env->cp15.hcr_el2 & HCR_FMO)) {
+        if (secure || !(env->cp15.hcr_el2 & HCR_FMO)
+            || (env->cp15.hcr_el2 & HCR_TGE)) {
             /* VFIQs are only taken when hypervized and non-secure.  */
             return false;
         }
         return !(env->daif & PSTATE_F);
     case EXCP_VIRQ:
-        if (secure || !(env->cp15.hcr_el2 & HCR_IMO)) {
+        if (secure || !(env->cp15.hcr_el2 & HCR_IMO)
+            || (env->cp15.hcr_el2 & HCR_TGE)) {
             /* VIRQs are only taken when hypervized and non-secure.  */
             return false;
         }
-- 
2.17.1
