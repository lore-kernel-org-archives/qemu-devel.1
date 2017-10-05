Received: from eggs.gnu.org ([2001:4830:134:3::10]:45075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xW-0002yP-3q
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xR-0003Jy-Pm
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:13 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 18:24:36 +0200
Message-Id: <1507220690-265042-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 09/23] ppc: virtex-ml507: replace cpu_model
 with cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/ppc/virtex_ml507.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index ed9b406..5ac4f76 100644
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
2.7.4
