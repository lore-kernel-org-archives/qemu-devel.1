Received: from eggs.gnu.org ([209.51.188.92]:49772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsH0p-0005vB-IJ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 20:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsH0n-0007ju-Et
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 20:00:55 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 9 Feb 2019 01:00:42 +0000
Message-ID: <06a867e9a21d725d0974d66e213a8eb58b0914f4.1549673900.git.alistair.francis@wdc.com>
References: <cover.1549673900.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1549673900.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 09/11] RISC-V: Add support for vectored
 interrupts
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

If vectored interrupts are enabled (bits[1:0]
of mtvec/stvec =3D=3D 1) then use the following
logic for trap entry address calculation:

 pc =3D mtvec + cause * 4

In addition to adding support for vectored interrupts
this patch simplifies the interrupt delivery logic
by making sync/async cause decoding and encoding
steps distinct.

The cause code and the sign bit indicating sync/async
is split at the beginning of the function and fixed
cause is renamed to cause. The MSB setting for async
traps is delayed until setting mcause/scause to allow
redundant variables to be eliminated. Some variables
are renamed for conciseness and moved so that decls
are at the start of the block.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 145 ++++++++++++++------------------------
 target/riscv/csr.c        |  12 ++--
 2 files changed, 60 insertions(+), 97 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 073bdcfe74..a02f4dad8c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -454,118 +454,81 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     RISCVCPU *cpu =3D RISCV_CPU(cs);
     CPURISCVState *env =3D &cpu->env;
