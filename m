Received: from eggs.gnu.org ([2001:4830:134:3::10]:51470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRGob-0005Gv-Jn
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRGoa-0006G1-OY
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:48:25 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  8 Jun 2018 14:48:13 +0200
Message-Id: <20180608124816.22140-4-david@redhat.com>
In-Reply-To: <20180608124816.22140-1-david@redhat.com>
References: <20180608124816.22140-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] spapr: move memory hotplug support
 check into spapr_memory_pre_plug()
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

Let's finish cleaning up the hotplug handler. This check can be
performed in the pre_plug code as the very first thing.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1f577b274b..9b8b4068b1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3184,12 +3184,18 @@ out:
 static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                   Error **errp)
 {
+    const sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr;
     uint64_t size;
     char *mem_dev;
 
+    if (!smc->dr_lmb_enabled) {
+        error_setg(errp, "Memory hotplug not supported for this machine");
+        return;
+    }
+
     mr = ddc->get_memory_region(dimm, errp);
     if (!mr) {
         return;
@@ -3571,14 +3577,7 @@ out:
 static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
-    MachineState *ms = MACHINE(hotplug_dev);
-    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
-
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        if (!smc->dr_lmb_enabled) {
-            error_setg(errp, "Memory hotplug not supported for this machine");
-            return;
-        }
         spapr_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         spapr_core_plug(hotplug_dev, dev, errp);
-- 
2.17.0
