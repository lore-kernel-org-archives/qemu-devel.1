Received: from eggs.gnu.org ([209.51.188.92]:36997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5HA-0003CD-P1
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5H8-0004X4-J8
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:54483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5H8-0004QX-7t
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:50 -0500
Received: by mail-wm1-x334.google.com with SMTP id a62so4681668wmh.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:23 +0100
Message-Id: <1549390526-24246-74-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 73/76] pc: Use
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
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's avoid manually looking up the hotplug handler class. Use the
existing wrappers instead.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181212095707.19358-1-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7d8f351..3889ecc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2122,7 +2122,6 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
                            DeviceState *dev, Error **errp)
 {
-    HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
@@ -2136,8 +2135,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
         nvdimm_plug(&pcms->acpi_nvdimm_state);
     }
 
-    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-    hhc->plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
+    hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
 out:
     error_propagate(errp, local_err);
 }
@@ -2145,7 +2143,6 @@ out:
 static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
-    HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
@@ -2166,9 +2163,8 @@ static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
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
@@ -2177,12 +2173,9 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
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
@@ -2224,14 +2217,12 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
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
@@ -2255,7 +2246,6 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     int idx = -1;
-    HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
@@ -2272,9 +2262,8 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
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
@@ -2288,14 +2277,11 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
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
1.8.3.1
