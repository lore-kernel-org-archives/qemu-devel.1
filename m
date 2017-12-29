Received: from eggs.gnu.org ([2001:4830:134:3::10]:50759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDH-00033E-38
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDF-0004hr-J4
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:15 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:33155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDF-0004hQ-B6
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:13 -0500
Received: by mail-pl0-x244.google.com with SMTP id 1so21073887plv.0
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:25 -0800
Message-Id: <20171229063145.29167-19-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 18/38] target/hppa: Implement tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

However since HPPA has a software-managed TLB, and the relevant
TLB manipulation instructions are not implemented, this does not
actually do anything.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  29 ++++++++-
 target/hppa/int_helper.c |  12 ++++
 target/hppa/mem_helper.c | 149 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 184 insertions(+), 6 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 0ae4a1c399..d09f9faa86 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -165,6 +165,22 @@ typedef int64_t  target_sreg;
 #define TREG_FMT_ld   "%"PRId64
 #endif
 
+typedef struct {
+    uint64_t va_b;
+    uint64_t va_e;
+    target_ureg pa;
+    unsigned u : 1;
+    unsigned t : 1;
+    unsigned d : 1;
+    unsigned b : 1;
+    unsigned page_size : 4;
+    unsigned ar_type : 3;
+    unsigned ar_pl1 : 2;
+    unsigned ar_pl2 : 2;
+    unsigned entry_valid : 1;
+    unsigned access_id : 16;
+} hppa_tlb_entry;
+
 struct CPUHPPAState {
     target_ureg gr[32];
     uint64_t fr[32];
@@ -198,6 +214,12 @@ struct CPUHPPAState {
 
     /* Those resources are used only in QEMU core */
     CPU_COMMON
+
+    /* ??? The number of entries isn't specified by the architecture.  */
+    /* ??? Implement a unified itlb/dtlb for the moment.  */
+    /* ??? We should use a more intelligent data structure.  */
+    hppa_tlb_entry tlb[256];
+    uint32_t tlb_last;
 };
 
 /**
@@ -309,12 +331,17 @@ void cpu_hppa_loaded_fr0(CPUHPPAState *env);
 #define cpu_signal_handler cpu_hppa_signal_handler
 
 int cpu_hppa_signal_handler(int host_signum, void *pinfo, void *puc);
-int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw, int midx);
 hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
 int hppa_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function, int);
+#ifdef CONFIG_USER_ONLY
+int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw, int midx);
+#else
+int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
+                              MMUAccessType type, hwaddr *pphys, int *pprot);
+#endif
 
 #endif /* HPPA_CPU_H */
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 297aa62c24..e66ca26941 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -78,12 +78,24 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         {
             /* Avoid reading directly from the virtual address, lest we
                raise another exception from some sort of TLB issue.  */
+            /* ??? An alternate fool-proof method would be to store the
+               instruction data into the unwind info.  That's probably
+               a bit too much in the way of extra storage required.  */
             vaddr vaddr;
             hwaddr paddr;
 
             paddr = vaddr = iaoq_f & -4;
             if (old_psw & PSW_C) {
+                int prot, t;
+
                 vaddr = hppa_form_gva_psw(old_psw, iasq_f, iaoq_f & -4);
+                t = hppa_get_physical_address(env, vaddr, 0, MMU_INST_FETCH,
+                                              &paddr, &prot);
+                if (t >= 0) {
+                    /* We can't re-load the instruction.  */
+                    env->cr[CR_IIR] = 0;
+                    break;
+                }
             }
             env->cr[CR_IIR] = ldl_phys(cs->as, paddr);
         }
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 1afaf89539..4e92e35957 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -36,18 +36,157 @@ int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
     return 1;
 }
 #else
