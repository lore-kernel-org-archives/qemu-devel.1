Received: from eggs.gnu.org ([2001:4830:134:3::10]:57491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5h-0003ba-G6
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5f-00050O-UD
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:25 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:39683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5f-0004zN-L8
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:23 -0400
Received: by mail-pf0-x244.google.com with SMTP id r11-v6so8605587pfl.6
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:41:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:42 -1000
Message-Id: <20180618184046.6270-19-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 18/22] target/openrisc: Reorg tlb lookup
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

While openrisc has a split i/d tlb, qemu does not.  Perform a
lookup on both i & d tlbs in parallel and put the composite
rights into qemu's tlb.  This avoids ping-ponging the qemu tlb
between EXEC and READ.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h |   8 --
 target/openrisc/mmu.c | 254 +++++++++++++++---------------------------
 2 files changed, 90 insertions(+), 172 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 8035654087..1efffa5269 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -237,14 +237,6 @@ enum {
     UXE = (1 << 7),
 };
 
-/* check if tlb available */
-enum {
-    TLBRET_INVALID = -3,
-    TLBRET_NOMATCH = -2,
-    TLBRET_BADADDR = -1,
-    TLBRET_MATCH = 0
-};
-
 typedef struct OpenRISCTLBEntry {
     uint32_t mr;
     uint32_t tr;
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index f4c0a3e217..d3796ae41e 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -29,148 +29,78 @@
 #endif
 
 #ifndef CONFIG_USER_ONLY
-static inline int get_phys_nommu(hwaddr *physical, int *prot,
-                                 target_ulong address)
+static inline void get_phys_nommu(hwaddr *phys_addr, int *prot,
+                                  target_ulong address)
 {
-    *physical = address;
+    *phys_addr = address;
     *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-    return TLBRET_MATCH;
 }
 
-static int get_phys_code(OpenRISCCPU *cpu, hwaddr *physical, int *prot,
-                         target_ulong address, int rw, bool supervisor)
+static int get_phys_mmu(OpenRISCCPU *cpu, hwaddr *phys_addr, int *prot,
+                        target_ulong addr, int need, bool super)
 {
-    int vpn = address >> TARGET_PAGE_BITS;
-    int idx = vpn & TLB_MASK;
-    int right = 0;
-    uint32_t mr = cpu->env.tlb.itlb[idx].mr;
-    uint32_t tr = cpu->env.tlb.itlb[idx].tr;
+    int idx = (addr >> TARGET_PAGE_BITS) & TLB_MASK;
+    uint32_t imr = cpu->env.tlb.itlb[idx].mr;
+    uint32_t itr = cpu->env.tlb.itlb[idx].tr;
+    uint32_t dmr = cpu->env.tlb.dtlb[idx].mr;
+    uint32_t dtr = cpu->env.tlb.dtlb[idx].tr;
+    int right, match, valid;
 
-    if ((mr >> TARGET_PAGE_BITS) != vpn) {
-        return TLBRET_NOMATCH;
-    }
-    if (!(mr & 1)) {
-        return TLBRET_INVALID;
-    }
-    if (supervisor) {
-        if (tr & SXE) {
-            right |= PAGE_EXEC;
-        }
-    } else {
-        if (tr & UXE) {
-            right |= PAGE_EXEC;
+    /* If the ITLB and DTLB indexes map to the same page, we want to
+       load all permissions all at once.  If the destination pages do
+       not match, zap the one we don't need.  */
+    if (unlikely((itr ^ dtr) & TARGET_PAGE_MASK)) {
+        if (need & PAGE_EXEC) {
+            dmr = dtr = 0;
+        } else {
+            imr = itr = 0;
         }
     }
-    if ((rw & 2) && ((right & PAGE_EXEC) == 0)) {
-        return TLBRET_BADADDR;
-    }
 
-    *physical = (tr & TARGET_PAGE_MASK) | (address & ~TARGET_PAGE_MASK);
+    /* Check if either of the entries matches the source address.  */
+    match  = (imr ^ addr) & TARGET_PAGE_MASK ? 0 : PAGE_EXEC;
+    match |= (dmr ^ addr) & TARGET_PAGE_MASK ? 0 : PAGE_READ | PAGE_WRITE;
+
+    /* Check if either of the entries is valid.  */
+    valid  = imr & 1 ? PAGE_EXEC : 0;
+    valid |= dmr & 1 ? PAGE_READ | PAGE_WRITE : 0;
+    valid &= match;
+
+    /* Collect the permissions from the entries.  */
+    right  = itr & (super ? SXE : UXE) ? PAGE_EXEC : 0;
+    right |= dtr & (super ? SRE : URE) ? PAGE_READ : 0;
+    right |= dtr & (super ? SWE : UWE) ? PAGE_WRITE : 0;
+    right &= valid;
+
+    /* Note that above we validated that itr and dtr match on page.
+       So oring them together changes nothing without having to
+       check which one we needed.  We also want to store to these
+       variables even on failure, as it avoids compiler warnings.  */
+    *phys_addr = ((itr | dtr) & TARGET_PAGE_MASK) | (addr & ~TARGET_PAGE_MASK);
     *prot = right;
-    return TLBRET_MATCH;
-}
 
-static int get_phys_data(OpenRISCCPU *cpu, hwaddr *physical, int *prot,
-                         target_ulong address, int rw, bool supervisor)
-{
-    int vpn = address >> TARGET_PAGE_BITS;
-    int idx = vpn & TLB_MASK;
-    int right = 0;
-    uint32_t mr = cpu->env.tlb.dtlb[idx].mr;
-    uint32_t tr = cpu->env.tlb.dtlb[idx].tr;
+    qemu_log_mask(CPU_LOG_MMU,
+                  "MMU lookup: need %d match %d valid %d right %d -> %s\n",
+                  need, match, valid, right, (need & right) ? "OK" : "FAIL");
 
-    if ((mr >> TARGET_PAGE_BITS) != vpn) {
-        return TLBRET_NOMATCH;
+    /* Check the collective permissions are present.  */
+    if (likely(need & right)) {
+        return 0;  /* success! */
     }
-    if (!(mr & 1)) {
-        return TLBRET_INVALID;
-    }
-    if (supervisor) {
-        if (tr & SRE) {
-            right |= PAGE_READ;
-        }
-        if (tr & SWE) {
-            right |= PAGE_WRITE;
-        }
+
+    /* Determine what kind of failure we have.  */
+    if (need & valid) {
+        return need & PAGE_EXEC ? EXCP_IPF : EXCP_DPF;
     } else {
-        if (tr & URE) {
-            right |= PAGE_READ;
-        }
-        if (tr & UWE) {
-            right |= PAGE_WRITE;
-        }
+        return need & PAGE_EXEC ? EXCP_ITLBMISS : EXCP_DTLBMISS;
     }
-
-    if (!(rw & 1) && ((right & PAGE_READ) == 0)) {
-        return TLBRET_BADADDR;
-    }
-    if ((rw & 1) && ((right & PAGE_WRITE) == 0)) {
-        return TLBRET_BADADDR;
-    }
-
-    *physical = (tr & TARGET_PAGE_MASK) | (address & ~TARGET_PAGE_MASK);
-    *prot = right;
-    return TLBRET_MATCH;
-}
-
-static int get_phys_addr(OpenRISCCPU *cpu, hwaddr *physical,
-                         int *prot, target_ulong address, int rw)
-{
-    bool supervisor = (cpu->env.sr & SR_SM) != 0;
-    int ret;
-
-    /* Assume nommu results for a moment.  */
-    ret = get_phys_nommu(physical, prot, address);
-
-    /* Overwrite with TLB lookup if enabled.  */
-    if (rw == MMU_INST_FETCH) {
-        if (cpu->env.sr & SR_IME) {
-            ret = get_phys_code(cpu, physical, prot, address, rw, supervisor);
-        }
-    } else {
-        if (cpu->env.sr & SR_DME) {
-            ret = get_phys_data(cpu, physical, prot, address, rw, supervisor);
-        }
-    }
-
-    return ret;
 }
 #endif
 
-static void cpu_openrisc_raise_mmu_exception(OpenRISCCPU *cpu,
-                                             target_ulong address,
-                                             int rw, int tlb_error)
+static void raise_mmu_exception(OpenRISCCPU *cpu, target_ulong address,
+                                int exception)
 {
     CPUState *cs = CPU(cpu);
-    int exception = 0;
-
-    switch (tlb_error) {
-    default:
-        if (rw == 2) {
-            exception = EXCP_IPF;
-        } else {
-            exception = EXCP_DPF;
-        }
-        break;
-#ifndef CONFIG_USER_ONLY
-    case TLBRET_BADADDR:
-        if (rw == 2) {
-            exception = EXCP_IPF;
-        } else {
-            exception = EXCP_DPF;
-        }
-        break;
-    case TLBRET_INVALID:
-    case TLBRET_NOMATCH:
-        /* No TLB match for a mapped address */
-        if (rw == 2) {
-            exception = EXCP_ITLBMISS;
-        } else {
-            exception = EXCP_DTLBMISS;
-        }
-        break;
-#endif
-    }
 
     cs->exception_index = exception;
     cpu->env.eear = address;
@@ -182,7 +112,7 @@ int openrisc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
 {
 #ifdef CONFIG_USER_ONLY
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    cpu_openrisc_raise_mmu_exception(cpu, address, rw, 0);
+    raise_mmu_exception(cpu, address, EXCP_DPF);
     return 1;
 #else
     g_assert_not_reached();
@@ -193,27 +123,32 @@ int openrisc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
+    int prot, excp, sr = cpu->env.sr;
     hwaddr phys_addr;
-    int prot;
-    int miss;
 
-    /* Check memory for any kind of address, since during debug the
-       gdb can ask for anything, check data tlb for address */
-    miss = get_phys_addr(cpu, &phys_addr, &prot, addr, 0);
+    switch (sr & (SR_DME | SR_IME)) {
+    case SR_DME | SR_IME:
+        /* The mmu is definitely enabled.  */
+        excp = get_phys_mmu(cpu, &phys_addr, &prot, addr,
+                            PROT_EXEC | PROT_READ | PROT_WRITE,
+                            (sr & SR_SM) != 0);
+        return excp ? -1 : phys_addr;
 
-    /* Check instruction tlb */
-    if (miss) {
-        miss = get_phys_addr(cpu, &phys_addr, &prot, addr, MMU_INST_FETCH);
-    }
+    default:
+        /* The mmu is partially enabled, and we don't really have
+           a "real" access type.  Begin by trying the mmu, but if
+           that fails try again without.  */
+        excp = get_phys_mmu(cpu, &phys_addr, &prot, addr,
+                            PROT_EXEC | PROT_READ | PROT_WRITE,
+                            (sr & SR_SM) != 0);
+        if (!excp) {
+            return phys_addr;
+        }
+        /* fallthru */
 
-    /* Last, fall back to a plain address */
-    if (miss) {
-        miss = get_phys_nommu(&phys_addr, &prot, addr);
-    }
-
-    if (miss) {
-        return -1;
-    } else {
+    case 0:
+        /* The mmu is definitely disabled; lookups never fail.  */
+        get_phys_nommu(&phys_addr, &prot, addr);
         return phys_addr;
     }
 }
@@ -222,37 +157,28 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
               MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    int ret, prot = 0;
-    hwaddr physical = 0;
+    int prot, excp;
+    hwaddr phys_addr;
 
     if (mmu_idx == MMU_NOMMU_IDX) {
-        ret = get_phys_nommu(&physical, &prot, addr);
+        /* The mmu is disabled; lookups never fail.  */
+        get_phys_nommu(&phys_addr, &prot, addr);
+        excp = 0;
     } else {
         bool super = mmu_idx == MMU_SUPERVISOR_IDX;
-        if (access_type == MMU_INST_FETCH) {
-            ret = get_phys_code(cpu, &physical, &prot, addr, 2, super);
-        } else {
-            ret = get_phys_data(cpu, &physical, &prot, addr,
-                                access_type == MMU_DATA_STORE, super);
-        }
+        int need = (access_type == MMU_INST_FETCH ? PROT_EXEC
+                    : access_type == MMU_DATA_STORE ? PROT_WRITE
+                    : PROT_READ);
+        excp = get_phys_mmu(cpu, &phys_addr, &prot, addr, need, super);
     }
 
-    if (ret == TLBRET_MATCH) {
-        tlb_set_page(cs, addr & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK, prot,
-                     mmu_idx, TARGET_PAGE_SIZE);
-    } else if (ret < 0) {
-        int rw;
-        if (access_type == MMU_INST_FETCH) {
-            rw = 2;
-        } else if (access_type == MMU_DATA_STORE) {
-            rw = 1;
-        } else {
-            rw = 0;
-        }
-        cpu_openrisc_raise_mmu_exception(cpu, addr, rw, ret);
-        /* Raise Exception.  */
+    if (unlikely(excp)) {
+        raise_mmu_exception(cpu, addr, excp);
         cpu_loop_exit_restore(cs, retaddr);
     }
+
+    tlb_set_page(cs, addr & TARGET_PAGE_MASK,
+                 phys_addr & TARGET_PAGE_MASK, prot,
+                 mmu_idx, TARGET_PAGE_SIZE);
 }
 #endif
-- 
2.17.1
