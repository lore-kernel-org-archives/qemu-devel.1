Received: from eggs.gnu.org ([209.51.188.92]:50226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gy4kV-00051M-7H
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 20:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gy4kK-0007Bp-4S
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 20:07:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:16168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gy4kD-00073J-GK
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 20:07:47 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Mon, 25 Feb 2019 09:07:08 +0800
Message-Id: <20190225010708.27385-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5] i386,
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
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com, eblake@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

Currently we do device realization like below:

   hotplug_handler_pre_plug()
   dc->realize()
   hotplug_handler_plug()

Before we do device realization and plug, we should allocate necessary
resources and check if memory-hotplug-support property is enabled.

At the piix4 and ich9, the memory-hotplug-support property is checked at
plug stage. This means that device has been realized and mapped into guest
address space 'pc_dimm_plug()' by the time acpi plug handler is called,
where it might fail and crash QEMU due to reaching g_assert_not_reached()
(piix4) or error_abort (ich9).

Fix it by checking if memory hotplug is enabled at pre_plug stage
where we can gracefully abort hotplug request.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
CC: Igor Mammedov <imammedo@redhat.com>
CC: Eric Blake <eblake@redhat.com>
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
v5:
   * rebase on latest upstream
   * remove a comment before hotplug_handler_pre_plug
   * fix alignment for ich9_pm_device_pre_plug_cb
v4:
   * fix code alignment of piix4_device_pre_plug_cb
v3:
   * replace acpi_memory_hotplug with memory-hotplug-support in changelog
   * fix code alignment of ich9_pm_device_pre_plug_cb
   * print which device type memory-hotplug-support is disabled in
     ich9_pm_device_pre_plug_cb and piix4_device_pre_plug_cb
v2:
   * (imammedo@redhat.com)
     - Almost the whole third paragraph
   * apply this change to ich9
   * use hotplug_handler_pre_plug() instead of open-coding check
---
 hw/acpi/ich9.c         | 15 +++++++++++++--
 hw/acpi/piix4.c        | 13 ++++++++++---
 hw/i386/pc.c           |  2 ++
 hw/isa/lpc_ich9.c      |  1 +
 include/hw/acpi/ich9.h |  2 ++
 5 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index c5d8646abc..e53dfe1ee3 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -483,13 +483,24 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
                              NULL);
 }
 
+void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                Error **errp)
+{
+    ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
+        !lpc->pm.acpi_memory_hotplug.is_enabled)
+        error_setg(errp,
+                   "memory hotplug is not enabled: %s.memory-hotplug-support "
+                   "is not set", object_get_typename(OBJECT(lpc)));
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
index df8c0db909..8b9654e437 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -374,9 +374,16 @@ static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
 static void piix4_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
+    PIIX4PMState *s = PIIX4_PM(hotplug_dev);
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         acpi_pcihp_device_pre_plug_cb(hotplug_dev, dev, errp);
-    } else if (!object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
+               !s->acpi_memory_hotplug.is_enabled) {
+        error_setg(errp,
+                   "memory hotplug is not enabled: %s.memory-hotplug-support "
+                   "is not set", object_get_typename(OBJECT(s)));
+    } else if (
                !object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         error_setg(errp, "acpi: device pre plug request for not supported"
                    " device type: %s", object_get_typename(OBJECT(dev)));
@@ -388,8 +395,7 @@ static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
 {
     PIIX4PMState *s = PIIX4_PM(hotplug_dev);
 
-    if (s->acpi_memory_hotplug.is_enabled &&
-        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
             nvdimm_acpi_plug_cb(hotplug_dev, dev);
         } else {
@@ -704,6 +710,7 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = false;
     dc->hotpluggable = false;
     hc->pre_plug = piix4_device_pre_plug_cb;
+    hc->pre_plug = piix4_device_pre_plug_cb;
     hc->plug = piix4_device_plug_cb;
     hc->unplug_request = piix4_device_unplug_request_cb;
     hc->unplug = piix4_device_unplug_cb;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 578f772e7c..64d9e756fa 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2083,6 +2083,8 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
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
index 59aeb06393..41568d1837 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -74,6 +74,8 @@ extern const VMStateDescription vmstate_ich9_pm;
 
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp);
 
+void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                Error **errp);
 void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp);
 void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
-- 
2.19.1
