Received: from eggs.gnu.org ([2001:4830:134:3::10]:59000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAHq-0003zY-As
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAHm-00053v-De
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:00:58 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 14 May 2018 12:00:14 +0200
Message-Id: <20180514100023.12542-10-david@redhat.com>
In-Reply-To: <20180514100023.12542-1-david@redhat.com>
References: <20180514100023.12542-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/18] spapr: handle cpu core unplug via
 hotplug handler chain
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

Let's handle it via hotplug_handler_unplug().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 286c38c842..13d153b5a6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3412,7 +3412,16 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
 /* Callback to be called during DRC release. */
 void spapr_core_release(DeviceState *dev)
 {
-    MachineState *ms = MACHINE(qdev_get_hotplug_handler(dev));
+    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+
+    /* Call the unplug handler chain. This can never fail. */
+    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
+}
+
+static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                              Error **errp)
+{
+    MachineState *ms = MACHINE(hotplug_dev);
     sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
     CPUCore *cc = CPU_CORE(dev);
     CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
@@ -3623,6 +3632,8 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
     /* final stage hotplug handler */
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         spapr_memory_unplug(hotplug_dev, dev, &local_err);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
+        spapr_core_unplug(hotplug_dev, dev, &local_err);
     } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
         hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
                                &local_err);
-- 
2.14.3
