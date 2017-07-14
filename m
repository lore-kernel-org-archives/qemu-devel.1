Received: from eggs.gnu.org ([2001:4830:134:3::10]:43573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtt2-00015K-Bb
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtt1-000288-13
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:36 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Jul 2017 16:15:15 +1000
Message-Id: <20170714061521.28300-13-david@gibson.dropbear.id.au>
In-Reply-To: <20170714061521.28300-1-david@gibson.dropbear.id.au>
References: <20170714061521.28300-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/18] spapr: fix potential memory leak in
 spapr_core_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, groug@kaod.org, sjitindarsingh@gmail.com, sbobroff@au1.ibm.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Since commit 5c1da81215c7 ("spapr: Remove unnecessary differences between
hotplug and coldplug paths"), the CPU DT for the DRC is always allocated.
This causes a memory leak for pseries-2.6 and older machine types, that
don't support CPU hotplug and don't allocate DRCs for CPUs.

Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e43d1b2ea2..396c3340cb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2974,8 +2974,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     CPUState *cs = CPU(core->threads);
     sPAPRDRConnector *drc;
     Error *local_err = NULL;
-    void *fdt = NULL;
-    int fdt_offset = 0;
     int smt = kvmppc_smt_threads();
     CPUArchId *core_slot;
     int index;
@@ -2991,9 +2989,12 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
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
-- 
2.13.0
