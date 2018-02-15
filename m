Received: from eggs.gnu.org ([2001:4830:134:3::10]:33552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOCp-0005gj-Fc
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOCo-0007t6-GB
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:24:27 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:24:21 +0000
Message-Id: <20180215182421.23788-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Fix register definitions for VMIDR
 and VMPIDR
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

The register definitions for VMIDR and VMPIDR have separate
reginfo structs for the AArch32 and AArch64 registers. However
the 32-bit versions are wrong:
 * they use offsetof instead of offsetoflow32 to mark where
   the 32-bit value lives in the uint64_t CPU state field
 * they don't mark themselves as ARM_CP_ALIAS

In particular this means that if you try to use an Arm guest CPU
which enables EL2 on a big-endian host it will assert at reset:
 target/arm/cpu.c:114: cp_reg_check_reset: Assertion `oldvalue == newvalue' failed.

because the reset of the 32-bit register writes to the top
half of the uint64_t.

Correct the errors in the structures.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is necessary for 'make check' to pass on big endian
systems with the 'raspi3' board enabled, which is the
first board which has an EL2-enabled-by-default CPU.
---
 target/arm/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e7586fcf6c..e27957df38 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5068,8 +5068,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "VPIDR", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 0,
               .access = PL2_RW, .accessfn = access_el3_aa32ns,
-              .resetvalue = cpu->midr,
-              .fieldoffset = offsetof(CPUARMState, cp15.vpidr_el2) },
+              .resetvalue = cpu->midr, .type = ARM_CP_ALIAS,
+              .fieldoffset = offsetoflow32(CPUARMState, cp15.vpidr_el2) },
             { .name = "VPIDR_EL2", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 0,
               .access = PL2_RW, .resetvalue = cpu->midr,
@@ -5077,8 +5077,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "VMPIDR", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 5,
               .access = PL2_RW, .accessfn = access_el3_aa32ns,
-              .resetvalue = vmpidr_def,
-              .fieldoffset = offsetof(CPUARMState, cp15.vmpidr_el2) },
+              .resetvalue = vmpidr_def, .type = ARM_CP_ALIAS,
+              .fieldoffset = offsetoflow32(CPUARMState, cp15.vmpidr_el2) },
             { .name = "VMPIDR_EL2", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 5,
               .access = PL2_RW,
-- 
2.16.1
