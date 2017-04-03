Received: from eggs.gnu.org ([2001:4830:134:3::10]:43457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cuyum-0008Hg-8c
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cuyuj-0003vy-0M
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:08:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  3 Apr 2017 20:08:32 +1000
Message-Id: <20170403100832.24088-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170403100832.24088-1-david@gibson.dropbear.id.au>
References: <20170403100832.24088-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/1] pseries: Enforce homogeneous
 threads-per-core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, imammedo@redhat.com, bharata@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

For reasons that may be useful in future, CPU core objects, as used on the
pseries machine type have their own nr-threads property, potentially
allowing cores with different numbers of threads in the same system.

If the user/management uses the values specified in query-hotpluggable-cpus
as they're expected to do, this will never matter in pratice.  But that's
not actually enforced - it's possible to manually specify a core with
a different number of threads from that in -smp.  That will confuse the
platform - most immediately, this can be used to create a CPU thread with
index above max_cpus which leads to an assertion failure in
spapr_cpu_core_realize().

For now, enforce that all cores must have the same, standard, number of
threads.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 44c26e4..35db949 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2790,6 +2790,12 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out;
     }
 
+    if (cc->nr_threads != smp_threads) {
+        error_setg(errp, "invalid nr-threads %d, must be %d",
+                   cc->nr_threads, smp_threads);
+        return;
+    }
+
     core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
     if (!core_slot) {
         error_setg(&local_err, "core id %d out of range", cc->core_id);
-- 
2.9.3
