Received: from eggs.gnu.org ([2001:4830:134:3::10]:47968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3sH-0007sO-EE
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:35:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3sE-0002C6-Kz
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:35:21 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX3sE-0002Bg-84
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:35:18 -0500
Received: by mail-wm0-x231.google.com with SMTP id r144so129831062wme.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:35:18 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:34:48 +0000
Message-Id: <20170127103505.18606-9-alex.bennee@linaro.org>
In-Reply-To: <20170127103505.18606-1-alex.bennee@linaro.org>
References: <20170127103505.18606-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 08/25] tcg: drop global lock during TCG code
 execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, KONRAD Frederic <fred.konrad@greensocs.com>, "Emilio G . Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:Overall" <qemu-devel@nongnu.org>, "open list:ARM cores" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This finally allows TCG to benefit from the iothread introduction: Drop
the global mutex while running pure TCG CPU code. Reacquire the lock
when entering MMIO or PIO emulation, or when leaving the TCG loop.

We have to revert a few optimization for the current TCG threading
model, namely kicking the TCG thread in qemu_mutex_lock_iothread and not
kicking it in qemu_cpu_kick. We also need to disable RAM block
reordering until we have a more efficient locking mechanism at hand.

Still, a Linux x86 UP guest and my Musicpal ARM model boot fine here.
These numbers demonstrate where we gain something:

20338 jan       20   0  331m  75m 6904 R   99  0.9   0:50.95 qemu-system-arm
20337 jan       20   0  331m  75m 6904 S   20  0.9   0:26.50 qemu-system-arm

The guest CPU was fully loaded, but the iothread could still run mostly
independent on a second core. Without the patch we don't get beyond

32206 jan       20   0  330m  73m 7036 R   82  0.9   1:06.00 qemu-system-arm
32204 jan       20   0  330m  73m 7036 S   21  0.9   0:17.03 qemu-system-arm

We don't benefit significantly, though, when the guest is not fully
loading a host CPU.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-Id: <1439220437-23957-10-git-send-email-fred.konrad@greensocs.com>
[FK: Rebase, fix qemu_devices_reset deadlock, rm address_space_* mutex]
Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
[EGC: fixed iothread lock for cpu-exec IRQ handling]
Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: -smp single-threaded fix, clean commit msg, BQL fixes]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>

---
v8:
 - merged in BQL fixes for PPC target: ppc_set_irq
 - merged in BQL fixes for ARM target: ARM_CP_IO helpers
 - merged in BQL fixes for ARM target: arm_call_el_change_hook

v5 (ajb, base patches):
 - added an assert to BQL unlock/lock functions instead of hanging
 - ensure all cpu->interrupt_requests *modifications* protected by BQL
 - add a re-read on cpu->interrupt_request for correctness
 - BQL fixes for:
   - assert BQL held for PPC hypercalls (emulate_spar_hypercall)
   - SCLP service calls on s390x
 - merge conflict with kick timer patch
v4 (ajb, base patches):
 - protect cpu->interrupt updates with BQL
 - fix wording io_mem_notdirty calls
 - s/we/with/
v3 (ajb, base-patches):
  - stale iothread_unlocks removed (cpu_exit/resume_from_signal deals
  with it in the longjmp).
  - fix re-base conflicts
v2 (ajb):
  - merge with tcg: grab iothread lock in cpu-exec interrupt handling
  - use existing fns for tracking lock state
  - lock iothread for mem_region
    - add assert on mem region modification
    - ensure smm_helper holds iothread
  - Add JK s-o-b
  - Fix-up FK s-o-b annotation
v1 (ajb, base-patches):
  - SMP failure now fixed by previous commit

Changes from Fred Konrad (mttcg-v7 via paolo):
  * Rebase on the current HEAD.
  * Fixes a deadlock in qemu_devices_reset().
  * Remove the mutex in address_space_*
