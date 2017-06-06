Received: from eggs.gnu.org ([2001:4830:134:3::10]:55010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI9ul-0003Oz-8r
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI9uj-00022d-2G
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:32:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 18:32:21 +1000
Message-Id: <20170606083221.9299-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170606083221.9299-1-david@gibson.dropbear.id.au>
References: <20170606083221.9299-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 7/7] spapr: Change DRC attach & detach methods
 to functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, David Gibson <david@gibson.dropbear.id.au>

DRC objects have attach & detach methods, but there's only one
implementation.  Although there are some differences in its behaviour for
different DRC types, the overall structure is the same, so while we might
want different method implementations for some parts, we're unlikely to
want them for the top-level functions.

So, replace them with direct function calls.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             | 19 ++++++-------------
 hw/ppc/spapr_drc.c         | 18 ++++++------------
 hw/ppc/spapr_pci.c         |  9 +++------
 include/hw/ppc/spapr_drc.h |  7 ++++---
 4 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e8cecaf..37466df 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2533,7 +2533,6 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                            Error **errp)
 {
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
     uint32_t nr_lmbs = size/SPAPR_MEMORY_BLOCK_SIZE;
     int i, fdt_offset, fdt_size;
     void *fdt;
@@ -2548,10 +2547,10 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
         fdt_offset = spapr_populate_memory_node(fdt, node, addr,
                                                 SPAPR_MEMORY_BLOCK_SIZE);
 
-        drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp);
+        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp);
         addr += SPAPR_MEMORY_BLOCK_SIZE;
         if (!dev->hotplugged) {
+            sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
             /* guests expect coldplugged LMBs to be pre-allocated */
             drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
             drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
@@ -2564,7 +2563,6 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
         if (dedicated_hp_event_source) {
             drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
                                   addr_start / SPAPR_MEMORY_BLOCK_SIZE);
-            drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
             spapr_hotplug_req_add_by_count_indexed(SPAPR_DR_CONNECTOR_TYPE_LMB,
                                                    nr_lmbs,
                                                    spapr_drc_index(drc));
@@ -2749,7 +2747,6 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
     uint64_t addr_start, addr;
     int i;
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
     sPAPRDIMMState *ds;
 
     addr_start = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP,
@@ -2769,14 +2766,12 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
                               addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
 
-        drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-        drck->detach(drc, dev, errp);
+        spapr_drc_detach(drc, dev, errp);
         addr += SPAPR_MEMORY_BLOCK_SIZE;
     }
 
     drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
                           addr_start / SPAPR_MEMORY_BLOCK_SIZE);
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     spapr_hotplug_req_remove_by_count_indexed(SPAPR_DR_CONNECTOR_TYPE_LMB,
                                               nr_lmbs, spapr_drc_index(drc));
 out:
@@ -2831,7 +2826,6 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     int index;
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
     Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
     int smt = kvmppc_smt_threads();
