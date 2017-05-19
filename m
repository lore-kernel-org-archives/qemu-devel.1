Received: from eggs.gnu.org ([2001:4830:134:3::10]:43087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBe1j-0000Wg-0i
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBe1e-0000d9-2w
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:16:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBe1d-0000cw-Q8
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:16:46 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 May 2017 11:16:42 +0200
Message-Id: <20170519091642.25309-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] target/i386: use multiple CPU AddressSpaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.xu@intel.com

This speeds up SMM switches.  Later on it may remove the need to take
the BQL, and it may also allow to reuse code between TCG and KVM.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c        | 15 +++++++++-----
 target/i386/cpu.h        | 11 +++++++++-
 target/i386/helper.c     | 54 ++++++++++++++++++++++++------------------------
 target/i386/machine.c    |  4 ----
 target/i386/smm_helper.c | 18 ----------------
 5 files changed, 47 insertions(+), 55 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5e768404a1..1b3b77c96a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3239,7 +3239,7 @@ static void x86_cpu_machine_done(Notifier *n, void *unused)
         cpu->smram = g_new(MemoryRegion, 1);
         memory_region_init_alias(cpu->smram, OBJECT(cpu), "smram",
                                  smram, 0, 1ull << 32);
-        memory_region_set_enabled(cpu->smram, false);
+        memory_region_set_enabled(cpu->smram, true);
         memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->smram, 1);
     }
 }
@@ -3619,7 +3619,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     if (tcg_enabled()) {
-        AddressSpace *newas = g_new(AddressSpace, 1);
+        AddressSpace *as_normal = address_space_init_shareable(cs->memory,
+                                                               "cpu-memory");
+        AddressSpace *as_smm = g_new(AddressSpace, 1);
 
         cpu->cpu_as_mem = g_new(MemoryRegion, 1);
         cpu->cpu_as_root = g_new(MemoryRegion, 1);
@@ -3635,9 +3637,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
                                  get_system_memory(), 0, ~0ull);
         memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->cpu_as_mem, 0);
         memory_region_set_enabled(cpu->cpu_as_mem, true);
-        address_space_init(newas, cpu->cpu_as_root, "CPU");
-        cs->num_ases = 1;
-        cpu_address_space_init(cs, newas, 0);
+        address_space_init(as_smm, cpu->cpu_as_root, "CPU");
+
+        cs->num_ases = 2;
+        cpu_address_space_init(cs, as_normal, 0);
+        cpu_address_space_init(cs, as_smm, 1);
 
         /* ... SMRAM with higher priority, linked from /machine/smram.  */
         cpu->machine_done.notify = x86_cpu_machine_done;
@@ -4053,6 +4057,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = x86_cpu_handle_mmu_fault;
 #else
+    cc->asidx_from_attrs = x86_asidx_from_attrs;
     cc->get_memory_mapping = x86_cpu_get_memory_mapping;
     cc->get_phys_page_debug = x86_cpu_get_phys_page_debug;
     cc->write_elf64_note = x86_cpu_write_elf64_note;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 32a3a0cb8f..c2e081c6e3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1450,6 +1450,16 @@ int x86_cpu_handle_mmu_fault(CPUState *cpu, vaddr addr,
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 
 #ifndef CONFIG_USER_ONLY
+static inline int x86_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
+{
+    return !!attrs.secure;
+}
+
+static inline AddressSpace *cpu_addressspace(CPUState *cs, MemTxAttrs attrs)
+{
+    return cpu_get_address_space(cs, cpu_asidx_from_attrs(cs, attrs));
+}
+
 uint8_t x86_ldub_phys(CPUState *cs, hwaddr addr);
 uint32_t x86_lduw_phys(CPUState *cs, hwaddr addr);
 uint32_t x86_ldl_phys(CPUState *cs, hwaddr addr);
@@ -1652,7 +1662,6 @@ void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw);
 
 /* smm_helper.c */
 void do_smm_enter(X86CPU *cpu);
-void cpu_smm_update(X86CPU *cpu);
 
 /* apic.c */
 void cpu_report_tpr_access(CPUX86State *env, TPRAccess access);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 6c16e7cb53..d0daa1f882 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -1403,89 +1403,89 @@ uint8_t x86_ldub_phys(CPUState *cs, hwaddr addr)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    MemTxAttrs attrs = cpu_get_mem_attrs(env);
+    AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    return address_space_ldub(cs->as, addr,
-                              cpu_get_mem_attrs(env),
-                              NULL);
+    return address_space_ldub(as, addr, attrs, NULL);
 }
 
 uint32_t x86_lduw_phys(CPUState *cs, hwaddr addr)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    MemTxAttrs attrs = cpu_get_mem_attrs(env);
