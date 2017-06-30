Received: from eggs.gnu.org ([2001:4830:134:3::10]:34509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRn-00004x-Ob
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRm-0007yO-55
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:24 +1000
Message-Id: <20170630104632.27942-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/21] spapr: prevent QEMU crash when CPU
 realization fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

ICPState objects were being allocated before CPU thread realization.
However commit 9ed656631d73 (xics: setup cpu at realize time) reversed it
by allocating ICPState objects after CPU thread is realized. But it
didn't take care to fix the error path because of which we observe
a SIGSEGV when CPU thread realization fails during cold/hotplug.

Fix this by ensuring that we do object_unparent() of ICPState object
only in case when is was created earlier.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index d6719d5..ea278ce 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -178,7 +178,7 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     CPUState *cs = CPU(child);
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-    Object *obj = NULL;
+    Object *obj;
 
     object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
@@ -198,13 +198,14 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
-        goto error;
+        goto free_icp;
     }
 
     return;
 
-error:
+free_icp:
     object_unparent(obj);
+error:
     error_propagate(errp, local_err);
 }
 
-- 
2.9.4
