Received: from eggs.gnu.org ([2001:4830:134:3::10]:40648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWzxN-0002dE-Ij
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWzxM-0001cd-4f
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:56:37 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 17 Jul 2017 16:56:13 +1000
Message-Id: <20170717065621.4688-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170717065621.4688-1-david@gibson.dropbear.id.au>
References: <20170717065621.4688-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/21] spapr: fix potential memory leak in
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
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sjitindarsingh@gmail.com, David Gibson <david@gibson.dropbear.id.au>

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
index 16d450f21c..a58dd54392 100644
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
2.13.3
