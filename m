Received: from eggs.gnu.org ([2001:4830:134:3::10]:54457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4b1-0003Z8-NO
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4ax-0002zn-7W
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:51 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:24 +1000
Message-Id: <20170606025135.2685-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/17] spapr: Make DRC get_index and get_type
 methods into plain functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

These two methods only have one implementation, and the spec they're
implementing means any other implementation is unlikely, verging on
impossible.

So replace them with simple functions.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c             | 13 +++------
 hw/ppc/spapr_drc.c         | 66 ++++++++++++++++++++++------------------------
 hw/ppc/spapr_events.c      | 10 +++----
 hw/ppc/spapr_pci.c         |  4 +--
 include/hw/ppc/spapr_drc.h |  5 ++--
 5 files changed, 44 insertions(+), 54 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ab3aab1..5d10366 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -456,15 +456,13 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
     int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
     int drc_index;
     uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
     int i;
 
     drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index);
     if (drc) {
-        drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-        drc_index = drck->get_index(drc);
+        drc_index = spapr_drc_index(drc);
         _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index)));
     }
 
@@ -654,15 +652,13 @@ static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
 
         if (i >= hotplug_lmb_start) {
             sPAPRDRConnector *drc;
-            sPAPRDRConnectorClass *drck;
 
             drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB, i);
             g_assert(drc);
-            drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
             dynamic_memory[0] = cpu_to_be32(addr >> 32);
             dynamic_memory[1] = cpu_to_be32(addr & 0xffffffff);
-            dynamic_memory[2] = cpu_to_be32(drck->get_index(drc));
+            dynamic_memory[2] = cpu_to_be32(spapr_drc_index(drc));
             dynamic_memory[3] = cpu_to_be32(0); /* reserved */
             dynamic_memory[4] = cpu_to_be32(numa_get_node(addr, NULL));
             if (memory_region_present(get_system_memory(), addr)) {
@@ -2560,7 +2556,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
             drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
             spapr_hotplug_req_add_by_count_indexed(SPAPR_DR_CONNECTOR_TYPE_LMB,
                                                    nr_lmbs,
-                                                   drck->get_index(drc));
+                                                   spapr_drc_index(drc));
         } else {
             spapr_hotplug_req_add_by_count(SPAPR_DR_CONNECTOR_TYPE_LMB,
                                            nr_lmbs);
@@ -2770,8 +2766,7 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
                                    addr_start / SPAPR_MEMORY_BLOCK_SIZE);
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     spapr_hotplug_req_remove_by_count_indexed(SPAPR_DR_CONNECTOR_TYPE_LMB,
-                                              nr_lmbs,
-                                              drck->get_index(drc));
+                                              nr_lmbs, spapr_drc_index(drc));
 out:
     error_propagate(errp, local_err);
 }
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 693571a..a35314e 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -70,7 +70,7 @@ static sPAPRDRConnectorTypeShift get_type_shift(sPAPRDRConnectorType type)
     return shift;
 }
 
