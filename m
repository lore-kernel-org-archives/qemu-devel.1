Received: from eggs.gnu.org ([2001:4830:134:3::10]:33982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1ds3cK-0001Sm-IF
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1ds3cH-0007Ql-0B
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:05:56 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:35036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1ds3cG-0007QL-QC
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:05:52 -0400
Received: by mail-vk0-x242.google.com with SMTP id t10so3326425vke.2
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 02:05:52 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Wed, 13 Sep 2017 04:05:13 -0500
Message-Id: <20170913090522.4022-6-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170913090522.4022-1-Sergio.G.DelReal@gmail.com>
References: <20170913090522.4022-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH v4 05/14] hvf: add code to cpus.c and do
 refactoring in preparation for compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@gmail.com, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

The files originally added from Google's repository in previous patches
won't compile cleanly unless some functions are implemented in cpus.c and some
other reorganization is done. This patch adds that code and does some
general refactoring in preparation for compiling in subsequent patches.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 cpus.c                             |  47 ++++
 include/sysemu/hvf.h               |  30 ++-
 target/i386/hvf-all.c              | 485 +++++++++++++++++--------------------
 target/i386/hvf-utils/x86.c        |   2 +-
 target/i386/hvf-utils/x86_cpuid.h  |   2 +-
 target/i386/hvf-utils/x86_decode.h |   8 +
 target/i386/hvf-utils/x86_descr.h  |   6 +
 target/i386/hvf-utils/x86_emu.c    |   5 +-
 target/i386/hvf-utils/x86_emu.h    |  15 ++
 target/i386/hvf-utils/x86_flags.h  |   2 +
 target/i386/hvf-utils/x86hvf.c     |   3 -
 target/i386/hvf-utils/x86hvf.h     |   2 +
 12 files changed, 326 insertions(+), 281 deletions(-)

diff --git a/cpus.c b/cpus.c
index a2cd9dfa5d..414c04ca6b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -37,6 +37,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
+#include "sysemu/hvf.h"
 #include "qmp-commands.h"
 #include "exec/exec-all.h"
 
@@ -900,6 +901,10 @@ void cpu_synchronize_all_states(void)
 
     CPU_FOREACH(cpu) {
         cpu_synchronize_state(cpu);
+        /* TODO: move to cpu_synchronize_state() */
+        if (hvf_enabled()) {
+            hvf_cpu_synchronize_state(cpu);
+        }
     }
 }
 
@@ -909,6 +914,10 @@ void cpu_synchronize_all_post_reset(void)
 
     CPU_FOREACH(cpu) {
         cpu_synchronize_post_reset(cpu);
+        /* TODO: move to cpu_synchronize_post_reset() */
+        if (hvf_enabled()) {
+            hvf_cpu_synchronize_post_reset(cpu);
+        }
     }
 }
 
@@ -918,6 +927,10 @@ void cpu_synchronize_all_post_init(void)
 
     CPU_FOREACH(cpu) {
         cpu_synchronize_post_init(cpu);
+        /* TODO: move to cpu_synchronize_post_init() */
+        if (hvf_enabled()) {
+            hvf_cpu_synchronize_post_init(cpu);
+        }
     }
 }
 
@@ -1098,6 +1111,14 @@ static void qemu_kvm_wait_io_event(CPUState *cpu)
     qemu_wait_io_event_common(cpu);
 }
 
+static void qemu_hvf_wait_io_event(CPUState *cpu)
+{
+    while (cpu_thread_is_idle(cpu)) {
+        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+    }
+    qemu_wait_io_event_common(cpu);
+}
+
 static void *qemu_kvm_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
@@ -1564,6 +1585,9 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
         fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
         exit(1);
     }
+    if (hvf_enabled()) {
+        cpu_exit(cpu);
+    }
 #else /* _WIN32 */
     if (!qemu_cpu_is_self(cpu)) {
         if (!QueueUserAPC(dummy_apc_func, cpu->hThread, 0)) {
@@ -1780,6 +1804,27 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
     }
 }
 
