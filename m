Received: from eggs.gnu.org ([2001:4830:134:3::10]:54265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfO-0006p6-BP
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfM-0003Q7-6i
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:28 +1000
Message-Id: <20170915035130.8354-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/18] spapr_cpu_core: cleaning up
 qdev_get_machine() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

This patch removes the qdev_get_machine() calls that are made
in spapr_cpu_core.c in situations where we can get an existing
pointer for the MachineState by either passing it as an argument
to the function or by using other already available pointers.

Credits to Daniel Henrique Barboza for the idea and the changelog
text.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 3f7ef20910..c08ee7571a 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -174,10 +174,10 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
     g_free(sc->threads);
 }
 
-static void spapr_cpu_core_realize_child(Object *child, Error **errp)
+static void spapr_cpu_core_realize_child(Object *child,
+                                         sPAPRMachineState *spapr, Error **errp)
 {
     Error *local_err = NULL;
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     CPUState *cs = CPU(child);
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     Object *obj;
@@ -266,7 +266,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     for (j = 0; j < cc->nr_threads; j++) {
         obj = sc->threads + j * size;
 
-        spapr_cpu_core_realize_child(obj, &local_err);
+        spapr_cpu_core_realize_child(obj, spapr, &local_err);
         if (local_err) {
             goto err;
         }
-- 
2.13.5
