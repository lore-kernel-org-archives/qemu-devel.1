Received: from eggs.gnu.org ([2001:4830:134:3::10]:43537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGh20-0008Rp-QS
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGh1z-0006kI-15
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:30:00 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  2 Jun 2017 17:29:50 +1000
Message-Id: <20170602072952.25454-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170602072952.25454-1-david@gibson.dropbear.id.au>
References: <20170602072952.25454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 3/5] spapr: Move configure-connector state into
 DRC
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

Currently the sPAPRMachineState contains a of sPAPRConfigureConnector
structures which store intermediate state for the ibm,configure-connector
RTAS call.

This was an attempt to separate this state from the core of the DRC state.
However the configure connector process is intimately tied to the DRC
model, so there's really no point trying to have two levels of interface
here.

Moving the configure-connector state into its corresponding DRC allows
removal of a number of helpers for maintaining the anciliary list.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             |  4 ---
 hw/ppc/spapr_drc.c         | 73 ++++++++++++----------------------------------
 include/hw/ppc/spapr.h     | 14 ---------
 include/hw/ppc/spapr_drc.h |  7 +++++
 4 files changed, 25 insertions(+), 73 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7aac3b9..6234dbd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2339,10 +2339,6 @@ static void ppc_spapr_init(MachineState *machine)
     register_savevm_live(NULL, "spapr/htab", -1, 1,
                          &savevm_htab_handlers, spapr);
 
-    /* used by RTAS */
-    QTAILQ_INIT(&spapr->ccs_list);
-    qemu_register_reset(spapr_ccs_reset_hook, spapr);
-
     qemu_register_boot_set(spapr_boot_set, spapr);
 
     if (kvm_enabled()) {
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 2514f87..27d4bd3 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -27,34 +27,6 @@
 #define DRC_INDEX_TYPE_SHIFT 28
 #define DRC_INDEX_ID_MASK ((1ULL << DRC_INDEX_TYPE_SHIFT) - 1)
 
-static sPAPRConfigureConnectorState *spapr_ccs_find(sPAPRMachineState *spapr,
-                                                    uint32_t drc_index)
-{
-    sPAPRConfigureConnectorState *ccs = NULL;
-
-    QTAILQ_FOREACH(ccs, &spapr->ccs_list, next) {
-        if (ccs->drc_index == drc_index) {
-            break;
-        }
-    }
-
-    return ccs;
-}
-
-static void spapr_ccs_add(sPAPRMachineState *spapr,
-                          sPAPRConfigureConnectorState *ccs)
-{
-    g_assert(!spapr_ccs_find(spapr, ccs->drc_index));
-    QTAILQ_INSERT_HEAD(&spapr->ccs_list, ccs, next);
-}
-
-static void spapr_ccs_remove(sPAPRMachineState *spapr,
-                             sPAPRConfigureConnectorState *ccs)
-{
-    QTAILQ_REMOVE(&spapr->ccs_list, ccs, next);
-    g_free(ccs);
-}
-
 sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc)
 {
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
@@ -81,6 +53,16 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
 
     trace_spapr_drc_set_isolation_state(spapr_drc_index(drc), state);
 
+    /* if the guest is configuring a device attached to this DRC, we
+     * should reset the configuration state at this point since it may
+     * no longer be reliable (guest released device and needs to start
+     * over, or unplug occurred so the FDT is no longer valid)
+     */
+    if (state == SPAPR_DR_ISOLATION_STATE_ISOLATED) {
+        g_free(drc->ccs);
+        drc->ccs = NULL;
+    }
+
     if (state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
         /* cannot unisolate a non-existent resource, and, or resources
          * which are in an 'UNUSABLE' allocation state. (PAPR 2.7, 13.5.3.5)
@@ -485,6 +467,10 @@ static void reset(DeviceState *d)
     sPAPRDREntitySense state;
 
     trace_spapr_drc_reset(spapr_drc_index(drc));
+
+    g_free(drc->ccs);
+    drc->ccs = NULL;
+
     /* immediately upon reset we can safely assume DRCs whose devices
      * are pending removal can be safely removed, and that they will
      * subsequently be left in an ISOLATED state. move the DRC to this
@@ -1020,19 +1006,6 @@ static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 
     switch (sensor_type) {
     case RTAS_SENSOR_TYPE_ISOLATION_STATE:
-        /* if the guest is configuring a device attached to this
-         * DRC, we should reset the configuration state at this
-         * point since it may no longer be reliable (guest released
-         * device and needs to start over, or unplug occurred so
-         * the FDT is no longer valid)
-         */
-        if (sensor_state == SPAPR_DR_ISOLATION_STATE_ISOLATED) {
-            sPAPRConfigureConnectorState *ccs = spapr_ccs_find(spapr,
-                                                               sensor_index);
-            if (ccs) {
-                spapr_ccs_remove(spapr, ccs);
-            }
-        }
         ret = drck->set_isolation_state(drc, sensor_state);
         break;
     case RTAS_SENSOR_TYPE_DR:
@@ -1116,16 +1089,6 @@ static void configure_connector_st(target_ulong addr, target_ulong offset,
                               buf, MIN(len, CC_WA_LEN - offset));
 }
 
-void spapr_ccs_reset_hook(void *opaque)
-{
-    sPAPRMachineState *spapr = opaque;
-    sPAPRConfigureConnectorState *ccs, *ccs_tmp;
-
-    QTAILQ_FOREACH_SAFE(ccs, &spapr->ccs_list, next, ccs_tmp) {
-        spapr_ccs_remove(spapr, ccs);
-    }
-}
-
 static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
                                          sPAPRMachineState *spapr,
                                          uint32_t token, uint32_t nargs,
@@ -1161,12 +1124,11 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
         goto out;
     }
 
