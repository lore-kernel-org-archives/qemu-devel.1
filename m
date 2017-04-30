Received: from eggs.gnu.org ([2001:4830:134:3::10]:36652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d4sbw-0005OE-DD
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 13:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d4sbt-0005tQ-8S
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 13:26:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53292
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d4sbt-0005sI-2c
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 13:26:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3UHNgic060510
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 13:26:12 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a4ptx1ss8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 13:26:12 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Sun, 30 Apr 2017 14:26:10 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Sun, 30 Apr 2017 14:25:44 -0300
In-Reply-To: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
References: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170430172547.13415-3-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/5] hw/ppc: removing spapr_drc_detach_cb
 opaques
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Following up the previous detach_cb change, this patch removes the
detach_cb_opaque entirely from the code.

The reason is that the drc->detach_cb_opaque object can't be
restored in the post load of the upcoming DRC migration and no detach
callbacks actually need this opaque. 'spapr_core_release' is
receiving it as NULL, 'spapr_phb_remove_pci_device_cb' is receiving
a phb object as opaque but is't using it. These were trivial removal
cases.

However, the LM removal callback 'spapr_lmb_release' is receiving
and using the opaque object, a 'sPAPRDIMMState' struct. This struct
holds the number of LMBs the DIMM object contains and the callback
was using this counter as a countdown to check if all LMB DRCs were
release before proceeding to the DIMM unplug. To remove the need of
this callback we have choices such as:

- migrate the 'sPAPRDIMMState' struct. This would require creating a
QTAILQ to store all DIMMStates and an additional 'dimm_id' field to
associate the DIMMState with the DIMM object. We could attach this
QTAILQ to the 'sPAPRPHBState' and retrieve it later in the callback.

- fetch the state of the LMB DRCs directly by scanning the state of
them and, if all of them are released, proceed with the DIMM unplug.

The second approach was chosen. The new 'spapr_all_lmbs_drcs_released'
function scans all LMBs of a given DIMM device to see if their DRC
state are inactive. If all of them are inactive return 'true', 'false'
otherwise. This function is being called inside the 'spapr_lmb_release'
callback, replacing the role of the 'sPAPRDIMMState' opaque. The
'sPAPRDIMMState' struct was removed from the code given that there are
no more uses for it.

After all these changes, there are no roles left for the 'detach_cb_opaque'
attribute of the 'sPAPRDRConnector' as well, so we can safely remove
it from the code too.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c             | 46 +++++++++++++++++++++++++++++++++-------------
 hw/ppc/spapr_drc.c         | 16 +++++-----------
 hw/ppc/spapr_pci.c         |  4 ++--
 include/hw/ppc/spapr_drc.h |  6 ++----
 4 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bc11757..8b9a6cf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1887,21 +1887,43 @@ static void spapr_drc_reset(void *opaque)
     }
 }
 
-typedef struct sPAPRDIMMState {
-    uint32_t nr_lmbs;
-} sPAPRDIMMState;
+static bool spapr_all_lmbs_drcs_released(PCDIMMDevice *dimm)
+{
+    Error *local_err = NULL;
+    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
+    uint64_t size = memory_region_size(mr);
+
+    uint64_t addr;
+    addr = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &local_err);
+    if (local_err) {
+        error_propagate(&error_abort, local_err);
+        return false;
+    }
+    uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
 
