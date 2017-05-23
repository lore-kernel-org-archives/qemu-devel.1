Received: from eggs.gnu.org ([2001:4830:134:3::10]:45308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dD7pY-0003nL-2I
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dD7pX-0006Cr-8B
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:18:24 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 23 May 2017 13:18:11 +0200
Message-Id: <20170523111812.13469-4-lvivier@redhat.com>
In-Reply-To: <20170523111812.13469-1-lvivier@redhat.com>
References: <20170523111812.13469-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] spapr: disable hotplugging without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>

If the OS is not started, QEMU sends an event to the OS
that is lost and cannot be recovered. An unplug is not
able to restore QEMU in a coherent state.
So, while the OS is not started, disable CPU and memory hotplug.
We use option vector 6 to know if the OS is started

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index eceb4cc..2e9320d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2625,6 +2625,7 @@ out:
 static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
+    sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm);
@@ -2645,6 +2646,13 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out;
     }
 
+    if (dev->hotplugged) {
+        if (!ms->os_name) {
+            error_setg(&local_err, "Memory hotplug not supported without OS");
+            goto out;
+        }
+    }
+
 out:
     error_propagate(errp, local_err);
 }
@@ -2874,6 +2882,7 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
     MachineState *machine = MACHINE(OBJECT(hotplug_dev));
+    sPAPRMachineState *ms = SPAPR_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
     Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
@@ -2884,9 +2893,16 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     int node_id;
     int index;
 
-    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
-        error_setg(&local_err, "CPU hotplug not supported for this machine");
-        goto out;
+    if (dev->hotplugged) {
+        if (!mc->has_hotpluggable_cpus) {
+            error_setg(&local_err,
+                       "CPU hotplug not supported for this machine");
+            goto out;
+        }
+        if (!ms->os_name) {
+            error_setg(&local_err, "CPU hotplug not supported without OS");
+            goto out;
+        }
     }
 
     if (strcmp(base_core_type, type)) {
-- 
2.9.4
