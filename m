Received: from eggs.gnu.org ([2001:4830:134:3::10]:54257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4aw-0003Uj-OJ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4au-0002xS-4C
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:21 +1000
Message-Id: <20170606025135.2685-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/17] spapr: Move DRC RTAS calls into
 spapr_drc.c
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

Currently implementations of the RTAS calls related to DRCs are in
spapr_rtas.c.  They belong better in spapr_drc.c - that way they're closer
to related code, and we'll be able to make some more things local.

spapr_rtas.c was intended to contain the RTAS infrastructure and core calls
that don't belong anywhere else, not every RTAS implementation.

Code motion only.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c  | 322 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/ppc/spapr_rtas.c | 304 -------------------------------------------------
 2 files changed, 315 insertions(+), 311 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index cc2400b..ae8800d 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -27,6 +27,34 @@
 #define DRC_INDEX_TYPE_SHIFT 28
 #define DRC_INDEX_ID_MASK ((1ULL << DRC_INDEX_TYPE_SHIFT) - 1)
 
+static sPAPRConfigureConnectorState *spapr_ccs_find(sPAPRMachineState *spapr,
+                                                    uint32_t drc_index)
+{
+    sPAPRConfigureConnectorState *ccs = NULL;
+
+    QTAILQ_FOREACH(ccs, &spapr->ccs_list, next) {
+        if (ccs->drc_index == drc_index) {
+            break;
+        }
+    }
+
+    return ccs;
+}
+
+static void spapr_ccs_add(sPAPRMachineState *spapr,
+                          sPAPRConfigureConnectorState *ccs)
+{
+    g_assert(!spapr_ccs_find(spapr, ccs->drc_index));
+    QTAILQ_INSERT_HEAD(&spapr->ccs_list, ccs, next);
+}
+
+static void spapr_ccs_remove(sPAPRMachineState *spapr,
+                             sPAPRConfigureConnectorState *ccs)
+{
+    QTAILQ_REMOVE(&spapr->ccs_list, ccs, next);
+    g_free(ccs);
+}
+
 static sPAPRDRConnectorTypeShift get_type_shift(sPAPRDRConnectorType type)
 {
     uint32_t shift = 0;
@@ -747,13 +775,6 @@ static const TypeInfo spapr_dr_connector_info = {
     .class_init    = spapr_dr_connector_class_init,
 };
 
-static void spapr_drc_register_types(void)
-{
-    type_register_static(&spapr_dr_connector_info);
-}
-
-type_init(spapr_drc_register_types)
-
 /* helper functions for external users */
 
 sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index)
@@ -932,3 +953,290 @@ out:
 
     return ret;
 }
