Received: from eggs.gnu.org ([2001:4830:134:3::10]:45636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTmr3-0007zV-Ja
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTmr2-0000qy-Ej
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:25:21 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 15 Jun 2018 13:24:53 +0200
Message-Id: <20180615112500.19854-6-david@redhat.com>
In-Reply-To: <20180615112500.19854-1-david@redhat.com>
References: <20180615112500.19854-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/12] pc: factor out pc specific dimm
 checks into pc_memory_pre_plug()
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f23133facc..2db032a6df 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1674,6 +1674,29 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
     }
 }
 
+static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp)
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
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
                            DeviceState *dev, Error **errp)
 {
@@ -1696,23 +1719,6 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
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
     pc_dimm_plug(dev, MACHINE(pcms), align, &local_err);
     if (local_err) {
         goto out;
@@ -2006,7 +2012,9 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
-    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        pc_memory_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_pre_plug(hotplug_dev, dev, errp);
     }
 }
-- 
2.17.1
