Received: from eggs.gnu.org ([2001:4830:134:3::10]:59314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFo-0004t6-Ey
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFi-0003IT-DS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFh-00031S-Uw
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:58 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:59 -0400
Message-Id: <20181019010625.25294-31-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 30/56] i386: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/cpu.c        |  2 +-
 target/i386/hax-all.c    | 16 +++++------
 target/i386/helper.c     |  4 +--
 target/i386/hvf/hvf.c    |  6 ++--
 target/i386/hvf/x86hvf.c | 32 ++++++++++++++--------
 target/i386/kvm.c        | 59 ++++++++++++++++++++++++----------------
 target/i386/svm_helper.c |  4 +--
 target/i386/whpx-all.c   | 44 ++++++++++++++++++------------
 8 files changed, 98 insertions(+), 69 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b91d80af0a..9eaf3274b2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5473,7 +5473,7 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
 
 static bool x86_cpu_has_work(CPUState *cs)
 {
-    return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
+    return x86_cpu_pending_interrupt(cs, cpu_interrupt_request(cs)) != 0;
 }
 
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 8b53a9708f..11751d78ad 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -293,7 +293,7 @@ int hax_vm_destroy(struct hax_vm *vm)
 
 static void hax_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
@@ -427,7 +427,7 @@ static int hax_vcpu_interrupt(CPUArchState *env)
      * Unlike KVM, HAX kernel check for the eflags, instead of qemu
      */
     if (ht->ready_for_interrupt_injection &&
-        (cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        (cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
         int irq;
 
         irq = cpu_get_pic_interrupt(env);
@@ -441,7 +441,7 @@ static int hax_vcpu_interrupt(CPUArchState *env)
      * interrupt, request an interrupt window exit.  This will
      * cause a return to userspace as soon as the guest is ready to
      * receive interrupts. */
-    if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+    if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
         ht->request_interrupt_window = 1;
     } else {
         ht->request_interrupt_window = 0;
@@ -482,19 +482,19 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
 
     cpu_halted_set(cpu, 0);
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_POLL) {
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         apic_poll_irq(x86_cpu->apic_state);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_INIT) {
         DPRINTF("\nhax_vcpu_hax_exec: handling INIT for %d\n",
                 cpu->cpu_index);
         do_cpu_init(x86_cpu);
         hax_vcpu_sync_state(env, 1);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_SIPI) {
         DPRINTF("hax_vcpu_hax_exec: handling SIPI for %d\n",
                 cpu->cpu_index);
         hax_vcpu_sync_state(env, 0);
@@ -553,8 +553,8 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
             ret = -1;
             break;
         case HAX_EXIT_HLT:
-            if (!(cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
-                !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+            if (!(cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD) &&
+                !(cpu_interrupt_request(cpu) & CPU_INTERRUPT_NMI)) {
                 /* hlt instruction with interrupt disabled is shutdown */
                 env->eflags |= IF_MASK;
                 cpu_halted_set(cpu, 1);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index a75278f954..9197fb4edc 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -1035,12 +1035,12 @@ void do_cpu_init(X86CPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
     CPUX86State *save = g_new(CPUX86State, 1);
-    int sipi = cs->interrupt_request & CPU_INTERRUPT_SIPI;
+    int sipi = cpu_interrupt_request(cs) & CPU_INTERRUPT_SIPI;
 
     *save = *env;
 
     cpu_reset(cs);
-    cs->interrupt_request = sipi;
+    cpu_interrupt_request_set(cs, sipi);
     memcpy(&env->start_init_save, &save->start_init_save,
            offsetof(CPUX86State, end_init_save) -
            offsetof(CPUX86State, start_init_save));
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index fb3b2a26a1..513a7ef417 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -250,7 +250,7 @@ void update_apic_tpr(CPUState *cpu)
 
 static void hvf_handle_interrupt(CPUState * cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
     }
@@ -713,9 +713,9 @@ int hvf_vcpu_exec(CPUState *cpu)
         switch (exit_reason) {
         case EXIT_REASON_HLT: {
             macvm_set_rip(cpu, rip + ins_len);
-            if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            if (!((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD) &&
                 (EFLAGS(env) & IF_MASK))
-                && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
+                && !(cpu_interrupt_request(cpu) & CPU_INTERRUPT_NMI) &&
                 !(idtvec_info & VMCS_IDT_VEC_VALID)) {
                 cpu_halted_set(cpu, 1);
                 ret = EXCP_HLT;
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index e8b13ed534..aae1324533 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -358,6 +358,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
 
     uint8_t vector;
     uint64_t intr_type;
+    bool ret;
     bool have_event = true;
     if (env->interrupt_injected != -1) {
         vector = env->interrupt_injected;
@@ -400,7 +401,8 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
         };
     }
 
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_NMI) {
+    cpu_mutex_lock(cpu_state);
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_NMI) {
         if (!(env->hflags2 & HF2_NMI_MASK) && !(info & VMCS_INTR_VALID)) {
             cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_NMI);
             info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | NMI_VEC;
@@ -411,7 +413,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
     }
 
     if (!(env->hflags & HF_INHIBIT_IRQ_MASK) &&
-        (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
+        (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_HARD) &&
         (EFLAGS(env) & IF_MASK) && !(info & VMCS_INTR_VALID)) {
         int line = cpu_get_pic_interrupt(&x86cpu->env);
         cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_HARD);
@@ -420,43 +422,49 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
                   VMCS_INTR_VALID | VMCS_INTR_T_HWINTR);
         }
     }
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_HARD) {
         vmx_set_int_window_exiting(cpu_state);
     }
-    return (cpu_state->interrupt_request
-            & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR));
+    ret = cpu_interrupt_request(cpu_state)
+          & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR);
+    cpu_mutex_unlock(cpu_state);
+    return ret;
 }
 
 int hvf_process_events(CPUState *cpu_state)
 {
     X86CPU *cpu = X86_CPU(cpu_state);
     CPUX86State *env = &cpu->env;
+    int ret;
 
     EFLAGS(env) = rreg(cpu_state->hvf_fd, HV_X86_RFLAGS);
 
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_INIT) {
+    cpu_mutex_lock(cpu_state);
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
+    if (((cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_HARD) &&
         (EFLAGS(env) & IF_MASK)) ||
-        (cpu_state->interrupt_request & CPU_INTERRUPT_NMI)) {
+        (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cpu_state, 0);
     }
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_SIPI) {
         hvf_cpu_synchronize_state(cpu_state);
         do_cpu_sipi(cpu);
     }
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_TPR) {
         cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_TPR);
         hvf_cpu_synchronize_state(cpu_state);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
                                       env->tpr_access_type);
     }