+
+/*
+ * RTAS calls
+ */
+
+static bool sensor_type_is_dr(uint32_t sensor_type)
+{
+    switch (sensor_type) {
+    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
+    case RTAS_SENSOR_TYPE_DR:
+    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
+        return true;
+    }
+
+    return false;
+}
+
+static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+                               uint32_t token, uint32_t nargs,
+                               target_ulong args, uint32_t nret,
+                               target_ulong rets)
+{
+    uint32_t sensor_type;
+    uint32_t sensor_index;
+    uint32_t sensor_state;
+    uint32_t ret = RTAS_OUT_SUCCESS;
+    sPAPRDRConnector *drc;
+    sPAPRDRConnectorClass *drck;
+
+    if (nargs != 3 || nret != 1) {
+        ret = RTAS_OUT_PARAM_ERROR;
+        goto out;
+    }
+
+    sensor_type = rtas_ld(args, 0);
+    sensor_index = rtas_ld(args, 1);
+    sensor_state = rtas_ld(args, 2);
+
+    if (!sensor_type_is_dr(sensor_type)) {
+        goto out_unimplemented;
+    }
+
+    /* if this is a DR sensor we can assume sensor_index == drc_index */
+    drc = spapr_dr_connector_by_index(sensor_index);
+    if (!drc) {
+        trace_spapr_rtas_set_indicator_invalid(sensor_index);
+        ret = RTAS_OUT_PARAM_ERROR;
+        goto out;
+    }
+    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+
+    switch (sensor_type) {
+    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
+        /* if the guest is configuring a device attached to this
+         * DRC, we should reset the configuration state at this
+         * point since it may no longer be reliable (guest released
+         * device and needs to start over, or unplug occurred so
+         * the FDT is no longer valid)
+         */
+        if (sensor_state == SPAPR_DR_ISOLATION_STATE_ISOLATED) {
+            sPAPRConfigureConnectorState *ccs = spapr_ccs_find(spapr,
+                                                               sensor_index);
+            if (ccs) {
+                spapr_ccs_remove(spapr, ccs);
+            }
+        }
+        ret = drck->set_isolation_state(drc, sensor_state);
+        break;
+    case RTAS_SENSOR_TYPE_DR:
+        ret = drck->set_indicator_state(drc, sensor_state);
+        break;
+    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
+        ret = drck->set_allocation_state(drc, sensor_state);
+        break;
+    default:
+        goto out_unimplemented;
+    }
+
+out:
+    rtas_st(rets, 0, ret);
+    return;
+
+out_unimplemented:
+    /* currently only DR-related sensors are implemented */
+    trace_spapr_rtas_set_indicator_not_supported(sensor_index, sensor_type);
+    rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+}
+
+static void rtas_get_sensor_state(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+                                  uint32_t token, uint32_t nargs,
+                                  target_ulong args, uint32_t nret,
+                                  target_ulong rets)
+{
+    uint32_t sensor_type;
+    uint32_t sensor_index;
+    uint32_t sensor_state = 0;
+    sPAPRDRConnector *drc;
+    sPAPRDRConnectorClass *drck;
+    uint32_t ret = RTAS_OUT_SUCCESS;
+
+    if (nargs != 2 || nret != 2) {
+        ret = RTAS_OUT_PARAM_ERROR;
+        goto out;
+    }
+
+    sensor_type = rtas_ld(args, 0);
+    sensor_index = rtas_ld(args, 1);
+
+    if (sensor_type != RTAS_SENSOR_TYPE_ENTITY_SENSE) {
+        /* currently only DR-related sensors are implemented */
+        trace_spapr_rtas_get_sensor_state_not_supported(sensor_index,
+                                                        sensor_type);
+        ret = RTAS_OUT_NOT_SUPPORTED;
+        goto out;
+    }
+
+    drc = spapr_dr_connector_by_index(sensor_index);
+    if (!drc) {
+        trace_spapr_rtas_get_sensor_state_invalid(sensor_index);
+        ret = RTAS_OUT_PARAM_ERROR;
+        goto out;
+    }
+    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    ret = drck->entity_sense(drc, &sensor_state);
+
+out:
+    rtas_st(rets, 0, ret);
+    rtas_st(rets, 1, sensor_state);
+}
+
+/* configure-connector work area offsets, int32_t units for field
+ * indexes, bytes for field offset/len values.
+ *
+ * as documented by PAPR+ v2.7, 13.5.3.5
+ */
+#define CC_IDX_NODE_NAME_OFFSET 2
+#define CC_IDX_PROP_NAME_OFFSET 2
+#define CC_IDX_PROP_LEN 3
+#define CC_IDX_PROP_DATA_OFFSET 4
+#define CC_VAL_DATA_OFFSET ((CC_IDX_PROP_DATA_OFFSET + 1) * 4)
+#define CC_WA_LEN 4096
+
+static void configure_connector_st(target_ulong addr, target_ulong offset,
+                                   const void *buf, size_t len)
+{
+    cpu_physical_memory_write(ppc64_phys_to_real(addr + offset),
+                              buf, MIN(len, CC_WA_LEN - offset));
+}
+
+void spapr_ccs_reset_hook(void *opaque)
+{
+    sPAPRMachineState *spapr = opaque;
+    sPAPRConfigureConnectorState *ccs, *ccs_tmp;
+
+    QTAILQ_FOREACH_SAFE(ccs, &spapr->ccs_list, next, ccs_tmp) {
+        spapr_ccs_remove(spapr, ccs);
+    }
+}
+
+static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
+                                         sPAPRMachineState *spapr,
+                                         uint32_t token, uint32_t nargs,
+                                         target_ulong args, uint32_t nret,
+                                         target_ulong rets)
+{
+    uint64_t wa_addr;
+    uint64_t wa_offset;
+    uint32_t drc_index;
+    sPAPRDRConnector *drc;
+    sPAPRDRConnectorClass *drck;
+    sPAPRConfigureConnectorState *ccs;
+    sPAPRDRCCResponse resp = SPAPR_DR_CC_RESPONSE_CONTINUE;
+    int rc;
+    const void *fdt;
+
+    if (nargs != 2 || nret != 1) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    wa_addr = ((uint64_t)rtas_ld(args, 1) << 32) | rtas_ld(args, 0);
+
+    drc_index = rtas_ld(wa_addr, 0);
+    drc = spapr_dr_connector_by_index(drc_index);
+    if (!drc) {
+        trace_spapr_rtas_ibm_configure_connector_invalid(drc_index);
+        rc = RTAS_OUT_PARAM_ERROR;
+        goto out;
+    }
+
+    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    fdt = drck->get_fdt(drc, NULL);
+    if (!fdt) {
+        trace_spapr_rtas_ibm_configure_connector_missing_fdt(drc_index);
+        rc = SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
+        goto out;
+    }
+
+    ccs = spapr_ccs_find(spapr, drc_index);
+    if (!ccs) {
+        ccs = g_new0(sPAPRConfigureConnectorState, 1);
+        (void)drck->get_fdt(drc, &ccs->fdt_offset);
+        ccs->drc_index = drc_index;
+        spapr_ccs_add(spapr, ccs);
+    }
+
+    do {
+        uint32_t tag;
+        const char *name;
+        const struct fdt_property *prop;
+        int fdt_offset_next, prop_len;
+
+        tag = fdt_next_tag(fdt, ccs->fdt_offset, &fdt_offset_next);
+
+        switch (tag) {
+        case FDT_BEGIN_NODE:
+            ccs->fdt_depth++;
+            name = fdt_get_name(fdt, ccs->fdt_offset, NULL);
+
+            /* provide the name of the next OF node */
+            wa_offset = CC_VAL_DATA_OFFSET;
+            rtas_st(wa_addr, CC_IDX_NODE_NAME_OFFSET, wa_offset);
+            configure_connector_st(wa_addr, wa_offset, name, strlen(name) + 1);
+            resp = SPAPR_DR_CC_RESPONSE_NEXT_CHILD;
+            break;
+        case FDT_END_NODE:
+            ccs->fdt_depth--;
+            if (ccs->fdt_depth == 0) {
+                /* done sending the device tree, don't need to track
+                 * the state anymore
+                 */
+                drck->set_configured(drc);
+                spapr_ccs_remove(spapr, ccs);
+                ccs = NULL;
+                resp = SPAPR_DR_CC_RESPONSE_SUCCESS;
+            } else {
+                resp = SPAPR_DR_CC_RESPONSE_PREV_PARENT;
+            }
+            break;
+        case FDT_PROP:
+            prop = fdt_get_property_by_offset(fdt, ccs->fdt_offset,
+                                              &prop_len);
+            name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
+
+            /* provide the name of the next OF property */
+            wa_offset = CC_VAL_DATA_OFFSET;
+            rtas_st(wa_addr, CC_IDX_PROP_NAME_OFFSET, wa_offset);
+            configure_connector_st(wa_addr, wa_offset, name, strlen(name) + 1);
+
+            /* provide the length and value of the OF property. data gets
+             * placed immediately after NULL terminator of the OF property's
+             * name string
+             */
+            wa_offset += strlen(name) + 1,
+            rtas_st(wa_addr, CC_IDX_PROP_LEN, prop_len);
+            rtas_st(wa_addr, CC_IDX_PROP_DATA_OFFSET, wa_offset);
+            configure_connector_st(wa_addr, wa_offset, prop->data, prop_len);
+            resp = SPAPR_DR_CC_RESPONSE_NEXT_PROPERTY;
+            break;
+        case FDT_END:
+            resp = SPAPR_DR_CC_RESPONSE_ERROR;
+        default:
+            /* keep seeking for an actionable tag */
+            break;
+        }
+        if (ccs) {
+            ccs->fdt_offset = fdt_offset_next;
+        }
+    } while (resp == SPAPR_DR_CC_RESPONSE_CONTINUE);
+
+    rc = resp;
+out:
+    rtas_st(rets, 0, rc);
+}
+
+static void spapr_drc_register_types(void)
+{
+    type_register_static(&spapr_dr_connector_info);
+
+    spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
+                        rtas_set_indicator);
+    spapr_rtas_register(RTAS_GET_SENSOR_STATE, "get-sensor-state",
+                        rtas_get_sensor_state);
+    spapr_rtas_register(RTAS_IBM_CONFIGURE_CONNECTOR, "ibm,configure-connector",
+                        rtas_ibm_configure_connector);
+}
+type_init(spapr_drc_register_types)
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index b666a4c..707c4d4 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -47,44 +47,6 @@
 #include "trace.h"
 #include "hw/ppc/fdt.h"
 
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
 static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
                                    target_ulong args,
