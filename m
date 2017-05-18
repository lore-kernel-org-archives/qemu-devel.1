Received: from eggs.gnu.org ([2001:4830:134:3::10]:44858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dBS9j-0002as-Cc
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dBS9e-0005vD-DD
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:36:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36395
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dBS9e-0005uv-8A
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:36:14 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4IKY4Zr099777
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 16:36:13 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ahjca10ch-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 16:36:13 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 18 May 2017 17:36:11 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 18 May 2017 17:35:47 -0300
In-Reply-To: <20170518203548.14207-1-danielhb@linux.vnet.ibm.com>
References: <20170518203548.14207-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170518203548.14207-5-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v10 4/5] hw/ppc/spapr.c: recover pending LMB
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
 hw/ppc/spapr.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5602cfc..7d304fc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2649,6 +2649,36 @@ static uint64_t spapr_dimm_get_address(PCDIMMDevice *dimm)
     return addr;
 }
 
+static sPAPRDIMMState *spapr_recover_pending_dimm_state(PCDIMMDevice *dimm,
+                                                        uint64_t addr)
+{
+    sPAPRDRConnector *drc;
+    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MemoryRegion *mr = ddc->get_memory_region(dimm);
+    uint64_t curr_addr = addr;
+    uint64_t size = memory_region_size(mr);
+    uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
+    uint32_t avail_lmbs = 0;
+    int i = 0;
+
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
+    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    sPAPRDIMMState *ds = g_malloc0(sizeof(sPAPRDIMMState));
+    ds->nr_lmbs = avail_lmbs;
+    ds->addr = addr;
+    spapr_pending_dimm_unplugs_add(spapr, ds);
+    return ds;
+}
+
 /* Callback to be called during DRC release. */
 void spapr_lmb_release(DeviceState *dev)
 {
@@ -2657,7 +2687,14 @@ void spapr_lmb_release(DeviceState *dev)
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, addr);
 
-    if (--ds->nr_lmbs) {
+    /* This information will get lost if a migration occurs
+     * during the unplug process. In this case recover it. */
+    if (ds == NULL) {
+        ds = spapr_recover_pending_dimm_state(PC_DIMM(dev), addr);
+        if (ds->nr_lmbs) {
+            return;
+        }
+    } else if (--ds->nr_lmbs) {
         return;
     }
 
-- 
2.9.4
