Received: from eggs.gnu.org ([209.51.188.92]:35578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3s-0008Uk-IJ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3o-0001Bu-VC
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:02 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3m-00010T-Ke
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:58 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:40 -0500
Message-Id: <20190130004811.27372-43-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 42/73] i386/whpx-all: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/whpx-all.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 9673bdc219..0d8cfa3a19 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -690,12 +690,14 @@ static int whpx_handle_portio(CPUState *cpu,
 static int whpx_handle_halt(CPUState *cpu)
 {
     struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
+    uint32_t interrupt_request;
     int ret = 0;
 
     qemu_mutex_lock_iothread();
-    if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    interrupt_request = cpu_interrupt_request(cpu);
+    if (!((interrupt_request & CPU_INTERRUPT_HARD) &&
           (env->eflags & IF_MASK)) &&
-        !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        !(interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
         cpu_halted_set(cpu, true);
         ret = 1;
@@ -713,6 +715,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
     X86CPU *x86_cpu = X86_CPU(cpu);
     int irq;
+    uint32_t interrupt_request;
     uint8_t tpr;
     WHV_X64_PENDING_INTERRUPTION_REGISTER new_int;
     UINT32 reg_count = 0;
@@ -724,17 +727,19 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     qemu_mutex_lock_iothread();
 
+    interrupt_request = cpu_interrupt_request(cpu);
+
     /* Inject NMI */
     if (!vcpu->interruption_pending &&
-        cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
-        if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
+        interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
+        if (interrupt_request & CPU_INTERRUPT_NMI) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
             vcpu->interruptable = false;
             new_int.InterruptionType = WHvX64PendingNmi;
             new_int.InterruptionPending = 1;
             new_int.InterruptionVector = 2;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
+        if (interrupt_request & CPU_INTERRUPT_SMI) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
         }
     }
@@ -743,12 +748,12 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
      * Force the VCPU out of its inner loop to process any INIT requests or
      * commit pending TPR access.
      */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
-        if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if (interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
+        if ((interrupt_request & CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
             cpu->exit_request = 1;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+        if (interrupt_request & CPU_INTERRUPT_TPR) {
             cpu->exit_request = 1;
         }
     }
@@ -757,7 +762,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     if (!vcpu->interruption_pending &&
         vcpu->interruptable && (env->eflags & IF_MASK)) {
         assert(!new_int.InterruptionPending);
-        if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (interrupt_request & CPU_INTERRUPT_HARD) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
             irq = cpu_get_pic_interrupt(env);
             if (irq >= 0) {
@@ -787,7 +792,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     /* Update the state of the interrupt delivery notification */
     if (!vcpu->window_registered &&
-        cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+        cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD) {
         reg_values[reg_count].DeliverabilityNotifications.InterruptNotification
             = 1;
         vcpu->window_registered = 1;
@@ -840,8 +845,9 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
+    uint32_t interrupt_request;
 
-    if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
 
         do_cpu_init(x86_cpu);
@@ -849,25 +855,26 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
         vcpu->interruptable = true;
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_POLL) {
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         apic_poll_irq(x86_cpu->apic_state);
     }
 
-    if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    interrupt_request = cpu_interrupt_request(cpu);
+    if (((interrupt_request & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        (interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cpu, false);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (interrupt_request & CPU_INTERRUPT_SIPI) {
         if (!cpu->vcpu_dirty) {
             whpx_get_registers(cpu);
         }
         do_cpu_sipi(x86_cpu);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_TPR) {
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_TPR);
         if (!cpu->vcpu_dirty) {
             whpx_get_registers(cpu);
@@ -1350,7 +1357,7 @@ static void whpx_memory_init(void)
 
 static void whpx_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
-- 
2.17.1
