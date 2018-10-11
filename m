Received: from eggs.gnu.org ([2001:4830:134:3::10]:48687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gAQZs-0002EG-3Q
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 22:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gAQZp-0004Qf-Bn
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 22:19:50 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 11 Oct 2018 04:19:28 +0200
Message-Id: <20181011021931.4249-10-edgar.iglesias@gmail.com>
In-Reply-To: <20181011021931.4249-1-edgar.iglesias@gmail.com>
References: <20181011021931.4249-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 09/12] target-arm: powerctl: Enable HVC when
 starting CPUs to EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

When QEMU provides the equivalent of the EL3 firmware, we
need to enable HVCs in scr_el3 when turning on CPUs that
target EL2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/arm/arm-powerctl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index ce55eeb682..2b856930fb 100644
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
2.17.1
