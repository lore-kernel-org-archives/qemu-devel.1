Received: from eggs.gnu.org ([209.51.188.92]:49498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsH00-0005Eh-VY
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 20:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsGzv-0006Ge-Vg
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 20:00:02 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 9 Feb 2019 00:59:56 +0000
Message-ID: <e1345bc6141130d7d7b3414377964d1223cf09ae.1549673900.git.alistair.francis@wdc.com>
References: <cover.1549673900.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1549673900.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 04/11] RISC-V: Allow interrupt controllers
 to claim interrupts
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

We can't allow the supervisor to control SEIP as this would allow the
supervisor to clear a pending external interrupt which will result in
lost a interrupt in the case a PLIC is attached. The SEIP bit must be
hardware controlled when a PLIC is attached.

This logic was previously hard-coded so SEIP was always masked even
if no PLIC was attached. This patch adds riscv_cpu_claim_interrupts
so that the PLIC can register control of SEIP. In the case of models
without a PLIC (spike), the SEIP bit remains software controlled.

This interface allows for hardware control of supervisor timer and
software interrupts by other interrupt controller models.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_plic.c    | 15 +++++++++++++++
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_helper.c | 11 +++++++++++
 target/riscv/csr.c        | 10 ++--------
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index b859f919a7..1c703e1a37 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -23,6 +23,7 @@
 #include "qemu/error-report.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
+#include "sysemu/sysemu.h"
 #include "hw/riscv/sifive_plic.h"
=20
 #define RISCV_DEBUG_PLIC 0
@@ -431,6 +432,7 @@ static void sifive_plic_irq_request(void *opaque, int i=
rq, int level)
 static void sifive_plic_realize(DeviceState *dev, Error **errp)
 {
     SiFivePLICState *plic =3D SIFIVE_PLIC(dev);
+    int i;
=20
     memory_region_init_io(&plic->mmio, OBJECT(dev), &sifive_plic_ops, plic=
,
                           TYPE_SIFIVE_PLIC, plic->aperture_size);
@@ -443,6 +445,19 @@ static void sifive_plic_realize(DeviceState *dev, Erro=
r **errp)
     plic->enable =3D g_new0(uint32_t, plic->bitfield_words * plic->num_add=
rs);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &plic->mmio);
     qdev_init_gpio_in(dev, sifive_plic_irq_request, plic->num_sources);
+
+    /* We can't allow the supervisor to control SEIP as this would allow t=
he
+     * supervisor to clear a pending external interrupt which will result =
in
+     * lost a interrupt in the case a PLIC is attached. The SEIP bit must =
be
+     * hardware controlled when a PLIC is attached.
+     */
+    for (i =3D 0; i < smp_cpus; i++) {
+        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(i));
+        if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
+            error_report("SEIP already claimed");
+            exit(1);
+        }
+    }
 }
=20
 static void sifive_plic_class_init(ObjectClass *klass, void *data)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5c2aebf132..a0b3c22dec 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -140,6 +140,7 @@ struct CPURISCVState {
      * mip is 32-bits to allow atomic_read on 32-bit hosts.
      */
     uint32_t mip;
+    uint32_t miclaim;
=20
     target_ulong mie;
     target_ulong mideleg;
@@ -263,6 +264,7 @@ void riscv_cpu_list(FILE *f, fprintf_function cpu_fprin=
tf);
 #define cpu_mmu_index riscv_cpu_mmu_index
=20
 #ifndef CONFIG_USER_ONLY
+int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value=
);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value =
*/
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f49e98ed59..555756d40c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -72,6 +72,17 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrup=
t_request)
=20
 #if !defined(CONFIG_USER_ONLY)
=20
+int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
+{
+    CPURISCVState *env =3D &cpu->env;
+    if (env->miclaim & interrupts) {
+        return -1;
+    } else {
+        env->miclaim |=3D interrupts;
+        return 0;
+    }
+}
+
 /* iothread_mutex must be held */
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value=
)
 {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 960d2b0aa9..938c10897c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -550,16 +550,10 @@ static int rmw_mip(CPURISCVState *env, int csrno, tar=
get_ulong *ret_value,
                    target_ulong new_value, target_ulong write_mask)
 {
     RISCVCPU *cpu =3D riscv_env_get_cpu(env);
-    target_ulong mask =3D write_mask & delegable_ints;
+    /* Allow software control of delegable interrupts not claimed by hardw=
are */
+    target_ulong mask =3D write_mask & delegable_ints & ~env->miclaim;
     uint32_t old_mip;
=20
-    /* We can't allow the supervisor to control SEIP as this would allow t=
he
-     * supervisor to clear a pending external interrupt which will result =
in
-     * lost a interrupt in the case a PLIC is attached. The SEIP bit must =
be
-     * hardware controlled when a PLIC is attached. This should be an opti=
on
-     * for CPUs with software-delegated Supervisor External Interrupts. */
-    mask &=3D ~MIP_SEIP;
-
     if (mask) {
         qemu_mutex_lock_iothread();
         old_mip =3D riscv_cpu_update_mip(cpu, mask, (new_value & mask));
--=20
2.20.1
