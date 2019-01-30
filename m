Received: from eggs.gnu.org ([209.51.188.92]:35647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3w-00005Y-MQ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3s-0001F5-1g
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:06 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36475)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3o-0000zp-02
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:00 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:33 -0500
Message-Id: <20190130004811.27372-36-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 35/73] i386: use cpu_reset_interrupt
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

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/hax-all.c    |  4 ++--
 target/i386/hvf/x86hvf.c |  8 ++++----
 target/i386/kvm.c        | 14 +++++++-------
 target/i386/seg_helper.c | 13 ++++++-------
 target/i386/svm_helper.c |  2 +-
 target/i386/whpx-all.c   | 10 +++++-----
 6 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 22951017cf..518c6ff103 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -424,7 +424,7 @@ static int hax_vcpu_interrupt(CPUArchState *env)
         irq = cpu_get_pic_interrupt(env);
         if (irq >= 0) {
             hax_inject_interrupt(env, irq);
-            cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
         }
     }
 
@@ -474,7 +474,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
     cpu_halted_set(cpu, 0);
 
     if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
-        cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         apic_poll_irq(x86_cpu->apic_state);
     }
 
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 163bbed23f..e8b13ed534 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -402,7 +402,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
 
     if (cpu_state->interrupt_request & CPU_INTERRUPT_NMI) {
         if (!(env->hflags2 & HF2_NMI_MASK) && !(info & VMCS_INTR_VALID)) {
-            cpu_state->interrupt_request &= ~CPU_INTERRUPT_NMI;
+            cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_NMI);
             info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | NMI_VEC;
             wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_INTR_INFO, info);
         } else {
@@ -414,7 +414,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
         (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
         (EFLAGS(env) & IF_MASK) && !(info & VMCS_INTR_VALID)) {
         int line = cpu_get_pic_interrupt(&x86cpu->env);
-        cpu_state->interrupt_request &= ~CPU_INTERRUPT_HARD;
+        cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_HARD);
         if (line >= 0) {
             wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_INTR_INFO, line |
                   VMCS_INTR_VALID | VMCS_INTR_T_HWINTR);
@@ -440,7 +440,7 @@ int hvf_process_events(CPUState *cpu_state)
     }
 
     if (cpu_state->interrupt_request & CPU_INTERRUPT_POLL) {
-        cpu_state->interrupt_request &= ~CPU_INTERRUPT_POLL;
+        cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_POLL);
         apic_poll_irq(cpu->apic_state);
     }
     if (((cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
@@ -453,7 +453,7 @@ int hvf_process_events(CPUState *cpu_state)
         do_cpu_sipi(cpu);
     }
     if (cpu_state->interrupt_request & CPU_INTERRUPT_TPR) {
-        cpu_state->interrupt_request &= ~CPU_INTERRUPT_TPR;
+        cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_TPR);
         hvf_cpu_synchronize_state(cpu_state);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
                                       env->tpr_access_type);
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9006f04d92..ca2629f0fe 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2893,7 +2893,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
              */
             events.smi.pending = cs->interrupt_request & CPU_INTERRUPT_SMI;
             events.smi.latched_init = cs->interrupt_request & CPU_INTERRUPT_INIT;
-            cs->interrupt_request &= ~(CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);
         } else {
             /* Keep these in cs->interrupt_request.  */
             events.smi.pending = 0;
@@ -3189,7 +3189,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     if (cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
         if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
             qemu_mutex_lock_iothread();
-            cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
             qemu_mutex_unlock_iothread();
             DPRINTF("injected NMI\n");
             ret = kvm_vcpu_ioctl(cpu, KVM_NMI);
@@ -3200,7 +3200,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
         }
         if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
             qemu_mutex_lock_iothread();
-            cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
             qemu_mutex_unlock_iothread();
             DPRINTF("injected SMI\n");
             ret = kvm_vcpu_ioctl(cpu, KVM_SMI);
@@ -3236,7 +3236,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
             (env->eflags & IF_MASK)) {
             int irq;
 
-            cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
             irq = cpu_get_pic_interrupt(env);
             if (irq >= 0) {
                 struct kvm_interrupt intr;
@@ -3307,7 +3307,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         /* We must not raise CPU_INTERRUPT_MCE if it's not supported. */
         assert(env->mcg_cap);
 
-        cs->interrupt_request &= ~CPU_INTERRUPT_MCE;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_MCE);
 
         kvm_cpu_synchronize_state(cs);
 
@@ -3337,7 +3337,7 @@ int kvm_arch_process_async_events(CPUState *cs)
     }
 
     if (cs->interrupt_request & CPU_INTERRUPT_POLL) {
-        cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_POLL);
         apic_poll_irq(cpu->apic_state);
     }
     if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
