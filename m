Received: from eggs.gnu.org ([2001:4830:134:3::10]:37765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gL78n-0001Tg-Ri
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gL78l-0008Ia-Sl
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:48:05 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Nov 2018 13:47:30 +0000
Message-Id: <20181109134731.11605-3-peter.maydell@linaro.org>
In-Reply-To: <20181109134731.11605-1-peter.maydell@linaro.org>
References: <20181109134731.11605-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-v3.1 2/3] target/arm: Track the state of
 our irq lines from the GIC explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Adam Lackorzynski <adam.lackorzynski@kernkonzept.com>

Currently we track the state of the four irq lines from the GIC
only via the cs->interrupt_request or KVM irq state. That means
that we assume that an interrupt is asserted if and only if the
external line is set. This assumption is incorrect for VIRQ
and VFIQ, because the HCR_EL2.{VI,VF} bits allow assertion
of VIRQ and VFIQ separately from the state of the external line.

To handle this, start tracking the state of the external lines
explicitly in a CPU state struct field, as is common practice
for devices.

The complicated part of this is dealing with inbound migration
from an older QEMU which didn't have this state. We assume in
that case that the older QEMU did not implement the HCR_EL2.{VI,VF}
bits as generating interrupts, and so the line state matches
the current state in cs->interrupt_request. (This is not quite
true between commit 8a0fc3a29fc2315325400c7 and its revert, but
that commit is broken and never made it into any released QEMU
version.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     |  3 +++
 target/arm/cpu.c     | 16 ++++++++++++++
 target/arm/machine.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b5eff79f73b..f1913cdad26 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -538,6 +538,9 @@ typedef struct CPUARMState {
         uint64_t esr;
     } serror;
 
+    /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
+    uint32_t irq_line_state;
+
     /* Thumb-2 EE state.  */
     uint32_t teecr;
     uint32_t teehbr;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 784a4c2dfcc..45c16ae90ba 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -449,6 +449,12 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
         [ARM_CPU_VFIQ] = CPU_INTERRUPT_VFIQ
     };
 
+    if (level) {
+        env->irq_line_state |= mask[irq];
+    } else {
+        env->irq_line_state &= ~mask[irq];
+    }
+
     switch (irq) {
     case ARM_CPU_VIRQ:
     case ARM_CPU_VFIQ:
@@ -473,17 +479,27 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
     ARMCPU *cpu = opaque;
     CPUState *cs = CPU(cpu);
     int kvm_irq = KVM_ARM_IRQ_TYPE_CPU << KVM_ARM_IRQ_TYPE_SHIFT;
+    uint32_t linestate_bit;
 
     switch (irq) {
     case ARM_CPU_IRQ:
         kvm_irq |= KVM_ARM_IRQ_CPU_IRQ;
+        linestate_bit = CPU_INTERRUPT_HARD;
         break;
     case ARM_CPU_FIQ:
         kvm_irq |= KVM_ARM_IRQ_CPU_FIQ;
+        linestate_bit = CPU_INTERRUPT_FIQ;
         break;
     default:
         g_assert_not_reached();
     }
+
+    if (level) {
+        env->irq_line_state |= linestate_bit;
+    } else {
+        env->irq_line_state &= ~linestate_bit;
+    }
+
     kvm_irq |= cs->cpu_index << KVM_ARM_IRQ_VCPU_SHIFT;
     kvm_set_irq(kvm_state, kvm_irq, level ? 1 : 0);
 #endif
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 239fe4e84d1..2033816a64e 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -192,6 +192,22 @@ static const VMStateDescription vmstate_serror = {
     }
 };
 
+static bool irq_line_state_needed(void *opaque)
+{
+    return true;
+}
+
+static const VMStateDescription vmstate_irq_line_state = {
+    .name = "cpu/irq-line-state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = irq_line_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.irq_line_state, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool m_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -625,11 +641,44 @@ static int cpu_pre_save(void *opaque)
     return 0;
 }
 
+static int cpu_pre_load(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    /*
+     * Pre-initialize irq_line_state to a value that's never valid as
+     * real data, so cpu_post_load() can tell whether we've seen the
+     * irq-line-state subsection in the incoming migration state.
+     */
+    env->irq_line_state = UINT32_MAX;
+
+    return 0;
+}
+
 static int cpu_post_load(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
     int i, v;
 
+    /*
+     * Handle migration compatibility from old QEMU which didn't
+     * send the irq-line-state subsection. A QEMU without it did not
+     * implement the HCR_EL2.{VI,VF} bits as generating interrupts,
+     * so for TCG the line state matches the bits set in cs->interrupt_request.
+     * For KVM the line state is not stored in cs->interrupt_request
+     * and so this will leave irq_line_state as 0, but this is OK because
+     * we only need to care about it for TCG.
+     */
+    if (env->irq_line_state == UINT32_MAX) {
+        CPUState *cs = CPU(cpu);
+
+        env->irq_line_state = cs->interrupt_request &
+            (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ |
+             CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VFIQ);
+    }
+
     /* Update the values list from the incoming migration data.
      * Anything in the incoming data which we don't know about is
      * a migration failure; anything we know about but the incoming
@@ -680,6 +729,7 @@ const VMStateDescription vmstate_arm_cpu = {
     .version_id = 22,
     .minimum_version_id = 22,
     .pre_save = cpu_pre_save,
+    .pre_load = cpu_pre_load,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(env.regs, ARMCPU, 16),
@@ -747,6 +797,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_sve,
 #endif
         &vmstate_serror,
+        &vmstate_irq_line_state,
         NULL
     }
 };
-- 
2.19.1
