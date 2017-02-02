Received: from eggs.gnu.org ([2001:4830:134:3::10]:52528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kD-0007si-5J
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k6-0004DR-IH
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:40 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:37 +1100
Message-Id: <20170202051445.5735-100-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 099/107] target-ppc: Add MMU model check for
 booke machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Valentin Plotkin <caliborn@sdf.org>, David Gibson <david@gibson.dropbear.id.au>

From: Valentin Plotkin <caliborn@sdf.org>

Machines bamboo, e500 and virtex-ml507 assume a certain MMU model,
otherwise resulting in unpredictable behavior. Add apropriate checks
into *_init functions.

Signed-off-by: Valentin Plotkin <caliborn@sdf.org>

[regarding virtex parts]
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/e500.c          | 6 ++++++
 hw/ppc/ppc440_bamboo.c | 6 ++++++
 hw/ppc/virtex_ml507.c  | 7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 792bd79..f7df238 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -827,6 +827,12 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         env = &cpu->env;
         cs = CPU(cpu);
 
+        if (env->mmu_model != POWERPC_MMU_BOOKE206) {
+            fprintf(stderr, "MMU model %i not supported by this machine.\n",
+                env->mmu_model);
+            exit(1);
+        }
+
         if (!firstenv) {
             firstenv = env;
         }
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 5c535b1..9d997bf 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -193,6 +193,12 @@ static void bamboo_init(MachineState *machine)
     }
     env = &cpu->env;
 
+    if (env->mmu_model != POWERPC_MMU_BOOKE) {
+        fprintf(stderr, "MMU model %i not supported by this machine.\n",
+            env->mmu_model);
+        exit(1);
+    }
+
     qemu_register_reset(main_cpu_reset, cpu);
     ppc_booke_timers_init(cpu, 400000000, 0);
     ppc_dcr_init(env, NULL, NULL);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index b97d966..fdbcf22 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -221,6 +221,13 @@ static void virtex_init(MachineState *machine)
 
     cpu = ppc440_init_xilinx(&ram_size, 1, machine->cpu_model, 400000000);
     env = &cpu->env;
+
+    if (env->mmu_model != POWERPC_MMU_BOOKE) {
+        fprintf(stderr, "MMU model %i not supported by this machine.\n",
+            env->mmu_model);
+        exit(1);
+    }
+
     qemu_register_reset(main_cpu_reset, cpu);
 
     memory_region_allocate_system_memory(phys_ram, NULL, "ram", ram_size);
-- 
2.9.3
