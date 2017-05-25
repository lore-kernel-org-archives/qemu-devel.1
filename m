Received: from eggs.gnu.org ([2001:4830:134:3::10]:57342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoR-0006Wj-4J
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoO-0007U0-Vr
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:29 +1000
Message-Id: <20170525035132.24268-16-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/18] hw/ppc: removing drc->detach_cb and
 drc->detach_cb_opaque
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

The pointer drc->detach_cb is being used as a way of informing
the detach() function inside spapr_drc.c which cb to execute. This
information can also be retrieved simply by checking drc->type and
choosing the right callback based on it. In this context, detach_cb
is redundant information that must be managed.

After the previous spapr_lmb_release change, no detach_cb_opaques
are being used by any of the three callbacks functions. This is
yet another information that is now unused and, on top of that, can't
be migrated either.

This patch makes the following changes:

- removal of detach_cb_opaque. the 'opaque' argument was removed from
the callbacks and from the detach() function of sPAPRConnectorClass. The
attribute detach_cb_opaque of sPAPRConnector was removed.

- removal of detach_cb from the detach() call. The function pointer
detach_cb of sPAPRConnector was removed. detach() now uses a
switch(drc->type) to execute the apropriate callback. To achieve this,
spapr_core_release, spapr_lmb_release and spapr_phb_remove_pci_device_cb
callbacks were made public to be visible inside detach().

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 10 ++++++----
 hw/ppc/spapr_drc.c          | 36 ++++++++++++++++++++----------------
 hw/ppc/spapr_pci.c          |  5 +++--
 include/hw/pci-host/spapr.h |  3 +++
 include/hw/ppc/spapr.h      |  4 ++++
 include/hw/ppc/spapr_drc.h  |  8 +-------
 6 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3a79dab..14399f4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2655,7 +2655,8 @@ static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
     g_free(dimm_state);
 }
 
-static void spapr_lmb_release(DeviceState *dev, void *opaque)
+/* Callback to be called during DRC release. */
+void spapr_lmb_release(DeviceState *dev)
 {
     HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
     sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_ctrl);
@@ -2720,7 +2721,7 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
         g_assert(drc);
 
         drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-        drck->detach(drc, dev, spapr_lmb_release, NULL, errp);
+        drck->detach(drc, dev, errp);
         addr += SPAPR_MEMORY_BLOCK_SIZE;
     }
 
@@ -2767,7 +2768,8 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     object_unparent(OBJECT(dev));
 }
 
-static void spapr_core_release(DeviceState *dev, void *opaque)
+/* Callback to be called during DRC release. */
+void spapr_core_release(DeviceState *dev)
 {
     HotplugHandler *hotplug_ctrl;
 
@@ -2800,7 +2802,7 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
     g_assert(drc);
 
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    drck->detach(drc, dev, spapr_core_release, NULL, &local_err);
+    drck->detach(drc, dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 9fa5545..2851e16 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -20,6 +20,7 @@
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "hw/ppc/spapr.h" /* for RTAS return codes */
+#include "hw/pci-host/spapr.h" /* spapr_phb_remove_pci_device_cb callback */
 #include "trace.h"
 
 #define DRC_CONTAINER_PATH "/dr-connector"
@@ -99,8 +100,7 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
         if (drc->awaiting_release) {
             if (drc->configured) {
                 trace_spapr_drc_set_isolation_state_finalizing(get_index(drc));
-                drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
-                             drc->detach_cb_opaque, NULL);
+                drck->detach(drc, DEVICE(drc->dev), NULL);
             } else {
                 trace_spapr_drc_set_isolation_state_deferring(get_index(drc));
             }
@@ -153,8 +153,7 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
         if (drc->awaiting_release &&
             drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
             trace_spapr_drc_set_allocation_state_finalizing(get_index(drc));
-            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
-                         drc->detach_cb_opaque, NULL);
+            drck->detach(drc, DEVICE(drc->dev), NULL);
         } else if (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) {
             drc->awaiting_allocation = false;
         }
@@ -404,15 +403,10 @@ static void attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                              NULL, 0, NULL);
 }
 
