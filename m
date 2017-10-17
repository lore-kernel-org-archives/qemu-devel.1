Received: from eggs.gnu.org ([2001:4830:134:3::10]:50488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOW-0008LK-3s
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOU-0006ys-U2
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:20 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:29 +1100
Message-Id: <20171017042152.29443-12-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/34] ppc: mpc8544ds/e500plat: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/e500.c      | 8 +-------
 hw/ppc/e500plat.c  | 1 +
 hw/ppc/mpc8544ds.c | 2 ++
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index db0e49ab8f..9178e70132 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -803,11 +803,6 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     SysBusDevice *s;
     PPCE500CCSRState *ccsr;
 
-    /* Setup CPUs */
-    if (machine->cpu_model == NULL) {
-        machine->cpu_model = "e500v2_v30";
-    }
-
     irqs = g_malloc0(smp_cpus * sizeof(qemu_irq *));
     irqs[0] = g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_NB);
     for (i = 0; i < smp_cpus; i++) {
@@ -815,8 +810,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         CPUState *cs;
         qemu_irq *input;
 
-        cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
-                                           machine->cpu_model));
+        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
         env = &cpu->env;
         cs = CPU(cpu);
 
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 94b454551f..e59e80fb9e 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -64,6 +64,7 @@ static void e500plat_machine_init(MachineClass *mc)
     mc->init = e500plat_init;
     mc->max_cpus = 32;
     mc->has_dynamic_sysbus = true;
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
 }
 
 DEFINE_MACHINE("ppce500", e500plat_machine_init)
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 27b8289016..1717953ec7 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -16,6 +16,7 @@
 #include "sysemu/device_tree.h"
 #include "hw/ppc/openpic.h"
 #include "qemu/error-report.h"
+#include "cpu.h"
 
 static void mpc8544ds_fixup_devtree(PPCE500Params *params, void *fdt)
 {
@@ -55,6 +56,7 @@ static void ppce500_machine_init(MachineClass *mc)
     mc->desc = "mpc8544ds";
     mc->init = mpc8544ds_init;
     mc->max_cpus = 15;
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
 }
 
 DEFINE_MACHINE("mpc8544ds", ppce500_machine_init)
-- 
2.13.6
