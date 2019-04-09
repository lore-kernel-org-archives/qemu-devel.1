Received: from eggs.gnu.org ([209.51.188.92]:47699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo1t-00062Y-V8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo1s-0007HT-OX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:01 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Tue, 9 Apr 2019 11:29:28 +0100
Message-ID: <20190409102935.28292-2-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 1/8] hw/acpi: Make ACPI IO address space
 configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com, imammedo@redhat.com
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com, xuwei5@hisilicon.com, lersek@redhat.com, ard.biesheuvel@linaro.org, linuxarm@huawei.com

This is in preparation for adding support for ARM64 platforms
where it doesn't use port mapped IO for ACPI IO space.

Also move few MEMORY_* definitions to header so that other memory
hotplug event signalling mechanisms (eg. Generic Event Device on
HW-reduced acpi platforms) can use the same from their respective
event handler code.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/memory_hotplug.c         | 25 ++++++++++++++-----------
 hw/i386/acpi-build.c             |  3 ++-
 include/hw/acpi/memory_hotplug.h |  9 +++++++--
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 297812d..c724f5f 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -29,12 +29,9 @@
 #define MEMORY_SLOT_PROXIMITY_METHOD "MPXM"
 #define MEMORY_SLOT_EJECT_METHOD     "MEJ0"
 #define MEMORY_SLOT_NOTIFY_METHOD    "MTFY"
-#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
 #define MEMORY_HOTPLUG_DEVICE        "MHPD"
-#define MEMORY_HOTPLUG_IO_LEN         24
-#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
 
-static uint16_t memhp_io_base;
+static hwaddr memhp_io_base;
 
 static ACPIOSTInfo *acpi_memory_device_status(int slot, MemStatus *mdev)
 {
@@ -209,7 +206,7 @@ static const MemoryRegionOps acpi_memory_hotplug_ops = {
 };
 
 void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
-                              MemHotplugState *state, uint16_t io_base)
+                              MemHotplugState *state, hwaddr io_base)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
 
@@ -342,7 +339,8 @@ const VMStateDescription vmstate_memory_hotplug = {
 
 void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
                               const char *res_root,
-                              const char *event_handler_method)
+                              const char *event_handler_method,
+                              AmlRegionSpace rs)
 {
     int i;
     Aml *ifctx;
@@ -365,14 +363,19 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
             aml_name_decl("_UID", aml_string("Memory hotplug resources")));
 
         crs = aml_resource_template();
-        aml_append(crs,
-            aml_io(AML_DECODE16, memhp_io_base, memhp_io_base, 0,
-                   MEMORY_HOTPLUG_IO_LEN)
-        );
+        if (rs == AML_SYSTEM_IO) {
+            aml_append(crs,
+                aml_io(AML_DECODE16, memhp_io_base, memhp_io_base, 0,
+                       MEMORY_HOTPLUG_IO_LEN)
+            );
+        } else {
+            aml_append(crs, aml_memory32_fixed(memhp_io_base,
+                            MEMORY_HOTPLUG_IO_LEN, AML_READ_WRITE));
+        }
         aml_append(mem_ctrl_dev, aml_name_decl("_CRS", crs));
 
         aml_append(mem_ctrl_dev, aml_operation_region(
-            MEMORY_HOTPLUG_IO_REGION, AML_SYSTEM_IO,
+            MEMORY_HOTPLUG_IO_REGION, rs,
             aml_int(memhp_io_base), MEMORY_HOTPLUG_IO_LEN)
         );
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 416da31..6d6de44 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1852,7 +1852,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
                        "\\_SB.PCI0", "\\_GPE._E02");
     }
-    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0", "\\_GPE._E03");
+    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0",
+                             "\\_GPE._E03", AML_SYSTEM_IO);
 
     scope =  aml_scope("_GPE");
     {
diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
index 77c6576..e3a4b89 100644
--- a/include/hw/acpi/memory_hotplug.h
+++ b/include/hw/acpi/memory_hotplug.h
@@ -5,6 +5,10 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 
+#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
+#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
+#define MEMORY_HOTPLUG_IO_LEN         24
+
 /**
  * MemStatus:
  * @is_removing: the memory device in slot has been requested to be ejected.
@@ -29,7 +33,7 @@ typedef struct MemHotplugState {
 } MemHotplugState;
 
 void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
-                              MemHotplugState *state, uint16_t io_base);
+                              MemHotplugState *state, hwaddr io_base);
 
 void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
                          DeviceState *dev, Error **errp);
@@ -48,5 +52,6 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
 
 void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
                               const char *res_root,
-                              const char *event_handler_method);
+                              const char *event_handler_method,
+                              AmlRegionSpace rs);
 #endif
-- 
2.7.4
