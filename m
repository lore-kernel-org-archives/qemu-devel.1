Received: from eggs.gnu.org ([2001:4830:134:3::10]:47007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRx-0003wI-AF
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRv-0006dM-Hh
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:09 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:39 +1000
Message-Id: <20170609052652.23200-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/20] spapr: Clean up RTAS set-indicator
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

In theory the RTAS set-indicator call can be used for a number of
"indicators" defined by PAPR.  In practice the only ones we're ever likely
to implement are those used for Dynamic Reconfiguration (i.e. hotplug).
Because of this, the current implementation determines the associated DRC
object, before dispatching based on the type of indicator.

However, this means we also need a check that we're dealing with a DR
related indicator at all, which duplicates some of the logic from the
switch further down.

Even though it means a bit of code duplication, things work out cleaner if
we delegate the DRC lookup to the individual indicator type functions -
and it also allows some further cleanups.

While we're there, remove references to "sensor", a copy/paste artefact
from the related, but distinct "get-sensor" call.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Acked-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c  | 84 ++++++++++++++++++++++++++++-------------------------
 hw/ppc/trace-events |  2 --
 2 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index cabeacf..f0cff0b 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -903,74 +903,78 @@ out:
  * RTAS calls
  */
 
-static bool sensor_type_is_dr(uint32_t sensor_type)
+static uint32_t rtas_set_isolation_state(uint32_t idx, uint32_t state)
 {
-    switch (sensor_type) {
-    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
-    case RTAS_SENSOR_TYPE_DR:
-    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
-        return true;
+    sPAPRDRConnector *drc = spapr_drc_by_index(idx);
+    sPAPRDRConnectorClass *drck;
+
+    if (!drc) {
+        return RTAS_OUT_PARAM_ERROR;
     }
 
-    return false;
+    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    return drck->set_isolation_state(drc, state);
 }
 
-static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
-                               uint32_t token, uint32_t nargs,
-                               target_ulong args, uint32_t nret,
-                               target_ulong rets)
+static uint32_t rtas_set_allocation_state(uint32_t idx, uint32_t state)
 {
-    uint32_t sensor_type;
-    uint32_t sensor_index;
-    uint32_t sensor_state;
-    uint32_t ret = RTAS_OUT_SUCCESS;
-    sPAPRDRConnector *drc;
+    sPAPRDRConnector *drc = spapr_drc_by_index(idx);
     sPAPRDRConnectorClass *drck;
 
-    if (nargs != 3 || nret != 1) {
-        ret = RTAS_OUT_PARAM_ERROR;
-        goto out;
+    if (!drc) {
+        return RTAS_OUT_PARAM_ERROR;
     }
 
-    sensor_type = rtas_ld(args, 0);
-    sensor_index = rtas_ld(args, 1);
-    sensor_state = rtas_ld(args, 2);
+    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    return drck->set_allocation_state(drc, state);
+}
 
-    if (!sensor_type_is_dr(sensor_type)) {
-        goto out_unimplemented;
-    }
+static uint32_t rtas_set_indicator_state(uint32_t idx, uint32_t state)
+{
+    sPAPRDRConnector *drc = spapr_drc_by_index(idx);
+    sPAPRDRConnectorClass *drck;
 
-    /* if this is a DR sensor we can assume sensor_index == drc_index */
-    drc = spapr_drc_by_index(sensor_index);
     if (!drc) {
-        trace_spapr_rtas_set_indicator_invalid(sensor_index);
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    return drck->set_indicator_state(drc, state);
+}
+
+static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+                               uint32_t token,
+                               uint32_t nargs, target_ulong args,
+                               uint32_t nret, target_ulong rets)
+{
+    uint32_t type, idx, state;
+    uint32_t ret = RTAS_OUT_SUCCESS;
+
+    if (nargs != 3 || nret != 1) {
         ret = RTAS_OUT_PARAM_ERROR;
         goto out;
     }
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
-    switch (sensor_type) {
+    type = rtas_ld(args, 0);
+    idx = rtas_ld(args, 1);
+    state = rtas_ld(args, 2);
+
+    switch (type) {
     case RTAS_SENSOR_TYPE_ISOLATION_STATE:
-        ret = drck->set_isolation_state(drc, sensor_state);
+        ret = rtas_set_isolation_state(idx, state);
         break;
     case RTAS_SENSOR_TYPE_DR:
-        ret = drck->set_indicator_state(drc, sensor_state);
+        ret = rtas_set_indicator_state(idx, state);
         break;
     case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
-        ret = drck->set_allocation_state(drc, sensor_state);
+        ret = rtas_set_allocation_state(idx, state);
         break;
     default:
-        goto out_unimplemented;
+        ret = RTAS_OUT_NOT_SUPPORTED;
     }
 
 out:
     rtas_st(rets, 0, ret);
-    return;
-
-out_unimplemented:
-    /* currently only DR-related sensors are implemented */
-    trace_spapr_rtas_set_indicator_not_supported(sensor_index, sensor_type);
-    rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
 }
 
 static void rtas_get_sensor_state(PowerPCCPU *cpu, sPAPRMachineState *spapr,
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 4979397..581fa85 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -60,8 +60,6 @@ spapr_ovec_parse_vector(int vector, int byte, uint16_t vec_len, uint8_t entry) "
 spapr_ovec_populate_dt(int byte, uint16_t vec_len, uint8_t entry) "encoding guest vector byte %3d / %3d: 0x%.2x"
 
 # hw/ppc/spapr_rtas.c
-spapr_rtas_set_indicator_invalid(uint32_t index) "sensor index: 0x%"PRIx32
-spapr_rtas_set_indicator_not_supported(uint32_t index, uint32_t type) "sensor index: 0x%"PRIx32", type: %"PRIu32
 spapr_rtas_get_sensor_state_not_supported(uint32_t index, uint32_t type) "sensor index: 0x%"PRIx32", type: %"PRIu32
 spapr_rtas_get_sensor_state_invalid(uint32_t index) "sensor index: 0x%"PRIx32
 spapr_rtas_ibm_configure_connector_invalid(uint32_t index) "DRC index: 0x%"PRIx32
-- 
2.9.4
