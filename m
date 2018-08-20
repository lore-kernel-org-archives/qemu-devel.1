Received: from eggs.gnu.org ([2001:4830:134:3::10]:46282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frm8X-0005dE-H5
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frm8W-0004DE-V6
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:30:33 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 16:30:15 +0100
Message-Id: <20180820153020.21478-2-peter.maydell@linaro.org>
In-Reply-To: <20180820153020.21478-1-peter.maydell@linaro.org>
References: <20180820153020.21478-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/6] target/arm: Implement RAZ/WI HACTLR2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Luc Michel <luc.michel@greensocs.com>

The v8 AArch32 HACTLR2 register maps to bits [63:32] of ACTLR_EL2.
We implement ACTLR_EL2 as RAZ/WI, so make HACTLR2 also RAZ/WI.
(We put the regdef next to ACTLR_EL2 as a reminder in case we
ever make ACTLR_EL2 something other than RAZ/WI).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
changes from v1: only define in ARMv8, not v7
---
 target/arm/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c9bce1efcb2..22547d8e739 100644
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