---
 cpu-exec.c                 | 20 ++++++++++++++++++--
 cpus.c                     | 28 +++++-----------------------
 cputlb.c                   | 21 ++++++++++++++++++++-
 exec.c                     | 12 +++++++++---
 hw/core/irq.c              |  1 +
 hw/i386/kvmvapic.c         |  4 ++--
 hw/intc/arm_gicv3_cpuif.c  |  3 +++
 hw/ppc/ppc.c               | 16 +++++++++++++++-
 hw/ppc/spapr.c             |  3 +++
 include/qom/cpu.h          |  1 +
 memory.c                   |  2 ++
 qom/cpu.c                  | 10 ++++++++++
 target/arm/helper.c        |  6 ++++++
 target/arm/op_helper.c     | 43 +++++++++++++++++++++++++++++++++++++++----
 target/i386/smm_helper.c   |  7 +++++++
 target/s390x/misc_helper.c |  5 ++++-
 translate-all.c            |  9 +++++++--
 translate-common.c         | 21 +++++++++++----------
 18 files changed, 163 insertions(+), 49 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index f9e836c8dd..f42a128bdf 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -29,6 +29,7 @@
 #include "qemu/rcu.h"
 #include "exec/tb-hash.h"
 #include "exec/log.h"
+#include "qemu/main-loop.h"
 #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
 #include "hw/i386/apic.h"
 #endif
@@ -388,8 +389,10 @@ static inline bool cpu_handle_halt(CPUState *cpu)
         if ((cpu->interrupt_request & CPU_INTERRUPT_POLL)
             && replay_interrupt()) {
             X86CPU *x86_cpu = X86_CPU(cpu);
+            qemu_mutex_lock_iothread();
             apic_poll_irq(x86_cpu->apic_state);
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
+            qemu_mutex_unlock_iothread();
         }
 #endif
         if (!cpu_has_work(cpu)) {
@@ -443,7 +446,9 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 #else
             if (replay_exception()) {
                 CPUClass *cc = CPU_GET_CLASS(cpu);
+                qemu_mutex_lock_iothread();
                 cc->do_interrupt(cpu);
+                qemu_mutex_unlock_iothread();
                 cpu->exception_index = -1;
             } else if (!replay_has_interrupt()) {
                 /* give a chance to iothread in replay mode */
@@ -469,9 +474,11 @@ static inline void cpu_handle_interrupt(CPUState *cpu,
                                         TranslationBlock **last_tb)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-    int interrupt_request = cpu->interrupt_request;
 
-    if (unlikely(interrupt_request)) {
+    if (unlikely(atomic_read(&cpu->interrupt_request))) {
+        int interrupt_request;
+        qemu_mutex_lock_iothread();
+        interrupt_request = cpu->interrupt_request;
         if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
             /* Mask out external interrupts for this step. */
             interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
@@ -526,7 +533,12 @@ static inline void cpu_handle_interrupt(CPUState *cpu,
                the program flow was changed */
             *last_tb = NULL;
         }
+
+        /* If we exit via cpu_loop_exit/longjmp it is reset in cpu_exec */
+        qemu_mutex_unlock_iothread();
     }
+
+
     if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
         atomic_set(&cpu->exit_request, 0);
         cpu->exception_index = EXCP_INTERRUPT;
@@ -656,8 +668,12 @@ int cpu_exec(CPUState *cpu)
             g_assert(cpu == current_cpu);
             g_assert(cc == CPU_GET_CLASS(cpu));
 #endif /* buggy compiler */
+
             cpu->can_do_io = 1;
             tb_lock_reset();
+            if (qemu_mutex_iothread_locked()) {
+                qemu_mutex_unlock_iothread();
+            }
         }
     } /* for(;;) */
 
diff --git a/cpus.c b/cpus.c
index 6d64199831..c48bc8d5b3 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1026,8 +1026,6 @@ static void qemu_kvm_init_cpu_signals(CPUState *cpu)
 #endif /* _WIN32 */
 
 static QemuMutex qemu_global_mutex;
-static QemuCond qemu_io_proceeded_cond;
-static unsigned iothread_requesting_mutex;
 
 static QemuThread io_thread;
 
@@ -1041,7 +1039,6 @@ void qemu_init_cpu_loop(void)
     qemu_init_sigbus();
     qemu_cond_init(&qemu_cpu_cond);
     qemu_cond_init(&qemu_pause_cond);
-    qemu_cond_init(&qemu_io_proceeded_cond);
     qemu_mutex_init(&qemu_global_mutex);
 
     qemu_thread_get_self(&io_thread);
@@ -1084,10 +1081,6 @@ static void qemu_tcg_wait_io_event(CPUState *cpu)
 
     start_tcg_kick_timer();
 
-    while (iothread_requesting_mutex) {
-        qemu_cond_wait(&qemu_io_proceeded_cond, &qemu_global_mutex);
-    }
-
     CPU_FOREACH(cpu) {
         qemu_wait_io_event_common(cpu);
     }
@@ -1248,9 +1241,11 @@ static int tcg_cpu_exec(CPUState *cpu)
         cpu->icount_decr.u16.low = decr;
         cpu->icount_extra = count;
     }
