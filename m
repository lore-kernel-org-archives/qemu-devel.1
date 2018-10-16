Received: from eggs.gnu.org ([2001:4830:134:3::10]:43306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRD2-0001T8-KF
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRD1-0000oh-PN
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRD1-000803-Du
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCC-0003pb-9U
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:44 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:20 +0100
Message-Id: <20181016152325.31367-15-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/19] target-arm: powerctl: Enable HVC when
 starting CPUs to EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

When QEMU provides the equivalent of the EL3 firmware, we
need to enable HVCs in scr_el3 when turning on CPUs that
target EL2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20181011021931.4249-10-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-powerctl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index ce55eeb682b..2b856930fb7 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -103,6 +103,16 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
     } else {
         /* Processor is not in secure mode */
         target_cpu->env.cp15.scr_el3 |= SCR_NS;
+
+        /*
+         * If QEMU is providing the equivalent of EL3 firmware, then we need
+         * to make sure a CPU targeting EL2 comes out of reset with a
+         * functional HVC insn.
+         */
+        if (arm_feature(&target_cpu->env, ARM_FEATURE_EL3)
+            && info->target_el == 2) {
+            target_cpu->env.cp15.scr_el3 |= SCR_HCE;
+        }
     }
 
     /* We check if the started CPU is now at the correct level */
-- 
2.19.0
