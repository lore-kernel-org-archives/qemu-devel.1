Received: from eggs.gnu.org ([209.51.188.92]:45635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gi1Ch-0008QI-3n
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gi1Ce-0002eR-Ig
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:06:47 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gi1Ce-0002cg-83
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:06:44 -0500
Received: by mail-pg1-x541.google.com with SMTP id g189so6625734pgc.5
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 10:06:43 -0800 (PST)
Date: Fri, 11 Jan 2019 10:06:29 -0800
Message-Id: <20190111180630.6433-4-palmer@sifive.com>
In-Reply-To: <20190111180630.6433-1-palmer@sifive.com>
References: <20190111180630.6433-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 3/4] RISC-V: Implement existential predicates
 for CSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Michael Clark <mjc@sifive.com>

CSR predicate functions are added to the CSR table.
mstatus.FS and counter enable checks are moved
to predicate functions and two new predicates are
added to check misa.S for s* CSRs and a new PMP
CPU feature for pmp* CSRs.

Processors that don't implement S-mode will trap
on access to s* CSRs and processors that don't
implement PMP will trap on accesses to pmp* CSRs.

PMP checks are disabled in riscv_cpu_handle_mmu_fault
when the PMP CPU feature is not present.

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c        |   6 ++
 target/riscv/cpu.h        |   6 +-
 target/riscv/cpu_helper.c |   3 +-
 target/riscv/csr.c        | 169 +++++++++++++++++++++-----------------
 4 files changed, 105 insertions(+), 79 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5e8a2cb2ba61..28d7e5302fb1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -126,6 +126,7 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
+    set_feature(env, RISCV_FEATURE_PMP);
 }
 
 static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
@@ -135,6 +136,7 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
+    set_feature(env, RISCV_FEATURE_PMP);
 }
 
 static void rv32imacu_nommu_cpu_init(Object *obj)
@@ -143,6 +145,7 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
     set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
+    set_feature(env, RISCV_FEATURE_PMP);
 }
 
 #elif defined(TARGET_RISCV64)
@@ -154,6 +157,7 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
+    set_feature(env, RISCV_FEATURE_PMP);
 }
 
 static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
@@ -163,6 +167,7 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
+    set_feature(env, RISCV_FEATURE_PMP);
 }
 
 static void rv64imacu_nommu_cpu_init(Object *obj)
@@ -171,6 +176,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
     set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
+    set_feature(env, RISCV_FEATURE_PMP);
 }
 
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4aeaa3204903..743f02c8b95a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -83,9 +83,10 @@
 /* S extension denotes that Supervisor mode exists, however it is possible
    to have a core that support S mode but does not have an MMU and there
    is currently no bit in misa to indicate whether an MMU exists or not
-   so a cpu features bitfield is required */
+   so a cpu features bitfield is required, likewise for optional PMP support */
 enum {
-    RISCV_FEATURE_MMU
+    RISCV_FEATURE_MMU,
+    RISCV_FEATURE_PMP
 };
 
 #define USER_VERSION_2_02_0 0x00020200
@@ -314,6 +315,7 @@ typedef int (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
     target_ulong *ret_value, target_ulong new_value, target_ulong write_mask);
 
 typedef struct {
+    riscv_csr_predicate_fn predicate;
     riscv_csr_read_fn read;
     riscv_csr_write_fn write;
     riscv_csr_op_fn op;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 4ef7f5c1f93d..f257050f1282 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -404,7 +404,8 @@ int riscv_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU,
             "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
              " prot %d\n", __func__, address, ret, pa, prot);
-    if (!pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << rw)) {
+    if (riscv_feature(env, RISCV_FEATURE_PMP) &&
+        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << rw)) {
         ret = TRANSLATE_FAIL;
     }
     if (ret == TRANSLATE_SUCCESS) {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 44ea8b7cb6e8..5e7e7d16b8b5 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -42,6 +42,46 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
     csr_ops[csrno & (CSR_TABLE_SIZE - 1)] = *ops;
 }
 
