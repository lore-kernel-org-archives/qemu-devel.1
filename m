Received: from eggs.gnu.org ([209.51.188.92]:35833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe42-0000Go-EW
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe41-0001Vg-7K
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:14 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50457)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe40-00010a-Vu
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:13 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:41 -0500
Message-Id: <20190130004811.27372-44-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 43/73] i386/hvf: convert to
 cpu_request_interrupt
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
 target/i386/hvf/hvf.c    |  8 +++++---
 target/i386/hvf/x86hvf.c | 26 +++++++++++++++-----------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c1ff220985..619a4dd565 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -249,7 +249,7 @@ void update_apic_tpr(CPUState *cpu)
 
 static void hvf_handle_interrupt(CPUState * cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
     }
@@ -706,10 +706,12 @@ int hvf_vcpu_exec(CPUState *cpu)
         ret = 0;
         switch (exit_reason) {
         case EXIT_REASON_HLT: {
+            uint32_t interrupt_request = cpu_interrupt_request(cpu);
+
             macvm_set_rip(cpu, rip + ins_len);
-            if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            if (!((interrupt_request & CPU_INTERRUPT_HARD) &&
                 (EFLAGS(env) & IF_MASK))
-                && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
+                && !(interrupt_request & CPU_INTERRUPT_NMI) &&
                 !(idtvec_info & VMCS_IDT_VEC_VALID)) {
                 cpu_halted_set(cpu, 1);
                 ret = EXCP_HLT;
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index e8b13ed534..91feafeedc 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -358,6 +358,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
 
     uint8_t vector;
     uint64_t intr_type;
+    uint32_t interrupt_request;
     bool have_event = true;
     if (env->interrupt_injected != -1) {
         vector = env->interrupt_injected;
@@ -400,7 +401,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
         };
     }
 
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_NMI) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_NMI) {
         if (!(env->hflags2 & HF2_NMI_MASK) && !(info & VMCS_INTR_VALID)) {
             cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_NMI);
             info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | NMI_VEC;
@@ -411,7 +412,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
     }
 
     if (!(env->hflags & HF_INHIBIT_IRQ_MASK) &&
-        (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
+        (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_HARD) &&
         (EFLAGS(env) & IF_MASK) && !(info & VMCS_INTR_VALID)) {
         int line = cpu_get_pic_interrupt(&x86cpu->env);
         cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_HARD);
@@ -420,39 +421,42 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
                   VMCS_INTR_VALID | VMCS_INTR_T_HWINTR);
         }
     }
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_HARD) {
         vmx_set_int_window_exiting(cpu_state);
     }
-    return (cpu_state->interrupt_request
-            & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR));
+    return cpu_interrupt_request(cpu_state) & (CPU_INTERRUPT_INIT |
+                                               CPU_INTERRUPT_TPR);
 }
 
 int hvf_process_events(CPUState *cpu_state)
 {
     X86CPU *cpu = X86_CPU(cpu_state);
     CPUX86State *env = &cpu->env;
+    uint32_t interrupt_request;
 
     EFLAGS(env) = rreg(cpu_state->hvf_fd, HV_X86_RFLAGS);
 
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_INIT) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_INIT) {
         hvf_cpu_synchronize_state(cpu_state);
         do_cpu_init(cpu);
     }
 
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_POLL) {
         cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_POLL);
         apic_poll_irq(cpu->apic_state);
     }
-    if (((cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
+
+    interrupt_request = cpu_interrupt_request(cpu_state);
+    if (((interrupt_request & CPU_INTERRUPT_HARD) &&
         (EFLAGS(env) & IF_MASK)) ||
-        (cpu_state->interrupt_request & CPU_INTERRUPT_NMI)) {
+        (interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cpu_state, 0);
     }
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (interrupt_request & CPU_INTERRUPT_SIPI) {
         hvf_cpu_synchronize_state(cpu_state);
         do_cpu_sipi(cpu);
     }
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_TPR) {
         cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_TPR);
         hvf_cpu_synchronize_state(cpu_state);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
-- 
2.17.1
