Received: from eggs.gnu.org ([2001:4830:134:3::10]:35653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7ye-0001RV-GL
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH7yd-0004T9-JA
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:20:52 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 May 2018 15:19:46 +0200
Message-Id: <20180511131953.12905-11-david@redhat.com>
In-Reply-To: <20180511131953.12905-1-david@redhat.com>
References: <20180511131953.12905-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/17] pc-dimm: implement new memory device
 functions
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

Implement the new functions, we don't have to care about alignment for
these DIMMs right now, so leave that function unimplemented.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/pc-dimm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 12da89d562..5e2e3263ab 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -244,6 +244,21 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
     return dimm->addr;
 }
 
+static void pc_dimm_md_set_addr(MemoryDeviceState *md, uint64_t addr)
+{
+    PCDIMMDevice *dimm = PC_DIMM(md);
+
+    dimm->addr = addr;
+}
+
+static MemoryRegion *pc_dimm_md_get_memory_region(MemoryDeviceState *md)
+{
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(md);
+    PCDIMMDevice *dimm = PC_DIMM(md);
+
+    return ddc->get_memory_region(dimm, &error_abort);
+}
+
 static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md)
 {
     /* dropping const here is fine as we don't touch the memory region */
@@ -304,6 +319,8 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
     ddc->get_vmstate_memory_region = pc_dimm_get_vmstate_memory_region;
 
     mdc->get_addr = pc_dimm_md_get_addr;
+    mdc->set_addr = pc_dimm_md_set_addr;
+    mdc->get_memory_region = pc_dimm_md_get_memory_region;
     /* for a dimm plugged_size == region_size */
     mdc->get_plugged_size = pc_dimm_md_get_region_size;
     mdc->get_region_size = pc_dimm_md_get_region_size;
-- 
2.14.3
