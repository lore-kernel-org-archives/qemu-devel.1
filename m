Received: from eggs.gnu.org ([209.51.188.92]:44984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sBC-0000TH-UT
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sBA-00026c-LO
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:10 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40699)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sBA-0001Gj-Bl
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:08 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:17:40 -0500
Message-Id: <20190304181813.8075-41-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 40/73] i386/kvm: convert to
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
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/kvm.c | 58 ++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f2e187e40f..44a9e3d243 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2888,11 +2888,14 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
         events.smi.smm = !!(env->hflags & HF_SMM_MASK);
         events.smi.smm_inside_nmi = !!(env->hflags2 & HF2_SMM_INSIDE_NMI_MASK);
         if (kvm_irqchip_in_kernel()) {
+            uint32_t interrupt_request;
+
             /* As soon as these are moved to the kernel, remove them
              * from cs->interrupt_request.
              */
-            events.smi.pending = cs->interrupt_request & CPU_INTERRUPT_SMI;
-            events.smi.latched_init = cs->interrupt_request & CPU_INTERRUPT_INIT;
+            interrupt_request = cpu_interrupt_request(cs);
+            events.smi.pending = interrupt_request & CPU_INTERRUPT_SMI;
+            events.smi.latched_init = interrupt_request & CPU_INTERRUPT_INIT;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);
         } else {
             /* Keep these in cs->interrupt_request.  */
@@ -3183,14 +3186,14 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
+    uint32_t interrupt_request;
     int ret;
 
+    interrupt_request = cpu_interrupt_request(cpu);
     /* Inject NMI */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
-        if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
-            qemu_mutex_lock_iothread();
+    if (interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
+        if (interrupt_request & CPU_INTERRUPT_NMI) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
-            qemu_mutex_unlock_iothread();
             DPRINTF("injected NMI\n");
             ret = kvm_vcpu_ioctl(cpu, KVM_NMI);
             if (ret < 0) {
@@ -3198,10 +3201,8 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
                         strerror(-ret));
             }
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
-            qemu_mutex_lock_iothread();
+        if (interrupt_request & CPU_INTERRUPT_SMI) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
-            qemu_mutex_unlock_iothread();
             DPRINTF("injected SMI\n");
             ret = kvm_vcpu_ioctl(cpu, KVM_SMI);
             if (ret < 0) {
@@ -3215,16 +3216,22 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
         qemu_mutex_lock_iothread();
     }
 
+    /*
+     * We might have cleared some bits in cpu->interrupt_request since reading
+     * it; read it again.
+     */
+    interrupt_request = cpu_interrupt_request(cpu);
+
     /* Force the VCPU out of its inner loop to process any INIT requests
      * or (for userspace APIC, but it is cheap to combine the checks here)
      * pending TPR access reports.
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
@@ -3232,7 +3239,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     if (!kvm_pic_in_kernel()) {
         /* Try to inject an interrupt if the guest can accept it */
         if (run->ready_for_interrupt_injection &&
-            (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            (interrupt_request & CPU_INTERRUPT_HARD) &&
             (env->eflags & IF_MASK)) {
             int irq;
 
@@ -3256,7 +3263,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
          * interrupt, request an interrupt window exit.  This will
          * cause a return to userspace as soon as the guest is ready to
          * receive interrupts. */
-        if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
             run->request_interrupt_window = 1;
         } else {
             run->request_interrupt_window = 0;
@@ -3302,8 +3309,9 @@ int kvm_arch_process_async_events(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    uint32_t interrupt_request;
 
-    if (cs->interrupt_request & CPU_INTERRUPT_MCE) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_MCE) {
         /* We must not raise CPU_INTERRUPT_MCE if it's not supported. */
         assert(env->mcg_cap);
 
@@ -3326,7 +3334,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         }
     }
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if ((cpu_interrupt_request(cs) & CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
         kvm_cpu_synchronize_state(cs);
         do_cpu_init(cpu);
@@ -3336,20 +3344,21 @@ int kvm_arch_process_async_events(CPUState *cs)
         return 0;
     }
 
-    if (cs->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_POLL) {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_POLL);
         apic_poll_irq(cpu->apic_state);
     }
-    if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    interrupt_request = cpu_interrupt_request(cs);
+    if (((interrupt_request & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        (interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cs, 0);
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (interrupt_request & CPU_INTERRUPT_SIPI) {
         kvm_cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_TPR) {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_TPR);
         kvm_cpu_synchronize_state(cs);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
@@ -3363,10 +3372,13 @@ static int kvm_handle_halt(X86CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
+    uint32_t interrupt_request;
+
+    interrupt_request = cpu_interrupt_request(cs);
 
-    if (!((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (!((interrupt_request & CPU_INTERRUPT_HARD) &&
           (env->eflags & IF_MASK)) &&
-        !(cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        !(interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cs, 1);
         return EXCP_HLT;
     }
-- 
2.17.1
