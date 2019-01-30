Received: from eggs.gnu.org ([209.51.188.92]:38523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotn7-0004hS-Jz
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotn3-00006q-Sm
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:49 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gotn3-0008Rf-Ia
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:45 -0500
Received: by mail-pg1-x541.google.com with SMTP id j10so133850pga.1
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 09:36:24 -0800 (PST)
Date: Wed, 30 Jan 2019 09:35:55 -0800
Message-Id: <20190130173601.3268-5-palmer@sifive.com>
In-Reply-To: <20190130173601.3268-1-palmer@sifive.com>
References: <20190130173601.3268-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 04/10] RISC-V: Use riscv prefix consistently on
 cpu helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Michael Clark <mjc@sifive.com>

* Add riscv prefix to raise_exception function
* Add riscv prefix to CSR read/write functions
* Add riscv prefix to signal handler function
* Add riscv prefix to get fflags function
* Remove redundant declaration of riscv_cpu_init
  and rename cpu_riscv_init to riscv_cpu_init
* rename riscv_set_mode to riscv_cpu_set_mode

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 linux-user/riscv/signal.c |  4 ++--
 target/riscv/cpu.h        | 21 ++++++++++-----------
 target/riscv/cpu_helper.c | 10 +++++-----
 target/riscv/csr.c        |  8 ++++----
 target/riscv/fpu_helper.c |  6 +++---
 target/riscv/op_helper.c  | 28 ++++++++++++++--------------
 6 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index f598d41891c1..83ecc6f799a1 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -83,7 +83,7 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
         __put_user(env->fpr[i], &sc->fpr[i]);
     }
 
-    uint32_t fcsr = csr_read_helper(env, CSR_FCSR); /*riscv_get_fcsr(env);*/
+    uint32_t fcsr = riscv_csr_read(env, CSR_FCSR);
     __put_user(fcsr, &sc->fcsr);
 }
 
@@ -159,7 +159,7 @@ static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
 
     uint32_t fcsr;
     __get_user(fcsr, &sc->fcsr);
-    csr_write_helper(env, fcsr, CSR_FCSR);
+    riscv_csr_write(env, CSR_FCSR, fcsr);
 }
 
 static void restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 681341f5d5a4..a97435bd7b1d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -256,7 +256,7 @@ int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
-#define cpu_signal_handler cpu_riscv_signal_handler
+#define cpu_signal_handler riscv_cpu_signal_handler
 #define cpu_list riscv_cpu_list
 #define cpu_mmu_index riscv_cpu_mmu_index
 
@@ -264,16 +264,15 @@ void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 #endif
-void riscv_set_mode(CPURISCVState *env, target_ulong newpriv);
+void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
 
 void riscv_translate_init(void);
-RISCVCPU *cpu_riscv_init(const char *cpu_model);
-int cpu_riscv_signal_handler(int host_signum, void *pinfo, void *puc);
-void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
-                                          uint32_t exception, uintptr_t pc);
+int riscv_cpu_signal_handler(int host_signum, void *pinfo, void *puc);
+void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
+                                         uint32_t exception, uintptr_t pc);
 
-target_ulong cpu_riscv_get_fflags(CPURISCVState *env);
-void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong);
+target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
+void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
 
 #define TB_FLAGS_MMU_MASK   3
 #define TB_FLAGS_MSTATUS_FS MSTATUS_FS
@@ -293,13 +292,13 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
                 target_ulong new_value, target_ulong write_mask);
 
-static inline void csr_write_helper(CPURISCVState *env, target_ulong val,
-                                    int csrno)
+static inline void riscv_csr_write(CPURISCVState *env, int csrno,
+                                   target_ulong val)
 {
     riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
 }
 
-static inline target_ulong csr_read_helper(CPURISCVState *env, int csrno)
+static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
 {
     target_ulong val = 0;
     riscv_csrrw(env, csrno, &val, 0, 0);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f257050f1282..f49e98ed594b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -93,7 +93,7 @@ uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
     return old;
 }
 
-void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
+void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
 {
     if (newpriv > PRV_M) {
         g_assert_not_reached();
@@ -366,7 +366,7 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
         g_assert_not_reached();
     }
     env->badaddr = addr;
-    do_raise_exception_err(env, cs->exception_index, retaddr);
+    riscv_raise_exception(env, cs->exception_index, retaddr);
 }
 
 /* called by qemu's softmmu to fill the qemu tlb */
@@ -378,7 +378,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
     if (ret == TRANSLATE_FAIL) {
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
-        do_raise_exception_err(env, cs->exception_index, retaddr);
+        riscv_raise_exception(env, cs->exception_index, retaddr);
     }
 }
 
@@ -530,7 +530,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_SPP, env->priv);
         s = set_field(s, MSTATUS_SIE, 0);
         env->mstatus = s;
