Received: from eggs.gnu.org ([2001:4830:134:3::10]:59599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5Q-00033X-Il
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgv1-00082P-PP
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:29 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgv1-0007mi-Jr
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:45:52 -0400
Message-Id: <20181025144644.15464-19-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 19/71] i386: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

Cc: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/cpu.h         |  2 +-
 target/i386/cpu.c         |  2 +-
 target/i386/hax-all.c     |  4 ++--
 target/i386/helper.c      |  4 ++--
 target/i386/hvf/hvf.c     |  8 ++++----
 target/i386/hvf/x86hvf.c  |  4 ++--
 target/i386/kvm.c         | 10 +++++-----
 target/i386/misc_helper.c |  2 +-
 target/i386/whpx-all.c    |  6 +++---
 9 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 730c06f80a..461459520a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1600,7 +1600,7 @@ static inline void cpu_x86_load_seg_cache_sipi(X86CPU *cpu,
                            sipi_vector << 12,
                            env->segs[R_CS].limit,
                            env->segs[R_CS].flags);
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
 }
 
 int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c88876dfe3..b91d80af0a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4524,7 +4524,7 @@ static void x86_cpu_reset(CPUState *s)
     /* We hard-wire the BSP to the first CPU. */
     apic_designate_bsp(cpu->apic_state, s->cpu_index == 0);
 
-    s->halted = !cpu_is_bsp(cpu);
+    cpu_halted_set(s, !cpu_is_bsp(cpu));
 
     if (kvm_enabled()) {
         kvm_arch_reset_vcpu(cpu);
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index d2e512856b..f095c527e3 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -480,7 +480,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
         return 0;
     }
 
-    cpu->halted = 0;
+    cpu_halted_set(cpu, 0);
 
     if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
@@ -557,7 +557,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
                 !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
                 /* hlt instruction with interrupt disabled is shutdown */
                 env->eflags |= IF_MASK;
-                cpu->halted = 1;
+                cpu_halted_set(cpu, 1);
                 cpu->exception_index = EXCP_HLT;
                 ret = 1;
             }
diff --git a/target/i386/helper.c b/target/i386/helper.c
index e695f8ba7a..a75278f954 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -454,7 +454,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                     (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
                     (env->a20_mask >> 20) & 1,
                     (env->hflags >> HF_SMM_SHIFT) & 1,
-                    cs->halted);
+                    cpu_halted(cs));
     } else
 #endif
     {
@@ -481,7 +481,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                     (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
                     (env->a20_mask >> 20) & 1,
                     (env->hflags >> HF_SMM_SHIFT) & 1,
-                    cs->halted);
+                    cpu_halted(cs));
     }
 
     for(i = 0; i < 6; i++) {
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 9f52bc413a..fb3b2a26a1 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -500,7 +500,7 @@ void hvf_reset_vcpu(CPUState *cpu) {
     }
 
     hv_vm_sync_tsc(0);
-    cpu->halted = 0;
+    cpu_halted_set(cpu, 0);
     hv_vcpu_invalidate_tlb(cpu->hvf_fd);
     hv_vcpu_flush(cpu->hvf_fd);
 }
@@ -665,7 +665,7 @@ int hvf_vcpu_exec(CPUState *cpu)
     int ret = 0;
     uint64_t rip = 0;
 
-    cpu->halted = 0;
+    cpu_halted_set(cpu, 0);
 
     if (hvf_process_events(cpu)) {
         return EXCP_HLT;
@@ -683,7 +683,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         vmx_update_tpr(cpu);
 
         qemu_mutex_unlock_iothread();
-        if (!cpu_is_bsp(X86_CPU(cpu)) && cpu->halted) {
+        if (!cpu_is_bsp(X86_CPU(cpu)) && cpu_halted(cpu)) {
             qemu_mutex_lock_iothread();
             return EXCP_HLT;
         }
@@ -717,7 +717,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 (EFLAGS(env) & IF_MASK))
                 && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
                 !(idtvec_info & VMCS_IDT_VEC_VALID)) {
-                cpu->halted = 1;
+                cpu_halted_set(cpu, 1);
                 ret = EXCP_HLT;
             }
             ret = EXCP_INTERRUPT;
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index df8e946fbc..163bbed23f 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -446,7 +446,7 @@ int hvf_process_events(CPUState *cpu_state)
     if (((cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
         (EFLAGS(env) & IF_MASK)) ||
         (cpu_state->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cpu_state->halted = 0;
+        cpu_halted_set(cpu_state, 0);
     }
     if (cpu_state->interrupt_request & CPU_INTERRUPT_SIPI) {
         hvf_cpu_synchronize_state(cpu_state);
@@ -458,5 +458,5 @@ int hvf_process_events(CPUState *cpu_state)
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
                                       env->tpr_access_type);
     }
-    return cpu_state->halted;
+    return cpu_halted(cpu);
 }
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index dc4047b02f..d593818cd5 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2650,7 +2650,7 @@ static int kvm_get_mp_state(X86CPU *cpu)
     }
     env->mp_state = mp_state.mp_state;
     if (kvm_irqchip_in_kernel()) {
-        cs->halted = (mp_state.mp_state == KVM_MP_STATE_HALTED);
+        cpu_halted_set(cs, mp_state.mp_state == KVM_MP_STATE_HALTED);
     }
     return 0;
 }
@@ -3136,7 +3136,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         env->exception_injected = EXCP12_MCHK;
         env->has_error_code = 0;
 
-        cs->halted = 0;
+        cpu_halted_set(cs, 0);
         if (kvm_irqchip_in_kernel() && env->mp_state == KVM_MP_STATE_HALTED) {
             env->mp_state = KVM_MP_STATE_RUNNABLE;
         }
@@ -3159,7 +3159,7 @@ int kvm_arch_process_async_events(CPUState *cs)
     if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
         (cs->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cs->halted = 0;
+        cpu_halted_set(cs, 0);
     }
     if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
         kvm_cpu_synchronize_state(cs);
@@ -3172,7 +3172,7 @@ int kvm_arch_process_async_events(CPUState *cs)
                                       env->tpr_access_type);
     }
 
-    return cs->halted;
+    return cpu_halted(cs);
 }
 
 static int kvm_handle_halt(X86CPU *cpu)
@@ -3183,7 +3183,7 @@ static int kvm_handle_halt(X86CPU *cpu)
     if (!((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
           (env->eflags & IF_MASK)) &&
         !(cs->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
         return EXCP_HLT;
     }
 
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 78f2020ef2..fcd6d833e8 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -554,7 +554,7 @@ static void do_hlt(X86CPU *cpu)
     CPUX86State *env = &cpu->env;
 
     env->hflags &= ~HF_INHIBIT_IRQ_MASK; /* needed if sti is just before */
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
     cpu_loop_exit(cs);
 }
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 57e53e1f1f..b9c79ccd99 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -697,7 +697,7 @@ static int whpx_handle_halt(CPUState *cpu)
           (env->eflags & IF_MASK)) &&
         !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
-        cpu->halted = true;
+        cpu_halted_set(cpu, true);
         ret = 1;
     }
     qemu_mutex_unlock_iothread();
@@ -857,7 +857,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
         (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cpu->halted = false;
+        cpu_halted_set(cpu, false);
     }
 
     if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
@@ -887,7 +887,7 @@ static int whpx_vcpu_run(CPUState *cpu)
     int ret;
 
     whpx_vcpu_process_async_events(cpu);
-    if (cpu->halted) {
+    if (cpu_halted(cpu)) {
         cpu->exception_index = EXCP_HLT;
         atomic_set(&cpu->exit_request, false);
         return 0;
-- 
2.17.1
