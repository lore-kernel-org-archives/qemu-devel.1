Received: from eggs.gnu.org ([2001:4830:134:3::10]:57292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoQ-0006VS-22
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoP-0007UN-5K
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:23 +1000
Message-Id: <20170525035132.24268-10-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/18] spapr_cpu_core: drop reference on ICP
 object during CPU realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

When a piece of code allocates an object, it implicitely gets a reference
on it. If it then makes that object a child property of another object, it
should drop its own reference at some point otherwise the child object can
never be finalized. The current code hence leaks one ICP object per CPU
when hot-removing a core.

Failing to add a newly allocated ICP object to the CPU is a bug. While here,
let's ensure QEMU aborts if this ever happens.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 1df1404..ff7058e 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -143,7 +143,8 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     Object *obj;
 
     obj = object_new(spapr->icp_type);
-    object_property_add_child(OBJECT(cpu), "icp", obj, NULL);
+    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
+    object_unref(obj);
     object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
-- 
2.9.4