=20
-    if (RISCV_DEBUG_INTERRUPT) {
-        int log_cause =3D cs->exception_index & RISCV_EXCP_INT_MASK;
-        if (cs->exception_index & RISCV_EXCP_INT_FLAG) {
-            qemu_log_mask(LOG_TRACE, "core "
-                TARGET_FMT_ld ": trap %s, epc 0x" TARGET_FMT_lx "\n",
-                env->mhartid, riscv_intr_names[log_cause], env->pc);
-        } else {
-            qemu_log_mask(LOG_TRACE, "core "
-                TARGET_FMT_ld ": intr %s, epc 0x" TARGET_FMT_lx "\n",
-                env->mhartid, riscv_excp_names[log_cause], env->pc);
+    /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
+     * so we mask off the MSB and separate into trap type and cause.
+     */
+    bool async =3D !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
+    target_ulong cause =3D cs->exception_index & RISCV_EXCP_INT_MASK;
+    target_ulong deleg =3D async ? env->mideleg : env->medeleg;
+    target_ulong tval =3D 0;
+
+    static const int ecall_cause_map[] =3D {
+        [PRV_U] =3D RISCV_EXCP_U_ECALL,
+        [PRV_S] =3D RISCV_EXCP_S_ECALL,
+        [PRV_H] =3D RISCV_EXCP_H_ECALL,
+        [PRV_M] =3D RISCV_EXCP_M_ECALL
+    };
+
+    if (!async) {
+        /* set tval to badaddr for traps with address information */
+        switch (cause) {
+        case RISCV_EXCP_INST_ADDR_MIS:
+        case RISCV_EXCP_INST_ACCESS_FAULT:
+        case RISCV_EXCP_LOAD_ADDR_MIS:
+        case RISCV_EXCP_STORE_AMO_ADDR_MIS:
+        case RISCV_EXCP_LOAD_ACCESS_FAULT:
+        case RISCV_EXCP_STORE_AMO_ACCESS_FAULT:
+        case RISCV_EXCP_INST_PAGE_FAULT:
+        case RISCV_EXCP_LOAD_PAGE_FAULT:
+        case RISCV_EXCP_STORE_PAGE_FAULT:
+            tval =3D env->badaddr;
+            break;
+        default:
+            break;
         }
-    }
-
-    target_ulong fixed_cause =3D 0;
-    if (cs->exception_index & (RISCV_EXCP_INT_FLAG)) {
-        /* hacky for now. the MSB (bit 63) indicates interrupt but cs->exc=
eption
-           index is only 32 bits wide */
-        fixed_cause =3D cs->exception_index & RISCV_EXCP_INT_MASK;
-        fixed_cause |=3D ((target_ulong)1) << (TARGET_LONG_BITS - 1);
-    } else {
-        /* fixup User ECALL -> correct priv ECALL */
-        if (cs->exception_index =3D=3D RISCV_EXCP_U_ECALL) {
-            switch (env->priv) {
-            case PRV_U:
-                fixed_cause =3D RISCV_EXCP_U_ECALL;
-                break;
-            case PRV_S:
-                fixed_cause =3D RISCV_EXCP_S_ECALL;
-                break;
-            case PRV_H:
-                fixed_cause =3D RISCV_EXCP_H_ECALL;
-                break;
-            case PRV_M:
-                fixed_cause =3D RISCV_EXCP_M_ECALL;
-                break;
-            }
-        } else {
-            fixed_cause =3D cs->exception_index;
+        /* ecall is dispatched as one cause so translate based on mode */
+        if (cause =3D=3D RISCV_EXCP_U_ECALL) {
+            assert(env->priv <=3D 3);
+            cause =3D ecall_cause_map[env->priv];
         }
     }
=20
-    target_ulong backup_epc =3D env->pc;
-
-    target_ulong bit =3D fixed_cause;
-    target_ulong deleg =3D env->medeleg;
-
-    int hasbadaddr =3D
-        (fixed_cause =3D=3D RISCV_EXCP_INST_ADDR_MIS) ||
-        (fixed_cause =3D=3D RISCV_EXCP_INST_ACCESS_FAULT) ||
-        (fixed_cause =3D=3D RISCV_EXCP_LOAD_ADDR_MIS) ||
-        (fixed_cause =3D=3D RISCV_EXCP_STORE_AMO_ADDR_MIS) ||
-        (fixed_cause =3D=3D RISCV_EXCP_LOAD_ACCESS_FAULT) ||
-        (fixed_cause =3D=3D RISCV_EXCP_STORE_AMO_ACCESS_FAULT) ||
-        (fixed_cause =3D=3D RISCV_EXCP_INST_PAGE_FAULT) ||
-        (fixed_cause =3D=3D RISCV_EXCP_LOAD_PAGE_FAULT) ||
-        (fixed_cause =3D=3D RISCV_EXCP_STORE_PAGE_FAULT);
-
-    if (bit & ((target_ulong)1 << (TARGET_LONG_BITS - 1))) {
-        deleg =3D env->mideleg;
-        bit &=3D ~((target_ulong)1 << (TARGET_LONG_BITS - 1));
+    if (RISCV_DEBUG_INTERRUPT) {
+        qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ": %s %s, "
+            "epc 0x" TARGET_FMT_lx ": tval 0x" TARGET_FMT_lx "\n",
+            env->mhartid, async ? "intr" : "trap",
+            (async ? riscv_intr_names : riscv_excp_names)[cause],
+            env->pc, tval);
     }
=20
-    if (env->priv <=3D PRV_S && bit < 64 && ((deleg >> bit) & 1)) {
+    if (env->priv <=3D PRV_S &&
+            cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
         /* handle the trap in S-mode */
-        /* No need to check STVEC for misaligned - lower 2 bits cannot be =
set */
-        env->pc =3D env->stvec;
-        env->scause =3D fixed_cause;
-        env->sepc =3D backup_epc;
-
-        if (hasbadaddr) {
-            if (RISCV_DEBUG_INTERRUPT) {
-                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ": badaddr =
0x"
-                    TARGET_FMT_lx "\n", env->mhartid, env->badaddr);
-            }
-            env->sbadaddr =3D env->badaddr;
-        } else {
-            /* otherwise we must clear sbadaddr/stval
-             * todo: support populating stval on illegal instructions */
-            env->sbadaddr =3D 0;
-        }
-
         target_ulong s =3D env->mstatus;
         s =3D set_field(s, MSTATUS_SPIE, env->priv_ver >=3D PRIV_VERSION_1=
_10_0 ?
             get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->p=
riv));
         s =3D set_field(s, MSTATUS_SPP, env->priv);
         s =3D set_field(s, MSTATUS_SIE, 0);
         env->mstatus =3D s;
+        env->scause =3D cause | ~(((target_ulong)-1) >> async);
+        env->sepc =3D env->pc;
+        env->sbadaddr =3D tval;
+        env->pc =3D (env->stvec >> 2 << 2) +
+            ((async && (env->stvec & 3) =3D=3D 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_S);
     } else {
-        /* No need to check MTVEC for misaligned - lower 2 bits cannot be =
set */
-        env->pc =3D env->mtvec;
-        env->mepc =3D backup_epc;
-        env->mcause =3D fixed_cause;
-
-        if (hasbadaddr) {
-            if (RISCV_DEBUG_INTERRUPT) {
-                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ": badaddr =
0x"
-                    TARGET_FMT_lx "\n", env->mhartid, env->badaddr);
-            }
-            env->mbadaddr =3D env->badaddr;
-        } else {
-            /* otherwise we must clear mbadaddr/mtval
-             * todo: support populating mtval on illegal instructions */
-            env->mbadaddr =3D 0;
-        }
-
+        /* handle the trap in M-mode */
         target_ulong s =3D env->mstatus;
         s =3D set_field(s, MSTATUS_MPIE, env->priv_ver >=3D PRIV_VERSION_1=
_10_0 ?
             get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->p=
riv));
         s =3D set_field(s, MSTATUS_MPP, env->priv);
         s =3D set_field(s, MSTATUS_MIE, 0);
         env->mstatus =3D s;
+        env->mcause =3D cause | ~(((target_ulong)-1) >> async);
+        env->mepc =3D env->pc;
+        env->mbadaddr =3D tval;
+        env->pc =3D (env->mtvec >> 2 << 2) +
+            ((async && (env->mtvec & 3) =3D=3D 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_M);
     }
     /* TODO yield load reservation  */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 938c10897c..8039eb6e48 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -435,10 +435,10 @@ static int read_mtvec(CPURISCVState *env, int csrno, =
target_ulong *val)
 static int write_mtvec(CPURISCVState *env, int csrno, target_ulong val)
 {
     /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D reserv=
ed */
-    if ((val & 3) =3D=3D 0) {
-        env->mtvec =3D val >> 2 << 2;
+    if ((val & 3) < 2) {
+        env->mtvec =3D val;
     } else {
-        qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: vectored traps not supported"=
);
+        qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: reserved mode not supported\n=
");
     }
     return 0;
 }
@@ -607,10 +607,10 @@ static int read_stvec(CPURISCVState *env, int csrno, =
target_ulong *val)
 static int write_stvec(CPURISCVState *env, int csrno, target_ulong val)
 {
     /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D reserv=
ed */
-    if ((val & 3) =3D=3D 0) {
-        env->stvec =3D val >> 2 << 2;
+    if ((val & 3) < 2) {
+        env->stvec =3D val;
     } else {
-        qemu_log_mask(LOG_UNIMP, "CSR_STVEC: vectored traps not supported"=
);
+        qemu_log_mask(LOG_UNIMP, "CSR_STVEC: reserved mode not supported\n=
");
     }
     return 0;
 }
--=20
2.20.1
