Received: from eggs.gnu.org ([2001:4830:134:3::10]:44082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX1Gg-0007oi-15
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX1Gc-0008FR-Di
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:57:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gX1Ga-0008EX-Bi
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:57:21 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 12 Dec 2018 10:57:07 +0100
Message-Id: <20181212095707.19358-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] pc: Use
 hotplug_handler_(plug|unplug|unplug_request)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>

Let's avoid manually looking up the hotplug handler class. Use the
existing wrappers instead.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4cd2fbca4d..c8857138f9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1711,7 +1711,6 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
                            DeviceState *dev, Error **errp)
 {
-    HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
@@ -1725,8 +1724,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
         nvdimm_plug(&pcms->acpi_nvdimm_state);
     }
 
-    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-    hhc->plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
+    hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
 out:
     error_propagate(errp, local_err);
 }
@@ -1734,7 +1732,6 @@ out:
 static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
-    HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
@@ -1755,9 +1752,8 @@ static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-    hhc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
-
+    hotplug_handler_unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
+                                   &local_err);
 out:
     error_propagate(errp, local_err);
 }
@@ -1766,12 +1762,9 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    HotplugHandlerClass *hhc;
     Error *local_err = NULL;
 
-    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-    hhc->unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
-
+    hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
     if (local_err) {
         goto out;
     }
@@ -1813,14 +1806,12 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
                         DeviceState *dev, Error **errp)
 {
     CPUArchId *found_cpu;
-    HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
     if (pcms->acpi_dev) {
-        hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-        hhc->plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
+        hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
         if (local_err) {
             goto out;
         }
@@ -1844,7 +1835,6 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     int idx = -1;
-    HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
@@ -1861,9 +1851,8 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-    hhc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
-
+    hotplug_handler_unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
+                                   &local_err);
     if (local_err) {
         goto out;
     }
@@ -1877,14 +1866,11 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
     CPUArchId *found_cpu;
-    HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
-    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-    hhc->unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
-
+    hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
     if (local_err) {
         goto out;
     }
-- 
2.17.2
