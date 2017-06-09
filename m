Received: from eggs.gnu.org ([2001:4830:134:3::10]:46979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRw-0003vU-GV
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRs-0006c0-U5
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:08 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:37 +1000
Message-Id: <20170609052652.23200-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/20] spapr: Clean up DR entity sense handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, David Gibson <david@gibson.dropbear.id.au>

DRC classes have an entity_sense method to determine (in a specific PAPR
sense) the presence or absence of a device plugged into a DRC.  However,
we only have one implementation of the method, which explicitly tests for
different DRC types.  This changes it to instead have different method
implementations for the two cases: "logical" and "physical" DRCs.

While we're at it, the entity sense method always returns RTAS_OUT_SUCCESS,
and the interesting value is returned via pass-by-reference.  Simplify this
to directly return the value we care about

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Acked-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c         | 72 ++++++++++++++++++++++------------------------
 hw/ppc/spapr_pci.c         |  6 ++--
 hw/ppc/trace-events        |  1 -
 include/hw/ppc/spapr_drc.h |  4 +--
 4 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 39e7f30..cabeacf 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -185,39 +185,25 @@ static void set_signalled(sPAPRDRConnector *drc)
  * based on the current allocation/indicator/power states
  * for the DR connector.
  */
-static uint32_t entity_sense(sPAPRDRConnector *drc, sPAPRDREntitySense *state)
+static sPAPRDREntitySense physical_entity_sense(sPAPRDRConnector *drc)
 {
-    if (drc->dev) {
-        if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI &&
-            drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
-            /* for logical DR, we return a state of UNUSABLE
-             * iff the allocation state UNUSABLE.
-             * Otherwise, report the state as USABLE/PRESENT,
-             * as we would for PCI.
-             */
-            *state = SPAPR_DR_ENTITY_SENSE_UNUSABLE;
-        } else {
-            /* this assumes all PCI devices are assigned to
-             * a 'live insertion' power domain, where QEMU
-             * manages power state automatically as opposed
-             * to the guest. present, non-PCI resources are
-             * unaffected by power state.
-             */
-            *state = SPAPR_DR_ENTITY_SENSE_PRESENT;
-        }
+    /* this assumes all PCI devices are assigned to a 'live insertion'
+     * power domain, where QEMU manages power state automatically as
+     * opposed to the guest. present, non-PCI resources are unaffected
+     * by power state.
+     */
+    return drc->dev ? SPAPR_DR_ENTITY_SENSE_PRESENT
+        : SPAPR_DR_ENTITY_SENSE_EMPTY;
+}
+
+static sPAPRDREntitySense logical_entity_sense(sPAPRDRConnector *drc)
+{
+    if (drc->dev
+        && (drc->allocation_state != SPAPR_DR_ALLOCATION_STATE_UNUSABLE)) {
+        return SPAPR_DR_ENTITY_SENSE_PRESENT;
     } else {
-        if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_PCI) {
-            /* PCI devices, and only PCI devices, use EMPTY
-             * in cases where we'd otherwise use UNUSABLE
-             */
-            *state = SPAPR_DR_ENTITY_SENSE_EMPTY;
-        } else {
-            *state = SPAPR_DR_ENTITY_SENSE_UNUSABLE;
-        }
+        return SPAPR_DR_ENTITY_SENSE_UNUSABLE;
     }
-
-    trace_spapr_drc_entity_sense(spapr_drc_index(drc), *state);
-    return RTAS_OUT_SUCCESS;
 }
 
 static void prop_get_index(Object *obj, Visitor *v, const char *name,
@@ -445,7 +431,6 @@ static void reset(DeviceState *d)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    sPAPRDREntitySense state;
 
     trace_spapr_drc_reset(spapr_drc_index(drc));
 
@@ -477,8 +462,7 @@ static void reset(DeviceState *d)
         }
     }
 
-    drck->entity_sense(drc, &state);
-    if (state == SPAPR_DR_ENTITY_SENSE_PRESENT) {
+    if (drck->dr_entity_sense(drc) == SPAPR_DR_ENTITY_SENSE_PRESENT) {
         drck->set_signalled(drc);
     }
 }
@@ -488,8 +472,7 @@ static bool spapr_drc_needed(void *opaque)
     sPAPRDRConnector *drc = (sPAPRDRConnector *)opaque;
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     bool rc = false;
-    sPAPRDREntitySense value;
-    drck->entity_sense(drc, &value);
+    sPAPRDREntitySense value = drck->dr_entity_sense(drc);
 
     /* If no dev is plugged in there is no need to migrate the DRC state */
     if (value != SPAPR_DR_ENTITY_SENSE_PRESENT) {
@@ -667,7 +650,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     drck->set_indicator_state = set_indicator_state;
     drck->set_allocation_state = set_allocation_state;
     drck->get_name = get_name;
-    drck->entity_sense = entity_sense;
     drck->attach = attach;
     drck->detach = detach;
     drck->release_pending = release_pending;
@@ -678,6 +660,20 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     dk->user_creatable = false;
 }
 
