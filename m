Received: from eggs.gnu.org ([2001:4830:134:3::10]:48806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1g7iqC-0002A4-29
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1g7iq9-0006UC-4V
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:13:32 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed,  3 Oct 2018 22:07:43 +0700
Message-Id: <1538579266-8389-10-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 09/12] target-arm: powerctl: Enable HVC when
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

When QEMU provides the equivalent of the EL3 firmware, we
need to enable HVCs in scr_el3 when turning on CPUs that
target EL2.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/arm/arm-powerctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index ce55eeb..54f2974 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -63,6 +63,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
     struct CpuOnInfo *info = (struct CpuOnInfo *) data.host_ptr;
 
     /* Initialize the cpu we are turning on */
+    qemu_log("CPU%d reset\n", target_cpu_state->cpu_index);
     cpu_reset(target_cpu_state);
     target_cpu_state->halted = 0;
 
@@ -103,6 +104,16 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
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
2.7.4
