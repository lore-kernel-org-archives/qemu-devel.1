Received: from eggsout.gnu.org ([209.51.188.92]:39274 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=90010c98c=Alistair.Francis@wdc.com>)
	id 1gfYov-000213-5o
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=90010c98c=Alistair.Francis@wdc.com>)
	id 1gfYop-0003qV-UW
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:24:05 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Fri, 4 Jan 2019 23:23:55 +0000
Message-ID: <0337c54faa2fc1e33a160b374ad9ec63fbd8e9f8.1546644177.git.alistair.francis@wdc.com>
References: <cover.1546644177.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1546644177.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 1/3] RISC-V: Implement modular CSR helper
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

From: Michael Clark <mjc@sifive.com>

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

An API is added to allow derived cpu instances to modify
or implement new CSR operations.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/Makefile.objs |   2 +-
 target/riscv/cpu.h         |  35 +-
 target/riscv/cpu_helper.c  |   4 +-
 target/riscv/csr.c         | 846 +++++++++++++++++++++++++++++++++++++
 target/riscv/gdbstub.c     |  10 +-
 target/riscv/op_helper.c   | 613 +--------------------------
 6 files changed, 904 insertions(+), 606 deletions(-)
 create mode 100644 target/riscv/csr.c

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index fcc5d34c1f..4072abe3e4 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -1 +1 @@
-obj-y +=3D translate.o op_helper.o cpu_helper.o cpu.o fpu_helper.o gdbstub=
.o pmp.o
+obj-y +=3D translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o g=
dbstub.o pmp.o
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4ee09b9cff..4aeaa32049 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -289,9 +289,38 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState =
*env, target_ulong *pc,
 #endif
 }
=20
-void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
-        target_ulong csrno);
-target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno);
+int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                target_ulong new_value, target_ulong write_mask);
+
+static inline void csr_write_helper(CPURISCVState *env, target_ulong val,
+                                    int csrno)
+{
+    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS=
));
+}
+
+static inline target_ulong csr_read_helper(CPURISCVState *env, int csrno)
+{
+    target_ulong val =3D 0;
+    riscv_csrrw(env, csrno, &val, 0, 0);
+    return val;
+}
+
+typedef int (*riscv_csr_predicate_fn)(CPURISCVState *env, int csrno);
+typedef int (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
+    target_ulong *ret_value);
+typedef int (*riscv_csr_write_fn)(CPURISCVState *env, int csrno,
+    target_ulong new_value);
+typedef int (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
+    target_ulong *ret_value, target_ulong new_value, target_ulong write_ma=
sk);
+
+typedef struct {
+    riscv_csr_read_fn read;
+    riscv_csr_write_fn write;
+    riscv_csr_op_fn op;
+} riscv_csr_operations;
+
+void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
+void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
=20
 #include "exec/cpu-all.h"
=20
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0234c2d528..4ef7f5c1f9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -528,7 +528,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->p=
riv));
         s =3D set_field(s, MSTATUS_SPP, env->priv);
         s =3D set_field(s, MSTATUS_SIE, 0);
-        csr_write_helper(env, s, CSR_MSTATUS);
+        env->mstatus =3D s;
         riscv_set_mode(env, PRV_S);
     } else {
         /* No need to check MTVEC for misaligned - lower 2 bits cannot be =
set */
@@ -553,7 +553,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->p=
riv));
         s =3D set_field(s, MSTATUS_MPP, env->priv);
         s =3D set_field(s, MSTATUS_MIE, 0);
-        csr_write_helper(env, s, CSR_MSTATUS);
+        env->mstatus =3D s;
         riscv_set_mode(env, PRV_M);
     }
     /* TODO yield load reservation  */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
