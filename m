Received: from eggs.gnu.org ([2001:4830:134:3::10]:35037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wh-0004Z2-3j
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wg-00022u-6u
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2Wf-00022e-Uj
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:58 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:12 +0200
Message-Id: <20180829153624.12299-9-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/20] pc-dimm: implement memory device
 class function set_addr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Hildenbrand <david@redhat.com>

Keep it simple for now and simply set the static property, that will
fail once realized.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/pc-dimm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index a208b17c64..d4e8a415bf 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -236,6 +236,12 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
     return dimm->addr;
 }
 
+static void pc_dimm_md_set_addr(MemoryDeviceState *md, uint64_t addr,
+                                Error **errp)
+{
+    object_property_set_uint(OBJECT(md), addr, PC_DIMM_ADDR_PROP, errp);
+}
+
 static uint64_t pc_dimm_md_get_plugged_size(const MemoryDeviceState *md,
                                             Error **errp)
 {
@@ -307,6 +313,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
     ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
 
     mdc->get_addr = pc_dimm_md_get_addr;
+    mdc->set_addr = pc_dimm_md_set_addr;
     mdc->get_plugged_size = pc_dimm_md_get_plugged_size;
     mdc->get_memory_region = pc_dimm_md_get_memory_region;
     mdc->fill_device_info = pc_dimm_md_fill_device_info;
-- 
2.17.1
