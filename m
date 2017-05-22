Received: from eggs.gnu.org ([2001:4830:134:3::10]:39620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dCt7y-0005I7-Dr
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dCt7u-0000En-Go
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:36:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48686
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dCt7u-0000EV-BJ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:36:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4MJ9HQS049971
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 15:36:21 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2am3ek6p0q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 15:36:21 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 22 May 2017 16:36:19 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 22 May 2017 16:35:50 -0300
In-Reply-To: <20170522193551.826-1-danielhb@linux.vnet.ibm.com>
References: <20170522193551.826-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170522193551.826-5-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v11 4/5] hw/ppc/spapr.c: recover pending LMB
 unplug info in spapr_lmb_release
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

When a LMB hot unplug starts, the current DRC LMB status is stored at
spapr->pending_dimm_unplugs QTAILQ. This queue isn't migrated, thus
if a migration occurs in the middle of a LMB unplug the
spapr_lmb_release callback will lost track of the LMB unplug progress.

This patch implements a new recover function spapr_recover_pending_dimm_state
that is used inside spapr_lmb_release to recover this DRC LMB release
status that is lost during the migration.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 463177e..c4473b9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2645,6 +2645,44 @@ static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
     g_free(dimm_state);
 }
 
+static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
+                                                        PCDIMMDevice *dimm)
+{
+    sPAPRDRConnector *drc;
+    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
+    uint64_t size = memory_region_size(mr);
+    uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
+    uint32_t avail_lmbs = 0;
+
+    Error *local_err = NULL;
+    uint64_t addr;
+    addr = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP,
+                                   &local_err);
+    if (local_err) {
+        error_propagate(&error_abort, local_err);
+        return 0;
+    }
+
+    uint64_t curr_addr = addr;
+    int i;
+    for (i = 0; i < nr_lmbs; i++) {
+        drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
+                                       curr_addr / SPAPR_MEMORY_BLOCK_SIZE);
+        g_assert(drc);
+        if (drc->indicator_state != SPAPR_DR_INDICATOR_STATE_INACTIVE) {
+            avail_lmbs++;
+        }
+        curr_addr += SPAPR_MEMORY_BLOCK_SIZE;
+    }
+
+    sPAPRDIMMState *ds = g_malloc0(sizeof(sPAPRDIMMState));
+    ds->nr_lmbs = avail_lmbs;
+    ds->dimm = dimm;
+    spapr_pending_dimm_unplugs_add(ms, ds);
+    return ds;
+}
+
 /* Callback to be called during DRC release. */
 void spapr_lmb_release(DeviceState *dev)
 {
@@ -2652,7 +2690,14 @@ void spapr_lmb_release(DeviceState *dev)
     sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_ctrl);
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
-    if (--ds->nr_lmbs) {
+    /* This information will get lost if a migration occurs
+     * during the unplug process. In this case recover it. */
+    if (ds == NULL) {
+        ds = spapr_recover_pending_dimm_state(spapr, PC_DIMM(dev));
+        if (ds->nr_lmbs) {
+            return;
+        }
+    } else if (--ds->nr_lmbs) {
         return;
     }
 
-- 
2.9.4