+static void qemu_hvf_start_vcpu(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    /* HVF currently does not support TCG, and only runs in
+     * unrestricted-guest mode. */
+    assert(hvf_enabled());
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+    while (!cpu->created) {
+        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
+    }
+}
+
 static void qemu_dummy_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -1816,6 +1861,8 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_kvm_start_vcpu(cpu);
     } else if (hax_enabled()) {
         qemu_hax_start_vcpu(cpu);
+    } else if (hvf_enabled()) {
+        qemu_hvf_start_vcpu(cpu);
     } else if (tcg_enabled()) {
         qemu_tcg_init_vcpu(cpu);
     } else {
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index d068a95e93..614a2d203b 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -15,15 +15,24 @@
 #include "config-host.h"
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "hw/hw.h"
-#include "target/i386/cpu.h"
 #include "qemu/bitops.h"
 #include "exec/memory.h"
 #include "sysemu/accel.h"
+
+extern int hvf_disabled;
+#ifdef CONFIG_HVF
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
 #include <Hypervisor/hv_error.h>
-
+#include "target/i386/cpu.h"
+#include "hw/hw.h"
+uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
+                                 int reg);
+#define hvf_enabled() !hvf_disabled
+#else
+#define hvf_enabled() 0
+#define hvf_get_supported_cpuid(func, idx, reg) 0
+#endif
 
 typedef struct hvf_slot {
     uint64_t start;
@@ -32,22 +41,21 @@ typedef struct hvf_slot {
     int slot_id;
 } hvf_slot;
 
-struct hvf_vcpu_caps {
+typedef struct hvf_vcpu_caps {
     uint64_t vmx_cap_pinbased;
     uint64_t vmx_cap_procbased;
     uint64_t vmx_cap_procbased2;
     uint64_t vmx_cap_entry;
     uint64_t vmx_cap_exit;
     uint64_t vmx_cap_preemption_timer;
-};
+} hvf_vcpu_caps;
 
-int __hvf_set_memory(hvf_slot *);
 typedef struct HVFState {
     AccelState parent;
     hvf_slot slots[32];
     int num_slots;
 
-    struct hvf_vcpu_caps *hvf_caps;
+    hvf_vcpu_caps *hvf_caps;
 } HVFState;
 extern HVFState *hvf_state;
 
@@ -56,8 +64,6 @@ void hvf_handle_io(CPUArchState *, uint16_t, void *,
                   int, int, int);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 
-/* Returns 1 if HVF is available and enabled, 0 otherwise. */
-int hvf_enabled(void);
 /* Disable HVF if |disable| is 1, otherwise, enable it iff it is supported by
  * the host CPU. Use hvf_enabled() after this to get the result. */
 void hvf_disable(int disable);
@@ -82,13 +88,11 @@ void _hvf_cpu_synchronize_post_init(CPUState *, run_on_cpu_data);
 void hvf_vcpu_destroy(CPUState *);
 void hvf_raise_event(CPUState *);
 /* void hvf_reset_vcpu_state(void *opaque); */
-void vmx_reset_vcpu(CPUState *);
-void __hvf_cpu_synchronize_state(CPUState *, run_on_cpu_data);
-void __hvf_cpu_synchronize_post_reset(CPUState *, run_on_cpu_data);
+void hvf_reset_vcpu(CPUState *);
 void vmx_update_tpr(CPUState *);
 void update_apic_tpr(CPUState *);
-int apic_get_highest_priority_irr(DeviceState *);
 int hvf_put_registers(CPUState *);
+void vmx_clear_int_window_exiting(CPUState *cpu);
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
diff --git a/target/i386/hvf-all.c b/target/i386/hvf-all.c
index bf70737d2f..7ccc6b4743 100644
--- a/target/i386/hvf-all.c
+++ b/target/i386/hvf-all.c
@@ -53,7 +53,7 @@
 
 pthread_rwlock_t mem_lock = PTHREAD_RWLOCK_INITIALIZER;
 HVFState *hvf_state;
-static int hvf_disabled = 1;
+int hvf_disabled = 1;
 
 static void assert_hvf_ok(hv_return_t ret)
 {
@@ -62,26 +62,26 @@ static void assert_hvf_ok(hv_return_t ret)
     }
 
     switch (ret) {
-        case HV_ERROR:
-            fprintf(stderr, "Error: HV_ERROR\n");
-            break;
-        case HV_BUSY:
-            fprintf(stderr, "Error: HV_BUSY\n");
-            break;
-        case HV_BAD_ARGUMENT:
-            fprintf(stderr, "Error: HV_BAD_ARGUMENT\n");
-            break;
-        case HV_NO_RESOURCES:
-            fprintf(stderr, "Error: HV_NO_RESOURCES\n");
-            break;
-        case HV_NO_DEVICE:
-            fprintf(stderr, "Error: HV_NO_DEVICE\n");
-            break;
-        case HV_UNSUPPORTED:
-            fprintf(stderr, "Error: HV_UNSUPPORTED\n");
-            break;
-        default:
-            fprintf(stderr, "Unknown Error\n");
+    case HV_ERROR:
+        error_report("Error: HV_ERROR\n");
+        break;
+    case HV_BUSY:
+        error_report("Error: HV_BUSY\n");
+        break;
+    case HV_BAD_ARGUMENT:
+        error_report("Error: HV_BAD_ARGUMENT\n");
+        break;
+    case HV_NO_RESOURCES:
+        error_report("Error: HV_NO_RESOURCES\n");
+        break;
+    case HV_NO_DEVICE:
+        error_report("Error: HV_NO_DEVICE\n");
+        break;
+    case HV_UNSUPPORTED:
+        error_report("Error: HV_UNSUPPORTED\n");
+        break;
+    default:
+        error_report("Unknown Error\n");
     }
 
     abort();
@@ -112,11 +112,10 @@ struct mac_slot {
 struct mac_slot mac_slots[32];
 #define ALIGN(x, y)  (((x) + (y) - 1) & ~((y) - 1))
 
-int __hvf_set_memory(hvf_slot *slot)
+static int do_hvf_set_memory(hvf_slot *slot)
 {
     struct mac_slot *macslot;
     hv_memory_flags_t flags;
-    pthread_rwlock_wrlock(&mem_lock);
     hv_return_t ret;
 
     macslot = &mac_slots[slot->slot_id];
@@ -130,7 +129,6 @@ int __hvf_set_memory(hvf_slot *slot)
     }
 
     if (!slot->size) {
-        pthread_rwlock_unlock(&mem_lock);
         return 0;
     }
 
@@ -141,7 +139,6 @@ int __hvf_set_memory(hvf_slot *slot)
     macslot->size = slot->size;
     ret = hv_vm_map((hv_uvaddr_t)slot->mem, slot->start, slot->size, flags);
     assert_hvf_ok(ret);
-    pthread_rwlock_unlock(&mem_lock);
     return 0;
 }
 
@@ -170,8 +167,8 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     /* Region needs to be reset. set the size to 0 and remap it. */
     if (mem) {
         mem->size = 0;
-        if (__hvf_set_memory(mem)) {
-            fprintf(stderr, "Failed to reset overlapping slot\n");
+        if (do_hvf_set_memory(mem)) {
+            error_report("Failed to reset overlapping slot\n");
             abort();
         }
     }
@@ -191,7 +188,7 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     }
 
     if (x == hvf_state->num_slots) {
-        fprintf(stderr, "No free slots\n");
+        error_report("No free slots\n");
         abort();
     }
 
@@ -199,24 +196,12 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     mem->mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
     mem->start = section->offset_within_address_space;
 
-    if (__hvf_set_memory(mem)) {
-        fprintf(stderr, "Error registering new memory slot\n");
+    if (do_hvf_set_memory(mem)) {
+        error_report("Error registering new memory slot\n");
         abort();
     }
 }
 
-/* return -1 if no bit is set */
-static int get_highest_priority_int(uint32_t *tab)
-{
-    int i;
-    for (i = 7; i >= 0; i--) {
-        if (tab[i] != 0) {
-            return i * 32 + apic_fls_bit(tab[i]);
-        }
-    }
-    return -1;
-}
-
 void vmx_update_tpr(CPUState *cpu)
 {
     /* TODO: need integrate APIC handling */
@@ -263,11 +248,11 @@ void hvf_handle_io(CPUArchState *env, uint16_t port, void *buffer,
         ptr += size;
     }
 }
-void __hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 
 /* TODO: synchronize vcpu state */
+static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    CPUState *cpu_state = cpu;//(CPUState *)data;
+    CPUState *cpu_state = cpu;
     if (cpu_state->hvf_vcpu_dirty == 0) {
         hvf_get_registers(cpu_state);
     }
@@ -277,12 +262,12 @@ void __hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 
 void hvf_cpu_synchronize_state(CPUState *cpu_state)
 {
-        run_on_cpu(cpu_state, __hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
     if (cpu_state->hvf_vcpu_dirty == 0) {
+        run_on_cpu(cpu_state, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
 
-void __hvf_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
+static void do_hvf_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
 {
     CPUState *cpu_state = cpu;
     hvf_put_registers(cpu_state);
@@ -291,7 +276,7 @@ void __hvf_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
 
 void hvf_cpu_synchronize_post_reset(CPUState *cpu_state)
 {
-    run_on_cpu(cpu_state, __hvf_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
+    run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
 }
 
 void _hvf_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
@@ -354,12 +339,11 @@ static MemoryListener hvf_memory_listener = {
     .region_del = hvf_region_del,
 };
 
-static MemoryListener hvf_io_listener = {
-    .priority = 10,
-};
-
-void vmx_reset_vcpu(CPUState *cpu) {
+void hvf_reset_vcpu(CPUState *cpu) {
 
+    /* TODO: this shouldn't be needed; there is already a call to
+     * cpu_synchronize_all_post_reset in vl.c
+     */
     wvmcs(cpu->hvf_fd, VMCS_ENTRY_CTLS, 0);
     wvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER, 0);
     macvm_set_cr0(cpu->hvf_fd, 0x60000010);
@@ -514,7 +498,7 @@ int hvf_init_vcpu(CPUState *cpu)
 
     wvmcs(cpu->hvf_fd, VMCS_TPR_THRESHOLD, 0);
 
-    vmx_reset_vcpu(cpu);
+    hvf_reset_vcpu(cpu);
 
     x86cpu = X86_CPU(cpu);
     x86cpu->env.kvm_xsave_buf = qemu_memalign(4096,
@@ -536,7 +520,6 @@ int hvf_init_vcpu(CPUState *cpu)
     return 0;
 }
 
-int hvf_enabled() { return !hvf_disabled; }
 void hvf_disable(int shouldDisable)
 {
     hvf_disabled = shouldDisable;
@@ -589,8 +572,6 @@ int hvf_vcpu_exec(CPUState *cpu)
         RFLAGS(cpu) = rreg(cpu->hvf_fd, HV_X86_RFLAGS);
         env->eflags = RFLAGS(cpu);
 
-        trace_hvf_vm_exit(exit_reason, exit_qual);
-
         qemu_mutex_lock_iothread();
 
         update_apic_tpr(cpu);
@@ -598,239 +579,226 @@ int hvf_vcpu_exec(CPUState *cpu)
 
         ret = 0;
         switch (exit_reason) {
-            case EXIT_REASON_HLT: {
-                macvm_set_rip(cpu, rip + ins_len);
-                if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) && (EFLAGS(cpu) & IF_MASK))
-                    && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
-                    !(idtvec_info & VMCS_IDT_VEC_VALID)) {
-                    cpu->halted = 1;
-                    ret = EXCP_HLT;
-                }
-                ret = EXCP_INTERRUPT;
-                break;
-            }
-            case EXIT_REASON_MWAIT: {
-                ret = EXCP_INTERRUPT;
-                break;
+        case EXIT_REASON_HLT: {
+            macvm_set_rip(cpu, rip + ins_len);
+            if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+                (EFLAGS(cpu) & IF_MASK))
+                && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
+                !(idtvec_info & VMCS_IDT_VEC_VALID)) {
+                cpu->halted = 1;
+                ret = EXCP_HLT;
             }
-                /* Need to check if MMIO or unmmaped fault */
-            case EXIT_REASON_EPT_FAULT:
-            {
-                hvf_slot *slot;
-                addr_t gpa = rvmcs(cpu->hvf_fd, VMCS_GUEST_PHYSICAL_ADDRESS);
-                trace_hvf_vm_exit_gpa(gpa);
-
-                if ((idtvec_info & VMCS_IDT_VEC_VALID) == 0 && (exit_qual & EXIT_QUAL_NMIUDTI) != 0)
-                    vmx_set_nmi_blocking(cpu);
-
-                slot = hvf_find_overlap_slot(gpa, gpa);
-                // mmio
-                if (ept_emulation_fault(exit_qual) && !slot) {
-                    struct x86_decode decode;
-
-                    load_regs(cpu);
-                    cpu->hvf_x86->fetch_rip = rip;
-
-                    decode_instruction(cpu, &decode);
-                    exec_instruction(cpu, &decode);
-                    store_regs(cpu);
-                    break;
-                }
-#ifdef DIRTY_VGA_TRACKING
-                if (slot) {
-                    bool read = exit_qual & EPT_VIOLATION_DATA_READ ? 1 : 0;
-                    bool write = exit_qual & EPT_VIOLATION_DATA_WRITE ? 1 : 0;
-                    if (!read && !write)
-                        break;
-                    int flags = HV_MEMORY_READ | HV_MEMORY_EXEC;
-                    if (write) flags |= HV_MEMORY_WRITE;
-
-                    pthread_rwlock_wrlock(&mem_lock);
-                    if (write)
-                        mark_slot_page_dirty(slot, gpa);
-                    hv_vm_protect(gpa & ~0xfff, 4096, flags);
-                    pthread_rwlock_unlock(&mem_lock);
-                }
-#endif
-                break;
+            ret = EXCP_INTERRUPT;
+            break;
+        }
+        case EXIT_REASON_MWAIT: {
+            ret = EXCP_INTERRUPT;
+            break;
+        }
+            /* Need to check if MMIO or unmmaped fault */
+        case EXIT_REASON_EPT_FAULT:
+        {
+            hvf_slot *slot;
+            addr_t gpa = rvmcs(cpu->hvf_fd, VMCS_GUEST_PHYSICAL_ADDRESS);
+
+            if (((idtvec_info & VMCS_IDT_VEC_VALID) == 0) &&
+                ((exit_qual & EXIT_QUAL_NMIUDTI) != 0)) {
+                vmx_set_nmi_blocking(cpu);
             }
-            case EXIT_REASON_INOUT:
-            {
-                uint32_t in = (exit_qual & 8) != 0;
-                uint32_t size =  (exit_qual & 7) + 1;
-                uint32_t string =  (exit_qual & 16) != 0;
-                uint32_t port =  exit_qual >> 16;
-                //uint32_t rep = (exit_qual & 0x20) != 0;
 
-#if 1
-                if (!string && in) {
-                    uint64_t val = 0;
-                    load_regs(cpu);
-                    hvf_handle_io(env, port, &val, 0, size, 1);
-                    if (size == 1) AL(cpu) = val;
-                    else if (size == 2) AX(cpu) = val;
-                    else if (size == 4) RAX(cpu) = (uint32_t)val;
-                    else VM_PANIC("size");
-                    RIP(cpu) += ins_len;
-                    store_regs(cpu);
-                    break;
-                } else if (!string && !in) {
-                    RAX(cpu) = rreg(cpu->hvf_fd, HV_X86_RAX);
-                    hvf_handle_io(env, port, &RAX(cpu), 1, size, 1);
-                    macvm_set_rip(cpu, rip + ins_len);
-                    break;
-                }
-#endif
+            slot = hvf_find_overlap_slot(gpa, gpa);
+            /* mmio */
+            if (ept_emulation_fault(exit_qual) && !slot) {
                 struct x86_decode decode;
 
                 load_regs(cpu);
                 cpu->hvf_x86->fetch_rip = rip;
 
                 decode_instruction(cpu, &decode);
-                VM_PANIC_ON(ins_len != decode.len);
                 exec_instruction(cpu, &decode);
                 store_regs(cpu);
-
-                break;
-            }
-            case EXIT_REASON_CPUID: {
-                uint32_t rax = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RAX);
-                uint32_t rbx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RBX);
-                uint32_t rcx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RCX);
-                uint32_t rdx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RDX);
-
-                get_cpuid_func(cpu, rax, rcx, &rax, &rbx, &rcx, &rdx);
-
-                wreg(cpu->hvf_fd, HV_X86_RAX, rax);
-                wreg(cpu->hvf_fd, HV_X86_RBX, rbx);
-                wreg(cpu->hvf_fd, HV_X86_RCX, rcx);
-                wreg(cpu->hvf_fd, HV_X86_RDX, rdx);
-
-                macvm_set_rip(cpu, rip + ins_len);
-                break;
-            }
-            case EXIT_REASON_XSETBV: {
-                X86CPU *x86_cpu = X86_CPU(cpu);
-                CPUX86State *env = &x86_cpu->env;
-                uint32_t eax = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RAX);
-                uint32_t ecx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RCX);
-                uint32_t edx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RDX);
-
-                if (ecx) {
-                    macvm_set_rip(cpu, rip + ins_len);
-                    break;
-                }
-                env->xcr0 = ((uint64_t)edx << 32) | eax;
-                wreg(cpu->hvf_fd, HV_X86_XCR0, env->xcr0 | 1);
-                macvm_set_rip(cpu, rip + ins_len);
-                break;
-            }
-            case EXIT_REASON_INTR_WINDOW:
-                vmx_clear_int_window_exiting(cpu);
-                ret = EXCP_INTERRUPT;
-                break;
-            case EXIT_REASON_NMI_WINDOW:
-                vmx_clear_nmi_window_exiting(cpu);
-                ret = EXCP_INTERRUPT;
-                break;
-            case EXIT_REASON_EXT_INTR:
-                /* force exit and allow io handling */
-                ret = EXCP_INTERRUPT;
-                break;
-            case EXIT_REASON_RDMSR:
-            case EXIT_REASON_WRMSR:
-            {
-                load_regs(cpu);
-                if (exit_reason == EXIT_REASON_RDMSR)
-                    simulate_rdmsr(cpu);
-                else
-                    simulate_wrmsr(cpu);
-                RIP(cpu) += rvmcs(cpu->hvf_fd, VMCS_EXIT_INSTRUCTION_LENGTH);
-                store_regs(cpu);
                 break;
             }
-            case EXIT_REASON_CR_ACCESS: {
-                int cr;
-                int reg;
+#ifdef DIRTY_VGA_TRACKING
+            /* TODO: handle dirty page tracking */
+#endif
+            break;
+        }
+        case EXIT_REASON_INOUT:
+        {
+            uint32_t in = (exit_qual & 8) != 0;
+            uint32_t size =  (exit_qual & 7) + 1;
+            uint32_t string =  (exit_qual & 16) != 0;
+            uint32_t port =  exit_qual >> 16;
+            /*uint32_t rep = (exit_qual & 0x20) != 0;*/
 
+#if 1
+            if (!string && in) {
+                uint64_t val = 0;
                 load_regs(cpu);
-                cr = exit_qual & 15;
-                reg = (exit_qual >> 8) & 15;
-
-                switch (cr) {
-                    case 0x0: {
-                        macvm_set_cr0(cpu->hvf_fd, RRX(cpu, reg));
-                        break;
-                    }
-                    case 4: {
-                        macvm_set_cr4(cpu->hvf_fd, RRX(cpu, reg));
-                        break;
-                    }
-                    case 8: {
-                        X86CPU *x86_cpu = X86_CPU(cpu);
-                        if (exit_qual & 0x10) {
-                            RRX(cpu, reg) = cpu_get_apic_tpr(x86_cpu->apic_state);
-                        }
-                        else {
-                            int tpr = RRX(cpu, reg);
-                            cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
-                            ret = EXCP_INTERRUPT;
-                        }
-                        break;
-                    }
-                    default:
-                        fprintf(stderr, "Unrecognized CR %d\n", cr);
-                        abort();
+                hvf_handle_io(env, port, &val, 0, size, 1);
+                if (size == 1) {
+                    AL(cpu) = val;
+                } else if (size == 2) {
+                    AX(cpu) = val;
+                } else if (size == 4) {
+                    RAX(cpu) = (uint32_t)val;
+                } else {
+                    VM_PANIC("size");
                 }
                 RIP(cpu) += ins_len;
                 store_regs(cpu);
                 break;
+            } else if (!string && !in) {
+                RAX(cpu) = rreg(cpu->hvf_fd, HV_X86_RAX);
+                hvf_handle_io(env, port, &RAX(cpu), 1, size, 1);
+                macvm_set_rip(cpu, rip + ins_len);
+                break;
             }
-            case EXIT_REASON_APIC_ACCESS: { // TODO
-                struct x86_decode decode;
+#endif
+            struct x86_decode decode;
 
-                load_regs(cpu);
-                cpu->hvf_x86->fetch_rip = rip;
+            load_regs(cpu);
+            cpu->hvf_x86->fetch_rip = rip;
 
-                decode_instruction(cpu, &decode);
-                exec_instruction(cpu, &decode);
-                store_regs(cpu);
+            decode_instruction(cpu, &decode);
+            VM_PANIC_ON(ins_len != decode.len);
+            exec_instruction(cpu, &decode);
+            store_regs(cpu);
+
+            break;
+        }
+        case EXIT_REASON_CPUID: {
+            uint32_t rax = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RAX);
+            uint32_t rbx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RBX);
+            uint32_t rcx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RCX);
+            uint32_t rdx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RDX);
+
+            cpu_x86_cpuid(env, rax, rcx, &rax, &rbx, &rcx, &rdx);
+
+            wreg(cpu->hvf_fd, HV_X86_RAX, rax);
+            wreg(cpu->hvf_fd, HV_X86_RBX, rbx);
+            wreg(cpu->hvf_fd, HV_X86_RCX, rcx);
+            wreg(cpu->hvf_fd, HV_X86_RDX, rdx);
+
+            macvm_set_rip(cpu, rip + ins_len);
+            break;
+        }
+        case EXIT_REASON_XSETBV: {
+            X86CPU *x86_cpu = X86_CPU(cpu);
+            CPUX86State *env = &x86_cpu->env;
+            uint32_t eax = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RAX);
+            uint32_t ecx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RCX);
+            uint32_t edx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RDX);
+
+            if (ecx) {
+                macvm_set_rip(cpu, rip + ins_len);
                 break;
             }
