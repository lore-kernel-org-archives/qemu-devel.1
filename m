Received: from eggs.gnu.org ([209.51.188.92]:60699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gu5Gr-00017F-DG
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 19:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gu5Gq-0005G8-3k
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 19:52:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:53677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gu5Go-0005Ce-AM
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 19:52:56 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Thu, 14 Feb 2019 08:52:25 +0800
Message-Id: <20190214005225.24048-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] i386,
 acpi: check acpi_memory_hotplug capacity in pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

Currently we do device realization like below:

   hotplug_handler_pre_plug()
   dc->realize()
   hotplug_handler_plug()

Before we do device realization and plug, we would allocate necessary
resources and check the capacity.

While we leave acpi_memory_hotplug capacity check in the last step. This
looks not comply with current architecture and does some unnecessary
work.

This patch abstract the check on acpi_memory_hotplug capacity in
pre_plug stage.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/acpi/piix4.c | 14 ++++++++++++--
 hw/i386/pc.c    |  8 ++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index e330f24c71..c97b747496 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -370,13 +370,22 @@ static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
     acpi_pm1_evt_power_down(&s->ar);
 }
 
+static void piix4_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+                                 DeviceState *dev, Error **errp)
+{
+    PIIX4PMState *s = PIIX4_PM(hotplug_dev);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
+        !s->acpi_memory_hotplug.is_enabled)
+        error_setg(errp,
+            "memory hotplug is not enabled: PIIX4 memory hotplug disabled");
+}
 static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
                                  DeviceState *dev, Error **errp)
 {
     PIIX4PMState *s = PIIX4_PM(hotplug_dev);
 
-    if (s->acpi_memory_hotplug.is_enabled &&
-        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
             nvdimm_acpi_plug_cb(hotplug_dev, dev);
         } else {
@@ -702,6 +711,7 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
      */
     dc->user_creatable = false;
     dc->hotpluggable = false;
+    hc->pre_plug = piix4_device_pre_plug_cb;
     hc->plug = piix4_device_plug_cb;
     hc->unplug_request = piix4_device_unplug_request_cb;
     hc->unplug = piix4_device_unplug_cb;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 734d3268fa..3c6eed0cd3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1662,6 +1662,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     const uint64_t legacy_align = TARGET_PAGE_SIZE;
+    HotplugHandlerClass *hhc;
 
     /*
      * When -no-acpi is used with Q35 machine type, no ACPI is built,
@@ -1674,6 +1675,13 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
+    /*
+     * Check acpi_dev memory hotplug capacity
+     */
+    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
+    if (hcc->pre_plug)
+        hhc->pre_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, errp);
+
     if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
         return;
-- 
2.19.1
