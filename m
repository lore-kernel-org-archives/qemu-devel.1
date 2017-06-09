Received: from eggs.gnu.org ([2001:4830:134:3::10]:47219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCS1-000449-Uv
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRz-0006gf-1x
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:13 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:43 +1000
Message-Id: <20170609052652.23200-12-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/20] spapr: Rework DRC name handling
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

DRC objects have a get_name method which returns the DRC name generated
when the DRC is created.  Replace that with a fixed spapr_drc_name()
function which generates the name on the fly from other information.  This
means:
  * We get rid of a method with only one implementation, and only local
    callers
  * We don't have to carry the name string around for the lifetime of the
    DRC
  * We use information added to the class structure to generate the name
    in standard format, so we don't need an explicit switch on drc type
    any more

We also eliminate the 'name' property; it's basically useless since the
only information in it can easily be deduced from other things.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Acked-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c         | 80 +++++++++++++++++-----------------------------
 include/hw/ppc/spapr_drc.h |  3 +-
 2 files changed, 30 insertions(+), 53 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 82c0b94..15ef67d 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -155,9 +155,32 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
     return RTAS_OUT_SUCCESS;
 }
 
-static const char *get_name(sPAPRDRConnector *drc)
+static const char *spapr_drc_name(sPAPRDRConnector *drc)
 {
-    return drc->name;
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+
+    /* human-readable name for a DRC to encode into the DT
+     * description. this is mainly only used within a guest in place
+     * of the unique DRC index.
+     *
+     * in the case of VIO/PCI devices, it corresponds to a "location
+     * code" that maps a logical device/function (DRC index) to a
+     * physical (or virtual in the case of VIO) location in the system
+     * by chaining together the "location label" for each
+     * encapsulating component.
+     *
+     * since this is more to do with diagnosing physical hardware
+     * issues than guest compatibility, we choose location codes/DRC
+     * names that adhere to the documented format, but avoid encoding
+     * the entire topology information into the label/code, instead
+     * just using the location codes based on the labels for the
+     * endpoints (VIO/PCI adaptor connectors), which is basically just
+     * "C" followed by an integer ID.
+     *
+     * DRC names as documented by PAPR+ v2.7, 13.5.2.4
+     * location codes as documented by PAPR+ v2.7, 12.3.1.5
+     */
+    return g_strdup_printf("%s%d", drck->drc_name_prefix, drc->id);
 }
 
 /* has the guest been notified of device attachment? */
@@ -202,13 +225,6 @@ static void prop_get_index(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static char *prop_get_name(Object *obj, Error **errp)
-{
-    sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    return g_strdup(drck->get_name(drc));
-}
-
 static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
@@ -567,45 +583,6 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
     object_property_set_bool(OBJECT(drc), true, "realized", NULL);
     g_free(prop_name);
 
-    /* human-readable name for a DRC to encode into the DT
-     * description. this is mainly only used within a guest in place
-     * of the unique DRC index.
-     *
-     * in the case of VIO/PCI devices, it corresponds to a
-     * "location code" that maps a logical device/function (DRC index)
-     * to a physical (or virtual in the case of VIO) location in the
-     * system by chaining together the "location label" for each
-     * encapsulating component.
-     *
-     * since this is more to do with diagnosing physical hardware
-     * issues than guest compatibility, we choose location codes/DRC
-     * names that adhere to the documented format, but avoid encoding
-     * the entire topology information into the label/code, instead
-     * just using the location codes based on the labels for the
-     * endpoints (VIO/PCI adaptor connectors), which is basically
-     * just "C" followed by an integer ID.
-     *
-     * DRC names as documented by PAPR+ v2.7, 13.5.2.4
-     * location codes as documented by PAPR+ v2.7, 12.3.1.5
-     */
-    switch (spapr_drc_type(drc)) {
-    case SPAPR_DR_CONNECTOR_TYPE_CPU:
-        drc->name = g_strdup_printf("CPU %d", id);
-        break;
-    case SPAPR_DR_CONNECTOR_TYPE_PHB:
-        drc->name = g_strdup_printf("PHB %d", id);
-        break;
-    case SPAPR_DR_CONNECTOR_TYPE_VIO:
-    case SPAPR_DR_CONNECTOR_TYPE_PCI:
-        drc->name = g_strdup_printf("C%d", id);
-        break;
-    case SPAPR_DR_CONNECTOR_TYPE_LMB:
-        drc->name = g_strdup_printf("LMB %d", id);
-        break;
-    default:
-        g_assert(false);
-    }
-
     /* PCI slot always start in a USABLE state, and stay there */
     if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_PCI) {
         drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
@@ -621,7 +598,6 @@ static void spapr_dr_connector_instance_init(Object *obj)
     object_property_add_uint32_ptr(obj, "id", &drc->id, NULL);
     object_property_add(obj, "index", "uint32", prop_get_index,
                         NULL, NULL, NULL, NULL);
-    object_property_add_str(obj, "name", prop_get_name, NULL, NULL);
     object_property_add(obj, "fdt", "struct", prop_get_fdt,
                         NULL, NULL, NULL, NULL);
 }
@@ -636,7 +612,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     dk->unrealize = unrealize;
     drck->set_isolation_state = set_isolation_state;
     drck->set_allocation_state = set_allocation_state;
-    drck->get_name = get_name;
     drck->release_pending = release_pending;
     drck->set_signalled = set_signalled;
     /*
@@ -665,6 +640,7 @@ static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
 
     drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_CPU;
     drck->typename = "CPU";
+    drck->drc_name_prefix = "CPU ";
 }
 
 static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
@@ -673,6 +649,7 @@ static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
 
     drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI;
     drck->typename = "28";
+    drck->drc_name_prefix = "C";
 }
 
 static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
@@ -681,6 +658,7 @@ static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
 
     drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB;
     drck->typename = "MEM";
+    drck->drc_name_prefix = "LMB ";
 }
 
 static const TypeInfo spapr_dr_connector_info = {
@@ -829,7 +807,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
         g_array_append_val(drc_power_domains, drc_power_domain);
 
         /* ibm,drc-names */
-        drc_names = g_string_append(drc_names, drck->get_name(drc));
+        drc_names = g_string_append(drc_names, spapr_drc_name(drc));
         drc_names = g_string_insert_len(drc_names, -1, "\0", 1);
 
         /* ibm,drc-types */
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 4f82001..c487123 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -184,7 +184,6 @@ typedef struct sPAPRDRConnector {
 
     uint32_t id;
     Object *owner;
-    const char *name;
 
     /* DR-indicator */
     uint32_t dr_indicator;
@@ -215,6 +214,7 @@ typedef struct sPAPRDRConnectorClass {
     /*< public >*/
     sPAPRDRConnectorTypeShift typeshift;
     const char *typename; /* used in device tree, PAPR 13.5.2.6 & C.6.1 */
+    const char *drc_name_prefix; /* used other places in device tree */
 
     sPAPRDREntitySense (*dr_entity_sense)(sPAPRDRConnector *drc);
 
@@ -223,7 +223,6 @@ typedef struct sPAPRDRConnectorClass {
                                     sPAPRDRIsolationState state);
     uint32_t (*set_allocation_state)(sPAPRDRConnector *drc,
                                      sPAPRDRAllocationState state);
-    const char *(*get_name)(sPAPRDRConnector *drc);
 
     /* QEMU interfaces for managing hotplug operations */
     bool (*release_pending)(sPAPRDRConnector *drc);
-- 
2.9.4
