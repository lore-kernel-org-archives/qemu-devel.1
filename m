Received: from eggs.gnu.org ([2001:4830:134:3::10]:54185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fIyFs-0007uZ-Vp
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fIyFm-0005nk-T1
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:22:16 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Wed, 16 May 2018 16:20:22 +0100
Message-ID: <20180516152026.2920-3-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v2 2/6] hw/arm/virt: Enable dynamic generation of
 guest RAM memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: drjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, eric.auger@redhat.com, zhaoshenglong@huawei.com, jonathan.cameron@huawei.com, linuxarm@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Register ram_memory_region_init notifier to allocate memory region
from system memory.

Signed-off-by: Zhu Yijun <zhuyijun@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/virt.c         | 28 ++++++++++++++++++++++------
 include/hw/arm/virt.h |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 94dcb12..05fcb62 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1171,6 +1171,19 @@ void virt_machine_done(Notifier *notifier, void *data)
     virt_build_smbios(vms);
 }
 
+static void virt_ram_memory_region_init(Notifier *notifier, void *data)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *ram = g_new(MemoryRegion, 1);
+    VirtMachineState *vms = container_of(notifier, VirtMachineState,
+                                         ram_memory_region_init);
+    MachineState *machine = MACHINE(vms);
+
+    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
+                                         machine->ram_size);
+    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
+}
+
 static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
 {
     uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
@@ -1204,7 +1217,6 @@ static void machvirt_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
     int n, virt_max_cpus;
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
 
     /* We can probe only here because during property set
@@ -1361,10 +1373,6 @@ static void machvirt_init(MachineState *machine)
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
-    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
-
     create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
 
     create_gic(vms, pic);
@@ -1405,15 +1413,23 @@ static void machvirt_init(MachineState *machine)
     vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
     vms->bootinfo.get_dtb = machvirt_dtb;
     vms->bootinfo.firmware_loaded = firmware_loaded;
+
+    /* Register notifiers. They are executed in registration reverse order */
     arm_load_kernel(ARM_CPU(first_cpu), &vms->bootinfo);
 
     /*
      * arm_load_kernel machine init done notifier registration must
      * happen before the platform_bus_create call. In this latter,
      * another notifier is registered which adds platform bus nodes.
-     * Notifiers are executed in registration reverse order.
      */
     create_platform_bus(vms, pic);
+
+    /*
+     * Register memory region notifier last as this has to be executed
+     * first.
+     */
+    vms->ram_memory_region_init.notify = virt_ram_memory_region_init;
+    qemu_add_machine_init_done_notifier(&vms->ram_memory_region_init);
 }
 
 static bool virt_get_secure(Object *obj, Error **errp)
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ba0c1a4..fc24f3a 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -91,6 +91,7 @@ typedef struct {
 typedef struct {
     MachineState parent;
     Notifier machine_done;
+    Notifier ram_memory_region_init;
     FWCfgState *fw_cfg;
     bool secure;
     bool highmem;
-- 
2.7.4
