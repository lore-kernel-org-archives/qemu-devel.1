Received: from eggs.gnu.org ([2001:4830:134:3::10]:35457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tn-0007DX-Se
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tm-0003ew-Mx
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:07 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Tm-0003ZB-D4
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:06 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tl-0006SU-Bm
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:07 +0100
Message-Id: <20180824093343.11346-17-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 16/52] target/arm: Implement support for taking
 exceptions to Hyp mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Implement the necessary support code for taking exceptions
to Hyp mode in AArch32.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180820153020.21478-5-peter.maydell@linaro.org
---
 target/arm/helper.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b47657c31b2..10f40b01700 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8073,6 +8073,83 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     env->regs[15] = newpc;
 }
 
+static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
+{
+    /*
+     * Handle exception entry to Hyp mode; this is sufficiently
+     * different to entry to other AArch32 modes that we handle it
+     * separately here.
+     *
+     * The vector table entry used is always the 0x14 Hyp mode entry point,
+     * unless this is an UNDEF/HVC/abort taken from Hyp to Hyp.
+     * The offset applied to the preferred return address is always zero
+     * (see DDI0487C.a section G1.12.3).
+     * PSTATE A/I/F masks are set based only on the SCR.EA/IRQ/FIQ values.
+     */
+    uint32_t addr, mask;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    switch (cs->exception_index) {
+    case EXCP_UDEF:
+        addr = 0x04;
+        break;
+    case EXCP_SWI:
+        addr = 0x14;
+        break;
+    case EXCP_BKPT:
+        /* Fall through to prefetch abort.  */
+    case EXCP_PREFETCH_ABORT:
+        env->cp15.ifar_s = env->exception.vaddress;
+        qemu_log_mask(CPU_LOG_INT, "...with HIFAR 0x%x\n",
+                      (uint32_t)env->exception.vaddress);
+        addr = 0x0c;
+        break;
+    case EXCP_DATA_ABORT:
+        env->cp15.dfar_s = env->exception.vaddress;
+        qemu_log_mask(CPU_LOG_INT, "...with HDFAR 0x%x\n",
+                      (uint32_t)env->exception.vaddress);
+        addr = 0x10;
+        break;
+    case EXCP_IRQ:
+        addr = 0x18;
+        break;
+    case EXCP_FIQ:
+        addr = 0x1c;
+        break;
+    case EXCP_HVC:
+        addr = 0x08;
+        break;
+    case EXCP_HYP_TRAP:
+        addr = 0x14;
+    default:
+        cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
+    }
+
+    if (cs->exception_index != EXCP_IRQ && cs->exception_index != EXCP_FIQ) {
+        env->cp15.esr_el[2] = env->exception.syndrome;
+    }
+
+    if (arm_current_el(env) != 2 && addr < 0x14) {
+        addr = 0x14;
+    }
+
+    mask = 0;
+    if (!(env->cp15.scr_el3 & SCR_EA)) {
+        mask |= CPSR_A;
+    }
+    if (!(env->cp15.scr_el3 & SCR_IRQ)) {
+        mask |= CPSR_I;
+    }
+    if (!(env->cp15.scr_el3 & SCR_FIQ)) {
+        mask |= CPSR_F;
+    }
+
+    addr += env->cp15.hvbar;
+
+    take_aarch32_exception(env, ARM_CPU_MODE_HYP, mask, 0, addr);
+}
+
 static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -8108,6 +8185,11 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
         env->cp15.mdscr_el1 = deposit64(env->cp15.mdscr_el1, 2, 4, moe);
     }
 
+    if (env->exception.target_el == 2) {
+        arm_cpu_do_interrupt_aarch32_hyp(cs);
+        return;
+    }
+
     /* TODO: Vectored interrupt controller.  */
     switch (cs->exception_index) {
     case EXCP_UDEF:
-- 
2.18.0
