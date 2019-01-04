Received: from eggsout.gnu.org ([209.51.188.92]:39319 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=90010c98c=Alistair.Francis@wdc.com>)
	id 1gfYp4-000291-5M
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=90010c98c=Alistair.Francis@wdc.com>)
	id 1gfYox-0003wr-R2
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:24:11 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Fri, 4 Jan 2019 23:24:04 +0000
Message-ID: <8c5a410e1ce4a5898e77ef49e66da289518a5298.1546644177.git.alistair.francis@wdc.com>
References: <cover.1546644177.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1546644177.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 2/3] RISC-V: Implement atomic mip/sip CSR
 updates
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

Use the new CSR read/modify/write interface to implement
atomic updates to mip/sip.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 56 +++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b61b0ef379..44ea8b7cb6 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -487,25 +487,31 @@ static int write_mbadaddr(CPURISCVState *env, int csr=
no, target_ulong val)
     return 0;
 }
=20
-static int read_mip(CPURISCVState *env, int csrno, target_ulong *val)
-{
-    *val =3D atomic_read(&env->mip);
-    return 0;
-}
-
-static int write_mip(CPURISCVState *env, int csrno, target_ulong val)
+static int rmw_mip(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                   target_ulong new_value, target_ulong write_mask)
 {
     RISCVCPU *cpu =3D riscv_env_get_cpu(env);
+    target_ulong mask =3D write_mask & delegable_ints;
+    uint32_t old_mip;
+
+    /* We can't allow the supervisor to control SEIP as this would allow t=
he
+     * supervisor to clear a pending external interrupt which will result =
in
+     * lost a interrupt in the case a PLIC is attached. The SEIP bit must =
be
+     * hardware controlled when a PLIC is attached. This should be an opti=
on
+     * for CPUs with software-delegated Supervisor External Interrupts. */
+    mask &=3D ~MIP_SEIP;
+
+    if (mask) {
+        qemu_mutex_lock_iothread();
+        old_mip =3D riscv_cpu_update_mip(cpu, mask, (new_value & mask));
+        qemu_mutex_unlock_iothread();
+    } else {
+        old_mip =3D atomic_read(&env->mip);
+    }
=20
-    /*
-     * csrs, csrc on mip.SEIP is not decomposable into separate read and
-     * write steps, so a different implementation is needed
-     */
-
-    qemu_mutex_lock_iothread();
-    riscv_cpu_update_mip(cpu, MIP_SSIP | MIP_STIP,
-                         (val & (MIP_SSIP | MIP_STIP)));
-    qemu_mutex_unlock_iothread();
+    if (ret_value) {
+        *ret_value =3D old_mip;
+    }
=20
     return 0;
 }
@@ -623,17 +629,11 @@ static int write_sbadaddr(CPURISCVState *env, int csr=
no, target_ulong val)
     return 0;
 }
=20
-static int read_sip(CPURISCVState *env, int csrno, target_ulong *val)
-{
-    *val =3D atomic_read(&env->mip) & env->mideleg;
-    return 0;
-}
-
-static int write_sip(CPURISCVState *env, int csrno, target_ulong val)
+static int rmw_sip(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                   target_ulong new_value, target_ulong write_mask)
 {
-    target_ulong newval =3D (atomic_read(&env->mip) & ~env->mideleg)
-                          | (val & env->mideleg);
-    return write_mip(env, CSR_MIP, newval);
+    return rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
+                   write_mask & env->mideleg);
 }
=20
 /* Supervisor Protection and Translation */
@@ -812,7 +812,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
     [CSR_MEPC] =3D                { read_mepc,        write_mepc        },
     [CSR_MCAUSE] =3D              { read_mcause,      write_mcause      },
     [CSR_MBADADDR] =3D            { read_mbadaddr,    write_mbadaddr    },
-    [CSR_MIP] =3D                 { read_mip,         write_mip         },
+    [CSR_MIP] =3D                 { NULL,     NULL,     rmw_mip         },
=20
     /* Supervisor Trap Setup */
     [CSR_SSTATUS] =3D             { read_sstatus,     write_sstatus     },
@@ -825,7 +825,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
     [CSR_SEPC] =3D                { read_sepc,        write_sepc        },
     [CSR_SCAUSE] =3D              { read_scause,      write_scause      },
     [CSR_SBADADDR] =3D            { read_sbadaddr,    write_sbadaddr    },
-    [CSR_SIP] =3D                 { read_sip,         write_sip         },
+    [CSR_SIP] =3D                 { NULL,     NULL,     rmw_sip         },
=20
     /* Supervisor Protection and Translation */
     [CSR_SATP] =3D                { read_satp,        write_satp        },
--=20
2.19.1
