Received: from eggs.gnu.org ([209.51.188.92]:34104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvXVq-0008BK-HO
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 20:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvXVp-000261-Ci
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 20:14:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:59067)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gvXVp-00021u-3L
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 20:14:25 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Mon, 18 Feb 2019 09:13:33 +0800
Message-Id: <20190218011333.13976-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] i386,
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
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com, Wei Yang <richardw.yang@linux.intel.com>, Eric Blake <eblake@redhat.com>

Currently we do device realization like below:

   hotplug_handler_pre_plug()
   dc->realize()
   hotplug_handler_plug()

Before we do device realization and plug, we should allocate necessary
resources and check if memory-hotplug-support property is enabled.

At the piix4 and ich9, the acpi_memory_hotplug property is checked in
plug stage. This means that device has been realized and mapped into
guest address space 'pc_dimm_plug()' by the time acpi plug handler is
called, where it might fail and crash QEMU due to reaching
g_assert_not_reached() (piix4) or error_abort (ich9).

This patch abstract the check on acpi_memory_hotplug capacity in
pre_plug stage.

[changelog rephrase from imammedo@redhat.com]

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
CC: Igor Mammedov <imammedo@redhat.com>
CC: Eric Blake <eblake@redhat.com>

---
v2:
   * rephrase change log
   * apply this change to ich9
   * use hotplug_handler_pre_plug() instead of open-coding check
---
 hw/acpi/ich9.c         | 14 ++++++++++++--
 hw/acpi/piix4.c        | 14 ++++++++++++--
 hw/i386/pc.c           |  5 +++++
 hw/isa/lpc_ich9.c      |  1 +
 include/hw/acpi/ich9.h |  2 ++
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index c5d8646abc..906a10f09a 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -483,13 +483,23 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
                              NULL);
 }
 
+void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                            Error **errp)
+{
+    ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
+        !lpc->pm.acpi_memory_hotplug.is_enabled)
+        error_setg(errp,
+            "memory hotplug is not enabled: ICH9 memory hotplug disabled");
+}
+
 void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
 
-    if (lpc->pm.acpi_memory_hotplug.is_enabled &&
-        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
             nvdimm_acpi_plug_cb(hotplug_dev, dev);
         } else {
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
index 734d3268fa..59c8ccf0ff 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1674,6 +1674,11 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
+    /*
+     * Check acpi_dev memory-hotplug-support property
+     */
+    hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
+
     if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
         return;
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index e692b9fdc1..ac44aa53be 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -805,6 +805,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
      * pc_q35_init()
      */
     dc->user_creatable = false;
+    hc->pre_plug = ich9_pm_device_pre_plug_cb;
     hc->plug = ich9_pm_device_plug_cb;
     hc->unplug_request = ich9_pm_device_unplug_request_cb;
     hc->unplug = ich9_pm_device_unplug_cb;
diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 59aeb06393..428af0b0be 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -74,6 +74,8 @@ extern const VMStateDescription vmstate_ich9_pm;
 
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp);
 
+void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                            Error **errp);
 void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp);
 void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
-- 
2.19.1