+    qemu_mutex_unlock_iothread();
     cpu_exec_start(cpu);
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
+    qemu_mutex_lock_iothread();
 #ifdef CONFIG_PROFILER
     tcg_time += profile_getclock() - ti;
 #endif
@@ -1478,27 +1473,14 @@ bool qemu_mutex_iothread_locked(void)
 
 void qemu_mutex_lock_iothread(void)
 {
-    atomic_inc(&iothread_requesting_mutex);
-    /* In the simple case there is no need to bump the VCPU thread out of
-     * TCG code execution.
-     */
-    if (!tcg_enabled() || qemu_in_vcpu_thread() ||
-        !first_cpu || !first_cpu->created) {
-        qemu_mutex_lock(&qemu_global_mutex);
-        atomic_dec(&iothread_requesting_mutex);
-    } else {
-        if (qemu_mutex_trylock(&qemu_global_mutex)) {
-            qemu_cpu_kick_rr_cpu();
-            qemu_mutex_lock(&qemu_global_mutex);
-        }
-        atomic_dec(&iothread_requesting_mutex);
-        qemu_cond_broadcast(&qemu_io_proceeded_cond);
-    }
+    g_assert(!qemu_mutex_iothread_locked());
+    qemu_mutex_lock(&qemu_global_mutex);
     iothread_locked = true;
 }
 
 void qemu_mutex_unlock_iothread(void)
 {
+    g_assert(qemu_mutex_iothread_locked());
     iothread_locked = false;
     qemu_mutex_unlock(&qemu_global_mutex);
 }
diff --git a/cputlb.c b/cputlb.c
index 6c39927455..1cc9d9da51 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/memory.h"
@@ -495,6 +496,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     hwaddr physaddr = iotlbentry->addr;
     MemoryRegion *mr = iotlb_to_region(cpu, physaddr, iotlbentry->attrs);
     uint64_t val;
+    bool locked = false;
 
     physaddr = (physaddr & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
@@ -503,7 +505,16 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     }
 
     cpu->mem_io_vaddr = addr;
+
+    if (mr->global_locking) {
+        qemu_mutex_lock_iothread();
+        locked = true;
+    }
     memory_region_dispatch_read(mr, physaddr, &val, size, iotlbentry->attrs);
+    if (locked) {
+        qemu_mutex_unlock_iothread();
+    }
+
     return val;
 }
 
@@ -514,15 +525,23 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     CPUState *cpu = ENV_GET_CPU(env);
     hwaddr physaddr = iotlbentry->addr;
     MemoryRegion *mr = iotlb_to_region(cpu, physaddr, iotlbentry->attrs);
+    bool locked = false;
 
     physaddr = (physaddr & TARGET_PAGE_MASK) + addr;
     if (mr != &io_mem_rom && mr != &io_mem_notdirty && !cpu->can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
-
     cpu->mem_io_vaddr = addr;
     cpu->mem_io_pc = retaddr;
+
+    if (mr->global_locking) {
+        qemu_mutex_lock_iothread();
+        locked = true;
+    }
     memory_region_dispatch_write(mr, physaddr, val, size, iotlbentry->attrs);
+    if (locked) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 /* Return true if ADDR is present in the victim tlb, and has been copied
diff --git a/exec.c b/exec.c
index f2bed92b64..87cf0db91e 100644
--- a/exec.c
+++ b/exec.c
@@ -2133,9 +2133,9 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
                 }
                 cpu->watchpoint_hit = wp;
 
-                /* The tb_lock will be reset when cpu_loop_exit or
-                 * cpu_loop_exit_noexc longjmp back into the cpu_exec
-                 * main loop.
+                /* Both tb_lock and iothread_mutex will be reset when
+                 * cpu_loop_exit or cpu_loop_exit_noexc longjmp
+                 * back into the cpu_exec main loop.
                  */
                 tb_lock();
                 tb_check_watchpoint(cpu);
@@ -2370,8 +2370,14 @@ static void io_mem_init(void)
     memory_region_init_io(&io_mem_rom, NULL, &unassigned_mem_ops, NULL, NULL, UINT64_MAX);
     memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,
                           NULL, UINT64_MAX);