@@ -2849,8 +2843,7 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
     drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
     g_assert(drc);
 
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    drck->detach(drc, dev, &local_err);
+    spapr_drc_detach(drc, dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -2894,8 +2887,8 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 
     if (drc) {
-        sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local_err);
+        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged,
+                         &local_err);
         if (local_err) {
             g_free(fdt);
             error_propagate(errp, local_err);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index a4ece2e..c73fae0 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -49,8 +49,6 @@ uint32_t spapr_drc_index(sPAPRDRConnector *drc)
 static uint32_t set_isolation_state(sPAPRDRConnector *drc,
                                     sPAPRDRIsolationState state)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-
     trace_spapr_drc_set_isolation_state(spapr_drc_index(drc), state);
 
     /* if the guest is configuring a device attached to this DRC, we
@@ -105,7 +103,7 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
             uint32_t drc_index = spapr_drc_index(drc);
             if (drc->configured) {
                 trace_spapr_drc_set_isolation_state_finalizing(drc_index);
-                drck->detach(drc, DEVICE(drc->dev), NULL);
+                spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
             } else {
                 trace_spapr_drc_set_isolation_state_deferring(drc_index);
             }
@@ -119,8 +117,6 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
 static uint32_t set_allocation_state(sPAPRDRConnector *drc,
                                      sPAPRDRAllocationState state)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-
     trace_spapr_drc_set_allocation_state(spapr_drc_index(drc), state);
 
     if (state == SPAPR_DR_ALLOCATION_STATE_USABLE) {
@@ -151,7 +147,7 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
             drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
             uint32_t drc_index = spapr_drc_index(drc);
             trace_spapr_drc_set_allocation_state_finalizing(drc_index);
-            drck->detach(drc, DEVICE(drc->dev), NULL);
+            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
         } else if (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) {
             drc->awaiting_allocation = false;
         }
@@ -281,8 +277,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
     } while (fdt_depth != 0);
 }
 
-static void attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
-                   int fdt_start_offset, bool coldplug, Error **errp)
+void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
+                      int fdt_start_offset, bool coldplug, Error **errp)
 {
     trace_spapr_drc_attach(spapr_drc_index(drc));
 
@@ -333,7 +329,7 @@ static void attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                              NULL, 0, NULL);
 }
 
-static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
+void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
 {
     trace_spapr_drc_detach(spapr_drc_index(drc));
 
@@ -436,7 +432,7 @@ static void reset(DeviceState *d)
          * force removal if we are
          */
         if (drc->awaiting_release) {
-            drck->detach(drc, DEVICE(drc->dev), NULL);
+            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
         }
 
         /* non-PCI devices may be awaiting a transition to UNUSABLE */
@@ -607,8 +603,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     dk->unrealize = unrealize;
     drck->set_isolation_state = set_isolation_state;
     drck->set_allocation_state = set_allocation_state;
-    drck->attach = attach;
-    drck->detach = detach;
     drck->release_pending = release_pending;
     drck->set_signalled = set_signalled;
     /*
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 967d7c3..46e736d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1349,7 +1349,6 @@ static void spapr_phb_add_pci_device(sPAPRDRConnector *drc,
                                      PCIDevice *pdev,
                                      Error **errp)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     DeviceState *dev = DEVICE(pdev);
     void *fdt = NULL;
     int fdt_start_offset = 0, fdt_size;
@@ -1361,8 +1360,8 @@ static void spapr_phb_add_pci_device(sPAPRDRConnector *drc,
         goto out;
     }
 
-    drck->attach(drc, DEVICE(pdev),
-                 fdt, fdt_start_offset, !dev->hotplugged, errp);
+    spapr_drc_attach(drc, DEVICE(pdev),
+                     fdt, fdt_start_offset, !dev->hotplugged, errp);
 out:
     if (*errp) {
         g_free(fdt);
@@ -1391,9 +1390,7 @@ static void spapr_phb_remove_pci_device(sPAPRDRConnector *drc,
                                         PCIDevice *pdev,
                                         Error **errp)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-
-    drck->detach(drc, DEVICE(pdev), errp);
+    spapr_drc_detach(drc, DEVICE(pdev), errp);
 }
 
 static sPAPRDRConnector *spapr_phb_get_pci_func_drc(sPAPRPHBState *phb,
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 802c708..ec0256b 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -225,9 +225,6 @@ typedef struct sPAPRDRConnectorClass {
                                      sPAPRDRAllocationState state);
 
     /* QEMU interfaces for managing hotplug operations */
-    void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
-                   int fdt_start_offset, bool coldplug, Error **errp);
-    void (*detach)(sPAPRDRConnector *drc, DeviceState *d, Error **errp);
     bool (*release_pending)(sPAPRDRConnector *drc);
     void (*set_signalled)(sPAPRDRConnector *drc);
 } sPAPRDRConnectorClass;
@@ -243,4 +240,8 @@ sPAPRDRConnector *spapr_drc_by_id(const char *type, uint32_t id);
 int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
                           uint32_t drc_type_mask);
 
+void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
+                      int fdt_start_offset, bool coldplug, Error **errp);
+void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp);
+
 #endif /* HW_SPAPR_DRC_H */
-- 
2.9.4
