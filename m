Received: from eggs.gnu.org ([2001:4830:134:3::10]:60247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1dtqq5-0004S6-6l
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1dtqq2-0002xJ-4M
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:51:33 -0400
Received: from goliath.siemens.de ([192.35.17.28]:50714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1dtqq1-0002wq-PT
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:51:30 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1d61ec4d-da94-e96a-e1f6-509a4e80daec@siemens.com>
Date: Mon, 18 Sep 2017 09:51:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] arm: Fix SMC reporting to EL2 when QEMU
 provides PSCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This properly forwards SMC events to EL2 when PSCI is provided by QEMU
itself and, thus, ARM_FEATURE_EL3 is off.

Found and tested with the Jailhouse hypervisor.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 target/arm/helper.c    | 2 +-
 target/arm/op_helper.c | 8 ++++----
 target/arm/psci.c      | 6 ++++++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4f41841ef6..8c3929762c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3717,7 +3717,7 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         valid_mask &= ~HCR_HCD;
-    } else {
+    } else if (cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
         valid_mask &= ~HCR_TSC;
     }
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 6a60464ab9..4b0ef6a234 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -960,12 +960,12 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
         return;
     }
 
-    if (!arm_feature(env, ARM_FEATURE_EL3)) {
-        /* If we have no EL3 then SMC always UNDEFs */
-        undef = true;
-    } else if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
+    if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
         /* In NS EL1, HCR controlled routing to EL2 has priority over SMD. */
         raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
+    } else if (!arm_feature(env, ARM_FEATURE_EL3)) {
+        /* If we have no EL3 then SMC always UNDEFs */
+        undef = true;
     }
 
     if (undef) {
diff --git a/target/arm/psci.c b/target/arm/psci.c
index fc34b263d3..637987ff46 100644
--- a/target/arm/psci.c
+++ b/target/arm/psci.c
@@ -35,6 +35,8 @@ bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
      */
     CPUARMState *env = &cpu->env;
     uint64_t param = is_a64(env) ? env->xregs[0] : env->regs[0];
+    int cur_el = arm_current_el(env);
+    bool secure = arm_is_secure(env);
 
     switch (excp_type) {
     case EXCP_HVC:
@@ -46,6 +48,10 @@ bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
         if (cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
             return false;
         }
+        if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
+            /* The EL2 will handle this. */
+            return false;
+        }
         break;
     default:
         return false;
-- 
2.12.3
