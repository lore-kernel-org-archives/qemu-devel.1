Received: from eggs.gnu.org ([2001:4830:134:3::10]:46226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frm8U-0005a1-Uv
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frm8U-0004AF-9B
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:30:30 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 16:30:19 +0100
Message-Id: <20180820153020.21478-6-peter.maydell@linaro.org>
In-Reply-To: <20180820153020.21478-1-peter.maydell@linaro.org>
References: <20180820153020.21478-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 5/6] target/arm: Clear CPSR.IL and CPSR.J on
 32-bit exception entry
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

On 32-bit exception entry, CPSR.J must always be set to 0
(see v7A Arm ARM DDI0406C.c B1.8.5). CPSR.IL must also
be cleared on 32-bit exception entry (see v8A Arm ARM
DDI0487C.a G1.10).

Clear these bits. (This fixes a bug which will never be noticed
by non-buggy guests.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Not strictly required for Hyp mode, but a minor nit we
can cross off the todo list, and it fits better here
after the refactoring of the exception-exit function.
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 21a2d438944..f548ba17697 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8054,6 +8054,8 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
         env->uncached_cpsr |= CPSR_E;
     }
+    /* J and IL must always be cleared for exception entry */
+    env->uncached_cpsr &= ~(CPSR_IL | CPSR_J);
     env->daif |= mask;
 
     if (new_mode == ARM_CPU_MODE_HYP) {
-- 
2.18.0