-            case EXIT_REASON_TPR: {
-                ret = 1;
-                break;
+            env->xcr0 = ((uint64_t)edx << 32) | eax;
+            wreg(cpu->hvf_fd, HV_X86_XCR0, env->xcr0 | 1);
+            macvm_set_rip(cpu, rip + ins_len);
+            break;
+        }
+        case EXIT_REASON_INTR_WINDOW:
+            vmx_clear_int_window_exiting(cpu);
+            ret = EXCP_INTERRUPT;
+            break;
+        case EXIT_REASON_NMI_WINDOW:
+            vmx_clear_nmi_window_exiting(cpu);
+            ret = EXCP_INTERRUPT;
+            break;
+        case EXIT_REASON_EXT_INTR:
+            /* force exit and allow io handling */
+            ret = EXCP_INTERRUPT;
+            break;
+        case EXIT_REASON_RDMSR:
+        case EXIT_REASON_WRMSR:
+        {
+            load_regs(cpu);
+            if (exit_reason == EXIT_REASON_RDMSR) {
+                simulate_rdmsr(cpu);
+            } else {
+                simulate_wrmsr(cpu);
             }
-            case EXIT_REASON_TASK_SWITCH: {
-                uint64_t vinfo = rvmcs(cpu->hvf_fd, VMCS_IDT_VECTORING_INFO);
-                x68_segment_selector sel = {.sel = exit_qual & 0xffff};
-                vmx_handle_task_switch(cpu, sel, (exit_qual >> 30) & 0x3,
-                 vinfo & VMCS_INTR_VALID, vinfo & VECTORING_INFO_VECTOR_MASK, vinfo & VMCS_INTR_T_MASK);
+            RIP(cpu) += rvmcs(cpu->hvf_fd, VMCS_EXIT_INSTRUCTION_LENGTH);
+            store_regs(cpu);
+            break;
+        }
+        case EXIT_REASON_CR_ACCESS: {
+            int cr;
+            int reg;
+
+            load_regs(cpu);
+            cr = exit_qual & 15;
+            reg = (exit_qual >> 8) & 15;
+
+            switch (cr) {
+            case 0x0: {
+                macvm_set_cr0(cpu->hvf_fd, RRX(cpu, reg));
                 break;
             }
-            case EXIT_REASON_TRIPLE_FAULT: {
-                //addr_t gpa = rvmcs(cpu->hvf_fd, VMCS_GUEST_PHYSICAL_ADDRESS);
-                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-                usleep(1000 * 100);
-                ret = EXCP_INTERRUPT;
+            case 4: {
+                macvm_set_cr4(cpu->hvf_fd, RRX(cpu, reg));
                 break;
             }
-            case EXIT_REASON_RDPMC:
-                wreg(cpu->hvf_fd, HV_X86_RAX, 0);
-                wreg(cpu->hvf_fd, HV_X86_RDX, 0);
-                macvm_set_rip(cpu, rip + ins_len);
-                break;
-            case VMX_REASON_VMCALL:
-                // TODO: maybe just take this out?
-                // if (g_hypervisor_iface) {
-                //     load_regs(cpu);
-                //     g_hypervisor_iface->hypercall_handler(cpu);
-                //     RIP(cpu) += rvmcs(cpu->hvf_fd, VMCS_EXIT_INSTRUCTION_LENGTH);
-                //     store_regs(cpu);
-                // }
+            case 8: {
+                X86CPU *x86_cpu = X86_CPU(cpu);
+                if (exit_qual & 0x10) {
+                    RRX(cpu, reg) = cpu_get_apic_tpr(x86_cpu->apic_state);
+                } else {
+                    int tpr = RRX(cpu, reg);
+                    cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
+                    ret = EXCP_INTERRUPT;
+                }
                 break;
+            }
             default:
-                fprintf(stderr, "%llx: unhandled exit %llx\n", rip, exit_reason);
+                error_report("Unrecognized CR %d\n", cr);
+                abort();
+            }
+            RIP(cpu) += ins_len;
+            store_regs(cpu);
+            break;
+        }
+        case EXIT_REASON_APIC_ACCESS: { /* TODO */
+            struct x86_decode decode;
+
+            load_regs(cpu);
+            cpu->hvf_x86->fetch_rip = rip;
+
+            decode_instruction(cpu, &decode);
+            exec_instruction(cpu, &decode);
+            store_regs(cpu);
+            break;
+        }
+        case EXIT_REASON_TPR: {
+            ret = 1;
+            break;
+        }
+        case EXIT_REASON_TASK_SWITCH: {
+            uint64_t vinfo = rvmcs(cpu->hvf_fd, VMCS_IDT_VECTORING_INFO);
+            x68_segment_selector sel = {.sel = exit_qual & 0xffff};
+            vmx_handle_task_switch(cpu, sel, (exit_qual >> 30) & 0x3,
+             vinfo & VMCS_INTR_VALID, vinfo & VECTORING_INFO_VECTOR_MASK, vinfo
+             & VMCS_INTR_T_MASK);
+            break;
+        }
+        case EXIT_REASON_TRIPLE_FAULT: {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            ret = EXCP_INTERRUPT;
+            break;
+        }
+        case EXIT_REASON_RDPMC:
+            wreg(cpu->hvf_fd, HV_X86_RAX, 0);
+            wreg(cpu->hvf_fd, HV_X86_RDX, 0);
+            macvm_set_rip(cpu, rip + ins_len);
+            break;
+        case VMX_REASON_VMCALL:
+            /* TODO: inject #GP fault */
+            break;
+        default:
+            error_report("%llx: unhandled exit %llx\n", rip, exit_reason);
         }
     } while (ret == 0);
 
