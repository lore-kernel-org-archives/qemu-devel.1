Received: from eggs.gnu.org ([2001:4830:134:3::10]:35987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVvNJ-0006TX-Tm
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVvNG-0005lc-SL
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:50:58 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:40375)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dVvNG-0005k1-L0
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:50:54 -0400
Received: from player687.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id B22FE59EA7
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 09:50:45 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 14 Jul 2017 09:50:40 +0200
Message-ID: <150001864048.7077.16008343547703241545.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr: fix memory leak in spapr_core_pre_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

In case of error, we must ensure the dynamically allocated base_core_type
is freed, like it is done everywhere else in this function.

This is a regression introduced in QEMU 2.9 by commit 8149e2992f78.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 638b8243de04..ed9b57d1fc2a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3150,9 +3150,9 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
      * total vcpus not a multiple of threads-per-core.
      */
     if (mc->has_hotpluggable_cpus && (cc->nr_threads != smp_threads)) {
-        error_setg(errp, "invalid nr-threads %d, must be %d",
+        error_setg(&local_err, "invalid nr-threads %d, must be %d",
                    cc->nr_threads, smp_threads);
-        return;
+        goto out;
     }
 
     core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
