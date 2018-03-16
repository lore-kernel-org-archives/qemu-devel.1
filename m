Received: from eggs.gnu.org ([2001:4830:134:3::10]:44514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1g-00068Q-5J
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1f-0003ep-D0
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:32 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 16 Mar 2018 16:31:15 -0400
Message-Id: <1521232280-13089-18-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v3 17/22] target/arm: Split arm_ccnt_enabled
 into generic pmu_counter_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f5e800e..2073d56 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1009,17 +1009,22 @@ static CPAccessResult pmreg_access_ccntr(CPUARMState *env,
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
