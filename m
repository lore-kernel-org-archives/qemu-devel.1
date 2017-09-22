Received: from eggs.gnu.org ([2001:4830:134:3::10]:56094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1dvHzO-0000jR-Ar
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1dvHzK-0007XY-29
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:03:06 -0400
Received: from thoth.sbs.de ([192.35.17.2]:47580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1dvHzJ-0007X2-Nf
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:03:01 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4f243068-aaea-776f-d18f-f9e05e7be9cd@siemens.com>
Date: Fri, 22 Sep 2017 09:02:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] arm: Fix SMC reporting to EL2 when QEMU
 provides PSCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This properly forwards SMC events to EL2 when PSCI is provided by QEMU
itself and, thus, ARM_FEATURE_EL3 is off.

Found and tested with the Jailhouse hypervisor. Solution based on
suggestions by Peter Maydell.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - implemented Peter's suggestions - and it turned out that the
   arm_is_psci_call became indeed obsolete

 target/arm/helper.c    |  9 ++++++++-
 target/arm/op_helper.c | 27 +++++++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fa60040361..539eef0187 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3717,7 +3717,14 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         valid_mask &= ~HCR_HCD;
-    } else {
+    } else if (cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
+        /* Architecturally HCR.TSC is RES0 if EL3 is not implemented.
+         * However, if we're using the SMC PSCI conduit then QEMU is
+         * effectively acting like EL3 firmware and so the guest at
+         * EL2 should retain the ability to prevent EL1 from being
+         * able to make SMC calls into the ersatz firmware, so in
+         * that case HCR.TSC should be read/write.
+         */
         valid_mask &= ~HCR_TSC;
     }
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 2a85666579..26a0a5cf35 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -901,22 +901,29 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
      */
     bool undef = arm_feature(env, ARM_FEATURE_AARCH64) ? smd : smd && !secure;
 
-    if (arm_is_psci_call(cpu, EXCP_SMC)) {
-        /* If PSCI is enabled and this looks like a valid PSCI call then
-         * that overrides the architecturally mandated SMC behaviour.
+    if (!arm_feature(env, ARM_FEATURE_EL3) &&
+        cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
+        /* If we have no EL3 then SMC always UNDEFs and can't be
+         * trapped to EL2. PSCI-via-SMC is a sort of ersatz EL3
+         * firmware within QEMU, and we want an EL2 guest to be able
+         * to forbid its EL1 from making PSCI calls into QEMU's
+         * "firmware" via HCR.TSC, so for these purposes treat
+         * PSCI-via-SMC as implying an EL3.
          */
-        return;
-    }
-
-    if (!arm_feature(env, ARM_FEATURE_EL3)) {
-        /* If we have no EL3 then SMC always UNDEFs */
         undef = true;
     } else if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
-        /* In NS EL1, HCR controlled routing to EL2 has priority over SMD. */
+        /* In NS EL1, HCR controlled routing to EL2 has priority over SMD.
+         * We also want an EL2 guest to be able to forbid its EL1 from
+         * making PSCI calls into QEMU's "firmware" via HCR.TSC.
+         */
         raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
     }
 
-    if (undef) {
+    /* If PSCI is enabled and this looks like a valid PSCI call then
+     * suppress the UNDEF -- we'll catch the SMC exception and
+     * implement the PSCI call behaviour there.
+     */
+    if (undef && !arm_is_psci_call(cpu, EXCP_SMC)) {
         raise_exception(env, EXCP_UDEF, syn_uncategorized(),
                         exception_target_el(env));
     }
-- 
2.12.3
