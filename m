Received: from eggs.gnu.org ([2001:4830:134:3::10]:55907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9O-0002v2-W9
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9O-00020k-5A
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:39 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Jun 2018 18:52:16 +0200
Message-Id: <20180607165218.9558-7-david@redhat.com>
In-Reply-To: <20180607165218.9558-1-david@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 6/8] spapr: handle pc-dimm unplug via
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
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>

Let's handle it via hotplug_handler_unplug(). E.g. necessary to hotplug/
unplug memory devices (which a pc-dimm is) later.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bcb72d9fa7..0a8a3455d6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3298,7 +3298,8 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
 /* Callback to be called during DRC release. */
 void spapr_lmb_release(DeviceState *dev)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_hotplug_handler(dev));
+    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+    sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_ctrl);
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
     /* This information will get lost if a migration occurs
@@ -3316,9 +3317,17 @@ void spapr_lmb_release(DeviceState *dev)
 
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
@@ -3589,6 +3598,9 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
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
