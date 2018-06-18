Received: from eggs.gnu.org ([2001:4830:134:3::10]:49922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEd-0005RO-RI
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEb-000444-4X
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:18 +1000
Message-Id: <20180618035324.19907-23-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 22/28] spapr_cpu_core: convert last snprintf()
 to g_strdup_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Because this is the preferred practice in QEMU.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 7fdb3b6667..ad404d13ec 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -176,7 +176,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
     sc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
-        char id[32];
+        char *id;
         CPUState *cs;
         PowerPCCPU *cpu;
 
@@ -194,8 +194,9 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         /* Set NUMA node for the threads belonged to core  */
         cpu->node_id = sc->node_id;
 
-        snprintf(id, sizeof(id), "thread[%d]", i);
+        id = g_strdup_printf("thread[%d]", i);
         object_property_add_child(OBJECT(sc), id, obj, &local_err);
+        g_free(id);
         if (local_err) {
             goto err;
         }
-- 
2.17.1
