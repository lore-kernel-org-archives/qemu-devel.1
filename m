Received: from eggs.gnu.org ([2001:4830:134:3::10]:51451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRGoa-0005GM-Ts
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRGoX-0006Ea-GT
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:48:24 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  8 Jun 2018 14:48:11 +0200
Message-Id: <20180608124816.22140-2-david@redhat.com>
In-Reply-To: <20180608124816.22140-1-david@redhat.com>
References: <20180608124816.22140-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/6] spapr: no need to verify the node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

The node property can always be queried and the value has already been
verified in pc_dimm_realize().

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
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
2.17.0