+/* Predicates */
+static int fs(CPURISCVState *env, int csrno)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!(env->mstatus & MSTATUS_FS)) {
+        return -1;
+    }
+#endif
+    return 0;
+}
+
+static int ctr(CPURISCVState *env, int csrno)
+{
+#if !defined(CONFIG_USER_ONLY)
+    target_ulong ctr_en = env->priv == PRV_U ? env->scounteren :
+                          env->priv == PRV_S ? env->mcounteren : -1U;
+    if (!(ctr_en & (1 << (csrno & 31)))) {
+        return -1;
+    }
+#endif
+    return 0;
+}
+
+#if !defined(CONFIG_USER_ONLY)
+static int any(CPURISCVState *env, int csrno)
+{
+    return 0;
+}
+
+static int smode(CPURISCVState *env, int csrno)
+{
+    return -!riscv_has_ext(env, RVS);
+}
+
+static int pmp(CPURISCVState *env, int csrno)
+{
+    return -!riscv_feature(env, RISCV_FEATURE_PMP);
+}
+#endif
+
 /* User Floating-Point CSRs */
 static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -115,33 +155,8 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
 }
 
 /* User Timers and Counters */
-static int counter_enabled(CPURISCVState *env, int csrno)
-{
-#ifndef CONFIG_USER_ONLY
-    target_ulong ctr_en = env->priv == PRV_U ? env->scounteren :
-                          env->priv == PRV_S ? env->mcounteren : -1U;
-#else
-    target_ulong ctr_en = -1;
-#endif
-    return (ctr_en >> (csrno & 31)) & 1;
-}
-
-#if !defined(CONFIG_USER_ONLY)
-static int read_zero_counter(CPURISCVState *env, int csrno, target_ulong *val)
-{
-    if (!counter_enabled(env, csrno)) {
-        return -1;
-    }
-    *val = 0;
-    return 0;
-}
-#endif
-
 static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    if (!counter_enabled(env, csrno)) {
-        return -1;
-    }
 #if !defined(CONFIG_USER_ONLY)
     if (use_icount) {
         *val = cpu_get_icount();
@@ -157,9 +172,6 @@ static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
 #if defined(TARGET_RISCV32)
 static int read_instreth(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    if (!counter_enabled(env, csrno)) {
-        return -1;
-    }
 #if !defined(CONFIG_USER_ONLY)
     if (use_icount) {
         *val = cpu_get_icount() >> 32;
@@ -720,6 +732,11 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
     }
 #endif
 
+    /* check predicate */
+    if (!csr_ops[csrno].predicate || csr_ops[csrno].predicate(env, csrno) < 0) {
+        return -1;
+    }
+
     /* execute combined read/write operation if it exists */
     if (csr_ops[csrno].op) {
         return csr_ops[csrno].op(env, csrno, ret_value, new_value, write_mask);
@@ -758,89 +775,89 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 /* Control and Status Register function table */
 static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* User Floating-Point CSRs */
-    [CSR_FFLAGS] =              { read_fflags,      write_fflags      },
-    [CSR_FRM] =                 { read_frm,         write_frm         },
-    [CSR_FCSR] =                { read_fcsr,        write_fcsr        },
+    [CSR_FFLAGS] =              { fs,   read_fflags,      write_fflags      },
+    [CSR_FRM] =                 { fs,   read_frm,         write_frm         },
+    [CSR_FCSR] =                { fs,   read_fcsr,        write_fcsr        },
 
     /* User Timers and Counters */
-    [CSR_CYCLE] =               { read_instret                        },
-    [CSR_INSTRET] =             { read_instret                        },
+    [CSR_CYCLE] =               { ctr,  read_instret                        },
+    [CSR_INSTRET] =             { ctr,  read_instret                        },
 #if defined(TARGET_RISCV32)
-    [CSR_CYCLEH] =              { read_instreth                       },
-    [CSR_INSTRETH] =            { read_instreth                       },
+    [CSR_CYCLEH] =              { ctr,  read_instreth                       },
+    [CSR_INSTRETH] =            { ctr,  read_instreth                       },
 #endif
 
     /* User-level time CSRs are only available in linux-user
      * In privileged mode, the monitor emulates these CSRs */
 #if defined(CONFIG_USER_ONLY)
-    [CSR_TIME] =                { read_time                           },
+    [CSR_TIME] =                { ctr,  read_time                           },
 #if defined(TARGET_RISCV32)
-    [CSR_TIMEH] =               { read_timeh                          },
+    [CSR_TIMEH] =               { ctr,  read_timeh                          },
 #endif
 #endif
 
 #if !defined(CONFIG_USER_ONLY)
     /* Machine Timers and Counters */
-    [CSR_MCYCLE] =              { read_instret                        },
-    [CSR_MINSTRET] =            { read_instret                        },
+    [CSR_MCYCLE] =              { any,  read_instret                        },
+    [CSR_MINSTRET] =            { any,  read_instret                        },
 #if defined(TARGET_RISCV32)
-    [CSR_MCYCLEH] =             { read_instreth                       },
-    [CSR_MINSTRETH] =           { read_instreth                       },
+    [CSR_MCYCLEH] =             { any,  read_instreth                       },
+    [CSR_MINSTRETH] =           { any,  read_instreth                       },
 #endif
 
     /* Machine Information Registers */
-    [CSR_MVENDORID] =           { read_zero                           },
-    [CSR_MARCHID] =             { read_zero                           },
-    [CSR_MIMPID] =              { read_zero                           },
-    [CSR_MHARTID] =             { read_mhartid                        },
+    [CSR_MVENDORID] =           { any,  read_zero                           },
+    [CSR_MARCHID] =             { any,  read_zero                           },
+    [CSR_MIMPID] =              { any,  read_zero                           },
+    [CSR_MHARTID] =             { any,  read_mhartid                        },
 
     /* Machine Trap Setup */
-    [CSR_MSTATUS] =             { read_mstatus,     write_mstatus     },
-    [CSR_MISA] =                { read_misa                           },
-    [CSR_MIDELEG] =             { read_mideleg,     write_mideleg     },
-    [CSR_MEDELEG] =             { read_medeleg,     write_medeleg     },
-    [CSR_MIE] =                 { read_mie,         write_mie         },
-    [CSR_MTVEC] =               { read_mtvec,       write_mtvec       },
-    [CSR_MCOUNTEREN] =          { read_mcounteren,  write_mcounteren  },
+    [CSR_MSTATUS] =             { any,  read_mstatus,     write_mstatus     },
+    [CSR_MISA] =                { any,  read_misa                           },
+    [CSR_MIDELEG] =             { any,  read_mideleg,     write_mideleg     },
+    [CSR_MEDELEG] =             { any,  read_medeleg,     write_medeleg     },
+    [CSR_MIE] =                 { any,  read_mie,         write_mie         },
+    [CSR_MTVEC] =               { any,  read_mtvec,       write_mtvec       },
+    [CSR_MCOUNTEREN] =          { any,  read_mcounteren,  write_mcounteren  },
 
     /* Legacy Counter Setup (priv v1.9.1) */
-    [CSR_MUCOUNTEREN] =         { read_mucounteren, write_mucounteren },
-    [CSR_MSCOUNTEREN] =         { read_mscounteren, write_mscounteren },
+    [CSR_MUCOUNTEREN] =         { any,  read_mucounteren, write_mucounteren },
+    [CSR_MSCOUNTEREN] =         { any,  read_mscounteren, write_mscounteren },
 
     /* Machine Trap Handling */
-    [CSR_MSCRATCH] =            { read_mscratch,    write_mscratch    },
-    [CSR_MEPC] =                { read_mepc,        write_mepc        },
-    [CSR_MCAUSE] =              { read_mcause,      write_mcause      },
-    [CSR_MBADADDR] =            { read_mbadaddr,    write_mbadaddr    },
-    [CSR_MIP] =                 { NULL,     NULL,     rmw_mip         },
+    [CSR_MSCRATCH] =            { any,  read_mscratch,    write_mscratch    },
+    [CSR_MEPC] =                { any,  read_mepc,        write_mepc        },
+    [CSR_MCAUSE] =              { any,  read_mcause,      write_mcause      },
+    [CSR_MBADADDR] =            { any,  read_mbadaddr,    write_mbadaddr    },
+    [CSR_MIP] =                 { any,  NULL,     NULL,     rmw_mip         },
 
     /* Supervisor Trap Setup */
-    [CSR_SSTATUS] =             { read_sstatus,     write_sstatus     },
-    [CSR_SIE] =                 { read_sie,         write_sie         },
-    [CSR_STVEC] =               { read_stvec,       write_stvec       },
-    [CSR_SCOUNTEREN] =          { read_scounteren,  write_scounteren  },
+    [CSR_SSTATUS] =             { smode, read_sstatus,     write_sstatus     },
+    [CSR_SIE] =                 { smode, read_sie,         write_sie         },
+    [CSR_STVEC] =               { smode, read_stvec,       write_stvec       },
+    [CSR_SCOUNTEREN] =          { smode, read_scounteren,  write_scounteren  },
 
     /* Supervisor Trap Handling */
-    [CSR_SSCRATCH] =            { read_sscratch,    write_sscratch    },
-    [CSR_SEPC] =                { read_sepc,        write_sepc        },
-    [CSR_SCAUSE] =              { read_scause,      write_scause      },
-    [CSR_SBADADDR] =            { read_sbadaddr,    write_sbadaddr    },
-    [CSR_SIP] =                 { NULL,     NULL,     rmw_sip         },
+    [CSR_SSCRATCH] =            { smode, read_sscratch,    write_sscratch    },
+    [CSR_SEPC] =                { smode, read_sepc,        write_sepc        },
+    [CSR_SCAUSE] =              { smode, read_scause,      write_scause      },
+    [CSR_SBADADDR] =            { smode, read_sbadaddr,    write_sbadaddr    },
+    [CSR_SIP] =                 { smode, NULL,     NULL,     rmw_sip         },
 
     /* Supervisor Protection and Translation */
-    [CSR_SATP] =                { read_satp,        write_satp        },
+    [CSR_SATP] =                { smode, read_satp,        write_satp        },
 
     /* Physical Memory Protection */
-    [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { read_pmpcfg,  write_pmpcfg   },
-    [CSR_PMPADDR0 ... CSR_PMPADDR15] = { read_pmpaddr, write_pmpaddr  },
+    [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
+    [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
 
     /* Performance Counters */
-    [CSR_HPMCOUNTER3   ... CSR_HPMCOUNTER31] =    { read_zero_counter },
-    [CSR_MHPMCOUNTER3  ... CSR_MHPMCOUNTER31] =   { read_zero         },
-    [CSR_MHPMEVENT3    ... CSR_MHPMEVENT31] =     { read_zero         },
+    [CSR_HPMCOUNTER3   ... CSR_HPMCOUNTER31] =    { ctr,  read_zero          },
+    [CSR_MHPMCOUNTER3  ... CSR_MHPMCOUNTER31] =   { any,  read_zero          },
+    [CSR_MHPMEVENT3    ... CSR_MHPMEVENT31] =     { any,  read_zero          },
 #if defined(TARGET_RISCV32)
-    [CSR_HPMCOUNTER3H  ... CSR_HPMCOUNTER31H] =   { read_zero_counter },
-    [CSR_MHPMCOUNTER3H ... CSR_MHPMCOUNTER31H] =  { read_zero         },
+    [CSR_HPMCOUNTER3H  ... CSR_HPMCOUNTER31H] =   { ctr,  read_zero          },
+    [CSR_MHPMCOUNTER3H ... CSR_MHPMCOUNTER31H] =  { any,  read_zero          },
 #endif
 #endif /* !CONFIG_USER_ONLY */
 };
-- 
2.18.1