-static void spapr_lmb_release(DeviceState *dev, void *opaque)
+    sPAPRDRConnector *drc;
+    int i = 0;
+    for (i = 0; i < nr_lmbs; i++) {
+        drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
+                addr / SPAPR_MEMORY_BLOCK_SIZE);
+        g_assert(drc);
+        if (drc->indicator_state != SPAPR_DR_INDICATOR_STATE_INACTIVE) {
+            return false;
+        }
+        addr += SPAPR_MEMORY_BLOCK_SIZE;
+    }
+    return true;
+}
+
+static void spapr_lmb_release(DeviceState *dev)
 {
-    sPAPRDIMMState *ds = (sPAPRDIMMState *)opaque;
     HotplugHandler *hotplug_ctrl;
 
-    if (--ds->nr_lmbs) {
+    if (!spapr_all_lmbs_drcs_released(PC_DIMM(dev))) {
         return;
     }
 
-    g_free(ds);
-
     /*
      * Now that all the LMBs have been removed by the guest, call the
      * pc-dimm unplug handler to cleanup up the pc-dimm device.
@@ -1979,7 +2001,7 @@ static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
     return &ms->possible_cpus->cpus[index];
 }
 
-static void spapr_core_release(DeviceState *dev, void *opaque)
+static void spapr_core_release(DeviceState *dev)
 {
     HotplugHandler *hotplug_ctrl;
 
@@ -2635,17 +2657,15 @@ static void spapr_del_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     sPAPRDRConnectorClass *drck;
     uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
     int i;
-    sPAPRDIMMState *ds = g_malloc0(sizeof(sPAPRDIMMState));
     uint64_t addr = addr_start;
 
-    ds->nr_lmbs = nr_lmbs;
     for (i = 0; i < nr_lmbs; i++) {
         drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
                 addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
 
         drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-        drck->detach(drc, dev, ds, errp);
+        drck->detach(drc, dev, errp);
         addr += SPAPR_MEMORY_BLOCK_SIZE;
     }
 
@@ -2746,7 +2766,7 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
     g_assert(drc);
 
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    drck->detach(drc, dev, NULL, &local_err);
+    drck->detach(drc, dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index afe5d82..6f98242 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -99,8 +99,7 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
         if (drc->awaiting_release) {
             if (drc->configured) {
                 trace_spapr_drc_set_isolation_state_finalizing(get_index(drc));
-                drck->detach(drc, DEVICE(drc->dev), drc->detach_cb_opaque,
-                                         NULL);
+                drck->detach(drc, DEVICE(drc->dev), NULL);
             } else {
                 trace_spapr_drc_set_isolation_state_deferring(get_index(drc));
             }
@@ -153,8 +152,7 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
         if (drc->awaiting_release &&
             drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
             trace_spapr_drc_set_allocation_state_finalizing(get_index(drc));
-            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb_opaque,
-                         NULL);
+            drck->detach(drc, DEVICE(drc->dev), NULL);
         } else if (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) {
             drc->awaiting_allocation = false;
         }
@@ -404,13 +402,10 @@ static void attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                              NULL, 0, NULL);
 }
 
-static void detach(sPAPRDRConnector *drc, DeviceState *d,
-                   void *detach_cb_opaque, Error **errp)
+static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
 {
     trace_spapr_drc_detach(get_index(drc));
 
-    drc->detach_cb_opaque = detach_cb_opaque;
-
     /* if we've signalled device presence to the guest, or if the guest
      * has gone ahead and configured the device (via manually-executed
      * device add via drmgr in guest, namely), we need to wait
@@ -455,7 +450,7 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d,
     drc->indicator_state = SPAPR_DR_INDICATOR_STATE_INACTIVE;
 
     if (drc->detach_cb) {
-        drc->detach_cb(drc->dev, drc->detach_cb_opaque);
+        drc->detach_cb(drc->dev);
     }
 
     drc->awaiting_release = false;
@@ -466,7 +461,6 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d,
     object_property_del(OBJECT(drc), "device", NULL);
     drc->dev = NULL;
     drc->detach_cb = NULL;
-    drc->detach_cb_opaque = NULL;
 }
 
 static bool release_pending(sPAPRDRConnector *drc)
@@ -496,7 +490,7 @@ static void reset(DeviceState *d)
          * force removal if we are
          */
         if (drc->awaiting_release) {
-            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb_opaque, NULL);
+            drck->detach(drc, DEVICE(drc->dev), NULL);
         }
 
         /* non-PCI devices may be awaiting a transition to UNUSABLE */
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 935e65e..c620eee 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1369,7 +1369,7 @@ out:
     }
 }
 
-static void spapr_phb_remove_pci_device_cb(DeviceState *dev, void *opaque)
+static void spapr_phb_remove_pci_device_cb(DeviceState *dev)
 {
     /* some version guests do not wait for completion of a device
      * cleanup (generally done asynchronously by the kernel) before
@@ -1392,7 +1392,7 @@ static void spapr_phb_remove_pci_device(sPAPRDRConnector *drc,
 {
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
-    drck->detach(drc, DEVICE(pdev), phb, errp);
+    drck->detach(drc, DEVICE(pdev), errp);
 }
 
 static sPAPRDRConnector *spapr_phb_get_pci_func_drc(sPAPRPHBState *phb,
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 0a2c173..f68c90e 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -130,7 +130,7 @@ typedef enum {
     SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE = -9003,
 } sPAPRDRCCResponse;
 
-typedef void (spapr_drc_detach_cb)(DeviceState *d, void *opaque);
+typedef void (spapr_drc_detach_cb)(DeviceState *d);
 
 typedef struct sPAPRDRConnector {
     /*< private >*/
@@ -159,7 +159,6 @@ typedef struct sPAPRDRConnector {
     /* device pointer, via link property */
     DeviceState *dev;
     spapr_drc_detach_cb *detach_cb;
-    void *detach_cb_opaque;
 } sPAPRDRConnector;
 
 typedef struct sPAPRDRConnectorClass {
@@ -188,8 +187,7 @@ typedef struct sPAPRDRConnectorClass {
     /* QEMU interfaces for managing hotplug operations */
     void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                    int fdt_start_offset, bool coldplug, Error **errp);
-    void (*detach)(sPAPRDRConnector *drc, DeviceState *d,
-                   void *detach_cb_opaque, Error **errp);
+    void (*detach)(sPAPRDRConnector *drc, DeviceState *d, Error **errp);
     bool (*release_pending)(sPAPRDRConnector *drc);
     void (*set_signalled)(sPAPRDRConnector *drc);
 } sPAPRDRConnectorClass;
-- 
2.9.3
