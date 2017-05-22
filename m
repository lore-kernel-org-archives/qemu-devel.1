Received: from eggs.gnu.org ([2001:4830:134:3::10]:39526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dCt7q-0005DA-Jz
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dCt7m-0000CK-Qv
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:36:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dCt7m-0000Bq-HL
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:36:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4MJ9DjE113078
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 15:36:13 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2am3rw5pxv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 15:36:13 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 22 May 2017 16:36:10 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 22 May 2017 16:35:47 -0300
In-Reply-To: <20170522193551.826-1-danielhb@linux.vnet.ibm.com>
References: <20170522193551.826-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170522193551.826-2-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v11 1/5] hw/ppc/spapr.c: adding
 pending_dimm_unplugs to sPAPRMachineState
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

The LMB DRC release callback, spapr_lmb_release(), uses an opaque
parameter, a sPAPRDIMMState struct that stores the current LMBs that
are allocated to a DIMM (nr_lmbs). After each call to this callback,
the nr_lmbs is decremented by one and, when it reaches zero, the callback
proceeds with the qdev calls to hot unplug the LMB.

Using drc->detach_cb_opaque is problematic because it can't be migrated in
the future DRC migration work. This patch makes the following changes to
eliminate the usage of this opaque callback inside spapr_lmb_release:

- sPAPRDIMMState was moved from spapr.c and added to spapr.h. A new
attribute called 'addr' was added to it. This is used as an unique
identifier to associate a sPAPRDIMMState to a PCDIMM element.

- sPAPRMachineState now hosts a new QTAILQ called 'pending_dimm_unplugs'.
This queue of sPAPRDIMMState elements will store the DIMM state of DIMMs
that are currently going under an unplug process.

- spapr_lmb_release() will now retrieve the nr_lmbs value by getting the
correspondent sPAPRDIMMState. A helper function called spapr_dimm_get_address
was created to fetch the address of a PCDIMM device inside spapr_lmb_release.
When nr_lmbs reaches zero and the callback proceeds with the qdev hot unplug
calls, the sPAPRDIMMState struct is removed from spapr->pending_dimm_unplugs.

After these changes, the opaque argument for spapr_lmb_release is now
unused and is passed as NULL inside spapr_del_lmbs. This and the other
opaque arguments can now be safely removed from the code.

As an additional cleanup made by this patch, the spapr_del_lmbs function
was merged with spapr_memory_unplug_request. The former was being called
only by the latter and both were small enough to fit one single function.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         | 98 +++++++++++++++++++++++++++++++-------------------
 include/hw/ppc/spapr.h |  6 ++++
 2 files changed, 68 insertions(+), 36 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 75e298b..5743b78 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2059,6 +2059,7 @@ static void ppc_spapr_init(MachineState *machine)
     msi_nonbroken = true;
 
     QLIST_INIT(&spapr->phbs);
+    QTAILQ_INIT(&spapr->pending_dimm_unplugs);
 
     /* Allocate RMA if necessary */
     rma_alloc_size = kvmppc_alloc_rma(&rma);
@@ -2612,58 +2613,57 @@ out:
     error_propagate(errp, local_err);
 }
 
-typedef struct sPAPRDIMMState {
+struct sPAPRDIMMState {
+    PCDIMMDevice *dimm;
     uint32_t nr_lmbs;
-} sPAPRDIMMState;
+    QTAILQ_ENTRY(sPAPRDIMMState) next;
+};
+
+static sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState *s,
+                                                       PCDIMMDevice *dimm)
+{
+    sPAPRDIMMState *dimm_state = NULL;
+    QTAILQ_FOREACH(dimm_state, &s->pending_dimm_unplugs, next) {
+        if (dimm_state->dimm == dimm) {
+            break;
+        }
+    }
+    return dimm_state;
+}
+
+static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
+                                           sPAPRDIMMState *dimm_state)
+{
+    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm));
+    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
+}
+
+static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
+                                              sPAPRDIMMState *dimm_state)
+{
+    QTAILQ_REMOVE(&spapr->pending_dimm_unplugs, dimm_state, next);
+    g_free(dimm_state);
+}
 
 static void spapr_lmb_release(DeviceState *dev, void *opaque)
 {
-    sPAPRDIMMState *ds = (sPAPRDIMMState *)opaque;
-    HotplugHandler *hotplug_ctrl;
+    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+    sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_ctrl);
+    sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
     if (--ds->nr_lmbs) {
         return;
     }
 
