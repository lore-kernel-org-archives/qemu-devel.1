Received: from eggs.gnu.org ([2001:4830:134:3::10]:40853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dkOfz-0004My-8U
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dkOfx-0003WL-Uf
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:58:03 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1dkOfx-0003Va-MB
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:58:01 -0400
Received: by mail-pf0-x241.google.com with SMTP id k3so721345pfc.2
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 22:58:01 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Wed, 23 Aug 2017 14:57:11 +0900
Message-Id: <9ff134a8c36d63ad667d94cacb5ef490e2227e1e.1503467674.git.shorne@gmail.com>
In-Reply-To: <cover.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
In-Reply-To: <cover.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
Subject: [Qemu-devel] [PATCH 3/5] openrisc/cputimer: Perparation for
 Multicore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Openrisc <openrisc@lists.librecores.org>, Stafford Horne <shorne@gmail.com>

In order to support multicore system we move some of the previously
static state variables into the state of each core.

On the other hand in order to allow timers to be synced between each
code the ttcr (tick timer count register) is moved out of the core.
This is not as per real hardware spec which has a separate timer counter
per core, but it seems the most simple way to keep each clock in sync.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/cputimer.c       | 62 +++++++++++++++++++++++++++++++++-----------
 target/openrisc/cpu.c        |  1 -
 target/openrisc/cpu.h        |  4 ++-
 target/openrisc/machine.c    |  1 -
 target/openrisc/sys_helper.c |  4 +--
 5 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index febc469170..4c5415ff75 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -25,39 +25,56 @@
 
 #define TIMER_PERIOD 50 /* 50 ns period for 20 MHz timer */
 
-/* The time when TTCR changes */
-static uint64_t last_clk;
-static int is_counting;
+/* Tick Timer global state to allow all cores to be in sync */
+typedef struct OR1KTimerState {
+    uint32_t ttcr;
+    uint64_t last_clk;
+} OR1KTimerState;
 
+static OR1KTimerState *or1k_timer;
+
+void cpu_openrisc_count_set(OpenRISCCPU *cpu, uint32_t val)
+{
+    or1k_timer->ttcr = val;
+}
+
+uint32_t cpu_openrisc_count_get(OpenRISCCPU *cpu)
+{
+    return or1k_timer->ttcr;
+}
+
+/* Add elapsed ticks to ttcr */
 void cpu_openrisc_count_update(OpenRISCCPU *cpu)
 {
     uint64_t now;
 
-    if (!is_counting) {
+    if (!cpu->env.is_counting) {
         return;
     }
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    cpu->env.ttcr += (uint32_t)((now - last_clk) / TIMER_PERIOD);
-    last_clk = now;
+    or1k_timer->ttcr += (uint32_t)((now - or1k_timer->last_clk)
+                                    / TIMER_PERIOD);
+    or1k_timer->last_clk = now;
 }
 
+/* Update the next timeout time as difference between ttmr and ttcr */
 void cpu_openrisc_timer_update(OpenRISCCPU *cpu)
 {
     uint32_t wait;
     uint64_t now, next;
 
-    if (!is_counting) {
+    if (!cpu->env.is_counting) {
         return;
     }
 
     cpu_openrisc_count_update(cpu);
-    now = last_clk;
+    now = or1k_timer->last_clk;
 
-    if ((cpu->env.ttmr & TTMR_TP) <= (cpu->env.ttcr & TTMR_TP)) {
-        wait = TTMR_TP - (cpu->env.ttcr & TTMR_TP) + 1;
+    if ((cpu->env.ttmr & TTMR_TP) <= (or1k_timer->ttcr & TTMR_TP)) {
+        wait = TTMR_TP - (or1k_timer->ttcr & TTMR_TP) + 1;
         wait += cpu->env.ttmr & TTMR_TP;
     } else {
-        wait = (cpu->env.ttmr & TTMR_TP) - (cpu->env.ttcr & TTMR_TP);
+        wait = (cpu->env.ttmr & TTMR_TP) - (or1k_timer->ttcr & TTMR_TP);
     }
     next = now + (uint64_t)wait * TIMER_PERIOD;
     timer_mod(cpu->env.timer, next);
@@ -66,7 +83,7 @@ void cpu_openrisc_timer_update(OpenRISCCPU *cpu)
 
 void cpu_openrisc_count_start(OpenRISCCPU *cpu)
 {
-    is_counting = 1;
+    cpu->env.is_counting = 1;
     cpu_openrisc_count_update(cpu);
 }
 
@@ -74,7 +91,7 @@ void cpu_openrisc_count_stop(OpenRISCCPU *cpu)
 {
     timer_del(cpu->env.timer);
     cpu_openrisc_count_update(cpu);
-    is_counting = 0;
+    cpu->env.is_counting = 0;
 }
 
 static void openrisc_timer_cb(void *opaque)
@@ -93,7 +110,7 @@ static void openrisc_timer_cb(void *opaque)
     case TIMER_NONE:
         break;
     case TIMER_INTR:
-        cpu->env.ttcr = 0;
+        or1k_timer->ttcr = 0;
         break;
     case TIMER_SHOT:
         cpu_openrisc_count_stop(cpu);
@@ -105,9 +122,24 @@ static void openrisc_timer_cb(void *opaque)
     cpu_openrisc_timer_update(cpu);
 }
 
+static const VMStateDescription vmstate_or1k_timer = {
+    .name = "or1k_timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ttcr, OR1KTimerState),
+        VMSTATE_UINT64(last_clk, OR1KTimerState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 void cpu_openrisc_clock_init(OpenRISCCPU *cpu)
 {
     cpu->env.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &openrisc_timer_cb, cpu);
     cpu->env.ttmr = 0x00000000;
-    cpu->env.ttcr = 0x00000000;
+
+    if (or1k_timer == NULL) {
+        or1k_timer = g_new0(OR1KTimerState, 1);
+        vmstate_register(NULL, 0, &vmstate_or1k_timer, or1k_timer);
+    }
 }
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 1d6330cbcc..0a46684987 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -61,7 +61,6 @@ static void openrisc_cpu_reset(CPUState *s)
     cpu->env.picsr = 0x00000000;
 
     cpu->env.ttmr = 0x00000000;
-    cpu->env.ttcr = 0x00000000;
 #endif
 }
 
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 4a61e5abfc..265f48ca43 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -315,7 +315,7 @@ typedef struct CPUOpenRISCState {
 
     QEMUTimer *timer;
     uint32_t ttmr;          /* Timer tick mode register */
-    uint32_t ttcr;          /* Timer tick count register */
+    int is_counting;
 
     uint32_t picmr;         /* Interrupt mask register */
     uint32_t picsr;         /* Interrupt contrl register*/
@@ -376,6 +376,8 @@ void cpu_openrisc_pic_init(OpenRISCCPU *cpu);
 
 /* hw/openrisc_timer.c */
 void cpu_openrisc_clock_init(OpenRISCCPU *cpu);
+uint32_t cpu_openrisc_count_get(OpenRISCCPU *cpu);
+void cpu_openrisc_count_set(OpenRISCCPU *cpu, uint32_t val);
 void cpu_openrisc_count_update(OpenRISCCPU *cpu);
 void cpu_openrisc_timer_update(OpenRISCCPU *cpu);
 void cpu_openrisc_count_start(OpenRISCCPU *cpu);
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index a879b2b539..c6a945f0df 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -147,7 +147,6 @@ static const VMStateDescription vmstate_env = {
 
         VMSTATE_TIMER_PTR(timer, CPUOpenRISCState),
         VMSTATE_UINT32(ttmr, CPUOpenRISCState),
-        VMSTATE_UINT32(ttcr, CPUOpenRISCState),
 
         VMSTATE_UINT32(picmr, CPUOpenRISCState),
         VMSTATE_UINT32(picsr, CPUOpenRISCState),
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index e138bcf9db..35be44beff 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -188,7 +188,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
         break;
 
     case TO_SPR(10, 1): /* TTCR */
-        env->ttcr = rb;
+        cpu_openrisc_count_set(cpu, rb);
         if (env->ttmr & TIMER_NONE) {
             return;
         }
@@ -311,7 +311,7 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
 
     case TO_SPR(10, 1): /* TTCR */
         cpu_openrisc_count_update(cpu);
-        return env->ttcr;
+        return cpu_openrisc_count_get(cpu);
 
     default:
         break;
-- 
2.13.5
