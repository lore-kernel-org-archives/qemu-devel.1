Received: from eggs.gnu.org ([2001:4830:134:3::10]:43569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGh22-0008SN-B2
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGh1y-0006ik-CQ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:30:02 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  2 Jun 2017 17:29:49 +1000
Message-Id: <20170602072952.25454-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170602072952.25454-1-david@gibson.dropbear.id.au>
References: <20170602072952.25454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 2/5] spapr: Clean up spapr_dr_connector_by_*()
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

 * Change names to something less ludicrously verbose
 * Now that we have QOM subclasses for the different DRC types, use a QOM
   typename instead of a PAPR type value parameter

The latter allows removal of the get_type_shift() helper.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             | 28 ++++++++++++++--------------
 hw/ppc/spapr_drc.c         | 34 ++++++++++------------------------
 hw/ppc/spapr_events.c      |  2 +-
 hw/ppc/spapr_pci.c         |  6 ++----
 include/hw/ppc/spapr_drc.h |  5 ++---
 5 files changed, 29 insertions(+), 46 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 456f9e7..7aac3b9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -460,7 +460,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
     int i;
 
-    drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index);
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index);
     if (drc) {
         drc_index = spapr_drc_index(drc);
         _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index)));
@@ -653,7 +653,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
         if (i >= hotplug_lmb_start) {
             sPAPRDRConnector *drc;
 
-            drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB, i);
+            drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, i);
             g_assert(drc);
 
             dynamic_memory[0] = cpu_to_be32(addr >> 32);
@@ -2528,8 +2528,8 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     uint64_t addr = addr_start;
 
     for (i = 0; i < nr_lmbs; i++) {
-        drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
-                addr/SPAPR_MEMORY_BLOCK_SIZE);
+        drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
+                              addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
 
         fdt = create_device_tree(&fdt_size);
@@ -2550,8 +2550,8 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
      */
     if (dev->hotplugged) {
         if (dedicated_hp_event_source) {
-            drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
-                    addr_start / SPAPR_MEMORY_BLOCK_SIZE);
+            drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
+                                  addr_start / SPAPR_MEMORY_BLOCK_SIZE);
             drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
             spapr_hotplug_req_add_by_count_indexed(SPAPR_DR_CONNECTOR_TYPE_LMB,
                                                    nr_lmbs,
@@ -2668,8 +2668,8 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
 
     addr = addr_start;
     for (i = 0; i < nr_lmbs; i++) {
-        drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
-                                       addr / SPAPR_MEMORY_BLOCK_SIZE);
+        drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
+                              addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
         if (drc->indicator_state != SPAPR_DR_INDICATOR_STATE_INACTIVE) {
             avail_lmbs++;
@@ -2752,8 +2752,8 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
 
     addr = addr_start;
     for (i = 0; i < nr_lmbs; i++) {
-        drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
-                addr / SPAPR_MEMORY_BLOCK_SIZE);
+        drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
+                              addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
 
         drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
@@ -2761,8 +2761,8 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
         addr += SPAPR_MEMORY_BLOCK_SIZE;
     }
 
-    drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
-                                   addr_start / SPAPR_MEMORY_BLOCK_SIZE);
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
+                          addr_start / SPAPR_MEMORY_BLOCK_SIZE);
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     spapr_hotplug_req_remove_by_count_indexed(SPAPR_DR_CONNECTOR_TYPE_LMB,
                                               nr_lmbs, spapr_drc_index(drc));
@@ -2833,7 +2833,7 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index * smt);
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
     g_assert(drc);
 
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
@@ -2868,7 +2868,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                    cc->core_id);
         return;
     }
-    drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index * smt);
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
 
     g_assert(drc || !mc->has_hotpluggable_cpus);
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 690b41f..2514f87 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -55,21 +55,6 @@ static void spapr_ccs_remove(sPAPRMachineState *spapr,
     g_free(ccs);
 }
 
