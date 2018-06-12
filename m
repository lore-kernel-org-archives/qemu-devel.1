Received: from eggs.gnu.org ([2001:4830:134:3::10]:59107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3s-0002rN-Dx
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3r-00020B-6U
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:56 +1000
Message-Id: <20180612064503.14282-27-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 26/33] spapr: move lookup of the node into
 spapr_memory_plug()
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

Let's clean the hotplug handler up by moving lookup of the node into
the function where it is actually being used.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f16a0b2870..1f577b274b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3136,7 +3136,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
 }
 
 static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                              uint32_t node, Error **errp)
+                              Error **errp)
 {
     Error *local_err = NULL;
     sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
@@ -3144,6 +3144,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr;
     uint64_t align, size, addr;
+    uint32_t node;
 
     mr = ddc->get_memory_region(dimm, &local_err);
     if (local_err) {
@@ -3163,6 +3164,8 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out_unplug;
     }
 
+    node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP,
+                                    &error_abort);
     spapr_add_lmbs(dev, addr, size, node,
                    spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
                    &local_err);
@@ -3572,16 +3575,11 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
     sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        int node;
-
         if (!smc->dr_lmb_enabled) {
             error_setg(errp, "Memory hotplug not supported for this machine");
             return;
         }
-        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP,
-                                        &error_abort);
-
-        spapr_memory_plug(hotplug_dev, dev, node, errp);
+        spapr_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_plug(hotplug_dev, dev, errp);
     }
-- 
2.17.1
