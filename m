Received: from eggs.gnu.org ([2001:4830:134:3::10]:59158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3t-0002rh-MJ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3s-000229-O1
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:45:00 +1000
Message-Id: <20180612064503.14282-31-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 30/33] spapr: handle cpu core unplug via hotplug
 handler chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: David Hildenbrand <david@redhat.com>

Factor out cpu core unplug into separate function from
spapr_core_release(). Then use generic hotplug_handler_unplug() to trigger
cpu core unplug, which would call spapr_machine_device_unplug() ->
spapr_core_unplug() in the end.

This way unplug operation is not buried in spapr internals and located
in the same place like in other targets, following similar
logic/call chain across targets.

Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 404d887f4e..f59999daac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3416,7 +3416,15 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
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
+static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
+{
+    MachineState *ms = MACHINE(hotplug_dev);
     sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
     CPUCore *cc = CPU_CORE(dev);
     CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
@@ -3598,6 +3606,8 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         spapr_memory_unplug(hotplug_dev, dev);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
+        spapr_core_unplug(hotplug_dev, dev);
     }
 }
 
-- 
2.17.1
