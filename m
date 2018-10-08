Received: from eggs.gnu.org ([2001:4830:134:3::10]:34906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=812b08464=Alistair.Francis@wdc.com>)
	id 1g9aDp-0004aF-2E
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=812b08464=Alistair.Francis@wdc.com>)
	id 1g9aDl-0007bY-Lx
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:25:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=812b08464=Alistair.Francis@wdc.com>)
	id 1g9aDk-0007Vf-7l
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:25:33 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 8 Oct 2018 18:25:27 +0000
Message-ID: <c5c4c65332bdfedc34f3b916233f5e3e61225e93.1539023064.git.alistair.francis@wdc.com>
References: <cover.1539023064.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1539023064.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 2/5] RISC-V: Move non-ops from op_helper to
 cpu_helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

From: Michael Clark <mjc@sifive.com>

This patch makes op_helper.c contain only instruction
operation helpers used by translate.c and moves any
unrelated cpu helpers into cpu_helper.c. No logic is
changed by this patch.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/Makefile.objs              |  2 +-
 target/riscv/{helper.c =3D> cpu_helper.c} | 35 ++++++++++++++++++++++++-
 target/riscv/op_helper.c                | 34 ------------------------
 3 files changed, 35 insertions(+), 36 deletions(-)
 rename target/riscv/{helper.c =3D> cpu_helper.c} (95%)

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index abd0a7cde3..fcc5d34c1f 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -1 +1 @@
-obj-y +=3D translate.o op_helper.o helper.o cpu.o fpu_helper.o gdbstub.o p=
mp.o
+obj-y +=3D translate.o op_helper.o cpu_helper.o cpu.o fpu_helper.o gdbstub=
.o pmp.o
diff --git a/target/riscv/helper.c b/target/riscv/cpu_helper.c
similarity index 95%
rename from target/riscv/helper.c
rename to target/riscv/cpu_helper.c
index 63b3386b76..86f9f4730c 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1,5 +1,5 @@
 /*
- * RISC-V emulation helpers for qemu.
+ * RISC-V CPU helpers for qemu.
  *
  * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
  * Copyright (c) 2017-2018 SiFive, Inc.
@@ -72,6 +72,39 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrup=
t_request)
=20
 #if !defined(CONFIG_USER_ONLY)
=20
+/* iothread_mutex must be held */
+uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value=
)
+{
+    CPURISCVState *env =3D &cpu->env;
+    uint32_t old, new, cmp =3D atomic_read(&env->mip);
+
+    do {
+        old =3D cmp;
+        new =3D (old & ~mask) | (value & mask);
+        cmp =3D atomic_cmpxchg(&env->mip, old, new);
+    } while (old !=3D cmp);
+
+    if (new && !old) {
+        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+    } else if (!new && old) {
+        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+    }
+
+    return old;
+}
+
+void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
+{
+    if (newpriv > PRV_M) {
+        g_assert_not_reached();
+    }
+    if (newpriv =3D=3D PRV_H) {
+        newpriv =3D PRV_U;
+    }
+    /* tlb_flush is unnecessary as mode is contained in mmu_idx */
+    env->priv =3D newpriv;
+}
+
 /* get_physical_address - get the physical address for this virtual addres=
s
  *
  * Do a page table walk to obtain the physical address corresponding to a
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index d0883d329b..495390ab1c 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -654,39 +654,6 @@ target_ulong helper_csrrc(CPURISCVState *env, target_u=
long src,
=20
 #ifndef CONFIG_USER_ONLY
=20
-/* iothread_mutex must be held */
-uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value=
)
-{
-    CPURISCVState *env =3D &cpu->env;
-    uint32_t old, new, cmp =3D atomic_read(&env->mip);
-
-    do {
-        old =3D cmp;
-        new =3D (old & ~mask) | (value & mask);
-        cmp =3D atomic_cmpxchg(&env->mip, old, new);
-    } while (old !=3D cmp);
-
-    if (new && !old) {
-        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
-    } else if (!new && old) {
-        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
-    }
-
-    return old;
-}
-
-void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
-{
-    if (newpriv > PRV_M) {
-        g_assert_not_reached();
-    }
-    if (newpriv =3D=3D PRV_H) {
-        newpriv =3D PRV_U;
-    }
-    /* tlb_flush is unnecessary as mode is contained in mmu_idx */
-    env->priv =3D newpriv;
-}
-
 target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
 {
     if (!(env->priv >=3D PRV_S)) {
@@ -737,7 +704,6 @@ target_ulong helper_mret(CPURISCVState *env, target_ulo=
ng cpu_pc_deb)
     return retpc;
 }
=20
-
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs =3D CPU(riscv_env_get_cpu(env));
--=20
2.17.1
