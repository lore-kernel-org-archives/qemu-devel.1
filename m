Received: from eggs.gnu.org ([2001:4830:134:3::10]:59636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJGJ-0005MW-1E
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJG8-0003kn-A4
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:58 -0400
Message-Id: <20181019010625.25294-30-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 29/56] arm: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/cpu.c    |  2 +-
 target/arm/helper.c | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9c5cda8eb7..7330c2dae1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -49,7 +49,7 @@ static bool arm_cpu_has_work(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
 
     return (cpu->power_state != PSCI_OFF)
-        && cs->interrupt_request &
+        && cpu_interrupt_request(cs) &
         (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
          | CPU_INTERRUPT_EXITTB);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c83f7c1109..85e0b9645e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1295,12 +1295,14 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     CPUState *cs = ENV_GET_CPU(env);
     uint64_t ret = 0;
 
-    if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+    cpu_mutex_lock(cs);
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
         ret |= CPSR_I;
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_FIQ) {
         ret |= CPSR_F;
     }
+    cpu_mutex_unlock(cs);
     /* External aborts are not possible in QEMU so A bit is always clear */
     return ret;
 }
@@ -8579,10 +8581,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
         return;
     }
 
-    /* Hooks may change global state so BQL should be held, also the
-     * BQL needs to be held for any modification of
-     * cs->interrupt_request.
-     */
+    /* Hooks may change global state so BQL should be held */
     g_assert(qemu_mutex_iothread_locked());
 
     arm_call_pre_el_change_hook(cpu);
@@ -8597,7 +8596,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     arm_call_el_change_hook(cpu);
 
     if (!kvm_enabled()) {
-        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
     }
 }
 
-- 
2.17.1
