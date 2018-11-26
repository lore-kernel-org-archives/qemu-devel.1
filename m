Received: from eggs.gnu.org ([2001:4830:134:3::10]:56939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRF8p-0000UC-ID
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:33:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRF8m-00023G-DE
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:33:27 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Tue, 27 Nov 2018 03:56:01 +0800
Message-Id: <1543262162-6351-9-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543262162-6351-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543262162-6351-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V9 8/9] hw/misc/pvpanic: realize the configure
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

Add configure interface for pvpanic-mmio. In qemu command line
use -device pvpanic-mmio to enable the device.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/arm/virt-acpi-build.c | 4 +++-
 hw/arm/virt.c            | 9 ++++-----
 hw/misc/pvpanic.c        | 1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 2adba60..50cea23 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -785,7 +785,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
                        (irqmap[VIRT_UART] + ARM_SPI_BASE));
     acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
-    acpi_dsdt_add_pvpanic(scope, &memmap[VIRT_PVPANIC]);
+    if (pvpanic_mmio()) {
+        acpi_dsdt_add_pvpanic(scope, &memmap[VIRT_PVPANIC]);
+    }
     acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
     acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
                     (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bb756a6..fcaa597 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -197,8 +197,6 @@ static void create_pvpanic_device(const VirtMachineState *vms)
      hwaddr base = vms->memmap[VIRT_PVPANIC].base;
      hwaddr size = vms->memmap[VIRT_PVPANIC].size;
 
-     sysbus_create_simple(TYPE_PVPANIC_MMIO, base, NULL);
-
      nodename = g_strdup_printf("/pvpanic-mmio@%" PRIx64, base);
      qemu_fdt_add_subnode(vms->fdt, nodename);
      qemu_fdt_setprop_string(vms->fdt, nodename,
@@ -1329,6 +1327,9 @@ void virt_machine_done(Notifier *notifier, void *data)
     struct arm_boot_info *info = &vms->bootinfo;
     AddressSpace *as = arm_boot_address_space(cpu, info);
 
+    if (pvpanic_mmio()) {
+        create_pvpanic_device(vms);
+    }
     /*
      * If the user provided a dtb, we assume the dynamic sysbus nodes
      * already are integrated there. This corresponds to a use case where
@@ -1548,9 +1549,7 @@ static void machvirt_init(MachineState *machine)
                                          machine->ram_size);
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
 
-    create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
-
-    create_pvpanic_device(vms);
+    create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
 
     create_gic(vms, pic);
 
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 08263ed..f199173 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -149,6 +149,7 @@ static void pvpanic_mmio_initfn(Object *obj)
     memory_region_init_io(&s->mr, OBJECT(s), &pvpanic_ops, s,
                           TYPE_PVPANIC_MMIO, 2);
     sysbus_init_mmio(sbd, &s->mr);
+    sysbus_mmio_map(sbd, 0, s->base);
 }
 
 static Property pvpanic_mmio_properties[] = {
-- 
1.8.3.1
