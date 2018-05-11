Received: from eggs.gnu.org ([2001:4830:134:3::10]:35460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7yL-000173-Qk
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7yK-00048Q-RU
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:20:33 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 May 2018 15:19:42 +0200
Message-Id: <20180511131953.12905-7-david@redhat.com>
In-Reply-To: <20180511131953.12905-1-david@redhat.com>
References: <20180511131953.12905-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/17] spapr: route all memory devices
 through the machine hotplug handler
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
 hw/ppc/spapr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index db09b626cc..a7c84ec34c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3669,6 +3669,13 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
         object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         return HOTPLUG_HANDLER(machine);
     }
+
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
