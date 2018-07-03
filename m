Received: from eggs.gnu.org ([208.118.235.92]:55605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faFms-0007DB-2r
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faFkc-0005J2-5Y
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:31:46 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue,  3 Jul 2018 09:19:56 +0200
Message-Id: <1530602398-16127-14-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 13/15] hw/arm/virt: Add nvdimm hot-plug
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

From: Kwangwoo Lee <kwangwoo.lee@sk.com>

Pre-plug and plug handlers are prepared for NVDIMM support.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
---
 default-configs/arm-softmmu.mak |  2 ++
 hw/arm/virt-acpi-build.c        |  6 ++++++
 hw/arm/virt.c                   | 23 +++++++++++++++++++++++
 include/hw/arm/virt.h           |  3 +++
 4 files changed, 34 insertions(+)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 28fe8f3..9f49a6a 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -153,4 +153,6 @@ CONFIG_STRONGARM=y
 CONFIG_HIGHBANK=y
 CONFIG_MUSICPAL=y
 CONFIG_MEM_HOTPLUG=y
+CONFIG_NVDIMM=y
+CONFIG_ACPI_NVDIMM=y
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0915391..f18bb5c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -804,6 +804,7 @@ static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    MachineState *ms = MACHINE(vms);
     GArray *table_offsets;
     unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
@@ -844,6 +845,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         }
     }
 
+    if (vms->acpi_nvdimm_state.is_enabled) {
+        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
+                          &vms->acpi_nvdimm_state, ms->ram_slots);
+    }
+
     if (its_class_name() && !vmc->no_its) {
         acpi_add_table(table_offsets, tables_blob);
         build_iort(tables_blob, tables->linker, vms);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7190962..51f42cd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -135,6 +135,7 @@ static const MemMapEntry a15memmap[] = {
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
+    [VIRT_ACPI_IO] =            { 0x09070000, 0x00010000 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -1607,6 +1608,18 @@ static void machvirt_init(MachineState *machine)
 
     create_platform_bus(vms, pic);
 
+    if (vms->acpi_nvdimm_state.is_enabled) {
+        AcpiNVDIMMState *acpi_nvdimm_state = &vms->acpi_nvdimm_state;
+
+        acpi_nvdimm_state->dsm_io.type = NVDIMM_ACPI_IO_MEMORY;
+        acpi_nvdimm_state->dsm_io.base =
+                vms->memmap[VIRT_ACPI_IO].base + NVDIMM_ACPI_IO_BASE;
+        acpi_nvdimm_state->dsm_io.len = NVDIMM_ACPI_IO_LEN;
+
+        nvdimm_init_acpi_state(acpi_nvdimm_state, sysmem,
+                               vms->fw_cfg, OBJECT(vms));
+    }
+
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.kernel_filename = machine->kernel_filename;
     vms->bootinfo.kernel_cmdline = machine->kernel_cmdline;
@@ -1801,9 +1814,11 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 static void virt_memory_plug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
+    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     Error *local_err = NULL;
     uint64_t align;
 
@@ -1815,7 +1830,15 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
     }
 
     pc_dimm_plug(dev, MACHINE(hotplug_dev), align, &local_err);
+    if (local_err) {
+        goto out;
+    }
 
+    if (is_nvdimm) {
+        nvdimm_plug(&vms->acpi_nvdimm_state);
+    }
+
+out:
     error_propagate(errp, local_err);
 }
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 173938d..2cabdbe 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -37,6 +37,7 @@
 #include "hw/arm/arm.h"
 #include "sysemu/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/mem/nvdimm.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -79,6 +80,7 @@ enum {
     VIRT_SECURE_UART,
     VIRT_SECURE_MEM,
     VIRT_HOTPLUG_MEM,
+    VIRT_ACPI_IO,
 };
 
 typedef enum VirtIOMMUType {
@@ -128,6 +130,7 @@ typedef struct {
     char *kvm_type;
     int32_t max_vm_phys_shift;
     int32_t source_max_vm_phys_shift;
+    AcpiNVDIMMState acpi_nvdimm_state;
 } VirtMachineState;
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_PCIE_ECAM_HIGH : VIRT_PCIE_ECAM)
-- 
2.5.5
