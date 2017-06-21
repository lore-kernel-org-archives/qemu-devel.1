Received: from eggs.gnu.org ([2001:4830:134:3::10]:40397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNbmy-0003EW-1R
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNbmw-0001zt-OP
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:19:04 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 21 Jun 2017 17:18:48 +0800
Message-Id: <20170621091848.28256-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170621091848.28256-1-david@gibson.dropbear.id.au>
References: <20170621091848.28256-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 5/5] spapr: Remove sPAPRConfigureConnectorState
 sub-structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: bharata@linux.vnet.ibm.com, groug@kaod.org, sursingh@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Most of the time, the state of a DRC object is contained in the single
'state' variable.  However, during the transition from UNISOLATE to
CONFIGURED state requires multiple calls to the ibm,configure-connector
RTAS call to retrieve the device tree for the attached device.  We need
some extra state to keep track of where we're up to in delivering the
device tree information to the guest.

Currently that extra state is in a sPAPRConfigureConnectorState
substructure which is only allocated when we're in the middle of the
configure connector process.  That sounds like a good idea, but the extra
state is only two integers - on many platforms that will take up the same
room as the (maybe NULL) ccs pointer even before malloc() overhead.  Plus
it's another object whose lifetime we need to manage.  In short, it's not
worth it.

So, fold the sPAPRConfigureConnectorState substructure directly into the
DRC object.

Previously the structure was allocated lazily when the configure-connector
call discovers it's not there.  Now, we need to initialize the subfields
pre-emptively, as soon as we enter UNISOLATE state.

Although it's not strictly necessary (the field values should only ever
be consulted when in UNISOLATE state), we try to keep them at -1 when in
other states, as a debugging aid.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c         | 56 +++++++++++++++-------------------------------
 include/hw/ppc/spapr_drc.h | 16 +++++--------
 2 files changed, 24 insertions(+), 48 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 54c3757..4251031 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -59,14 +59,6 @@ static uint32_t drc_isolate_physical(sPAPRDRConnector *drc)
         g_assert_not_reached();
     }
 
-    /* if the guest is configuring a device attached to this DRC, we
-     * should reset the configuration state at this point since it may
-     * no longer be reliable (guest released device and needs to start
-     * over, or unplug occurred so the FDT is no longer valid)
-     */
-    g_free(drc->ccs);
-    drc->ccs = NULL;
-
     drc->state = SPAPR_DRC_STATE_PHYSICAL_POWERON;
 
     if (drc->unplug_requested) {
@@ -99,6 +91,8 @@ static uint32_t drc_unisolate_physical(sPAPRDRConnector *drc)
     }
 
     drc->state = SPAPR_DRC_STATE_PHYSICAL_UNISOLATE;
+    drc->ccs_offset = drc->fdt_start_offset;
+    drc->ccs_depth = 0;
 
     return RTAS_OUT_SUCCESS;
 }
@@ -117,14 +111,6 @@ static uint32_t drc_isolate_logical(sPAPRDRConnector *drc)
         g_assert_not_reached();
     }
 
-    /* if the guest is configuring a device attached to this DRC, we
-     * should reset the configuration state at this point since it may
-     * no longer be reliable (guest released device and needs to start
-     * over, or unplug occurred so the FDT is no longer valid)
-     */
-    g_free(drc->ccs);
-    drc->ccs = NULL;
-
     /*
      * Fail any requests to ISOLATE the LMB DRC if this LMB doesn't
      * belong to a DIMM device that is marked for removal.
@@ -176,6 +162,9 @@ static uint32_t drc_unisolate_logical(sPAPRDRConnector *drc)
     g_assert(drc->dev);
 
     drc->state = SPAPR_DRC_STATE_LOGICAL_UNISOLATE;
+    drc->ccs_offset = drc->fdt_start_offset;
+    drc->ccs_depth = 0;
+
     return RTAS_OUT_SUCCESS;
 }
 
@@ -442,9 +431,6 @@ static void drc_reset(void *opaque)
 
     trace_spapr_drc_reset(spapr_drc_index(drc));
 
-    g_free(drc->ccs);
-    drc->ccs = NULL;
-
     /* immediately upon reset we can safely assume DRCs whose devices
      * are pending removal can be safely removed.
      */
@@ -460,6 +446,9 @@ static void drc_reset(void *opaque)
     } else {
         drc->state = drck->empty_state;
     }
