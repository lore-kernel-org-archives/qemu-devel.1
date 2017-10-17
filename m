Received: from eggs.gnu.org ([2001:4830:134:3::10]:50558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOZ-0008MT-0c
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOW-00072I-CQ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:21 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:34 +1100
Message-Id: <20171017042152.29443-17-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/34] ppc: virtex-ml507: replace cpu_model with
 cpu_type
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
 hw/ppc/virtex_ml507.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index ed9b406fd3..5ac4f76613 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -89,14 +89,14 @@ static void mmubooke_create_initial_mapping(CPUPPCState *env,
 
 static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram_size,
                                       int do_init,
-                                      const char *cpu_model,
+                                      const char *cpu_type,
                                       uint32_t sysclk)
 {
     PowerPCCPU *cpu;
     CPUPPCState *env;
     qemu_irq *irqs;
 
-    cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
+    cpu = POWERPC_CPU(cpu_create(cpu_type));
     env = &cpu->env;
 
     ppc_booke_timers_init(cpu, sysclk, 0/* no flags */);
@@ -211,11 +211,7 @@ static void virtex_init(MachineState *machine)
     int i;
 
     /* init CPUs */
-    if (machine->cpu_model == NULL) {
-        machine->cpu_model = "440-Xilinx";
-    }
-
-    cpu = ppc440_init_xilinx(&ram_size, 1, machine->cpu_model, 400000000);
+    cpu = ppc440_init_xilinx(&ram_size, 1, machine->cpu_type, 400000000);
     env = &cpu->env;
 
     if (env->mmu_model != POWERPC_MMU_BOOKE) {
@@ -307,6 +303,7 @@ static void virtex_machine_init(MachineClass *mc)
 {
     mc->desc = "Xilinx Virtex ML507 reference design";
     mc->init = virtex_init;
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440-xilinx");
 }
 
 DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
-- 
2.13.6
