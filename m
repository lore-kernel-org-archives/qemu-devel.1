Received: from eggs.gnu.org ([2001:4830:134:3::10]:57482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoT-0006aI-UQ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoS-0007Xk-BX
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:31 +1000
Message-Id: <20170525035132.24268-18-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/18] hw/ppc/spapr.c: recover pending LMB
 unplug info in spapr_lmb_release
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

When a LMB hot unplug starts, the current DRC LMB status is stored at
spapr->pending_dimm_unplugs QTAILQ. This queue isn't migrated, thus
if a migration occurs in the middle of a LMB unplug the
spapr_lmb_release callback will lost track of the LMB unplug progress.

This patch implements a new recover function spapr_recover_pending_dimm_state
that is used inside spapr_lmb_release to recover this DRC LMB release
status that is lost during the migration.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
[dwg: Minor stylistic changes, simplify error handling]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 14399f4..ab3aab1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2655,6 +2655,40 @@ static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
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
+    uint64_t addr_start, addr;
+    int i;
+    sPAPRDIMMState *ds;
+
+    addr_start = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP,
+                                         &error_abort);
+
+    addr = addr_start;
+    for (i = 0; i < nr_lmbs; i++) {
+        drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
+                                       addr / SPAPR_MEMORY_BLOCK_SIZE);
+        g_assert(drc);
+        if (drc->indicator_state != SPAPR_DR_INDICATOR_STATE_INACTIVE) {
+            avail_lmbs++;
+        }
+        addr += SPAPR_MEMORY_BLOCK_SIZE;
+    }
+
+    ds = g_malloc0(sizeof(sPAPRDIMMState));
+    ds->nr_lmbs = avail_lmbs;
+    ds->dimm = dimm;
+    spapr_pending_dimm_unplugs_add(ms, ds);
+    return ds;
+}
+
 /* Callback to be called during DRC release. */
 void spapr_lmb_release(DeviceState *dev)
 {
@@ -2662,7 +2696,14 @@ void spapr_lmb_release(DeviceState *dev)
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
