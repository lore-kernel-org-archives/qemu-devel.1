Received: from eggs.gnu.org ([209.51.188.92]:53747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKo-0007hg-2N
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKn-0004cg-8k
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:10 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:32812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMKn-0004cA-1O
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:09 -0500
Received: by mail-wr1-x42a.google.com with SMTP id i12so7757166wrw.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:38 +0000
Message-Id: <20190214190603.25030-3-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/27] target/arm: Implement HACR_EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

HACR_EL2 is a register with IMPDEF behaviour, which allows
implementation specific trapping to EL2. Implement it as RAZ/WI,
since QEMU's implementation has no extra traps. This also
matches what h/w implementations like Cortex-A53 and A57 do.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190205181218.8995-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index bd9f6050eca..e1ef2f35237 100644
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
