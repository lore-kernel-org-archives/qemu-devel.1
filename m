Received: from eggs.gnu.org ([2001:4830:134:3::10]:56297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJD0-000836-R3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCy-0002Bg-91
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:50 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:03:57 -0500
Message-Id: <20181213050453.9677-18-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 17/73] arm: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

Cc: Andrzej Zaborowski <balrogg@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/arm/omap1.c            | 4 ++--
 hw/arm/pxa2xx_gpio.c      | 2 +-
 hw/arm/pxa2xx_pic.c       | 2 +-
 target/arm/arm-powerctl.c | 4 ++--
 target/arm/cpu.c          | 2 +-
 target/arm/op_helper.c    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 539d29ef9c..55a7672976 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -1769,7 +1769,7 @@ static uint64_t omap_clkdsp_read(void *opaque, hwaddr addr,
     case 0x18:	/* DSP_SYSST */
         cpu = CPU(s->cpu);
         return (s->clkm.clocking_scheme << 11) | s->clkm.cold_start |
-                (cpu->halted << 6);      /* Quite useless... */
+                (cpu_halted(cpu) << 6);      /* Quite useless... */
     }
 
     OMAP_BAD_REG(addr);
@@ -3790,7 +3790,7 @@ void omap_mpu_wakeup(void *opaque, int irq, int req)
     struct omap_mpu_state_s *mpu = (struct omap_mpu_state_s *) opaque;
     CPUState *cpu = CPU(mpu->cpu);
 
-    if (cpu->halted) {
+    if (cpu_halted(cpu)) {
         cpu_interrupt(cpu, CPU_INTERRUPT_EXITTB);
     }
 }
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index e15070188e..5c3fea42e9 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -128,7 +128,7 @@ static void pxa2xx_gpio_set(void *opaque, int line, int level)
         pxa2xx_gpio_irq_update(s);
 
     /* Wake-up GPIOs */
-    if (cpu->halted && (mask & ~s->dir[bank] & pxa2xx_gpio_wake[bank])) {
+    if (cpu_halted(cpu) && (mask & ~s->dir[bank] & pxa2xx_gpio_wake[bank])) {
         cpu_interrupt(cpu, CPU_INTERRUPT_EXITTB);
     }
 }
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 61275fa040..46ab4c3fc2 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -58,7 +58,7 @@ static void pxa2xx_pic_update(void *opaque)
     PXA2xxPICState *s = (PXA2xxPICState *) opaque;
     CPUState *cpu = CPU(s->cpu);
 
-    if (cpu->halted) {
+    if (cpu_halted(cpu)) {
         mask[0] = s->int_pending[0] & (s->int_enabled[0] | s->int_idle);
         mask[1] = s->int_pending[1] & (s->int_enabled[1] | s->int_idle);
         if (mask[0] || mask[1]) {
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 2b856930fb..003bf6c184 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -64,7 +64,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
 
     /* Initialize the cpu we are turning on */
     cpu_reset(target_cpu_state);
-    target_cpu_state->halted = 0;
+    cpu_halted_set(target_cpu_state, 0);
 
     if (info->target_aa64) {
         if ((info->target_el < 3) && arm_feature(&target_cpu->env,
@@ -238,7 +238,7 @@ static void arm_set_cpu_off_async_work(CPUState *target_cpu_state,
 
     assert(qemu_mutex_iothread_locked());
     target_cpu->power_state = PSCI_OFF;
-    target_cpu_state->halted = 1;
+    cpu_halted_set(target_cpu_state, 1);
     target_cpu_state->exception_index = EXCP_HLT;
 }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 60411f6bfe..8baa5bb891 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -149,7 +149,7 @@ static void arm_cpu_reset(CPUState *s)
     env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.mvfr2;
 
     cpu->power_state = cpu->start_powered_off ? PSCI_OFF : PSCI_ON;
-    s->halted = cpu->start_powered_off;
+    cpu_halted_set(s, cpu->start_powered_off);
 
     if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
         env->iwmmxt.cregs[ARM_IWMMXT_wCID] = 0x69051000 | 'Q';
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 0d6e89e474..4c8c7204d4 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -465,7 +465,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
     }
 
     cs->exception_index = EXCP_HLT;
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cpu_loop_exit(cs);
 }
 
-- 
2.17.1
