Received: from eggs.gnu.org ([2001:4830:134:3::10]:34730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dS0MW-00049G-Sc
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dS0MT-0006Nq-Qi
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:21:56 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:37724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dS0MT-0006M2-K6
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:21:53 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B83BF8146F
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 14:21:44 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 03 Jul 2017 14:21:31 +0200
Message-ID: <149908449117.14256.2821600309813941055.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr: fix memory hotplug error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

QEMU shouldn't abort if spapr_add_lmbs()->spapr_drc_attach() fails.
Let's propagate the error instead, like it is done everywhere else
where spapr_drc_attach() is called.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 70b3fd374e2b..e103be500189 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2601,6 +2601,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     int i, fdt_offset, fdt_size;
     void *fdt;
     uint64_t addr = addr_start;
+    Error *local_err = NULL;
 
     for (i = 0; i < nr_lmbs; i++) {
         drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
@@ -2611,7 +2612,12 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
         fdt_offset = spapr_populate_memory_node(fdt, node, addr,
                                                 SPAPR_MEMORY_BLOCK_SIZE);
 
-        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
+        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
+        if (local_err) {
+            g_free(fdt);
+            error_propagate(errp, local_err);
+            return;
+        }
         addr += SPAPR_MEMORY_BLOCK_SIZE;
     }
     /* send hotplug notification to the
@@ -2657,7 +2663,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     spapr_add_lmbs(dev, addr, size, node,
                    spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
-                   &error_abort);
+                   &local_err);
 
 out:
     error_propagate(errp, local_err);