-    return cpu_halted(cpu);
+    ret = cpu_halted(cpu);
+    cpu_mutex_unlock(cpu_state);
+    return ret;
 }
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index effaf87f01..2e98a0ac63 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2707,9 +2707,12 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
             /* As soon as these are moved to the kernel, remove them
              * from cs->interrupt_request.
              */
-            events.smi.pending = cs->interrupt_request & CPU_INTERRUPT_SMI;
-            events.smi.latched_init = cs->interrupt_request & CPU_INTERRUPT_INIT;
+            cpu_mutex_lock(cs);
+            events.smi.pending = cpu_interrupt_request(cs) & CPU_INTERRUPT_SMI;
+            events.smi.latched_init = cpu_interrupt_request(cs) &
+                CPU_INTERRUPT_INIT;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);
+            cpu_mutex_unlock(cs);
         } else {
             /* Keep these in cs->interrupt_request.  */
             events.smi.pending = 0;
@@ -3001,12 +3004,12 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     CPUX86State *env = &x86_cpu->env;
     int ret;
 
+    cpu_mutex_lock(cpu);
+
     /* Inject NMI */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
-        if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
-            qemu_mutex_lock_iothread();
+    if (cpu_interrupt_request(cpu) & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
+        if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_NMI) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
-            qemu_mutex_unlock_iothread();
             DPRINTF("injected NMI\n");
             ret = kvm_vcpu_ioctl(cpu, KVM_NMI);
             if (ret < 0) {
@@ -3014,10 +3017,8 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
                         strerror(-ret));
             }
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
-            qemu_mutex_lock_iothread();
+        if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_SMI) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
-            qemu_mutex_unlock_iothread();
             DPRINTF("injected SMI\n");
             ret = kvm_vcpu_ioctl(cpu, KVM_SMI);
             if (ret < 0) {
@@ -3028,19 +3029,21 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     }
 
     if (!kvm_pic_in_kernel()) {
+        cpu_mutex_unlock(cpu);
         qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cpu);
     }
 
     /* Force the VCPU out of its inner loop to process any INIT requests
      * or (for userspace APIC, but it is cheap to combine the checks here)
      * pending TPR access reports.
      */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
-        if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if (cpu_interrupt_request(cpu) & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
+        if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
             cpu->exit_request = 1;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+        if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_TPR) {
             cpu->exit_request = 1;
         }
     }
@@ -3048,7 +3051,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     if (!kvm_pic_in_kernel()) {
         /* Try to inject an interrupt if the guest can accept it */
         if (run->ready_for_interrupt_injection &&
-            (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            (cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD) &&
             (env->eflags & IF_MASK)) {
             int irq;
 
@@ -3072,7 +3075,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
          * interrupt, request an interrupt window exit.  This will
          * cause a return to userspace as soon as the guest is ready to
          * receive interrupts. */
-        if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
             run->request_interrupt_window = 1;
         } else {
             run->request_interrupt_window = 0;
@@ -3083,6 +3086,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
 
         qemu_mutex_unlock_iothread();
     }
+    cpu_mutex_unlock(cpu);
 }
 
 MemTxAttrs kvm_arch_post_run(CPUState *cpu, struct kvm_run *run)
@@ -3118,8 +3122,9 @@ int kvm_arch_process_async_events(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    int ret;
 
-    if (cs->interrupt_request & CPU_INTERRUPT_MCE) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_MCE) {
         /* We must not raise CPU_INTERRUPT_MCE if it's not supported. */
         assert(env->mcg_cap);
 
@@ -3142,7 +3147,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         }
     }
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if ((cpu_interrupt_request(cs) & CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
         kvm_cpu_synchronize_state(cs);
         do_cpu_init(cpu);
@@ -3152,27 +3157,30 @@ int kvm_arch_process_async_events(CPUState *cs)
         return 0;
     }
 
-    if (cs->interrupt_request & CPU_INTERRUPT_POLL) {
+    cpu_mutex_lock(cs);
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_POLL) {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_POLL);
         apic_poll_irq(cpu->apic_state);
     }