new file mode 100644
index 0000000000..b61b0ef379
--- /dev/null
+++ b/target/riscv/csr.c
@@ -0,0 +1,846 @@
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
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "qemu/main-loop.h"
+#include "exec/exec-all.h"
+
+/* CSR function table */
+static riscv_csr_operations csr_ops[];
+
+/* CSR function table constants */
+enum {
+    CSR_TABLE_SIZE =3D 0x1000
+};
+
+/* CSR function table public API */
+void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
+{
+    *ops =3D csr_ops[csrno & (CSR_TABLE_SIZE - 1)];
+}
+
+void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
+{
+    csr_ops[csrno & (CSR_TABLE_SIZE - 1)] =3D *ops;
+}
+
+/* User Floating-Point CSRs */
+static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!(env->mstatus & MSTATUS_FS)) {
+        return -1;
+    }
+#endif
+    *val =3D cpu_riscv_get_fflags(env);
+    return 0;
+}
+
+static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!(env->mstatus & MSTATUS_FS)) {
+        return -1;
+    }
+    env->mstatus |=3D MSTATUS_FS;
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
+    *val =3D env->frm;
+    return 0;
+}
+
+static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!(env->mstatus & MSTATUS_FS)) {
+        return -1;
+    }
+    env->mstatus |=3D MSTATUS_FS;
+#endif
+    env->frm =3D val & (FSR_RD >> FSR_RD_SHIFT);
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
+    *val =3D (cpu_riscv_get_fflags(env) << FSR_AEXC_SHIFT)
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
+    env->mstatus |=3D MSTATUS_FS;
+#endif
+    env->frm =3D (val & FSR_RD) >> FSR_RD_SHIFT;
+    cpu_riscv_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
+    return 0;
+}
+
+/* User Timers and Counters */
+static int counter_enabled(CPURISCVState *env, int csrno)
+{
+#ifndef CONFIG_USER_ONLY
+    target_ulong ctr_en =3D env->priv =3D=3D PRV_U ? env->scounteren :
+                          env->priv =3D=3D PRV_S ? env->mcounteren : -1U;
+#else
+    target_ulong ctr_en =3D -1;
+#endif
+    return (ctr_en >> (csrno & 31)) & 1;
+}
+
+#if !defined(CONFIG_USER_ONLY)
+static int read_zero_counter(CPURISCVState *env, int csrno, target_ulong *=
val)
+{
+    if (!counter_enabled(env, csrno)) {
+        return -1;
+    }
+    *val =3D 0;
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
+        *val =3D cpu_get_icount();
+    } else {
+        *val =3D cpu_get_host_ticks();
+    }
+#else
+    *val =3D cpu_get_host_ticks();
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
+        *val =3D cpu_get_icount() >> 32;
+    } else {
+        *val =3D cpu_get_host_ticks() >> 32;
+    }
+#else
+    *val =3D cpu_get_host_ticks() >> 32;
+#endif
+    return 0;
+}
+#endif /* TARGET_RISCV32 */
+
+#if defined(CONFIG_USER_ONLY)
+static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D cpu_get_host_ticks();
+    return 0;
+}
+
+#if defined(TARGET_RISCV32)
+static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D cpu_get_host_ticks() >> 32;
+    return 0;
+}
+#endif
+
+#else /* CONFIG_USER_ONLY */
+
+/* Machine constants */
+
+#define M_MODE_INTERRUPTS (MIP_MSIP | MIP_MTIP | MIP_MEIP)
+#define S_MODE_INTERRUPTS (MIP_SSIP | MIP_STIP | MIP_SEIP)
+
+static const target_ulong delegable_ints =3D S_MODE_INTERRUPTS;
+static const target_ulong all_ints =3D M_MODE_INTERRUPTS | S_MODE_INTERRUP=
TS;
+static const target_ulong delegable_excps =3D
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
+static const target_ulong sstatus_v1_9_mask =3D SSTATUS_SIE | SSTATUS_SPIE=
 |
