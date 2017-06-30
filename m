Received: from eggs.gnu.org ([2001:4830:134:3::10]:34712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRs-0000Aq-Hi
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRp-00082q-6k
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:52 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:32 +1000
Message-Id: <20170630104632.27942-22-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 21/21] spapr: Clean up DRC set_isolation_state()
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

There are substantial differences in the various paths through
set_isolation_state(), both for setting to ISOLATED versus UNISOLATED
state and for logical versus physical DRCs.

So, split the set_isolation_state() method into isolate() and unisolate()
methods, and give it different implementations for the two DRC types.

Factor some minimal common checks, including for valid indicator values
(which we weren't previously checking) into rtas_set_isolation_state().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c         | 145 ++++++++++++++++++++++++++++++++-------------
 include/hw/ppc/spapr_drc.h |   6 +-
 2 files changed, 105 insertions(+), 46 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index dbcd670..bd40b84 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -46,30 +46,64 @@ uint32_t spapr_drc_index(sPAPRDRConnector *drc)
         | (drc->id & DRC_INDEX_ID_MASK);
 }
 
-static uint32_t set_isolation_state(sPAPRDRConnector *drc,
-                                    sPAPRDRIsolationState state)
+static uint32_t drc_isolate_physical(sPAPRDRConnector *drc)
 {
-    trace_spapr_drc_set_isolation_state(spapr_drc_index(drc), state);
-
     /* if the guest is configuring a device attached to this DRC, we
      * should reset the configuration state at this point since it may
      * no longer be reliable (guest released device and needs to start
      * over, or unplug occurred so the FDT is no longer valid)
      */
-    if (state == SPAPR_DR_ISOLATION_STATE_ISOLATED) {
-        g_free(drc->ccs);
-        drc->ccs = NULL;
-    }
+    g_free(drc->ccs);
+    drc->ccs = NULL;
 
-    if (state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
-        /* cannot unisolate a non-existent resource, and, or resources
-         * which are in an 'UNUSABLE' allocation state. (PAPR 2.7, 13.5.3.5)
-         */
-        if (!drc->dev ||
-            drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
-            return RTAS_OUT_NO_SUCH_INDICATOR;
+    drc->isolation_state = SPAPR_DR_ISOLATION_STATE_ISOLATED;
+
+    /* if we're awaiting release, but still in an unconfigured state,
+     * it's likely the guest is still in the process of configuring
+     * the device and is transitioning the devices to an ISOLATED
+     * state as a part of that process. so we only complete the
+     * removal when this transition happens for a device in a
+     * configured state, as suggested by the state diagram from PAPR+
+     * 2.7, 13.4
+     */
+    if (drc->awaiting_release) {
+        uint32_t drc_index = spapr_drc_index(drc);
+        if (drc->configured) {
+            trace_spapr_drc_set_isolation_state_finalizing(drc_index);
+            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
+        } else {
+            trace_spapr_drc_set_isolation_state_deferring(drc_index);
         }
     }
+    drc->configured = false;
+
+    return RTAS_OUT_SUCCESS;
+}
+
+static uint32_t drc_unisolate_physical(sPAPRDRConnector *drc)
+{
+    /* cannot unisolate a non-existent resource, and, or resources
+     * which are in an 'UNUSABLE' allocation state. (PAPR 2.7,
+     * 13.5.3.5)
+     */
+    if (!drc->dev) {
+        return RTAS_OUT_NO_SUCH_INDICATOR;
+    }
+
+    drc->isolation_state = SPAPR_DR_ISOLATION_STATE_UNISOLATED;
+
+    return RTAS_OUT_SUCCESS;
+}
+
+static uint32_t drc_isolate_logical(sPAPRDRConnector *drc)
+{
+    /* if the guest is configuring a device attached to this DRC, we
+     * should reset the configuration state at this point since it may
+     * no longer be reliable (guest released device and needs to start
+     * over, or unplug occurred so the FDT is no longer valid)
+     */
+    g_free(drc->ccs);
+    drc->ccs = NULL;
 
     /*
      * Fail any requests to ISOLATE the LMB DRC if this LMB doesn't
@@ -81,35 +115,47 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
      * If the LMB being removed doesn't belong to a DIMM device that is
      * actually being unplugged, fail the isolation request here.
      */
-    if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_LMB) {
-        if ((state == SPAPR_DR_ISOLATION_STATE_ISOLATED) &&
-             !drc->awaiting_release) {
-            return RTAS_OUT_HW_ERROR;
-        }
+    if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_LMB
+        && !drc->awaiting_release) {
+        return RTAS_OUT_HW_ERROR;
     }
 
-    drc->isolation_state = state;
+    drc->isolation_state = SPAPR_DR_ISOLATION_STATE_ISOLATED;
 
-    if (drc->isolation_state == SPAPR_DR_ISOLATION_STATE_ISOLATED) {
-        /* if we're awaiting release, but still in an unconfigured state,
-         * it's likely the guest is still in the process of configuring
-         * the device and is transitioning the devices to an ISOLATED
-         * state as a part of that process. so we only complete the
-         * removal when this transition happens for a device in a
-         * configured state, as suggested by the state diagram from
-         * PAPR+ 2.7, 13.4
-         */
-        if (drc->awaiting_release) {
-            uint32_t drc_index = spapr_drc_index(drc);
-            if (drc->configured) {
-                trace_spapr_drc_set_isolation_state_finalizing(drc_index);
-                spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
-            } else {
-                trace_spapr_drc_set_isolation_state_deferring(drc_index);
-            }
+    /* if we're awaiting release, but still in an unconfigured state,
+     * it's likely the guest is still in the process of configuring
+     * the device and is transitioning the devices to an ISOLATED
+     * state as a part of that process. so we only complete the
+     * removal when this transition happens for a device in a
+     * configured state, as suggested by the state diagram from PAPR+
+     * 2.7, 13.4
+     */
+    if (drc->awaiting_release) {
+        uint32_t drc_index = spapr_drc_index(drc);
+        if (drc->configured) {
+            trace_spapr_drc_set_isolation_state_finalizing(drc_index);
+            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
+        } else {
+            trace_spapr_drc_set_isolation_state_deferring(drc_index);
         }
-        drc->configured = false;
     }
+    drc->configured = false;
+
+    return RTAS_OUT_SUCCESS;
+}
+
+static uint32_t drc_unisolate_logical(sPAPRDRConnector *drc)
+{
+    /* cannot unisolate a non-existent resource, and, or resources
+     * which are in an 'UNUSABLE' allocation state. (PAPR 2.7,
+     * 13.5.3.5)
+     */
+    if (!drc->dev ||
+        drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
+        return RTAS_OUT_NO_SUCH_INDICATOR;
+    }
+
+    drc->isolation_state = SPAPR_DR_ISOLATION_STATE_UNISOLATED;
 
     return RTAS_OUT_SUCCESS;
 }
@@ -555,7 +601,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     dk->reset = reset;
     dk->realize = realize;
     dk->unrealize = unrealize;
-    drck->set_isolation_state = set_isolation_state;
     drck->release_pending = release_pending;
     /*
      * Reason: it crashes FIXME find and document the real reason
@@ -568,6 +613,8 @@ static void spapr_drc_physical_class_init(ObjectClass *k, void *data)
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
     drck->dr_entity_sense = physical_entity_sense;
+    drck->isolate = drc_isolate_physical;
+    drck->unisolate = drc_unisolate_physical;
 }
 
 static void spapr_drc_logical_class_init(ObjectClass *k, void *data)
@@ -575,6 +622,8 @@ static void spapr_drc_logical_class_init(ObjectClass *k, void *data)
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
     drck->dr_entity_sense = logical_entity_sense;
+    drck->isolate = drc_isolate_logical;
+    drck->unisolate = drc_unisolate_logical;
 }
 
 static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
@@ -815,11 +864,23 @@ static uint32_t rtas_set_isolation_state(uint32_t idx, uint32_t state)
     sPAPRDRConnectorClass *drck;
 
     if (!drc) {
-        return RTAS_OUT_PARAM_ERROR;
+        return RTAS_OUT_NO_SUCH_INDICATOR;
     }
 
+    trace_spapr_drc_set_isolation_state(spapr_drc_index(drc), state);
+
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    return drck->set_isolation_state(drc, state);
+
+    switch (state) {
+    case SPAPR_DR_ISOLATION_STATE_ISOLATED:
+        return drck->isolate(drc);
+
+    case SPAPR_DR_ISOLATION_STATE_UNISOLATED:
+        return drck->unisolate(drc);
+
+    default:
+        return RTAS_OUT_PARAM_ERROR;
+    }
 }
 
 static uint32_t rtas_set_allocation_state(uint32_t idx, uint32_t state)
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 1674b66..d9cacb3 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -215,10 +215,8 @@ typedef struct sPAPRDRConnectorClass {
     const char *drc_name_prefix; /* used other places in device tree */
 
     sPAPRDREntitySense (*dr_entity_sense)(sPAPRDRConnector *drc);
-
-    /* accessors for guest-visible (generally via RTAS) DR state */
-    uint32_t (*set_isolation_state)(sPAPRDRConnector *drc,
-                                    sPAPRDRIsolationState state);
+    uint32_t (*isolate)(sPAPRDRConnector *drc);
+    uint32_t (*unisolate)(sPAPRDRConnector *drc);
 
     /* QEMU interfaces for managing hotplug operations */
     bool (*release_pending)(sPAPRDRConnector *drc);
-- 
2.9.4
