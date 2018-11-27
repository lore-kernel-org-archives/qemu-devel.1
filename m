Received: from eggs.gnu.org ([2001:4830:134:3::10]:60038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd4W-0003ey-3i
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:06:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd4Q-0007Aw-96
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:06:36 -0500
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:56306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRd4O-0007A2-DU
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:06:29 -0500
Received: from player693.ha.ovh.net (unknown [10.109.143.24])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id CA5CD10BB10
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:06:26 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 27 Nov 2018 14:06:22 +0100
Message-ID: <154332398267.541746.11072542942668362774.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-4.0 8/9] mac_newworld: simplify IRQ wiring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The OpenPIC have 5 outputs per connected CPU. The machine init code hence
needs a bi-dimensional array (smp_cpu lines, 5 columns) to wire up the irqs
between the PIC and the CPUs.

The current code first allocates an array of smp_cpus pointers to qemu_irq
type, then it allocates another array of smp_cpus * 5 qemu_irq and fills the
first array with pointers to each line of the second array. This is rather
convoluted.

Simplify the logic by introducing a structured type that describes all the
OpenPIC outputs for a single CPU, ie, fixed size of 5 qemu_irq, and only
allocate a smp_cpu sized array of those.

This also allows to use g_new(T, n) instead of g_malloc(sizeof(T) * n)
as recommended in HACKING.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/mac_newworld.c    |   30 +++++++++++++-----------------
 include/hw/ppc/openpic.h |    2 ++
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 14273a123e52..8c1bc6dd8a90 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -115,7 +115,7 @@ static void ppc_core99_init(MachineState *machine)
     PowerPCCPU *cpu = NULL;
     CPUPPCState *env = NULL;
     char *filename;
-    qemu_irq **openpic_irqs;
+    IrqLines *openpic_irqs;
     int linux_boot, i, j, k;
     MemoryRegion *ram = g_new(MemoryRegion, 1), *bios = g_new(MemoryRegion, 1);
     hwaddr kernel_base, initrd_base, cmdline_base = 0;
@@ -249,41 +249,37 @@ static void ppc_core99_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0xf8000000,
                                 sysbus_mmio_get_region(s, 0));
 
-    openpic_irqs = g_malloc0(smp_cpus * sizeof(qemu_irq *));
-    openpic_irqs[0] =
-        g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_NB);
+    openpic_irqs = g_new0(IrqLines, smp_cpus);
     for (i = 0; i < smp_cpus; i++) {
         /* Mac99 IRQ connection between OpenPIC outputs pins
          * and PowerPC input pins
          */
         switch (PPC_INPUT(env)) {
         case PPC_FLAGS_INPUT_6xx:
-            openpic_irqs[i] = openpic_irqs[0] + (i * OPENPIC_OUTPUT_NB);
-            openpic_irqs[i][OPENPIC_OUTPUT_INT] =
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_INT] =
                 ((qemu_irq *)env->irq_inputs)[PPC6xx_INPUT_INT];
-            openpic_irqs[i][OPENPIC_OUTPUT_CINT] =
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_CINT] =
                 ((qemu_irq *)env->irq_inputs)[PPC6xx_INPUT_INT];
-            openpic_irqs[i][OPENPIC_OUTPUT_MCK] =
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_MCK] =
                 ((qemu_irq *)env->irq_inputs)[PPC6xx_INPUT_MCP];
             /* Not connected ? */
-            openpic_irqs[i][OPENPIC_OUTPUT_DEBUG] = NULL;
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_DEBUG] = NULL;
             /* Check this */
-            openpic_irqs[i][OPENPIC_OUTPUT_RESET] =
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_RESET] =
                 ((qemu_irq *)env->irq_inputs)[PPC6xx_INPUT_HRESET];
             break;
 #if defined(TARGET_PPC64)
         case PPC_FLAGS_INPUT_970:
-            openpic_irqs[i] = openpic_irqs[0] + (i * OPENPIC_OUTPUT_NB);
-            openpic_irqs[i][OPENPIC_OUTPUT_INT] =
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_INT] =
                 ((qemu_irq *)env->irq_inputs)[PPC970_INPUT_INT];
-            openpic_irqs[i][OPENPIC_OUTPUT_CINT] =
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_CINT] =
                 ((qemu_irq *)env->irq_inputs)[PPC970_INPUT_INT];
-            openpic_irqs[i][OPENPIC_OUTPUT_MCK] =
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_MCK] =
                 ((qemu_irq *)env->irq_inputs)[PPC970_INPUT_MCP];
             /* Not connected ? */
-            openpic_irqs[i][OPENPIC_OUTPUT_DEBUG] = NULL;
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_DEBUG] = NULL;
             /* Check this */
-            openpic_irqs[i][OPENPIC_OUTPUT_RESET] =
+            openpic_irqs[i].irq[OPENPIC_OUTPUT_RESET] =
                 ((qemu_irq *)env->irq_inputs)[PPC970_INPUT_HRESET];
             break;
 #endif /* defined(TARGET_PPC64) */
@@ -300,7 +296,7 @@ static void ppc_core99_init(MachineState *machine)
     k = 0;
     for (i = 0; i < smp_cpus; i++) {
         for (j = 0; j < OPENPIC_OUTPUT_NB; j++) {
-            sysbus_connect_irq(s, k++, openpic_irqs[i][j]);
+            sysbus_connect_irq(s, k++, openpic_irqs[i].irq[j]);
         }
     }
     g_free(openpic_irqs);
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index 5eb982197d2a..dad08fe9be9e 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -20,6 +20,8 @@ enum {
     OPENPIC_OUTPUT_NB,
 };
 
+typedef struct IrqLines { qemu_irq irq[OPENPIC_OUTPUT_NB]; } IrqLines;
+
 #define OPENPIC_MODEL_RAVEN       0
 #define OPENPIC_MODEL_FSL_MPIC_20 1
 #define OPENPIC_MODEL_FSL_MPIC_42 2
