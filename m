Received: from eggs.gnu.org ([2001:4830:134:3::10]:42179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHT1-00087j-GW
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHSu-0000jE-IL
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:23 -0400
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:39817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHSu-0000iV-0z
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:16 -0400
Received: by mail-pl0-x236.google.com with SMTP id c19-v6so11867873pls.6
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:17:15 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:14:55 +1200
Message-Id: <1527034517-7851-9-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 08/30] RISC-V: Implement modular CSR helper
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

Previous CSR code uses csr_read_helper and csr_write_helper
to update CSR registers however this interface prevents
atomic read/modify/write CSR operations; in addition
there is no trap-free method to access to CSRs due
to the monolithic CSR functions call longjmp.

The current iCSR interface is not safe to be called by
target/riscv/gdbstub.c as privilege checks or missing CSRs
may call longjmp to generate exceptions. It needs to
indicate existence so traps can be generated in the
CSR instruction helpers.

This commit moves CSR access from the monolithic switch
statements in target/riscv/op_helper.c into modular
read/write functions in target/riscv/csr.c using a new
function pointer table for dispatch (which can later
be used to allow CPUs to hook up model specific CSRs).

A read/modify/write interface is added to support atomic
CSR operations and a non-trapping interface is added
to allow exception-free access to CSRs by the debugger.

The CSR functions and CSR dispatch table are ordered
to match The RISC-V Instruction Set Manual, Volume II:
Privileged Architecture Version 1.10, 2.2 CSR Listing.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/Makefile.objs |   2 +-
 target/riscv/cpu.h         |  18 +-
 target/riscv/cpu_helper.c  |   4 +-
 target/riscv/csr.c         | 857 +++++++++++++++++++++++++++++++++++++++++++++
 target/riscv/gdbstub.c     |  10 +-
 target/riscv/op_helper.c   | 611 +-------------------------------
 6 files changed, 898 insertions(+), 604 deletions(-)
 create mode 100644 target/riscv/csr.c

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index fcc5d34c1f2e..4072abe3e45c 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -1 +1 @@
-obj-y += translate.o op_helper.o cpu_helper.o cpu.o fpu_helper.o gdbstub.o pmp.o
+obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o pmp.o
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c5d485769cde..02c60c45631b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -290,9 +290,21 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 #endif
 }
 
-void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
-        target_ulong csrno);
-target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno);
+int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                target_ulong new_value, target_ulong write_mask);
+
+static inline void csr_write_helper(CPURISCVState *env, target_ulong val,
+                                    int csrno)
+{
+    riscv_csrrw(env, csrno, NULL, val, -1);
+}
+
+static inline target_ulong csr_read_helper(CPURISCVState *env, int csrno)
+{
+    target_ulong val = 0;
+    riscv_csrrw(env, csrno, &val, 0, 0);
+    return val;
+}
 
 #include "exec/cpu-all.h"
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6c886e99055a..1f523861b7cb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -526,7 +526,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_SPP, env->priv);
         s = set_field(s, MSTATUS_SIE, 0);
-        csr_write_helper(env, s, CSR_MSTATUS);
+        env->mstatus = s;
         riscv_set_mode(env, PRV_S);
     } else {
         /* No need to check MTVEC for misaligned - lower 2 bits cannot be set */
@@ -551,7 +551,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_MPP, env->priv);
         s = set_field(s, MSTATUS_MIE, 0);
-        csr_write_helper(env, s, CSR_MSTATUS);
+        env->mstatus = s;
         riscv_set_mode(env, PRV_M);
     }
     /* TODO yield load reservation  */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
