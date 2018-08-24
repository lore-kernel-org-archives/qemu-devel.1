Received: from eggs.gnu.org ([2001:4830:134:3::10]:35404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tk-0007AT-PZ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tj-0003Uu-K8
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Tj-0003Sa-CI
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:03 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Ti-0006RA-FA
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:02 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:04 +0100
Message-Id: <20180824093343.11346-14-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 13/52] target/arm: Implement RAZ/WI HACTLR2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The v8 AArch32 HACTLR2 register maps to bits [63:32] of ACTLR_EL2.
We implement ACTLR_EL2 as RAZ/WI, so make HACTLR2 also RAZ/WI.
(We put the regdef next to ACTLR_EL2 as a reminder in case we
ever make ACTLR_EL2 something other than RAZ/WI).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180820153020.21478-2-peter.maydell@linaro.org
---
 target/arm/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8eb611542dc..336ce6ffa89 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5459,6 +5459,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             REGINFO_SENTINEL
         };
         define_arm_cp_regs(cpu, auxcr_reginfo);
+        if (arm_feature(env, ARM_FEATURE_V8)) {
+            /* HACTLR2 maps to ACTLR_EL2[63:32] and is not in ARMv7 */
+            ARMCPRegInfo hactlr2_reginfo = {
+                .name = "HACTLR2", .state = ARM_CP_STATE_AA32,
+                .cp = 15, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 3,
+                .access = PL2_RW, .type = ARM_CP_CONST,
+                .resetvalue = 0
+            };
+            define_one_arm_cp_reg(cpu, &hactlr2_reginfo);
+        }
     }
 
     if (arm_feature(env, ARM_FEATURE_CBAR)) {
-- 
2.18.0