+static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(env->tlb); ++i) {
+        hppa_tlb_entry *ent = &env->tlb[i];
+        if (ent->va_b <= addr && addr <= ent->va_e && ent->entry_valid) {
+            return ent;
+        }
+    }
+    return NULL;
+}
+
+int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
+                              MMUAccessType type, hwaddr *pphys, int *pprot)
+{
+    hwaddr phys;
+    int prot, ret, r_prot, w_prot, x_prot, a_prot;
+    bool ifetch = type == MMU_INST_FETCH;
+    hppa_tlb_entry *ent;
+
+    /* Virtual translation disabled.  Direct map virtual to physical.  */
+    if (mmu_idx == MMU_PHYS_IDX) {
+        phys = addr;
+        prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        ret = -1;
+        goto egress;
+    }
+
+    /* Find a valid tlb entry that matches the virtual address.  */
+    ent = hppa_find_tlb(env, addr);
+    if (ent == NULL) {
+        phys = 0;
+        prot = 0;
+        ret = (ifetch ? EXCP_ITLB_MISS : EXCP_DTLB_MISS);
+        goto egress;
+    }
+
+    /* We now know the physical address.  */
+    phys = ent->pa + (addr & ~TARGET_PAGE_MASK);
+
+    /* Map TLB access_rights field to QEMU protection.  */
+    r_prot = (mmu_idx <= ent->ar_pl1 ? PROT_READ : 0);
+    w_prot = (mmu_idx <= ent->ar_pl2 ? PROT_WRITE : 0);
+    x_prot = (ent->ar_pl2 <= mmu_idx && mmu_idx <= ent->ar_pl1 ? PROT_EXEC : 0);
+    switch (ent->ar_type) {
+    case 0: /* read-only: data page */
+        prot = r_prot;
+        break;
+    case 1: /* read/write: dynamic data page */
+        prot = r_prot | w_prot;
+        break;
+    case 2: /* read/execute: normal code page */
+        prot = r_prot | x_prot;
+        break;
+    case 3: /* read/write/execute: dynamic code page */
+        prot = r_prot | w_prot | x_prot;
+        break;
+    default: /* execute: promote to privilege level type & 3 */
+        prot = x_prot;
+    }
+
+    /* ??? Check PSW_P and ent->access_prot.  This can remove PROT_WRITE.  */
+
+    /* Map MMUAccessType to QEMU protection.  */
+    if (ifetch) {
+        a_prot = PROT_EXEC;
+    } else if (type == MMU_DATA_STORE) {
+        a_prot = PROT_WRITE;
+    } else {
+        a_prot = PROT_READ;
+    }
+
+    if (unlikely(!(prot & a_prot))) {
+        /* The access isn't allowed -- Inst/Data Memory Protection Fault.  */
+        ret = (ifetch ? EXCP_IMP : EXCP_DMP);
+        goto egress;
+    }
+
+    /* In reverse priority order, check for conditions which raise faults.
+       As we go, remove PROT bits that cover the condition we want to check.
+       In this way, the resulting PROT will force a re-check of the
+       architectural TLB entry for the next access.  */
+    ret = -1;
+    if (unlikely(!ent->d)) {
+        if (type == MMU_DATA_STORE) {
+            /* The D bit is not set -- TLB Dirty Bit Fault.  */
+            ret = EXCP_TLB_DIRTY;
+        }
+        prot &= PROT_READ | PROT_EXEC;
+    }
+    if (unlikely(ent->b)) {
+        if (type == MMU_DATA_STORE) {
+            /* The B bit is set -- Data Memory Break Fault.  */
+            ret = EXCP_DMB;
+        }
+        prot &= PROT_READ | PROT_EXEC;
+    }
+    if (unlikely(ent->t)) {
+        if (!ifetch) {
+            /* The T bit is set -- Page Reference Fault.  */
+            ret = EXCP_PAGE_REF;
+        }
+        prot &= PROT_EXEC;
+    }
+
+ egress:
+    *pphys = phys;
+    *pprot = prot;
+    return ret;
+}
+
 hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    /* Stub */
-    return addr;
+    HPPACPU *cpu = HPPA_CPU(cs);
+    hwaddr phys;
+    int prot, excp;
+
+    /* If the (data) mmu is disabled, bypass translation.  */
+    /* ??? We really ought to know if the code mmu is disabled too,
+       in order to get the correct debugging dumps.  */
+    if (!(cpu->env.psw & PSW_D)) {
+        return addr;
+    }
+
+    excp = hppa_get_physical_address(&cpu->env, addr, MMU_KERNEL_IDX,
+                                     MMU_DATA_LOAD, &phys, &prot);
+
+    /* Since we're translating for debugging, the only error that is a
+       hard error is no translation at all.  Otherwise, while a real cpu
+       access might not have permission, the debugger does.  */
+    return excp == EXCP_DTLB_MISS ? -1 : phys;
 }
 
 void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType type,
               int mmu_idx, uintptr_t retaddr)
 {
-    /* Stub */
-    int prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-    hwaddr phys = addr;
+    HPPACPU *cpu = HPPA_CPU(cs);
+    int prot, excp;
+    hwaddr phys;
+
+    excp = hppa_get_physical_address(&cpu->env, addr, mmu_idx,
+                                     type, &phys, &prot);
+    if (unlikely(excp >= 0)) {
+        /* Failure.  Raise the indicated exception.  */
+        cs->exception_index = excp;
+        /* ??? Needs tweaking for hppa64.  */
+        cpu->env.cr[CR_IOR] = addr;
+        cpu->env.cr[CR_ISR] = addr >> 32;
+        cpu_loop_exit_restore(cs, retaddr);
+    }
 
     /* Success!  Store the translation into the QEMU TLB.  */
     tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
-- 
2.14.3
