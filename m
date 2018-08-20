Received: from eggs.gnu.org ([2001:4830:134:3::10]:37035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUC-0003oj-RQ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUA-0005XH-Tg
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhU8-0005WA-VO
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhU7-000385-Bk
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:31 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:31:55 +0100
Message-Id: <20180820103212.2810-9-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/25] target/arm: Implement AArch32 Hyp FARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The AArch32 virtualization extensions support these fault address
registers:
 * HDFAR: aliased with AArch64 FAR_EL2[31:0] and AArch32 DFAR(S)
 * HIFAR: aliased with AArch64 FAR_EL2[63:32] and AArch32 IFAR(S)

Implement the accessors for these. This fixes in passing a bug
where we weren't implementing the "RES0 from EL3 if EL2 not
implemented" behaviour for AArch64 FAR_EL2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180814124254.5229-7-peter.maydell@linaro.org
---
 target/arm/helper.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 274fb219122..bb08bd4e4bf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3843,6 +3843,13 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
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
 
@@ -3891,9 +3898,14 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
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
