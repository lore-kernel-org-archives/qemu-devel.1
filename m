Received: from eggs.gnu.org ([209.51.188.92]:34581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr5Cv-0007eA-1n
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr5Ct-00019N-4L
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:12:28 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr5Cr-0000zX-55
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:12:25 -0500
Received: by mail-wm1-x341.google.com with SMTP id m1so4677373wml.2
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:12:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 18:12:18 +0000
Message-Id: <20190205181218.8995-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/arm: Implement HACR_EL2
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

HACR_EL2 is a register with IMPDEF behaviour, which allows
implementation specific trapping to EL2. Implement it as RAZ/WI,
since QEMU's implementation has no extra traps. This also
matches what h/w implementations like Cortex-A53 and A57 do.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d070879894c..f09f815578e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4434,6 +4434,9 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW,
       .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "HACR_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 7,
+      .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "ESR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 2, .opc2 = 0,
       .access = PL2_RW,
@@ -4666,6 +4669,9 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
       .writefn = hcr_writelow },
+    { .name = "HACR_EL2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 7,
+      .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "ELR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
-- 
2.20.1
