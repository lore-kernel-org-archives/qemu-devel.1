Received: from eggs.gnu.org ([2001:4830:134:3::10]:43809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpYfI-0005W6-Jh
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpYfH-0002Jg-KL
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:12 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 13:42:51 +0100
Message-Id: <20180814124254.5229-8-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-1-peter.maydell@linaro.org>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 07/10] target/arm: Implement ESR_EL2/HSR for
 AArch32 and no-EL2
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

The AArch32 HSR is the equivalent of AArch64 ESR_EL2;
we can implement it by marking our existing ESR_EL2 regdef
as STATE_BOTH. It also needs to be "RES0 from EL3 if
EL2 not implemented", so add the missing stanza to
el3_no_el2_cp_reginfo.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d6e98e9d606..80855302089 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3763,6 +3763,10 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
       .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 4,
       .access = PL2_RW,
       .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "ESR_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 2, .opc2 = 0,
+      .access = PL2_RW,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "CPTR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 2,
       .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
@@ -3926,7 +3930,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
       .access = PL2_RW,
       .fieldoffset = offsetof(CPUARMState, elr_el[2]) },
-    { .name = "ESR_EL2", .state = ARM_CP_STATE_AA64,
+    { .name = "ESR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 2, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.esr_el[2]) },
     { .name = "FAR_EL2", .state = ARM_CP_STATE_BOTH,
-- 
2.18.0