+static void spapr_drc_physical_class_init(ObjectClass *k, void *data)
+{
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
+
+    drck->dr_entity_sense = physical_entity_sense;
+}
+
+static void spapr_drc_logical_class_init(ObjectClass *k, void *data)
+{
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
+
+    drck->dr_entity_sense = logical_entity_sense;
+}
+
 static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
 {
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
@@ -716,6 +712,7 @@ static const TypeInfo spapr_drc_physical_info = {
     .name          = TYPE_SPAPR_DRC_PHYSICAL,
     .parent        = TYPE_SPAPR_DR_CONNECTOR,
     .instance_size = sizeof(sPAPRDRConnector),
+    .class_init    = spapr_drc_physical_class_init,
     .abstract      = true,
 };
 
@@ -723,6 +720,7 @@ static const TypeInfo spapr_drc_logical_info = {
     .name          = TYPE_SPAPR_DRC_LOGICAL,
     .parent        = TYPE_SPAPR_DR_CONNECTOR,
     .instance_size = sizeof(sPAPRDRConnector),
+    .class_init    = spapr_drc_logical_class_init,
     .abstract      = true,
 };
 
@@ -1010,7 +1008,7 @@ static void rtas_get_sensor_state(PowerPCCPU *cpu, sPAPRMachineState *spapr,
         goto out;
     }
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    ret = drck->entity_sense(drc, &sensor_state);
+    sensor_state = drck->dr_entity_sense(drc);
 
 out:
     rtas_st(rets, 0, ret);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 0c181bb..5cba8f9 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1481,7 +1481,7 @@ static void spapr_phb_hot_plug_child(HotplugHandler *plug_handler,
             func_drc = spapr_phb_get_pci_func_drc(phb, pci_bus_num(bus),
                                                   PCI_DEVFN(slotnr, i));
             func_drck = SPAPR_DR_CONNECTOR_GET_CLASS(func_drc);
-            func_drck->entity_sense(func_drc, &state);
+            state = func_drck->dr_entity_sense(func_drc);
 
             if (state == SPAPR_DR_ENTITY_SENSE_PRESENT) {
                 spapr_hotplug_req_add_by_index(func_drc);
@@ -1522,7 +1522,7 @@ static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
                 func_drc = spapr_phb_get_pci_func_drc(phb, pci_bus_num(bus),
                                                       PCI_DEVFN(slotnr, i));
                 func_drck = SPAPR_DR_CONNECTOR_GET_CLASS(func_drc);
-                func_drck->entity_sense(func_drc, &state);
+                state = func_drck->dr_entity_sense(func_drc);
                 if (state == SPAPR_DR_ENTITY_SENSE_PRESENT
                     && !func_drck->release_pending(func_drc)) {
                     error_setg(errp,
@@ -1548,7 +1548,7 @@ static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
                 func_drc = spapr_phb_get_pci_func_drc(phb, pci_bus_num(bus),
                                                       PCI_DEVFN(slotnr, i));
                 func_drck = SPAPR_DR_CONNECTOR_GET_CLASS(func_drc);
-                func_drck->entity_sense(func_drc, &state);
+                state = func_drck->dr_entity_sense(func_drc);
                 if (state == SPAPR_DR_ENTITY_SENSE_PRESENT) {
                     spapr_hotplug_req_remove_by_index(func_drc);
                 }
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 43d265f..4979397 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -44,7 +44,6 @@ spapr_drc_set_allocation_state(uint32_t index, int state) "drc: 0x%"PRIx32", sta
 spapr_drc_set_allocation_state_finalizing(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_set_configured(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_set_configured_skipping(uint32_t index) "drc: 0x%"PRIx32", isolated device"
-spapr_drc_entity_sense(uint32_t index, int state) "drc: 0x%"PRIx32", state: 0x%x"
 spapr_drc_attach(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_detach(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_awaiting_isolated(uint32_t index) "drc: 0x%"PRIx32
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index c88e1be..f892b94 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -214,6 +214,8 @@ typedef struct sPAPRDRConnectorClass {
     sPAPRDRConnectorTypeShift typeshift;
     const char *typename; /* used in device tree, PAPR 13.5.2.6 & C.6.1 */
 
+    sPAPRDREntitySense (*dr_entity_sense)(sPAPRDRConnector *drc);
+
     /* accessors for guest-visible (generally via RTAS) DR state */
     uint32_t (*set_isolation_state)(sPAPRDRConnector *drc,
                                     sPAPRDRIsolationState state);
@@ -223,8 +225,6 @@ typedef struct sPAPRDRConnectorClass {
                                      sPAPRDRAllocationState state);
     const char *(*get_name)(sPAPRDRConnector *drc);
 
-    uint32_t (*entity_sense)(sPAPRDRConnector *drc, sPAPRDREntitySense *state);
-
     /* QEMU interfaces for managing hotplug operations */
     void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                    int fdt_start_offset, bool coldplug, Error **errp);
-- 
2.9.4
