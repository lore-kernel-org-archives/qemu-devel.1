Received: from eggs.gnu.org ([2001:4830:134:3::10]:35382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7yF-00011S-SK
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7yE-00041Y-U8
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:20:27 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 May 2018 15:19:40 +0200
Message-Id: <20180511131953.12905-5-david@redhat.com>
In-Reply-To: <20180511131953.12905-1-david@redhat.com>
References: <20180511131953.12905-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/17] pc: route all memory devices through
 the machine hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Hildenbrand <david@redhat.com>

Necessary to hotplug them cleanly later. We can only support memory
devices that are not DIMMs if we have a parent bus. Otherwise we might
miss "Device '%s' can not be hotplugged on this machine" cases.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 39153fa083..7a5558ebea 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -74,6 +74,7 @@
 #include "hw/nmi.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
+#include "hw/mem/memory-device.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -2079,6 +2080,12 @@ static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
         return HOTPLUG_HANDLER(machine);
     }
 
+    if (dev->parent_bus) {
+        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
+            return HOTPLUG_HANDLER(machine);
+        }
+    }
+
     return NULL;
 }
 
-- 
2.14.3