+
+    /* io_mem_notdirty calls tb_invalidate_phys_page_fast,
+     * which can be called without the iothread mutex.
+     */
     memory_region_init_io(&io_mem_notdirty, NULL, &notdirty_mem_ops, NULL,
                           NULL, UINT64_MAX);
+    memory_region_clear_global_locking(&io_mem_notdirty);
+
     memory_region_init_io(&io_mem_watch, NULL, &watch_mem_ops, NULL,
                           NULL, UINT64_MAX);
 }
diff --git a/hw/core/irq.c b/hw/core/irq.c
index 49ff2e64fe..b98d1d69f5 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu-common.h"
 #include "hw/irq.h"
 #include "qom/object.h"
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 702e281dc8..b3c49b2c61 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -451,8 +451,8 @@ static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
     resume_all_vcpus();
 
     if (!kvm_enabled()) {
-        /* tb_lock will be reset when cpu_loop_exit_noexc longjmps
-         * back into the cpu_exec loop. */
+        /* Both tb_lock and iothread_mutex will be reset when
+         *  longjmps back into the cpu_exec loop. */
         tb_lock();
         tb_gen_code(cs, current_pc, current_cs_base, current_flags, 1);
         cpu_loop_exit_noexc(cs);
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index a9ee7fddf9..2624d8d909 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/main-loop.h"
 #include "trace.h"
 #include "gicv3_internal.h"
 #include "cpu.h"
@@ -733,6 +734,8 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs->cpu);
     CPUARMState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     trace_gicv3_cpuif_update(gicv3_redist_affid(cs), cs->hppi.irq,
                              cs->hppi.grp, cs->hppi.prio);
 
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 8945869009..59c3faa6c8 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -62,7 +62,16 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    unsigned int old_pending = env->pending_interrupts;
+    unsigned int old_pending;
+    bool locked = false;
+
+    /* We may already have the BQL if coming from the reset path */
+    if (!qemu_mutex_iothread_locked()) {
+        locked = true;
+        qemu_mutex_lock_iothread();
+    }
+
+    old_pending = env->pending_interrupts;
 
     if (level) {
         env->pending_interrupts |= 1 << n_IRQ;
@@ -80,9 +89,14 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
 #endif
     }
 
+
     LOG_IRQ("%s: %p n_IRQ %d level %d => pending %08" PRIx32
                 "req %08x\n", __func__, env, n_IRQ, level,
                 env->pending_interrupts, CPU(cpu)->interrupt_request);
