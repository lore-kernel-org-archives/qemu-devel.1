Received: from eggs.gnu.org ([2001:4830:134:3::10]:48839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLkw-0001wZ-G5
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLkv-0008QN-Jg
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:06 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Jun 2018 14:16:47 +0200
Message-Id: <20180611121655.19616-4-david@redhat.com>
In-Reply-To: <20180611121655.19616-1-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 03/11] pc: factor out pc-dimm checks into
 pc_dimm_pre_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

We can perform these checks before the device is actually realized.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f3befe6721..85c040482e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1674,6 +1674,29 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
     }
 }
 
+static void pc_dimm_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                             Error **errp)
+{
+    const PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
+
+    /*
+     * When -no-acpi is used with Q35 machine type, no ACPI is built,
+     * but pcms->acpi_dev is still created. Check !acpi_enabled in
+     * addition to cover this case.
+     */
+    if (!pcms->acpi_dev || !acpi_enabled) {
+        error_setg(errp,
+                   "memory hotplug is not enabled: missing acpi device or acpi disabled");
+        return;
+    }
+
+    if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
+        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
+        return;
+    }
+}
+
 static void pc_dimm_plug(HotplugHandler *hotplug_dev,
                          DeviceState *dev, Error **errp)
 {
@@ -1696,23 +1719,6 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
         align = memory_region_get_alignment(mr);
     }
 
-    /*
-     * When -no-acpi is used with Q35 machine type, no ACPI is built,
-     * but pcms->acpi_dev is still created. Check !acpi_enabled in
-     * addition to cover this case.
-     */
-    if (!pcms->acpi_dev || !acpi_enabled) {
-        error_setg(&local_err,
-                   "memory hotplug is not enabled: missing acpi device or acpi disabled");
-        goto out;
-    }
-
-    if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
-        error_setg(&local_err,
-                   "nvdimm is not enabled: missing 'nvdimm' in '-M'");
-        goto out;
-    }
-
     pc_dimm_memory_plug(dev, MACHINE(pcms), align, &local_err);
     if (local_err) {
         goto out;
@@ -2006,7 +2012,9 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
-    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        pc_dimm_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_pre_plug(hotplug_dev, dev, errp);
     }
 }
-- 
2.17.1
