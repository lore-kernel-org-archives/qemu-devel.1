Received: from eggs.gnu.org ([2001:4830:134:3::10]:36640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9Ln-0006cy-Cl
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9Lm-0008PL-ER
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:32:35 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 18 Oct 2018 16:30:42 +0200
Message-Id: <20181018143042.29588-17-eric.auger@redhat.com>
In-Reply-To: <20181018143042.29588-1-eric.auger@redhat.com>
References: <20181018143042.29588-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 16/16] hw/arm/virt: Add nvdimm and
 nvdimm-persistence options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: drjones@redhat.com, dgilbert@redhat.com, Suzuki.Poulose@arm.com

Machine option nvdimm allows to turn NVDIMM support on.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d84d5a5841..02fb62595e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1748,6 +1748,47 @@ static void virt_set_iommu(Object *obj, const char *value, Error **errp)
     }
 }
 
+static bool virt_get_nvdimm(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->acpi_nvdimm_state.is_enabled;
+}
+
+static void virt_set_nvdimm(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->acpi_nvdimm_state.is_enabled = value;
+}
+
+static char *virt_get_nvdimm_persistence(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return g_strdup(vms->acpi_nvdimm_state.persistence_string);
+}
+
+static void virt_set_nvdimm_persistence(Object *obj, const char *value,
+                                        Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    AcpiNVDIMMState *nvdimm_state = &vms->acpi_nvdimm_state;
+
+    if (strcmp(value, "cpu") == 0)
+        nvdimm_state->persistence = 3;
+    else if (strcmp(value, "mem-ctrl") == 0)
+        nvdimm_state->persistence = 2;
+    else {
+        error_report("-machine nvdimm-persistence=%s: unsupported option",
+                     value);
+        exit(EXIT_FAILURE);
+    }
+
+    g_free(nvdimm_state->persistence_string);
+    nvdimm_state->persistence_string = g_strdup(value);
+}
+
 static CpuInstanceProperties
 virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 {
@@ -1790,13 +1831,14 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                  Error **errp)
 {
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
 
     if (dev->hotplugged) {
         error_setg(errp, "memory hotplug is not supported");
     }
 
-    if (is_nvdimm) {
-        error_setg(errp, "nvdimm is not yet supported");
+    if (is_nvdimm && !vms->acpi_nvdimm_state.is_enabled) {
+        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
         return;
     }
 
@@ -2025,6 +2067,19 @@ static void virt_3_2_instance_init(Object *obj)
                                     "Valid values are none and smmuv3",
                                     NULL);
 
+    object_property_add_bool(obj, "nvdimm",
+                             virt_get_nvdimm, virt_set_nvdimm, NULL);
+    object_property_set_description(obj, "nvdimm",
+                                         "Set on/off to enable/disable NVDIMM "
+                                         "instantiation", NULL);
+
+    object_property_add_str(obj, "nvdimm-persistence",
+                            virt_get_nvdimm_persistence,
+                            virt_set_nvdimm_persistence, NULL);
+    object_property_set_description(obj, "nvdimm-persistence",
+                                    "Set NVDIMM persistence"
+                                    "Valid values are cpu and mem-ctrl", NULL);
+
     vms->memmap = a15memmap;
     vms->irqmap = a15irqmap;
 }
-- 
2.17.1
