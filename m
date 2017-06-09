Received: from eggs.gnu.org ([2001:4830:134:3::10]:47043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRy-0003x7-2Z
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRw-0006dz-1V
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:10 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:40 +1000
Message-Id: <20170609052652.23200-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/20] spapr: Clean up handling of DR-indicator
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

There are 3 types of "indicator" associated with hotplug in the PAPR spec
the "allocation state", "isolation state" and "DR-indicator".  The first
two are intimately tied to the various state transitions associated with
hotplug.  The DR-indicator, however, is different and simpler.

It's basically just a guest controlled variable which can be used by the
guest to flag state or problems associated with a device.  The idea is that
the hypervisor can use it to present information back on management
consoles (on some machines with PowerVM it may even control physical LEDs
on the machine case associated with the relevant device).

For that reason, there's only ever likely to be a single update
implementation so the set_indicator_state method isn't useful.  Replace it
with a direct function call.

While we're there, make some small associated cleanups:
  * PAPR doesn't use the term "indicator state", just "DR-indicator" and
the allocation state and isolation state are also considered "indicators".
Rename things to be less confusing
  * Fold set_indicator_state() and rtas_set_indicator_state() into a single
rtas_set_dr_indicator() function.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Acked-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c         | 25 ++++++++-----------------
 hw/ppc/trace-events        |  2 +-
 include/hw/ppc/spapr_drc.h | 16 ++++++++--------
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index f0cff0b..19e2c0d 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -116,14 +116,6 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
     return RTAS_OUT_SUCCESS;
 }
 
-static uint32_t set_indicator_state(sPAPRDRConnector *drc,
-                                    sPAPRDRIndicatorState state)
-{
-    trace_spapr_drc_set_indicator_state(spapr_drc_index(drc), state);
-    drc->indicator_state = state;
-    return RTAS_OUT_SUCCESS;
-}
-
 static uint32_t set_allocation_state(sPAPRDRConnector *drc,
                                      sPAPRDRAllocationState state)
 {
@@ -321,7 +313,7 @@ static void attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
     if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_PCI) {
         drc->isolation_state = SPAPR_DR_ISOLATION_STATE_UNISOLATED;
     }
-    drc->indicator_state = SPAPR_DR_INDICATOR_STATE_ACTIVE;
+    drc->dr_indicator = SPAPR_DR_INDICATOR_ACTIVE;
 
     drc->dev = d;
     drc->fdt = fdt;
@@ -394,7 +386,7 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
         }
     }
 
