Received: from eggs.gnu.org ([2001:4830:134:3::10]:50715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC6-0003eu-LE
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC3-000276-TC
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:50 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:11 +1100
Message-Id: <20181213040126.6768-13-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/27] e500: simplify IRQ wiring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The OpenPIC have 5 outputs per connected CPU. The machine init code hence
needs a bi-dimensional array (smp_cpu lines, 5 columns) to wire up the ir=
qs
between the PIC and the CPUs.

The current code first allocates an array of smp_cpus pointers to qemu_ir=
q
type, then it allocates another array of smp_cpus * 5 qemu_irq and fills =
the
first array with pointers to each line of the second array. This is rathe=
r
convoluted.

Simplify the logic by introducing a structured type that describes all th=
e
OpenPIC outputs for a single CPU, ie, fixed size of 5 qemu_irq, and only
allocate a smp_cpu sized array of those.

This also allows to use g_new(T, n) instead of g_malloc(sizeof(T) * n)
as recommended in HACKING.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/e500.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index e6747fce28..b20fea0dfc 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -685,7 +685,7 @@ static void ppce500_cpu_reset(void *opaque)
 }
=20
 static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
-                                           qemu_irq **irqs)
+                                           IrqLines  *irqs)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -705,7 +705,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500Mac=
hineState *pms,
     k =3D 0;
     for (i =3D 0; i < smp_cpus; i++) {
         for (j =3D 0; j < OPENPIC_OUTPUT_NB; j++) {
-            sysbus_connect_irq(s, k++, irqs[i][j]);
+            sysbus_connect_irq(s, k++, irqs[i].irq[j]);
         }
     }
=20
@@ -713,7 +713,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500Mac=
hineState *pms,
 }
=20
 static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc=
,
-                                          qemu_irq **irqs, Error **errp)
+                                          IrqLines *irqs, Error **errp)
 {
     Error *err =3D NULL;
     DeviceState *dev;
@@ -742,7 +742,7 @@ static DeviceState *ppce500_init_mpic_kvm(const PPCE5=
00MachineClass *pmc,
=20
 static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
                                       MemoryRegion *ccsr,
-                                      qemu_irq **irqs)
+                                      IrqLines *irqs)
 {
     MachineState *machine =3D MACHINE(pms);
     const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(pms);
@@ -806,15 +806,14 @@ void ppce500_init(MachineState *machine)
     /* irq num for pin INTA, INTB, INTC and INTD is 1, 2, 3 and
      * 4 respectively */
     unsigned int pci_irq_nrs[PCI_NUM_PINS] =3D {1, 2, 3, 4};
-    qemu_irq **irqs;
+    IrqLines *irqs;
     DeviceState *dev, *mpicdev;
     CPUPPCState *firstenv =3D NULL;
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
     PPCE500CCSRState *ccsr;
=20
-    irqs =3D g_malloc0(smp_cpus * sizeof(qemu_irq *));
-    irqs[0] =3D g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_N=
B);
+    irqs =3D g_new0(IrqLines, smp_cpus);
     for (i =3D 0; i < smp_cpus; i++) {
         PowerPCCPU *cpu;
         CPUState *cs;
@@ -834,10 +833,9 @@ void ppce500_init(MachineState *machine)
             firstenv =3D env;
         }
=20
-        irqs[i] =3D irqs[0] + (i * OPENPIC_OUTPUT_NB);
         input =3D (qemu_irq *)env->irq_inputs;
-        irqs[i][OPENPIC_OUTPUT_INT] =3D input[PPCE500_INPUT_INT];
-        irqs[i][OPENPIC_OUTPUT_CINT] =3D input[PPCE500_INPUT_CINT];
+        irqs[i].irq[OPENPIC_OUTPUT_INT] =3D input[PPCE500_INPUT_INT];
+        irqs[i].irq[OPENPIC_OUTPUT_CINT] =3D input[PPCE500_INPUT_CINT];
         env->spr_cb[SPR_BOOKE_PIR].default_value =3D cs->cpu_index =3D i=
;
         env->mpic_iack =3D pmc->ccsrbar_base + MPC8544_MPIC_REGS_OFFSET =
+ 0xa0;
=20
--=20
2.19.2
