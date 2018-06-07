Received: from eggs.gnu.org ([2001:4830:134:3::10]:55705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9D-0002k8-Gu
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9B-0001s1-SM
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:27 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Jun 2018 18:52:11 +0200
Message-Id: <20180607165218.9558-2-david@redhat.com>
In-Reply-To: <20180607165218.9558-1-david@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/8] pc: local error handling in hotplug
 handler functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>

Let's introduce and use local error variables in the hotplug handler
functions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f3befe6721..8075c6af15 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2006,45 +2006,57 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
+    Error *local_err = NULL;
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        pc_cpu_pre_plug(hotplug_dev, dev, errp);
+        pc_cpu_pre_plug(hotplug_dev, dev, &local_err);
     }
+    error_propagate(errp, local_err);
 }
 
 static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
+    Error *local_err = NULL;
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        pc_dimm_plug(hotplug_dev, dev, errp);
+        pc_dimm_plug(hotplug_dev, dev, &local_err);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        pc_cpu_plug(hotplug_dev, dev, errp);
+        pc_cpu_plug(hotplug_dev, dev, &local_err);
     }
+    error_propagate(errp, local_err);
 }
 
 static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                                 DeviceState *dev, Error **errp)
 {
+    Error *local_err = NULL;
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        pc_dimm_unplug_request(hotplug_dev, dev, errp);
+        pc_dimm_unplug_request(hotplug_dev, dev, &local_err);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
+        pc_cpu_unplug_request_cb(hotplug_dev, dev, &local_err);
     } else {
-        error_setg(errp, "acpi: device unplug request for not supported device"
-                   " type: %s", object_get_typename(OBJECT(dev)));
+        error_setg(&local_err, "acpi: device unplug request for not supported"
+                   " device type: %s", object_get_typename(OBJECT(dev)));
     }
+    error_propagate(errp, local_err);
 }
 
 static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
+    Error *local_err = NULL;
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        pc_dimm_unplug(hotplug_dev, dev, errp);
+        pc_dimm_unplug(hotplug_dev, dev, &local_err);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        pc_cpu_unplug_cb(hotplug_dev, dev, errp);
+        pc_cpu_unplug_cb(hotplug_dev, dev, &local_err);
     } else {
-        error_setg(errp, "acpi: device unplug for not supported device"
+        error_setg(&local_err, "acpi: device unplug for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
     }
+    error_propagate(errp, local_err);
 }
 
 static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
-- 
2.17.0