new file mode 100644
index 000000000000..e08f3523d854
--- /dev/null
+++ b/target/riscv/csr.c
@@ -0,0 +1,857 @@
+/*
+ * RISC-V Control and Status Registers.
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2017-2018 SiFive, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "qemu/main-loop.h"
+#include "exec/exec-all.h"
+
+
+/* Control and Status Register function table forward declaration */
+
+typedef int (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
+    target_ulong *ret_value);
+typedef int (*riscv_csr_write_fn)(CPURISCVState *env, int csrno,
+    target_ulong new_value);
+typedef int (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
+    target_ulong *ret_value, target_ulong new_value, target_ulong write_mask);
+
+typedef struct {
+    riscv_csr_read_fn read;
+    riscv_csr_write_fn write;
+    riscv_csr_op_fn op;
+} riscv_csr_operations;
+
+static const riscv_csr_operations csr_ops[];
+
+
+/* User Floating-Point CSRs */
+
+static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!(env->mstatus & MSTATUS_FS)) {
+        return -1;
+    }
+#endif
+    *val = cpu_riscv_get_fflags(env);
+    return 0;
+}
+
+static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!(env->mstatus & MSTATUS_FS)) {
+        return -1;
+    }
+    env->mstatus |= MSTATUS_FS;
+#endif
+    cpu_riscv_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
+    return 0;
+}
+
+static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!(env->mstatus & MSTATUS_FS)) {
+        return -1;
+    }
+#endif
+    *val = env->frm;
+    return 0;
+}
+
+static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!(env->mstatus & MSTATUS_FS)) {
+        return -1;
+    }
+    env->mstatus |= MSTATUS_FS;
+#endif
+    env->frm = val & (FSR_RD >> FSR_RD_SHIFT);
+    return 0;
+}
+
+static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!(env->mstatus & MSTATUS_FS)) {
+        return -1;
+    }
+#endif
+    *val = (cpu_riscv_get_fflags(env) << FSR_AEXC_SHIFT)
+        | (env->frm << FSR_RD_SHIFT);
+    return 0;
+}
+
+static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!(env->mstatus & MSTATUS_FS)) {
+        return -1;
+    }
+    env->mstatus |= MSTATUS_FS;
+#endif
+    env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
+    cpu_riscv_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
+    return 0;
+}
+
+/* User Timers and Counters */
+
+static int counter_enabled(CPURISCVState *env, int csrno)
+{
+#ifndef CONFIG_USER_ONLY
+    target_ulong ctr_en = env->priv == PRV_U ? env->scounteren :
+                          env->priv == PRV_S ? env->mcounteren : -1U;
+#else
+    target_ulong ctr_en = -1;
+#endif
+    return (ctr_en >> (csrno & 31)) & 1;
+}
+
+#if !defined(CONFIG_USER_ONLY)
+static int read_zero_counter(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!counter_enabled(env, csrno)) {
+        return -1;
+    }
+    *val = 0;
+    return 0;
+}
+#endif
+
+static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!counter_enabled(env, csrno)) {
+        return -1;
+    }
+#if !defined(CONFIG_USER_ONLY)
+    if (use_icount) {
+        *val = cpu_get_icount();
+    } else {
+        *val = cpu_get_host_ticks();
+    }
+#else
+    *val = cpu_get_host_ticks();
+#endif
+    return 0;
+}
+
+#if defined(TARGET_RISCV32)
+static int read_instreth(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!counter_enabled(env, csrno)) {
+        return -1;
+    }
+#if !defined(CONFIG_USER_ONLY)
+    if (use_icount) {
+        *val = cpu_get_icount() >> 32;
+    } else {
+        *val = cpu_get_host_ticks() >> 32;
+    }
+#else
+    *val = cpu_get_host_ticks() >> 32;
+#endif
+    return 0;
+}
+#endif
+
+#if defined(CONFIG_USER_ONLY)
+
+static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = cpu_get_host_ticks();
+    return 0;
+}
+
+#if defined(TARGET_RISCV32)
+static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = cpu_get_host_ticks() >> 32;
+    return 0;
+}
+#endif
+
+#else
+
+/* Machine constants */
+
+#define M_MODE_INTERRUPTS (MIP_MSIP | MIP_MTIP | MIP_MEIP | MIP_MCIP)
+#define S_MODE_INTERRUPTS (MIP_SSIP | MIP_STIP | MIP_SEIP | MIP_SCIP)
+
+static const target_ulong delegable_ints = S_MODE_INTERRUPTS;
+static const target_ulong all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS;
+static const target_ulong delegable_excps =
+    (1ULL << (RISCV_EXCP_INST_ADDR_MIS)) |
+    (1ULL << (RISCV_EXCP_INST_ACCESS_FAULT)) |
+    (1ULL << (RISCV_EXCP_ILLEGAL_INST)) |
+    (1ULL << (RISCV_EXCP_BREAKPOINT)) |
+    (1ULL << (RISCV_EXCP_LOAD_ADDR_MIS)) |
+    (1ULL << (RISCV_EXCP_LOAD_ACCESS_FAULT)) |
+    (1ULL << (RISCV_EXCP_STORE_AMO_ADDR_MIS)) |
+    (1ULL << (RISCV_EXCP_STORE_AMO_ACCESS_FAULT)) |
+    (1ULL << (RISCV_EXCP_U_ECALL)) |
+    (1ULL << (RISCV_EXCP_S_ECALL)) |
+    (1ULL << (RISCV_EXCP_H_ECALL)) |
+    (1ULL << (RISCV_EXCP_M_ECALL)) |
+    (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) |
+    (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) |
+    (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT));
+static const target_ulong sstatus_v1_9_mask = SSTATUS_SIE | SSTATUS_SPIE |
+    SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
+    SSTATUS_SUM | SSTATUS_SD;
+static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
+    SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
+    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
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
+/* Machine Information Registers */
+
+static int read_zero(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    return *val = 0;
+}
+
+static int read_mhartid(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mhartid;
+    return 0;
+}
+
+/* Machine Trap Setup */
+
+static int read_mstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mstatus;
+    return 0;
+}
+
+static int validate_vm(CPURISCVState *env, target_ulong vm)
+{
+    return (env->priv_ver >= PRIV_VERSION_1_10_0) ?
+        valid_vm_1_10[vm & 0xf] : valid_vm_1_09[vm & 0xf];
+}
+
+static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong mstatus = env->mstatus;
+    target_ulong mask = 0;
+    target_ulong mpp = get_field(val, MSTATUS_MPP);
+
+    /* flush tlb on mstatus fields that affect VM */
+    if (env->priv_ver <= PRIV_VERSION_1_09_1) {
+        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
+                MSTATUS_MPRV | MSTATUS_SUM | MSTATUS_VM)) {
+            tlb_flush(CPU(riscv_env_get_cpu(env)));
+        }
+        mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
+            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
+            MSTATUS_MPP | MSTATUS_MXR |
+            (validate_vm(env, get_field(val, MSTATUS_VM)) ?
+                MSTATUS_VM : 0);
+    }
+    if (env->priv_ver >= PRIV_VERSION_1_10_0) {
+        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
+                MSTATUS_MPRV | MSTATUS_SUM)) {
+            tlb_flush(CPU(riscv_env_get_cpu(env)));
+        }
+        mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
+            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
+            MSTATUS_MPP | MSTATUS_MXR;
+    }
+
+    /* silenty discard mstatus.mpp writes for unsupported modes */
+    if (mpp == PRV_H ||
+        (!riscv_has_ext(env, RVS) && mpp == PRV_S) ||
+        (!riscv_has_ext(env, RVU) && mpp == PRV_U)) {
+        mask &= ~MSTATUS_MPP;
+    }
+
+    mstatus = (mstatus & ~mask) | (val & mask);
+
+    /* Note: this is a workaround for an issue where mstatus.FS
+       does not report dirty after floating point operations
+       that modify floating point state. This workaround is
+       technically compliant with the RISC-V Privileged
+       specification as it is legal to return only off, or dirty.
+       at the expense of extra floating point save/restore. */
+
+    /* FP is always dirty or off */
+    if (mstatus & MSTATUS_FS) {
+        mstatus |= MSTATUS_FS;
+    }
+
+    int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
+                ((mstatus & MSTATUS_XS) == MSTATUS_XS);
+    mstatus = set_field(mstatus, MSTATUS_SD, dirty);
+    env->mstatus = mstatus;
+
+    return 0;
+}
+
+static int read_misa(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->misa;
+    return 0;
+}
+
+static int read_medeleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->medeleg;
+    return 0;
+}
+
+static int write_medeleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->medeleg = (env->medeleg & ~delegable_excps) | (val & delegable_excps);
+    return 0;
+}
+
+static int read_mideleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mideleg;
+    return 0;
+}
+
+static int write_mideleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mideleg = (env->mideleg & ~delegable_ints) | (val & delegable_ints);
+    return 0;
+}
+
+static int read_mie(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mie;
+    return 0;
+}
+
+static int write_mie(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mie = (env->mie & ~all_ints) | (val & all_ints);
+    return 0;
+}
+
+static int read_mtvec(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mtvec;
+    return 0;
+}
+
+static int write_mtvec(CPURISCVState *env, int csrno, target_ulong val)
+{
+    /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
+    if ((val & 3) == 0) {
+        env->mtvec = val >> 2 << 2;
+    } else {
+        qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: vectored traps not supported");
+    }
+    return 0;
+}
+
+static int read_mcounteren(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (env->priv_ver < PRIV_VERSION_1_10_0) {
+        return -1;
+    }
+    *val = env->mcounteren;
+    return 0;
+}
+
+static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (env->priv_ver < PRIV_VERSION_1_10_0) {
+        return -1;
+    }
+    env->mcounteren = val;
+    return 0;
+}
+
+static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+        return -1;
+    }
+    *val = env->mcounteren;
+    return 0;
+}
+
+static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+        return -1;
+    }
+    env->mcounteren = val;
+    return 0;
+}
+
+static int read_mucounteren(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+        return -1;
+    }
+    *val = env->scounteren;
+    return 0;
+}
+
+static int write_mucounteren(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+        return -1;
+    }
+    env->scounteren = val;
+    return 0;
+}
+
+/* Machine Trap Handling */
+
+static int read_mscratch(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mscratch;
+    return 0;
+}
+
+static int write_mscratch(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mscratch = val;
+    return 0;
+}
+
+static int read_mepc(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mepc;
+    return 0;
+}
+
+static int write_mepc(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mepc = val;
+    return 0;
+}
+
+static int read_mcause(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mcause;
+    return 0;
+}
+
+static int write_mcause(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mcause = val;
+    return 0;
+}
+
+static int read_mbadaddr(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mbadaddr;
+    return 0;
+}
+
+static int write_mbadaddr(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mbadaddr = val;
+    return 0;
+}
+
+static int read_mip(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = atomic_read(&env->mip);
+    return 0;
+}
+
+static int write_mip(CPURISCVState *env, int csrno, target_ulong val)
+{
+    RISCVCPU *cpu = riscv_env_get_cpu(env);
+
+    /*
+     * csrs, csrc on mip.SEIP is not decomposable into separate read and
+     * write steps, so a different implementation is needed
+     */
+
+    qemu_mutex_lock_iothread();
+    riscv_cpu_update_mip(cpu, MIP_SSIP | MIP_STIP,
+                         (val & (MIP_SSIP | MIP_STIP)));
+    qemu_mutex_unlock_iothread();
+
+    return 0;
+}
+
+/* Supervisor Trap Setup */
+
+static int read_sstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    target_ulong mask = ((env->priv_ver >= PRIV_VERSION_1_10_0) ?
+                         sstatus_v1_10_mask : sstatus_v1_9_mask);
+    *val = env->mstatus & mask;
+    return 0;
+}
+
+static int write_sstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong mask = ((env->priv_ver >= PRIV_VERSION_1_10_0) ?
+                         sstatus_v1_10_mask : sstatus_v1_9_mask);
+    target_ulong newval = (env->mstatus & ~mask) | (val & mask);
+    return write_mstatus(env, CSR_MSTATUS, newval);
+}
+
+static int read_sie(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mie & env->mideleg;
+    return 0;
+}
+
+static int write_sie(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong newval = (env->mie & ~env->mideleg) | (val & env->mideleg);
+    return write_mie(env, CSR_MIE, newval);
+}
+
+static int read_stvec(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->stvec;
+    return 0;
+}
+
+static int write_stvec(CPURISCVState *env, int csrno, target_ulong val)
+{
+    /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
+    if ((val & 3) == 0) {
+        env->stvec = val >> 2 << 2;
+    } else {
+        qemu_log_mask(LOG_UNIMP, "CSR_STVEC: vectored traps not supported");
+    }
+    return 0;
+}
+
+static int read_scounteren(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (env->priv_ver < PRIV_VERSION_1_10_0) {
+        return -1;
+    }
+    *val = env->scounteren;
+    return 0;
+}
+
+static int write_scounteren(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (env->priv_ver < PRIV_VERSION_1_10_0) {
+        return -1;
+    }
+    env->scounteren = val;
+    return 0;
+}
+
+/* Supervisor Trap Handling */
+
+static int read_sscratch(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->sscratch;
+    return 0;
+}
+
+static int write_sscratch(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->sscratch = val;
+    return 0;
+}
+
+static int read_sepc(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->sepc;
+    return 0;
+}
+
+static int write_sepc(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->sepc = val;
+    return 0;
+}
+
+static int read_scause(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->scause;
+    return 0;
+}
+
+static int write_scause(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->scause = val;
+    return 0;
+}
+
+static int read_sbadaddr(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->sbadaddr;
+    return 0;
+}
+
+static int write_sbadaddr(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->sbadaddr = val;
+    return 0;
+}
+
+static int read_sip(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = atomic_read(&env->mip) & env->mideleg;
+    return 0;
+}
+
+static int write_sip(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong newval = (atomic_read(&env->mip) & ~env->mideleg)
+                          | (val & env->mideleg);
+    return write_mip(env, CSR_MIP, newval);
+}
+
+/* Supervisor Protection and Translation */
+
+static int read_satp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
+        *val = 0;
+    } else if (env->priv_ver >= PRIV_VERSION_1_10_0) {
+        *val = env->satp;
+    } else {
+        *val = env->sptbr;
+    }
+    return 0;
+}
+
+static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
+        return 0;
+    }
+    if (env->priv_ver <= PRIV_VERSION_1_09_1 && (val ^ env->sptbr)) {
+        tlb_flush(CPU(riscv_env_get_cpu(env)));
+        env->sptbr = val & (((target_ulong)
+            1 << (TARGET_PHYS_ADDR_SPACE_BITS - PGSHIFT)) - 1);
+    }
+    if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
+        validate_vm(env, get_field(val, SATP_MODE)) &&
+        ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
+    {
+        tlb_flush(CPU(riscv_env_get_cpu(env)));
+        env->satp = val;
+    }
+    return 0;
+}
+
+/* Physical Memory Protection */
+
+static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = pmpcfg_csr_read(env, csrno - CSR_PMPCFG0);
+    return 0;
+}
+
+static int write_pmpcfg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    pmpcfg_csr_write(env, csrno - CSR_PMPCFG0, val);
+    return 0;
+}
+
+static int read_pmpaddr(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = pmpaddr_csr_read(env, csrno - CSR_PMPADDR0);
+    return 0;
+}
+
+static int write_pmpaddr(CPURISCVState *env, int csrno, target_ulong val)
+{
+    pmpaddr_csr_write(env, csrno - CSR_PMPADDR0, val);
+    return 0;
+}
+
+#endif
+
+/*
+ * riscv_csrrw - read and/or update control and status register
+ *
+ * csrr   <->  riscv_csrrw(env, csrno, ret_value, 0, 0);
+ * csrrw  <->  riscv_csrrw(env, csrno, ret_value, value, -1);
+ * csrrs  <->  riscv_csrrw(env, csrno, ret_value, -1, value);
+ * csrrc  <->  riscv_csrrw(env, csrno, ret_value, 0, value);
+ */
+
+int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                target_ulong new_value, target_ulong write_mask)
+{
+    int ret;
+    target_ulong old_value;
+
+    /* check privileges and return -1 if check fails */
+#if !defined(CONFIG_USER_ONLY)
+    int csr_priv = get_field(csrno, 0x300);
+    int read_only = get_field(csrno, 0xC00) == 3;
+    if ((write_mask && read_only) || (env->priv < csr_priv)) {
+        return -1;
+    }
+#endif
+
+    /* execute combined read/write operation if it exists */
+    if (csr_ops[csrno].op) {
+        return csr_ops[csrno].op(env, csrno, ret_value, new_value, write_mask);
+    }
+
+    /* if no accessor exists then return failure */
+    if (!csr_ops[csrno].read) {
+        return -1;
+    }
+
+    /* read old value */
+    ret = csr_ops[csrno].read(env, csrno, &old_value);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* write value if writable and write mask set, otherwise drop writes */
+    if (write_mask) {
+        new_value = (old_value & ~write_mask) | (new_value & write_mask);
+        if (csr_ops[csrno].write) {
+            ret = csr_ops[csrno].write(env, csrno, new_value);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+    }
+
+    /* return old value */
+    if (ret_value) {
+        *ret_value = old_value;
+    }
+
+    return 0;
+}
+
+/* Control and Status Register function table */
+
+static const riscv_csr_operations csr_ops[0xfff] = {
+    /* User Floating-Point CSRs */
+    [CSR_FFLAGS] =              { read_fflags,      write_fflags      },
+    [CSR_FRM] =                 { read_frm,         write_frm         },
+    [CSR_FCSR] =                { read_fcsr,        write_fcsr        },
+
+    /* User Timers and Counters */
+    [CSR_CYCLE] =               { read_instret                        },
+    [CSR_INSTRET] =             { read_instret                        },
+#if defined(TARGET_RISCV32)
+    [CSR_CYCLEH] =              { read_instreth                       },
+    [CSR_INSTRETH] =            { read_instreth                       },
+#endif
+
+    /* User-level time CSRs are only available in linux-user
+     * In privileged mode, the monitor emulates these CSRs */
+#if defined(CONFIG_USER_ONLY)
+    [CSR_TIME] =                { read_time                           },
+#if defined(TARGET_RISCV32)
+    [CSR_TIMEH] =               { read_timeh                          },
+#endif
+#endif
+
+#if !defined(CONFIG_USER_ONLY)
+    /* Machine Timers and Counters */
+    [CSR_MCYCLE] =              { read_instret                        },
+    [CSR_MINSTRET] =            { read_instret                        },
+#if defined(TARGET_RISCV32)
+    [CSR_MCYCLEH] =             { read_instreth                       },
+    [CSR_MINSTRETH] =           { read_instreth                       },
+#endif
+
+    /* Machine Information Registers */
+    [CSR_MVENDORID] =           { read_zero                           },
+    [CSR_MARCHID] =             { read_zero                           },
+    [CSR_MIMPID] =              { read_zero                           },
+    [CSR_MHARTID] =             { read_mhartid                        },
+
+    /* Machine Trap Setup */
+    [CSR_MSTATUS] =             { read_mstatus,     write_mstatus     },
+    [CSR_MISA] =                { read_misa                           },
+    [CSR_MIDELEG] =             { read_mideleg,     write_mideleg     },
+    [CSR_MEDELEG] =             { read_medeleg,     write_medeleg     },
+    [CSR_MIE] =                 { read_mie,         write_mie         },
+    [CSR_MTVEC] =               { read_mtvec,       write_mtvec       },
+    [CSR_MCOUNTEREN] =          { read_mcounteren,  write_mcounteren  },
+
+    /* Legacy Counter Setup (priv v1.9.1) */
+    [CSR_MUCOUNTEREN] =         { read_mucounteren, write_mucounteren },
+    [CSR_MSCOUNTEREN] =         { read_mscounteren, write_mscounteren },
+
+    /* Machine Trap Handling */
+    [CSR_MSCRATCH] =            { read_mscratch,    write_mscratch    },
+    [CSR_MEPC] =                { read_mepc,        write_mepc        },
+    [CSR_MCAUSE] =              { read_mcause,      write_mcause      },
+    [CSR_MBADADDR] =            { read_mbadaddr,    write_mbadaddr    },
+    [CSR_MIP] =                 { read_mip,         write_mip         },
+
+    /* Supervisor Trap Setup */
+    [CSR_SSTATUS] =             { read_sstatus,     write_sstatus     },
+    [CSR_SIE] =                 { read_sie,         write_sie         },
+    [CSR_STVEC] =               { read_stvec,       write_stvec       },
+    [CSR_SCOUNTEREN] =          { read_scounteren,  write_scounteren  },
+
+    /* Supervisor Trap Handling */
+    [CSR_SSCRATCH] =            { read_sscratch,    write_sscratch    },
+    [CSR_SEPC] =                { read_sepc,        write_sepc        },
+    [CSR_SCAUSE] =              { read_scause,      write_scause      },
+    [CSR_SBADADDR] =            { read_sbadaddr,    write_sbadaddr    },
+    [CSR_SIP] =                 { read_sip,         write_sip         },
+
+    /* Supervisor Protection and Translation */
+    [CSR_SATP] =                { read_satp,        write_satp        },
+
+    /* Physical Memory Protection */
+    [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { read_pmpcfg,  write_pmpcfg   },
+    [CSR_PMPADDR0 ... CSR_PMPADDR15] = { read_pmpaddr, write_pmpaddr  },
+
+    /* Performance Counters */
+    [CSR_HPMCOUNTER3   ... CSR_HPMCOUNTER31] =    { read_zero_counter },
+    [CSR_MHPMCOUNTER3  ... CSR_MHPMCOUNTER31] =   { read_zero         },
+    [CSR_MHPMEVENT3    ... CSR_MHPMEVENT31] =     { read_zero         },
+#if defined(TARGET_RISCV32)
+    [CSR_HPMCOUNTER3H  ... CSR_HPMCOUNTER31H] =   { read_zero_counter },
+    [CSR_MHPMCOUNTER3H ... CSR_MHPMCOUNTER31H] =  { read_zero         },
+#endif
+#endif
+};
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 4f919b6c3413..3cabb21cd012 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -33,7 +33,10 @@ int riscv_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
     } else if (n < 65) {
         return gdb_get_reg64(mem_buf, env->fpr[n - 33]);
     } else if (n < 4096 + 65) {
-        return gdb_get_regl(mem_buf, csr_read_helper(env, n - 65));
+        target_ulong val = 0;
+        if (riscv_csrrw(env, n - 65, &val, 0, 0) == 0) {
+            return gdb_get_regl(mem_buf, val);
+        }
     }
     return 0;
 }