+
+    if (locked) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 /* PowerPC 6xx / 7xx internal IRQ controller */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a642e663d4..745743d64b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1012,6 +1012,9 @@ static void emulate_spapr_hypercall(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
 
+    /* The TCG path should also be holding the BQL at this point */
+    g_assert(qemu_mutex_iothread_locked());
+
     if (msr_pr) {
         hcall_dprintf("Hypercall made with MSR[PR]=1\n");
         env->gpr[3] = H_PRIVILEGE;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 11db2015a4..1a06ae5938 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -325,6 +325,7 @@ struct CPUState {
     bool unplug;
     bool crash_occurred;
     bool exit_request;
+    /* updates protected by BQL */
     uint32_t interrupt_request;
     int singlestep_enabled;
     int64_t icount_extra;
diff --git a/memory.c b/memory.c
index 2bfc37f65c..7d7b285e41 100644
--- a/memory.c
+++ b/memory.c
@@ -917,6 +917,8 @@ void memory_region_transaction_commit(void)
     AddressSpace *as;
 
     assert(memory_region_transaction_depth);
+    assert(qemu_mutex_iothread_locked());
+
     --memory_region_transaction_depth;
     if (!memory_region_transaction_depth) {
         if (memory_region_update_pending) {
diff --git a/qom/cpu.c b/qom/cpu.c
index 7f575879f6..bd77c05cd0 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -113,9 +113,19 @@ static void cpu_common_get_memory_mapping(CPUState *cpu,
     error_setg(errp, "Obtaining memory mappings is unsupported on this CPU.");
 }
 
+/* Resetting the IRQ comes from across the code base so we take the
+ * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
 {
+    bool need_lock = !qemu_mutex_iothread_locked();
+
+    if (need_lock) {
+        qemu_mutex_lock_iothread();
+    }
     cpu->interrupt_request &= ~mask;
+    if (need_lock) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 void cpu_exit(CPUState *cpu)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7111c8cf18..84d789be93 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6693,6 +6693,12 @@ void arm_cpu_do_interrupt(CPUState *cs)
         arm_cpu_do_interrupt_aarch32(cs);
     }
 
+    /* Hooks may change global state so BQL should be held, also the
+     * BQL needs to be held for any modification of
+     * cs->interrupt_request.
+     */
+    g_assert(qemu_mutex_iothread_locked());
+
     arm_call_el_change_hook(cpu);
 
     if (!kvm_enabled()) {
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index ba796d898e..e1a883c595 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "internals.h"
@@ -487,7 +488,9 @@ void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
      */
     env->regs[15] &= (env->thumb ? ~1 : ~3);
 
+    qemu_mutex_lock_iothread();
     arm_call_el_change_hook(arm_env_get_cpu(env));
+    qemu_mutex_unlock_iothread();
 }
 
 /* Access to user mode registers from privileged modes.  */
@@ -735,28 +738,58 @@ void HELPER(set_cp_reg)(CPUARMState *env, void *rip, uint32_t value)
 {
     const ARMCPRegInfo *ri = rip;
 
-    ri->writefn(env, ri, value);
+    if (ri->type & ARM_CP_IO) {
+        qemu_mutex_lock_iothread();
+        ri->writefn(env, ri, value);
+        qemu_mutex_unlock_iothread();
+    } else {
+        ri->writefn(env, ri, value);
+    }
 }
 
 uint32_t HELPER(get_cp_reg)(CPUARMState *env, void *rip)
 {
     const ARMCPRegInfo *ri = rip;
+    uint32_t res;
 
-    return ri->readfn(env, ri);
+    if (ri->type & ARM_CP_IO) {
+        qemu_mutex_lock_iothread();
+        res = ri->readfn(env, ri);
+        qemu_mutex_unlock_iothread();
+    } else {
+        res = ri->readfn(env, ri);
+    }
+
+    return res;
 }
 
 void HELPER(set_cp_reg64)(CPUARMState *env, void *rip, uint64_t value)
 {
     const ARMCPRegInfo *ri = rip;
 
-    ri->writefn(env, ri, value);
+    if (ri->type & ARM_CP_IO) {
+        qemu_mutex_lock_iothread();
+        ri->writefn(env, ri, value);
+        qemu_mutex_unlock_iothread();
+    } else {
+        ri->writefn(env, ri, value);
+    }
 }
 
 uint64_t HELPER(get_cp_reg64)(CPUARMState *env, void *rip)
 {
     const ARMCPRegInfo *ri = rip;
+    uint64_t res;
+
+    if (ri->type & ARM_CP_IO) {
+        qemu_mutex_lock_iothread();
+        res = ri->readfn(env, ri);
+        qemu_mutex_unlock_iothread();
+    } else {
+        res = ri->readfn(env, ri);
+    }
 
-    return ri->readfn(env, ri);
+    return res;
 }
 
 void HELPER(msr_i_pstate)(CPUARMState *env, uint32_t op, uint32_t imm)
@@ -989,7 +1022,9 @@ void HELPER(exception_return)(CPUARMState *env)
                       cur_el, new_el, env->pc);
     }
 
+    qemu_mutex_lock_iothread();
     arm_call_el_change_hook(arm_env_get_cpu(env));
+    qemu_mutex_unlock_iothread();
 
     return;
 
diff --git a/target/i386/smm_helper.c b/target/i386/smm_helper.c
index 4dd6a2c544..f051a77c4a 100644
--- a/target/i386/smm_helper.c
+++ b/target/i386/smm_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/log.h"
@@ -42,11 +43,14 @@ void helper_rsm(CPUX86State *env)
 #define SMM_REVISION_ID 0x00020000
 #endif
 
+/* Called with iothread lock taken */
 void cpu_smm_update(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     bool smm_enabled = (env->hflags & HF_SMM_MASK);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     if (cpu->smram) {
         memory_region_set_enabled(cpu->smram, smm_enabled);
     }
@@ -333,7 +337,10 @@ void helper_rsm(CPUX86State *env)
     }
     env->hflags2 &= ~HF2_SMM_INSIDE_NMI_MASK;
     env->hflags &= ~HF_SMM_MASK;
+
+    qemu_mutex_lock_iothread();
     cpu_smm_update(cpu);
+    qemu_mutex_unlock_iothread();
 
     qemu_log_mask(CPU_LOG_INT, "SMM: after RSM\n");
     log_cpu_state_mask(CPU_LOG_INT, CPU(cpu), CPU_DUMP_CCOP);
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index c9604ea9c7..3cb942e8bb 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -25,6 +25,7 @@
 #include "exec/helper-proto.h"
 #include "sysemu/kvm.h"
 #include "qemu/timer.h"
+#include "qemu/main-loop.h"
 #include "exec/address-spaces.h"
 #ifdef CONFIG_KVM
 #include <linux/kvm.h>
@@ -109,11 +110,13 @@ void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
 /* SCLP service call */
 uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
 {
+    qemu_mutex_lock_iothread();
     int r = sclp_service_call(env, r1, r2);
     if (r < 0) {
         program_interrupt(env, -r, 4);
-        return 0;
+        r = 0;
     }
+    qemu_mutex_unlock_iothread();
     return r;
 }
 
diff --git a/translate-all.c b/translate-all.c
index 055436a676..41b36f04c6 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -55,6 +55,7 @@
 #include "translate-all.h"
 #include "qemu/bitmap.h"
 #include "qemu/timer.h"
+#include "qemu/main-loop.h"
 #include "exec/log.h"
 
 /* #define DEBUG_TB_INVALIDATE */
@@ -1521,7 +1522,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
 #ifdef CONFIG_SOFTMMU
 /* len must be <= 8 and start must be a multiple of len.
  * Called via softmmu_template.h when code areas are written to with
- * tb_lock held.
+ * iothread mutex not held.
  */
 void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
 {
@@ -1723,7 +1724,10 @@ void tb_check_watchpoint(CPUState *cpu)
 
 #ifndef CONFIG_USER_ONLY
 /* in deterministic execution mode, instructions doing device I/Os
-   must be at the end of the TB */
+ * must be at the end of the TB.
+ *
+ * Called by softmmu_template.h, with iothread mutex not held.
+ */
 void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
 {
 #if defined(TARGET_MIPS) || defined(TARGET_SH4)
@@ -1935,6 +1939,7 @@ void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
 
 void cpu_interrupt(CPUState *cpu, int mask)
 {
+    g_assert(qemu_mutex_iothread_locked());
     cpu->interrupt_request |= mask;
     cpu->tcg_exit_req = 1;
 }
diff --git a/translate-common.c b/translate-common.c
index 5e989cdf70..d504dd0d33 100644
--- a/translate-common.c
+++ b/translate-common.c
@@ -21,6 +21,7 @@
 #include "qemu-common.h"
 #include "qom/cpu.h"
 #include "sysemu/cpus.h"
+#include "qemu/main-loop.h"
 
 uintptr_t qemu_real_host_page_size;
 intptr_t qemu_real_host_page_mask;
@@ -30,6 +31,7 @@ intptr_t qemu_real_host_page_mask;
 static void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
     int old_mask;
+    g_assert(qemu_mutex_iothread_locked());
 
     old_mask = cpu->interrupt_request;
     cpu->interrupt_request |= mask;
@@ -40,17 +42,16 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
      */
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
-        return;
-    }
-
-    if (use_icount) {
-        cpu->icount_decr.u16.high = 0xffff;
-        if (!cpu->can_do_io
-            && (mask & ~old_mask) != 0) {
-            cpu_abort(cpu, "Raised interrupt while not in I/O function");
-        }
     } else {
-        cpu->tcg_exit_req = 1;
+        if (use_icount) {
+            cpu->icount_decr.u16.high = 0xffff;
+            if (!cpu->can_do_io
+                && (mask & ~old_mask) != 0) {
+                cpu_abort(cpu, "Raised interrupt while not in I/O function");
+            }
+        } else {
+            cpu->tcg_exit_req = 1;
+        }
     }
 }
 
-- 
2.11.0
