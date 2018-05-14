Received: from eggs.gnu.org ([2001:4830:134:3::10]:58820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAHc-0003jY-Uz
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAHb-0004zr-9W
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:00:44 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 14 May 2018 12:00:10 +0200
Message-Id: <20180514100023.12542-6-david@redhat.com>
In-Reply-To: <20180514100023.12542-1-david@redhat.com>
References: <20180514100023.12542-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/18] pc: route all memory devices through
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

Necessary to hotplug them cleanly later. We could drop the PC_DIMM
check, as PC_DIMM are just memory devices, but this approach is cleaner.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 510076e156..8bc41ef24b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -74,6 +74,7 @@
 #include "hw/nmi.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
+#include "hw/mem/memory-device.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -2075,6 +2076,7 @@ static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         return HOTPLUG_HANDLER(machine);
     }
-- 
2.14.3
