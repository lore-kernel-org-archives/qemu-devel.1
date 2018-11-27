Received: from eggs.gnu.org ([2001:4830:134:3::10]:60125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd4d-0003kk-PJ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRd4X-0007HI-No
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:06:43 -0500
Received: from 1.mo7.mail-out.ovh.net ([178.33.45.51]:46799)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRd4X-0007GA-GN
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:06:37 -0500
Received: from player774.ha.ovh.net (unknown [10.109.146.32])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 27D6BEA5D4
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:06:36 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 27 Nov 2018 14:06:31 +0100
Message-ID: <154332399179.541746.2583875942341917939.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-4.0 9/9] e500: simplify IRQ wiring
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
 hw/ppc/e500.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index e6747fce282a..b20fea0dfcef 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -685,7 +685,7 @@ static void ppce500_cpu_reset(void *opaque)
 }
 
 static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
-                                           qemu_irq **irqs)
+                                           IrqLines  *irqs)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -705,7 +705,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
     k = 0;
     for (i = 0; i < smp_cpus; i++) {
         for (j = 0; j < OPENPIC_OUTPUT_NB; j++) {
-            sysbus_connect_irq(s, k++, irqs[i][j]);
+            sysbus_connect_irq(s, k++, irqs[i].irq[j]);
         }
     }
 
@@ -713,7 +713,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
 }
 
 static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
-                                          qemu_irq **irqs, Error **errp)
+                                          IrqLines *irqs, Error **errp)
 {
     Error *err = NULL;
     DeviceState *dev;
@@ -742,7 +742,7 @@ static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
 
 static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
                                       MemoryRegion *ccsr,
-                                      qemu_irq **irqs)
+                                      IrqLines *irqs)
 {
     MachineState *machine = MACHINE(pms);
     const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(pms);
@@ -806,15 +806,14 @@ void ppce500_init(MachineState *machine)
     /* irq num for pin INTA, INTB, INTC and INTD is 1, 2, 3 and
      * 4 respectively */
     unsigned int pci_irq_nrs[PCI_NUM_PINS] = {1, 2, 3, 4};
-    qemu_irq **irqs;
+    IrqLines *irqs;
     DeviceState *dev, *mpicdev;
     CPUPPCState *firstenv = NULL;
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
     PPCE500CCSRState *ccsr;
 
-    irqs = g_malloc0(smp_cpus * sizeof(qemu_irq *));
-    irqs[0] = g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_NB);
+    irqs = g_new0(IrqLines, smp_cpus);
     for (i = 0; i < smp_cpus; i++) {
         PowerPCCPU *cpu;
         CPUState *cs;
@@ -834,10 +833,9 @@ void ppce500_init(MachineState *machine)
             firstenv = env;
         }
 
-        irqs[i] = irqs[0] + (i * OPENPIC_OUTPUT_NB);
         input = (qemu_irq *)env->irq_inputs;
-        irqs[i][OPENPIC_OUTPUT_INT] = input[PPCE500_INPUT_INT];
-        irqs[i][OPENPIC_OUTPUT_CINT] = input[PPCE500_INPUT_CINT];
+        irqs[i].irq[OPENPIC_OUTPUT_INT] = input[PPCE500_INPUT_INT];
+        irqs[i].irq[OPENPIC_OUTPUT_CINT] = input[PPCE500_INPUT_CINT];
         env->spr_cb[SPR_BOOKE_PIR].default_value = cs->cpu_index = i;
         env->mpic_iack = pmc->ccsrbar_base + MPC8544_MPIC_REGS_OFFSET + 0xa0;
 
