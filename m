Received: from eggs.gnu.org ([2001:4830:134:3::10]:59486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJG4-00058V-2c
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFx-0003Zt-UT
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:17 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:00 -0400
Message-Id: <20181019010625.25294-32-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 31/56] ppc: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/ppc/ppc.c                    |  2 +-
 target/ppc/excp_helper.c        |  2 +-
 target/ppc/kvm.c                |  6 ++++--
 target/ppc/translate_init.inc.c | 14 +++++++-------
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index d1a5a0b877..bc1cefa13f 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -91,7 +91,7 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
 
     LOG_IRQ("%s: %p n_IRQ %d level %d => pending %08" PRIx32
                 "req %08x\n", __func__, env, n_IRQ, level,
-                env->pending_interrupts, CPU(cpu)->interrupt_request);
+                env->pending_interrupts, cpu_interrupt_request(CPU(cpu)));
 
     if (locked) {
         qemu_mutex_unlock_iothread();
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 737c9c72be..75a434f46b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -753,7 +753,7 @@ static void ppc_hw_interrupt(CPUPPCState *env)
 
     qemu_log_mask(CPU_LOG_INT, "%s: %p pending %08x req %08x me %d ee %d\n",
                   __func__, env, env->pending_interrupts,
-                  cs->interrupt_request, (int)msr_me, (int)msr_ee);
+                  cpu_interrupt_request(cs), (int)msr_me, (int)msr_ee);
 #endif
     /* External reset */
     if (env->pending_interrupts & (1 << PPC_INTERRUPT_RESET)) {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index dc6b8d5e9e..1e1a69f49e 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1334,7 +1334,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
      * interrupt, reset, etc) in PPC-specific env->irq_input_state. */
     if (!cap_interrupt_level &&
         run->ready_for_interrupt_injection &&
-        (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+        (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
         (env->irq_input_state & (1<<PPC_INPUT_INT)))
     {
         /* For now KVM disregards the 'irq' argument. However, in the
@@ -1376,10 +1376,12 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD) && (msr_ee)) {
+    cpu_mutex_lock(cs);
+    if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) && (msr_ee)) {
         cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
     }
+    cpu_mutex_unlock(cs);
 
     return 0;
 }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 0e423bea69..6827db14b6 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8446,7 +8446,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
@@ -8470,7 +8470,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -8600,7 +8600,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
@@ -8632,7 +8632,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -8792,7 +8792,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         /* External Exception */
@@ -8825,7 +8825,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -10236,7 +10236,7 @@ static bool ppc_cpu_has_work(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+    return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
 }
 
 /* CPUClass::reset() */
-- 
2.17.1
