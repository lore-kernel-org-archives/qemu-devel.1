Received: from eggs.gnu.org ([209.51.188.92]:51390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC85-00041D-8R
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC83-0000zQ-D9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:58:53 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 14 Jan 2019 23:58:23 +0000
Message-ID: <20ba320ced470eed0f16b39e01b1bf8c24dbd3c4.1547510220.git.alistair.francis@wdc.com>
References: <cover.1547510220.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1547510220.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 4/8] RISC-V: Use riscv prefix consistently
 on cpu helpers
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

* Add riscv prefix to raise_exception function
* Add riscv prefix to CSR read/write functions
* Add riscv prefix to signal handler function
* Add riscv prefix to get fflags function
* Remove redundant declaration of riscv_cpu_init
  and rename cpu_riscv_init to riscv_cpu_init
* rename riscv_set_mode to riscv_cpu_set_mode

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/riscv/signal.c |  4 ++--
 target/riscv/cpu.h        | 21 ++++++++++-----------
 target/riscv/cpu_helper.c | 10 +++++-----
 target/riscv/csr.c        |  8 ++++----
 target/riscv/fpu_helper.c |  6 +++---
 target/riscv/op_helper.c  | 28 ++++++++++++++--------------
 6 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index f598d41891..83ecc6f799 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -83,7 +83,7 @@ static void setup_sigcontext(struct target_sigcontext *sc=
, CPURISCVState *env)
         __put_user(env->fpr[i], &sc->fpr[i]);
     }
=20
-    uint32_t fcsr =3D csr_read_helper(env, CSR_FCSR); /*riscv_get_fcsr(env=
);*/
+    uint32_t fcsr =3D riscv_csr_read(env, CSR_FCSR);
     __put_user(fcsr, &sc->fcsr);
 }
=20
@@ -159,7 +159,7 @@ static void restore_sigcontext(CPURISCVState *env, stru=
ct target_sigcontext *sc)
=20
     uint32_t fcsr;
     __get_user(fcsr, &sc->fcsr);
-    csr_write_helper(env, fcsr, CSR_FCSR);
+    riscv_csr_write(env, CSR_FCSR, fcsr);
 }
=20
 static void restore_ucontext(CPURISCVState *env, struct target_ucontext *u=
c)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 681341f5d5..a97435bd7b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -256,7 +256,7 @@ int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr add=
ress, int size,
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
=20
-#define cpu_signal_handler cpu_riscv_signal_handler
+#define cpu_signal_handler riscv_cpu_signal_handler
 #define cpu_list riscv_cpu_list
 #define cpu_mmu_index riscv_cpu_mmu_index
=20
@@ -264,16 +264,15 @@ void riscv_cpu_list(FILE *f, fprintf_function cpu_fpr=
intf);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value=
);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value =
*/
 #endif
-void riscv_set_mode(CPURISCVState *env, target_ulong newpriv);
+void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
=20
 void riscv_translate_init(void);
-RISCVCPU *cpu_riscv_init(const char *cpu_model);
-int cpu_riscv_signal_handler(int host_signum, void *pinfo, void *puc);
-void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
-                                          uint32_t exception, uintptr_t pc=
);
+int riscv_cpu_signal_handler(int host_signum, void *pinfo, void *puc);
+void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
+                                         uint32_t exception, uintptr_t pc)=
;
=20
-target_ulong cpu_riscv_get_fflags(CPURISCVState *env);
-void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong);
+target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
+void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
=20
 #define TB_FLAGS_MMU_MASK   3
 #define TB_FLAGS_MSTATUS_FS MSTATUS_FS
@@ -293,13 +292,13 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState=
 *env, target_ulong *pc,
 int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
                 target_ulong new_value, target_ulong write_mask);
=20
-static inline void csr_write_helper(CPURISCVState *env, target_ulong val,
-                                    int csrno)
+static inline void riscv_csr_write(CPURISCVState *env, int csrno,
+                                   target_ulong val)
 {
     riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS=
));
 }
