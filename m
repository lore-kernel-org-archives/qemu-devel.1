Received: from eggs.gnu.org ([209.51.188.92]:43465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVby-0003JU-08
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbr-0007mR-WC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:09 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbr-0007lN-Pd
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:03 -0500
Received: by mail-wr1-x434.google.com with SMTP id r10so15383561wrs.10
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:59:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.59.01 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:59:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:58:03 +0000
Message-Id: <20190118145805.6852-48-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 47/49] target/arm: PMU: Set PMCR.N to 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <aaron@os.amperecomputing.com>

This both advertises that we support four counters and enables them
because the pmu_num_counters() reads this value from PMCR.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20181211151945.29137-13-aaron@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 35c105a8618..44f1340ee13 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1777,7 +1777,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .access = PL1_W, .type = ARM_CP_NOP },
     /* Performance monitors are implementation defined in v7,
      * but with an ARM recommended set of registers, which we
-     * follow (although we don't actually implement any counters)
+     * follow.
      *
      * Performance registers fall into three categories:
      *  (a) always UNDEF in PL0, RW in PL1 (PMINTENSET, PMINTENCLR)
@@ -5671,10 +5671,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
     if (arm_feature(env, ARM_FEATURE_V7)) {
         /* v7 performance monitor control register: same implementor
-         * field as main ID register, and we implement only the cycle
-         * count register.
+         * field as main ID register, and we implement four counters in
+         * addition to the cycle count register.
          */
-        unsigned int i, pmcrn = 0;
+        unsigned int i, pmcrn = 4;
         ARMCPRegInfo pmcr = {
             .name = "PMCR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 0,
             .access = PL0_RW,
@@ -5689,7 +5689,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .access = PL0_RW, .accessfn = pmreg_access,
             .type = ARM_CP_IO,
             .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
-            .resetvalue = cpu->midr & 0xff000000,
+            .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT),
             .writefn = pmcr_write, .raw_writefn = raw_write,
         };
         define_one_arm_cp_reg(cpu, &pmcr);
-- 
2.20.1
