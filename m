Received: from eggs.gnu.org ([2001:4830:134:3::10]:50855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXICA-0003kC-50
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC6-0002Ck-Qg
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:53 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:10 +1100
Message-Id: <20181213040126.6768-12-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/27] mac_newworld: simplify IRQ wiring
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
 hw/ppc/mac_newworld.c    | 30 +++++++++++++-----------------
 include/hw/ppc/openpic.h |  2 ++
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 14273a123e..8c1bc6dd8a 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -115,7 +115,7 @@ static void ppc_core99_init(MachineState *machine)
     PowerPCCPU *cpu =3D NULL;
     CPUPPCState *env =3D NULL;
     char *filename;
-    qemu_irq **openpic_irqs;
+    IrqLines *openpic_irqs;
     int linux_boot, i, j, k;
     MemoryRegion *ram =3D g_new(MemoryRegion, 1), *bios =3D g_new(Memory=
Region, 1);
     hwaddr kernel_base, initrd_base, cmdline_base =3D 0;
@@ -249,41 +249,37 @@ static void ppc_core99_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0xf8000000,
                                 sysbus_mmio_get_region(s, 0));
=20
-    openpic_irqs =3D g_malloc0(smp_cpus * sizeof(qemu_irq *));
-    openpic_irqs[0] =3D
-        g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_NB);
+    openpic_irqs =3D g_new0(IrqLines, smp_cpus);
     for (i =3D 0; i < smp_cpus; i++) {
         /* Mac99 IRQ connection between OpenPIC outputs pins
          * and PowerPC input pins
          */
         switch (PPC_INPUT(env)) {
         case PPC_FLAGS_INPUT_6xx:
-            openpic_irqs[i] =3D openpic_irqs[0] + (i * OPENPIC_OUTPUT_NB=
);
-            openpic_irqs[i][OPENPIC_OUTPUT_INT] =3D
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_INT] =3D
                 ((qemu_irq *)env->irq_inputs)[PPC6xx_INPUT_INT];
-            openpic_irqs[i][OPENPIC_OUTPUT_CINT] =3D
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_CINT] =3D
                 ((qemu_irq *)env->irq_inputs)[PPC6xx_INPUT_INT];
-            openpic_irqs[i][OPENPIC_OUTPUT_MCK] =3D
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_MCK] =3D
                 ((qemu_irq *)env->irq_inputs)[PPC6xx_INPUT_MCP];
             /* Not connected ? */
-            openpic_irqs[i][OPENPIC_OUTPUT_DEBUG] =3D NULL;
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_DEBUG] =3D NULL;
             /* Check this */
-            openpic_irqs[i][OPENPIC_OUTPUT_RESET] =3D
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_RESET] =3D
                 ((qemu_irq *)env->irq_inputs)[PPC6xx_INPUT_HRESET];
             break;
 #if defined(TARGET_PPC64)
         case PPC_FLAGS_INPUT_970:
-            openpic_irqs[i] =3D openpic_irqs[0] + (i * OPENPIC_OUTPUT_NB=
);
-            openpic_irqs[i][OPENPIC_OUTPUT_INT] =3D
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_INT] =3D
                 ((qemu_irq *)env->irq_inputs)[PPC970_INPUT_INT];
-            openpic_irqs[i][OPENPIC_OUTPUT_CINT] =3D
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_CINT] =3D
                 ((qemu_irq *)env->irq_inputs)[PPC970_INPUT_INT];
-            openpic_irqs[i][OPENPIC_OUTPUT_MCK] =3D
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_MCK] =3D
                 ((qemu_irq *)env->irq_inputs)[PPC970_INPUT_MCP];
             /* Not connected ? */
-            openpic_irqs[i][OPENPIC_OUTPUT_DEBUG] =3D NULL;
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_DEBUG] =3D NULL;
             /* Check this */
-            openpic_irqs[i][OPENPIC_OUTPUT_RESET] =3D
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_RESET] =3D
                 ((qemu_irq *)env->irq_inputs)[PPC970_INPUT_HRESET];
             break;
 #endif /* defined(TARGET_PPC64) */
@@ -300,7 +296,7 @@ static void ppc_core99_init(MachineState *machine)
     k =3D 0;
     for (i =3D 0; i < smp_cpus; i++) {
         for (j =3D 0; j < OPENPIC_OUTPUT_NB; j++) {
-            sysbus_connect_irq(s, k++, openpic_irqs[i][j]);
+            sysbus_connect_irq(s, k++, openpic_irqs[i].irq[j]);
         }
     }
     g_free(openpic_irqs);
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index 5eb982197d..dad08fe9be 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -20,6 +20,8 @@ enum {
     OPENPIC_OUTPUT_NB,
 };
=20
+typedef struct IrqLines { qemu_irq irq[OPENPIC_OUTPUT_NB]; } IrqLines;
+
 #define OPENPIC_MODEL_RAVEN       0
 #define OPENPIC_MODEL_FSL_MPIC_20 1
 #define OPENPIC_MODEL_FSL_MPIC_42 2
--=20
2.19.2