+
+    drc->ccs_offset = -1;
+    drc->ccs_depth = -1;
 }
 
 static bool spapr_drc_needed(void *opaque)
@@ -1008,7 +997,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
     uint32_t drc_index;
     sPAPRDRConnector *drc;
     sPAPRDRConnectorClass *drck;
-    sPAPRConfigureConnectorState *ccs;
     sPAPRDRCCResponse resp = SPAPR_DR_CC_RESPONSE_CONTINUE;
     int rc;
 
@@ -1038,25 +1026,18 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
 
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
-    ccs = drc->ccs;
-    if (!ccs) {
-        ccs = g_new0(sPAPRConfigureConnectorState, 1);
-        ccs->fdt_offset = drc->fdt_start_offset;
-        drc->ccs = ccs;
-    }
-
     do {
         uint32_t tag;
         const char *name;
         const struct fdt_property *prop;
         int fdt_offset_next, prop_len;
 
-        tag = fdt_next_tag(drc->fdt, ccs->fdt_offset, &fdt_offset_next);
+        tag = fdt_next_tag(drc->fdt, drc->ccs_offset, &fdt_offset_next);
 
         switch (tag) {
         case FDT_BEGIN_NODE:
-            ccs->fdt_depth++;
-            name = fdt_get_name(drc->fdt, ccs->fdt_offset, NULL);
+            drc->ccs_depth++;
+            name = fdt_get_name(drc->fdt, drc->ccs_offset, NULL);
 
             /* provide the name of the next OF node */
             wa_offset = CC_VAL_DATA_OFFSET;
@@ -1065,23 +1046,22 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
             resp = SPAPR_DR_CC_RESPONSE_NEXT_CHILD;
             break;
         case FDT_END_NODE:
-            ccs->fdt_depth--;
-            if (ccs->fdt_depth == 0) {
+            drc->ccs_depth--;
+            if (drc->ccs_depth == 0) {
                 uint32_t drc_index = spapr_drc_index(drc);
 
                 /* done sending the device tree, move to configured state */
                 trace_spapr_drc_set_configured(drc_index);
                 drc->state = drck->ready_state;
-                g_free(ccs);
-                drc->ccs = NULL;
-                ccs = NULL;
+                drc->ccs_offset = -1;
+                drc->ccs_depth = -1;
                 resp = SPAPR_DR_CC_RESPONSE_SUCCESS;
             } else {
                 resp = SPAPR_DR_CC_RESPONSE_PREV_PARENT;
             }
             break;
         case FDT_PROP:
-            prop = fdt_get_property_by_offset(drc->fdt, ccs->fdt_offset,
+            prop = fdt_get_property_by_offset(drc->fdt, drc->ccs_offset,
                                               &prop_len);
             name = fdt_string(drc->fdt, fdt32_to_cpu(prop->nameoff));
 
@@ -1106,8 +1086,8 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
             /* keep seeking for an actionable tag */
             break;
         }
-        if (ccs) {
-            ccs->fdt_offset = fdt_offset_next;
+        if (drc->ccs_offset >= 0) {
+            drc->ccs_offset = fdt_offset_next;
         }
     } while (resp == SPAPR_DR_CC_RESPONSE_CONTINUE);
 
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index c229722..4c54864 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -190,12 +190,6 @@ typedef enum {
     SPAPR_DRC_STATE_PHYSICAL_CONFIGURED = 8,
 } sPAPRDRCState;
 
-/* rtas-configure-connector state */
-typedef struct sPAPRConfigureConnectorState {
-    int fdt_offset;
-    int fdt_depth;
-} sPAPRConfigureConnectorState;
-
 typedef struct sPAPRDRConnector {
     /*< private >*/
     DeviceState parent;
@@ -208,14 +202,16 @@ typedef struct sPAPRDRConnector {
 
     uint32_t state;
 
-    /* configure-connector state */
-    void *fdt;
-    int fdt_start_offset;
-    sPAPRConfigureConnectorState *ccs;
+    /* RTAS ibm,configure-connector state */
+    /* (only valid in UNISOLATE state) */
+    int ccs_offset;
+    int ccs_depth;
 
     /* device pointer, via link property */
     DeviceState *dev;
     bool unplug_requested;
+    void *fdt;
+    int fdt_start_offset;
 } sPAPRDRConnector;
 
 typedef struct sPAPRDRConnectorClass {
-- 
2.9.4
