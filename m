Received: from eggs.gnu.org ([2001:4830:134:3::10]:43615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtt3-000179-GL
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtt0-00027P-K8
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:37 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Jul 2017 16:15:11 +1000
Message-Id: <20170714061521.28300-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170714061521.28300-1-david@gibson.dropbear.id.au>
References: <20170714061521.28300-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/18] spapr: Cleanups relating to DRC
 awaiting_release field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, groug@kaod.org, sjitindarsingh@gmail.com, sbobroff@au1.ibm.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

'awaiting_release' indicates that the host has requested an unplug of the
device attached to the DRC, but the guest has not (yet) put the device
into a state where it is safe to complete removal.

1. Rename it to 'unplug_requested' which to me at least is clearer

2. Remove the ->release_pending() method used to check this from outside
spapr_drc.c.  The method only plausibly has one implementation, so use
a plain function (spapr_drc_unplug_requested()) instead.

3. Remove it from the migration stream.  Attempting to migrate mid-unplug
is broken not just for spapr - in general management has no good way to
determine if the device should be present on the destination or not.  So,
until that's fixed, there's no point adding extra things to the stream.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c         | 26 +++++++++-----------------
 hw/ppc/spapr_pci.c         |  6 ++----
 include/hw/ppc/spapr_drc.h | 11 ++++++-----
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 3ad0e8b39a..5ffbb6059f 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -66,7 +66,7 @@ static uint32_t drc_isolate_physical(sPAPRDRConnector *drc)
      * configured state, as suggested by the state diagram from PAPR+
      * 2.7, 13.4
      */
