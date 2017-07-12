Received: from eggs.gnu.org ([2001:4830:134:3::10]:45103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVEGR-00033p-EO
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVEGM-0005Tl-KR
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:48:59 -0400
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:49111)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dVEGM-0005TL-EG
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:48:54 -0400
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id C01E96C0F0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 11:48:52 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 12 Jul 2017 11:48:39 +0200
Message-ID: <149985291912.20899.12562819149683053534.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr: fix potential memory leak in
 spapr_core_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Since commit 5c1da81215c7 ("spapr: Remove unnecessary differences between
hotplug and coldplug paths"), the CPU DT for the DRC is always allocated.
This causes a memory leak for pseries-2.6 and older machine types, that
don't support CPU hotplug and don't allocate DRCs for CPUs.

Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 12b3f099d4c9..4a480e1c1dd9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2993,8 +2993,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     CPUState *cs = CPU(core->threads);
     sPAPRDRConnector *drc;
     Error *local_err = NULL;
-    void *fdt = NULL;
-    int fdt_offset = 0;
     int smt = kvmppc_smt_threads();
     CPUArchId *core_slot;
     int index;
@@ -3009,9 +3007,12 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     g_assert(drc || !mc->has_hotpluggable_cpus);
 
-    fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
-
     if (drc) {
+        void *fdt;
+        int fdt_offset;
+
+        fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
+
         spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
         if (local_err) {
             g_free(fdt);
