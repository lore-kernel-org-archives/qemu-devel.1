Received: from eggs.gnu.org ([2001:4830:134:3::10]:49334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVAaX-0000iK-I0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 01:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVAaW-0004o7-7n
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 01:53:29 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 12 Jul 2017 15:53:17 +1000
Message-Id: <20170712055317.26225-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170712055317.26225-1-david@gibson.dropbear.id.au>
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 8/8] spapr: Implement DR-indicator for
 physical DRCs only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com, groug@kaod.org, danielhb@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

According to PAPR, the DR-indicator should only be valid for physical DRCs,
not logical DRCs.  At the moment we implement it for all DRCs, so restrict
it to physical ones only.

We move the state to the physical DRC subclass, which means adding some
QOM boilerplate to handle the newly distinct type.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c         | 68 ++++++++++++++++++++++++++++++++++++++++++----
 include/hw/ppc/spapr_drc.h | 13 ++++++---
 2 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 423db80..39b7cef 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -478,7 +478,6 @@ static const VMStateDescription vmstate_spapr_drc = {
     .needed = spapr_drc_needed,
     .fields  = (VMStateField []) {
         VMSTATE_UINT32(state, sPAPRDRConnector),
-        VMSTATE_UINT32(dr_indicator, sPAPRDRConnector),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -575,10 +574,63 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     dk->user_creatable = false;
 }
 
+static bool drc_physical_needed(void *opaque)
+{
+    sPAPRDRCPhysical *drcp = (sPAPRDRCPhysical *)opaque;
+    sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(drcp);
+
+    if ((drc->dev && (drcp->dr_indicator == SPAPR_DR_INDICATOR_ACTIVE))
+        || (!drc->dev && (drcp->dr_indicator == SPAPR_DR_INDICATOR_INACTIVE))) {
+        return false;
+    }
+    return true;
+}
+
+static const VMStateDescription vmstate_spapr_drc_physical = {
+    .name = "spapr_drc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = drc_physical_needed,
+    .fields  = (VMStateField []) {
+        VMSTATE_UINT32(dr_indicator, sPAPRDRCPhysical),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void drc_physical_reset(void *opaque)
+{
+    sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(opaque);
+    sPAPRDRCPhysical *drcp = SPAPR_DRC_PHYSICAL(drc);
+
+    if (drc->dev) {
+        drcp->dr_indicator = SPAPR_DR_INDICATOR_ACTIVE;
+    } else {
+        drcp->dr_indicator = SPAPR_DR_INDICATOR_INACTIVE;
+    }
+}
+
+static void realize_physical(DeviceState *d, Error **errp)
+{
+    sPAPRDRCPhysical *drcp = SPAPR_DRC_PHYSICAL(d);
+    Error *local_err = NULL;
+
+    realize(d, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    vmstate_register(DEVICE(drcp), spapr_drc_index(SPAPR_DR_CONNECTOR(drcp)),
+                     &vmstate_spapr_drc_physical, drcp);
+    qemu_register_reset(drc_physical_reset, drcp);
+}
+
 static void spapr_drc_physical_class_init(ObjectClass *k, void *data)
 {
+    DeviceClass *dk = DEVICE_CLASS(k);
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
+    dk->realize = realize_physical;
     drck->dr_entity_sense = physical_entity_sense;
     drck->isolate = drc_isolate_physical;
     drck->unisolate = drc_unisolate_physical;
@@ -640,7 +692,7 @@ static const TypeInfo spapr_dr_connector_info = {
 static const TypeInfo spapr_drc_physical_info = {
     .name          = TYPE_SPAPR_DRC_PHYSICAL,
     .parent        = TYPE_SPAPR_DR_CONNECTOR,
-    .instance_size = sizeof(sPAPRDRConnector),
+    .instance_size = sizeof(sPAPRDRCPhysical),
     .class_init    = spapr_drc_physical_class_init,
     .abstract      = true,
 };
@@ -883,12 +935,18 @@ static uint32_t rtas_set_dr_indicator(uint32_t idx, uint32_t state)
 {
     sPAPRDRConnector *drc = spapr_drc_by_index(idx);
 
-    if (!drc) {
-        return RTAS_OUT_PARAM_ERROR;
+    if (!drc || !object_dynamic_cast(OBJECT(drc), TYPE_SPAPR_DRC_PHYSICAL)) {
+        return RTAS_OUT_NO_SUCH_INDICATOR;
+    }
+    if ((state != SPAPR_DR_INDICATOR_INACTIVE)
+        && (state != SPAPR_DR_INDICATOR_ACTIVE)
+        && (state != SPAPR_DR_INDICATOR_IDENTIFY)
+        && (state != SPAPR_DR_INDICATOR_ACTION)) {
+        return RTAS_OUT_PARAM_ERROR; /* bad state parameter */
     }
 
     trace_spapr_drc_set_dr_indicator(idx, state);
-    drc->dr_indicator = state;
+    SPAPR_DRC_PHYSICAL(drc)->dr_indicator = state;
     return RTAS_OUT_SUCCESS;
 }
 
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 9d4fd41..a7958d0 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -33,7 +33,7 @@
 #define SPAPR_DRC_PHYSICAL_CLASS(klass) \
         OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, \
                            TYPE_SPAPR_DRC_PHYSICAL)
-#define SPAPR_DRC_PHYSICAL(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+#define SPAPR_DRC_PHYSICAL(obj) OBJECT_CHECK(sPAPRDRCPhysical, (obj), \
                                              TYPE_SPAPR_DRC_PHYSICAL)
 
 #define TYPE_SPAPR_DRC_LOGICAL "spapr-drc-logical"
@@ -198,9 +198,6 @@ typedef struct sPAPRDRConnector {
     uint32_t id;
     Object *owner;
 
-    /* DR-indicator */
-    uint32_t dr_indicator;
-
     uint32_t state;
 
     /* RTAS ibm,configure-connector state */
@@ -232,6 +229,14 @@ typedef struct sPAPRDRConnectorClass {
     void (*release)(DeviceState *dev);
 } sPAPRDRConnectorClass;
 
+typedef struct sPAPRDRCPhysical {
+    /*< private >*/
+    sPAPRDRConnector parent;
+
+    /* DR-indicator */
+    uint32_t dr_indicator;
+} sPAPRDRCPhysical;
+
 static inline bool spapr_drc_hotplugged(DeviceState *dev)
 {
     return dev->hotplugged && !runstate_check(RUN_STATE_INMIGRATE);
-- 
2.9.4