-    if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (((cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        (cpu_interrupt_request(cs) & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cs, 0);
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_SIPI) {
         kvm_cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_TPR) {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_TPR);
         kvm_cpu_synchronize_state(cs);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
                                       env->tpr_access_type);
     }
+    ret = cpu_halted(cs);
+    cpu_mutex_unlock(cs);
 
-    return cpu_halted(cs);
+    return ret;
 }
 
 static int kvm_handle_halt(X86CPU *cpu)
@@ -3180,12 +3188,15 @@ static int kvm_handle_halt(X86CPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
 
-    if (!((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    cpu_mutex_lock(cs);
+    if (!((cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
           (env->eflags & IF_MASK)) &&
-        !(cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        !(cpu_interrupt_request(cs) & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cs, 1);
+        cpu_mutex_unlock(cs);
         return EXCP_HLT;
     }
+    cpu_mutex_unlock(cs);
 
     return 0;
 }
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index a6d33e55d8..ebf3643ba7 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -316,7 +316,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     if (int_ctl & V_IRQ_MASK) {
         CPUState *cs = CPU(x86_env_get_cpu(env));
 
-        cs->interrupt_request |= CPU_INTERRUPT_VIRQ;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_VIRQ);
     }
 
     /* maybe we need to inject an event */
@@ -674,7 +674,7 @@ void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1)
                        env->vm_vmcb + offsetof(struct vmcb, control.int_ctl));
     int_ctl &= ~(V_TPR_MASK | V_IRQ_MASK);
     int_ctl |= env->v_tpr & V_TPR_MASK;
-    if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_VIRQ) {
         int_ctl |= V_IRQ_MASK;
     }
     x86_stl_phys(cs,
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 9673bdc219..5456f26d8c 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -693,14 +693,16 @@ static int whpx_handle_halt(CPUState *cpu)
     int ret = 0;
 
     qemu_mutex_lock_iothread();
-    if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    cpu_mutex_lock(cpu);
+    if (!((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD) &&
           (env->eflags & IF_MASK)) &&
-        !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        !(cpu_interrupt_request(cpu) & CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
         cpu_halted_set(cpu, true);
         ret = 1;
     }
     qemu_mutex_unlock_iothread();
+    cpu_mutex_unlock(cpu);
 
     return ret;
 }
@@ -724,17 +726,20 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     qemu_mutex_lock_iothread();
 
+    cpu_mutex_lock(cpu);
+
     /* Inject NMI */
     if (!vcpu->interruption_pending &&
-        cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
-        if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
+        cpu_interrupt_request(cpu) & (CPU_INTERRUPT_NMI |
+                                             CPU_INTERRUPT_SMI)) {
+        if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_NMI) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
             vcpu->interruptable = false;
             new_int.InterruptionType = WHvX64PendingNmi;
             new_int.InterruptionPending = 1;
             new_int.InterruptionVector = 2;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
+        if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_SMI) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
         }
     }
@@ -743,12 +748,12 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
      * Force the VCPU out of its inner loop to process any INIT requests or
      * commit pending TPR access.
      */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
-        if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if (cpu_interrupt_request(cpu) & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
+        if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
             cpu->exit_request = 1;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+        if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_TPR) {
             cpu->exit_request = 1;
         }
     }
@@ -757,7 +762,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     if (!vcpu->interruption_pending &&
         vcpu->interruptable && (env->eflags & IF_MASK)) {
         assert(!new_int.InterruptionPending);
-        if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD) {
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
@@ -796,6 +801,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     }
 
     qemu_mutex_unlock_iothread();
+    cpu_mutex_unlock(cpu);
 
     if (reg_count) {
         hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
@@ -841,7 +847,9 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
 
-    if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    cpu_mutex_lock(cpu);
+
+    if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
 
         do_cpu_init(x86_cpu);
@@ -849,25 +857,25 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
         vcpu->interruptable = true;
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_POLL) {
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         apic_poll_irq(x86_cpu->apic_state);
     }
 
-    if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        (cpu_interrupt_request(cpu) & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cpu, false);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_SIPI) {
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
@@ -876,6 +884,8 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
                                       env->tpr_access_type);
     }
 
+    cpu_mutex_unlock(cpu);
+
     return;
 }
 
@@ -1350,7 +1360,7 @@ static void whpx_memory_init(void)
 
 static void whpx_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
-- 
2.17.1
