Received: from eggs.gnu.org ([2001:4830:134:3::10]:54981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI9uh-0003Ns-RB
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI9ug-00021q-B3
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:32:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 18:32:17 +1000
Message-Id: <20170606083221.9299-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170606083221.9299-1-david@gibson.dropbear.id.au>
References: <20170606083221.9299-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 3/7] spapr: Assign DRC names from owners
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

At present, spapr_dr_connector_new assigns a name to the drc based on its
type and ID.  The few places the DRC name are used, however, are supposed
to give some sort of human-useful information to correlate guest-side
problems with host-side resources (for PCI devices it's supposed to be
a physical location code).

The owners who set up the DRCs are in a much better position to supply this
information than the DRC core.  We already have a "name" R/O property, so
make it R/W and set from the callers.  We change the "name" property from
a new-style QOM one to the property list form, simply because it's a bit
less verbose that way.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             | 16 +++++++++---
 hw/ppc/spapr_drc.c         | 61 ++++++++++++----------------------------------
 hw/ppc/spapr_pci.c         | 29 ++++++++++++++++++++--
 include/hw/ppc/spapr_drc.h |  5 ++--
 4 files changed, 57 insertions(+), 54 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 86e6228..671cdbb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1909,11 +1909,14 @@ static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
 
     for (i = 0; i < nr_lmbs; i++) {
         sPAPRDRConnector *drc;
+        char *drc_name;
         uint64_t addr;
 
         addr = i * lmb_size + spapr->hotplug_memory.base;
+        drc_name = g_strdup_printf("LMB %"PRId64, addr / lmb_size);
         drc = spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_LMB,
-                                     addr/lmb_size);
+                                     addr / lmb_size, drc_name, &error_abort);
+        g_free(drc_name);
         qemu_register_reset(spapr_drc_reset, drc);
     }
 }
@@ -2008,9 +2011,14 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
         int core_id = i * smp_threads;
 
         if (mc->has_hotpluggable_cpus) {
-            sPAPRDRConnector *drc =
-                spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
-                                       (core_id / smp_threads) * smt);
+            int id = (core_id / smp_threads) * smt;
+            char *drc_name;
+            sPAPRDRConnector *drc;
+
+            drc_name = g_strdup_printf("CPU %d", id);
+            drc = spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
+                                         id, drc_name, &error_abort);
+            g_free(drc_name);
 
             qemu_register_reset(spapr_drc_reset, drc);
         }
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 9140b48..1fc51c9 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -213,12 +213,6 @@ static void prop_get_index(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static char *prop_get_name(Object *obj, Error **errp)
-{
-    sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
-    return g_strdup(drc->name);
-}
-
 static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
@@ -564,9 +558,11 @@ static void unrealize(DeviceState *d, Error **errp)
 }
 
 sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
-                                         uint32_t id)
+                                         uint32_t id, const char *name,
+                                         Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(object_new(type));
+    Error *local_err = NULL;
     char *prop_name;
 
     drc->id = id;
@@ -574,48 +570,16 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
     prop_name = g_strdup_printf("dr-connector[%"PRIu32"]",
                                 spapr_drc_index(drc));
     object_property_add_child(owner, prop_name, OBJECT(drc), NULL);
-    object_property_set_bool(OBJECT(drc), true, "realized", NULL);
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
+    object_property_set_str(OBJECT(drc), name, "name", &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return NULL;
     }
 
+    object_property_set_bool(OBJECT(drc), true, "realized", NULL);
+
     /* PCI slot always start in a USABLE state, and stay there */
     if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_PCI) {
         drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
@@ -631,16 +595,21 @@ static void spapr_dr_connector_instance_init(Object *obj)
     object_property_add_uint32_ptr(obj, "id", &drc->id, NULL);
     object_property_add(obj, "index", "uint32", prop_get_index,
                         NULL, NULL, NULL, NULL);
-    object_property_add_str(obj, "name", prop_get_name, NULL, NULL);
     object_property_add(obj, "fdt", "struct", prop_get_fdt,
                         NULL, NULL, NULL, NULL);
 }
 
+static Property spapr_drc_properties[] = {
+    DEFINE_PROP_STRING("name", sPAPRDRConnector, name),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
 {
     DeviceClass *dk = DEVICE_CLASS(k);
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
+    dk->props = spapr_drc_properties;
     dk->reset = reset;
     dk->realize = realize;
     dk->unrealize = unrealize;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5cba8f9..967d7c3 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1570,10 +1570,10 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     sPAPRTCETable *tcet;
     const unsigned windows_supported =
         sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
+    Error *local_err = NULL;
 
     if (sphb->index != (uint32_t)-1) {
         sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
-        Error *local_err = NULL;
 
         if ((sphb->buid != (uint64_t)-1) || (sphb->dma_liobn[0] != (uint32_t)-1)
             || (sphb->dma_liobn[1] != (uint32_t)-1 && windows_supported == 2)
@@ -1759,8 +1759,33 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     /* allocate connectors for child PCI devices */
     if (sphb->dr_enabled) {
         for (i = 0; i < PCI_SLOT_MAX * 8; i++) {
+            int id = sphb->index << 16 | i;
+            char *drc_name;
+
+            /* Name for a DRC for the DT. For PCI devices, it is a
+             * "location code" mapping a logical device/function (DRC
+             * index) to a physical location in the system.
+             *
+             * This is more to do with diagnosing physical hardware
+             * issues than guest compatibility, so choose names that
+             * adhere to the documented format, but avoid encoding the
+             * entire topology information into the label/code,
+             * instead just using the location codes based on the
+             * labels for the endpoints (VIO/PCI adaptor connectors),
+             * which is basically just "C" followed by an integer ID.
+             *
+             * DRC names as documented by PAPR+ v2.7, 13.5.2.4
+             * location codes as documented by PAPR+ v2.7, 12.3.1.5
+             */
+
+            drc_name = g_strdup_printf("C%d", id);
             spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
-                                   (sphb->index << 16) | i);
+                                   id, drc_name, &local_err);
+            g_free(drc_name);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
         }
     }
 
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 795b7dd..d437e0a 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -184,7 +184,7 @@ typedef struct sPAPRDRConnector {
 
     uint32_t id;
     Object *owner;
-    const char *name;
+    char *name;
 
     /* sensor/indicator states */
     uint32_t isolation_state;
@@ -236,7 +236,8 @@ uint32_t spapr_drc_index(sPAPRDRConnector *drc);
 sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc);
 
 sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
-                                         uint32_t id);
+                                         uint32_t id, const char *name,
+                                         Error **errp);
 sPAPRDRConnector *spapr_drc_by_index(uint32_t index);
 sPAPRDRConnector *spapr_drc_by_id(const char *type, uint32_t id);
 int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
-- 
2.9.4
