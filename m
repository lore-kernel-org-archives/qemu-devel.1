Received: from eggs.gnu.org ([2001:4830:134:3::10]:54238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfN-0006lE-Mw
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfM-0003QS-9j
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:25 +1000
Message-Id: <20170915035130.8354-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/18] spapr_cpu_core: fail gracefully with
 non-pseries machine types
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

Since commit 7cca3e466eb0 ("ppc: spapr: Move VCPU ID calculation into
sPAPR"), QEMU aborts when started with a *-spapr-cpu-core device and
a non-pseries machine.

Let's rely on the already existing call to object_dynamic_cast() instead
of using the SPAPR_MACHINE() macro.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 85037ef71e..3f7ef20910 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -213,7 +213,7 @@ error:
 
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    sPAPRMachineState *spapr;
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
@@ -223,7 +223,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     void *obj;
     int i, j;
 
-    if (!object_dynamic_cast(qdev_get_machine(), TYPE_SPAPR_MACHINE)) {
+    spapr = (sPAPRMachineState *) qdev_get_machine();
+    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
         error_setg(errp, "spapr-cpu-core needs a pseries machine");
         return;
     }
-- 
2.13.5
