Received: from eggs.gnu.org ([2001:4830:134:3::10]:48817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0Tv-0004Dj-Tg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0Tu-00081J-0I
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:11 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:42895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa0Tt-000807-Nv
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:09 -0400
Received: by mail-pf0-x234.google.com with SMTP id v9-v6so6527625pff.9
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:11:09 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Tue,  3 Jul 2018 00:10:10 +0900
Message-Id: <20180702151023.24532-13-shorne@gmail.com>
In-Reply-To: <20180702151023.24532-1-shorne@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 12/25] target/openrisc: Remove indirect
 function calls for mmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

There is no reason to use an indirect branch instead
of simply testing the SR bits that control mmu state.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/cpu.c              |  4 --
 target/openrisc/cpu.h              | 11 -----
 target/openrisc/interrupt.c        |  2 -
 target/openrisc/interrupt_helper.c | 25 ++---------
 target/openrisc/machine.c          | 26 ------------
 target/openrisc/mmu.c              | 68 +++++++++++++-----------------
 target/openrisc/sys_helper.c       | 15 -------
 7 files changed, 32 insertions(+), 119 deletions(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index fa8e342ff7..b92de51ecf 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -92,10 +92,6 @@ static void openrisc_cpu_initfn(Object *obj)
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
     cs->env_ptr = &cpu->env;
-
-#ifndef CONFIG_USER_ONLY
-    cpu_openrisc_mmu_init(cpu);
-#endif
 }
 
 /* CPU models */
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 96b7f58659..a27adad085 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -379,17 +379,6 @@ void cpu_openrisc_count_update(OpenRISCCPU *cpu);
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
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 2d0b55afa9..23abcf29ed 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -63,8 +63,6 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     env->sr &= ~SR_TEE;
     env->pmr &= ~PMR_DME;
     env->pmr &= ~PMR_SME;
-    env->tlb.cpu_openrisc_map_address_data = &cpu_openrisc_get_phys_nommu;
-    env->tlb.cpu_openrisc_map_address_code = &cpu_openrisc_get_phys_nommu;
     env->lock_addr = -1;
 
     if (exception > 0 && exception < EXCP_NR) {
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
-
-    if (rw == MMU_INST_FETCH) {    /* ITLB */
-       *physical = 0;
-        ret = cpu->env.tlb.cpu_openrisc_map_address_code(cpu, physical,
-                                                          prot, address, rw);
-    } else {          /* DTLB */
-        ret = cpu->env.tlb.cpu_openrisc_map_address_data(cpu, physical,
-                                                          prot, address, rw);
+    bool supervisor = (cpu->env.sr & SR_SM) != 0;
+    int ret;
+
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
index ff315f6f1a..9b4339b34e 100644
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
2.17.0