+    SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
+    SSTATUS_SUM | SSTATUS_SD;
+static const target_ulong sstatus_v1_10_mask =3D SSTATUS_SIE | SSTATUS_SPI=
E |
+    SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
+    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
+
+#if defined(TARGET_RISCV32)
+static const char valid_vm_1_09[16] =3D {
+    [VM_1_09_MBARE] =3D 1,
+    [VM_1_09_SV32] =3D 1,
+};
+static const char valid_vm_1_10[16] =3D {
+    [VM_1_10_MBARE] =3D 1,
+    [VM_1_10_SV32] =3D 1
+};
+#elif defined(TARGET_RISCV64)
+static const char valid_vm_1_09[16] =3D {
+    [VM_1_09_MBARE] =3D 1,
+    [VM_1_09_SV39] =3D 1,
+    [VM_1_09_SV48] =3D 1,
+};
+static const char valid_vm_1_10[16] =3D {
+    [VM_1_10_MBARE] =3D 1,
+    [VM_1_10_SV39] =3D 1,
+    [VM_1_10_SV48] =3D 1,
+    [VM_1_10_SV57] =3D 1
+};
+#endif /* CONFIG_USER_ONLY */
+
+/* Machine Information Registers */
+static int read_zero(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    return *val =3D 0;
+}
+
+static int read_mhartid(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->mhartid;
+    return 0;
+}
+
+/* Machine Trap Setup */
+static int read_mstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->mstatus;
+    return 0;
+}
+
+static int validate_vm(CPURISCVState *env, target_ulong vm)
+{
+    return (env->priv_ver >=3D PRIV_VERSION_1_10_0) ?
+        valid_vm_1_10[vm & 0xf] : valid_vm_1_09[vm & 0xf];
+}
+
+static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong mstatus =3D env->mstatus;
+    target_ulong mask =3D 0;
+    target_ulong mpp =3D get_field(val, MSTATUS_MPP);
+
+    /* flush tlb on mstatus fields that affect VM */
+    if (env->priv_ver <=3D PRIV_VERSION_1_09_1) {
+        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
+                MSTATUS_MPRV | MSTATUS_SUM | MSTATUS_VM)) {
+            tlb_flush(CPU(riscv_env_get_cpu(env)));
+        }
+        mask =3D MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
+            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
+            MSTATUS_MPP | MSTATUS_MXR |
+            (validate_vm(env, get_field(val, MSTATUS_VM)) ?
+                MSTATUS_VM : 0);
+    }
+    if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
+        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
+                MSTATUS_MPRV | MSTATUS_SUM)) {
+            tlb_flush(CPU(riscv_env_get_cpu(env)));
+        }
+        mask =3D MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
+            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
+            MSTATUS_MPP | MSTATUS_MXR;
+    }
+
+    /* silenty discard mstatus.mpp writes for unsupported modes */
+    if (mpp =3D=3D PRV_H ||
+        (!riscv_has_ext(env, RVS) && mpp =3D=3D PRV_S) ||
+        (!riscv_has_ext(env, RVU) && mpp =3D=3D PRV_U)) {
+        mask &=3D ~MSTATUS_MPP;
+    }
+
+    mstatus =3D (mstatus & ~mask) | (val & mask);
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
+        mstatus |=3D MSTATUS_FS;
+    }
+
+    int dirty =3D ((mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS) |
+                ((mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS);
+    mstatus =3D set_field(mstatus, MSTATUS_SD, dirty);
+    env->mstatus =3D mstatus;
+
+    return 0;
+}
+
+static int read_misa(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->misa;
+    return 0;
+}
+
+static int read_medeleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->medeleg;
+    return 0;
+}
+
+static int write_medeleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->medeleg =3D (env->medeleg & ~delegable_excps) | (val & delegable_=
excps);
+    return 0;
+}
+
+static int read_mideleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->mideleg;
+    return 0;
+}
+
+static int write_mideleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mideleg =3D (env->mideleg & ~delegable_ints) | (val & delegable_i=
nts);
+    return 0;
+}
+
+static int read_mie(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->mie;
+    return 0;
+}
+
+static int write_mie(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mie =3D (env->mie & ~all_ints) | (val & all_ints);
+    return 0;
+}
+
+static int read_mtvec(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->mtvec;
+    return 0;
+}
+
+static int write_mtvec(CPURISCVState *env, int csrno, target_ulong val)
+{
+    /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D reserv=
ed */
+    if ((val & 3) =3D=3D 0) {
+        env->mtvec =3D val >> 2 << 2;
+    } else {
+        qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: vectored traps not supported"=
);
+    }
+    return 0;
+}
+
+static int read_mcounteren(CPURISCVState *env, int csrno, target_ulong *va=
l)
+{
+    if (env->priv_ver < PRIV_VERSION_1_10_0) {
+        return -1;
+    }
+    *val =3D env->mcounteren;
+    return 0;
+}
+
+static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong va=
l)
+{
+    if (env->priv_ver < PRIV_VERSION_1_10_0) {
+        return -1;
+    }
+    env->mcounteren =3D val;
+    return 0;
+}
+
+static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *v=
al)
+{
+    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+        return -1;
+    }
+    *val =3D env->mcounteren;
+    return 0;
+}
+
+static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong v=
al)
+{
+    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+        return -1;
+    }
+    env->mcounteren =3D val;
+    return 0;
+}
+
+static int read_mucounteren(CPURISCVState *env, int csrno, target_ulong *v=
al)
+{
+    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+        return -1;
+    }
+    *val =3D env->scounteren;
+    return 0;
+}
+
+static int write_mucounteren(CPURISCVState *env, int csrno, target_ulong v=
al)
+{
+    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+        return -1;
+    }
+    env->scounteren =3D val;
+    return 0;
+}
+
+/* Machine Trap Handling */
+static int read_mscratch(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->mscratch;
+    return 0;
+}
+
+static int write_mscratch(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mscratch =3D val;
+    return 0;
+}
+
+static int read_mepc(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->mepc;
+    return 0;
+}
+
+static int write_mepc(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mepc =3D val;
+    return 0;
+}
+
+static int read_mcause(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->mcause;
+    return 0;
+}
+
+static int write_mcause(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mcause =3D val;
+    return 0;
+}
+
+static int read_mbadaddr(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->mbadaddr;
+    return 0;
+}
+
+static int write_mbadaddr(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mbadaddr =3D val;
+    return 0;
+}
+
+static int read_mip(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D atomic_read(&env->mip);
+    return 0;
+}
+
+static int write_mip(CPURISCVState *env, int csrno, target_ulong val)
+{
+    RISCVCPU *cpu =3D riscv_env_get_cpu(env);
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
+static int read_sstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    target_ulong mask =3D ((env->priv_ver >=3D PRIV_VERSION_1_10_0) ?
+                         sstatus_v1_10_mask : sstatus_v1_9_mask);
+    *val =3D env->mstatus & mask;
+    return 0;
+}
+
+static int write_sstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong mask =3D ((env->priv_ver >=3D PRIV_VERSION_1_10_0) ?
+                         sstatus_v1_10_mask : sstatus_v1_9_mask);
+    target_ulong newval =3D (env->mstatus & ~mask) | (val & mask);
+    return write_mstatus(env, CSR_MSTATUS, newval);
+}
+
+static int read_sie(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->mie & env->mideleg;
+    return 0;
+}
+
+static int write_sie(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong newval =3D (env->mie & ~env->mideleg) | (val & env->midel=
eg);
+    return write_mie(env, CSR_MIE, newval);
+}
+
+static int read_stvec(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->stvec;
+    return 0;
+}
+
+static int write_stvec(CPURISCVState *env, int csrno, target_ulong val)
+{
+    /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D reserv=
ed */
+    if ((val & 3) =3D=3D 0) {
+        env->stvec =3D val >> 2 << 2;
+    } else {
+        qemu_log_mask(LOG_UNIMP, "CSR_STVEC: vectored traps not supported"=
);
+    }
+    return 0;
+}
+
+static int read_scounteren(CPURISCVState *env, int csrno, target_ulong *va=
l)
+{
+    if (env->priv_ver < PRIV_VERSION_1_10_0) {
+        return -1;
+    }
+    *val =3D env->scounteren;
+    return 0;
+}
+
+static int write_scounteren(CPURISCVState *env, int csrno, target_ulong va=
l)
+{
+    if (env->priv_ver < PRIV_VERSION_1_10_0) {
+        return -1;
+    }
+    env->scounteren =3D val;
+    return 0;
+}
+
+/* Supervisor Trap Handling */
+static int read_sscratch(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->sscratch;
+    return 0;
+}
+
+static int write_sscratch(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->sscratch =3D val;
+    return 0;
+}
+
+static int read_sepc(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->sepc;
+    return 0;
+}
+
+static int write_sepc(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->sepc =3D val;
+    return 0;
+}
+
+static int read_scause(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->scause;
+    return 0;
+}
+
+static int write_scause(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->scause =3D val;
+    return 0;
+}
+
+static int read_sbadaddr(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->sbadaddr;
+    return 0;
+}
+
+static int write_sbadaddr(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->sbadaddr =3D val;
+    return 0;
+}
+
+static int read_sip(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D atomic_read(&env->mip) & env->mideleg;
+    return 0;
+}
+
+static int write_sip(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong newval =3D (atomic_read(&env->mip) & ~env->mideleg)
+                          | (val & env->mideleg);
+    return write_mip(env, CSR_MIP, newval);
+}
+
+/* Supervisor Protection and Translation */
+static int read_satp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
+        *val =3D 0;
+    } else if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
+        *val =3D env->satp;
+    } else {
+        *val =3D env->sptbr;
+    }
+    return 0;
+}
+
+static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
+        return 0;
+    }
+    if (env->priv_ver <=3D PRIV_VERSION_1_09_1 && (val ^ env->sptbr)) {
+        tlb_flush(CPU(riscv_env_get_cpu(env)));
+        env->sptbr =3D val & (((target_ulong)
+            1 << (TARGET_PHYS_ADDR_SPACE_BITS - PGSHIFT)) - 1);
+    }
+    if (env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
+        validate_vm(env, get_field(val, SATP_MODE)) &&
+        ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
+    {
+        tlb_flush(CPU(riscv_env_get_cpu(env)));
+        env->satp =3D val;
+    }
+    return 0;
+}
+
+/* Physical Memory Protection */
+static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D pmpcfg_csr_read(env, csrno - CSR_PMPCFG0);
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
+    *val =3D pmpaddr_csr_read(env, csrno - CSR_PMPADDR0);
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
+    int csr_priv =3D get_field(csrno, 0x300);
+    int read_only =3D get_field(csrno, 0xC00) =3D=3D 3;
+    if ((write_mask && read_only) || (env->priv < csr_priv)) {
+        return -1;
+    }
+#endif
+
+    /* execute combined read/write operation if it exists */
+    if (csr_ops[csrno].op) {
+        return csr_ops[csrno].op(env, csrno, ret_value, new_value, write_m=
ask);
+    }
+
+    /* if no accessor exists then return failure */
+    if (!csr_ops[csrno].read) {
+        return -1;
+    }
+
+    /* read old value */
+    ret =3D csr_ops[csrno].read(env, csrno, &old_value);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* write value if writable and write mask set, otherwise drop writes *=
/
+    if (write_mask) {
+        new_value =3D (old_value & ~write_mask) | (new_value & write_mask)=
;
+        if (csr_ops[csrno].write) {
+            ret =3D csr_ops[csrno].write(env, csrno, new_value);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+    }
+
+    /* return old value */
+    if (ret_value) {
+        *ret_value =3D old_value;
+    }
+
+    return 0;
+}
+
+/* Control and Status Register function table */
+static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
+    /* User Floating-Point CSRs */
+    [CSR_FFLAGS] =3D              { read_fflags,      write_fflags      },
+    [CSR_FRM] =3D                 { read_frm,         write_frm         },
+    [CSR_FCSR] =3D                { read_fcsr,        write_fcsr        },
+
+    /* User Timers and Counters */
+    [CSR_CYCLE] =3D               { read_instret                        },
+    [CSR_INSTRET] =3D             { read_instret                        },
+#if defined(TARGET_RISCV32)
+    [CSR_CYCLEH] =3D              { read_instreth                       },
+    [CSR_INSTRETH] =3D            { read_instreth                       },
+#endif
+
+    /* User-level time CSRs are only available in linux-user
+     * In privileged mode, the monitor emulates these CSRs */
+#if defined(CONFIG_USER_ONLY)
+    [CSR_TIME] =3D                { read_time                           },
+#if defined(TARGET_RISCV32)
+    [CSR_TIMEH] =3D               { read_timeh                          },
+#endif
+#endif
+
+#if !defined(CONFIG_USER_ONLY)
+    /* Machine Timers and Counters */
+    [CSR_MCYCLE] =3D              { read_instret                        },
+    [CSR_MINSTRET] =3D            { read_instret                        },
+#if defined(TARGET_RISCV32)
+    [CSR_MCYCLEH] =3D             { read_instreth                       },
+    [CSR_MINSTRETH] =3D           { read_instreth                       },
+#endif
+
+    /* Machine Information Registers */
+    [CSR_MVENDORID] =3D           { read_zero                           },
+    [CSR_MARCHID] =3D             { read_zero                           },
+    [CSR_MIMPID] =3D              { read_zero                           },
+    [CSR_MHARTID] =3D             { read_mhartid                        },
+
+    /* Machine Trap Setup */
+    [CSR_MSTATUS] =3D             { read_mstatus,     write_mstatus     },
+    [CSR_MISA] =3D                { read_misa                           },
+    [CSR_MIDELEG] =3D             { read_mideleg,     write_mideleg     },
+    [CSR_MEDELEG] =3D             { read_medeleg,     write_medeleg     },
+    [CSR_MIE] =3D                 { read_mie,         write_mie         },
+    [CSR_MTVEC] =3D               { read_mtvec,       write_mtvec       },
+    [CSR_MCOUNTEREN] =3D          { read_mcounteren,  write_mcounteren  },
+
+    /* Legacy Counter Setup (priv v1.9.1) */
+    [CSR_MUCOUNTEREN] =3D         { read_mucounteren, write_mucounteren },
+    [CSR_MSCOUNTEREN] =3D         { read_mscounteren, write_mscounteren },
+
+    /* Machine Trap Handling */
+    [CSR_MSCRATCH] =3D            { read_mscratch,    write_mscratch    },
+    [CSR_MEPC] =3D                { read_mepc,        write_mepc        },
+    [CSR_MCAUSE] =3D              { read_mcause,      write_mcause      },
+    [CSR_MBADADDR] =3D            { read_mbadaddr,    write_mbadaddr    },
+    [CSR_MIP] =3D                 { read_mip,         write_mip         },
+
+    /* Supervisor Trap Setup */
+    [CSR_SSTATUS] =3D             { read_sstatus,     write_sstatus     },
+    [CSR_SIE] =3D                 { read_sie,         write_sie         },
+    [CSR_STVEC] =3D               { read_stvec,       write_stvec       },
+    [CSR_SCOUNTEREN] =3D          { read_scounteren,  write_scounteren  },
+
+    /* Supervisor Trap Handling */
+    [CSR_SSCRATCH] =3D            { read_sscratch,    write_sscratch    },
+    [CSR_SEPC] =3D                { read_sepc,        write_sepc        },
+    [CSR_SCAUSE] =3D              { read_scause,      write_scause      },
+    [CSR_SBADADDR] =3D            { read_sbadaddr,    write_sbadaddr    },
+    [CSR_SIP] =3D                 { read_sip,         write_sip         },
+
+    /* Supervisor Protection and Translation */
+    [CSR_SATP] =3D                { read_satp,        write_satp        },
+
+    /* Physical Memory Protection */
+    [CSR_PMPCFG0  ... CSR_PMPADDR9] =3D  { read_pmpcfg,  write_pmpcfg   },
+    [CSR_PMPADDR0 ... CSR_PMPADDR15] =3D { read_pmpaddr, write_pmpaddr  },
+
+    /* Performance Counters */
+    [CSR_HPMCOUNTER3   ... CSR_HPMCOUNTER31] =3D    { read_zero_counter },
+    [CSR_MHPMCOUNTER3  ... CSR_MHPMCOUNTER31] =3D   { read_zero         },
+    [CSR_MHPMEVENT3    ... CSR_MHPMEVENT31] =3D     { read_zero         },
+#if defined(TARGET_RISCV32)
+    [CSR_HPMCOUNTER3H  ... CSR_HPMCOUNTER31H] =3D   { read_zero_counter },
+    [CSR_MHPMCOUNTER3H ... CSR_MHPMCOUNTER31H] =3D  { read_zero         },
+#endif
+#endif /* !CONFIG_USER_ONLY */
+};
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 4f919b6c34..3cabb21cd0 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -33,7 +33,10 @@ int riscv_cpu_gdb_read_register(CPUState *cs, uint8_t *m=
em_buf, int n)
     } else if (n < 65) {
         return gdb_get_reg64(mem_buf, env->fpr[n - 33]);
     } else if (n < 4096 + 65) {
-        return gdb_get_regl(mem_buf, csr_read_helper(env, n - 65));
+        target_ulong val =3D 0;
+        if (riscv_csrrw(env, n - 65, &val, 0, 0) =3D=3D 0) {
+            return gdb_get_regl(mem_buf, val);
+        }
     }
     return 0;
 }
