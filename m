Received: from eggs.gnu.org ([2001:4830:134:3::10]:54518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4b3-0003bh-Ee
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4az-00031o-W7
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:53 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:31 +1000
Message-Id: <20170606025135.2685-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/17] spapr: Introduce DRC subclasses
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

Currently we only have a single QOM type for all DRCs, but lots of
places where we switch behaviour based on the DRC's PAPR defined type.
This is a poor use of our existing type system.

So, instead create QOM subclasses for each PAPR defined DRC type.  We
also introduce intermediate subclasses for physical and logical DRCs,
a division which will be useful later on.

Instead of being stored in the DRC object itself, the PAPR type is now
stored in the class structure.  There are still many places where we
switch directly on the PAPR type value, but this at least provides the
basis to start to remove those.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Acked-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c             |   5 +-
 hw/ppc/spapr_drc.c         | 123 +++++++++++++++++++++++++++++++++------------
 hw/ppc/spapr_pci.c         |   3 +-
 include/hw/ppc/spapr_drc.h |  47 +++++++++++++++--
 4 files changed, 139 insertions(+), 39 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c1c0951..11a04d1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1912,7 +1912,7 @@ static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
         uint64_t addr;
 
         addr = i * lmb_size + spapr->hotplug_memory.base;
-        drc = spapr_dr_connector_new(OBJECT(spapr), SPAPR_DR_CONNECTOR_TYPE_LMB,
+        drc = spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_LMB,
                                      addr/lmb_size);
         qemu_register_reset(spapr_drc_reset, drc);
     }
@@ -2009,8 +2009,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
 
         if (mc->has_hotpluggable_cpus) {
             sPAPRDRConnector *drc =
-                spapr_dr_connector_new(OBJECT(spapr),
-                                       SPAPR_DR_CONNECTOR_TYPE_CPU,
+                spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
                                        (core_id / smp_threads) * smt);
 
             qemu_register_reset(spapr_drc_reset, drc);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index c1d4b10..969d727 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -70,14 +70,23 @@ static sPAPRDRConnectorTypeShift get_type_shift(sPAPRDRConnectorType type)
     return shift;
 }
 
+sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc)
+{
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+
+    return 1 << drck->typeshift;
+}
+
 uint32_t spapr_drc_index(sPAPRDRConnector *drc)
 {
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+
     /* no set format for a drc index: it only needs to be globally
      * unique. this is how we encode the DRC type on bare-metal
      * however, so might as well do that here
      */
-    return (get_type_shift(drc->type) << DRC_INDEX_TYPE_SHIFT) |
-            (drc->id & DRC_INDEX_ID_MASK);
+    return (drck->typeshift << DRC_INDEX_TYPE_SHIFT)
+        | (drc->id & DRC_INDEX_ID_MASK);
 }
 
 static uint32_t set_isolation_state(sPAPRDRConnector *drc,
@@ -107,7 +116,7 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
      * If the LMB being removed doesn't belong to a DIMM device that is
      * actually being unplugged, fail the isolation request here.
      */
-    if (drc->type == SPAPR_DR_CONNECTOR_TYPE_LMB) {
+    if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_LMB) {
         if ((state == SPAPR_DR_ISOLATION_STATE_ISOLATED) &&
              !drc->awaiting_release) {
             return RTAS_OUT_HW_ERROR;
@@ -177,7 +186,7 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
         }
     }
 
-    if (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI) {
+    if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
         drc->allocation_state = state;
         if (drc->awaiting_release &&
             drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
@@ -191,11 +200,6 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
     return RTAS_OUT_SUCCESS;
 }
 
-sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc)
-{
-    return drc->type;
-}
-
 static const char *get_name(sPAPRDRConnector *drc)
 {
     return drc->name;
@@ -217,7 +221,7 @@ static void set_signalled(sPAPRDRConnector *drc)
 static uint32_t entity_sense(sPAPRDRConnector *drc, sPAPRDREntitySense *state)
 {
     if (drc->dev) {
-        if (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI &&
+        if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI &&
             drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
             /* for logical DR, we return a state of UNUSABLE
              * iff the allocation state UNUSABLE.
@@ -235,7 +239,7 @@ static uint32_t entity_sense(sPAPRDRConnector *drc, sPAPRDREntitySense *state)
             *state = SPAPR_DR_ENTITY_SENSE_PRESENT;
         }
     } else {
-        if (drc->type == SPAPR_DR_CONNECTOR_TYPE_PCI) {
+        if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_PCI) {
             /* PCI devices, and only PCI devices, use EMPTY
              * in cases where we'd otherwise use UNUSABLE
              */
@@ -368,7 +372,7 @@ static void attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
         error_setg(errp, "an attached device is still awaiting release");
         return;
     }
-    if (drc->type == SPAPR_DR_CONNECTOR_TYPE_PCI) {
+    if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_PCI) {
         g_assert(drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE);
     }
     g_assert(fdt || coldplug);
@@ -380,7 +384,7 @@ static void attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
      * may be accessing the device, we can easily crash the guest, so we
      * we defer completion of removal in such cases to the reset() hook.
      */
-    if (drc->type == SPAPR_DR_CONNECTOR_TYPE_PCI) {
+    if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_PCI) {
         drc->isolation_state = SPAPR_DR_ISOLATION_STATE_UNISOLATED;
     }
     drc->indicator_state = SPAPR_DR_INDICATOR_STATE_ACTIVE;
@@ -398,10 +402,10 @@ static void attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
      * 'physical' DR resources such as PCI where each device/resource is
      * signalled individually.
      */
-    drc->signalled = (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI)
+    drc->signalled = (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI)
                      ? true : coldplug;
 
-    if (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI) {
+    if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
         drc->awaiting_allocation = true;
     }
 
@@ -441,7 +445,7 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
         return;
     }
 
-    if (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI &&
+    if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI &&
         drc->allocation_state != SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
         trace_spapr_drc_awaiting_unusable(spapr_drc_index(drc));
         drc->awaiting_release = true;
@@ -458,8 +462,8 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
 
     drc->indicator_state = SPAPR_DR_INDICATOR_STATE_INACTIVE;
 
-    /* Calling release callbacks based on drc->type. */
-    switch (drc->type) {
+    /* Calling release callbacks based on spapr_drc_type(drc). */
+    switch (spapr_drc_type(drc)) {
     case SPAPR_DR_CONNECTOR_TYPE_CPU:
         spapr_core_release(drc->dev);
         break;
@@ -515,7 +519,7 @@ static void reset(DeviceState *d)
         }
 
         /* non-PCI devices may be awaiting a transition to UNUSABLE */
-        if (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI &&
+        if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI &&
             drc->awaiting_release) {
             drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_UNUSABLE);
         }
@@ -544,7 +548,7 @@ static bool spapr_drc_needed(void *opaque)
      * If there is dev plugged in, we need to migrate the DRC state when
      * it is different from cold-plugged state
      */
-    switch (drc->type) {
+    switch (spapr_drc_type(drc)) {
     case SPAPR_DR_CONNECTOR_TYPE_PCI:
     case SPAPR_DR_CONNECTOR_TYPE_CPU:
     case SPAPR_DR_CONNECTOR_TYPE_LMB:
@@ -626,17 +630,12 @@ static void unrealize(DeviceState *d, Error **errp)
     }
 }
 
-sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
-                                         sPAPRDRConnectorType type,
+sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
                                          uint32_t id)
 {
-    sPAPRDRConnector *drc =
-        SPAPR_DR_CONNECTOR(object_new(TYPE_SPAPR_DR_CONNECTOR));
+    sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(object_new(type));
     char *prop_name;
 
-    g_assert(type);
-
-    drc->type = type;
     drc->id = id;
     drc->owner = owner;
     prop_name = g_strdup_printf("dr-connector[%"PRIu32"]",
@@ -666,7 +665,7 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
      * DRC names as documented by PAPR+ v2.7, 13.5.2.4
      * location codes as documented by PAPR+ v2.7, 12.3.1.5
      */
-    switch (drc->type) {
+    switch (spapr_drc_type(drc)) {
     case SPAPR_DR_CONNECTOR_TYPE_CPU:
         drc->name = g_strdup_printf("CPU %d", id);
         break;
@@ -685,7 +684,7 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
     }
 
     /* PCI slot always start in a USABLE state, and stay there */
-    if (drc->type == SPAPR_DR_CONNECTOR_TYPE_PCI) {
+    if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_PCI) {
         drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
     }
 
@@ -737,6 +736,27 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     dk->user_creatable = false;
 }
 
+static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
+{
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
+
+    drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_CPU;
+}
+
+static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
+{
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
+
+    drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI;
+}
+
+static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
+{
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
+
+    drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB;
+}
+
 static const TypeInfo spapr_dr_connector_info = {
     .name          = TYPE_SPAPR_DR_CONNECTOR,
     .parent        = TYPE_DEVICE,
@@ -744,6 +764,42 @@ static const TypeInfo spapr_dr_connector_info = {
     .instance_init = spapr_dr_connector_instance_init,
     .class_size    = sizeof(sPAPRDRConnectorClass),
     .class_init    = spapr_dr_connector_class_init,
+    .abstract      = true,
+};
+
+static const TypeInfo spapr_drc_physical_info = {
+    .name          = TYPE_SPAPR_DRC_PHYSICAL,
+    .parent        = TYPE_SPAPR_DR_CONNECTOR,
+    .instance_size = sizeof(sPAPRDRConnector),
+    .abstract      = true,
+};
+
+static const TypeInfo spapr_drc_logical_info = {
+    .name          = TYPE_SPAPR_DRC_LOGICAL,
+    .parent        = TYPE_SPAPR_DR_CONNECTOR,
+    .instance_size = sizeof(sPAPRDRConnector),
+    .abstract      = true,
+};
+
+static const TypeInfo spapr_drc_cpu_info = {
+    .name          = TYPE_SPAPR_DRC_CPU,
+    .parent        = TYPE_SPAPR_DRC_LOGICAL,
+    .instance_size = sizeof(sPAPRDRConnector),
+    .class_init    = spapr_drc_cpu_class_init,
+};
+
+static const TypeInfo spapr_drc_pci_info = {
+    .name          = TYPE_SPAPR_DRC_PCI,
+    .parent        = TYPE_SPAPR_DRC_PHYSICAL,
+    .instance_size = sizeof(sPAPRDRConnector),
+    .class_init    = spapr_drc_pci_class_init,
+};
+
+static const TypeInfo spapr_drc_lmb_info = {
+    .name          = TYPE_SPAPR_DRC_LMB,
+    .parent        = TYPE_SPAPR_DRC_LOGICAL,
+    .instance_size = sizeof(sPAPRDRConnector),
+    .class_init    = spapr_drc_lmb_class_init,
 };
 
 /* helper functions for external users */
@@ -854,7 +910,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
             continue;
         }
 
-        if ((drc->type & drc_type_mask) == 0) {
+        if ((spapr_drc_type(drc) & drc_type_mask) == 0) {
             continue;
         }
 
@@ -874,7 +930,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
 
         /* ibm,drc-types */
         drc_types = g_string_append(drc_types,
-                                    spapr_drc_get_type_str(drc->type));
+                                    spapr_drc_get_type_str(spapr_drc_type(drc)));
         drc_types = g_string_insert_len(drc_types, -1, "\0", 1);
     }
 
@@ -1206,6 +1262,11 @@ out:
 static void spapr_drc_register_types(void)
 {
     type_register_static(&spapr_dr_connector_info);
+    type_register_static(&spapr_drc_physical_info);
+    type_register_static(&spapr_drc_logical_info);
+    type_register_static(&spapr_drc_cpu_info);
+    type_register_static(&spapr_drc_pci_info);
+    type_register_static(&spapr_drc_lmb_info);
 
     spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
                         rtas_set_indicator);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7a208a7..50d673b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1761,8 +1761,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     /* allocate connectors for child PCI devices */
     if (sphb->dr_enabled) {
         for (i = 0; i < PCI_SLOT_MAX * 8; i++) {
-            spapr_dr_connector_new(OBJECT(phb),
-                                   SPAPR_DR_CONNECTOR_TYPE_PCI,
+            spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
                                    (sphb->index << 16) | i);
         }
     }
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 10e7c24..969c16d 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -26,6 +26,48 @@
 #define SPAPR_DR_CONNECTOR(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
                                              TYPE_SPAPR_DR_CONNECTOR)
 
+#define TYPE_SPAPR_DRC_PHYSICAL "spapr-drc-physical"
+#define SPAPR_DRC_PHYSICAL_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_PHYSICAL)
+#define SPAPR_DRC_PHYSICAL_CLASS(klass) \
+        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, \
+                           TYPE_SPAPR_DRC_PHYSICAL)
+#define SPAPR_DRC_PHYSICAL(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+                                             TYPE_SPAPR_DRC_PHYSICAL)
+
+#define TYPE_SPAPR_DRC_LOGICAL "spapr-drc-logical"
+#define SPAPR_DRC_LOGICAL_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_LOGICAL)
+#define SPAPR_DRC_LOGICAL_CLASS(klass) \
+        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, \
+                           TYPE_SPAPR_DRC_LOGICAL)
+#define SPAPR_DRC_LOGICAL(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+                                             TYPE_SPAPR_DRC_LOGICAL)
+
+#define TYPE_SPAPR_DRC_CPU "spapr-drc-cpu"
+#define SPAPR_DRC_CPU_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_CPU)
+#define SPAPR_DRC_CPU_CLASS(klass) \
+        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DRC_CPU)
+#define SPAPR_DRC_CPU(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+                                        TYPE_SPAPR_DRC_CPU)
+
+#define TYPE_SPAPR_DRC_PCI "spapr-drc-pci"
+#define SPAPR_DRC_PCI_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_PCI)
+#define SPAPR_DRC_PCI_CLASS(klass) \
+        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DRC_PCI)
+#define SPAPR_DRC_PCI(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+                                        TYPE_SPAPR_DRC_PCI)
+
+#define TYPE_SPAPR_DRC_LMB "spapr-drc-lmb"
+#define SPAPR_DRC_LMB_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_LMB)
+#define SPAPR_DRC_LMB_CLASS(klass) \
+        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DRC_LMB)
+#define SPAPR_DRC_LMB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+                                        TYPE_SPAPR_DRC_LMB)
+
 /*
  * Various hotplug types managed by sPAPRDRConnector
  *
@@ -134,7 +176,6 @@ typedef struct sPAPRDRConnector {
     /*< private >*/
     DeviceState parent;
 
-    sPAPRDRConnectorType type;
     uint32_t id;
     Object *owner;
     const char *name;
@@ -163,6 +204,7 @@ typedef struct sPAPRDRConnectorClass {
     DeviceClass parent;
 
     /*< public >*/
+    sPAPRDRConnectorTypeShift typeshift;
 
     /* accessors for guest-visible (generally via RTAS) DR state */
     uint32_t (*set_isolation_state)(sPAPRDRConnector *drc,
@@ -186,8 +228,7 @@ typedef struct sPAPRDRConnectorClass {
 uint32_t spapr_drc_index(sPAPRDRConnector *drc);
 sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc);
 
-sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
-                                         sPAPRDRConnectorType type,
+sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
                                          uint32_t id);
 sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index);
 sPAPRDRConnector *spapr_dr_connector_by_id(sPAPRDRConnectorType type,
-- 
2.9.4
