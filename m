Received: from eggs.gnu.org ([2001:4830:134:3::10]:49991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dS2kS-0001DK-HW
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dS2kO-000502-Jj
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:54:48 -0400
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:42099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dS2kO-0004z7-Ci
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:54:44 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 81FD9813F8
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 16:54:42 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 03 Jul 2017 16:54:36 +0200
Message-ID: <149909367669.21100.17690903693542179077.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] spapr: fix memory hotplug error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

QEMU shouldn't abort if spapr_add_lmbs()->spapr_drc_attach() fails.
Let's propagate the error instead, like it is done everywhere else
where spapr_drc_attach() is called.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
Changes in v2: - added rollback code
---
 hw/ppc/spapr.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 70b3fd374e2b..ba8f57a5a054 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2601,6 +2601,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     int i, fdt_offset, fdt_size;
     void *fdt;
     uint64_t addr = addr_start;
+    Error *local_err = NULL;
 
     for (i = 0; i < nr_lmbs; i++) {
         drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
@@ -2611,7 +2612,18 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
         fdt_offset = spapr_populate_memory_node(fdt, node, addr,
                                                 SPAPR_MEMORY_BLOCK_SIZE);
 
-        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
+        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
+        if (local_err) {
+            while (addr > addr_start) {
+                addr -= SPAPR_MEMORY_BLOCK_SIZE;
+                drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
+                                      addr / SPAPR_MEMORY_BLOCK_SIZE);
+                spapr_drc_detach(drc, dev, NULL);
+            }
+            g_free(fdt);
+            error_propagate(errp, local_err);
+            return;
+        }
         addr += SPAPR_MEMORY_BLOCK_SIZE;
     }
     /* send hotplug notification to the
@@ -2651,14 +2663,20 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     addr = object_property_get_uint(OBJECT(dimm),
                                     PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
-        pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
-        goto out;
+        goto out_unplug;
     }
 
     spapr_add_lmbs(dev, addr, size, node,
                    spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
-                   &error_abort);
+                   &local_err);
+    if (local_err) {
+        goto out_unplug;
+    }
+
+    return;
 
+out_unplug:
+    pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
 out:
     error_propagate(errp, local_err);
 }