-static sPAPRDRConnectorTypeShift get_type_shift(sPAPRDRConnectorType type)
-{
-    uint32_t shift = 0;
-
-    /* make sure this isn't SPAPR_DR_CONNECTOR_TYPE_ANY, or some
-     * other wonky value.
-     */
-    g_assert(is_power_of_2(type));
-
-    while (type != (1 << shift)) {
-        shift++;
-    }
-    return shift;
-}
-
 sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc)
 {
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
@@ -805,7 +790,7 @@ static const TypeInfo spapr_drc_lmb_info = {
 
 /* helper functions for external users */
 
-sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index)
+sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
 {
     Object *obj;
     char name[256];
@@ -816,12 +801,13 @@ sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index)
     return !obj ? NULL : SPAPR_DR_CONNECTOR(obj);
 }
 
-sPAPRDRConnector *spapr_dr_connector_by_id(sPAPRDRConnectorType type,
-                                           uint32_t id)
+sPAPRDRConnector *spapr_drc_by_id(const char *type, uint32_t id)
 {
-    return spapr_dr_connector_by_index(
-            (get_type_shift(type) << DRC_INDEX_TYPE_SHIFT) |
-            (id & DRC_INDEX_ID_MASK));
+    sPAPRDRConnectorClass *drck
+        = SPAPR_DR_CONNECTOR_CLASS(object_class_by_name(type));
+
+    return spapr_drc_by_index(drck->typeshift << DRC_INDEX_TYPE_SHIFT
+                              | (id & DRC_INDEX_ID_MASK));
 }
 
 /* generate a string the describes the DRC to encode into the
@@ -1024,7 +1010,7 @@ static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     }
 
     /* if this is a DR sensor we can assume sensor_index == drc_index */
-    drc = spapr_dr_connector_by_index(sensor_index);
+    drc = spapr_drc_by_index(sensor_index);
     if (!drc) {
         trace_spapr_rtas_set_indicator_invalid(sensor_index);
         ret = RTAS_OUT_PARAM_ERROR;
@@ -1097,7 +1083,7 @@ static void rtas_get_sensor_state(PowerPCCPU *cpu, sPAPRMachineState *spapr,
         goto out;
     }
 
-    drc = spapr_dr_connector_by_index(sensor_index);
+    drc = spapr_drc_by_index(sensor_index);
     if (!drc) {
         trace_spapr_rtas_get_sensor_state_invalid(sensor_index);
         ret = RTAS_OUT_PARAM_ERROR;
@@ -1162,7 +1148,7 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
     wa_addr = ((uint64_t)rtas_ld(args, 1) << 32) | rtas_ld(args, 0);
 
     drc_index = rtas_ld(wa_addr, 0);
-    drc = spapr_dr_connector_by_index(drc_index);
+    drc = spapr_drc_by_index(drc_index);
     if (!drc) {
         trace_spapr_rtas_ibm_configure_connector_invalid(drc_index);
         rc = RTAS_OUT_PARAM_ERROR;
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 6b01b04..4ab2312 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -478,7 +478,7 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
 
 static void spapr_hotplug_set_signalled(uint32_t drc_index)
 {
-    sPAPRDRConnector *drc = spapr_dr_connector_by_index(drc_index);
+    sPAPRDRConnector *drc = spapr_drc_by_index(drc_index);
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     drck->set_signalled(drc);
 }
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 50d673b..0c181bb 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1400,10 +1400,8 @@ static sPAPRDRConnector *spapr_phb_get_pci_func_drc(sPAPRPHBState *phb,
                                                     uint32_t busnr,
                                                     int32_t devfn)
 {
-    return spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_PCI,
-                                    (phb->index << 16) |
-                                    (busnr << 8) |
-                                    devfn);
+    return spapr_drc_by_id(TYPE_SPAPR_DRC_PCI,
+                           (phb->index << 16) | (busnr << 8) | devfn);
 }
 
 static sPAPRDRConnector *spapr_phb_get_pci_drc(sPAPRPHBState *phb,
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index f77be38..d8cb84b 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -230,9 +230,8 @@ sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc);
 
 sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
                                          uint32_t id);
-sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index);
-sPAPRDRConnector *spapr_dr_connector_by_id(sPAPRDRConnectorType type,
-                                           uint32_t id);
+sPAPRDRConnector *spapr_drc_by_index(uint32_t index);
+sPAPRDRConnector *spapr_drc_by_id(const char *type, uint32_t id);
 int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
                           uint32_t drc_type_mask);
 
-- 
2.9.4
