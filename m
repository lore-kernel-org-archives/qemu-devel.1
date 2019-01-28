Received: from eggs.gnu.org ([209.51.188.92]:57060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1go4oe-00076t-19
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1go4od-0005zT-1R
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:11:00 -0500
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Mon, 28 Jan 2019 11:10:31 +0000
Message-ID: <20190128111031.6176-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 4/4] hw/arm/virt: Add nvdimm hotplug support
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

nvdimm hotplug is enabled using GPIO(Pin 4) based ACPI
event. Hot removal functionality is not yet supported.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/virt-acpi-build.c | 17 +++++++++++++++++
 hw/arm/virt.c            | 29 ++++++++++++++++++-----------
 include/hw/arm/virt.h    |  1 +
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index eedd323..132414c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -360,6 +360,14 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
                                      1, "GPO0", NULL, 0));
     }
 
+    if (vms->acpi_nvdimm_state.is_enabled) {
+        /* GPIO Interrupt connection descriptor for NVDIMM hotplug */
+        pin_list[0] = GPIO_NVDIMM;
+        aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
+                                     AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list,
+                                     1, "GPO0", NULL, 0));
+    }
+
     aml_append(dev, aml_name_decl("_AEI", aei));
 
     /* _E03 is handle for power button */
@@ -367,6 +375,15 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
     aml_append(method, aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
                                   aml_int(0x80)));
     aml_append(dev, method);
+
+    if (vms->acpi_nvdimm_state.is_enabled) {
+        /* _E04 is for nvdimm hotplug*/
+        method = aml_method("_E04", 0, AML_NOTSERIALIZED);
+        aml_append(method, aml_notify(aml_name("\\_SB.NVDR"),
+                                      aml_int(0x80)));
+        aml_append(dev, method);
+    }
+
     aml_append(scope, dev);
 }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cf64554..71e7886 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -809,6 +809,11 @@ static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
     if (vms->acpi_memhp_state.is_enabled) {
         virt_create_gpio_dev(pl061_dev, GPIO_PCDIMM);
     }
+
+    if (vms->acpi_nvdimm_state.is_enabled) {
+        virt_create_gpio_dev(pl061_dev, GPIO_NVDIMM);
+    }
+
     qemu_fdt_add_subnode(vms->fdt, "/gpio-keys");
     qemu_fdt_setprop_string(vms->fdt, "/gpio-keys", "compatible", "gpio-keys");
     qemu_fdt_setprop_cell(vms->fdt, "/gpio-keys", "#size-cells", 0);
@@ -1885,10 +1890,6 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
 
-    if (dev->hotplugged && is_nvdimm) {
-        error_setg(errp, "nvdimm hotplug is not supported");
-    }
-
     if (is_nvdimm && !vms->acpi_nvdimm_state.is_enabled) {
         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
         return;
@@ -1898,19 +1899,25 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 }
 
 static void virt_memhp_send_event(HotplugHandler *hotplug_dev, DeviceState *dev,
-                                  Error **errp)
+                                  bool is_nvdimm, Error **errp)
 {
     DeviceState *gpio_dev;
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
 
-    gpio_dev = virt_get_gpio_dev(GPIO_PCDIMM);
+    gpio_dev = (is_nvdimm) ? virt_get_gpio_dev(GPIO_NVDIMM) :
+                            virt_get_gpio_dev(GPIO_PCDIMM);
     if (!gpio_dev) {
         error_setg(errp, "No dev interface to send hotplug event");
         return;
     }
-    acpi_memory_plug_cb(hotplug_dev, &vms->acpi_memhp_state,
-                        dev, errp);
-    qemu_set_irq(qdev_get_gpio_in(gpio_dev, 0), 1);
+
+    if (is_nvdimm) {
+        qemu_set_irq(qdev_get_gpio_in(gpio_dev, 0), 1);
+    } else {
+        acpi_memory_plug_cb(hotplug_dev, &vms->acpi_memhp_state,
+                            dev, errp);
+        qemu_set_irq(qdev_get_gpio_in(gpio_dev, 0), 1);
+    }
 }
 
 static void virt_memory_plug(HotplugHandler *hotplug_dev,
@@ -1929,8 +1936,8 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
         nvdimm_plug(&vms->acpi_nvdimm_state);
     }
 
-    if (dev->hotplugged && !is_nvdimm) {
-        virt_memhp_send_event(hotplug_dev, dev, errp);
+    if (dev->hotplugged) {
+        virt_memhp_send_event(hotplug_dev, dev, is_nvdimm, errp);
     }
 
 out:
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ef39ce6..70ee2f2 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -144,6 +144,7 @@ typedef struct {
 enum {
     GPIO_PCDIMM = 2,
     GPIO_PWRB,
+    GPIO_NVDIMM,
 };
 
 typedef struct GPIODevice {
-- 
2.7.4
