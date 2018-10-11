Received: from eggs.gnu.org ([2001:4830:134:3::10]:39674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhcs-0006jY-Bt
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhcn-0006h1-9l
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:32:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhcm-0006dE-H8
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:32:00 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 11 Oct 2018 20:31:56 +0000
Message-ID: <20181011203115.18666-7-alistair.francis@wdc.com>
References: <20181011203115.18666-1-alistair.francis@wdc.com>
In-Reply-To: <20181011203115.18666-1-alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PULL 06/10] RISC-V: Allow setting and clearing
 multiple irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>Alistair Francis <Alistair.Francis@wdc.com>

From: Michael Clark <mjc@sifive.com>

Change the API of riscv_set_local_interrupt to take a
write mask and value to allow setting and clearing of
multiple local interrupts atomically in a single call.
Rename the new function to riscv_cpu_update_mip.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_clint.c  |  8 ++++----
 hw/riscv/sifive_plic.c   |  4 ++--
 target/riscv/cpu.h       | 22 +++++++++++++---------
 target/riscv/op_helper.c | 24 +++++++++++++++---------
 4 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index 7cc606e065..0d2fd52487 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -47,12 +47,12 @@ static void sifive_clint_write_timecmp(RISCVCPU *cpu, u=
int64_t value)
     if (cpu->env.timecmp <=3D rtc_r) {
         /* if we're setting an MTIMECMP value in the "past",
            immediately raise the timer interrupt */
-        riscv_set_local_interrupt(cpu, MIP_MTIP, 1);
+        riscv_cpu_update_mip(cpu, MIP_MTIP, BOOL_TO_MASK(1));
         return;
     }
=20
     /* otherwise, set up the future timer interrupt */
-    riscv_set_local_interrupt(cpu, MIP_MTIP, 0);
+    riscv_cpu_update_mip(cpu, MIP_MTIP, BOOL_TO_MASK(0));
     diff =3D cpu->env.timecmp - rtc_r;
     /* back to ns (note args switched in muldiv64) */
     next =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
@@ -67,7 +67,7 @@ static void sifive_clint_write_timecmp(RISCVCPU *cpu, uin=
t64_t value)
 static void sifive_clint_timer_cb(void *opaque)
 {
     RISCVCPU *cpu =3D opaque;
-    riscv_set_local_interrupt(cpu, MIP_MTIP, 1);
+    riscv_cpu_update_mip(cpu, MIP_MTIP, BOOL_TO_MASK(1));
 }
=20
 /* CPU wants to read rtc or timecmp register */
@@ -132,7 +132,7 @@ static void sifive_clint_write(void *opaque, hwaddr add=
r, uint64_t value,
         if (!env) {
             error_report("clint: invalid timecmp hartid: %zu", hartid);
         } else if ((addr & 0x3) =3D=3D 0) {
-            riscv_set_local_interrupt(RISCV_CPU(cpu), MIP_MSIP, value !=3D=
 0);
+            riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_MSIP, BOOL_TO_MASK(va=
lue));
         } else {
             error_report("clint: invalid sip write: %08x", (uint32_t)addr)=
;
         }
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index f635e6ff67..9cf9a1f986 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -142,10 +142,10 @@ static void sifive_plic_update(SiFivePLICState *plic)
         int level =3D sifive_plic_irqs_pending(plic, addrid);
         switch (mode) {
         case PLICMode_M:
-            riscv_set_local_interrupt(RISCV_CPU(cpu), MIP_MEIP, level);
+            riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_MEIP, BOOL_TO_MASK(le=
vel));
             break;
         case PLICMode_S:
