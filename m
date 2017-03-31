Received: from eggs.gnu.org ([2001:4830:134:3::10]:35221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ctoXT-00068c-6N
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ctoXQ-0000YC-5I
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:51:55 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 31 Mar 2017 15:51:44 +1100
Message-Id: <20170331045144.9307-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH for-2.9] pseries: Enforce homogeneous
 threads-per-core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, imammedo@redhat.com
Cc: lvivier@redhat.com, ehabkost@redhat.com, agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

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
threads.  While we're at it, also enforce that the core ids are correctly
aligned based on that number of threads.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 6883f09..935ee62 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -167,6 +167,18 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     void *obj;
     int i, j;
 
+    if (cc->nr_threads != smp_threads) {
+        error_setg(errp,
+                   "Invalid nr-threads=%d of CPU[core-id: %d], must be %d",
+                   cc->nr_threads, cc->core_id, smp_threads);
+        return;
+    }
+    if ((cc->core_id % smp_threads) != 0) {
+        error_setg(errp, "Invalid CPU core-id=%d, must be a multiple of %d",
+                   cc->core_id, smp_threads);
+        return;
+    }
+
     sc->threads = g_malloc0(size * cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
         int node_id;
-- 
2.9.3
