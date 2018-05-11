Received: from eggs.gnu.org ([2001:4830:134:3::10]:36268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7zV-0002Sh-2x
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7zT-0005Rt-PY
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:21:45 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 May 2018 15:19:53 +0200
Message-Id: <20180511131953.12905-18-david@redhat.com>
In-Reply-To: <20180511131953.12905-1-david@redhat.com>
References: <20180511131953.12905-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/17] s390x: support memory devices
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

Let's route all memory devices we can hotplug through the machine hotplug
handler, just like on pc and spapr.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 default-configs/s390x-softmmu.mak |  1 +
 hw/s390x/s390-virtio-ccw.c        | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 2f4bfe73b4..6b017b65fc 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -9,3 +9,4 @@ CONFIG_S390_FLIC=y
 CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
 CONFIG_VFIO_CCW=$(CONFIG_LINUX)
 CONFIG_WDT_DIAG288=y
+CONFIG_MEM_HOTPLUG=y
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 09b755282b..91687ca327 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -35,6 +35,7 @@
 #include "migration/register.h"
 #include "cpu_models.h"
 #include "hw/nmi.h"
+#include "hw/mem/memory-device.h"
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -436,12 +437,29 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
 {
     Error *local_err = NULL;
 
+    /* first stage hotplug handler */
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+        memory_device_plug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev), NULL,
+                           &local_err);
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     /* final stage hotplug handler */
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         s390_cpu_plug(hotplug_dev, dev, &local_err);
     } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
         hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err);
     }
+
+    if (local_err) {
+        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+            memory_device_unplug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev));
+        }
+    }
     error_propagate(errp, local_err);
 }
 
@@ -468,6 +486,16 @@ static void s390_machine_device_unplug(HotplugHandler *hotplug_dev,
                                &local_err);
     }
     error_propagate(errp, local_err);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /* first stage hotplug handler */
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+        memory_device_unplug(MACHINE(hotplug_dev), MEMORY_DEVICE(dev));
+    }
 }
 
 static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
@@ -509,6 +537,13 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         return HOTPLUG_HANDLER(machine);
     }
+
+    if (dev->parent_bus) {
+        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+            return HOTPLUG_HANDLER(machine);
+        }
+    }
+
     return NULL;
 }
 
-- 
2.14.3
