Received: from eggs.gnu.org ([209.51.188.92]:38765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOk-0005uU-1r
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOg-00054N-Dp
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:01 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOf-0004gJ-Ko
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:58 -0500
Received: by mail-pf1-x442.google.com with SMTP id g6so313846pfh.13
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:54 -0800
Message-Id: <20190211235258.542-25-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 24/28] target/arm: Create tagged ram when
 MTE is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h |  4 ++++
 hw/arm/virt.c    | 33 +++++++++++++++++++++++++++++++++
 target/arm/cpu.c | 21 ++++++++++++++++++---
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ca32939483..2626af4a9c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -768,6 +768,9 @@ struct ARMCPU {
     /* MemoryRegion to use for secure physical accesses */
     MemoryRegion *secure_memory;
 
+    /* MemoryRegion to use for allocation tag accesses */
+    MemoryRegion *tag_memory;
+
     /* For v8M, pointer to the IDAU interface provided by board/SoC */
     Object *idau;
 
@@ -2850,6 +2853,7 @@ int cpu_mmu_index(CPUARMState *env, bool ifetch);
 typedef enum ARMASIdx {
     ARMASIdx_NS = 0,
     ARMASIdx_S = 1,
+    ARMASIdx_TAG = 2,
 } ARMASIdx;
 
 /* Return the Exception Level targeted by debug exceptions. */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99c2b6e60d..dccd1345a1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1260,6 +1260,21 @@ static void create_secure_ram(VirtMachineState *vms,
     g_free(nodename);
 }
 
+static void create_tag_ram(VirtMachineState *vms, MachineState *machine,
+                           MemoryRegion *tag_sysmem)
+{
+    MemoryRegion *tagram = g_new(MemoryRegion, 1);
+    hwaddr base = vms->memmap[VIRT_MEM].base / 32;
+    hwaddr size = machine->ram_size / 32;
+
+    memory_region_init_ram(tagram, NULL, "mach-virt.tag", size, &error_fatal);
+    memory_region_add_subregion(tag_sysmem, base, tagram);
+
+    /* ??? Do we really need an fdt entry, or is MemTag enabled sufficient.  */
+    /* ??? We appear to need secure tag mem to go with secure mem.  */
+    /* ??? Does that imply we need a fourth address space?  */
+}
+
 static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
 {
     const VirtMachineState *board = container_of(binfo, VirtMachineState,
@@ -1362,6 +1377,7 @@ static void machvirt_init(MachineState *machine)
     qemu_irq pic[NUM_IRQS];
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
+    MemoryRegion *tag_sysmem = NULL;
     int n, virt_max_cpus;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
@@ -1518,6 +1534,20 @@ static void machvirt_init(MachineState *machine)
                                      "secure-memory", &error_abort);
         }
 
+        /*
+         * The cpu adds the property iff MemTag is supported.
+         * If it is, we must allocate the ram to back that up.
+         */
+        if (object_property_find(cpuobj, "tag-memory", NULL)) {
+            if (!tag_sysmem) {
+                tag_sysmem = g_new(MemoryRegion, 1);
+                memory_region_init(tag_sysmem, OBJECT(machine),
+                                   "tag-memory", UINT64_MAX / 32);
+            }
+            object_property_set_link(cpuobj, OBJECT(tag_sysmem),
+                                     "tag-memory", &error_abort);
+        }
+
         object_property_set_bool(cpuobj, true, "realized", &error_fatal);
         object_unref(cpuobj);
     }
@@ -1540,6 +1570,9 @@ static void machvirt_init(MachineState *machine)
         create_secure_ram(vms, secure_sysmem);
         create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
     }
+    if (tag_sysmem) {
+        create_tag_ram(vms, machine, tag_sysmem);
+    }
 
     vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index edf6e0e1f1..decf95de3e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -851,6 +851,18 @@ void arm_cpu_post_init(Object *obj)
 
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
                              &error_abort);
+
+#ifndef CONFIG_USER_ONLY
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
+        cpu_isar_feature(aa64_mte, cpu)) {
+        object_property_add_link(obj, "tag-memory",
+                                 TYPE_MEMORY_REGION,
+                                 (Object **)&cpu->tag_memory,
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG,
+                                 &error_abort);
+    }
+#endif
 }
 
 static void arm_cpu_finalizefn(Object *obj)
@@ -1164,16 +1176,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     init_cpreg_list(cpu);
 
 #ifndef CONFIG_USER_ONLY
+    cs->num_ases = 1;
     if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         cs->num_ases = 2;
-
         if (!cpu->secure_memory) {
             cpu->secure_memory = cs->memory;
         }
         cpu_address_space_init(cs, ARMASIdx_S, "cpu-secure-memory",
                                cpu->secure_memory);
-    } else {
-        cs->num_ases = 1;
+    }
+    if (cpu->tag_memory != NULL) {
+        cs->num_ases = 3;
+        cpu_address_space_init(cs, ARMASIdx_TAG, "cpu-tag-memory",
+                               cpu->tag_memory);
     }
     cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
 
-- 
2.17.2