-    if (drc->awaiting_release) {
+    if (drc->unplug_requested) {
         uint32_t drc_index = spapr_drc_index(drc);
         if (drc->configured) {
             trace_spapr_drc_set_isolation_state_finalizing(drc_index);
@@ -116,7 +116,7 @@ static uint32_t drc_isolate_logical(sPAPRDRConnector *drc)
      * actually being unplugged, fail the isolation request here.
      */
     if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_LMB
-        && !drc->awaiting_release) {
+        && !drc->unplug_requested) {
         return RTAS_OUT_HW_ERROR;
     }
 
@@ -130,7 +130,7 @@ static uint32_t drc_isolate_logical(sPAPRDRConnector *drc)
      * configured state, as suggested by the state diagram from PAPR+
      * 2.7, 13.4
      */
-    if (drc->awaiting_release) {
+    if (drc->unplug_requested) {
         uint32_t drc_index = spapr_drc_index(drc);
         if (drc->configured) {
             trace_spapr_drc_set_isolation_state_finalizing(drc_index);
@@ -170,7 +170,7 @@ static uint32_t drc_set_usable(sPAPRDRConnector *drc)
     if (!drc->dev) {
         return RTAS_OUT_NO_SUCH_INDICATOR;
     }
-    if (drc->awaiting_release) {
+    if (drc->unplug_requested) {
         /* Don't allow the guest to move a device away from UNUSABLE
          * state when we want to unplug it */
         return RTAS_OUT_NO_SUCH_INDICATOR;
@@ -184,7 +184,7 @@ static uint32_t drc_set_usable(sPAPRDRConnector *drc)
 static uint32_t drc_set_unusable(sPAPRDRConnector *drc)
 {
     drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
-    if (drc->awaiting_release) {
+    if (drc->unplug_requested) {
         uint32_t drc_index = spapr_drc_index(drc);
         trace_spapr_drc_set_allocation_state_finalizing(drc_index);
         spapr_drc_detach(drc);
@@ -363,7 +363,7 @@ static void spapr_drc_release(sPAPRDRConnector *drc)
 
     drck->release(drc->dev);
 
-    drc->awaiting_release = false;
+    drc->unplug_requested = false;
     g_free(drc->fdt);
     drc->fdt = NULL;
     drc->fdt_start_offset = 0;
@@ -375,7 +375,7 @@ void spapr_drc_detach(sPAPRDRConnector *drc)
 {
     trace_spapr_drc_detach(spapr_drc_index(drc));
 
-    drc->awaiting_release = true;
+    drc->unplug_requested = true;
 
     if (drc->isolation_state != SPAPR_DR_ISOLATION_STATE_ISOLATED) {
         trace_spapr_drc_awaiting_isolated(spapr_drc_index(drc));
@@ -391,11 +391,6 @@ void spapr_drc_detach(sPAPRDRConnector *drc)
     spapr_drc_release(drc);
 }
 
-static bool release_pending(sPAPRDRConnector *drc)
-{
-    return drc->awaiting_release;
-}
-
 void spapr_drc_reset(sPAPRDRConnector *drc)
 {
     trace_spapr_drc_reset(spapr_drc_index(drc));
@@ -406,7 +401,7 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
     /* immediately upon reset we can safely assume DRCs whose devices
      * are pending removal can be safely removed.
      */
-    if (drc->awaiting_release) {
+    if (drc->unplug_requested) {
         spapr_drc_release(drc);
     }
 
@@ -454,7 +449,7 @@ static bool spapr_drc_needed(void *opaque)
     case SPAPR_DR_CONNECTOR_TYPE_LMB:
         rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) &&
                (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) &&
-               drc->configured && !drc->awaiting_release);
+               drc->configured);
         break;
     case SPAPR_DR_CONNECTOR_TYPE_PHB:
     case SPAPR_DR_CONNECTOR_TYPE_VIO:
@@ -474,7 +469,6 @@ static const VMStateDescription vmstate_spapr_drc = {
         VMSTATE_UINT32(allocation_state, sPAPRDRConnector),
         VMSTATE_UINT32(dr_indicator, sPAPRDRConnector),
         VMSTATE_BOOL(configured, sPAPRDRConnector),
-        VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -565,11 +559,9 @@ static void spapr_dr_connector_instance_init(Object *obj)
 static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
 {
     DeviceClass *dk = DEVICE_CLASS(k);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
     dk->realize = realize;
     dk->unrealize = unrealize;
-    drck->release_pending = release_pending;
     /*
      * Reason: it crashes FIXME find and document the real reason
      */
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 092a2f5f3d..6ecdf29d28 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1476,7 +1476,6 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
 {
     sPAPRPHBState *phb = SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
     PCIDevice *pdev = PCI_DEVICE(plugged_dev);
-    sPAPRDRConnectorClass *drck;
     sPAPRDRConnector *drc = spapr_phb_get_pci_drc(phb, pdev);
 
     if (!phb->dr_enabled) {
@@ -1488,8 +1487,7 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
     g_assert(drc);
     g_assert(drc->dev == plugged_dev);
 
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    if (!drck->release_pending(drc)) {
+    if (!spapr_drc_unplug_requested(drc)) {
         PCIBus *bus = PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
         uint32_t slotnr = PCI_SLOT(pdev->devfn);
         sPAPRDRConnector *func_drc;
@@ -1505,7 +1503,7 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
                 func_drck = SPAPR_DR_CONNECTOR_GET_CLASS(func_drc);
                 state = func_drck->dr_entity_sense(func_drc);
                 if (state == SPAPR_DR_ENTITY_SENSE_PRESENT
-                    && !func_drck->release_pending(func_drc)) {
+                    && !spapr_drc_unplug_requested(func_drc)) {
                     error_setg(errp,
                                "PCI: slot %d, function %d still present. "
                                "Must unplug all non-0 functions first.",
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index fc8b721639..5fa502e465 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -199,10 +199,9 @@ typedef struct sPAPRDRConnector {
     bool configured;
     sPAPRConfigureConnectorState *ccs;
 
-    bool awaiting_release;
-
     /* device pointer, via link property */
     DeviceState *dev;
+    bool unplug_requested;
 } sPAPRDRConnector;
 
 typedef struct sPAPRDRConnectorClass {
@@ -218,9 +217,6 @@ typedef struct sPAPRDRConnectorClass {
     uint32_t (*isolate)(sPAPRDRConnector *drc);
     uint32_t (*unisolate)(sPAPRDRConnector *drc);
     void (*release)(DeviceState *dev);
-
-    /* QEMU interfaces for managing hotplug operations */
-    bool (*release_pending)(sPAPRDRConnector *drc);
 } sPAPRDRConnectorClass;
 
 static inline bool spapr_drc_hotplugged(DeviceState *dev)
@@ -244,4 +240,9 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                       int fdt_start_offset, Error **errp);
 void spapr_drc_detach(sPAPRDRConnector *drc);
 
+static inline bool spapr_drc_unplug_requested(sPAPRDRConnector *drc)
+{
+    return drc->unplug_requested;
+}
+
 #endif /* HW_SPAPR_DRC_H */
-- 
2.13.0
