Received: from eggs.gnu.org ([2001:4830:134:3::10]:59207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAI8-0004OH-38
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAI5-0005Cb-SW
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:01:16 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 14 May 2018 12:00:21 +0200
Message-Id: <20180514100023.12542-17-david@redhat.com>
In-Reply-To: <20180514100023.12542-1-david@redhat.com>
References: <20180514100023.12542-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 16/18] s390x: prepare for multi stage
 hotplug handlers
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
 hw/s390x/s390-virtio-ccw.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5796e24bd8..af9bf97933 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -394,21 +394,56 @@ static void s390_machine_reset(void)
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, ipl_cpu);
 }
 
+static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
+                                         DeviceState *dev, Error **errp)
+{
+    Error *local_err = NULL;
+
+    /* final stage hotplug handler */
+    if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
+        hotplug_handler_pre_plug(dev->parent_bus->hotplug_handler, dev,
+                                 &local_err);
+    }
+    error_propagate(errp, local_err);
+}
+
 static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
+    Error *local_err = NULL;
+
+    /* final stage hotplug handler */
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        s390_cpu_plug(hotplug_dev, dev, errp);
+        s390_cpu_plug(hotplug_dev, dev, &local_err);
+    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
+        hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err);
     }
+    error_propagate(errp, local_err);
 }
 
 static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
                                                DeviceState *dev, Error **errp)
 {
+    /* final stage hotplug handler */
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         error_setg(errp, "CPU hot unplug not supported on this machine");
-        return;
+    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
+        hotplug_handler_unplug_request(dev->parent_bus->hotplug_handler, dev,
+                                       errp);
+    }
+}
+
+static void s390_machine_device_unplug(HotplugHandler *hotplug_dev,
+                                       DeviceState *dev, Error **errp)
+{
+    Error *local_err = NULL;
+
+    /* final stage hotplug handler */
+    if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
+        hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
+                               &local_err);
     }
+    error_propagate(errp, local_err);
 }
 
 static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
@@ -497,8 +532,10 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->possible_cpu_arch_ids = s390_possible_cpu_arch_ids;
     /* it is overridden with 'host' cpu *in kvm_arch_init* */
     mc->default_cpu_type = S390_CPU_TYPE_NAME("qemu");
+    hc->pre_plug = s390_machine_device_pre_plug;
     hc->plug = s390_machine_device_plug;
     hc->unplug_request = s390_machine_device_unplug_request;
+    hc->unplug = s390_machine_device_unplug;
     nc->nmi_monitor_handler = s390_nmi;
 }
 
-- 
2.14.3