-    drc->indicator_state = SPAPR_DR_INDICATOR_STATE_INACTIVE;
+    drc->dr_indicator = SPAPR_DR_INDICATOR_INACTIVE;
 
     /* Calling release callbacks based on spapr_drc_type(drc). */
     switch (spapr_drc_type(drc)) {
@@ -507,7 +499,7 @@ static const VMStateDescription vmstate_spapr_drc = {
     .fields  = (VMStateField []) {
         VMSTATE_UINT32(isolation_state, sPAPRDRConnector),
         VMSTATE_UINT32(allocation_state, sPAPRDRConnector),
-        VMSTATE_UINT32(indicator_state, sPAPRDRConnector),
+        VMSTATE_UINT32(dr_indicator, sPAPRDRConnector),
         VMSTATE_BOOL(configured, sPAPRDRConnector),
         VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
         VMSTATE_BOOL(awaiting_allocation, sPAPRDRConnector),
@@ -647,7 +639,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     dk->realize = realize;
     dk->unrealize = unrealize;
     drck->set_isolation_state = set_isolation_state;
-    drck->set_indicator_state = set_indicator_state;
     drck->set_allocation_state = set_allocation_state;
     drck->get_name = get_name;
     drck->attach = attach;
@@ -929,17 +920,17 @@ static uint32_t rtas_set_allocation_state(uint32_t idx, uint32_t state)
     return drck->set_allocation_state(drc, state);
 }
 
-static uint32_t rtas_set_indicator_state(uint32_t idx, uint32_t state)
+static uint32_t rtas_set_dr_indicator(uint32_t idx, uint32_t state)
 {
     sPAPRDRConnector *drc = spapr_drc_by_index(idx);
-    sPAPRDRConnectorClass *drck;
 
     if (!drc) {
         return RTAS_OUT_PARAM_ERROR;
     }
 
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    return drck->set_indicator_state(drc, state);
+    trace_spapr_drc_set_dr_indicator(idx, state);
+    drc->dr_indicator = state;
+    return RTAS_OUT_SUCCESS;
 }
 
 static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
@@ -964,7 +955,7 @@ static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
         ret = rtas_set_isolation_state(idx, state);
         break;
     case RTAS_SENSOR_TYPE_DR:
-        ret = rtas_set_indicator_state(idx, state);
+        ret = rtas_set_dr_indicator(idx, state);
         break;
     case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
         ret = rtas_set_allocation_state(idx, state);
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 581fa85..3e8e3cf 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -39,7 +39,7 @@ spapr_iommu_ddw_reset(uint64_t buid, uint32_t cfgaddr) "buid=%"PRIx64" addr=%"PR
 spapr_drc_set_isolation_state(uint32_t index, int state) "drc: 0x%"PRIx32", state: %"PRIx32
 spapr_drc_set_isolation_state_finalizing(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_set_isolation_state_deferring(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_set_indicator_state(uint32_t index, int state) "drc: 0x%"PRIx32", state: 0x%x"
+spapr_drc_set_dr_indicator(uint32_t index, int state) "drc: 0x%"PRIx32", state: 0x%x"
 spapr_drc_set_allocation_state(uint32_t index, int state) "drc: 0x%"PRIx32", state: 0x%x"
 spapr_drc_set_allocation_state_finalizing(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_set_configured(uint32_t index) "drc: 0x%"PRIx32
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index f892b94..70db573 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -125,7 +125,7 @@ typedef enum {
 } sPAPRDRAllocationState;
 
 /*
- * LED/visual indicator state
+ * DR-indicator (LED/visual indicator)
  *
  * set via set-indicator RTAS calls
  * as documented by PAPR+ 2.7 13.5.3.4, Table 177,
@@ -137,10 +137,10 @@ typedef enum {
  * action: (currently unused)
  */
 typedef enum {
-    SPAPR_DR_INDICATOR_STATE_INACTIVE   = 0,
-    SPAPR_DR_INDICATOR_STATE_ACTIVE     = 1,
-    SPAPR_DR_INDICATOR_STATE_IDENTIFY   = 2,
-    SPAPR_DR_INDICATOR_STATE_ACTION     = 3,
+    SPAPR_DR_INDICATOR_INACTIVE   = 0,
+    SPAPR_DR_INDICATOR_ACTIVE     = 1,
+    SPAPR_DR_INDICATOR_IDENTIFY   = 2,
+    SPAPR_DR_INDICATOR_ACTION     = 3,
 } sPAPRDRIndicatorState;
 
 /*
@@ -186,10 +186,12 @@ typedef struct sPAPRDRConnector {
     Object *owner;
     const char *name;
 
+    /* DR-indicator */
+    uint32_t dr_indicator;
+
     /* sensor/indicator states */
     uint32_t isolation_state;
     uint32_t allocation_state;
-    uint32_t indicator_state;
 
     /* configure-connector state */
     void *fdt;
@@ -219,8 +221,6 @@ typedef struct sPAPRDRConnectorClass {
     /* accessors for guest-visible (generally via RTAS) DR state */
     uint32_t (*set_isolation_state)(sPAPRDRConnector *drc,
                                     sPAPRDRIsolationState state);
-    uint32_t (*set_indicator_state)(sPAPRDRConnector *drc,
-                                    sPAPRDRIndicatorState state);
     uint32_t (*set_allocation_state)(sPAPRDRConnector *drc,
                                      sPAPRDRAllocationState state);
     const char *(*get_name)(sPAPRDRConnector *drc);
-- 
2.9.4
