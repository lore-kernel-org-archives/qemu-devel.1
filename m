Received: from eggs.gnu.org ([2001:4830:134:3::10]:37512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV0-0002wv-3g
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQUx-0007os-1P
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:02 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:08 +1100
Message-Id: <20170222063348.32176-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/43] spapr: make cpu core unplug follow
 expected hotunplug call flow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

spapr_core_unplug() were essentially spapr_core_unplug_request()
handler that requested CPU removal and registered callback
which did actual cpu core removali but it was called from
spapr_machine_device_unplug() which is intended for actual object
removal. Commit (cf632463 spapr: Memory hot-unplug support)
sort of fixed it introducing spapr_machine_device_unplug_request()
and calling spapr_core_unplug() but it hasn't renamed callback and
by mistake calls it from spapr_machine_device_unplug().

However spapr_machine_device_unplug() isn't ever called for
cpu core since spapr_core_release() doesn't follow expected
hotunplug call flow which is:
 1: device_del() ->
        hotplug_handler_unplug_request() ->
            set destroy_cb()
 2: destroy_cb() ->
        hotplug_handler_unplug() ->
            object_unparent // actual device removal

Fix it by renaming spapr_core_unplug() to spapr_core_unplug_request()
which is called from spapr_machine_device_unplug_request() and
making spapr_core_release() call hotplug_handler_unplug() which
will call spapr_machine_device_unplug() -> spapr_core_unplug()
to remove cpu core.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reveiwed-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8c2efd8..37cb338 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2488,7 +2488,8 @@ void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
     return fdt;
 }
 
-static void spapr_core_release(DeviceState *dev, void *opaque)
+static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                              Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     CPUCore *cc = CPU_CORE(dev);
@@ -2497,8 +2498,17 @@ static void spapr_core_release(DeviceState *dev, void *opaque)
     object_unparent(OBJECT(dev));
 }
 
-static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                              Error **errp)
+static void spapr_core_release(DeviceState *dev, void *opaque)
+{
+    HotplugHandler *hotplug_ctrl;
+
+    hotplug_ctrl = qdev_get_hotplug_handler(dev);
+    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
+}
+
+static
+void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp)
 {
     CPUCore *cc = CPU_CORE(dev);
     int smt = kvmppc_smt_threads();
@@ -2719,7 +2729,7 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
             error_setg(errp, "CPU hot unplug not supported on this machine");
             return;
         }
-        spapr_core_unplug(hotplug_dev, dev, errp);
+        spapr_core_unplug_request(hotplug_dev, dev, errp);
     }
 }
 
-- 
2.9.3
