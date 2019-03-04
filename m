Received: from eggs.gnu.org ([209.51.188.92]:44876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sBC-0000Sz-Nw
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sB9-00023x-UC
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:09 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:17:38 -0500
Message-Id: <20190304181813.8075-39-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 38/73] arm: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/cpu.c     |  6 +++---
 target/arm/helper.c  | 16 +++++++---------
 target/arm/machine.c |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 845730c00c..7037e22580 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -73,7 +73,7 @@ static bool arm_cpu_has_work(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
 
     return (cpu->power_state != PSCI_OFF)
-        && cs->interrupt_request &
+        && cpu_interrupt_request(cs) &
         (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
          | CPU_INTERRUPT_EXITTB);
@@ -484,7 +484,7 @@ void arm_cpu_update_virq(ARMCPU *cpu)
     bool new_state = (env->cp15.hcr_el2 & HCR_VI) ||
         (env->irq_line_state & CPU_INTERRUPT_VIRQ);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VIRQ) != 0)) {
+    if (new_state != ((cpu_interrupt_request(cs) & CPU_INTERRUPT_VIRQ) != 0)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VIRQ);
         } else {
@@ -505,7 +505,7 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
     bool new_state = (env->cp15.hcr_el2 & HCR_VF) ||
         (env->irq_line_state & CPU_INTERRUPT_VFIQ);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VFIQ) != 0)) {
+    if (new_state != ((cpu_interrupt_request(cs) & CPU_INTERRUPT_VFIQ) != 0)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VFIQ);
         } else {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1fa282a7fc..2affe7965c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1893,23 +1893,24 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     CPUState *cs = ENV_GET_CPU(env);
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     uint64_t ret = 0;
+    uint32_t interrupt_request = cpu_interrupt_request(cs);
 
     if (hcr_el2 & HCR_IMO) {
-        if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
+        if (interrupt_request & CPU_INTERRUPT_VIRQ) {
             ret |= CPSR_I;
         }
     } else {
-        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (interrupt_request & CPU_INTERRUPT_HARD) {
             ret |= CPSR_I;
         }
     }
 
     if (hcr_el2 & HCR_FMO) {
-        if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
+        if (interrupt_request & CPU_INTERRUPT_VFIQ) {
             ret |= CPSR_F;
         }
     } else {
-        if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
+        if (interrupt_request & CPU_INTERRUPT_FIQ) {
             ret |= CPSR_F;
         }
     }
@@ -9647,10 +9648,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
         return;
     }
 
-    /* Hooks may change global state so BQL should be held, also the
-     * BQL needs to be held for any modification of
-     * cs->interrupt_request.
-     */
+    /* Hooks may change global state so BQL should be held */
     g_assert(qemu_mutex_iothread_locked());
 
     arm_call_pre_el_change_hook(cpu);
@@ -9665,7 +9663,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     arm_call_el_change_hook(cpu);
 
     if (!kvm_enabled()) {
-        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
     }
 }
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/arm/machine.c b/target/arm/machine.c
index b292549614..4f2099ecde 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -693,7 +693,7 @@ static int cpu_post_load(void *opaque, int version_id)
     if (env->irq_line_state == UINT32_MAX) {
         CPUState *cs = CPU(cpu);
 
-        env->irq_line_state = cs->interrupt_request &
+        env->irq_line_state = cpu_interrupt_request(cs) &
             (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ |
              CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VFIQ);
     }
-- 
2.17.1