=20
-static inline target_ulong csr_read_helper(CPURISCVState *env, int csrno)
+static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
 {
     target_ulong val =3D 0;
     riscv_csrrw(env, csrno, &val, 0, 0);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f257050f12..f49e98ed59 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -93,7 +93,7 @@ uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mas=
k, uint32_t value)
     return old;
 }
=20
-void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
+void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
 {
     if (newpriv > PRV_M) {
         g_assert_not_reached();
@@ -366,7 +366,7 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr =
addr,
         g_assert_not_reached();
     }
     env->badaddr =3D addr;
-    do_raise_exception_err(env, cs->exception_index, retaddr);
+    riscv_raise_exception(env, cs->exception_index, retaddr);
 }
=20
 /* called by qemu's softmmu to fill the qemu tlb */
@@ -378,7 +378,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size=
,
     if (ret =3D=3D TRANSLATE_FAIL) {
         RISCVCPU *cpu =3D RISCV_CPU(cs);
         CPURISCVState *env =3D &cpu->env;
-        do_raise_exception_err(env, cs->exception_index, retaddr);
+        riscv_raise_exception(env, cs->exception_index, retaddr);
     }
 }
=20
@@ -530,7 +530,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s =3D set_field(s, MSTATUS_SPP, env->priv);
         s =3D set_field(s, MSTATUS_SIE, 0);
         env->mstatus =3D s;
-        riscv_set_mode(env, PRV_S);
+        riscv_cpu_set_mode(env, PRV_S);
     } else {
         /* No need to check MTVEC for misaligned - lower 2 bits cannot be =
set */
         env->pc =3D env->mtvec;
@@ -555,7 +555,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s =3D set_field(s, MSTATUS_MPP, env->priv);
         s =3D set_field(s, MSTATUS_MIE, 0);
         env->mstatus =3D s;
-        riscv_set_mode(env, PRV_M);
+        riscv_cpu_set_mode(env, PRV_M);
     }
     /* TODO yield load reservation  */
 #endif
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 390d3a9a56..e2bd374f09 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -90,7 +90,7 @@ static int read_fflags(CPURISCVState *env, int csrno, tar=
get_ulong *val)
         return -1;
     }
 #endif
-    *val =3D cpu_riscv_get_fflags(env);
+    *val =3D riscv_cpu_get_fflags(env);
     return 0;
 }
=20
@@ -102,7 +102,7 @@ static int write_fflags(CPURISCVState *env, int csrno, =
target_ulong val)
     }
     env->mstatus |=3D MSTATUS_FS;
 #endif
-    cpu_riscv_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
+    riscv_cpu_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
     return 0;
 }
=20
@@ -136,7 +136,7 @@ static int read_fcsr(CPURISCVState *env, int csrno, tar=
get_ulong *val)
         return -1;
     }
 #endif
-    *val =3D (cpu_riscv_get_fflags(env) << FSR_AEXC_SHIFT)
+    *val =3D (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
         | (env->frm << FSR_RD_SHIFT);
     return 0;
 }
@@ -150,7 +150,7 @@ static int write_fcsr(CPURISCVState *env, int csrno, ta=
rget_ulong val)
     env->mstatus |=3D MSTATUS_FS;
 #endif
     env->frm =3D (val & FSR_RD) >> FSR_RD_SHIFT;
-    cpu_riscv_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
+    riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
     return 0;
 }
=20
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 01b45ca0ae..b4f818a646 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -22,7 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
=20
-target_ulong cpu_riscv_get_fflags(CPURISCVState *env)
+target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
 {
     int soft =3D get_float_exception_flags(&env->fp_status);
     target_ulong hard =3D 0;
@@ -36,7 +36,7 @@ target_ulong cpu_riscv_get_fflags(CPURISCVState *env)
     return hard;
 }
