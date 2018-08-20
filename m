Received: from eggs.gnu.org ([2001:4830:134:3::10]:37003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhU6-0003lq-Py
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhU4-0005V5-St
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhU4-0005PL-Ii
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:28 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhTy-00036z-Le
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:22 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:31:53 +0100
Message-Id: <20180820103212.2810-7-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/25] target/arm: Add missing .cp = 15 to
 HMAIR1 and HAMAIR1 regdefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ARMCPRegInfo structs will default to .cp = 15 if they
are ARM_CP_STATE_BOTH, but not if they are ARM_CP_STATE_AA32
(because a coprocessor number of 0 is valid for AArch32).
We forgot to explicitly set .cp = 15 for the HMAIR1 and
HAMAIR1 regdefs, which meant they would UNDEF when the guest
tried to access them under cp15.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180814124254.5229-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3e20467ac6b..a68577a06aa 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3767,14 +3767,14 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
       .access = PL2_RW, .type = ARM_CP_CONST,
       .resetvalue = 0 },
     { .name = "HMAIR1", .state = ARM_CP_STATE_AA32,
-      .opc1 = 4, .crn = 10, .crm = 2, .opc2 = 1,
+      .cp = 15, .opc1 = 4, .crn = 10, .crm = 2, .opc2 = 1,
       .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "AMAIR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 0,
       .access = PL2_RW, .type = ARM_CP_CONST,
       .resetvalue = 0 },
     { .name = "HAMAIR1", .state = ARM_CP_STATE_AA32,
-      .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 1,
+      .cp = 15, .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 1,
       .access = PL2_RW, .type = ARM_CP_CONST,
       .resetvalue = 0 },
     { .name = "AFSR0_EL2", .state = ARM_CP_STATE_BOTH,
@@ -3917,7 +3917,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.mair_el[2]),
       .resetvalue = 0 },
     { .name = "HMAIR1", .state = ARM_CP_STATE_AA32,
-      .opc1 = 4, .crn = 10, .crm = 2, .opc2 = 1,
+      .cp = 15, .opc1 = 4, .crn = 10, .crm = 2, .opc2 = 1,
       .access = PL2_RW, .type = ARM_CP_ALIAS,
       .fieldoffset = offsetofhigh32(CPUARMState, cp15.mair_el[2]) },
     { .name = "AMAIR_EL2", .state = ARM_CP_STATE_BOTH,
@@ -3926,7 +3926,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .resetvalue = 0 },
     /* HAMAIR1 is mapped to AMAIR_EL2[63:32] */
     { .name = "HAMAIR1", .state = ARM_CP_STATE_AA32,
-      .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 1,
+      .cp = 15, .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 1,
       .access = PL2_RW, .type = ARM_CP_CONST,
       .resetvalue = 0 },
     { .name = "AFSR0_EL2", .state = ARM_CP_STATE_BOTH,
-- 
2.18.0