@@ -56,7 +59,10 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->fpr[n - 33] = ldq_p(mem_buf); /* always 64-bit */
         return sizeof(uint64_t);
     } else if (n < 4096 + 65) {
-        csr_write_helper(env, ldtul_p(mem_buf), n - 65);
+        target_ulong val = ldtul_p(mem_buf);
+        if (riscv_csrrw(env, n - 65, NULL, val, -1) == 0) {
+            return sizeof(target_ulong);
+        }
     }
     return 0;
 }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index fd2efcb49929..81bd1a77ea90 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -24,39 +24,6 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 
-#ifndef CONFIG_USER_ONLY
-
-#if defined(TARGET_RISCV32)
-static const char valid_vm_1_09[16] = {
-    [VM_1_09_MBARE] = 1,
-    [VM_1_09_SV32] = 1,
-};
-static const char valid_vm_1_10[16] = {
-    [VM_1_10_MBARE] = 1,
-    [VM_1_10_SV32] = 1
-};
-#elif defined(TARGET_RISCV64)
-static const char valid_vm_1_09[16] = {
-    [VM_1_09_MBARE] = 1,
-    [VM_1_09_SV39] = 1,
-    [VM_1_09_SV48] = 1,
-};
-static const char valid_vm_1_10[16] = {
-    [VM_1_10_MBARE] = 1,
-    [VM_1_10_SV39] = 1,
-    [VM_1_10_SV48] = 1,
-    [VM_1_10_SV57] = 1
-};
-#endif
-
-static int validate_vm(CPURISCVState *env, target_ulong vm)
-{
-    return (env->priv_ver >= PRIV_VERSION_1_10_0) ?
-        valid_vm_1_10[vm & 0xf] : valid_vm_1_09[vm & 0xf];
-}
-
-#endif
-
 /* Exceptions processing helpers */
 void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
                                           uint32_t exception, uintptr_t pc)
