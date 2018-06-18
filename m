Received: from eggs.gnu.org ([2001:4830:134:3::10]:57348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5S-0003Ss-5X
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5Q-0004k5-EW
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:10 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:40663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5Q-0004jW-6a
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:08 -0400
Received: by mail-pg0-x244.google.com with SMTP id w8-v6so4899651pgp.7
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:41:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:33 -1000
Message-Id: <20180618184046.6270-10-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 09/22] target/openrisc: Remove indirect
 function calls for mmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

There is no reason to use an indirect branch instead
of simply testing the SR bits that control mmu state.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h              | 11 -----
 target/openrisc/cpu.c              |  4 --
 target/openrisc/interrupt.c        |  2 -
 target/openrisc/interrupt_helper.c | 25 ++---------
 target/openrisc/machine.c          | 26 ------------
 target/openrisc/mmu.c              | 66 +++++++++++++-----------------
 target/openrisc/sys_helper.c       | 15 -------
 7 files changed, 31 insertions(+), 118 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index edc06be40e..13107058cb 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -378,17 +378,6 @@ void cpu_openrisc_count_update(OpenRISCCPU *cpu);
 void cpu_openrisc_timer_update(OpenRISCCPU *cpu);
 void cpu_openrisc_count_start(OpenRISCCPU *cpu);
 void cpu_openrisc_count_stop(OpenRISCCPU *cpu);
-
-void cpu_openrisc_mmu_init(OpenRISCCPU *cpu);
-int cpu_openrisc_get_phys_nommu(OpenRISCCPU *cpu,
-                                hwaddr *physical,
-                                int *prot, target_ulong address, int rw);
-int cpu_openrisc_get_phys_code(OpenRISCCPU *cpu,
-                               hwaddr *physical,
-                               int *prot, target_ulong address, int rw);
-int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
-                               hwaddr *physical,
-                               int *prot, target_ulong address, int rw);
 #endif
 
 #define OPENRISC_CPU_TYPE_SUFFIX "-" TYPE_OPENRISC_CPU
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index a692a98ec0..4c166c6329 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -87,10 +87,6 @@ static void openrisc_cpu_initfn(Object *obj)
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
     cs->env_ptr = &cpu->env;
-
-#ifndef CONFIG_USER_ONLY
-    cpu_openrisc_mmu_init(cpu);
-#endif
 }
 
 /* CPU models */
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 8b8b14ace0..d9cb363fea 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -62,8 +62,6 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     env->sr &= ~SR_TEE;
     env->pmr &= ~PMR_DME;
     env->pmr &= ~PMR_SME;
-    env->tlb.cpu_openrisc_map_address_data = &cpu_openrisc_get_phys_nommu;
-    env->tlb.cpu_openrisc_map_address_code = &cpu_openrisc_get_phys_nommu;
     env->lock_addr = -1;
 
     if (cs->exception_index > 0 && cs->exception_index < EXCP_NR) {
diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
index dc97b38704..a2e9003969 100644
--- a/target/openrisc/interrupt_helper.c
+++ b/target/openrisc/interrupt_helper.c
@@ -29,31 +29,12 @@ void HELPER(rfe)(CPUOpenRISCState *env)
 #ifndef CONFIG_USER_ONLY
     int need_flush_tlb = (cpu->env.sr & (SR_SM | SR_IME | SR_DME)) ^
                          (cpu->env.esr & (SR_SM | SR_IME | SR_DME));
-#endif
-    cpu->env.pc = cpu->env.epcr;
-    cpu_set_sr(&cpu->env, cpu->env.esr);
-    cpu->env.lock_addr = -1;
-
-#ifndef CONFIG_USER_ONLY
-    if (cpu->env.sr & SR_DME) {
-        cpu->env.tlb.cpu_openrisc_map_address_data =
-            &cpu_openrisc_get_phys_data;
-    } else {
-        cpu->env.tlb.cpu_openrisc_map_address_data =
-            &cpu_openrisc_get_phys_nommu;
-    }
-
-    if (cpu->env.sr & SR_IME) {
-        cpu->env.tlb.cpu_openrisc_map_address_code =
-            &cpu_openrisc_get_phys_code;
-    } else {
-        cpu->env.tlb.cpu_openrisc_map_address_code =
-            &cpu_openrisc_get_phys_nommu;
-    }
-
     if (need_flush_tlb) {
         CPUState *cs = CPU(cpu);
         tlb_flush(cs);
     }
 #endif
+    cpu->env.pc = cpu->env.epcr;
+    cpu->env.lock_addr = -1;
+    cpu_set_sr(&cpu->env, cpu->env.esr);
 }
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index c10d28b055..73e0abcfd7 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -24,31 +24,6 @@
 #include "hw/boards.h"
 #include "migration/cpu.h"
 
