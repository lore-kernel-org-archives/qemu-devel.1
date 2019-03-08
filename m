Received: from eggs.gnu.org ([209.51.188.92]:40697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1h2Dw0-0000Bi-Hv
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1h2Dvx-0007lq-9U
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:45:03 -0500
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Fri, 8 Mar 2019 11:42:18 +0000
Message-ID: <20190308114218.26692-12-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20190308114218.26692-1-shameerali.kolothum.thodi@huawei.com>
References: <20190308114218.26692-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 11/11] hw/arm/virt: Add GED irq routing and
 Enable memory hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com
Cc: linuxarm@huawei.com, xuwei5@hisilicon.com

Adds GED irq routing to guest and enables memory hotplug.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/virt-acpi.c    | 27 +++++++++++++++++++++++++--
 hw/arm/virt.c         | 17 +++++++++++------
 include/hw/arm/virt.h |  3 ++-
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt-acpi.c b/hw/arm/virt-acpi.c
index 3b55c63..c5a9311 100644
--- a/hw/arm/virt-acpi.c
+++ b/hw/arm/virt-acpi.c
@@ -32,6 +32,7 @@ typedef struct VirtAcpiState {
     SysBusDevice parent_obj;
     MemHotplugState memhp_state;
     GEDState ged_state;
+    qemu_irq *gsi;
 } VirtAcpiState;
 
 #define TYPE_VIRT_ACPI "virt-acpi"
@@ -71,6 +72,21 @@ static void virt_device_unplug_cb(HotplugHandler *hotplug_dev,
 
 static void virt_send_ged(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
 {
+    VirtAcpiState *s = VIRT_ACPI(adev);
+    uint32_t sel = ACPI_GED_IRQ_SEL_INIT;
+
+    if (ev & ACPI_MEMORY_HOTPLUG_STATUS) {
+        sel = ACPI_GED_IRQ_SEL_MEM;
+    } else {
+        /* Unknown event. Return without generating interrupt. */
+        return;
+    }
+
+    /*
+     * We inject the hotplug interrupt. The IRQ selector will make
+     * the difference from the ACPI table.
+     */
+    acpi_ged_event(&s->ged_state, s->gsi, sel);
 }
 
 static void virt_device_realize(DeviceState *dev, Error **errp)
@@ -89,9 +105,16 @@ static void virt_device_realize(DeviceState *dev, Error **errp)
     }
 }
 
-DeviceState *virt_acpi_init(void)
+DeviceState *virt_acpi_init(qemu_irq *gsi)
 {
-    return sysbus_create_simple(TYPE_VIRT_ACPI, -1, NULL);
+    DeviceState *dev;
+    VirtAcpiState *s;
+
+    dev = sysbus_create_simple(TYPE_VIRT_ACPI, -1, NULL);
+    s = VIRT_ACPI(dev);
+    s->gsi = gsi;
+
+    return dev;
 }
 
 static Property virt_acpi_properties[] = {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 352dbb1..fa352c5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -577,6 +577,12 @@ static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
     fdt_add_v2m_gic_node(vms);
 }
 
+static void virt_gsi_handler(void *opaque, int n, int level)
+{
+    qemu_irq *gic_irq = opaque;
+    qemu_set_irq(gic_irq[n], level);
+}
+
 static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 {
     /* We create a standalone GIC */
@@ -692,6 +698,8 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
         pic[i] = qdev_get_gpio_in(gicdev, i);
     }
 
+    vms->gsi = qemu_allocate_irqs(virt_gsi_handler, pic, NUM_IRQS);
+
     fdt_add_gic_node(vms);
 
     if (type == 3 && vms->its) {
@@ -1444,7 +1452,7 @@ static void machvirt_init(MachineState *machine)
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *possible_cpus;
-    qemu_irq pic[NUM_IRQS];
+    qemu_irq *pic;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
     int n, virt_max_cpus;
@@ -1640,6 +1648,7 @@ static void machvirt_init(MachineState *machine)
 
     create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
 
+    pic = g_new0(qemu_irq, NUM_IRQS);
     create_gic(vms, pic);
 
     fdt_add_pmu_nodes(vms);
@@ -1670,7 +1679,7 @@ static void machvirt_init(MachineState *machine)
 
     create_platform_bus(vms, pic);
 
-    vms->acpi = virt_acpi_init();
+    vms->acpi = virt_acpi_init(vms->gsi);
     virt_acpi_ged_conf(vms);
 
     vms->bootinfo.ram_size = machine->ram_size;
@@ -1842,10 +1851,6 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    if (dev->hotplugged) {
-        error_setg(errp, "memory hotplug is not supported");
-    }
-
     if (is_nvdimm) {
         error_setg(errp, "nvdimm is not yet supported");
         return;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 49fda81..30ff460 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -136,6 +136,7 @@ typedef struct {
     int psci_conduit;
     hwaddr highest_gpa;
     DeviceState *acpi;
+    qemu_irq *gsi;
     GedEvent *ged_events;
     uint32_t ged_events_size;
 } VirtMachineState;
@@ -151,7 +152,7 @@ typedef struct {
     OBJECT_CLASS_CHECK(VirtMachineClass, klass, TYPE_VIRT_MACHINE)
 
 void virt_acpi_setup(VirtMachineState *vms);
-DeviceState *virt_acpi_init(void);
+DeviceState *virt_acpi_init(qemu_irq *gsi);
 
 /* Return the number of used redistributor regions  */
 static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
-- 
2.7.4
