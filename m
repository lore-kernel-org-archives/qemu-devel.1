Received: from eggs.gnu.org ([2001:4830:134:3::10]:49264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fJE4h-0002W7-3v
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fJE4d-0002s7-4V
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:15:47 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 17 May 2018 10:15:17 +0200
Message-Id: <20180517081527.14410-5-david@redhat.com>
In-Reply-To: <20180517081527.14410-1-david@redhat.com>
References: <20180517081527.14410-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/14] pc: prepare for multi stage hotplug
 handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Hildenbrand <david@redhat.com>

For multi stage hotplug handlers, we'll have to do some error handling
in some hotplug functions, so let's use a local error variable (except
for unplug requests).

Also, add code to pass control to the final stage hotplug handler at the
parent bus.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d768930d02..510076e156 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2007,19 +2007,32 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
+    Error *local_err = NULL;
+
+    /* final stage hotplug handler */
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        pc_cpu_pre_plug(hotplug_dev, dev, errp);
+        pc_cpu_pre_plug(hotplug_dev, dev, &local_err);
+    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
+        hotplug_handler_pre_plug(dev->parent_bus->hotplug_handler, dev,
+                                 &local_err);
     }
+    error_propagate(errp, local_err);
 }
 
 static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
+    Error *local_err = NULL;
+
+    /* final stage hotplug handler */
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        pc_dimm_plug(hotplug_dev, dev, errp);
+        pc_dimm_plug(hotplug_dev, dev, &local_err);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        pc_cpu_plug(hotplug_dev, dev, errp);
+        pc_cpu_plug(hotplug_dev, dev, &local_err);
+    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
+        hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err);
     }
+    error_propagate(errp, local_err);
 }
 
 static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
@@ -2029,7 +2042,10 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
         pc_dimm_unplug_request(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
-    } else {
+    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
+        hotplug_handler_unplug_request(dev->parent_bus->hotplug_handler, dev,
+                                       errp);
+    } else if (!dev->parent_bus) {
         error_setg(errp, "acpi: device unplug request for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
     }
@@ -2038,14 +2054,21 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
 static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
+    Error *local_err = NULL;
+
+    /* final stage hotplug handler */
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        pc_dimm_unplug(hotplug_dev, dev, errp);
+        pc_dimm_unplug(hotplug_dev, dev, &local_err);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        pc_cpu_unplug_cb(hotplug_dev, dev, errp);
-    } else {
-        error_setg(errp, "acpi: device unplug for not supported device"
+        pc_cpu_unplug_cb(hotplug_dev, dev, &local_err);
+    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
+        hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
+                               &local_err);
+    } else if (!dev->parent_bus) {
+        error_setg(&local_err, "acpi: device unplug for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
     }
+    error_propagate(errp, local_err);
 }
 
 static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
-- 
2.14.3
