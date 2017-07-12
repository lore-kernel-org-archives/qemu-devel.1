Received: from eggs.gnu.org ([2001:4830:134:3::10]:49467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVAb2-0001YX-Fi
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 01:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVAb0-0004ve-0b
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 01:54:00 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 12 Jul 2017 15:53:15 +1000
Message-Id: <20170712055317.26225-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170712055317.26225-1-david@gibson.dropbear.id.au>
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 6/8] spapr: Consolidate DRC state variables
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

Each DRC has three fields describing its state: isolation_state,
allocation_state and configured.  At first this seems like a reasonable
representation, since its based directly on the PAPR defined
isolation-state and allocation-state indicators.  However:
  * Only a few combinations of the two fields' values are permitted
  * allocation_state isn't used at all for physical DRCs
  * The indicators are write only so they don't really have a well
    defined current value independent of each other

This replaces these variables with a single state variable, whose names
and numbers are based on the diagram in LoPAPR section 13.4.  Along with
this we add code to check the current state on various operations and make
sure the requested transition is permitted.

Strictly speaking, this makes guest visible changes to behaviour (since we
probably allowed some transitions we shouldn't have before).  However, a
hypothetical guest broken by that wasn't PAPR compliant, and probably
wouldn't have worked under PowerVM.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c         | 225 +++++++++++++++++++++++++--------------------
 hw/ppc/trace-events        |   3 +-
 include/hw/ppc/spapr_drc.h |  25 ++++-
 3 files changed, 145 insertions(+), 108 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 8326f3a..dbc9c0f 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -48,6 +48,17 @@ uint32_t spapr_drc_index(sPAPRDRConnector *drc)
 
 static uint32_t drc_isolate_physical(sPAPRDRConnector *drc)
 {
+    switch (drc->state) {
+    case SPAPR_DRC_STATE_PHYSICAL_POWERON:
+        return RTAS_OUT_SUCCESS; /* Nothing to do */
+    case SPAPR_DRC_STATE_PHYSICAL_CONFIGURED:
+        break; /* see below */
+    case SPAPR_DRC_STATE_PHYSICAL_UNISOLATE:
+        return RTAS_OUT_PARAM_ERROR; /* not allowed */
+    default:
+        g_assert_not_reached();
+    }
+
     /* if the guest is configuring a device attached to this DRC, we
      * should reset the configuration state at this point since it may
      * no longer be reliable (guest released device and needs to start
@@ -56,32 +67,29 @@ static uint32_t drc_isolate_physical(sPAPRDRConnector *drc)
     g_free(drc->ccs);
     drc->ccs = NULL;
 
-    drc->isolation_state = SPAPR_DR_ISOLATION_STATE_ISOLATED;
+    drc->state = SPAPR_DRC_STATE_PHYSICAL_POWERON;
 
-    /* if we're awaiting release, but still in an unconfigured state,
-     * it's likely the guest is still in the process of configuring
-     * the device and is transitioning the devices to an ISOLATED
-     * state as a part of that process. so we only complete the
-     * removal when this transition happens for a device in a
-     * configured state, as suggested by the state diagram from PAPR+
-     * 2.7, 13.4
-     */
     if (drc->unplug_requested) {
         uint32_t drc_index = spapr_drc_index(drc);
-        if (drc->configured) {
-            trace_spapr_drc_set_isolation_state_finalizing(drc_index);
-            spapr_drc_detach(drc);
-        } else {
-            trace_spapr_drc_set_isolation_state_deferring(drc_index);
-        }
+        trace_spapr_drc_set_isolation_state_finalizing(drc_index);
+        spapr_drc_detach(drc);
     }
-    drc->configured = false;
 
     return RTAS_OUT_SUCCESS;
 }
 
 static uint32_t drc_unisolate_physical(sPAPRDRConnector *drc)
 {
+    switch (drc->state) {
+    case SPAPR_DRC_STATE_PHYSICAL_UNISOLATE:
+    case SPAPR_DRC_STATE_PHYSICAL_CONFIGURED:
+        return RTAS_OUT_SUCCESS; /* Nothing to do */
+    case SPAPR_DRC_STATE_PHYSICAL_POWERON:
+        break; /* see below */
+    default:
+        g_assert_not_reached();
+    }
+
     /* cannot unisolate a non-existent resource, and, or resources
      * which are in an 'UNUSABLE' allocation state. (PAPR 2.7,
      * 13.5.3.5)
@@ -90,13 +98,25 @@ static uint32_t drc_unisolate_physical(sPAPRDRConnector *drc)
         return RTAS_OUT_NO_SUCH_INDICATOR;
     }
 
-    drc->isolation_state = SPAPR_DR_ISOLATION_STATE_UNISOLATED;
+    drc->state = SPAPR_DRC_STATE_PHYSICAL_UNISOLATE;
 
     return RTAS_OUT_SUCCESS;
 }
 
 static uint32_t drc_isolate_logical(sPAPRDRConnector *drc)
 {
+    switch (drc->state) {
+    case SPAPR_DRC_STATE_LOGICAL_AVAILABLE:
+    case SPAPR_DRC_STATE_LOGICAL_UNUSABLE:
+        return RTAS_OUT_SUCCESS; /* Nothing to do */
+    case SPAPR_DRC_STATE_LOGICAL_CONFIGURED:
+        break; /* see below */
+    case SPAPR_DRC_STATE_LOGICAL_UNISOLATE:
+        return RTAS_OUT_PARAM_ERROR; /* not allowed */
+    default:
+        g_assert_not_reached();
+    }
+
     /* if the guest is configuring a device attached to this DRC, we
      * should reset the configuration state at this point since it may
      * no longer be reliable (guest released device and needs to start
@@ -120,7 +140,7 @@ static uint32_t drc_isolate_logical(sPAPRDRConnector *drc)
         return RTAS_OUT_HW_ERROR;
     }
 
-    drc->isolation_state = SPAPR_DR_ISOLATION_STATE_ISOLATED;
+    drc->state = SPAPR_DRC_STATE_LOGICAL_AVAILABLE;
 
     /* if we're awaiting release, but still in an unconfigured state,
      * it's likely the guest is still in the process of configuring
@@ -132,36 +152,46 @@ static uint32_t drc_isolate_logical(sPAPRDRConnector *drc)
      */
     if (drc->unplug_requested) {
         uint32_t drc_index = spapr_drc_index(drc);
-        if (drc->configured) {
-            trace_spapr_drc_set_isolation_state_finalizing(drc_index);
-            spapr_drc_detach(drc);
-        } else {
-            trace_spapr_drc_set_isolation_state_deferring(drc_index);
-        }
+        trace_spapr_drc_set_isolation_state_finalizing(drc_index);
+        spapr_drc_detach(drc);
     }
-    drc->configured = false;
-
     return RTAS_OUT_SUCCESS;
 }
 
 static uint32_t drc_unisolate_logical(sPAPRDRConnector *drc)
 {
-    /* cannot unisolate a non-existent resource, and, or resources
-     * which are in an 'UNUSABLE' allocation state. (PAPR 2.7,
-     * 13.5.3.5)
-     */
-    if (!drc->dev ||
-        drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
-        return RTAS_OUT_NO_SUCH_INDICATOR;
+    switch (drc->state) {
+    case SPAPR_DRC_STATE_LOGICAL_UNISOLATE:
+    case SPAPR_DRC_STATE_LOGICAL_CONFIGURED:
+        return RTAS_OUT_SUCCESS; /* Nothing to do */
+    case SPAPR_DRC_STATE_LOGICAL_AVAILABLE:
+        break; /* see below */
+    case SPAPR_DRC_STATE_LOGICAL_UNUSABLE:
+        return RTAS_OUT_NO_SUCH_INDICATOR; /* not allowed */
+    default:
+        g_assert_not_reached();
     }
 
-    drc->isolation_state = SPAPR_DR_ISOLATION_STATE_UNISOLATED;
+    /* Move to AVAILABLE state should have ensured device was present */
+    g_assert(drc->dev);
 
+    drc->state = SPAPR_DRC_STATE_LOGICAL_UNISOLATE;
     return RTAS_OUT_SUCCESS;
 }
 
 static uint32_t drc_set_usable(sPAPRDRConnector *drc)
 {
+    switch (drc->state) {
+    case SPAPR_DRC_STATE_LOGICAL_AVAILABLE:
+    case SPAPR_DRC_STATE_LOGICAL_UNISOLATE:
+    case SPAPR_DRC_STATE_LOGICAL_CONFIGURED:
+        return RTAS_OUT_SUCCESS; /* Nothing to do */
+    case SPAPR_DRC_STATE_LOGICAL_UNUSABLE:
+        break; /* see below */
+    default:
+        g_assert_not_reached();
+    }
+
     /* if there's no resource/device associated with the DRC, there's
      * no way for us to put it in an allocation state consistent with
      * being 'USABLE'. PAPR 2.7, 13.5.3.4 documents that this should
@@ -176,14 +206,26 @@ static uint32_t drc_set_usable(sPAPRDRConnector *drc)
         return RTAS_OUT_NO_SUCH_INDICATOR;
     }
 
-    drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
+    drc->state = SPAPR_DRC_STATE_LOGICAL_AVAILABLE;
 
     return RTAS_OUT_SUCCESS;
 }
 
 static uint32_t drc_set_unusable(sPAPRDRConnector *drc)
 {
-    drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
+    switch (drc->state) {
+    case SPAPR_DRC_STATE_LOGICAL_UNUSABLE:
+        return RTAS_OUT_SUCCESS; /* Nothing to do */
+    case SPAPR_DRC_STATE_LOGICAL_AVAILABLE:
+        break; /* see below */
+    case SPAPR_DRC_STATE_LOGICAL_UNISOLATE:
+    case SPAPR_DRC_STATE_LOGICAL_CONFIGURED:
+        return RTAS_OUT_NO_SUCH_INDICATOR; /* not allowed */
+    default:
+        g_assert_not_reached();
+    }
+
+    drc->state = SPAPR_DRC_STATE_LOGICAL_UNUSABLE;
     if (drc->unplug_requested) {
         uint32_t drc_index = spapr_drc_index(drc);
         trace_spapr_drc_set_allocation_state_finalizing(drc_index);
@@ -241,11 +283,16 @@ static sPAPRDREntitySense physical_entity_sense(sPAPRDRConnector *drc)
 
 static sPAPRDREntitySense logical_entity_sense(sPAPRDRConnector *drc)
 {
-    if (drc->dev
-        && (drc->allocation_state != SPAPR_DR_ALLOCATION_STATE_UNUSABLE)) {
-        return SPAPR_DR_ENTITY_SENSE_PRESENT;
-    } else {
+    switch (drc->state) {
+    case SPAPR_DRC_STATE_LOGICAL_UNUSABLE:
         return SPAPR_DR_ENTITY_SENSE_UNUSABLE;
+    case SPAPR_DRC_STATE_LOGICAL_AVAILABLE:
+    case SPAPR_DRC_STATE_LOGICAL_UNISOLATE:
+    case SPAPR_DRC_STATE_LOGICAL_CONFIGURED:
+        g_assert(drc->dev);
+        return SPAPR_DR_ENTITY_SENSE_PRESENT;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -338,13 +385,12 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
 {
     trace_spapr_drc_attach(spapr_drc_index(drc));
 
-    if (drc->isolation_state != SPAPR_DR_ISOLATION_STATE_ISOLATED) {
+    if (drc->dev) {
         error_setg(errp, "an attached device is still awaiting release");
         return;
     }
-    if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_PCI) {
-        g_assert(drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE);
-    }
+    g_assert((drc->state == SPAPR_DRC_STATE_LOGICAL_UNUSABLE)
+             || (drc->state == SPAPR_DRC_STATE_PHYSICAL_POWERON));
     g_assert(fdt);
 
     drc->dev = d;
@@ -373,18 +419,16 @@ static void spapr_drc_release(sPAPRDRConnector *drc)
 
 void spapr_drc_detach(sPAPRDRConnector *drc)
 {
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+
     trace_spapr_drc_detach(spapr_drc_index(drc));
 
-    drc->unplug_requested = true;
+    g_assert(drc->dev);
 
-    if (drc->isolation_state != SPAPR_DR_ISOLATION_STATE_ISOLATED) {
-        trace_spapr_drc_awaiting_isolated(spapr_drc_index(drc));
-        return;
-    }
+    drc->unplug_requested = true;
 
-    if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI &&
-        drc->allocation_state != SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
-        trace_spapr_drc_awaiting_unusable(spapr_drc_index(drc));
+    if (drc->state != drck->empty_state) {
+        trace_spapr_drc_awaiting_quiesce(spapr_drc_index(drc));
         return;
     }
 
@@ -393,6 +437,8 @@ void spapr_drc_detach(sPAPRDRConnector *drc)
 
 void spapr_drc_reset(sPAPRDRConnector *drc)
 {
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+
     trace_spapr_drc_reset(spapr_drc_index(drc));
 
     g_free(drc->ccs);
@@ -406,19 +452,10 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
     }
 
     if (drc->dev) {
-        /* A device present at reset is coldplugged */
-        drc->isolation_state = SPAPR_DR_ISOLATION_STATE_UNISOLATED;
-        if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
-            drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
-        }
-        drc->dr_indicator = SPAPR_DR_INDICATOR_ACTIVE;
+        /* A device present at reset is ready to go, same as coldplugged */
+        drc->state = drck->ready_state;
     } else {
-        /* Otherwise device is absent, but might be hotplugged */
-        drc->isolation_state = SPAPR_DR_ISOLATION_STATE_ISOLATED;
-        if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
-            drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
-        }
-        drc->dr_indicator = SPAPR_DR_INDICATOR_INACTIVE;
+        drc->state = drck->empty_state;
     }
 }
 
@@ -431,7 +468,6 @@ static bool spapr_drc_needed(void *opaque)
 {
     sPAPRDRConnector *drc = (sPAPRDRConnector *)opaque;
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    bool rc = false;
     sPAPRDREntitySense value = drck->dr_entity_sense(drc);
 
     /* If no dev is plugged in there is no need to migrate the DRC state */
@@ -440,23 +476,10 @@ static bool spapr_drc_needed(void *opaque)
     }
 
     /*
-     * If there is dev plugged in, we need to migrate the DRC state when
-     * it is different from cold-plugged state
-     */
-    switch (spapr_drc_type(drc)) {
-    case SPAPR_DR_CONNECTOR_TYPE_PCI:
-    case SPAPR_DR_CONNECTOR_TYPE_CPU:
-    case SPAPR_DR_CONNECTOR_TYPE_LMB:
-        rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) &&
-               (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) &&
-               drc->configured);
-        break;
-    case SPAPR_DR_CONNECTOR_TYPE_PHB:
-    case SPAPR_DR_CONNECTOR_TYPE_VIO:
-    default:
-        g_assert_not_reached();
-    }
-    return rc;
+     * We need to migrate the state if it's not equal to the expected
+     * long-term state, which is the same as the coldplugged initial
+     * state */
+    return (drc->state != drck->ready_state);
 }
 
 static const VMStateDescription vmstate_spapr_drc = {
@@ -465,10 +488,8 @@ static const VMStateDescription vmstate_spapr_drc = {
     .minimum_version_id = 1,
     .needed = spapr_drc_needed,
     .fields  = (VMStateField []) {
-        VMSTATE_UINT32(isolation_state, sPAPRDRConnector),
-        VMSTATE_UINT32(allocation_state, sPAPRDRConnector),
+        VMSTATE_UINT32(state, sPAPRDRConnector),
         VMSTATE_UINT32(dr_indicator, sPAPRDRConnector),
-        VMSTATE_BOOL(configured, sPAPRDRConnector),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -537,23 +558,20 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
     object_property_set_bool(OBJECT(drc), true, "realized", NULL);
     g_free(prop_name);
 
-    /* PCI slot always start in a USABLE state, and stay there */
-    if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_PCI) {
-        drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
-    }
-
     return drc;
 }
 
 static void spapr_dr_connector_instance_init(Object *obj)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
     object_property_add_uint32_ptr(obj, "id", &drc->id, NULL);
     object_property_add(obj, "index", "uint32", prop_get_index,
                         NULL, NULL, NULL, NULL);
     object_property_add(obj, "fdt", "struct", prop_get_fdt,
                         NULL, NULL, NULL, NULL);
+    drc->state = drck->empty_state;
 }
 
 static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
@@ -575,6 +593,8 @@ static void spapr_drc_physical_class_init(ObjectClass *k, void *data)
     drck->dr_entity_sense = physical_entity_sense;
     drck->isolate = drc_isolate_physical;
     drck->unisolate = drc_unisolate_physical;
+    drck->ready_state = SPAPR_DRC_STATE_PHYSICAL_CONFIGURED;
+    drck->empty_state = SPAPR_DRC_STATE_PHYSICAL_POWERON;
 }
 
 static void spapr_drc_logical_class_init(ObjectClass *k, void *data)