@@ -56,7 +59,10 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *=
mem_buf, int n)
         env->fpr[n - 33] =3D ldq_p(mem_buf); /* always 64-bit */
         return sizeof(uint64_t);
     } else if (n < 4096 + 65) {
-        csr_write_helper(env, ldtul_p(mem_buf), n - 65);
+        target_ulong val =3D ldtul_p(mem_buf);
+        if (riscv_csrrw(env, n - 65, NULL, val, -1) =3D=3D 0) {
+            return sizeof(target_ulong);
+        }
     }
     return 0;
 }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 3726299d4a..81bd1a77ea 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -24,39 +24,6 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
=20
-#ifndef CONFIG_USER_ONLY
-
-#if defined(TARGET_RISCV32)
-static const char valid_vm_1_09[16] =3D {
-    [VM_1_09_MBARE] =3D 1,
-    [VM_1_09_SV32] =3D 1,
-};
-static const char valid_vm_1_10[16] =3D {
-    [VM_1_10_MBARE] =3D 1,
-    [VM_1_10_SV32] =3D 1
-};
-#elif defined(TARGET_RISCV64)
-static const char valid_vm_1_09[16] =3D {
-    [VM_1_09_MBARE] =3D 1,
-    [VM_1_09_SV39] =3D 1,
-    [VM_1_09_SV48] =3D 1,
-};
-static const char valid_vm_1_10[16] =3D {
-    [VM_1_10_MBARE] =3D 1,
-    [VM_1_10_SV39] =3D 1,
-    [VM_1_10_SV48] =3D 1,
-    [VM_1_10_SV57] =3D 1
-};
-#endif
-
-static int validate_vm(CPURISCVState *env, target_ulong vm)
-{
-    return (env->priv_ver >=3D PRIV_VERSION_1_10_0) ?
-        valid_vm_1_10[vm & 0xf] : valid_vm_1_09[vm & 0xf];
-}
-
-#endif
-
 /* Exceptions processing helpers */
 void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
                                           uint32_t exception, uintptr_t pc=
)
@@ -72,584 +39,34 @@ void helper_raise_exception(CPURISCVState *env, uint32=
_t exception)
     do_raise_exception_err(env, exception, 0);
 }
