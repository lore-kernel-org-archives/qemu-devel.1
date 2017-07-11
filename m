Received: from eggs.gnu.org ([2001:4830:134:3::10]:40567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxM-0002IO-0r
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxK-0007T1-Nn
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:27 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:07 +1000
Message-Id: <20170711043917.1757-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/17] spapr: Uniform DRC reset paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

DRC objects have a regular device reset method.  However, it only gets
called in the usual way for PCI DRCs.  Because of where CPU and LMB DRCs
are in the QOM tree, their device reset method isn't automatically called.
So, the machine manually registers reset handlers to call device_reset().

This patch removes the device reset method, and instead always explicitly
registers the reset handler from realize().  This means the callers don't
have to worry about the two cases, and we always get proper resets.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c     | 31 ++++---------------------------
 hw/ppc/spapr_drc.c |  6 +++---
 2 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5acfb47..4fa982d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1967,24 +1967,6 @@ static void spapr_boot_set(void *opaque, const char *boot_device,
     machine->boot_order = g_strdup(boot_device);
 }
 
-/*
- * Reset routine for LMB DR devices.
- *
- * Unlike PCI DR devices, LMB DR devices explicitly register this reset
- * routine. Reset for PCI DR devices will be handled by PHB reset routine
- * when it walks all its children devices. LMB devices reset occurs
- * as part of ppc_spapr_reset().
- */
-static void spapr_drc_reset(void *opaque)
-{
-    sPAPRDRConnector *drc = opaque;
-    DeviceState *d = DEVICE(drc);
-
-    if (d) {
-        device_reset(d);
-    }
-}
-
 static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
 {
     MachineState *machine = MACHINE(spapr);
@@ -1993,13 +1975,11 @@ static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
     int i;
 
     for (i = 0; i < nr_lmbs; i++) {
-        sPAPRDRConnector *drc;
         uint64_t addr;
 
         addr = i * lmb_size + spapr->hotplug_memory.base;
-        drc = spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_LMB,
-                                     addr/lmb_size);
-        qemu_register_reset(spapr_drc_reset, drc);
+        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_LMB,
+                               addr / lmb_size);
     }
 }
 
@@ -2093,11 +2073,8 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
         int core_id = i * smp_threads;
 
         if (mc->has_hotpluggable_cpus) {
-            sPAPRDRConnector *drc =
-                spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
-                                       (core_id / smp_threads) * smt);
-
-            qemu_register_reset(spapr_drc_reset, drc);
+            spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
+                                   (core_id / smp_threads) * smt);
         }
 
         if (i < boot_cores_nr) {
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 22d4d81..c831aa3 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -426,9 +426,9 @@ static bool release_pending(sPAPRDRConnector *drc)
     return drc->awaiting_release;
 }
 
-static void reset(DeviceState *d)
+static void drc_reset(void *opaque)
 {
-    sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
+    sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(opaque);
 
     trace_spapr_drc_reset(spapr_drc_index(drc));
 
@@ -538,6 +538,7 @@ static void realize(DeviceState *d, Error **errp)
     g_free(child_name);
     vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr_drc,
                      drc);
+    qemu_register_reset(drc_reset, drc);
     trace_spapr_drc_realize_complete(spapr_drc_index(drc));
 }
 
@@ -596,7 +597,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     DeviceClass *dk = DEVICE_CLASS(k);
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
-    dk->reset = reset;
     dk->realize = realize;
     dk->unrealize = unrealize;
     drck->release_pending = release_pending;
-- 
2.9.4