@@ -389,266 +351,6 @@ static void rtas_get_power_level(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     rtas_st(rets, 1, 100);
 }
 
-static bool sensor_type_is_dr(uint32_t sensor_type)
-{
-    switch (sensor_type) {
-    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
-    case RTAS_SENSOR_TYPE_DR:
-    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
-        return true;
-    }
-
-    return false;
-}
-
-static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr,
-                               uint32_t token, uint32_t nargs,
-                               target_ulong args, uint32_t nret,
-                               target_ulong rets)
-{
-    uint32_t sensor_type;
-    uint32_t sensor_index;
-    uint32_t sensor_state;
-    uint32_t ret = RTAS_OUT_SUCCESS;
-    sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
-
-    if (nargs != 3 || nret != 1) {
-        ret = RTAS_OUT_PARAM_ERROR;
-        goto out;
-    }
-
-    sensor_type = rtas_ld(args, 0);
-    sensor_index = rtas_ld(args, 1);
-    sensor_state = rtas_ld(args, 2);
-
-    if (!sensor_type_is_dr(sensor_type)) {
-        goto out_unimplemented;
-    }
-
-    /* if this is a DR sensor we can assume sensor_index == drc_index */
-    drc = spapr_dr_connector_by_index(sensor_index);
-    if (!drc) {
-        trace_spapr_rtas_set_indicator_invalid(sensor_index);
-        ret = RTAS_OUT_PARAM_ERROR;
-        goto out;
-    }
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-
-    switch (sensor_type) {
-    case RTAS_SENSOR_TYPE_ISOLATION_STATE:
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
-        ret = drck->set_isolation_state(drc, sensor_state);
-        break;
-    case RTAS_SENSOR_TYPE_DR:
-        ret = drck->set_indicator_state(drc, sensor_state);
-        break;
-    case RTAS_SENSOR_TYPE_ALLOCATION_STATE:
-        ret = drck->set_allocation_state(drc, sensor_state);
-        break;
-    default:
-        goto out_unimplemented;
-    }
-
-out:
-    rtas_st(rets, 0, ret);
-    return;
-
-out_unimplemented:
-    /* currently only DR-related sensors are implemented */
-    trace_spapr_rtas_set_indicator_not_supported(sensor_index, sensor_type);
-    rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
-}
-
-static void rtas_get_sensor_state(PowerPCCPU *cpu, sPAPRMachineState *spapr,
-                                  uint32_t token, uint32_t nargs,
-                                  target_ulong args, uint32_t nret,
-                                  target_ulong rets)
-{
-    uint32_t sensor_type;
-    uint32_t sensor_index;
-    uint32_t sensor_state = 0;
-    sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
-    uint32_t ret = RTAS_OUT_SUCCESS;
-
-    if (nargs != 2 || nret != 2) {
-        ret = RTAS_OUT_PARAM_ERROR;
-        goto out;
-    }
-
-    sensor_type = rtas_ld(args, 0);
-    sensor_index = rtas_ld(args, 1);
-
-    if (sensor_type != RTAS_SENSOR_TYPE_ENTITY_SENSE) {
-        /* currently only DR-related sensors are implemented */
-        trace_spapr_rtas_get_sensor_state_not_supported(sensor_index,
-                                                        sensor_type);
-        ret = RTAS_OUT_NOT_SUPPORTED;
-        goto out;
-    }
-
-    drc = spapr_dr_connector_by_index(sensor_index);
-    if (!drc) {
-        trace_spapr_rtas_get_sensor_state_invalid(sensor_index);
-        ret = RTAS_OUT_PARAM_ERROR;
-        goto out;
-    }
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    ret = drck->entity_sense(drc, &sensor_state);
-
-out:
-    rtas_st(rets, 0, ret);
-    rtas_st(rets, 1, sensor_state);
-}
-
-/* configure-connector work area offsets, int32_t units for field
- * indexes, bytes for field offset/len values.
- *
- * as documented by PAPR+ v2.7, 13.5.3.5
- */
-#define CC_IDX_NODE_NAME_OFFSET 2
-#define CC_IDX_PROP_NAME_OFFSET 2
-#define CC_IDX_PROP_LEN 3
-#define CC_IDX_PROP_DATA_OFFSET 4
-#define CC_VAL_DATA_OFFSET ((CC_IDX_PROP_DATA_OFFSET + 1) * 4)
-#define CC_WA_LEN 4096
-
-static void configure_connector_st(target_ulong addr, target_ulong offset,
-                                   const void *buf, size_t len)
-{
-    cpu_physical_memory_write(ppc64_phys_to_real(addr + offset),
-                              buf, MIN(len, CC_WA_LEN - offset));
-}
-
-static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
-                                         sPAPRMachineState *spapr,
-                                         uint32_t token, uint32_t nargs,
-                                         target_ulong args, uint32_t nret,
-                                         target_ulong rets)
-{
-    uint64_t wa_addr;
-    uint64_t wa_offset;
-    uint32_t drc_index;
-    sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
-    sPAPRConfigureConnectorState *ccs;
-    sPAPRDRCCResponse resp = SPAPR_DR_CC_RESPONSE_CONTINUE;
-    int rc;
-    const void *fdt;
-
-    if (nargs != 2 || nret != 1) {
-        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
-        return;
-    }
-
-    wa_addr = ((uint64_t)rtas_ld(args, 1) << 32) | rtas_ld(args, 0);
-
-    drc_index = rtas_ld(wa_addr, 0);
-    drc = spapr_dr_connector_by_index(drc_index);
-    if (!drc) {
-        trace_spapr_rtas_ibm_configure_connector_invalid(drc_index);
-        rc = RTAS_OUT_PARAM_ERROR;
-        goto out;
-    }
-
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    fdt = drck->get_fdt(drc, NULL);
-    if (!fdt) {
-        trace_spapr_rtas_ibm_configure_connector_missing_fdt(drc_index);
-        rc = SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
-        goto out;
-    }
-
-    ccs = spapr_ccs_find(spapr, drc_index);
-    if (!ccs) {
-        ccs = g_new0(sPAPRConfigureConnectorState, 1);
-        (void)drck->get_fdt(drc, &ccs->fdt_offset);
-        ccs->drc_index = drc_index;
-        spapr_ccs_add(spapr, ccs);
-    }
-
-    do {
-        uint32_t tag;
-        const char *name;
-        const struct fdt_property *prop;
-        int fdt_offset_next, prop_len;
-
-        tag = fdt_next_tag(fdt, ccs->fdt_offset, &fdt_offset_next);
-
-        switch (tag) {
-        case FDT_BEGIN_NODE:
-            ccs->fdt_depth++;
-            name = fdt_get_name(fdt, ccs->fdt_offset, NULL);
-
-            /* provide the name of the next OF node */
-            wa_offset = CC_VAL_DATA_OFFSET;
-            rtas_st(wa_addr, CC_IDX_NODE_NAME_OFFSET, wa_offset);
-            configure_connector_st(wa_addr, wa_offset, name, strlen(name) + 1);
-            resp = SPAPR_DR_CC_RESPONSE_NEXT_CHILD;
-            break;
-        case FDT_END_NODE:
-            ccs->fdt_depth--;
-            if (ccs->fdt_depth == 0) {
-                /* done sending the device tree, don't need to track
-                 * the state anymore
-                 */
-                drck->set_configured(drc);
-                spapr_ccs_remove(spapr, ccs);
-                ccs = NULL;
-                resp = SPAPR_DR_CC_RESPONSE_SUCCESS;
-            } else {
-                resp = SPAPR_DR_CC_RESPONSE_PREV_PARENT;
-            }
-            break;
-        case FDT_PROP:
-            prop = fdt_get_property_by_offset(fdt, ccs->fdt_offset,
-                                              &prop_len);
-            name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
-
-            /* provide the name of the next OF property */
-            wa_offset = CC_VAL_DATA_OFFSET;
-            rtas_st(wa_addr, CC_IDX_PROP_NAME_OFFSET, wa_offset);
-            configure_connector_st(wa_addr, wa_offset, name, strlen(name) + 1);
-
-            /* provide the length and value of the OF property. data gets
-             * placed immediately after NULL terminator of the OF property's
-             * name string
-             */
-            wa_offset += strlen(name) + 1,
-            rtas_st(wa_addr, CC_IDX_PROP_LEN, prop_len);
-            rtas_st(wa_addr, CC_IDX_PROP_DATA_OFFSET, wa_offset);
-            configure_connector_st(wa_addr, wa_offset, prop->data, prop_len);
-            resp = SPAPR_DR_CC_RESPONSE_NEXT_PROPERTY;
-            break;
-        case FDT_END:
-            resp = SPAPR_DR_CC_RESPONSE_ERROR;
-        default:
-            /* keep seeking for an actionable tag */
-            break;
-        }
-        if (ccs) {
-            ccs->fdt_offset = fdt_offset_next;
-        }
-    } while (resp == SPAPR_DR_CC_RESPONSE_CONTINUE);
-
-    rc = resp;
-out:
-    rtas_st(rets, 0, rc);
-}
-
 static struct rtas_call {
     const char *name;
     spapr_rtas_fn fn;
@@ -790,12 +492,6 @@ static void core_rtas_register_types(void)
                         rtas_set_power_level);
     spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
                         rtas_get_power_level);
-    spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
-                        rtas_set_indicator);
-    spapr_rtas_register(RTAS_GET_SENSOR_STATE, "get-sensor-state",
-                        rtas_get_sensor_state);
-    spapr_rtas_register(RTAS_IBM_CONFIGURE_CONNECTOR, "ibm,configure-connector",
-                        rtas_ibm_configure_connector);
 }
 
 type_init(core_rtas_register_types)
-- 
2.9.4
