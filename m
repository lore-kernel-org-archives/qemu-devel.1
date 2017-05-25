Received: from eggs.gnu.org ([2001:4830:134:3::10]:57474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoT-0006Zr-Ng
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoR-0007Wz-MZ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:26 +1000
Message-Id: <20170525035132.24268-13-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/18] pseries: Restore support for total vcpus
 not a multiple of threads-per-core for old machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

As of pseries-2.7 and later, we require the total number of guest vcpus to
be a multiple of the threads-per-core.  pseries-2.6 and earlier machine
types, however, are supposed to allow this for the sake of migration from
old qemu versions which allowed this.

Unfortunately, 8149e29 "pseries: Enforce homogeneous threads-per-core"
broke this by not considering the old machine type case.  This fixes it by
only applying the check when the machine type supports hotpluggable cpus.
By not-entirely-coincidence, that corresponds to the same time when we
started enforcing total threads being a multiple of threads-per-core.

Fixes: 8149e2992f7811355cc34721b79d69d1a3a667dd

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c92d269..bcb0e18 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2863,7 +2863,13 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out;
     }
 
-    if (cc->nr_threads != smp_threads) {
+    /*
+     * In general we should have homogeneous threads-per-core, but old
+     * (pre hotplug support) machine types allow the last core to have
+     * reduced threads as a compatibility hack for when we allowed
+     * total vcpus not a multiple of threads-per-core.
+     */
+    if (mc->has_hotpluggable_cpus && (cc->nr_threads != smp_threads)) {
         error_setg(errp, "invalid nr-threads %d, must be %d",
                    cc->nr_threads, smp_threads);
         return;
-- 
2.9.4