=20
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
-    uint64_t delegable_ints =3D MIP_SSIP | MIP_STIP | MIP_SEIP;
-    uint64_t all_ints =3D delegable_ints | MIP_MSIP | MIP_MTIP;
-#endif
-
-    switch (csrno) {
-    case CSR_FFLAGS:
-        validate_mstatus_fs(env, GETPC());
-        cpu_riscv_set_fflags(env, val_to_write & (FSR_AEXC >> FSR_AEXC_SHI=
FT));
-        break;
-    case CSR_FRM:
-        validate_mstatus_fs(env, GETPC());
-        env->frm =3D val_to_write & (FSR_RD >> FSR_RD_SHIFT);
-        break;
-    case CSR_FCSR:
-        validate_mstatus_fs(env, GETPC());
-        env->frm =3D (val_to_write & FSR_RD) >> FSR_RD_SHIFT;
-        cpu_riscv_set_fflags(env, (val_to_write & FSR_AEXC) >> FSR_AEXC_SH=
IFT);
-        break;
-#ifndef CONFIG_USER_ONLY
-    case CSR_MSTATUS: {
-        target_ulong mstatus =3D env->mstatus;
-        target_ulong mask =3D 0;
-        target_ulong mpp =3D get_field(val_to_write, MSTATUS_MPP);
-
-        /* flush tlb on mstatus fields that affect VM */
-        if (env->priv_ver <=3D PRIV_VERSION_1_09_1) {
-            if ((val_to_write ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
-                    MSTATUS_MPRV | MSTATUS_SUM | MSTATUS_VM)) {
-                helper_tlb_flush(env);
-            }
-            mask =3D MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MP=
IE |
-                MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
-                MSTATUS_MPP | MSTATUS_MXR |
-                (validate_vm(env, get_field(val_to_write, MSTATUS_VM)) ?
-                    MSTATUS_VM : 0);
-        }
-        if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
-            if ((val_to_write ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
-                    MSTATUS_MPRV | MSTATUS_SUM)) {
-                helper_tlb_flush(env);
-            }
-            mask =3D MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MP=
IE |
-                MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
-                MSTATUS_MPP | MSTATUS_MXR;
-        }
-
-        /* silenty discard mstatus.mpp writes for unsupported modes */
-        if (mpp =3D=3D PRV_H ||
-            (!riscv_has_ext(env, RVS) && mpp =3D=3D PRV_S) ||
-            (!riscv_has_ext(env, RVU) && mpp =3D=3D PRV_U)) {
-            mask &=3D ~MSTATUS_MPP;
-        }
-
-        mstatus =3D (mstatus & ~mask) | (val_to_write & mask);
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
-            mstatus |=3D MSTATUS_FS;
-        }
-
-        int dirty =3D ((mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS) |
-                    ((mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS);
-        mstatus =3D set_field(mstatus, MSTATUS_SD, dirty);
-        env->mstatus =3D mstatus;
-        break;
-    }
-    case CSR_MIP: {
-        /*
-         * Since the writeable bits in MIP are not set asynchrously by the
-         * CLINT, no additional locking is needed for read-modifiy-write
-         * CSR operations
-         */
-        qemu_mutex_lock_iothread();
-        RISCVCPU *cpu =3D riscv_env_get_cpu(env);
-        riscv_cpu_update_mip(cpu, MIP_SSIP | MIP_STIP,
-                                  (val_to_write & (MIP_SSIP | MIP_STIP)));
-        /*
-         * csrs, csrc on mip.SEIP is not decomposable into separate read a=
nd
-         * write steps, so a different implementation is needed
-         */
-        qemu_mutex_unlock_iothread();
-        break;
-    }
-    case CSR_MIE: {
-        env->mie =3D (env->mie & ~all_ints) |
-            (val_to_write & all_ints);
-        break;
-    }
-    case CSR_MIDELEG:
-        env->mideleg =3D (env->mideleg & ~delegable_ints)
-                                | (val_to_write & delegable_ints);
-        break;
-    case CSR_MEDELEG: {
-        target_ulong mask =3D 0;
-        mask |=3D 1ULL << (RISCV_EXCP_INST_ADDR_MIS);
-        mask |=3D 1ULL << (RISCV_EXCP_INST_ACCESS_FAULT);
-        mask |=3D 1ULL << (RISCV_EXCP_ILLEGAL_INST);
-        mask |=3D 1ULL << (RISCV_EXCP_BREAKPOINT);
-        mask |=3D 1ULL << (RISCV_EXCP_LOAD_ADDR_MIS);
-        mask |=3D 1ULL << (RISCV_EXCP_LOAD_ACCESS_FAULT);
-        mask |=3D 1ULL << (RISCV_EXCP_STORE_AMO_ADDR_MIS);
-        mask |=3D 1ULL << (RISCV_EXCP_STORE_AMO_ACCESS_FAULT);
-        mask |=3D 1ULL << (RISCV_EXCP_U_ECALL);
-        mask |=3D 1ULL << (RISCV_EXCP_S_ECALL);
-        mask |=3D 1ULL << (RISCV_EXCP_H_ECALL);
-        mask |=3D 1ULL << (RISCV_EXCP_M_ECALL);
-        mask |=3D 1ULL << (RISCV_EXCP_INST_PAGE_FAULT);
-        mask |=3D 1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT);
-        mask |=3D 1ULL << (RISCV_EXCP_STORE_PAGE_FAULT);
-        env->medeleg =3D (env->medeleg & ~mask)
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
-        if (env->priv_ver <=3D PRIV_VERSION_1_09_1) {
-            env->scounteren =3D val_to_write;
-            break;
-        } else {
-            goto do_illegal;
-        }
-    case CSR_MSCOUNTEREN:
-        if (env->priv_ver <=3D PRIV_VERSION_1_09_1) {
-            env->mcounteren =3D val_to_write;
-            break;
-        } else {
-            goto do_illegal;
-        }
-    case CSR_SSTATUS: {
-        target_ulong ms =3D env->mstatus;
-        target_ulong mask =3D SSTATUS_SIE | SSTATUS_SPIE | SSTATUS_UIE
-            | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS
-            | SSTATUS_SUM | SSTATUS_SD;
-        if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
-            mask |=3D SSTATUS_MXR;
-        }
-        ms =3D (ms & ~mask) | (val_to_write & mask);
-        csr_write_helper(env, ms, CSR_MSTATUS);
-        break;
-    }
-    case CSR_SIP: {
-        qemu_mutex_lock_iothread();
-        target_ulong next_mip =3D (env->mip & ~env->mideleg)
-                                | (val_to_write & env->mideleg);
-        qemu_mutex_unlock_iothread();
-        csr_write_helper(env, next_mip, CSR_MIP);
-        break;
-    }
-    case CSR_SIE: {
-        target_ulong next_mie =3D (env->mie & ~env->mideleg)
-                                | (val_to_write & env->mideleg);
-        csr_write_helper(env, next_mie, CSR_MIE);
-        break;
-    }
-    case CSR_SATP: /* CSR_SPTBR */ {
-        if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
-            break;
-        }
-        if (env->priv_ver <=3D PRIV_VERSION_1_09_1 && (val_to_write ^ env-=
>sptbr))
-        {
-            helper_tlb_flush(env);
-            env->sptbr =3D val_to_write & (((target_ulong)
-                1 << (TARGET_PHYS_ADDR_SPACE_BITS - PGSHIFT)) - 1);
-        }
-        if (env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
-            validate_vm(env, get_field(val_to_write, SATP_MODE)) &&
-            ((val_to_write ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PP=
N)))
-        {
-            helper_tlb_flush(env);
-            env->satp =3D val_to_write;
-        }
-        break;
-    }
-    case CSR_SEPC:
-        env->sepc =3D val_to_write;
-        break;
-    case CSR_STVEC:
-        /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D re=
served */
-        if ((val_to_write & 3) =3D=3D 0) {
-            env->stvec =3D val_to_write >> 2 << 2;
-        } else {
-            qemu_log_mask(LOG_UNIMP,
-                          "CSR_STVEC: vectored traps not supported\n");
-        }
-        break;
-    case CSR_SCOUNTEREN:
-        if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
-            env->scounteren =3D val_to_write;
-            break;
-        } else {
-            goto do_illegal;
-        }
-    case CSR_SSCRATCH:
-        env->sscratch =3D val_to_write;
-        break;
-    case CSR_SCAUSE:
-        env->scause =3D val_to_write;
-        break;
-    case CSR_SBADADDR:
-        env->sbadaddr =3D val_to_write;
-        break;
-    case CSR_MEPC:
-        env->mepc =3D val_to_write;
-        break;
-    case CSR_MTVEC:
-        /* bits [1:0] indicate mode; 0 =3D direct, 1 =3D vectored, 2 >=3D =
reserved */
-        if ((val_to_write & 3) =3D=3D 0) {
-            env->mtvec =3D val_to_write >> 2 << 2;
-        } else {
-            qemu_log_mask(LOG_UNIMP,
-                          "CSR_MTVEC: vectored traps not supported\n");
-        }
-        break;
-    case CSR_MCOUNTEREN:
-        if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
-            env->mcounteren =3D val_to_write;
-            break;
-        } else {
-            goto do_illegal;
-        }
-    case CSR_MSCRATCH:
-        env->mscratch =3D val_to_write;
-        break;
-    case CSR_MCAUSE:
-        env->mcause =3D val_to_write;
-        break;
-    case CSR_MBADADDR:
-        env->mbadaddr =3D val_to_write;
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
-    target_ulong ctr_en =3D env->priv =3D=3D PRV_U ? env->scounteren :
-                          env->priv =3D=3D PRV_S ? env->mcounteren : -1U;
-#else
-    target_ulong ctr_en =3D -1;
-#endif
-    target_ulong ctr_ok =3D (ctr_en >> (csrno & 31)) & 1;
-
-    if (csrno >=3D CSR_HPMCOUNTER3 && csrno <=3D CSR_HPMCOUNTER31) {
-        if (ctr_ok) {
-            return 0;
-        }
-    }
-#if defined(TARGET_RISCV32)
-    if (csrno >=3D CSR_HPMCOUNTER3H && csrno <=3D CSR_HPMCOUNTER31H) {
-        if (ctr_ok) {
-            return 0;
-        }
-    }
-#endif
-    if (csrno >=3D CSR_MHPMCOUNTER3 && csrno <=3D CSR_MHPMCOUNTER31) {
-        return 0;
-    }
-#if defined(TARGET_RISCV32)
-    if (csrno >=3D CSR_MHPMCOUNTER3 && csrno <=3D CSR_MHPMCOUNTER31) {
-        return 0;
-    }
-#endif
-    if (csrno >=3D CSR_MHPMEVENT3 && csrno <=3D CSR_MHPMEVENT31) {
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
-        if (env->priv_ver <=3D PRIV_VERSION_1_09_1) {
-            return env->scounteren;
-        } else {
-            break; /* illegal instruction */
-        }
-    case CSR_MSCOUNTEREN:
-        if (env->priv_ver <=3D PRIV_VERSION_1_09_1) {
-            return env->mcounteren;
-        } else {
-            break; /* illegal instruction */
-        }
-    case CSR_SSTATUS: {
-        target_ulong mask =3D SSTATUS_SIE | SSTATUS_SPIE | SSTATUS_UIE
-            | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS
-            | SSTATUS_SUM | SSTATUS_SD;
-        if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
-            mask |=3D SSTATUS_MXR;
-        }
-        return env->mstatus & mask;
-    }
-    case CSR_SIP: {
-        qemu_mutex_lock_iothread();
-        target_ulong tmp =3D env->mip & env->mideleg;
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
-        if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
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
-        if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
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
-        target_ulong tmp =3D env->mip;
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
-        if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
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
-    unsigned csr_priv =3D get_field((which), 0x300);
-    unsigned csr_read_only =3D get_field((which), 0xC00) =3D=3D 3;
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
-    uint64_t csr_backup =3D csr_read_helper(env, csr);
-    csr_write_helper(env, src, csr);
-    return csr_backup;
+    target_ulong val =3D 0;
+    if (riscv_csrrw(env, csr, &val, src, -1) < 0) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+    return val;
 }