=20
-void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong hard)
+void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
 {
     int soft =3D 0;
=20
@@ -73,7 +73,7 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_=
t rm)
         softrm =3D float_round_ties_away;
         break;
     default:
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
=20
     set_float_rounding_mode(softrm, &env->fp_status);
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 77c79ba36e..b7dc18a41e 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -25,7 +25,7 @@
 #include "exec/helper-proto.h"
=20
 /* Exceptions processing helpers */
-void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
+void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
                                           uint32_t exception, uintptr_t pc=
)
 {
     CPUState *cs =3D CPU(riscv_env_get_cpu(env));
@@ -36,7 +36,7 @@ void QEMU_NORETURN do_raise_exception_err(CPURISCVState *=
env,
=20
 void helper_raise_exception(CPURISCVState *env, uint32_t exception)
 {
-    do_raise_exception_err(env, exception, 0);
+    riscv_raise_exception(env, exception, 0);
 }
=20
 target_ulong helper_csrrw(CPURISCVState *env, target_ulong src,
@@ -44,7 +44,7 @@ target_ulong helper_csrrw(CPURISCVState *env, target_ulon=
g src,
 {
     target_ulong val =3D 0;
     if (riscv_csrrw(env, csr, &val, src, -1) < 0) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
     return val;
 }
@@ -54,7 +54,7 @@ target_ulong helper_csrrs(CPURISCVState *env, target_ulon=
g src,
 {
     target_ulong val =3D 0;
     if (riscv_csrrw(env, csr, &val, -1, rs1_pass ? src : 0) < 0) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
     return val;
 }
@@ -64,7 +64,7 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulon=
g src,
 {
     target_ulong val =3D 0;
     if (riscv_csrrw(env, csr, &val, 0, rs1_pass ? src : 0) < 0) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
     return val;
 }
@@ -74,17 +74,17 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ul=
ong src,
 target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
 {
     if (!(env->priv >=3D PRV_S)) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
=20
     target_ulong retpc =3D env->sepc;
     if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
-        do_raise_exception_err(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
=20
     if (env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
         get_field(env->mstatus, MSTATUS_TSR)) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
=20
     target_ulong mstatus =3D env->mstatus;
@@ -95,7 +95,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong=
 cpu_pc_deb)
         get_field(mstatus, MSTATUS_SPIE));
     mstatus =3D set_field(mstatus, MSTATUS_SPIE, 0);
     mstatus =3D set_field(mstatus, MSTATUS_SPP, PRV_U);
-    riscv_set_mode(env, prev_priv);
+    riscv_cpu_set_mode(env, prev_priv);
     env->mstatus =3D mstatus;
=20
     return retpc;
@@ -104,12 +104,12 @@ target_ulong helper_sret(CPURISCVState *env, target_u=
long cpu_pc_deb)
 target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
 {
     if (!(env->priv >=3D PRV_M)) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
=20
     target_ulong retpc =3D env->mepc;
     if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
-        do_raise_exception_err(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
=20
     target_ulong mstatus =3D env->mstatus;
@@ -120,7 +120,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulo=
ng cpu_pc_deb)
         get_field(mstatus, MSTATUS_MPIE));
     mstatus =3D set_field(mstatus, MSTATUS_MPIE, 0);
     mstatus =3D set_field(mstatus, MSTATUS_MPP, PRV_U);
-    riscv_set_mode(env, prev_priv);
+    riscv_cpu_set_mode(env, prev_priv);
     env->mstatus =3D mstatus;
=20
     return retpc;
@@ -133,7 +133,7 @@ void helper_wfi(CPURISCVState *env)
     if (env->priv =3D=3D PRV_S &&
         env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
         get_field(env->mstatus, MSTATUS_TW)) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         cs->halted =3D 1;
         cs->exception_index =3D EXCP_HLT;
@@ -148,7 +148,7 @@ void helper_tlb_flush(CPURISCVState *env)
     if (env->priv =3D=3D PRV_S &&
         env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
         get_field(env->mstatus, MSTATUS_TVM)) {
-        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         tlb_flush(cs);
     }
--=20
2.19.1
