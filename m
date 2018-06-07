Received: from eggs.gnu.org ([2001:4830:134:3::10]:55729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9E-0002kF-OV
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9E-0001tH-5a
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:28 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Jun 2018 18:52:12 +0200
Message-Id: <20180607165218.9558-3-david@redhat.com>
In-Reply-To: <20180607165218.9558-1-david@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/8] spapr: no need to verify the node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>

The node property can always be queried and the value has already been
verified in pc_dimm_realize().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2375cbee12..d038f3243e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3578,14 +3578,7 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
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
+        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, NULL);
 
         spapr_memory_plug(hotplug_dev, dev, node, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
-- 
2.17.0