-        riscv_set_mode(env, PRV_S);
+        riscv_cpu_set_mode(env, PRV_S);
     } else {
         /* No need to check MTVEC for misaligned - lower 2 bits cannot be set */
         env->pc = env->mtvec;
@@ -555,7 +555,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_MPP, env->priv);
         s = set_field(s, MSTATUS_MIE, 0);
         env->mstatus = s;
-        riscv_set_mode(env, PRV_M);
+        riscv_cpu_set_mode(env, PRV_M);
     }
     /* TODO yield load reservation  */
 #endif
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 390d3a9a5634..e2bd374f09ed 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -90,7 +90,7 @@ static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
         return -1;
     }
 #endif
-    *val = cpu_riscv_get_fflags(env);
+    *val = riscv_cpu_get_fflags(env);
     return 0;
 }
 
@@ -102,7 +102,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
     }
     env->mstatus |= MSTATUS_FS;
 #endif
-    cpu_riscv_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
+    riscv_cpu_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
     return 0;
 }
 
@@ -136,7 +136,7 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
         return -1;
     }
 #endif
-    *val = (cpu_riscv_get_fflags(env) << FSR_AEXC_SHIFT)
+    *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
         | (env->frm << FSR_RD_SHIFT);
     return 0;
 }
@@ -150,7 +150,7 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
     env->mstatus |= MSTATUS_FS;
 #endif
     env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
-    cpu_riscv_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
+    riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
     return 0;
 }
 
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 01b45ca0aed1..b4f818a64657 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -22,7 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 
-target_ulong cpu_riscv_get_fflags(CPURISCVState *env)
+target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
 {
     int soft = get_float_exception_flags(&env->fp_status);
     target_ulong hard = 0;
@@ -36,7 +36,7 @@ target_ulong cpu_riscv_get_fflags(CPURISCVState *env)
     return hard;
 }
 
-void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong hard)
+void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
 {
     int soft = 0;
 
@@ -73,7 +73,7 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
         softrm = float_round_ties_away;
         break;
     default:
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
     set_float_rounding_mode(softrm, &env->fp_status);
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 77c79ba36e0b..b7dc18a41e21 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -25,7 +25,7 @@
 #include "exec/helper-proto.h"
 
 /* Exceptions processing helpers */
-void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
+void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
                                           uint32_t exception, uintptr_t pc)
 {
     CPUState *cs = CPU(riscv_env_get_cpu(env));
@@ -36,7 +36,7 @@ void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
 
 void helper_raise_exception(CPURISCVState *env, uint32_t exception)
 {
-    do_raise_exception_err(env, exception, 0);
+    riscv_raise_exception(env, exception, 0);
 }
 
 target_ulong helper_csrrw(CPURISCVState *env, target_ulong src,
@@ -44,7 +44,7 @@ target_ulong helper_csrrw(CPURISCVState *env, target_ulong src,
 {
     target_ulong val = 0;
     if (riscv_csrrw(env, csr, &val, src, -1) < 0) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
     return val;
 }
@@ -54,7 +54,7 @@ target_ulong helper_csrrs(CPURISCVState *env, target_ulong src,
 {
     target_ulong val = 0;
     if (riscv_csrrw(env, csr, &val, -1, rs1_pass ? src : 0) < 0) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
     return val;
 }
@@ -64,7 +64,7 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
 {
     target_ulong val = 0;
     if (riscv_csrrw(env, csr, &val, 0, rs1_pass ? src : 0) < 0) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
     return val;
 }
@@ -74,17 +74,17 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
 target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
 {
     if (!(env->priv >= PRV_S)) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
     target_ulong retpc = env->sepc;
     if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
-        do_raise_exception_err(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
         get_field(env->mstatus, MSTATUS_TSR)) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
     target_ulong mstatus = env->mstatus;
@@ -95,7 +95,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
         get_field(mstatus, MSTATUS_SPIE));
     mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
     mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
-    riscv_set_mode(env, prev_priv);
+    riscv_cpu_set_mode(env, prev_priv);
     env->mstatus = mstatus;
 
     return retpc;
@@ -104,12 +104,12 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
 target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
 {
     if (!(env->priv >= PRV_M)) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
     target_ulong retpc = env->mepc;
     if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
-        do_raise_exception_err(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
     target_ulong mstatus = env->mstatus;
@@ -120,7 +120,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
         get_field(mstatus, MSTATUS_MPIE));
     mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
     mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
-    riscv_set_mode(env, prev_priv);
+    riscv_cpu_set_mode(env, prev_priv);
     env->mstatus = mstatus;
 
     return retpc;
@@ -133,7 +133,7 @@ void helper_wfi(CPURISCVState *env)
     if (env->priv == PRV_S &&
         env->priv_ver >= PRIV_VERSION_1_10_0 &&
         get_field(env->mstatus, MSTATUS_TW)) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
@@ -148,7 +148,7 @@ void helper_tlb_flush(CPURISCVState *env)
     if (env->priv == PRV_S &&
         env->priv_ver >= PRIV_VERSION_1_10_0 &&
         get_field(env->mstatus, MSTATUS_TVM)) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         tlb_flush(cs);
     }
-- 
2.18.1
