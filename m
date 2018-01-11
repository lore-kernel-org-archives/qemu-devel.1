Received: from eggs.gnu.org ([2001:4830:134:3::10]:48033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZSWf-0003DN-PR
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZSWb-0008FI-6G
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:29 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZSWa-0008E1-Q3
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:25 -0500
Received: by mail-pg0-x244.google.com with SMTP id i196so1682311pgd.0
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 18:23:24 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 18:21:48 -0800
Message-Id: <1515637324-96034-6-git-send-email-mjc@sifive.com>
In-Reply-To: <1515637324-96034-1-git-send-email-mjc@sifive.com>
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v3 05/21] RISC-V CPU Helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

Privileged control and status register helpers and page fault handling.

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/helper.c    | 499 ++++++++++++++++++++++++++++++++++
 target/riscv/helper.h    |  78 ++++++
 target/riscv/op_helper.c | 682 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1259 insertions(+)
 create mode 100644 target/riscv/helper.c
 create mode 100644 target/riscv/helper.h
 create mode 100644 target/riscv/op_helper.c

diff --git a/target/riscv/helper.c b/target/riscv/helper.c
new file mode 100644
index 0000000..ff3f19a
--- /dev/null
+++ b/target/riscv/helper.c
@@ -0,0 +1,499 @@
+/*
+ *  RISC-V emulation helpers for qemu.
+ *
+ *  Author: Sagar Karandikar, sagark@eecs.berkeley.edu
+ *
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+
+#define RISCV_DEBUG_INTERRUPT 0
+
+int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
+{
+#ifdef CONFIG_USER_ONLY
+    return 0;
+#else
+    target_ulong mode = env->priv;
+    if (!ifetch) {
+        if (get_field(env->mstatus, MSTATUS_MPRV)) {
+            mode = get_field(env->mstatus, MSTATUS_MPP);
+        }
+    }
+    if (env->priv_ver >= PRIV_VERSION_1_10_0) {
+        if (get_field(env->satp, SATP_MODE) == VM_1_10_MBARE) {
+            mode = PRV_M;
+        }
+    } else {
+        if (get_field(env->mstatus, MSTATUS_VM) == VM_1_09_MBARE) {
+            mode = PRV_M;
+        }
+    }
+    return mode;
+#endif
+}
+
+#ifndef CONFIG_USER_ONLY
+/*
+ * Return RISC-V IRQ number if an interrupt should be taken, else -1.
+ * Used in cpu-exec.c
+ *
+ * Adapted from Spike's processor_t::take_interrupt()
+ */
+static int riscv_cpu_hw_interrupts_pending(CPURISCVState *env)
+{
+    target_ulong pending_interrupts = env->mip & env->mie;
+
+    target_ulong mie = get_field(env->mstatus, MSTATUS_MIE);
+    target_ulong m_enabled = env->priv < PRV_M || (env->priv == PRV_M && mie);
+    target_ulong enabled_interrupts = pending_interrupts &
+                                      ~env->mideleg & -m_enabled;
+
+    target_ulong sie = get_field(env->mstatus, MSTATUS_SIE);
+    target_ulong s_enabled = env->priv < PRV_S || (env->priv == PRV_S && sie);
+    enabled_interrupts |= pending_interrupts & env->mideleg &
+                          -s_enabled;
+
+    if (enabled_interrupts) {
+        target_ulong counted = ctz64(enabled_interrupts); /* since non-zero */
+        if (counted == IRQ_X_HOST) {
+            /* we're handing it to the cpu now, so get rid of the qemu irq */
+            qemu_irq_lower(HTIF_IRQ);
+        } else if (counted == IRQ_M_TIMER) {
+            /* we're handing it to the cpu now, so get rid of the qemu irq */
+            qemu_irq_lower(MTIP_IRQ);
+        } else if (counted == IRQ_S_TIMER || counted == IRQ_H_TIMER) {
+            /* don't lower irq here */
+        }
+        return counted;
+    } else {
+        return EXCP_NONE; /* indicates no pending interrupt */
+    }
+}
+#endif
+
+bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (interrupt_request & CPU_INTERRUPT_HARD) {
+        RISCVCPU *cpu = RISCV_CPU(cs);
+        CPURISCVState *env = &cpu->env;
+        int interruptno = riscv_cpu_hw_interrupts_pending(env);
+        if (interruptno + 1) {
+            cs->exception_index = RISCV_EXCP_INT_FLAG | interruptno;
+            riscv_cpu_do_interrupt(cs);
+            return true;
+        }
+    }
+#endif
+    return false;
+}
+
+#if !defined(CONFIG_USER_ONLY)
+
+/* get_physical_address - get the physical address for this virtual address
+ *
+ * Do a page table walk to obtain the physical address corresponding to a
+ * virtual address. Returns 0 if the translation was successful
+ *
+ * Adapted from Spike's mmu_t::translate and mmu_t::walk
+ *
+ */
+static int get_physical_address(CPURISCVState *env, hwaddr *physical,
+                                int *prot, target_ulong address,
+                                int access_type, int mmu_idx)
+{
+    /* NOTE: the env->pc value visible here will not be
+     * correct, but the value visible to the exception handler
+     * (riscv_cpu_do_interrupt) is correct */
+
+    const int mode = mmu_idx;
+
+    *prot = 0;
+    CPUState *cs = CPU(riscv_env_get_cpu(env));
+
+    if (mode == PRV_M) {
+        *physical = address;
+        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        return TRANSLATE_SUCCESS;
+    }
+
+    target_ulong addr = address;
+    target_ulong base;
+
+    int levels, ptidxbits, ptesize, vm, sum;
+    int mxr = get_field(env->mstatus, MSTATUS_MXR);
+
+    if (env->priv_ver >= PRIV_VERSION_1_10_0) {
+        base = get_field(env->satp, SATP_PPN) << PGSHIFT;
+        sum = get_field(env->mstatus, MSTATUS_SUM);
+        vm = get_field(env->satp, SATP_MODE);
+        switch (vm) {
+        case VM_1_10_SV32:
+          levels = 2; ptidxbits = 10; ptesize = 4; break;
+        case VM_1_10_SV39:
+          levels = 3; ptidxbits = 9; ptesize = 8; break;
+        case VM_1_10_SV48:
+          levels = 4; ptidxbits = 9; ptesize = 8; break;
+        case VM_1_10_SV57:
+          levels = 5; ptidxbits = 9; ptesize = 8; break;
+        case VM_1_10_MBARE:
+          /* cpu_mmu_index returns PRV_M for S-Mode bare */
+        default:
+          g_assert_not_reached();
+        }
+    } else {
+        base = env->sptbr << PGSHIFT;
+        sum = !get_field(env->mstatus, MSTATUS_PUM);
+        vm = get_field(env->mstatus, MSTATUS_VM);
+        switch (vm) {
+        case VM_1_09_SV32:
+          levels = 2; ptidxbits = 10; ptesize = 4; break;
+        case VM_1_09_SV39:
+          levels = 3; ptidxbits = 9; ptesize = 8; break;
+        case VM_1_09_SV48:
+          levels = 4; ptidxbits = 9; ptesize = 8; break;
+        case VM_1_09_MBARE:
+          /* cpu_mmu_index returns PRV_M for S-Mode bare */
+        default:
+          g_assert_not_reached();
+        }
+    }
+
+    int va_bits = PGSHIFT + levels * ptidxbits;
+    target_ulong mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
+    target_ulong masked_msbs = (addr >> (va_bits - 1)) & mask;
+    if (masked_msbs != 0 && masked_msbs != mask) {
+        return TRANSLATE_FAIL;
+    }
+
+    int ptshift = (levels - 1) * ptidxbits;
+    int i;
+    for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
+        target_ulong idx = (addr >> (PGSHIFT + ptshift)) &
+                           ((1 << ptidxbits) - 1);
+
+        /* check that physical address of PTE is legal */
+        target_ulong pte_addr = base + idx * ptesize;
+        target_ulong pte = ldq_phys(cs->as, pte_addr);
+        target_ulong ppn = pte >> PTE_PPN_SHIFT;
+
+        if (PTE_TABLE(pte)) { /* next level of page table */
+            base = ppn << PGSHIFT;
+        } else if ((pte & PTE_U) ? (mode == PRV_S) && !sum : !(mode == PRV_S)) {
+            break;
+        } else if (!(pte & PTE_V) || (!(pte & PTE_R) && (pte & PTE_W))) {
+            break;
+        } else if (access_type == MMU_INST_FETCH ? !(pte & PTE_X) :
+                  access_type == MMU_DATA_LOAD ?  !(pte & PTE_R) &&
+                  !(mxr && (pte & PTE_X)) : !((pte & PTE_R) && (pte & PTE_W))) {
+            break;
+        } else {
+            /* set accessed and possibly dirty bits.
+               we only put it in the TLB if it has the right stuff */
+            stq_phys(cs->as, pte_addr, ldq_phys(cs->as, pte_addr) | PTE_A |
+                    ((access_type == MMU_DATA_STORE) * PTE_D));
+
+            /* for superpage mappings, make a fake leaf PTE for the TLB's
+               benefit. */
+            target_ulong vpn = addr >> PGSHIFT;
+            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
+
+            /* we do not give all prots indicated by the PTE
+             * this is because future accesses need to do things like set the
+             * dirty bit on the PTE
+             *
+             * at this point, we assume that protection checks have occurred */
+            if (mode == PRV_S) {
+                if ((pte & PTE_X) && access_type == MMU_INST_FETCH) {
+                    *prot |= PAGE_EXEC;
+                } else if ((pte & PTE_W) && access_type == MMU_DATA_STORE) {
+                    *prot |= PAGE_WRITE;
+                } else if ((pte & PTE_R) && access_type == MMU_DATA_LOAD) {
+                    *prot |= PAGE_READ;
+                } else {
+                    g_assert_not_reached();
+                }
+            } else {
+                if ((pte & PTE_X) && access_type == MMU_INST_FETCH) {
+                    *prot |= PAGE_EXEC;
+                } else if ((pte & PTE_W) && access_type == MMU_DATA_STORE) {
+                    *prot |= PAGE_WRITE;
+                } else if ((pte & PTE_R) && access_type == MMU_DATA_LOAD) {
+                    *prot |= PAGE_READ;
+                } else {
+                    g_assert_not_reached();
+                }
+            }
+            return TRANSLATE_SUCCESS;
+        }
+    }
+    return TRANSLATE_FAIL;
+}
+
+static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
+                                MMUAccessType access_type)
+{
+    CPUState *cs = CPU(riscv_env_get_cpu(env));
+    int page_fault_exceptions =
+        (env->priv_ver >= PRIV_VERSION_1_10_0) &&
+        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE;
+    int exception = 0;
+    if (access_type == MMU_INST_FETCH) { /* inst access */
+        exception = page_fault_exceptions ?
+            RISCV_EXCP_INST_PAGE_FAULT : RISCV_EXCP_INST_ACCESS_FAULT;
+        env->badaddr = address;
+    } else if (access_type == MMU_DATA_STORE) { /* store access */
+        exception = page_fault_exceptions ?
+            RISCV_EXCP_STORE_PAGE_FAULT : RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+        env->badaddr = address;
+    } else if (access_type == MMU_DATA_LOAD) { /* load access */
+        exception = page_fault_exceptions ?
+            RISCV_EXCP_LOAD_PAGE_FAULT : RISCV_EXCP_LOAD_ACCESS_FAULT;
+        env->badaddr = address;
+    } else {
+        g_assert_not_reached();
+    }
+    cs->exception_index = exception;
+}
+
+hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    hwaddr phys_addr;
+    int prot;
+    int mem_idx = cpu_mmu_index(&cpu->env, false);
+
+    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mem_idx)) {
+        return -1;
+    }
+    return phys_addr;
+}
+
+void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                   MMUAccessType access_type, int mmu_idx,
+                                   uintptr_t retaddr)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    if (access_type == MMU_INST_FETCH) {
+        cs->exception_index = RISCV_EXCP_INST_ADDR_MIS;
+        env->badaddr = addr;
+    } else if (access_type == MMU_DATA_STORE) {
+        cs->exception_index = RISCV_EXCP_STORE_AMO_ADDR_MIS;
+        env->badaddr = addr;
+    } else if (access_type == MMU_DATA_LOAD) {
+        cs->exception_index = RISCV_EXCP_LOAD_ADDR_MIS;
+        env->badaddr = addr;
+    } else {
+        g_assert_not_reached();
+    }
+    do_raise_exception_err(env, cs->exception_index, retaddr);
+}
+
+/* called by qemu's softmmu to fill the qemu tlb */
+void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
+        int mmu_idx, uintptr_t retaddr)
+{
+    int ret;
+    ret = riscv_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    if (ret == TRANSLATE_FAIL) {
+        RISCVCPU *cpu = RISCV_CPU(cs);
+        CPURISCVState *env = &cpu->env;
+        do_raise_exception_err(env, cs->exception_index, retaddr);
+    }
+}
+
+void riscv_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
+        bool is_exec, int unused, unsigned size)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    if (is_exec) {
+        cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
+        env->badaddr = addr;
+    } else if (is_write) {
+        cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+        env->badaddr = addr;
+    } else {
+        cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
+        env->badaddr = addr;
+    }
+    qemu_log_mask(LOG_GUEST_ERROR, "cpu_unassigned_access: %016" PRIx64 "\n",
+        addr);
+    do_raise_exception_err(env, cs->exception_index, env->pc);
+}
+
+#endif
+
+int riscv_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
+        int access_type, int mmu_idx)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+#if !defined(CONFIG_USER_ONLY)
+    hwaddr pa = 0;
+    int prot;
+#endif
+    int ret = TRANSLATE_FAIL;
+
+    qemu_log_mask(CPU_LOG_MMU,
+            "%s pc " TARGET_FMT_lx " ad %" VADDR_PRIx " access_type %d mmu_idx \
+             %d\n", __func__, env->pc, address, access_type, mmu_idx);
+
+#if !defined(CONFIG_USER_ONLY)
+    ret = get_physical_address(env, &pa, &prot, address, access_type,
+                               mmu_idx);
+    qemu_log_mask(CPU_LOG_MMU,
+            "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
+             " prot %d\n", __func__, address, ret, pa, prot);
+    if (!pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
+        ret = TRANSLATE_FAIL;
+    }
+    if (ret == TRANSLATE_SUCCESS) {
+        tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
+                     prot, mmu_idx, TARGET_PAGE_SIZE);
+    } else if (ret == TRANSLATE_FAIL) {
+        raise_mmu_exception(env, address, access_type);
+    }
+#else
+    cs->exception_index = QEMU_USER_EXCP_FAULT;
+#endif
+    return ret;
+}
+
+/*
+ * Handle Traps
+ *
+ * Adapted from Spike's processor_t::take_trap.
+ *
+ */
+void riscv_cpu_do_interrupt(CPUState *cs)
+{
+#if !defined(CONFIG_USER_ONLY)
+
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    if (RISCV_DEBUG_INTERRUPT) {
+        int log_cause = cs->exception_index & RISCV_EXCP_INT_MASK;
+        if (cs->exception_index & RISCV_EXCP_INT_FLAG) {
+            qemu_log_mask(LOG_TRACE, "core   0: trap %s, epc 0x" TARGET_FMT_lx,
+                riscv_intr_names[log_cause], env->pc);
+        } else {
+            qemu_log_mask(LOG_TRACE, "core   0: intr %s, epc 0x" TARGET_FMT_lx,
+                riscv_excp_names[log_cause], env->pc);
+        }
+    }
+
+    target_ulong fixed_cause = 0;
+    if (cs->exception_index & (RISCV_EXCP_INT_FLAG)) {
+        /* hacky for now. the MSB (bit 63) indicates interrupt but cs->exception
+           index is only 32 bits wide */
+        fixed_cause = cs->exception_index & RISCV_EXCP_INT_MASK;
+        fixed_cause |= ((target_ulong)1) << (TARGET_LONG_BITS - 1);
+    } else {
+        /* fixup User ECALL -> correct priv ECALL */
+        if (cs->exception_index == RISCV_EXCP_U_ECALL) {
+            switch (env->priv) {
+            case PRV_U:
+                fixed_cause = RISCV_EXCP_U_ECALL;
+                break;
+            case PRV_S:
+                fixed_cause = RISCV_EXCP_S_ECALL;
+                break;
+            case PRV_H:
+                fixed_cause = RISCV_EXCP_H_ECALL;
+                break;
+            case PRV_M:
+                fixed_cause = RISCV_EXCP_M_ECALL;
+                break;
+            }
+        } else {
+            fixed_cause = cs->exception_index;
+        }
+    }
+
+    target_ulong backup_epc = env->pc;
+
+    target_ulong bit = fixed_cause;
+    target_ulong deleg = env->medeleg;
+
+    int hasbadaddr =
+        (fixed_cause == RISCV_EXCP_INST_ADDR_MIS) ||
+        (fixed_cause == RISCV_EXCP_INST_ACCESS_FAULT) ||
+        (fixed_cause == RISCV_EXCP_LOAD_ADDR_MIS) ||
+        (fixed_cause == RISCV_EXCP_STORE_AMO_ADDR_MIS) ||
+        (fixed_cause == RISCV_EXCP_LOAD_ACCESS_FAULT) ||
+        (fixed_cause == RISCV_EXCP_STORE_AMO_ACCESS_FAULT) ||
+        (fixed_cause == RISCV_EXCP_INST_PAGE_FAULT) ||
+        (fixed_cause == RISCV_EXCP_LOAD_PAGE_FAULT) ||
+        (fixed_cause == RISCV_EXCP_STORE_PAGE_FAULT);
+
+    if (bit & ((target_ulong)1 << (TARGET_LONG_BITS - 1))) {
+        deleg = env->mideleg;
+        bit &= ~((target_ulong)1 << (TARGET_LONG_BITS - 1));
+    }
+
+    if (env->priv <= PRV_S && bit < 64 && ((deleg >> bit) & 1)) {
+        /* handle the trap in S-mode */
+        /* No need to check STVEC for misaligned - lower 2 bits cannot be set */
+        env->pc = env->stvec;
+        env->scause = fixed_cause;
+        env->sepc = backup_epc;
+
+        if (hasbadaddr) {
+            if (RISCV_DEBUG_INTERRUPT) {
+                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
+                    ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
+            }
+            env->sbadaddr = env->badaddr;
+        }
+
+        target_ulong s = env->mstatus;
+        s = set_field(s, MSTATUS_SPIE, get_field(s, MSTATUS_UIE << env->priv));
+        s = set_field(s, MSTATUS_SPP, env->priv);
+        s = set_field(s, MSTATUS_SIE, 0);
+        csr_write_helper(env, s, CSR_MSTATUS);
+        riscv_set_mode(env, PRV_S);
+    } else {
+        /* No need to check MTVEC for misaligned - lower 2 bits cannot be set */
+        env->pc = env->mtvec;
+        env->mepc = backup_epc;
+        env->mcause = fixed_cause;
+
+        if (hasbadaddr) {
+            if (RISCV_DEBUG_INTERRUPT) {
+                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
+                    ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
+            }
+            env->mbadaddr = env->badaddr;
+        }
+
+        target_ulong s = env->mstatus;
+        s = set_field(s, MSTATUS_MPIE, get_field(s, MSTATUS_UIE << env->priv));
+        s = set_field(s, MSTATUS_MPP, env->priv);
+        s = set_field(s, MSTATUS_MIE, 0);
+        csr_write_helper(env, s, CSR_MSTATUS);
+        riscv_set_mode(env, PRV_M);
+    }
+    /* TODO yield load reservation  */
+#endif
+    cs->exception_index = EXCP_NONE; /* mark handled to qemu */
+}
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
new file mode 100644
index 0000000..60f04a2
--- /dev/null
+++ b/target/riscv/helper.h
@@ -0,0 +1,78 @@
+/* Exceptions */
+DEF_HELPER_2(raise_exception, noreturn, env, i32)
+DEF_HELPER_1(raise_exception_debug, noreturn, env)
+DEF_HELPER_3(raise_exception_mbadaddr, noreturn, env, i32, tl)
+
+/* Floating Point - fused */
+DEF_HELPER_FLAGS_5(fmadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_5(fmadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_5(fmsub_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_5(fmsub_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_5(fnmsub_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_5(fnmsub_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_5(fnmadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_5(fnmadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64, i64)
+
+/* Floating Point - Single Precision */
+DEF_HELPER_FLAGS_4(fadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(fsub_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(fmul_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(fdiv_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_3(fmin_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fmax_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fsqrt_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fle_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(flt_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(feq_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(fcvt_w_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(fcvt_wu_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
+#if defined(TARGET_RISCV64)
+DEF_HELPER_FLAGS_3(fcvt_l_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fcvt_lu_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
+#endif
+DEF_HELPER_FLAGS_3(fcvt_s_w, TCG_CALL_NO_RWG, i64, env, tl, i64)
+DEF_HELPER_FLAGS_3(fcvt_s_wu, TCG_CALL_NO_RWG, i64, env, tl, i64)
+#if defined(TARGET_RISCV64)
+DEF_HELPER_FLAGS_3(fcvt_s_l, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fcvt_s_lu, TCG_CALL_NO_RWG, i64, env, i64, i64)
+#endif
+DEF_HELPER_FLAGS_2(fclass_s, TCG_CALL_NO_RWG, tl, env, i64)
+
+/* Floating Point - Double Precision */
+DEF_HELPER_FLAGS_4(fadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(fsub_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(fmul_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(fdiv_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_3(fmin_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fmax_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fcvt_s_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fcvt_d_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fsqrt_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fle_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(flt_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(feq_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(fcvt_w_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(fcvt_wu_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
+#if defined(TARGET_RISCV64)
+DEF_HELPER_FLAGS_3(fcvt_l_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fcvt_lu_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
+#endif
+DEF_HELPER_FLAGS_3(fcvt_d_w, TCG_CALL_NO_RWG, i64, env, tl, i64)
+DEF_HELPER_FLAGS_3(fcvt_d_wu, TCG_CALL_NO_RWG, i64, env, tl, i64)
+#if defined(TARGET_RISCV64)
+DEF_HELPER_FLAGS_3(fcvt_d_l, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(fcvt_d_lu, TCG_CALL_NO_RWG, i64, env, i64, i64)
+#endif
+DEF_HELPER_FLAGS_2(fclass_d, TCG_CALL_NO_RWG, tl, env, i64)
+
+/* Special functions */
+DEF_HELPER_3(csrrw, tl, env, tl, tl)
+DEF_HELPER_4(csrrs, tl, env, tl, tl, tl)
+DEF_HELPER_4(csrrc, tl, env, tl, tl, tl)
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_2(sret, tl, env, tl)
+DEF_HELPER_2(mret, tl, env, tl)
+DEF_HELPER_1(wfi, void, env)
+DEF_HELPER_1(tlb_flush, void, env)
+DEF_HELPER_1(fence_i, void, env)
+#endif
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
new file mode 100644
index 0000000..1930ab1
--- /dev/null
+++ b/target/riscv/op_helper.c
@@ -0,0 +1,682 @@
+/*
+ * RISC-V Emulation Helpers for QEMU.
+ *
+ * Author: Sagar Karandikar, sagark@eecs.berkeley.edu
+ *
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "qemu/main-loop.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+
+#ifndef CONFIG_USER_ONLY
+
+#if defined(TARGET_RISCV32)
+static const char valid_vm_1_09[16] = {
+    [VM_1_09_MBARE] = 1,
+    [VM_1_09_SV32] = 1,
+};
+static const char valid_vm_1_10[16] = {
+    [VM_1_10_MBARE] = 1,
+    [VM_1_10_SV32] = 1
+};
+#elif defined(TARGET_RISCV64)
+static const char valid_vm_1_09[16] = {
+    [VM_1_09_MBARE] = 1,
+    [VM_1_09_SV39] = 1,
+    [VM_1_09_SV48] = 1,
+};
+static const char valid_vm_1_10[16] = {
+    [VM_1_10_MBARE] = 1,
+    [VM_1_10_SV39] = 1,
+    [VM_1_10_SV48] = 1,
+    [VM_1_10_SV57] = 1
+};
+#endif
+
+static int validate_vm(CPURISCVState *env, target_ulong vm)
+{
+    return (env->priv_ver >= PRIV_VERSION_1_10_0) ?
+        valid_vm_1_10[vm & 0xf] : valid_vm_1_09[vm & 0xf];
+}
+
+#endif
+
+/* Exceptions processing helpers */
+inline void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
+                                          uint32_t exception, uintptr_t pc)
+{
+    CPUState *cs = CPU(riscv_env_get_cpu(env));
+    qemu_log_mask(CPU_LOG_INT, "%s: %d\n", __func__, exception);
+    cs->exception_index = exception;
+    cpu_loop_exit_restore(cs, pc);
+}
+
+void helper_raise_exception(CPURISCVState *env, uint32_t exception)
+{
+    do_raise_exception_err(env, exception, 0);
+}
+
+void helper_raise_exception_debug(CPURISCVState *env)
+{
+    do_raise_exception_err(env, EXCP_DEBUG, 0);
+}
+
+void helper_raise_exception_mbadaddr(CPURISCVState *env, uint32_t exception,
+        target_ulong bad_pc) {
+    env->badaddr = bad_pc;
+    do_raise_exception_err(env, exception, 0);
+}
+
+/*
+ * Handle writes to CSRs and any resulting special behavior
+ *
+ * Adapted from Spike's processor_t::set_csr
+ */
+inline void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
+        target_ulong csrno)
+{
+    #ifdef RISCV_DEBUG_PRINT
+    qemu_log_mask(LOG_TRACE, "Write CSR reg: 0x" TARGET_FMT_lx, csrno);
+    qemu_log_mask(LOG_TRACE, "Write CSR val: 0x" TARGET_FMT_lx, val_to_write);
+    #endif
+
+#ifndef CONFIG_USER_ONLY
+    uint64_t delegable_ints = MIP_SSIP | MIP_STIP | MIP_SEIP | (1 << IRQ_X_COP);
+    uint64_t all_ints = delegable_ints | MIP_MSIP | MIP_MTIP;
+#endif
+
+    switch (csrno) {
+    case CSR_FFLAGS:
+        if (riscv_mstatus_fs(env)) {
+            env->fflags = val_to_write & (FSR_AEXC >> FSR_AEXC_SHIFT);
+        } else {
+            helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        }
+        break;
+    case CSR_FRM:
+        if (riscv_mstatus_fs(env)) {
+            env->frm = val_to_write & (FSR_RD >> FSR_RD_SHIFT);
+        } else {
+            helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        }
+        break;
+    case CSR_FCSR:
+        if (riscv_mstatus_fs(env)) {
+            env->fflags = (val_to_write & FSR_AEXC) >> FSR_AEXC_SHIFT;
+            env->frm = (val_to_write & FSR_RD) >> FSR_RD_SHIFT;
+        } else {
+            helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        }
+        break;
+#ifndef CONFIG_USER_ONLY
+    case CSR_MSTATUS: {
+        target_ulong mstatus = env->mstatus;
+        target_ulong mask = 0;
+        if (env->priv_ver <= PRIV_VERSION_1_09_1) {
+            if ((val_to_write ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
+                    MSTATUS_MPRV | MSTATUS_SUM | MSTATUS_VM)) {
+                helper_tlb_flush(env);
+            }
+            mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
+                MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
+                MSTATUS_MPP | MSTATUS_MXR |
+                (validate_vm(env, get_field(val_to_write, MSTATUS_VM)) ?
+                    MSTATUS_VM : 0);
+        }
+        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
+            if ((val_to_write ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
+                    MSTATUS_MPRV | MSTATUS_SUM)) {
+                helper_tlb_flush(env);
+            }
+            mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
+                MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
+                MSTATUS_MPP | MSTATUS_MXR;
+        }
+        mstatus = (mstatus & ~mask) | (val_to_write & mask);
+        int dirty = (mstatus & MSTATUS_FS) == MSTATUS_FS;
+        dirty |= (mstatus & MSTATUS_XS) == MSTATUS_XS;
+        mstatus = set_field(mstatus, MSTATUS_SD, dirty);
+        env->mstatus = mstatus;
+        break;
+    }
+    case CSR_MIP: {
+        target_ulong mask = MIP_SSIP | MIP_STIP | MIP_SEIP;
+        env->mip = (env->mip & ~mask) |
+            (val_to_write & mask);
+        qemu_mutex_lock_iothread();
+        if (env->mip & MIP_SSIP) {
+            qemu_irq_raise(SSIP_IRQ);
+        } else {
+            qemu_irq_lower(SSIP_IRQ);
+        }
+        if (env->mip & MIP_STIP) {
+            qemu_irq_raise(STIP_IRQ);
+        } else {
+            qemu_irq_lower(STIP_IRQ);
+        }
+        if (env->mip & MIP_SEIP) {
+            qemu_irq_raise(SEIP_IRQ);
+        } else {
+            qemu_irq_lower(SEIP_IRQ);
+        }
+        qemu_mutex_unlock_iothread();
+        break;
+    }
+    case CSR_MIE: {
+        env->mie = (env->mie & ~all_ints) |
+            (val_to_write & all_ints);
+        break;
+    }
+    case CSR_MIDELEG:
+        env->mideleg = (env->mideleg & ~delegable_ints)
+                                | (val_to_write & delegable_ints);
+        break;
+    case CSR_MEDELEG: {
+        target_ulong mask = 0;
+        mask |= 1ULL << (RISCV_EXCP_INST_ADDR_MIS);
+        mask |= 1ULL << (RISCV_EXCP_INST_ACCESS_FAULT);
+        mask |= 1ULL << (RISCV_EXCP_ILLEGAL_INST);
+        mask |= 1ULL << (RISCV_EXCP_BREAKPOINT);
+        mask |= 1ULL << (RISCV_EXCP_LOAD_ADDR_MIS);
+        mask |= 1ULL << (RISCV_EXCP_LOAD_ACCESS_FAULT);
+        mask |= 1ULL << (RISCV_EXCP_STORE_AMO_ADDR_MIS);
+        mask |= 1ULL << (RISCV_EXCP_STORE_AMO_ACCESS_FAULT);
+        mask |= 1ULL << (RISCV_EXCP_U_ECALL);
+        mask |= 1ULL << (RISCV_EXCP_S_ECALL);
+        mask |= 1ULL << (RISCV_EXCP_H_ECALL);
+        mask |= 1ULL << (RISCV_EXCP_M_ECALL);
+        mask |= 1ULL << (RISCV_EXCP_INST_PAGE_FAULT);
+        mask |= 1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT);
+        mask |= 1ULL << (RISCV_EXCP_STORE_PAGE_FAULT);
+        env->medeleg = (env->medeleg & ~mask)
+                                | (val_to_write & mask);
+        break;
+    }
+    case CSR_MINSTRET:
+        qemu_log_mask(LOG_UNIMP, "CSR_MINSTRET: write not implemented");
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        break;
+    case CSR_MCYCLE:
+        qemu_log_mask(LOG_UNIMP, "CSR_MCYCLE: write not implemented");
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        break;
+    case CSR_MINSTRETH:
+        qemu_log_mask(LOG_UNIMP, "CSR_MINSTRETH: write not implemented");
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        break;
+    case CSR_MCYCLEH:
+        qemu_log_mask(LOG_UNIMP, "CSR_MCYCLEH: write not implemented");
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        break;
+    case CSR_MUCOUNTEREN:
+        env->mucounteren = val_to_write;
+        break;
+    case CSR_MSCOUNTEREN:
+        env->mscounteren = val_to_write;
+        break;
+    case CSR_SSTATUS: {
+        target_ulong ms = env->mstatus;
+        target_ulong mask = SSTATUS_SIE | SSTATUS_SPIE | SSTATUS_UIE
+            | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS
+            | SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
+        ms = (ms & ~mask) | (val_to_write & mask);
+        csr_write_helper(env, ms, CSR_MSTATUS);
+        break;
+    }
+    case CSR_SIP: {
+        target_ulong next_mip = (env->mip & ~env->mideleg)
+                                | (val_to_write & env->mideleg);
+        csr_write_helper(env, next_mip, CSR_MIP);
+        break;
+    }
+    case CSR_SIE: {
+        target_ulong next_mie = (env->mie & ~env->mideleg)
+                                | (val_to_write & env->mideleg);
+        csr_write_helper(env, next_mie, CSR_MIE);
+        break;
+    }
+    case CSR_SATP: /* CSR_SPTBR */ {
+        if (env->priv_ver <= PRIV_VERSION_1_09_1 && (val_to_write ^ env->sptbr))
+        {
+            helper_tlb_flush(env);
+            env->sptbr = val_to_write & (((target_ulong)
+                1 << (TARGET_PHYS_ADDR_SPACE_BITS - PGSHIFT)) - 1);
+        }
+        if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
+            validate_vm(env, get_field(val_to_write, SATP_MODE)) &&
+            ((val_to_write ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
+        {
+            helper_tlb_flush(env);
+            env->satp = val_to_write;
+        }
+        break;
+    }
+    case CSR_SEPC:
+        env->sepc = val_to_write;
+        break;
+    case CSR_STVEC:
+        if (val_to_write & 1) {
+            qemu_log_mask(LOG_UNIMP, "CSR_STVEC: vectored traps not supported");
+            helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        } else {
+            env->stvec = val_to_write >> 2 << 2;
+        }
+        break;
+    case CSR_SCOUNTEREN:
+        env->scounteren = val_to_write;
+        break;
+    case CSR_SSCRATCH:
+        env->sscratch = val_to_write;
+        break;
+    case CSR_SCAUSE:
+        env->scause = val_to_write;
+        break;
+    case CSR_SBADADDR:
+        env->sbadaddr = val_to_write;
+        break;
+    case CSR_MEPC:
+        env->mepc = val_to_write;
+        break;
+    case CSR_MTVEC:
+        if (val_to_write & 1) {
+            qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: vectored traps not supported");
+            helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        } else {
+            env->mtvec = val_to_write >> 2 << 2;
+        }
+        break;
+    case CSR_MCOUNTEREN:
+        env->mcounteren = val_to_write;
+        break;
+    case CSR_MSCRATCH:
+        env->mscratch = val_to_write;
+        break;
+    case CSR_MCAUSE:
+        env->mcause = val_to_write;
+        break;
+    case CSR_MBADADDR:
+        env->mbadaddr = val_to_write;
+        break;
+    case CSR_MISA: {
+        if (!(val_to_write & (1L << ('F' - 'A')))) {
+            val_to_write &= ~(1L << ('D' - 'A'));
+        }
+
+        /* allow MAFDC bits in MISA to be modified */
+        target_ulong mask = 0;
+        mask |= 1L << ('M' - 'A');
+        mask |= 1L << ('A' - 'A');
+        mask |= 1L << ('F' - 'A');
+        mask |= 1L << ('D' - 'A');
+        mask |= 1L << ('C' - 'A');
+        mask &= env->misa_mask;
+
+        env->misa = (val_to_write & mask) | (env->misa & ~mask);
+        break;
+    }
+    case CSR_PMPCFG0:
+    case CSR_PMPCFG1:
+    case CSR_PMPCFG2:
+    case CSR_PMPCFG3:
+       pmpcfg_csr_write(env, csrno - CSR_PMPCFG0, val_to_write);
+       break;
+    case CSR_PMPADDR0:
+    case CSR_PMPADDR1:
+    case CSR_PMPADDR2:
+    case CSR_PMPADDR3:
+    case CSR_PMPADDR4:
+    case CSR_PMPADDR5:
+    case CSR_PMPADDR6:
+    case CSR_PMPADDR7:
+    case CSR_PMPADDR8:
+    case CSR_PMPADDR9:
+    case CSR_PMPADDR10:
+    case CSR_PMPADDR11:
+    case CSR_PMPADDR12:
+    case CSR_PMPADDR13:
+    case CSR_PMPADDR14:
+    case CSR_PMPADDR15:
+       pmpaddr_csr_write(env, csrno - CSR_PMPADDR0, val_to_write);
+       break;
+#endif
+    default:
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+    }
+}
+
+/*
+ * Handle reads to CSRs and any resulting special behavior
+ *
+ * Adapted from Spike's processor_t::get_csr
+ */
+inline target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
+{
+    #ifdef RISCV_DEBUG_PRINT
+    qemu_log_mask(LOG_TRACE, "Read CSR reg: 0x" TARGET_FMT_lx, csrno);
+    #endif
+
+#ifndef CONFIG_USER_ONLY
+    target_ulong ctr_en = env->priv == PRV_U ? env->mucounteren :
+                   env->priv == PRV_S ? env->mscounteren : -1U;
+#else
+    target_ulong ctr_en = env->mucounteren;
+#endif
+    target_ulong ctr_ok = (ctr_en >> (csrno & 31)) & 1;
+
+    if (ctr_ok) {
+        if (csrno >= CSR_HPMCOUNTER3 && csrno <= CSR_HPMCOUNTER31) {
+            return 0;
+        }
+#if defined(TARGET_RISCV32)
+        if (csrno >= CSR_HPMCOUNTER3H && csrno <= CSR_HPMCOUNTER31H) {
+            return 0;
+        }
+#endif
+    }
+    if (csrno >= CSR_MHPMCOUNTER3 && csrno <= CSR_MHPMCOUNTER31) {
+        return 0;
+    }
+#if defined(TARGET_RISCV32)
+    if (csrno >= CSR_MHPMCOUNTER3 && csrno <= CSR_MHPMCOUNTER31) {
+        return 0;
+    }
+#endif
+    if (csrno >= CSR_MHPMEVENT3 && csrno <= CSR_MHPMEVENT31) {
+        return 0;
+    }
+
+    switch (csrno) {
+    case CSR_FFLAGS:
+        if (riscv_mstatus_fs(env)) {
+            return env->fflags;
+        } else {
+            helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        }
+    case CSR_FRM:
+        if (riscv_mstatus_fs(env)) {
+            return env->frm;
+        } else {
+            helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        }
+    case CSR_FCSR:
+        if (riscv_mstatus_fs(env)) {
+            return env->fflags << FSR_AEXC_SHIFT | env->frm << FSR_RD_SHIFT;
+        } else {
+            helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+        }
+#ifdef CONFIG_USER_ONLY
+    case CSR_TIME:
+    case CSR_CYCLE:
+    case CSR_INSTRET:
+        return (target_ulong)cpu_get_host_ticks();
+    case CSR_TIMEH:
+    case CSR_CYCLEH:
+    case CSR_INSTRETH:
+#if defined(TARGET_RISCV32)
+        return (target_ulong)(cpu_get_host_ticks() >> 32);
+#endif
+        break;
+#endif
+#ifndef CONFIG_USER_ONLY
+    case CSR_TIME:
+        return cpu_riscv_read_rtc();
+    case CSR_TIMEH:
+        return (target_ulong)(cpu_riscv_read_rtc() >> 32);
+    case CSR_INSTRET:
+    case CSR_CYCLE:
+        if (ctr_ok) {
+            return cpu_riscv_read_instret(env);
+        }
+        break;
+    case CSR_MINSTRET:
+    case CSR_MCYCLE:
+        return cpu_riscv_read_instret(env);
+    case CSR_MINSTRETH:
+    case CSR_MCYCLEH:
+#if defined(TARGET_RISCV32)
+        return cpu_riscv_read_instret(env) >> 32;
+#endif
+        break;
+    case CSR_MUCOUNTEREN:
+        return env->mucounteren;
+    case CSR_MSCOUNTEREN:
+        return env->mscounteren;
+    case CSR_SSTATUS: {
+        target_ulong mask = SSTATUS_SIE | SSTATUS_SPIE | SSTATUS_UIE
+            | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS
+            | SSTATUS_SUM |  SSTATUS_SD;
+        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
+            mask |= SSTATUS_MXR;
+        }
+        return env->mstatus & mask;
+    }
+    case CSR_SIP:
+        return env->mip & env->mideleg;
+    case CSR_SIE:
+        return env->mie & env->mideleg;
+    case CSR_SEPC:
+        return env->sepc;
+    case CSR_SBADADDR:
+        return env->sbadaddr;
+    case CSR_STVEC:
+        return env->stvec;
+    case CSR_SCOUNTEREN:
+        return env->scounteren;
+    case CSR_SCAUSE:
+        return env->scause;
+    case CSR_SPTBR:
+        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
+            return env->satp;
+        } else {
+            return env->sptbr;
+        }
+    case CSR_SSCRATCH:
+        return env->sscratch;
+    case CSR_MSTATUS:
+        return env->mstatus;
+    case CSR_MIP:
+        return env->mip;
+    case CSR_MIE:
+        return env->mie;
+    case CSR_MEPC:
+        return env->mepc;
+    case CSR_MSCRATCH:
+        return env->mscratch;
+    case CSR_MCAUSE:
+        return env->mcause;
+    case CSR_MBADADDR:
+        return env->mbadaddr;
+    case CSR_MISA:
+        return env->misa;
+    case CSR_MARCHID:
+        return 0; /* as spike does */
+    case CSR_MIMPID:
+        return 0; /* as spike does */
+    case CSR_MVENDORID:
+        return 0; /* as spike does */
+    case CSR_MHARTID:
+        return env->mhartid;
+    case CSR_MTVEC:
+        return env->mtvec;
+    case CSR_MCOUNTEREN:
+        return env->mcounteren;
+    case CSR_MEDELEG:
+        return env->medeleg;
+    case CSR_MIDELEG:
+        return env->mideleg;
+    case CSR_PMPCFG0:
+    case CSR_PMPCFG1:
+    case CSR_PMPCFG2:
+    case CSR_PMPCFG3:
+       return pmpcfg_csr_read(env, csrno - CSR_PMPCFG0);
+    case CSR_PMPADDR0:
+    case CSR_PMPADDR1:
+    case CSR_PMPADDR2:
+    case CSR_PMPADDR3:
+    case CSR_PMPADDR4:
+    case CSR_PMPADDR5:
+    case CSR_PMPADDR6:
+    case CSR_PMPADDR7:
+    case CSR_PMPADDR8:
+    case CSR_PMPADDR9:
+    case CSR_PMPADDR10:
+    case CSR_PMPADDR11:
+    case CSR_PMPADDR12:
+    case CSR_PMPADDR13:
+    case CSR_PMPADDR14:
+    case CSR_PMPADDR15:
+       return pmpaddr_csr_read(env, csrno - CSR_PMPADDR0);
+#endif
+    }
+    /* used by e.g. MTIME read */
+    helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+    return 0;
+}
+
+/*
+ * Check that CSR access is allowed.
+ *
+ * Adapted from Spike's decode.h:validate_csr
+ */
+void validate_csr(CPURISCVState *env, uint64_t which, uint64_t write)
+{
+#ifndef CONFIG_USER_ONLY
+    unsigned csr_priv = get_field((which), 0x300);
+    unsigned csr_read_only = get_field((which), 0xC00) == 3;
+    if (((write) && csr_read_only) || (env->priv < csr_priv)) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, env->pc);
+    }
+#endif
+}
+
+target_ulong helper_csrrw(CPURISCVState *env, target_ulong src,
+        target_ulong csr)
+{
+    validate_csr(env, csr, 1);
+    uint64_t csr_backup = csr_read_helper(env, csr);
+    csr_write_helper(env, src, csr);
+    return csr_backup;
+}
+
+target_ulong helper_csrrs(CPURISCVState *env, target_ulong src,
+        target_ulong csr, target_ulong rs1_pass)
+{
+    validate_csr(env, csr, rs1_pass != 0);
+    uint64_t csr_backup = csr_read_helper(env, csr);
+    if (rs1_pass != 0) {
+        csr_write_helper(env, src | csr_backup, csr);
+    }
+    return csr_backup;
+}
+
+target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
+        target_ulong csr, target_ulong rs1_pass)
+{
+    validate_csr(env, csr, rs1_pass != 0);
+    uint64_t csr_backup = csr_read_helper(env, csr);
+    if (rs1_pass != 0) {
+        csr_write_helper(env, (~src) & csr_backup, csr);
+    }
+    return csr_backup;
+}
+
+#ifndef CONFIG_USER_ONLY
+
+void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
+{
+    if (newpriv > PRV_M) {
+        g_assert_not_reached();
+    }
+    if (newpriv == PRV_H) {
+        newpriv = PRV_U;
+    }
+    helper_tlb_flush(env);
+    env->priv = newpriv;
+}
+
+target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
+{
+    if (!(env->priv >= PRV_S)) {
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+    }
+
+    target_ulong retpc = env->sepc;
+    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
+        helper_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS);
+    }
+
+    target_ulong mstatus = env->mstatus;
+    target_ulong prev_priv = get_field(mstatus, MSTATUS_SPP);
+    mstatus = set_field(mstatus, MSTATUS_UIE << prev_priv,
+                        get_field(mstatus, MSTATUS_SPIE));
+    mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
+    mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
+    riscv_set_mode(env, prev_priv);
+    csr_write_helper(env, mstatus, CSR_MSTATUS);
+
+    return retpc;
+}
+
+target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
+{
+    if (!(env->priv >= PRV_M)) {
+        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
+    }
+
+    target_ulong retpc = env->mepc;
+    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
+        helper_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS);
+    }
+
+    target_ulong mstatus = env->mstatus;
+    target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
+    mstatus = set_field(mstatus, MSTATUS_UIE << prev_priv,
+                        get_field(mstatus, MSTATUS_MPIE));
+    mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
+    mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
+    riscv_set_mode(env, prev_priv);
+    csr_write_helper(env, mstatus, CSR_MSTATUS);
+
+    return retpc;
+}
+
+
+void helper_wfi(CPURISCVState *env)
+{
+    CPUState *cs = CPU(riscv_env_get_cpu(env));
+
+    cs->halted = 1;
+    cs->exception_index = EXCP_HLT;
+    cpu_loop_exit(cs);
+}
+
+void helper_fence_i(CPURISCVState *env)
+{
+    /* FENCE.I is a no-op in qemu as self modifying code is detected */
+}
+
+void helper_tlb_flush(CPURISCVState *env)
+{
+    RISCVCPU *cpu = riscv_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+    tlb_flush(cs);
+}
+
+#endif /* !CONFIG_USER_ONLY */
-- 
2.7.0
