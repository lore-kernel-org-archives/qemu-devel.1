Received: from eggs.gnu.org ([2001:4830:134:3::10]:50678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOa-0008Ox-Ub
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOZ-000786-5J
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:24 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:52 +1100
Message-Id: <20171017042152.29443-35-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 34/34] spapr_cpu_core: rewrite machine type
 sanity check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

This makes the code easier to understand and it is consistent with what
we already do for PHBs.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 195762d8d2..3a4c174012 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -137,7 +137,12 @@ error:
 
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 {
-    sPAPRMachineState *spapr;
+    /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
+     * tries to add a sPAPR CPU core to a non-pseries machine.
+     */
+    sPAPRMachineState *spapr =
+        (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
+                                                  TYPE_SPAPR_MACHINE);
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
@@ -146,9 +151,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     void *obj;
     int i, j;
 
-    spapr = (sPAPRMachineState *) qdev_get_machine();
-    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
-        error_setg(errp, "spapr-cpu-core needs a pseries machine");
+    if (!spapr) {
+        error_setg(errp, TYPE_SPAPR_CPU_CORE " needs a pseries machine");
         return;
     }
 
-- 
2.13.6