-    g_free(ds);
+    spapr_pending_dimm_unplugs_remove(spapr, ds);
 
     /*
      * Now that all the LMBs have been removed by the guest, call the
      * pc-dimm unplug handler to cleanup up the pc-dimm device.
      */
-    hotplug_ctrl = qdev_get_hotplug_handler(dev);
     hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
 }
 
-static void spapr_del_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
-                           Error **errp)
-{
-    sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
-    uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
-    int i;
-    sPAPRDIMMState *ds = g_malloc0(sizeof(sPAPRDIMMState));
-    uint64_t addr = addr_start;
-
-    ds->nr_lmbs = nr_lmbs;
-    for (i = 0; i < nr_lmbs; i++) {
-        drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
-                addr / SPAPR_MEMORY_BLOCK_SIZE);
-        g_assert(drc);
-
-        drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-        drck->detach(drc, dev, spapr_lmb_release, ds, errp);
-        addr += SPAPR_MEMORY_BLOCK_SIZE;
-    }
-
-    drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
-                                   addr_start / SPAPR_MEMORY_BLOCK_SIZE);
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    spapr_hotplug_req_remove_by_count_indexed(SPAPR_DR_CONNECTOR_TYPE_LMB,
-                                              nr_lmbs,
-                                              drck->get_index(drc));
-}
-
 static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
@@ -2684,14 +2684,40 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm);
     uint64_t size = memory_region_size(mr);
+    uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
     uint64_t addr;
+    sPAPRDRConnector *drc;
+    sPAPRDRConnectorClass *drck;
 
     addr = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
         goto out;
     }
 
-    spapr_del_lmbs(dev, addr, size, &error_abort);
+    sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
+    sPAPRDIMMState *ds = g_malloc0(sizeof(sPAPRDIMMState));
+    ds->nr_lmbs = nr_lmbs;
+    ds->dimm = dimm;
+    spapr_pending_dimm_unplugs_add(spapr, ds);
+
+    uint64_t addr_start = addr;
+    int i;
+    for (i = 0; i < nr_lmbs; i++) {
+        drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
+                addr / SPAPR_MEMORY_BLOCK_SIZE);
+        g_assert(drc);
+
+        drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+        drck->detach(drc, dev, spapr_lmb_release, NULL, errp);
+        addr += SPAPR_MEMORY_BLOCK_SIZE;
+    }
+
+    drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
+                                   addr_start / SPAPR_MEMORY_BLOCK_SIZE);
+    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    spapr_hotplug_req_remove_by_count_indexed(SPAPR_DR_CONNECTOR_TYPE_LMB,
+                                              nr_lmbs,
+                                              drck->get_index(drc));
 out:
     error_propagate(errp, local_err);
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index be2b3b8..87af2f1 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -32,6 +32,7 @@ struct sPAPRRTCState {
     int64_t ns_offset;
 };
 
+typedef struct sPAPRDIMMState sPAPRDIMMState;
 typedef struct sPAPRMachineClass sPAPRMachineClass;
 
 #define TYPE_SPAPR_MACHINE      "spapr-machine"
@@ -105,6 +106,11 @@ struct sPAPRMachineState {
     /* RTAS state */
     QTAILQ_HEAD(, sPAPRConfigureConnectorState) ccs_list;
 
+    /* Pending DIMM unplug cache. It is populated when a LMB
+     * unplug starts. It can be regenerated if a migration
+     * occurs during the unplug process. */
+    QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
+
     /*< public >*/
     char *kvm_type;
     MemoryHotplugState hotplug_memory;
-- 
2.9.4
