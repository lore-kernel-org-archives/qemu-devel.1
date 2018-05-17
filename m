Received: from eggs.gnu.org ([2001:4830:134:3::10]:49382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fJE4p-0002dS-Av
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fJE4o-0002xe-Cc
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:15:55 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 17 May 2018 10:15:21 +0200
Message-Id: <20180517081527.14410-9-david@redhat.com>
In-Reply-To: <20180517081527.14410-1-david@redhat.com>
References: <20180517081527.14410-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 08/14] spapr: handle pc-dimm unplug via
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

Let's handle it via hotplug_handler_unplug(). E.g. necessary to hotplug/
unplug memory devices (which a pc-dimm is) later.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2f315f963b..286c38c842 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3291,7 +3291,8 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
 /* Callback to be called during DRC release. */
 void spapr_lmb_release(DeviceState *dev)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_hotplug_handler(dev));
+    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+    sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_ctrl);
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
     /* This information will get lost if a migration occurs
@@ -3309,9 +3310,21 @@ void spapr_lmb_release(DeviceState *dev)
 
     /*
      * Now that all the LMBs have been removed by the guest, call the
-     * pc-dimm unplug handler to cleanup up the pc-dimm device.
+     * unplug handler chain. This can never fail.
      */
-    pc_dimm_memory_unplug(dev, MACHINE(spapr));
+    hotplug_ctrl = qdev_get_hotplug_handler(dev);
+    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
+}
+
+static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
+    sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
+
+    g_assert(ds);
+    g_assert(!ds->nr_lmbs);
+    pc_dimm_memory_unplug(dev, MACHINE(hotplug_dev));
     object_unparent(OBJECT(dev));
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
@@ -3608,7 +3621,9 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
 
     /* final stage hotplug handler */
-    if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        spapr_memory_unplug(hotplug_dev, dev, &local_err);
+    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
         hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
                                &local_err);
     }
-- 
2.14.3
