Received: from eggs.gnu.org ([2001:4830:134:3::10]:46242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa2YT-0000fd-Vw
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa2YP-000766-0s
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:24:01 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  2 Jul 2018 19:22:42 +0200
Message-Id: <1530552162-15533-16-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1530552162-15533-1-git-send-email-eric.auger@redhat.com>
References: <1530552162-15533-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 15/15] hw/arm/virt: Add nvdimm and
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
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

Machine option nvdimm allows to turn NVDIMM support on.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 51f42cd..13e6dec 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1762,6 +1762,47 @@ static void virt_set_kvm_type(Object *obj, const char *value, Error **errp)
     vms->kvm_type = g_strdup(value);
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
@@ -1804,10 +1845,10 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                  Error **errp)
 {
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
 
-    if (is_nvdimm) {
-        error_setg(errp, "nvdimm is not yet supported");
-        return;
+    if (is_nvdimm && !vms->acpi_nvdimm_state.is_enabled) {
+        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
     }
 }
 
@@ -2044,6 +2085,19 @@ static void virt_3_0_instance_init(Object *obj)
     object_property_add_str(obj, "kvm-type",
                             virt_get_kvm_type, virt_set_kvm_type, NULL);
 
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
2.5.5
