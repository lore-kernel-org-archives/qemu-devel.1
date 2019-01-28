Received: from eggs.gnu.org ([209.51.188.92]:56126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1go4l0-0003t3-9h
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1go4kx-00049s-Om
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:07:14 -0500
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Mon, 28 Jan 2019 11:05:44 +0000
Message-ID: <20190128110545.20644-3-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20190128110545.20644-1-shameerali.kolothum.thodi@huawei.com>
References: <20190128110545.20644-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 2/4] hw/arm/virt: Add GPIO based pcdimm
 hotplug ACPI event support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger@redhat.com, shannon.zhaosl@gmail.com, peter.maydell@linaro.org, imammedo@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: xuwei5@huawei.com, linuxarm@huawei.com

This adds support for using PL061 GPIO controller pin to trigger
pcdimm hotplug event to guest.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 default-configs/arm-softmmu.mak |  1 +
 hw/arm/virt-acpi-build.c        | 28 ++++++++++++++++++++++++----
 hw/arm/virt.c                   | 37 +++++++++++++++++++++++++++++++++----
 include/hw/arm/virt.h           | 14 ++++++++++++++
 4 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 5deabc1..ebbc67b 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -163,3 +163,4 @@ CONFIG_MEM_DEVICE=y
 CONFIG_DIMM=y
 CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
+CONFIG_ACPI_MEMORY_HOTPLUG=y
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index ab30e28..eedd323 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -40,6 +40,7 @@
 #include "hw/loader.h"
 #include "hw/hw.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/memory_hotplug.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/arm/virt.h"
@@ -327,8 +328,10 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
 }
 
 static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
-                                           uint32_t gpio_irq)
+                               uint32_t gpio_irq, VirtMachineState *vms)
 {
+    uint32_t pin_list[1];
+
     Aml *dev = aml_device("GPO0");
     aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0061")));
     aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
@@ -342,11 +345,21 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
     aml_append(dev, aml_name_decl("_CRS", crs));
 
     Aml *aei = aml_resource_template();
-    /* Pin 3 for power button */
-    const uint32_t pin_list[1] = {3};
+
+    /* GPIO Interrupt connection descriptor for power button */
+    pin_list[0] = GPIO_PWRB;
     aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
                                  AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
                                  "GPO0", NULL, 0));
+
+    if (vms->acpi_memhp_state.is_enabled) {
+        /* GPIO Interrupt connection descriptor for pc-dimm hotplug */
+        pin_list[0] = GPIO_PCDIMM;
+        aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
+                                     AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list,
+                                     1, "GPO0", NULL, 0));
+    }
+
     aml_append(dev, aml_name_decl("_AEI", aei));
 
     /* _E03 is handle for power button */
@@ -735,6 +748,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     Aml *scope, *dsdt;
     const MemMapEntry *memmap = vms->memmap;
     const int *irqmap = vms->irqmap;
+    MachineState *ms = MACHINE(vms);
+    uint32_t nr_mem = ms->ram_slots;
 
     dsdt = init_aml_allocator();
     /* Reserve space for header */
@@ -756,11 +771,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] + ARM_SPI_BASE),
                       vms->highmem, vms->highmem_ecam);
     acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
-                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
+                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE), vms);
     acpi_dsdt_add_power_button(scope);
 
     aml_append(dsdt, scope);
 
+    if (vms->acpi_memhp_state.is_enabled) {
+        build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.GPO0",
+                                 "\\_SB.GPO0._E02", AML_SYSTEM_MEMORY);
+    }
+
     /* copy AML table into ACPI tables blob and patch header there */
     g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
     build_header(linker, table_data,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8c6dd59..884960d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -173,6 +173,9 @@ static const char *valid_cpus[] = {
     ARM_CPU_TYPE_NAME("max"),
 };
 
+static QLIST_HEAD(, GPIODevice) gpio_devices =
+    QLIST_HEAD_INITIALIZER(gpio_devices);
+
 static bool cpu_type_valid(const char *cpu)
 {
     int i;
@@ -740,11 +743,34 @@ static void create_rtc(const VirtMachineState *vms, qemu_irq *pic)
     g_free(nodename);
 }
 
-static DeviceState *gpio_key_dev;
+static DeviceState *virt_get_gpio_dev(int pin)
+{
+    GPIODevice *gpio_dev;
+
+    QLIST_FOREACH(gpio_dev, &gpio_devices, next) {
+        if (pin == gpio_dev->pin_num) {
+            return gpio_dev->dev;
+        }
+    }
+    return NULL;
+}
+
+static void virt_create_gpio_dev(DeviceState *pl061_dev, int pin)
+{
+    GPIODevice *gpio_dev;
+
+    gpio_dev = g_malloc0(sizeof(*gpio_dev));
+    gpio_dev->dev = sysbus_create_simple("gpio-key", -1,
+                                          qdev_get_gpio_in(pl061_dev, pin));
+    gpio_dev->pin_num = pin;
+    QLIST_INSERT_HEAD(&gpio_devices, gpio_dev, next);
+}
+
 static void virt_powerdown_req(Notifier *n, void *opaque)
 {
+    DeviceState *dev = virt_get_gpio_dev(GPIO_PWRB);
     /* use gpio Pin 3 for power button event */
-    qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
+    qemu_set_irq(qdev_get_gpio_in(dev, 0), 1);
 }
 
 static Notifier virt_system_powerdown_notifier = {
@@ -777,8 +803,11 @@ static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
     qemu_fdt_setprop_string(vms->fdt, nodename, "clock-names", "apb_pclk");
     qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", phandle);
 
-    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
-                                        qdev_get_gpio_in(pl061_dev, 3));
+    virt_create_gpio_dev(pl061_dev, GPIO_PWRB);
+
+    if (vms->acpi_memhp_state.is_enabled) {
+        virt_create_gpio_dev(pl061_dev, GPIO_PCDIMM);
+    }
     qemu_fdt_add_subnode(vms->fdt, "/gpio-keys");
     qemu_fdt_setprop_string(vms->fdt, "/gpio-keys", "compatible", "gpio-keys");
     qemu_fdt_setprop_cell(vms->fdt, "/gpio-keys", "#size-cells", 0);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 6bb7f92..ef39ce6 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -38,6 +38,7 @@
 #include "sysemu/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/acpi/memory_hotplug.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -136,8 +137,21 @@ typedef struct {
     hwaddr high_io_base;
     bool extended_memmap;
     AcpiNVDIMMState acpi_nvdimm_state;
+    MemHotplugState acpi_memhp_state;
 } VirtMachineState;
 
+/* GPIO pins for ACPI events */
+enum {
+    GPIO_PCDIMM = 2,
+    GPIO_PWRB,
+};
+
+typedef struct GPIODevice {
+    DeviceState *dev;
+    int pin_num;
+    QLIST_ENTRY(GPIODevice) next;
+} GPIODevice;
+
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
 
 #define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
-- 
2.7.4
