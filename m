Received: from eggs.gnu.org ([2001:4830:134:3::10]:51567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRGof-0005K3-1L
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRGoe-0006J0-1V
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:48:29 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  8 Jun 2018 14:48:15 +0200
Message-Id: <20180608124816.22140-6-david@redhat.com>
In-Reply-To: <20180608124816.22140-1-david@redhat.com>
References: <20180608124816.22140-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/6] spapr: handle pc-dimm unplug via
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
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

Factor out memory unplug into separate function from spapr_lmb_release().
Then use generic hotplug_handler_unplug() to trigger memory unplug,
which will call spapr_machine_device_unplug() -> spapr_memory_unplug()
in the end.

This way unplug operation is not buried in lmb internals and located in
the same place like in other targets, following similar logic/call chain
across targets.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c45f8bc75b..404d887f4e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3299,7 +3299,8 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
 /* Callback to be called during DRC release. */
 void spapr_lmb_release(DeviceState *dev)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_hotplug_handler(dev));
+    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+    sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_ctrl);
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
     /* This information will get lost if a migration occurs
@@ -3317,9 +3318,17 @@ void spapr_lmb_release(DeviceState *dev)
 
     /*
      * Now that all the LMBs have been removed by the guest, call the
-     * pc-dimm unplug handler to cleanup up the pc-dimm device.
+     * unplug handler chain. This can never fail.
      */
-    pc_dimm_memory_unplug(dev, MACHINE(spapr));
+    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
+}
+
+static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
+    sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
+
+    pc_dimm_memory_unplug(dev, MACHINE(hotplug_dev));
     object_unparent(OBJECT(dev));
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
@@ -3587,6 +3596,9 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
 static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        spapr_memory_unplug(hotplug_dev, dev);
+    }
 }
 
 static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
-- 
2.17.0