-static int env_post_load(void *opaque, int version_id)
-{
-    CPUOpenRISCState *env = opaque;
-
-    /* Restore MMU handlers */
-    if (env->sr & SR_DME) {
-        env->tlb.cpu_openrisc_map_address_data =
-            &cpu_openrisc_get_phys_data;
-    } else {
-        env->tlb.cpu_openrisc_map_address_data =
-            &cpu_openrisc_get_phys_nommu;
-    }
-
-    if (env->sr & SR_IME) {
-        env->tlb.cpu_openrisc_map_address_code =
-            &cpu_openrisc_get_phys_code;
-    } else {
-        env->tlb.cpu_openrisc_map_address_code =
-            &cpu_openrisc_get_phys_nommu;
-    }
-
-
-    return 0;
-}
-
 static const VMStateDescription vmstate_tlb_entry = {
     .name = "tlb_entry",
     .version_id = 1,
@@ -102,7 +77,6 @@ static const VMStateDescription vmstate_env = {
     .name = "env",
     .version_id = 6,
     .minimum_version_id = 6,
-    .post_load = env_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINTTL_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
         VMSTATE_UINTTL(pc, CPUOpenRISCState),
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 5665bb7cc9..b2effaa6d7 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -29,18 +29,16 @@
 #endif
 
 #ifndef CONFIG_USER_ONLY
-int cpu_openrisc_get_phys_nommu(OpenRISCCPU *cpu,
-                                hwaddr *physical,
-                                int *prot, target_ulong address, int rw)
+static inline int get_phys_nommu(hwaddr *physical, int *prot,
+                                 target_ulong address)
 {
     *physical = address;
     *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     return TLBRET_MATCH;
 }
 
-int cpu_openrisc_get_phys_code(OpenRISCCPU *cpu,
-                               hwaddr *physical,
-                               int *prot, target_ulong address, int rw)
+static int get_phys_code(OpenRISCCPU *cpu, hwaddr *physical, int *prot,
+                         target_ulong address, int rw, bool supervisor)
 {
     int vpn = address >> TARGET_PAGE_BITS;
     int idx = vpn & ITLB_MASK;
@@ -52,8 +50,7 @@ int cpu_openrisc_get_phys_code(OpenRISCCPU *cpu,
     if (!(cpu->env.tlb.itlb[0][idx].mr & 1)) {
         return TLBRET_INVALID;
     }
-
-    if (cpu->env.sr & SR_SM) { /* supervisor mode */
+    if (supervisor) {
         if (cpu->env.tlb.itlb[0][idx].tr & SXE) {
             right |= PAGE_EXEC;
         }
@@ -62,7 +59,6 @@ int cpu_openrisc_get_phys_code(OpenRISCCPU *cpu,
             right |= PAGE_EXEC;
         }
     }
-
     if ((rw & 2) && ((right & PAGE_EXEC) == 0)) {
         return TLBRET_BADADDR;
     }
@@ -73,9 +69,8 @@ int cpu_openrisc_get_phys_code(OpenRISCCPU *cpu,
     return TLBRET_MATCH;
 }
 
-int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
-                               hwaddr *physical,
-                               int *prot, target_ulong address, int rw)
+static int get_phys_data(OpenRISCCPU *cpu, hwaddr *physical, int *prot,
+                         target_ulong address, int rw, bool supervisor)
 {
     int vpn = address >> TARGET_PAGE_BITS;
     int idx = vpn & DTLB_MASK;
@@ -87,8 +82,7 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
     if (!(cpu->env.tlb.dtlb[0][idx].mr & 1)) {
         return TLBRET_INVALID;
     }
-
-    if (cpu->env.sr & SR_SM) { /* supervisor mode */
+    if (supervisor) {
         if (cpu->env.tlb.dtlb[0][idx].tr & SRE) {
             right |= PAGE_READ;
         }
@@ -117,20 +111,24 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
     return TLBRET_MATCH;
 }
 
-static int cpu_openrisc_get_phys_addr(OpenRISCCPU *cpu,
-                                      hwaddr *physical,
-                                      int *prot, target_ulong address,
-                                      int rw)
+static int get_phys_addr(OpenRISCCPU *cpu, hwaddr *physical,
+                         int *prot, target_ulong address, int rw)
 {
-    int ret = TLBRET_MATCH;
+    bool supervisor = (cpu->env.sr & SR_SM) != 0;
+    int ret;
 
-    if (rw == MMU_INST_FETCH) {    /* ITLB */
-       *physical = 0;
-        ret = cpu->env.tlb.cpu_openrisc_map_address_code(cpu, physical,
-                                                          prot, address, rw);
-    } else {          /* DTLB */
-        ret = cpu->env.tlb.cpu_openrisc_map_address_data(cpu, physical,
-                                                          prot, address, rw);
+    /* Assume nommu results for a moment.  */
+    ret = get_phys_nommu(physical, prot, address);
+
+    /* Overwrite with TLB lookup if enabled.  */
+    if (rw == MMU_INST_FETCH) {
+        if (cpu->env.sr & SR_IME) {
+            ret = get_phys_code(cpu, physical, prot, address, rw, supervisor);
+        }
+    } else {
+        if (cpu->env.sr & SR_DME) {
+            ret = get_phys_data(cpu, physical, prot, address, rw, supervisor);
+        }
     }
 
     return ret;
@@ -186,8 +184,7 @@ int openrisc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
     hwaddr physical = 0;
     int prot = 0;
 
-    ret = cpu_openrisc_get_phys_addr(cpu, &physical, &prot,
-                                     address, rw);
+    ret = get_phys_addr(cpu, &physical, &prot, address, rw);
 
     if (ret == TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
@@ -225,17 +222,16 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
     /* Check memory for any kind of address, since during debug the
        gdb can ask for anything, check data tlb for address */
-    miss = cpu_openrisc_get_phys_addr(cpu, &phys_addr, &prot, addr, 0);
+    miss = get_phys_addr(cpu, &phys_addr, &prot, addr, 0);
 
     /* Check instruction tlb */
     if (miss) {
-        miss = cpu_openrisc_get_phys_addr(cpu, &phys_addr, &prot, addr,
-                                          MMU_INST_FETCH);
+        miss = get_phys_addr(cpu, &phys_addr, &prot, addr, MMU_INST_FETCH);
     }
 
     /* Last, fall back to a plain address */
     if (miss) {
-        miss = cpu_openrisc_get_phys_nommu(cpu, &phys_addr, &prot, addr, 0);
+        miss = get_phys_nommu(&phys_addr, &prot, addr);
     }
 
     if (miss) {
@@ -244,10 +240,4 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         return phys_addr;
     }
 }
-
-void cpu_openrisc_mmu_init(OpenRISCCPU *cpu)
-{
-    cpu->env.tlb.cpu_openrisc_map_address_code = &cpu_openrisc_get_phys_nommu;
-    cpu->env.tlb.cpu_openrisc_map_address_data = &cpu_openrisc_get_phys_nommu;
-}
 #endif
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index f26c688df6..a1285894ad 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -60,21 +60,6 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
             tlb_flush(cs);
         }
         cpu_set_sr(env, rb);
-        if (env->sr & SR_DME) {
-            env->tlb.cpu_openrisc_map_address_data =
-                &cpu_openrisc_get_phys_data;
-        } else {
-            env->tlb.cpu_openrisc_map_address_data =
-                &cpu_openrisc_get_phys_nommu;
-        }
-
-        if (env->sr & SR_IME) {
-            env->tlb.cpu_openrisc_map_address_code =
-                &cpu_openrisc_get_phys_code;
-        } else {
-            env->tlb.cpu_openrisc_map_address_code =
-                &cpu_openrisc_get_phys_nommu;
-        }
         break;
 
     case TO_SPR(0, 18): /* PPC */
-- 
2.17.1