+    AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    return address_space_lduw(cs->as, addr,
-                              cpu_get_mem_attrs(env),
-                              NULL);
+    return address_space_lduw(as, addr, attrs, NULL);
 }
 
 uint32_t x86_ldl_phys(CPUState *cs, hwaddr addr)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    MemTxAttrs attrs = cpu_get_mem_attrs(env);
+    AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    return address_space_ldl(cs->as, addr,
-                             cpu_get_mem_attrs(env),
-                             NULL);
+    return address_space_ldl(as, addr, attrs, NULL);
 }
 
 uint64_t x86_ldq_phys(CPUState *cs, hwaddr addr)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    MemTxAttrs attrs = cpu_get_mem_attrs(env);
+    AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    return address_space_ldq(cs->as, addr,
-                             cpu_get_mem_attrs(env),
-                             NULL);
+    return address_space_ldq(as, addr, attrs, NULL);
 }
 
 void x86_stb_phys(CPUState *cs, hwaddr addr, uint8_t val)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    MemTxAttrs attrs = cpu_get_mem_attrs(env);
+    AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    address_space_stb(cs->as, addr, val,
-                      cpu_get_mem_attrs(env),
-                      NULL);
+    address_space_stb(as, addr, val, attrs, NULL);
 }
 
 void x86_stl_phys_notdirty(CPUState *cs, hwaddr addr, uint32_t val)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    MemTxAttrs attrs = cpu_get_mem_attrs(env);
+    AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    address_space_stl_notdirty(cs->as, addr, val,
-                               cpu_get_mem_attrs(env),
-                               NULL);
+    address_space_stl_notdirty(as, addr, val, attrs, NULL);
 }
 
 void x86_stw_phys(CPUState *cs, hwaddr addr, uint32_t val)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    MemTxAttrs attrs = cpu_get_mem_attrs(env);
+    AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    address_space_stw(cs->as, addr, val,
-                      cpu_get_mem_attrs(env),
-                      NULL);
+    address_space_stw(as, addr, val, attrs, NULL);
 }
 
 void x86_stl_phys(CPUState *cs, hwaddr addr, uint32_t val)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    MemTxAttrs attrs = cpu_get_mem_attrs(env);
+    AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    address_space_stl(cs->as, addr, val,
-                      cpu_get_mem_attrs(env),
-                      NULL);
+    address_space_stl(as, addr, val, attrs, NULL);
 }
 
 void x86_stq_phys(CPUState *cs, hwaddr addr, uint64_t val)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    MemTxAttrs attrs = cpu_get_mem_attrs(env);
+    AddressSpace *as = cpu_addressspace(cs, attrs);
 
-    address_space_stq(cs->as, addr, val,
-                      cpu_get_mem_attrs(env),
-                      NULL);
+    address_space_stq(as, addr, val, attrs, NULL);
 }
 #endif
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 3cb272948e..8c7a822e9f 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -274,10 +274,6 @@ static int cpu_post_load(void *opaque, int version_id)
         cpu_x86_update_dr7(env, dr7);
     }
     tlb_flush(cs);
-
-    if (tcg_enabled()) {
-        cpu_smm_update(cpu);
-    }
     return 0;
 }
 
diff --git a/target/i386/smm_helper.c b/target/i386/smm_helper.c
index f051a77c4a..90621e5977 100644
--- a/target/i386/smm_helper.c
+++ b/target/i386/smm_helper.c
@@ -43,19 +43,6 @@ void helper_rsm(CPUX86State *env)
 #define SMM_REVISION_ID 0x00020000
 #endif
 
-/* Called with iothread lock taken */
-void cpu_smm_update(X86CPU *cpu)
-{
-    CPUX86State *env = &cpu->env;
-    bool smm_enabled = (env->hflags & HF_SMM_MASK);
-
-    g_assert(qemu_mutex_iothread_locked());
-
-    if (cpu->smram) {
-        memory_region_set_enabled(cpu->smram, smm_enabled);
-    }
-}
-
 void do_smm_enter(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
@@ -73,7 +60,6 @@ void do_smm_enter(X86CPU *cpu)
     } else {
         env->hflags2 |= HF2_NMI_MASK;
     }
-    cpu_smm_update(cpu);
 
     sm_state = env->smbase + 0x8000;
 
@@ -338,10 +324,6 @@ void helper_rsm(CPUX86State *env)
     env->hflags2 &= ~HF2_SMM_INSIDE_NMI_MASK;
     env->hflags &= ~HF_SMM_MASK;
 
-    qemu_mutex_lock_iothread();
-    cpu_smm_update(cpu);
-    qemu_mutex_unlock_iothread();
-
     qemu_log_mask(CPU_LOG_INT, "SMM: after RSM\n");
     log_cpu_state_mask(CPU_LOG_INT, CPU(cpu), CPU_DUMP_CCOP);
 }
-- 
2.13.0
