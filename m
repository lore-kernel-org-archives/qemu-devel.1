Received: from eggs.gnu.org ([2001:4830:134:3::10]:51669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRqs8-00034X-N5
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRqs7-00046m-UJ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:50:44 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 28 Nov 2018 20:12:51 +0800
Message-Id: <1543407172-16175-9-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V10 8/9] hw/misc/pvpanic: realize the configure
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
 hw/arm/virt-acpi-build.c | 5 ++++-
 hw/arm/virt.c            | 7 +++----
 hw/misc/pvpanic.c        | 1 +
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 2adba60..d29d229 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -45,6 +45,7 @@
 #include "hw/arm/virt.h"
 #include "sysemu/numa.h"
 #include "kvm_arm.h"
+#include "hw/misc/pvpanic.h"
 
 #define ARM_SPI_BASE 32
 #define ACPI_POWER_BUTTON_DEVICE "PWRB"
@@ -785,7 +786,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
index 1fd5941..9cddf36 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -198,8 +198,6 @@ static void create_pvpanic_device(const VirtMachineState *vms)
      hwaddr base = vms->memmap[VIRT_PVPANIC].base;
      hwaddr size = vms->memmap[VIRT_PVPANIC].size;
 
-     sysbus_create_simple(TYPE_PVPANIC_MMIO, base, NULL);
-
      nodename = g_strdup_printf("/pvpanic-mmio@%" PRIx64, base);
      qemu_fdt_add_subnode(vms->fdt, nodename);
      qemu_fdt_setprop_string(vms->fdt, nodename,
@@ -1330,6 +1328,9 @@ void virt_machine_done(Notifier *notifier, void *data)
     struct arm_boot_info *info = &vms->bootinfo;
     AddressSpace *as = arm_boot_address_space(cpu, info);
 
+    if (pvpanic_mmio()) {
+        create_pvpanic_device(vms);
+    }
     /*
      * If the user provided a dtb, we assume the dynamic sysbus nodes
      * already are integrated there. This corresponds to a use case where
@@ -1551,8 +1552,6 @@ static void machvirt_init(MachineState *machine)
 
     create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
 
-    create_pvpanic_device(vms);
-
     create_gic(vms, pic);
 
     fdt_add_pmu_nodes(vms);
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index b6b5c89..6c4a79f 100644
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
