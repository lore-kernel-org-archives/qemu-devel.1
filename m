Received: from eggs.gnu.org ([2001:4830:134:3::10]:33860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6k96-0004uv-49
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6k92-0006Sc-VO
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42127
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d6k92-0006SQ-O8
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45Khjnh061816
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 16:48:07 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8scbdjtc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 16:48:07 -0400
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 5 May 2017 17:48:05 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 17:47:42 -0300
In-Reply-To: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170505204746.14116-3-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v9 2/6] hw/ppc: removing drc->detach_cb and
 drc->detach_cb_opaque
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com

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
---
 hw/ppc/spapr.c              | 10 ++++++----
 hw/ppc/spapr_drc.c          | 36 ++++++++++++++++++++----------------
 hw/ppc/spapr_pci.c          |  5 +++--
 include/hw/pci-host/spapr.h |  3 +++
 include/hw/ppc/spapr.h      |  4 ++++
 include/hw/ppc/spapr_drc.h  |  8 +-------
 6 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 346c827..e190eb9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2610,7 +2610,8 @@ static uint64_t spapr_dimm_get_address(PCDIMMDevice *dimm)
     return addr;
 }
 
-static void spapr_lmb_release(DeviceState *dev, void *opaque)
+/* Callback to be called during DRC release. */
+void spapr_lmb_release(DeviceState *dev)
 {
     HotplugHandler *hotplug_ctrl;
 
@@ -2652,7 +2653,7 @@ static void spapr_del_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
         g_assert(drc);
 
         drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-        drck->detach(drc, dev, spapr_lmb_release, NULL, errp);
+        drck->detach(drc, dev, errp);
         addr += SPAPR_MEMORY_BLOCK_SIZE;
     }
 
@@ -2728,7 +2729,8 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     object_unparent(OBJECT(dev));
 }
 
-static void spapr_core_release(DeviceState *dev, void *opaque)
+/* Callback to be called during DRC release. */
+void spapr_core_release(DeviceState *dev)
 {
     HotplugHandler *hotplug_ctrl;
 
@@ -2761,7 +2763,7 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
     g_assert(drc);
 
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    drck->detach(drc, dev, spapr_core_release, NULL, &local_err);
+    drck->detach(drc, dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index a1cdc87..1c72160 100644
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
+    case SPAPR_DR_CONNECTOR_TYPE_PHB:
+    case SPAPR_DR_CONNECTOR_TYPE_VIO:
+    case SPAPR_DR_CONNECTOR_TYPE_PCI:
+        spapr_phb_remove_pci_device_cb(drc->dev);
+        break;
+    case SPAPR_DR_CONNECTOR_TYPE_LMB:
+        spapr_lmb_release(drc->dev);
+        break;
+    default:
+        ;
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
index e7567e2..5775db8 100644
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
index 3e2b5ab..adc9fdb 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -640,6 +640,10 @@ void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
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
2.9.3