@@ -860,7 +828,6 @@ static int hvf_accel_init(MachineState *ms)
     hvf_state = s;
     cpu_interrupt_handler = hvf_handle_interrupt;
     memory_listener_register(&hvf_memory_listener, &address_space_memory);
-    memory_listener_register(&hvf_io_listener, &address_space_io);
     return 0;
 }
 
diff --git a/target/i386/hvf-utils/x86.c b/target/i386/hvf-utils/x86.c
index 045b520425..1f68287830 100644
--- a/target/i386/hvf-utils/x86.c
+++ b/target/i386/hvf-utils/x86.c
@@ -26,7 +26,7 @@
 #include "x86_mmu.h"
 #include "x86_descr.h"
 
-static uint32_t x86_segment_access_rights(struct x86_segment_descriptor *var)
+/* static uint32_t x86_segment_access_rights(struct x86_segment_descriptor *var)
 {
    uint32_t ar;
 
diff --git a/target/i386/hvf-utils/x86_cpuid.h b/target/i386/hvf-utils/x86_cpuid.h
index 45d27c457a..da13ea8aca 100644
--- a/target/i386/hvf-utils/x86_cpuid.h
+++ b/target/i386/hvf-utils/x86_cpuid.h
@@ -35,7 +35,7 @@ struct x86_cpuid {
     uint32_t features, ext_features, ext2_features, ext3_features;
     uint32_t kvm_features, svm_features;
     uint32_t xlevel;
-    char model_id[48];
+    char model_id[50];
     int vendor_override;
     uint32_t flags;
     uint32_t xlevel2;
diff --git a/target/i386/hvf-utils/x86_decode.h b/target/i386/hvf-utils/x86_decode.h
index 26932b7ff7..571931dc73 100644
--- a/target/i386/hvf-utils/x86_decode.h
+++ b/target/i386/hvf-utils/x86_decode.h
@@ -314,3 +314,11 @@ addr_t decode_linear_addr(struct CPUState *cpu, struct x86_decode *decode,
                           addr_t addr, x86_reg_segment seg);
 
 void init_decoder(CPUState *cpu);
+void calc_modrm_operand16(CPUState *cpu, struct x86_decode *decode,
+                          struct x86_decode_op *op);
+void calc_modrm_operand32(CPUState *cpu, struct x86_decode *decode,
+                          struct x86_decode_op *op);
+void calc_modrm_operand64(CPUState *cpu, struct x86_decode *decode,
+                          struct x86_decode_op *op);
+void set_addressing_size(CPUState *cpu, struct x86_decode *decode);
+void set_operand_size(CPUState *cpu, struct x86_decode *decode);
diff --git a/target/i386/hvf-utils/x86_descr.h b/target/i386/hvf-utils/x86_descr.h
index e2d3f75054..1285dd3897 100644
--- a/target/i386/hvf-utils/x86_descr.h
+++ b/target/i386/hvf-utils/x86_descr.h
@@ -47,3 +47,9 @@ void x86_segment_descriptor_to_vmx(struct CPUState *cpu,
                                    x68_segment_selector selector,
                                    struct x86_segment_descriptor *desc,
                                    struct vmx_segment *vmx_desc);
+
+uint32_t vmx_read_segment_limit(CPUState *cpu, x86_reg_segment seg);
+uint32_t vmx_read_segment_ar(CPUState *cpu, x86_reg_segment seg);
+void vmx_segment_to_x86_descriptor(struct CPUState *cpu,
+                                   struct vmx_segment *vmx_desc,
+                                   struct x86_segment_descriptor *desc);
diff --git a/target/i386/hvf-utils/x86_emu.c b/target/i386/hvf-utils/x86_emu.c
index bd6e4b6577..52c915419a 100644
--- a/target/i386/hvf-utils/x86_emu.c
+++ b/target/i386/hvf-utils/x86_emu.c
@@ -45,7 +45,6 @@
 #include "vmcs.h"
 #include "vmx.h"
 
-static void print_debug(struct CPUState *cpu);
 void hvf_handle_io(struct CPUState *cpu, uint16_t port, void *data,
                    int direction, int size, uint32_t count);
 
@@ -1473,13 +1472,11 @@ void load_regs(struct CPUState *cpu)
     RRX(cpu, REG_RBP) = rreg(cpu->hvf_fd, HV_X86_RBP);
     for (i = 8; i < 16; i++) {
         RRX(cpu, i) = rreg(cpu->hvf_fd, HV_X86_RAX + i);
-    
     }
+
     RFLAGS(cpu) = rreg(cpu->hvf_fd, HV_X86_RFLAGS);
     rflags_to_lflags(cpu);
     RIP(cpu) = rreg(cpu->hvf_fd, HV_X86_RIP);
-
-    //print_debug(cpu);
 }
 
 void store_regs(struct CPUState *cpu)
diff --git a/target/i386/hvf-utils/x86_emu.h b/target/i386/hvf-utils/x86_emu.h
index f6feff5553..be80350ed8 100644
--- a/target/i386/hvf-utils/x86_emu.h
+++ b/target/i386/hvf-utils/x86_emu.h
@@ -30,4 +30,19 @@ void store_regs(struct CPUState *cpu);
 void simulate_rdmsr(struct CPUState *cpu);
 void simulate_wrmsr(struct CPUState *cpu);
 
+addr_t read_reg(struct CPUState *cpu, int reg, int size);
+void write_reg(struct CPUState *cpu, int reg, addr_t val, int size);
+addr_t read_val_from_reg(addr_t reg_ptr, int size);
+void write_val_to_reg(addr_t reg_ptr, addr_t val, int size);
+void write_val_ext(struct CPUState *cpu, addr_t ptr, addr_t val, int size);
+uint8_t *read_mmio(struct CPUState *cpu, addr_t ptr, int bytes);
+addr_t read_val_ext(struct CPUState *cpu, addr_t ptr, int size);
+
+void exec_movzx(struct CPUState *cpu, struct x86_decode *decode);
+void exec_shl(struct CPUState *cpu, struct x86_decode *decode);
+void exec_movsx(struct CPUState *cpu, struct x86_decode *decode);
+void exec_ror(struct CPUState *cpu, struct x86_decode *decode);
+void exec_rol(struct CPUState *cpu, struct x86_decode *decode);
+void exec_rcl(struct CPUState *cpu, struct x86_decode *decode);
+void exec_rcr(struct CPUState *cpu, struct x86_decode *decode);
 #endif
diff --git a/target/i386/hvf-utils/x86_flags.h b/target/i386/hvf-utils/x86_flags.h
index 87a694b408..68a0c10b90 100644
--- a/target/i386/hvf-utils/x86_flags.h
+++ b/target/i386/hvf-utils/x86_flags.h
@@ -242,4 +242,6 @@ void SET_FLAGS_SHL32(struct CPUState *cpu, uint32_t v, int count, uint32_t res);
 void SET_FLAGS_SHL16(struct CPUState *cpu, uint16_t v, int count, uint16_t res);
 void SET_FLAGS_SHL8(struct CPUState *cpu, uint8_t v, int count, uint8_t res);
 
+bool _get_OF(struct CPUState *cpu);
+bool _get_CF(struct CPUState *cpu);
 #endif /* __X86_FLAGS_H__ */
