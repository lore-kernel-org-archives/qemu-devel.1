Received: from eggs.gnu.org ([2001:4830:134:3::10]:45318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvk-00026Z-A8
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvj-0006ue-6r
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gOlvi-0006rE-SX
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:43 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvg-00065b-59
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 15:57:40 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 15:57:27 +0000
Message-Id: <20181119155730.11758-8-peter.maydell@linaro.org>
In-Reply-To: <20181119155730.11758-1-peter.maydell@linaro.org>
References: <20181119155730.11758-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/10] target/arm: fix smc incorrectly trapping
 to EL3 when secure is off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc Michel <luc.michel@greensocs.com>

This commit fixes a case where the CPU would try to go to EL3 when
executing an smc instruction, even though ARM_FEATURE_EL3 is false. This
case is raised when the PSCI conduit is set to smc, but the smc
instruction does not lead to a valid PSCI call.

QEMU crashes with an assertion failure latter on because of incoherent
mmu_idx.

This commit refactors the pre_smc helper by enumerating all the possible
way of handling an scm instruction, and covering the previously missing
case leading to the crash.

The following minimal test would crash before this commit:

.global _start
    .text
_start:
    ldr x0, =0xdeadbeef  ; invalid PSCI call
    smc #0

run with the following command line:

aarch64-linux-gnu-gcc -nostdinc -nostdlib -Wl,-Ttext=40000000 \
                      -o test test.s

qemu-system-aarch64 -M virt,virtualization=on,secure=off \
                    -cpu cortex-a57 -kernel test

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20181117160213.18995-1-luc.michel@greensocs.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/op_helper.c | 54 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index eb6fb82fb81..0d6e89e474a 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -939,7 +939,38 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
     ARMCPU *cpu = arm_env_get_cpu(env);
     int cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
-    bool smd = env->cp15.scr_el3 & SCR_SMD;
+    bool smd_flag = env->cp15.scr_el3 & SCR_SMD;
+
+    /*
+     * SMC behaviour is summarized in the following table.
+     * This helper handles the "Trap to EL2" and "Undef insn" cases.
+     * The "Trap to EL3" and "PSCI call" cases are handled in the exception
+     * helper.
+     *
+     *  -> ARM_FEATURE_EL3 and !SMD
+     *                           HCR_TSC && NS EL1   !HCR_TSC || !NS EL1
+     *
+     *  Conduit SMC, valid call  Trap to EL2         PSCI Call
+     *  Conduit SMC, inval call  Trap to EL2         Trap to EL3
+     *  Conduit not SMC          Trap to EL2         Trap to EL3
+     *
+     *
+     *  -> ARM_FEATURE_EL3 and SMD
+     *                           HCR_TSC && NS EL1   !HCR_TSC || !NS EL1
+     *
+     *  Conduit SMC, valid call  Trap to EL2         PSCI Call
+     *  Conduit SMC, inval call  Trap to EL2         Undef insn
+     *  Conduit not SMC          Trap to EL2         Undef insn
+     *
+     *
+     *  -> !ARM_FEATURE_EL3
+     *                           HCR_TSC && NS EL1   !HCR_TSC || !NS EL1
+     *
+     *  Conduit SMC, valid call  Trap to EL2         PSCI Call
+     *  Conduit SMC, inval call  Trap to EL2         Undef insn
+     *  Conduit not SMC          Undef insn          Undef insn
+     */
+
     /* On ARMv8 with EL3 AArch64, SMD applies to both S and NS state.
      * On ARMv8 with EL3 AArch32, or ARMv7 with the Virtualization
      *  extensions, SMD only applies to NS state.
@@ -947,7 +978,8 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
      * doesn't exist, but we forbid the guest to set it to 1 in scr_write(),
      * so we need not special case this here.
      */
-    bool undef = arm_feature(env, ARM_FEATURE_AARCH64) ? smd : smd && !secure;
+    bool smd = arm_feature(env, ARM_FEATURE_AARCH64) ? smd_flag
+                                                     : smd_flag && !secure;
 
     if (!arm_feature(env, ARM_FEATURE_EL3) &&
         cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
@@ -957,21 +989,27 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
          * to forbid its EL1 from making PSCI calls into QEMU's
          * "firmware" via HCR.TSC, so for these purposes treat
          * PSCI-via-SMC as implying an EL3.
+         * This handles the very last line of the previous table.
          */
-        undef = true;
-    } else if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
+        raise_exception(env, EXCP_UDEF, syn_uncategorized(),
+                        exception_target_el(env));
+    }
+
+    if (!secure && cur_el == 1 && (env->cp15.hcr_el2 & HCR_TSC)) {
         /* In NS EL1, HCR controlled routing to EL2 has priority over SMD.
          * We also want an EL2 guest to be able to forbid its EL1 from
          * making PSCI calls into QEMU's "firmware" via HCR.TSC.
+         * This handles all the "Trap to EL2" cases of the previous table.
          */
         raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
     }
 
-    /* If PSCI is enabled and this looks like a valid PSCI call then
-     * suppress the UNDEF -- we'll catch the SMC exception and
-     * implement the PSCI call behaviour there.
+    /* Catch the two remaining "Undef insn" cases of the previous table:
+     *    - PSCI conduit is SMC but we don't have a valid PCSI call,
+     *    - We don't have EL3 or SMD is set.
      */
-    if (undef && !arm_is_psci_call(cpu, EXCP_SMC)) {
+    if (!arm_is_psci_call(cpu, EXCP_SMC) &&
+        (smd || !arm_feature(env, ARM_FEATURE_EL3))) {
         raise_exception(env, EXCP_UDEF, syn_uncategorized(),
                         exception_target_el(env));
     }
-- 
2.19.1
