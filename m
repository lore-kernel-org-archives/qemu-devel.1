Received: from eggs.gnu.org ([2001:4830:134:3::10]:55726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dFjdd-0003va-7T
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dFjda-0007GC-0P
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:04:53 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 30 May 2017 18:04:45 +0200
Message-Id: <20170530160445.12810-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] spapr: manage hotplugged devices while the VM
 is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

For QEMU, a hotlugged device is a device added using the HMP/QMP
interface.
For SPAPR, a hotplugged device is a device added while the
machine is running. In this case QEMU doesn't update internal
state but relies on the OS for this part

In the case of migration, when we (libvirt) hotplug a device
on the source guest, we (libvirt) generally hotplug the same
device on the destination guest. But in this case, the machine
is stopped (RUN_STATE_INMIGRATE) and QEMU must not expect
the OS will manage it as an hotplugged device as it will
be "imported" by the migration.

This patch changes the meaning of "hotplugged" in spapr.c
to manage a QEMU hotplugged device like a "coldplugged" one
when the machine is awaiting an incoming migration.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0980d73..f1302d0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2511,6 +2511,12 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+static bool spapr_coldplugged(DeviceState *dev)
+{
+    return runstate_check(RUN_STATE_INMIGRATE) ||
+           !dev->hotplugged;
+}
+
 static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                            uint32_t node, bool dedicated_hp_event_source,
                            Error **errp)
@@ -2521,6 +2527,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     int i, fdt_offset, fdt_size;
     void *fdt;
     uint64_t addr = addr_start;
+    bool coldplugged = spapr_coldplugged(dev);
 
     for (i = 0; i < nr_lmbs; i++) {
         drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
@@ -2532,9 +2539,9 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                                                 SPAPR_MEMORY_BLOCK_SIZE);
 
         drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp);
+        drck->attach(drc, dev, fdt, fdt_offset, coldplugged, errp);
         addr += SPAPR_MEMORY_BLOCK_SIZE;
-        if (!dev->hotplugged) {
+        if (coldplugged) {
             /* guests expect coldplugged LMBs to be pre-allocated */
             drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
             drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
@@ -2543,7 +2550,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     /* send hotplug notification to the
      * guest only in case of hotplugged memory
      */
-    if (dev->hotplugged) {
+    if (!coldplugged) {
         if (dedicated_hp_event_source) {
             drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
                     addr_start / SPAPR_MEMORY_BLOCK_SIZE);
@@ -2776,6 +2783,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     int smt = kvmppc_smt_threads();
     CPUArchId *core_slot;
     int index;
+    bool coldplugged = spapr_coldplugged(dev);
 
     core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
     if (!core_slot) {
@@ -2797,7 +2805,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     if (drc) {
         sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local_err);
+        drck->attach(drc, dev, fdt, fdt_offset, coldplugged, &local_err);
         if (local_err) {
             g_free(fdt);
             error_propagate(errp, local_err);
@@ -2805,7 +2813,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         }
     }
 
-    if (dev->hotplugged) {
+    if (!coldplugged) {
         /*
          * Send hotplug notification interrupt to the guest only in case
          * of hotplugged CPUs.
@@ -2838,7 +2846,7 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     int node_id;
     int index;
 
-    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
+    if (!spapr_coldplugged(dev) && !mc->has_hotpluggable_cpus) {
         error_setg(&local_err, "CPU hotplug not supported for this machine");
         goto out;
     }
-- 
2.9.4