@@ -3350,7 +3350,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         do_cpu_sipi(cpu);
     }
     if (cs->interrupt_request & CPU_INTERRUPT_TPR) {
-        cs->interrupt_request &= ~CPU_INTERRUPT_TPR;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_TPR);
         kvm_cpu_synchronize_state(cs);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
                                       env->tpr_access_type);
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 63e265cb38..b580403ef4 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1332,7 +1332,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     switch (interrupt_request) {
 #if !defined(CONFIG_USER_ONLY)
     case CPU_INTERRUPT_POLL:
-        cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_POLL);
         apic_poll_irq(cpu->apic_state);
         break;
 #endif
@@ -1341,23 +1341,22 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         break;
     case CPU_INTERRUPT_SMI:
         cpu_svm_check_intercept_param(env, SVM_EXIT_SMI, 0, 0);
-        cs->interrupt_request &= ~CPU_INTERRUPT_SMI;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SMI);
         do_smm_enter(cpu);
         break;
     case CPU_INTERRUPT_NMI:
         cpu_svm_check_intercept_param(env, SVM_EXIT_NMI, 0, 0);
-        cs->interrupt_request &= ~CPU_INTERRUPT_NMI;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_NMI);
         env->hflags2 |= HF2_NMI_MASK;
         do_interrupt_x86_hardirq(env, EXCP02_NMI, 1);
         break;
     case CPU_INTERRUPT_MCE:
-        cs->interrupt_request &= ~CPU_INTERRUPT_MCE;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_MCE);
         do_interrupt_x86_hardirq(env, EXCP12_MCHK, 0);
         break;
     case CPU_INTERRUPT_HARD:
         cpu_svm_check_intercept_param(env, SVM_EXIT_INTR, 0, 0);
-        cs->interrupt_request &= ~(CPU_INTERRUPT_HARD |
-                                   CPU_INTERRUPT_VIRQ);
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_VIRQ);
         intno = cpu_get_pic_interrupt(env);
         qemu_log_mask(CPU_LOG_TB_IN_ASM,
                       "Servicing hardware INT=0x%02x\n", intno);
@@ -1372,7 +1371,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         qemu_log_mask(CPU_LOG_TB_IN_ASM,
                       "Servicing virtual hardware INT=0x%02x\n", intno);
         do_interrupt_x86_hardirq(env, intno, 1);
-        cs->interrupt_request &= ~CPU_INTERRUPT_VIRQ;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_VIRQ);
         break;
 #endif
     }
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 9fd22a883b..a6d33e55d8 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -700,7 +700,7 @@ void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1)
     env->hflags &= ~HF_GUEST_MASK;
     env->intercept = 0;
     env->intercept_exceptions = 0;
-    cs->interrupt_request &= ~CPU_INTERRUPT_VIRQ;
+    cpu_reset_interrupt(cs, CPU_INTERRUPT_VIRQ);
     env->tsc_offset = 0;
 
     env->gdt.base  = x86_ldq_phys(cs, env->vm_hsave + offsetof(struct vmcb,
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index b9c79ccd99..9673bdc219 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -728,14 +728,14 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     if (!vcpu->interruption_pending &&
         cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
         if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
             vcpu->interruptable = false;
             new_int.InterruptionType = WHvX64PendingNmi;
             new_int.InterruptionPending = 1;
             new_int.InterruptionVector = 2;
         }
         if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
         }
     }
 
@@ -758,7 +758,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
         vcpu->interruptable && (env->eflags & IF_MASK)) {
         assert(!new_int.InterruptionPending);
         if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
             irq = cpu_get_pic_interrupt(env);
             if (irq >= 0) {
                 new_int.InterruptionType = WHvX64PendingInterrupt;
@@ -850,7 +850,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 
     if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
-        cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         apic_poll_irq(x86_cpu->apic_state);
     }
 
@@ -868,7 +868,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 
     if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
-        cpu->interrupt_request &= ~CPU_INTERRUPT_TPR;
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_TPR);
         if (!cpu->vcpu_dirty) {
             whpx_get_registers(cpu);
         }
-- 
2.17.1
