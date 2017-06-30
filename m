Received: from eggs.gnu.org ([2001:4830:134:3::10]:34395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRk-0008T1-Pz
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRj-0007uN-05
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:31 +1000
Message-Id: <20170630104632.27942-21-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 20/21] spapr: Clean up DRC set_allocation_state
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

The allocation-state indicator should only actually be implemented for
"logical" DRCs, not physical ones.  Factor a check for this, and also for
valid indicator state values into rtas_set_allocation_state().  Because
they don't exist for physical DRCs, there's no reason that we'd ever want
more than one method implementation, so it can just be a plain function.

In addition, the setting to USABLE and setting to UNUSABLE paths in
set_allocation_state() don't actually have much in common.  So, split the
method separate functions for each parameter value (drc_set_usable()
and drc_set_unusable()).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c         | 73 ++++++++++++++++++++++++++++------------------
 include/hw/ppc/spapr_drc.h |  2 --
 2 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 9a2511f..dbcd670 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -114,33 +114,42 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
     return RTAS_OUT_SUCCESS;
 }
 
-static uint32_t set_allocation_state(sPAPRDRConnector *drc,
-                                     sPAPRDRAllocationState state)
+static uint32_t drc_set_usable(sPAPRDRConnector *drc)
 {
-    trace_spapr_drc_set_allocation_state(spapr_drc_index(drc), state);
-
-    if (state == SPAPR_DR_ALLOCATION_STATE_USABLE) {
-        /* if there's no resource/device associated with the DRC, there's
-         * no way for us to put it in an allocation state consistent with
-         * being 'USABLE'. PAPR 2.7, 13.5.3.4 documents that this should
-         * result in an RTAS return code of -3 / "no such indicator"
+    /* if there's no resource/device associated with the DRC, there's
+     * no way for us to put it in an allocation state consistent with
+     * being 'USABLE'. PAPR 2.7, 13.5.3.4 documents that this should
+     * result in an RTAS return code of -3 / "no such indicator"
+     */
+    if (!drc->dev) {
+        return RTAS_OUT_NO_SUCH_INDICATOR;
+    }
+    if (drc->awaiting_release && drc->awaiting_allocation) {
+        /* kernel is acknowledging a previous hotplug event
+         * while we are already removing it.
+         * it's safe to ignore awaiting_allocation here since we know the
+         * situation is predicated on the guest either already having done
+         * so (boot-time hotplug), or never being able to acquire in the
+         * first place (hotplug followed by immediate unplug).
          */
-        if (!drc->dev) {
-            return RTAS_OUT_NO_SUCH_INDICATOR;
-        }
+        return RTAS_OUT_NO_SUCH_INDICATOR;
     }
 
-    if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
-        drc->allocation_state = state;
-        if (drc->awaiting_release &&
-            drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
-            uint32_t drc_index = spapr_drc_index(drc);
-            trace_spapr_drc_set_allocation_state_finalizing(drc_index);
-            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
-        } else if (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) {
-            drc->awaiting_allocation = false;
-        }
+    drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
+    drc->awaiting_allocation = false;
+
+    return RTAS_OUT_SUCCESS;
+}
+
+static uint32_t drc_set_unusable(sPAPRDRConnector *drc)
+{
+    drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
+    if (drc->awaiting_release) {
+        uint32_t drc_index = spapr_drc_index(drc);
+        trace_spapr_drc_set_allocation_state_finalizing(drc_index);
+        spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
     }
+
     return RTAS_OUT_SUCCESS;
 }
 
@@ -547,7 +556,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     dk->realize = realize;
     dk->unrealize = unrealize;
     drck->set_isolation_state = set_isolation_state;
-    drck->set_allocation_state = set_allocation_state;
     drck->release_pending = release_pending;
     /*
      * Reason: it crashes FIXME find and document the real reason
@@ -817,14 +825,23 @@ static uint32_t rtas_set_isolation_state(uint32_t idx, uint32_t state)
 static uint32_t rtas_set_allocation_state(uint32_t idx, uint32_t state)
 {
     sPAPRDRConnector *drc = spapr_drc_by_index(idx);
-    sPAPRDRConnectorClass *drck;
 
-    if (!drc) {
-        return RTAS_OUT_PARAM_ERROR;
+    if (!drc || !object_dynamic_cast(OBJECT(drc), TYPE_SPAPR_DRC_LOGICAL)) {
+        return RTAS_OUT_NO_SUCH_INDICATOR;
     }
 
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    return drck->set_allocation_state(drc, state);
+    trace_spapr_drc_set_allocation_state(spapr_drc_index(drc), state);
+
+    switch (state) {
+    case SPAPR_DR_ALLOCATION_STATE_USABLE:
+        return drc_set_usable(drc);
+
+    case SPAPR_DR_ALLOCATION_STATE_UNUSABLE:
+        return drc_set_unusable(drc);
+
+    default:
+        return RTAS_OUT_PARAM_ERROR;
+    }
 }
 
 static uint32_t rtas_set_dr_indicator(uint32_t idx, uint32_t state)
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 388e2a6..1674b66 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -219,8 +219,6 @@ typedef struct sPAPRDRConnectorClass {
     /* accessors for guest-visible (generally via RTAS) DR state */
     uint32_t (*set_isolation_state)(sPAPRDRConnector *drc,
                                     sPAPRDRIsolationState state);
-    uint32_t (*set_allocation_state)(sPAPRDRConnector *drc,
-                                     sPAPRDRAllocationState state);
 
     /* QEMU interfaces for managing hotplug operations */
     bool (*release_pending)(sPAPRDRConnector *drc);
-- 
2.9.4
