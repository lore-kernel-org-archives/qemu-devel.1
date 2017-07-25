Received: from eggs.gnu.org ([2001:4830:134:3::10]:51557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZser-0000Yt-2z
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZseo-0006Fe-7u
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:45:25 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 25 Jul 2017 15:45:09 +1000
Message-Id: <20170725054510.15177-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170725054510.15177-1-david@gibson.dropbear.id.au>
References: <20170725054510.15177-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 3/4] spapr: Fix QEMU abort during memory unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, lvivier@redhat.com, groug@kaod.org, bharata@linux.vnet.ibm.com, thuth@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Commit 0cffce56 (hw/ppc/spapr.c: adding pending_dimm_unplugs to
sPAPRMachineState) introduced a new way to track pending LMBs of DIMM
device that is marked for removal. Since this commit we can hit the
assert in spapr_pending_dimm_unplugs_add() in the following situation:

- DIMM device removal fails as the guest doesn't allow the removal.
- Subsequent attempt to remove the same DIMM would hit the assert
  as the corresponding sPAPRDIMMState is still part of the
  pending_dimm_unplugs list.

Fix this by removing the assert and conditionally adding the
sPAPRDIMMState to pending_dimm_unplugs list only when it is not
already present.

Fixes: 0cffce56ae3501c5783d779f97993ce478acf856
Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
[dwg: Tweaked to avoid returning NULL when spapr_pending_dimm_unplugs_add()
 does find an existing entry]
Reviewed-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1cb09e7c64..2a3e53d5d5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2850,11 +2850,26 @@ static sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState *s,
     return dimm_state;
 }
 
-static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
-                                           sPAPRDIMMState *dimm_state)
+static sPAPRDIMMState *spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
+                                                      uint32_t nr_lmbs,
+                                                      PCDIMMDevice *dimm)
 {
-    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm));
-    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
+    sPAPRDIMMState *ds = NULL;
+
+    /*
+     * If this request is for a DIMM whose removal had failed earlier
+     * (due to guest's refusal to remove the LMBs), we would have this
+     * dimm already in the pending_dimm_unplugs list. In that
+     * case don't add again.
+     */
+    ds = spapr_pending_dimm_unplugs_find(spapr, dimm);
+    if (!ds) {
+        ds = g_malloc0(sizeof(sPAPRDIMMState));
+        ds->nr_lmbs = nr_lmbs;
+        ds->dimm = dimm;
+        QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, ds, next);
+    }
+    return ds;
 }
 
 static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
@@ -2875,7 +2890,6 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
     uint32_t avail_lmbs = 0;
     uint64_t addr_start, addr;
     int i;
-    sPAPRDIMMState *ds;
 
     addr_start = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP,
                                          &error_abort);
@@ -2891,11 +2905,7 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
         addr += SPAPR_MEMORY_BLOCK_SIZE;
     }
 
-    ds = g_malloc0(sizeof(sPAPRDIMMState));
-    ds->nr_lmbs = avail_lmbs;
-    ds->dimm = dimm;
-    spapr_pending_dimm_unplugs_add(ms, ds);
-    return ds;
+    return spapr_pending_dimm_unplugs_add(ms, avail_lmbs, dimm);
 }
 
 /* Callback to be called during DRC release. */
@@ -2911,6 +2921,7 @@ void spapr_lmb_release(DeviceState *dev)
      * during the unplug process. In this case recover it. */
     if (ds == NULL) {
         ds = spapr_recover_pending_dimm_state(spapr, PC_DIMM(dev));
+        g_assert(ds);
         /* The DRC being examined by the caller at least must be counted */
         g_assert(ds->nr_lmbs);
     }
@@ -2942,18 +2953,13 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
     uint64_t addr_start, addr;
     int i;
     sPAPRDRConnector *drc;
-    sPAPRDIMMState *ds;
-
     addr_start = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
                                          &local_err);
     if (local_err) {
         goto out;
     }
 
-    ds = g_malloc0(sizeof(sPAPRDIMMState));
-    ds->nr_lmbs = nr_lmbs;
-    ds->dimm = dimm;
-    spapr_pending_dimm_unplugs_add(spapr, ds);
+    spapr_pending_dimm_unplugs_add(spapr, nr_lmbs, dimm);
 
     addr = addr_start;
     for (i = 0; i < nr_lmbs; i++) {
-- 
2.13.3