@@ -584,6 +604,8 @@ static void spapr_drc_logical_class_init(ObjectClass *k, void *data)
     drck->dr_entity_sense = logical_entity_sense;
     drck->isolate = drc_isolate_logical;
     drck->unisolate = drc_unisolate_logical;
+    drck->ready_state = SPAPR_DRC_STATE_LOGICAL_CONFIGURED;
+    drck->empty_state = SPAPR_DRC_STATE_LOGICAL_UNUSABLE;
 }
 
 static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
@@ -987,6 +1009,7 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
     uint64_t wa_offset;
     uint32_t drc_index;
     sPAPRDRConnector *drc;
+    sPAPRDRConnectorClass *drck;
     sPAPRConfigureConnectorState *ccs;
     sPAPRDRCCResponse resp = SPAPR_DR_CC_RESPONSE_CONTINUE;
     int rc;
@@ -1006,12 +1029,17 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
         goto out;
     }
 
-    if (!drc->fdt) {
-        trace_spapr_rtas_ibm_configure_connector_missing_fdt(drc_index);
+    if ((drc->state != SPAPR_DRC_STATE_LOGICAL_UNISOLATE)
+        && (drc->state != SPAPR_DRC_STATE_PHYSICAL_UNISOLATE)) {
+        /* Need to unisolate the device before configuring */
         rc = SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
         goto out;
     }
 
+    g_assert(drc->fdt);
+
+    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+
     ccs = drc->ccs;
     if (!ccs) {
         ccs = g_new0(sPAPRConfigureConnectorState, 1);
@@ -1041,18 +1069,11 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
         case FDT_END_NODE:
             ccs->fdt_depth--;
             if (ccs->fdt_depth == 0) {
-                sPAPRDRIsolationState state = drc->isolation_state;
                 uint32_t drc_index = spapr_drc_index(drc);
-                /* done sending the device tree, don't need to track
-                 * the state anymore
-                 */
+
+                /* done sending the device tree, move to configured state */
                 trace_spapr_drc_set_configured(drc_index);
-                if (state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
-                    drc->configured = true;
-                } else {
-                    /* guest should be not configuring an isolated device */
-                    trace_spapr_drc_set_configured_skipping(drc_index);
-                }
+                drc->state = drck->ready_state;
                 g_free(ccs);
                 drc->ccs = NULL;
                 ccs = NULL;
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 3e8e3cf..8e79f7e 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -46,8 +46,7 @@ spapr_drc_set_configured(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_set_configured_skipping(uint32_t index) "drc: 0x%"PRIx32", isolated device"
 spapr_drc_attach(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_detach(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_awaiting_isolated(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_awaiting_unusable(uint32_t index) "drc: 0x%"PRIx32
+spapr_drc_awaiting_quiesce(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_awaiting_allocation(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_reset(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_realize(uint32_t index) "drc: 0x%"PRIx32
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 5fa502e..4ceaaf0 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -173,6 +173,24 @@ typedef enum {
     SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE = -9003,
 } sPAPRDRCCResponse;
 
+typedef enum {
+    /*
+     * Values come from Fig. 12 in LoPAPR section 13.4
+     *
+     * These are exposed in the migration stream, so don't change
+     * them.
+     */
+    SPAPR_DRC_STATE_INVALID             = 0,
+    SPAPR_DRC_STATE_LOGICAL_UNUSABLE    = 1,
+    SPAPR_DRC_STATE_LOGICAL_AVAILABLE   = 2,
+    SPAPR_DRC_STATE_LOGICAL_UNISOLATE   = 3,
+    SPAPR_DRC_STATE_LOGICAL_CONFIGURED  = 4,
+    SPAPR_DRC_STATE_PHYSICAL_AVAILABLE  = 5,
+    SPAPR_DRC_STATE_PHYSICAL_POWERON    = 6,
+    SPAPR_DRC_STATE_PHYSICAL_UNISOLATE  = 7,
+    SPAPR_DRC_STATE_PHYSICAL_CONFIGURED = 8,
+} sPAPRDRCState;
+
 /* rtas-configure-connector state */
 typedef struct sPAPRConfigureConnectorState {
     int fdt_offset;
@@ -189,14 +207,11 @@ typedef struct sPAPRDRConnector {
     /* DR-indicator */
     uint32_t dr_indicator;
 
-    /* sensor/indicator states */
-    uint32_t isolation_state;
-    uint32_t allocation_state;
+    uint32_t state;
 
     /* configure-connector state */
     void *fdt;
     int fdt_start_offset;
-    bool configured;
     sPAPRConfigureConnectorState *ccs;
 
     /* device pointer, via link property */
@@ -207,6 +222,8 @@ typedef struct sPAPRDRConnector {
 typedef struct sPAPRDRConnectorClass {
     /*< private >*/
     DeviceClass parent;
+    sPAPRDRCState empty_state;
+    sPAPRDRCState ready_state;
 
     /*< public >*/
     sPAPRDRConnectorTypeShift typeshift;
-- 
2.9.4
