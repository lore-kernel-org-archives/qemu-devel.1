Received: from eggs.gnu.org ([2001:4830:134:3::10]:59047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3r-0002qs-7t
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3q-0001yT-1N
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:55 +1000
Message-Id: <20180612064503.14282-26-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 25/33] spapr: no need to verify the node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: David Hildenbrand <david@redhat.com>

The node property can always be queried and the value has already been
verified in pc_dimm_realize().

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2375cbee12..f16a0b2870 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3578,14 +3578,8 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
             error_setg(errp, "Memory hotplug not supported for this machine");
             return;
         }
-        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, errp);
-        if (*errp) {
-            return;
-        }
-        if (node < 0 || node >= MAX_NODES) {
-            error_setg(errp, "Invaild node %d", node);
-            return;
-        }
+        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP,
+                                        &error_abort);
 
         spapr_memory_plug(hotplug_dev, dev, node, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
-- 
2.17.1