diff --git a/target/i386/hvf-utils/x86hvf.c b/target/i386/hvf-utils/x86hvf.c
index 1d2c49d50a..c920064659 100644
--- a/target/i386/hvf-utils/x86hvf.c
+++ b/target/i386/hvf-utils/x86hvf.c
@@ -35,8 +35,6 @@
 #include <Hypervisor/hv_vmx.h>
 #include <stdint.h>
 
-void hvf_cpu_synchronize_state(struct CPUState* cpu_state);
-
 void hvf_set_segment(struct CPUState *cpu, struct vmx_segment *vmx_seg,
                      SegmentCache *qseg, bool is_tr)
 {
@@ -112,7 +110,6 @@ void hvf_put_xsave(CPUState *cpu_state)
     }
 }
 
-void vmx_update_tpr(CPUState *cpu);
 void hvf_put_segments(CPUState *cpu_state)
 {
     CPUX86State *env = &X86_CPU(cpu_state)->env;
diff --git a/target/i386/hvf-utils/x86hvf.h b/target/i386/hvf-utils/x86hvf.h
index ddc73ed114..26da3dab57 100644
--- a/target/i386/hvf-utils/x86hvf.h
+++ b/target/i386/hvf-utils/x86hvf.h
@@ -34,4 +34,6 @@ void hvf_get_xsave(CPUState *cpu_state);
 void hvf_get_msrs(CPUState *cpu_state);
 void vmx_clear_int_window_exiting(CPUState *cpu);
 void hvf_get_segments(CPUState *cpu_state);
+void vmx_update_tpr(CPUState *cpu);
+void hvf_cpu_synchronize_state(CPUState *cpu_state);
 #endif
-- 
2.14.1
