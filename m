Received: from eggs.gnu.org ([2001:4830:134:3::10]:57053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4y0-0007E5-Ah
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 17:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xz-00031C-BS
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 17:00:00 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 26 Nov 2017 15:59:12 -0600
Message-Id: <9eb62eb9ad147fef563d259f24c1891b4b2e8511.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 14/17] e500: split mpc8544ds specific
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

split off the remaining board specific parts
of e500_init() as mpc85xx_init() which
will be used by the existing
mpc8544ds and generic e500 boards.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/ppc/e500.c      | 49 ++++++++++++++++++++++++++++++++-----------------
 hw/ppc/e500.h      |  3 ++-
 hw/ppc/e500plat.c  |  2 +-
 hw/ppc/mpc8544ds.c |  2 +-
 4 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index b0c8495aef..0ac7cdf6a1 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -690,7 +690,32 @@ static void ppce500_power_off(void *opaque, int line, int on)
     }
 }
 
-void ppce500_init(MachineState *machine, PPCE500Params *params)
+
+void ppce500_init(MachineState *machine, uint32_t decrementer_freq)
+{
+    int i;
+    for (i = 0; i < smp_cpus; i++) {
+        PowerPCCPU *cpu;
+        CPUState *cs;
+        CPUPPCState *env;
+
+        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+        env = &cpu->env;
+        cs = CPU(cpu);
+
+        if (env->mmu_model != POWERPC_MMU_BOOKE206) {
+            error_report("MMU model %i not supported by this machine.",
+                         env->mmu_model);
+            exit(1);
+        }
+
+        env->spr_cb[SPR_BOOKE_PIR].default_value = cs->cpu_index = i;
+
+        ppc_booke_timers_init(cpu, decrementer_freq, PPC_TIMER_E500);
+    }
+}
+
+void mpc85xx_init(MachineState *machine, PPCE500Params *params)
 {
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
@@ -716,31 +741,21 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     CPUPPCState *firstenv = NULL;
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
+    CPUState *cs;
 
-    for (i = 0; i < smp_cpus; i++) {
+    ppce500_init(machine, 400000000);
+
+    CPU_FOREACH(cs) {
         PowerPCCPU *cpu;
-        CPUState *cs;
 
-        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+        cpu = POWERPC_CPU(cs);
         env = &cpu->env;
-        cs = CPU(cpu);
 
-        if (env->mmu_model != POWERPC_MMU_BOOKE206) {
-            fprintf(stderr, "MMU model %i not supported by this machine.\n",
-                env->mmu_model);
-            exit(1);
-        }
 
+        /* Register reset handler */
         if (!firstenv) {
             firstenv = env;
-        }
 
-        env->spr_cb[SPR_BOOKE_PIR].default_value = cs->cpu_index = i;
-
-        ppc_booke_timers_init(cpu, 400000000, PPC_TIMER_E500);
-
-        /* Register reset handler */
-        if (!i) {
             /* Primary CPU */
             struct boot_info *boot_info;
             boot_info = g_malloc0(sizeof(struct boot_info));
diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 70ba1d8f4f..350be17462 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -24,7 +24,8 @@ typedef struct PPCE500Params {
     hwaddr spin_base;
 } PPCE500Params;
 
-void ppce500_init(MachineState *machine, PPCE500Params *params);
+void ppce500_init(MachineState *machine, uint32_t decrementer_freq);
+void mpc85xx_init(MachineState *machine, PPCE500Params *params);
 
 hwaddr booke206_page_size_to_tlb(uint64_t size);
 
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index e59e80fb9e..103efc68c2 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -55,7 +55,7 @@ static void e500plat_init(MachineState *machine)
         params.mpic_version = OPENPIC_MODEL_FSL_MPIC_20;
     }
 
-    ppce500_init(machine, &params);
+    mpc85xx_init(machine, &params);
 }
 
 static void e500plat_machine_init(MachineClass *mc)
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 1717953ec7..7de4ed8ae2 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -47,7 +47,7 @@ static void mpc8544ds_init(MachineState *machine)
         exit(1);
     }
 
-    ppce500_init(machine, &params);
+    mpc85xx_init(machine, &params);
 }
 
 
-- 
2.11.0
