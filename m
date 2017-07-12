Received: from eggs.gnu.org ([2001:4830:134:3::10]:49332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVAaX-0000iI-Hb
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 01:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVAaT-0004ml-Aw
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 01:53:29 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 12 Jul 2017 15:53:12 +1000
Message-Id: <20170712055317.26225-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170712055317.26225-1-david@gibson.dropbear.id.au>
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 3/8] spapr: Simplify unplug path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com, groug@kaod.org, danielhb@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

spapr_lmb_release() and spapr_core_release() call hotplug_handler_unplug()
which after a bunch of indirection calls spapr_memory_unplug() or
spapr_core_unplug().  But we already know which is the appropriate thing
to call here, so we can just fold it directly into the release function.

Once that's done, there's no need for an hc->unplug method in the spapr
machine at all: since we also have an hc->unplug_request method, the
hotplug core will never use ->unplug.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 54 ++++++++----------------------------------------------
 1 file changed, 8 insertions(+), 46 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2a059d5..ff2aa6b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2818,6 +2818,9 @@ void spapr_lmb_release(DeviceState *dev)
 {
     HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
     sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_ctrl);
+    PCDIMMDevice *dimm = PC_DIMM(dev);
+    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
     /* This information will get lost if a migration occurs
@@ -2838,18 +2841,7 @@ void spapr_lmb_release(DeviceState *dev)
      * Now that all the LMBs have been removed by the guest, call the
      * pc-dimm unplug handler to cleanup up the pc-dimm device.
      */
-    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
-}
-
-static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                                Error **errp)
-{
-    sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
-    PCDIMMDevice *dimm = PC_DIMM(dev);
-    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm);
-
-    pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
+    pc_dimm_memory_unplug(dev, &spapr->hotplug_memory, mr);
     object_unparent(OBJECT(dev));
 }
 
@@ -2918,10 +2910,11 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
     return fdt;
 }
 
-static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                              Error **errp)
+/* Callback to be called during DRC release. */
+void spapr_core_release(DeviceState *dev)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
+    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+    MachineState *ms = MACHINE(hotplug_ctrl);
     sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
     CPUCore *cc = CPU_CORE(dev);
     CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
@@ -2945,15 +2938,6 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     object_unparent(OBJECT(dev));
 }
 
-/* Callback to be called during DRC release. */
-void spapr_core_release(DeviceState *dev)
-{
-    HotplugHandler *hotplug_ctrl;
-
-    hotplug_ctrl = qdev_get_hotplug_handler(dev);
-    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
-}
-
 static
 void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
@@ -3159,27 +3143,6 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
     }
 }
 
-static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
-                                      DeviceState *dev, Error **errp)
-{
-    sPAPRMachineState *sms = SPAPR_MACHINE(qdev_get_machine());
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
-            spapr_memory_unplug(hotplug_dev, dev, errp);
-        } else {
-            error_setg(errp, "Memory hot unplug not supported for this guest");
-        }
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
-        if (!mc->has_hotpluggable_cpus) {
-            error_setg(errp, "CPU hot unplug not supported on this machine");
-            return;
-        }
-        spapr_core_unplug(hotplug_dev, dev, errp);
-    }
-}
-
 static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
                                                 DeviceState *dev, Error **errp)
 {
@@ -3397,7 +3360,6 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->get_hotplug_handler = spapr_get_hotplug_handler;
     hc->pre_plug = spapr_machine_device_pre_plug;
     hc->plug = spapr_machine_device_plug;
-    hc->unplug = spapr_machine_device_unplug;
     mc->cpu_index_to_instance_props = spapr_cpu_index_to_props;
     mc->possible_cpu_arch_ids = spapr_possible_cpu_arch_ids;
     hc->unplug_request = spapr_machine_device_unplug_request;
-- 
2.9.4
