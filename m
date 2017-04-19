Received: from eggs.gnu.org ([2001:4830:134:3::10]:44039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1d0tc7-0008Fd-0e
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1d0tc6-0004QC-64
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:41:59 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Wed, 19 Apr 2017 13:41:19 -0400
Message-Id: <1492623684-25799-9-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1492623684-25799-1-git-send-email-alindsay@codeaurora.org>
References: <1492623684-25799-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH 08/13] target/arm: Split arm_ccnt_enabled into
 generic pmu_counter_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mspradli@codeaurora.org, Aaron Lindsay <alindsay@codeaurora.org>

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/helper.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9c01269..5d07f72 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -975,17 +975,22 @@ static CPAccessResult pmreg_access_ccntr(CPUARMState *env,
     return pmreg_access(env, ri, isread);
 }
 
-static inline bool arm_ccnt_enabled(CPUARMState *env)
+static inline bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
 {
     /* Does not check PMCCFILTR_EL0, which is handled by pmu_counter_filtered */
-
-    if (!(env->cp15.c9_pmcr & PMCRE) || !(env->cp15.c9_pmcnten & (1 << 31))) {
+    if (!(env->cp15.c9_pmcr & PMCRE) ||
+            !(env->cp15.c9_pmcnten & (1 << counter))) {
         return false;
     }
 
     return true;
 }
 
+static inline bool arm_ccnt_enabled(CPUARMState *env)
+{
+    return pmu_counter_enabled(env, 31);
+}
+
 /* Returns true if the counter corresponding to the passed-in pmevtyper or
  * pmccfiltr value is filtered using the current state */
 static inline bool pmu_counter_filtered(CPUARMState *env, uint64_t pmxevtyper)
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