@@ -72,582 +39,34 @@ void helper_raise_exception(CPURISCVState *env, uint32_t exception)
     do_raise_exception_err(env, exception, 0);
 }
 
-static void validate_mstatus_fs(CPURISCVState *env, uintptr_t ra)
-{
-#ifndef CONFIG_USER_ONLY
-    if (!(env->mstatus & MSTATUS_FS)) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, ra);
-    }
-#endif
-}
-
-/*
- * Handle writes to CSRs and any resulting special behavior
- *
- * Adapted from Spike's processor_t::set_csr
- */
-void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
-        target_ulong csrno)
-{
-#ifndef CONFIG_USER_ONLY
-    uint64_t delegable_ints = MIP_SSIP | MIP_STIP | MIP_SEIP | MIP_SCIP;
-    uint64_t all_ints = delegable_ints | MIP_MSIP | MIP_MTIP | MIP_MCIP;
-#endif
-
-    switch (csrno) {
-    case CSR_FFLAGS:
-        validate_mstatus_fs(env, GETPC());
-        cpu_riscv_set_fflags(env, val_to_write & (FSR_AEXC >> FSR_AEXC_SHIFT));
-        break;
-    case CSR_FRM:
-        validate_mstatus_fs(env, GETPC());
-        env->frm = val_to_write & (FSR_RD >> FSR_RD_SHIFT);
-        break;
-    case CSR_FCSR:
-        validate_mstatus_fs(env, GETPC());
-        env->frm = (val_to_write & FSR_RD) >> FSR_RD_SHIFT;
-        cpu_riscv_set_fflags(env, (val_to_write & FSR_AEXC) >> FSR_AEXC_SHIFT);
-        break;
-#ifndef CONFIG_USER_ONLY
-    case CSR_MSTATUS: {
-        target_ulong mstatus = env->mstatus;
-        target_ulong mask = 0;
-        target_ulong mpp = get_field(val_to_write, MSTATUS_MPP);
-
-        /* flush tlb on mstatus fields that affect VM */
-        if (env->priv_ver <= PRIV_VERSION_1_09_1) {
-            if ((val_to_write ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
-                    MSTATUS_MPRV | MSTATUS_SUM | MSTATUS_VM)) {
-                helper_tlb_flush(env);
-            }
-            mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
-                MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
-                MSTATUS_MPP | MSTATUS_MXR |
-                (validate_vm(env, get_field(val_to_write, MSTATUS_VM)) ?
-                    MSTATUS_VM : 0);
-        }
-        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-            if ((val_to_write ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
-                    MSTATUS_MPRV | MSTATUS_SUM)) {
-                helper_tlb_flush(env);
-            }
-            mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
-                MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
-                MSTATUS_MPP | MSTATUS_MXR;
-        }
-
-        /* silenty discard mstatus.mpp writes for unsupported modes */
-        if (mpp == PRV_H ||
-            (!riscv_has_ext(env, RVS) && mpp == PRV_S) ||
-            (!riscv_has_ext(env, RVU) && mpp == PRV_U)) {
-            mask &= ~MSTATUS_MPP;
-        }
-
-        mstatus = (mstatus & ~mask) | (val_to_write & mask);
-
-        /* Note: this is a workaround for an issue where mstatus.FS
-           does not report dirty after floating point operations
-           that modify floating point state. This workaround is
-           technically compliant with the RISC-V Privileged
-           specification as it is legal to return only off, or dirty.
-           at the expense of extra floating point save/restore. */
-
-        /* FP is always dirty or off */
-        if (mstatus & MSTATUS_FS) {
-            mstatus |= MSTATUS_FS;
-        }
-
-        int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
-                    ((mstatus & MSTATUS_XS) == MSTATUS_XS);
-        mstatus = set_field(mstatus, MSTATUS_SD, dirty);
-        env->mstatus = mstatus;
-        break;
-    }
-    case CSR_MIP: {
-        /*
-         * Since the writeable bits in MIP are not set asynchrously by the
-         * CLINT, no additional locking is needed for read-modifiy-write
-         * CSR operations
-         */
-        qemu_mutex_lock_iothread();
-        RISCVCPU *cpu = riscv_env_get_cpu(env);
-        riscv_cpu_update_mip(cpu, MIP_SSIP | MIP_STIP,
-                                  (val_to_write & (MIP_SSIP | MIP_STIP)));
-        /*
-         * csrs, csrc on mip.SEIP is not decomposable into separate read and
-         * write steps, so a different implementation is needed
-         */
-        qemu_mutex_unlock_iothread();
-        break;
-    }
-    case CSR_MIE: {
-        env->mie = (env->mie & ~all_ints) |
-            (val_to_write & all_ints);
-        break;
-    }
-    case CSR_MIDELEG:
-        env->mideleg = (env->mideleg & ~delegable_ints)
-                                | (val_to_write & delegable_ints);
-        break;
-    case CSR_MEDELEG: {
-        target_ulong mask = 0;
-        mask |= 1ULL << (RISCV_EXCP_INST_ADDR_MIS);
-        mask |= 1ULL << (RISCV_EXCP_INST_ACCESS_FAULT);
-        mask |= 1ULL << (RISCV_EXCP_ILLEGAL_INST);
-        mask |= 1ULL << (RISCV_EXCP_BREAKPOINT);
-        mask |= 1ULL << (RISCV_EXCP_LOAD_ADDR_MIS);
-        mask |= 1ULL << (RISCV_EXCP_LOAD_ACCESS_FAULT);
-        mask |= 1ULL << (RISCV_EXCP_STORE_AMO_ADDR_MIS);
-        mask |= 1ULL << (RISCV_EXCP_STORE_AMO_ACCESS_FAULT);
-        mask |= 1ULL << (RISCV_EXCP_U_ECALL);
-        mask |= 1ULL << (RISCV_EXCP_S_ECALL);
-        mask |= 1ULL << (RISCV_EXCP_H_ECALL);
-        mask |= 1ULL << (RISCV_EXCP_M_ECALL);
-        mask |= 1ULL << (RISCV_EXCP_INST_PAGE_FAULT);
-        mask |= 1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT);
-        mask |= 1ULL << (RISCV_EXCP_STORE_PAGE_FAULT);
-        env->medeleg = (env->medeleg & ~mask)
-                                | (val_to_write & mask);
-        break;
-    }
-    case CSR_MINSTRET:
-        /* minstret is WARL so unsupported writes are ignored */
-        break;
-    case CSR_MCYCLE:
-        /* mcycle is WARL so unsupported writes are ignored */
-        break;
-#if defined(TARGET_RISCV32)
-    case CSR_MINSTRETH:
-        /* minstreth is WARL so unsupported writes are ignored */
-        break;
-    case CSR_MCYCLEH:
-        /* mcycleh is WARL so unsupported writes are ignored */
-        break;
-#endif
-    case CSR_MUCOUNTEREN:
-        if (env->priv_ver <= PRIV_VERSION_1_09_1) {
-            env->scounteren = val_to_write;
-            break;
-        } else {
-            goto do_illegal;
-        }
-    case CSR_MSCOUNTEREN:
-        if (env->priv_ver <= PRIV_VERSION_1_09_1) {
-            env->mcounteren = val_to_write;
-            break;
-        } else {
-            goto do_illegal;
-        }
-    case CSR_SSTATUS: {
-        target_ulong ms = env->mstatus;
-        target_ulong mask = SSTATUS_SIE | SSTATUS_SPIE | SSTATUS_UIE
-            | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS
-            | SSTATUS_SUM | SSTATUS_SD;
-        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-            mask |= SSTATUS_MXR;
-        }
-        ms = (ms & ~mask) | (val_to_write & mask);
-        csr_write_helper(env, ms, CSR_MSTATUS);
-        break;
-    }
-    case CSR_SIP: {
-        qemu_mutex_lock_iothread();
-        target_ulong next_mip = (env->mip & ~env->mideleg)
-                                | (val_to_write & env->mideleg);
-        qemu_mutex_unlock_iothread();
-        csr_write_helper(env, next_mip, CSR_MIP);
-        break;
-    }
-    case CSR_SIE: {
-        target_ulong next_mie = (env->mie & ~env->mideleg)
-                                | (val_to_write & env->mideleg);
-        csr_write_helper(env, next_mie, CSR_MIE);
-        break;
-    }
-    case CSR_SATP: /* CSR_SPTBR */ {
-        if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
-            break;
-        }
-        if (env->priv_ver <= PRIV_VERSION_1_09_1 && (val_to_write ^ env->sptbr))
-        {
-            helper_tlb_flush(env);
-            env->sptbr = val_to_write & (((target_ulong)
-                1 << (TARGET_PHYS_ADDR_SPACE_BITS - PGSHIFT)) - 1);
-        }
-        if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
-            validate_vm(env, get_field(val_to_write, SATP_MODE)) &&
-            ((val_to_write ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
-        {
-            helper_tlb_flush(env);
-            env->satp = val_to_write;
-        }
-        break;
-    }
-    case CSR_SEPC:
-        env->sepc = val_to_write;
-        break;
-    case CSR_STVEC:
-        /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
-        if ((val_to_write & 3) == 0) {
-            env->stvec = val_to_write >> 2 << 2;
-        } else {
-            qemu_log_mask(LOG_UNIMP, "CSR_STVEC: vectored traps not supported");
-        }
-        break;
-    case CSR_SCOUNTEREN:
-        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-            env->scounteren = val_to_write;
-            break;
-        } else {
-            goto do_illegal;
-        }
-    case CSR_SSCRATCH:
-        env->sscratch = val_to_write;
-        break;
-    case CSR_SCAUSE:
-        env->scause = val_to_write;
-        break;
-    case CSR_SBADADDR:
-        env->sbadaddr = val_to_write;
-        break;
-    case CSR_MEPC:
-        env->mepc = val_to_write;
-        break;
-    case CSR_MTVEC:
-        /* bits [1:0] indicate mode; 0 = direct, 1 = vectored, 2 >= reserved */
-        if ((val_to_write & 3) == 0) {
-            env->mtvec = val_to_write >> 2 << 2;
-        } else {
-            qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: vectored traps not supported");
-        }
-        break;
-    case CSR_MCOUNTEREN:
-        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-            env->mcounteren = val_to_write;
-            break;
-        } else {
-            goto do_illegal;
-        }
-    case CSR_MSCRATCH:
-        env->mscratch = val_to_write;
-        break;
-    case CSR_MCAUSE:
-        env->mcause = val_to_write;
-        break;
-    case CSR_MBADADDR:
-        env->mbadaddr = val_to_write;
-        break;
-    case CSR_MISA:
-        /* misa is WARL so unsupported writes are ignored */
-        break;
-    case CSR_PMPCFG0:
-    case CSR_PMPCFG1:
-    case CSR_PMPCFG2:
-    case CSR_PMPCFG3:
-       pmpcfg_csr_write(env, csrno - CSR_PMPCFG0, val_to_write);
-       break;
-    case CSR_PMPADDR0:
-    case CSR_PMPADDR1:
-    case CSR_PMPADDR2:
-    case CSR_PMPADDR3:
-    case CSR_PMPADDR4:
-    case CSR_PMPADDR5:
-    case CSR_PMPADDR6:
-    case CSR_PMPADDR7:
-    case CSR_PMPADDR8:
-    case CSR_PMPADDR9:
-    case CSR_PMPADDR10:
-    case CSR_PMPADDR11:
-    case CSR_PMPADDR12:
-    case CSR_PMPADDR13:
-    case CSR_PMPADDR14:
-    case CSR_PMPADDR15:
-       pmpaddr_csr_write(env, csrno - CSR_PMPADDR0, val_to_write);
-       break;
-#endif
-#if !defined(CONFIG_USER_ONLY)
-    do_illegal:
-#endif
-    default:
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
-    }
-}
-
-/*
- * Handle reads to CSRs and any resulting special behavior
- *
- * Adapted from Spike's processor_t::get_csr
- */
-target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
-{
-#ifndef CONFIG_USER_ONLY
-    target_ulong ctr_en = env->priv == PRV_U ? env->scounteren :
-                          env->priv == PRV_S ? env->mcounteren : -1U;
-#else
-    target_ulong ctr_en = -1;
-#endif
-    target_ulong ctr_ok = (ctr_en >> (csrno & 31)) & 1;
-
-    if (csrno >= CSR_HPMCOUNTER3 && csrno <= CSR_HPMCOUNTER31) {
-        if (ctr_ok) {
-            return 0;
-        }
-    }
-#if defined(TARGET_RISCV32)
-    if (csrno >= CSR_HPMCOUNTER3H && csrno <= CSR_HPMCOUNTER31H) {
-        if (ctr_ok) {
-            return 0;
-        }
-    }
-#endif
-    if (csrno >= CSR_MHPMCOUNTER3 && csrno <= CSR_MHPMCOUNTER31) {
-        return 0;
-    }
-#if defined(TARGET_RISCV32)
-    if (csrno >= CSR_MHPMCOUNTER3 && csrno <= CSR_MHPMCOUNTER31) {
-        return 0;
-    }
-#endif
-    if (csrno >= CSR_MHPMEVENT3 && csrno <= CSR_MHPMEVENT31) {
-        return 0;
-    }
-
-    switch (csrno) {
-    case CSR_FFLAGS:
-        validate_mstatus_fs(env, GETPC());
-        return cpu_riscv_get_fflags(env);
-    case CSR_FRM:
-        validate_mstatus_fs(env, GETPC());
-        return env->frm;
-    case CSR_FCSR:
-        validate_mstatus_fs(env, GETPC());
-        return (cpu_riscv_get_fflags(env) << FSR_AEXC_SHIFT)
-                | (env->frm << FSR_RD_SHIFT);
-    /* rdtime/rdtimeh is trapped and emulated by bbl in system mode */
-#ifdef CONFIG_USER_ONLY
-    case CSR_TIME:
-        return cpu_get_host_ticks();
-#if defined(TARGET_RISCV32)
-    case CSR_TIMEH:
-        return cpu_get_host_ticks() >> 32;
-#endif
-#endif
-    case CSR_INSTRET:
-    case CSR_CYCLE:
-        if (ctr_ok) {
-#if !defined(CONFIG_USER_ONLY)
-            if (use_icount) {
-                return cpu_get_icount();
-            } else {
-                return cpu_get_host_ticks();
-            }
-#else
-            return cpu_get_host_ticks();
-#endif
-        }
-        break;
-#if defined(TARGET_RISCV32)
-    case CSR_INSTRETH:
-    case CSR_CYCLEH:
-        if (ctr_ok) {
-#if !defined(CONFIG_USER_ONLY)
-            if (use_icount) {
-                return cpu_get_icount() >> 32;
-            } else {
-                return cpu_get_host_ticks() >> 32;
-            }
-#else
-            return cpu_get_host_ticks() >> 32;
-#endif
-        }
-        break;
-#endif
-#ifndef CONFIG_USER_ONLY
-    case CSR_MINSTRET:
-    case CSR_MCYCLE:
-        if (use_icount) {
-            return cpu_get_icount();
-        } else {
-            return cpu_get_host_ticks();
-        }
-    case CSR_MINSTRETH:
-    case CSR_MCYCLEH:
-#if defined(TARGET_RISCV32)
-        if (use_icount) {
-            return cpu_get_icount() >> 32;
-        } else {
-            return cpu_get_host_ticks() >> 32;
-        }
-#endif
-        break;
-    case CSR_MUCOUNTEREN:
-        if (env->priv_ver <= PRIV_VERSION_1_09_1) {
-            return env->scounteren;
-        } else {
-            break; /* illegal instruction */
-        }
-    case CSR_MSCOUNTEREN:
-        if (env->priv_ver <= PRIV_VERSION_1_09_1) {
-            return env->mcounteren;
-        } else {
-            break; /* illegal instruction */
-        }
-    case CSR_SSTATUS: {
-        target_ulong mask = SSTATUS_SIE | SSTATUS_SPIE | SSTATUS_UIE
-            | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS
-            | SSTATUS_SUM | SSTATUS_SD;
-        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-            mask |= SSTATUS_MXR;
-        }
-        return env->mstatus & mask;
-    }
-    case CSR_SIP: {
-        qemu_mutex_lock_iothread();
-        target_ulong tmp = env->mip & env->mideleg;
-        qemu_mutex_unlock_iothread();
-        return tmp;
-    }
-    case CSR_SIE:
-        return env->mie & env->mideleg;
-    case CSR_SEPC:
-        return env->sepc;
-    case CSR_SBADADDR:
-        return env->sbadaddr;
-    case CSR_STVEC:
-        return env->stvec;
-    case CSR_SCOUNTEREN:
-        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-            return env->scounteren;
-        } else {
-            break; /* illegal instruction */
-        }
-    case CSR_SCAUSE:
-        return env->scause;
-    case CSR_SATP: /* CSR_SPTBR */
-        if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
-            return 0;
-        }
-        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-            return env->satp;
-        } else {
-            return env->sptbr;
-        }
-    case CSR_SSCRATCH:
-        return env->sscratch;
-    case CSR_MSTATUS:
-        return env->mstatus;
-    case CSR_MIP: {
-        qemu_mutex_lock_iothread();
-        target_ulong tmp = env->mip;
-        qemu_mutex_unlock_iothread();
-        return tmp;
-    }
-    case CSR_MIE:
-        return env->mie;
-    case CSR_MEPC:
-        return env->mepc;
-    case CSR_MSCRATCH:
-        return env->mscratch;
-    case CSR_MCAUSE:
-        return env->mcause;
-    case CSR_MBADADDR:
-        return env->mbadaddr;
-    case CSR_MISA:
-        return env->misa;
-    case CSR_MARCHID:
-        return 0; /* as spike does */
-    case CSR_MIMPID:
-        return 0; /* as spike does */
-    case CSR_MVENDORID:
-        return 0; /* as spike does */
-    case CSR_MHARTID:
-        return env->mhartid;
-    case CSR_MTVEC:
-        return env->mtvec;
-    case CSR_MCOUNTEREN:
-        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-            return env->mcounteren;
-        } else {
-            break; /* illegal instruction */
-        }
-    case CSR_MEDELEG:
-        return env->medeleg;
-    case CSR_MIDELEG:
-        return env->mideleg;
-    case CSR_PMPCFG0:
-    case CSR_PMPCFG1:
-    case CSR_PMPCFG2:
-    case CSR_PMPCFG3:
-       return pmpcfg_csr_read(env, csrno - CSR_PMPCFG0);
-    case CSR_PMPADDR0:
-    case CSR_PMPADDR1:
-    case CSR_PMPADDR2:
-    case CSR_PMPADDR3:
-    case CSR_PMPADDR4:
-    case CSR_PMPADDR5:
-    case CSR_PMPADDR6:
-    case CSR_PMPADDR7:
-    case CSR_PMPADDR8:
-    case CSR_PMPADDR9:
-    case CSR_PMPADDR10:
-    case CSR_PMPADDR11:
-    case CSR_PMPADDR12:
-    case CSR_PMPADDR13:
-    case CSR_PMPADDR14:
-    case CSR_PMPADDR15:
-       return pmpaddr_csr_read(env, csrno - CSR_PMPADDR0);
-#endif
-    }
-    /* used by e.g. MTIME read */
-    do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
-}
-
-/*
- * Check that CSR access is allowed.
- *
- * Adapted from Spike's decode.h:validate_csr
- */
-static void validate_csr(CPURISCVState *env, uint64_t which,
-                         uint64_t write, uintptr_t ra)
-{
-#ifndef CONFIG_USER_ONLY
-    unsigned csr_priv = get_field((which), 0x300);
-    unsigned csr_read_only = get_field((which), 0xC00) == 3;
-    if (((write) && csr_read_only) || (env->priv < csr_priv)) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, ra);
-    }
-#endif
-}
-
 target_ulong helper_csrrw(CPURISCVState *env, target_ulong src,
         target_ulong csr)
 {
-    validate_csr(env, csr, 1, GETPC());
-    uint64_t csr_backup = csr_read_helper(env, csr);
-    csr_write_helper(env, src, csr);
-    return csr_backup;
+    target_ulong val = 0;
+    if (riscv_csrrw(env, csr, &val, src, -1) < 0) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+    return val;
 }
 
 target_ulong helper_csrrs(CPURISCVState *env, target_ulong src,
         target_ulong csr, target_ulong rs1_pass)
 {
-    validate_csr(env, csr, rs1_pass != 0, GETPC());
-    uint64_t csr_backup = csr_read_helper(env, csr);
-    if (rs1_pass != 0) {
-        csr_write_helper(env, src | csr_backup, csr);
+    target_ulong val = 0;
+    if (riscv_csrrw(env, csr, &val, -1, rs1_pass ? src : 0) < 0) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
-    return csr_backup;
+    return val;
 }
 
 target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
         target_ulong csr, target_ulong rs1_pass)
 {
-    validate_csr(env, csr, rs1_pass != 0, GETPC());
-    uint64_t csr_backup = csr_read_helper(env, csr);
-    if (rs1_pass != 0) {
-        csr_write_helper(env, (~src) & csr_backup, csr);
+    target_ulong val = 0;
+    if (riscv_csrrw(env, csr, &val, 0, rs1_pass ? src : 0) < 0) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
-    return csr_backup;
+    return val;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -672,7 +91,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
     mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
     mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
     riscv_set_mode(env, prev_priv);
-    csr_write_helper(env, mstatus, CSR_MSTATUS);
+    env->mstatus = mstatus;
 
     return retpc;
 }
@@ -697,7 +116,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
     mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
     mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
     riscv_set_mode(env, prev_priv);
-    csr_write_helper(env, mstatus, CSR_MSTATUS);
+    env->mstatus = mstatus;
 
     return retpc;
 }
-- 
2.7.0