-static void detach(sPAPRDRConnector *drc, DeviceState *d,
-                   spapr_drc_detach_cb *detach_cb,
-                   void *detach_cb_opaque, Error **errp)
+static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
 {
     trace_spapr_drc_detach(get_index(drc));
 
-    drc->detach_cb = detach_cb;
-    drc->detach_cb_opaque = detach_cb_opaque;
-
     /* if we've signalled device presence to the guest, or if the guest
      * has gone ahead and configured the device (via manually-executed
      * device add via drmgr in guest, namely), we need to wait
@@ -456,8 +450,21 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d,
 
     drc->indicator_state = SPAPR_DR_INDICATOR_STATE_INACTIVE;
 
-    if (drc->detach_cb) {
-        drc->detach_cb(drc->dev, drc->detach_cb_opaque);
+    /* Calling release callbacks based on drc->type. */
+    switch (drc->type) {
+    case SPAPR_DR_CONNECTOR_TYPE_CPU:
+        spapr_core_release(drc->dev);
+        break;
+    case SPAPR_DR_CONNECTOR_TYPE_PCI:
+        spapr_phb_remove_pci_device_cb(drc->dev);
+        break;
+    case SPAPR_DR_CONNECTOR_TYPE_LMB:
+        spapr_lmb_release(drc->dev);
+        break;
+    case SPAPR_DR_CONNECTOR_TYPE_PHB:
+    case SPAPR_DR_CONNECTOR_TYPE_VIO:
+    default:
+        g_assert(false);
     }
 
     drc->awaiting_release = false;
@@ -467,8 +474,6 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d,
     drc->fdt_start_offset = 0;
     object_property_del(OBJECT(drc), "device", NULL);
     drc->dev = NULL;
-    drc->detach_cb = NULL;
-    drc->detach_cb_opaque = NULL;
 }
 
 static bool release_pending(sPAPRDRConnector *drc)
@@ -498,8 +503,7 @@ static void reset(DeviceState *d)
          * force removal if we are
          */
         if (drc->awaiting_release) {
-            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
-                         drc->detach_cb_opaque, NULL);
+            drck->detach(drc, DEVICE(drc->dev), NULL);
         }
 
         /* non-PCI devices may be awaiting a transition to UNUSABLE */
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index a7cff32..e4daf8d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1369,7 +1369,8 @@ out:
     }
 }
 
-static void spapr_phb_remove_pci_device_cb(DeviceState *dev, void *opaque)
+/* Callback to be called during DRC release. */
+void spapr_phb_remove_pci_device_cb(DeviceState *dev)
 {
     /* some version guests do not wait for completion of a device
      * cleanup (generally done asynchronously by the kernel) before
@@ -1392,7 +1393,7 @@ static void spapr_phb_remove_pci_device(sPAPRDRConnector *drc,
 {
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
-    drck->detach(drc, DEVICE(pdev), spapr_phb_remove_pci_device_cb, phb, errp);
+    drck->detach(drc, DEVICE(pdev), errp);
 }
 
 static sPAPRDRConnector *spapr_phb_get_pci_func_drc(sPAPRPHBState *phb,
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 1c2e970..38470b2 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -123,6 +123,9 @@ sPAPRPHBState *spapr_pci_find_phb(sPAPRMachineState *spapr, uint64_t buid);
 PCIDevice *spapr_pci_find_dev(sPAPRMachineState *spapr, uint64_t buid,
                               uint32_t config_addr);
 
+/* PCI release callback. */
+void spapr_phb_remove_pci_device_cb(DeviceState *dev);
+
 /* VFIO EEH hooks */
 #ifdef CONFIG_LINUX
 bool spapr_phb_eeh_available(sPAPRPHBState *sphb);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 777b5de..98fb78b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -642,6 +642,10 @@ void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
 void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
                                     sPAPRMachineState *spapr);
 
+/* CPU and LMB DRC release callbacks. */
+void spapr_core_release(DeviceState *dev);
+void spapr_lmb_release(DeviceState *dev);
+
 /* rtas-configure-connector state */
 struct sPAPRConfigureConnectorState {
     uint32_t drc_index;
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 5524247..813b9ff 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -130,8 +130,6 @@ typedef enum {
     SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE = -9003,
 } sPAPRDRCCResponse;
 
-typedef void (spapr_drc_detach_cb)(DeviceState *d, void *opaque);
-
 typedef struct sPAPRDRConnector {
     /*< private >*/
     DeviceState parent;
@@ -158,8 +156,6 @@ typedef struct sPAPRDRConnector {
 
     /* device pointer, via link property */
     DeviceState *dev;
-    spapr_drc_detach_cb *detach_cb;
-    void *detach_cb_opaque;
 } sPAPRDRConnector;
 
 typedef struct sPAPRDRConnectorClass {
@@ -188,9 +184,7 @@ typedef struct sPAPRDRConnectorClass {
     /* QEMU interfaces for managing hotplug operations */
     void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                    int fdt_start_offset, bool coldplug, Error **errp);
-    void (*detach)(sPAPRDRConnector *drc, DeviceState *d,
-                   spapr_drc_detach_cb *detach_cb,
-                   void *detach_cb_opaque, Error **errp);
+    void (*detach)(sPAPRDRConnector *drc, DeviceState *d, Error **errp);
     bool (*release_pending)(sPAPRDRConnector *drc);
     void (*set_signalled)(sPAPRDRConnector *drc);
 } sPAPRDRConnectorClass;
-- 
2.9.4
