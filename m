Received: from eggs.gnu.org ([2001:4830:134:3::10]:47453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0000yD-UE
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPp-0005AU-7l
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:14 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPo-000582-WC
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:13 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPo-0003G4-8P
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:12 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:53 +0000
Message-Id: <1484834995-26826-35-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 34/36] target/arm/psci.c: If EL2 implemented,
 start CPUs in EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The PSCI spec states that a CPU_ON call should cause the new
CPU to be started in the highest implemented Non-secure
exception level. We were incorrectly starting it at the
exception level of the caller, which happens to be correct
if EL2 is not implemented. Implement the correct logic
as described in the PSCI 1.0 spec section 6.4:
 * if EL2 exists and SCR_EL3.HCE is set: start in EL2
 * otherwise start in EL1

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Tested-by: Andrew Jones <drjones@redhat.com>
Message-id: 1483977924-14522-17-git-send-email-peter.maydell@linaro.org
---
 target/arm/psci.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/target/arm/psci.c b/target/arm/psci.c
index 14316eb..64bf82e 100644
--- a/target/arm/psci.c
+++ b/target/arm/psci.c
@@ -148,17 +148,28 @@ void arm_handle_psci_call(ARMCPU *cpu)
     case QEMU_PSCI_0_1_FN_CPU_ON:
     case QEMU_PSCI_0_2_FN_CPU_ON:
     case QEMU_PSCI_0_2_FN64_CPU_ON:
+    {
+        /* The PSCI spec mandates that newly brought up CPUs start
+         * in the highest exception level which exists and is enabled
+         * on the calling CPU. Since the QEMU PSCI implementation is
+         * acting as a "fake EL3" or "fake EL2" firmware, this for us
+         * means that we want to start at the highest NS exception level
+         * that we are providing to the guest.
+         * The execution mode should be that which is currently in use
+         * by the same exception level on the calling CPU.
+         * The CPU should be started with the context_id value
+         * in x0 (if AArch64) or r0 (if AArch32).
+         */
+        int target_el = arm_feature(env, ARM_FEATURE_EL2) ? 2 : 1;
+        bool target_aarch64 = arm_el_is_aa64(env, target_el);
+
         mpidr = param[1];
         entry = param[2];
         context_id = param[3];
-        /*
-         * The PSCI spec mandates that newly brought up CPUs enter the
-         * exception level of the caller in the same execution mode as
-         * the caller, with context_id in x0/r0, respectively.
-         */
-        ret = arm_set_cpu_on(mpidr, entry, context_id, arm_current_el(env),
-                             is_a64(env));
+        ret = arm_set_cpu_on(mpidr, entry, context_id,
+                             target_el, target_aarch64);
         break;
+    }
     case QEMU_PSCI_0_1_FN_CPU_OFF:
     case QEMU_PSCI_0_2_FN_CPU_OFF:
         goto cpu_off;
-- 
2.7.4
