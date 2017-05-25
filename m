Received: from eggs.gnu.org ([2001:4830:134:3::10]:57236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoO-0006UZ-ST
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoL-0007Rp-OK
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:18 +1000
Message-Id: <20170525035132.24268-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/18] spapr-cpu-core: release ICP object when
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
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

While here we introduce a single error path to avoid code duplication.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index a17ea07..1df1404 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -147,25 +147,25 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+        goto error;
     }
 
     object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
-        object_unparent(obj);
-        error_propagate(errp, local_err);
-        return;
+        goto error;
     }
 
     spapr_cpu_init(spapr, cpu, &local_err);
     if (local_err) {
-        object_unparent(obj);
-        error_propagate(errp, local_err);
-        return;
+        goto error;
     }
 
     xics_cpu_setup(XICS_FABRIC(spapr), cpu, ICP(obj));
+    return;
+
+error:
+    object_unparent(obj);
+    error_propagate(errp, local_err);
 }
 
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
-- 
2.9.4