-static uint32_t get_index(sPAPRDRConnector *drc)
+uint32_t spapr_drc_index(sPAPRDRConnector *drc)
 {
     /* no set format for a drc index: it only needs to be globally
      * unique. this is how we encode the DRC type on bare-metal
@@ -85,7 +85,7 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
 {
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
-    trace_spapr_drc_set_isolation_state(get_index(drc), state);
+    trace_spapr_drc_set_isolation_state(spapr_drc_index(drc), state);
 
     if (state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
         /* cannot unisolate a non-existent resource, and, or resources
@@ -126,11 +126,12 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
          * PAPR+ 2.7, 13.4
          */
         if (drc->awaiting_release) {
+            uint32_t drc_index = spapr_drc_index(drc);
             if (drc->configured) {
-                trace_spapr_drc_set_isolation_state_finalizing(get_index(drc));
+                trace_spapr_drc_set_isolation_state_finalizing(drc_index);
                 drck->detach(drc, DEVICE(drc->dev), NULL);
             } else {
-                trace_spapr_drc_set_isolation_state_deferring(get_index(drc));
+                trace_spapr_drc_set_isolation_state_deferring(drc_index);
             }
         }
         drc->configured = false;
@@ -142,7 +143,7 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
 static uint32_t set_indicator_state(sPAPRDRConnector *drc,
                                     sPAPRDRIndicatorState state)
 {
-    trace_spapr_drc_set_indicator_state(get_index(drc), state);
+    trace_spapr_drc_set_indicator_state(spapr_drc_index(drc), state);
     drc->indicator_state = state;
     return RTAS_OUT_SUCCESS;
 }
@@ -152,7 +153,7 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
 {
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
-    trace_spapr_drc_set_allocation_state(get_index(drc), state);
+    trace_spapr_drc_set_allocation_state(spapr_drc_index(drc), state);
 
     if (state == SPAPR_DR_ALLOCATION_STATE_USABLE) {
         /* if there's no resource/device associated with the DRC, there's
@@ -180,7 +181,8 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
         drc->allocation_state = state;
         if (drc->awaiting_release &&
             drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
-            trace_spapr_drc_set_allocation_state_finalizing(get_index(drc));
+            uint32_t drc_index = spapr_drc_index(drc);
+            trace_spapr_drc_set_allocation_state_finalizing(drc_index);
             drck->detach(drc, DEVICE(drc->dev), NULL);
         } else if (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) {
             drc->awaiting_allocation = false;
@@ -189,7 +191,7 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
     return RTAS_OUT_SUCCESS;
 }
 
-static uint32_t get_type(sPAPRDRConnector *drc)
+sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc)
 {
     return drc->type;
 }
@@ -243,7 +245,7 @@ static uint32_t entity_sense(sPAPRDRConnector *drc, sPAPRDREntitySense *state)
         }
     }
 
-    trace_spapr_drc_entity_sense(get_index(drc), *state);
+    trace_spapr_drc_entity_sense(spapr_drc_index(drc), *state);
     return RTAS_OUT_SUCCESS;
 }
 
@@ -251,8 +253,7 @@ static void prop_get_index(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    uint32_t value = (uint32_t)drck->get_index(drc);
+    uint32_t value = spapr_drc_index(drc);
     visit_type_uint32(v, name, &value, errp);
 }
 
@@ -260,8 +261,7 @@ static void prop_get_type(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    uint32_t value = (uint32_t)drck->get_type(drc);
+    uint32_t value = (uint32_t)spapr_drc_type(drc);
     visit_type_uint32(v, name, &value, errp);
 }
 
@@ -362,7 +362,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
 static void attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                    int fdt_start_offset, bool coldplug, Error **errp)
 {
-    trace_spapr_drc_attach(get_index(drc));
+    trace_spapr_drc_attach(spapr_drc_index(drc));
 
     if (drc->isolation_state != SPAPR_DR_ISOLATION_STATE_ISOLATED) {
         error_setg(errp, "an attached device is still awaiting release");
@@ -413,7 +413,7 @@ static void attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
 
 static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
 {
-    trace_spapr_drc_detach(get_index(drc));
+    trace_spapr_drc_detach(spapr_drc_index(drc));
 
     /* if we've signalled device presence to the guest, or if the guest
      * has gone ahead and configured the device (via manually-executed
@@ -436,14 +436,14 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
     }
 
     if (drc->isolation_state != SPAPR_DR_ISOLATION_STATE_ISOLATED) {
-        trace_spapr_drc_awaiting_isolated(get_index(drc));
+        trace_spapr_drc_awaiting_isolated(spapr_drc_index(drc));
         drc->awaiting_release = true;
         return;
     }
 
     if (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI &&
         drc->allocation_state != SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
-        trace_spapr_drc_awaiting_unusable(get_index(drc));
+        trace_spapr_drc_awaiting_unusable(spapr_drc_index(drc));
         drc->awaiting_release = true;
         return;
     }
@@ -451,7 +451,7 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
     if (drc->awaiting_allocation) {
         if (!drc->awaiting_allocation_skippable) {
             drc->awaiting_release = true;
-            trace_spapr_drc_awaiting_allocation(get_index(drc));
+            trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
             return;
         }
     }
@@ -495,7 +495,7 @@ static void reset(DeviceState *d)
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     sPAPRDREntitySense state;
 
-    trace_spapr_drc_reset(drck->get_index(drc));
+    trace_spapr_drc_reset(spapr_drc_index(drc));
     /* immediately upon reset we can safely assume DRCs whose devices
      * are pending removal can be safely removed, and that they will
      * subsequently be left in an ISOLATED state. move the DRC to this
@@ -584,13 +584,12 @@ static const VMStateDescription vmstate_spapr_drc = {
 static void realize(DeviceState *d, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     Object *root_container;
     char link_name[256];
     gchar *child_name;
     Error *err = NULL;
 
-    trace_spapr_drc_realize(drck->get_index(drc));
+    trace_spapr_drc_realize(spapr_drc_index(drc));
     /* NOTE: we do this as part of realize/unrealize due to the fact
      * that the guest will communicate with the DRC via RTAS calls
      * referencing the global DRC index. By unlinking the DRC
@@ -599,9 +598,9 @@ static void realize(DeviceState *d, Error **errp)
      * existing in the composition tree
      */
     root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
-    snprintf(link_name, sizeof(link_name), "%x", drck->get_index(drc));
+    snprintf(link_name, sizeof(link_name), "%x", spapr_drc_index(drc));
     child_name = object_get_canonical_path_component(OBJECT(drc));
-    trace_spapr_drc_realize_child(drck->get_index(drc), child_name);
+    trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
     object_property_add_alias(root_container, link_name,
                               drc->owner, child_name, &err);
     if (err) {
@@ -609,22 +608,21 @@ static void realize(DeviceState *d, Error **errp)
         object_unref(OBJECT(drc));
     }
     g_free(child_name);
-    vmstate_register(DEVICE(drc), drck->get_index(drc), &vmstate_spapr_drc,
+    vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr_drc,
                      drc);
-    trace_spapr_drc_realize_complete(drck->get_index(drc));
+    trace_spapr_drc_realize_complete(spapr_drc_index(drc));
 }
 
 static void unrealize(DeviceState *d, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     Object *root_container;
     char name[256];
     Error *err = NULL;
 
-    trace_spapr_drc_unrealize(drck->get_index(drc));
+    trace_spapr_drc_unrealize(spapr_drc_index(drc));
     root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
-    snprintf(name, sizeof(name), "%x", drck->get_index(drc));
+    snprintf(name, sizeof(name), "%x", spapr_drc_index(drc));
     object_property_del(root_container, name, &err);
     if (err) {
         error_report_err(err);
@@ -645,7 +643,8 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
     drc->type = type;
     drc->id = id;
     drc->owner = owner;
-    prop_name = g_strdup_printf("dr-connector[%"PRIu32"]", get_index(drc));
+    prop_name = g_strdup_printf("dr-connector[%"PRIu32"]",
+                                spapr_drc_index(drc));
     object_property_add_child(owner, prop_name, OBJECT(drc), NULL);
     object_property_set_bool(OBJECT(drc), true, "realized", NULL);
     g_free(prop_name);
@@ -730,8 +729,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     drck->set_isolation_state = set_isolation_state;
     drck->set_indicator_state = set_indicator_state;
     drck->set_allocation_state = set_allocation_state;
-    drck->get_index = get_index;
-    drck->get_type = get_type;
     drck->get_name = get_name;
     drck->entity_sense = entity_sense;
     drck->attach = attach;
@@ -868,7 +865,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
         drc_count++;
 
         /* ibm,drc-indexes */
-        drc_index = cpu_to_be32(drck->get_index(drc));
+        drc_index = cpu_to_be32(spapr_drc_index(drc));
         g_array_append_val(drc_indexes, drc_index);
 
         /* ibm,drc-power-domains */
@@ -1156,15 +1153,16 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
             ccs->fdt_depth--;
             if (ccs->fdt_depth == 0) {
                 sPAPRDRIsolationState state = drc->isolation_state;
+                uint32_t drc_index = spapr_drc_index(drc);
                 /* done sending the device tree, don't need to track
                  * the state anymore
                  */
-                trace_spapr_drc_set_configured(get_index(drc));
+                trace_spapr_drc_set_configured(drc_index);
                 if (state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
                     drc->configured = true;
                 } else {
                     /* guest should be not configuring an isolated device */
-                    trace_spapr_drc_set_configured_skipping(get_index(drc));
+                    trace_spapr_drc_set_configured_skipping(drc_index);
                 }
                 spapr_ccs_remove(spapr, ccs);
                 ccs = NULL;
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 57acd85..d349ae5 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -570,22 +570,20 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
 
 void spapr_hotplug_req_add_by_index(sPAPRDRConnector *drc)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    sPAPRDRConnectorType drc_type = drck->get_type(drc);
+    sPAPRDRConnectorType drc_type = spapr_drc_type(drc);
     union drc_identifier drc_id;
 
-    drc_id.index = drck->get_index(drc);
+    drc_id.index = spapr_drc_index(drc);
     spapr_hotplug_req_event(RTAS_LOG_V6_HP_ID_DRC_INDEX,
                             RTAS_LOG_V6_HP_ACTION_ADD, drc_type, &drc_id);
 }
 
 void spapr_hotplug_req_remove_by_index(sPAPRDRConnector *drc)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    sPAPRDRConnectorType drc_type = drck->get_type(drc);
+    sPAPRDRConnectorType drc_type = spapr_drc_type(drc);
     union drc_identifier drc_id;
 
-    drc_id.index = drck->get_index(drc);
+    drc_id.index = spapr_drc_index(drc);
     spapr_hotplug_req_event(RTAS_LOG_V6_HP_ID_DRC_INDEX,
                             RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
 }
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index e4daf8d..7a208a7 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1417,14 +1417,12 @@ static uint32_t spapr_phb_get_pci_drc_index(sPAPRPHBState *phb,
                                             PCIDevice *pdev)
 {
     sPAPRDRConnector *drc = spapr_phb_get_pci_drc(phb, pdev);
-    sPAPRDRConnectorClass *drck;
 
     if (!drc) {
         return 0;
     }
 
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    return drck->get_index(drc);
+    return spapr_drc_index(drc);
 }
 
 static void spapr_phb_hot_plug_child(HotplugHandler *plug_handler,
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 90f4953..10e7c24 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -171,8 +171,6 @@ typedef struct sPAPRDRConnectorClass {
                                     sPAPRDRIndicatorState state);
     uint32_t (*set_allocation_state)(sPAPRDRConnector *drc,
                                      sPAPRDRAllocationState state);
-    uint32_t (*get_index)(sPAPRDRConnector *drc);
-    uint32_t (*get_type)(sPAPRDRConnector *drc);
     const char *(*get_name)(sPAPRDRConnector *drc);
 
     uint32_t (*entity_sense)(sPAPRDRConnector *drc, sPAPRDREntitySense *state);
@@ -185,6 +183,9 @@ typedef struct sPAPRDRConnectorClass {
     void (*set_signalled)(sPAPRDRConnector *drc);
 } sPAPRDRConnectorClass;
 
+uint32_t spapr_drc_index(sPAPRDRConnector *drc);
+sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc);
+
 sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
                                          sPAPRDRConnectorType type,
                                          uint32_t id);
-- 
2.9.4
