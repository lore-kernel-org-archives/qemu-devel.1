Received: from eggs.gnu.org ([2001:4830:134:3::10]:43785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpYfH-0005VO-UN
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpYfG-0002IO-SB
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:11 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 13:42:50 +0100
Message-Id: <20180814124254.5229-7-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-1-peter.maydell@linaro.org>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 06/10] target/arm: Implement AArch32 Hyp FARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Luc Michel <luc.michel@greensocs.com>, edgari@xilinx.com

The AArch32 virtualization extensions support these fault address
registers:
 * HDFAR: aliased with AArch64 FAR_EL2[31:0] and AArch32 DFAR(S)
 * HIFAR: aliased with AArch64 FAR_EL2[63:32] and AArch32 IFAR(S)

Implement the accessors for these. This fixes in passing a bug
where we weren't implementing the "RES0 from EL3 if EL2 not
implemented" behaviour for AArch64 FAR_EL2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9701e413859..d6e98e9d606 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3847,6 +3847,13 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
     { .name = "HSTR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 3,
       .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "FAR_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 6, .crm = 0, .opc2 = 0,
+      .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "HIFAR", .state = ARM_CP_STATE_AA32,
+      .type = ARM_CP_CONST,
+      .cp = 15, .opc1 = 4, .crn = 6, .crm = 0, .opc2 = 2,
+      .access = PL2_RW, .resetvalue = 0 },
     REGINFO_SENTINEL
 };
 
@@ -3922,9 +3929,14 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "ESR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 2, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.esr_el[2]) },
-    { .name = "FAR_EL2", .state = ARM_CP_STATE_AA64,
+    { .name = "FAR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 6, .crm = 0, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.far_el[2]) },
+    { .name = "HIFAR", .state = ARM_CP_STATE_AA32,
+      .type = ARM_CP_ALIAS,
+      .cp = 15, .opc1 = 4, .crn = 6, .crm = 0, .opc2 = 2,
+      .access = PL2_RW,
+      .fieldoffset = offsetofhigh32(CPUARMState, cp15.far_el[2]) },
     { .name = "SPSR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 0,
-- 
2.18.0