-            riscv_set_local_interrupt(RISCV_CPU(cpu), MIP_SEIP, level);
+            riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_SEIP, BOOL_TO_MASK(le=
vel));
             break;
         default:
             break;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d4f36295f0..4ee09b9cff 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -126,13 +126,18 @@ struct CPURISCVState {
=20
     target_ulong mhartid;
     target_ulong mstatus;
+
     /*
      * CAUTION! Unlike the rest of this struct, mip is accessed asynchonou=
sly
-     * by I/O threads and other vCPUs, so hold the iothread mutex before
-     * operating on it.  CPU_INTERRUPT_HARD should be in effect iff this i=
s
-     * non-zero.  Use riscv_cpu_set_local_interrupt.
+     * by I/O threads. It should be read with atomic_read. It should be up=
dated
+     * using riscv_cpu_update_mip with the iothread mutex held. The iothre=
ad
+     * mutex must be held because mip must be consistent with the CPU intu=
rrept
+     * state. riscv_cpu_update_mip calls cpu_interrupt or cpu_reset_interr=
upt
+     * wuth the invariant that CPU_INTERRUPT_HARD is set iff mip is non-ze=
ro.
+     * mip is 32-bits to allow atomic_read on 32-bit hosts.
      */
-    uint32_t mip;        /* allow atomic_read for >=3D 32-bit hosts */
+    uint32_t mip;
+
     target_ulong mie;
     target_ulong mideleg;
=20
@@ -247,7 +252,6 @@ void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr=
 addr,
                                     uintptr_t retaddr);
 int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
                               int rw, int mmu_idx);
-
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
=20
@@ -255,6 +259,10 @@ void riscv_cpu_list(FILE *f, fprintf_function cpu_fpri=
ntf);
 #define cpu_list riscv_cpu_list
 #define cpu_mmu_index riscv_cpu_mmu_index
=20
+#ifndef CONFIG_USER_ONLY
+uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value=
);
+#define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value =
*/
+#endif
 void riscv_set_mode(CPURISCVState *env, target_ulong newpriv);
=20
 void riscv_translate_init(void);
@@ -285,10 +293,6 @@ void csr_write_helper(CPURISCVState *env, target_ulong=
 val_to_write,
         target_ulong csrno);
 target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno);
=20
-#ifndef CONFIG_USER_ONLY
-void riscv_set_local_interrupt(RISCVCPU *cpu, target_ulong mask, int value=
);
-#endif
-
 #include "exec/cpu-all.h"
=20
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index aec7558e1b..d0883d329b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -171,10 +171,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong=
 val_to_write,
          */
         qemu_mutex_lock_iothread();
         RISCVCPU *cpu =3D riscv_env_get_cpu(env);
-        riscv_set_local_interrupt(cpu, MIP_SSIP,
-                                  (val_to_write & MIP_SSIP) !=3D 0);
-        riscv_set_local_interrupt(cpu, MIP_STIP,
-                                  (val_to_write & MIP_STIP) !=3D 0);
+        riscv_cpu_update_mip(cpu, MIP_SSIP | MIP_STIP,
+                                  (val_to_write & (MIP_SSIP | MIP_STIP)));
         /*
          * csrs, csrc on mip.SEIP is not decomposable into separate read a=
nd
          * write steps, so a different implementation is needed
@@ -657,16 +655,24 @@ target_ulong helper_csrrc(CPURISCVState *env, target_=
ulong src,
 #ifndef CONFIG_USER_ONLY
=20
 /* iothread_mutex must be held */
-void riscv_set_local_interrupt(RISCVCPU *cpu, target_ulong mask, int value=
)
+uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value=
)
 {
-    target_ulong old_mip =3D cpu->env.mip;
-    cpu->env.mip =3D (old_mip & ~mask) | (value ? mask : 0);
+    CPURISCVState *env =3D &cpu->env;
+    uint32_t old, new, cmp =3D atomic_read(&env->mip);
=20
-    if (cpu->env.mip && !old_mip) {
+    do {
+        old =3D cmp;
+        new =3D (old & ~mask) | (value & mask);
+        cmp =3D atomic_cmpxchg(&env->mip, old, new);
+    } while (old !=3D cmp);
+
+    if (new && !old) {
         cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
-    } else if (!cpu->env.mip && old_mip) {
+    } else if (!new && old) {
         cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
     }
+
+    return old;
 }
=20
 void riscv_set_mode(CPURISCVState *env, target_ulong newpriv)
--=20
2.17.1