=20
 target_ulong helper_csrrs(CPURISCVState *env, target_ulong src,
         target_ulong csr, target_ulong rs1_pass)
 {
-    validate_csr(env, csr, rs1_pass !=3D 0, GETPC());
-    uint64_t csr_backup =3D csr_read_helper(env, csr);
-    if (rs1_pass !=3D 0) {
-        csr_write_helper(env, src | csr_backup, csr);
+    target_ulong val =3D 0;
+    if (riscv_csrrw(env, csr, &val, -1, rs1_pass ? src : 0) < 0) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
-    return csr_backup;
+    return val;
 }
=20
 target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
         target_ulong csr, target_ulong rs1_pass)
 {
-    validate_csr(env, csr, rs1_pass !=3D 0, GETPC());
-    uint64_t csr_backup =3D csr_read_helper(env, csr);
-    if (rs1_pass !=3D 0) {
-        csr_write_helper(env, (~src) & csr_backup, csr);
+    target_ulong val =3D 0;
+    if (riscv_csrrw(env, csr, &val, 0, rs1_pass ? src : 0) < 0) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
-    return csr_backup;
+    return val;
 }
=20
 #ifndef CONFIG_USER_ONLY
@@ -674,7 +91,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulon=
g cpu_pc_deb)
     mstatus =3D set_field(mstatus, MSTATUS_SPIE, 0);
     mstatus =3D set_field(mstatus, MSTATUS_SPP, PRV_U);
     riscv_set_mode(env, prev_priv);
-    csr_write_helper(env, mstatus, CSR_MSTATUS);
+    env->mstatus =3D mstatus;
=20
     return retpc;
 }
@@ -699,7 +116,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulo=
ng cpu_pc_deb)
     mstatus =3D set_field(mstatus, MSTATUS_MPIE, 0);
     mstatus =3D set_field(mstatus, MSTATUS_MPP, PRV_U);
     riscv_set_mode(env, prev_priv);
-    csr_write_helper(env, mstatus, CSR_MSTATUS);
+    env->mstatus =3D mstatus;
=20
     return retpc;
 }
--=20
2.19.1