-    ccs = spapr_ccs_find(spapr, drc_index);
+    ccs = drc->ccs;
     if (!ccs) {
         ccs = g_new0(sPAPRConfigureConnectorState, 1);
         ccs->fdt_offset = drc->fdt_start_offset;
-        ccs->drc_index = drc_index;
-        spapr_ccs_add(spapr, ccs);
+        drc->ccs = ccs;
     }
 
     do {
@@ -1203,7 +1165,8 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
                     /* guest should be not configuring an isolated device */
                     trace_spapr_drc_set_configured_skipping(drc_index);
                 }
-                spapr_ccs_remove(spapr, ccs);
+                g_free(ccs);
+                drc->ccs = NULL;
                 ccs = NULL;
                 resp = SPAPR_DR_CC_RESPONSE_SUCCESS;
             } else {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 98fb78b..f973b02 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -11,7 +11,6 @@
 struct VIOsPAPRBus;
 struct sPAPRPHBState;
 struct sPAPRNVRAM;
-typedef struct sPAPRConfigureConnectorState sPAPRConfigureConnectorState;
 typedef struct sPAPREventLogEntry sPAPREventLogEntry;
 typedef struct sPAPREventSource sPAPREventSource;
 
@@ -102,9 +101,6 @@ struct sPAPRMachineState {
     bool htab_first_pass;
     int htab_fd;
 
-    /* RTAS state */
-    QTAILQ_HEAD(, sPAPRConfigureConnectorState) ccs_list;
-
     /* Pending DIMM unplug cache. It is populated when a LMB
      * unplug starts. It can be regenerated if a migration
      * occurs during the unplug process. */
@@ -646,16 +642,6 @@ void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
 void spapr_core_release(DeviceState *dev);
 void spapr_lmb_release(DeviceState *dev);
 
-/* rtas-configure-connector state */
-struct sPAPRConfigureConnectorState {
-    uint32_t drc_index;
-    int fdt_offset;
-    int fdt_depth;
-    QTAILQ_ENTRY(sPAPRConfigureConnectorState) next;
-};
-
-void spapr_ccs_reset_hook(void *opaque);
-
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
 int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
 
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index d8cb84b..53b0f8b 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -172,6 +172,12 @@ typedef enum {
     SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE = -9003,
 } sPAPRDRCCResponse;
 
+/* rtas-configure-connector state */
+typedef struct sPAPRConfigureConnectorState {
+    int fdt_offset;
+    int fdt_depth;
+} sPAPRConfigureConnectorState;
+
 typedef struct sPAPRDRConnector {
     /*< private >*/
     DeviceState parent;
@@ -189,6 +195,7 @@ typedef struct sPAPRDRConnector {
     void *fdt;
     int fdt_start_offset;
     bool configured;
+    sPAPRConfigureConnectorState *ccs;
 
     bool awaiting_release;
     bool signalled;
-- 
2.9.4
