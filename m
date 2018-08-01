Received: from eggs.gnu.org ([2001:4830:134:3::10]:45228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkrHV-0006Kd-N9
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkrHU-0008E4-Tg
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:35:13 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed,  1 Aug 2018 15:34:43 +0200
Message-Id: <20180801133444.11269-4-david@redhat.com>
In-Reply-To: <20180801133444.11269-1-david@redhat.com>
References: <20180801133444.11269-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/4] pc: drop memory region alignment check
 for 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, Eric Auger <eric.auger@redhat.com>, David Hildenbrand <david@redhat.com>

All applicable memory regions always have an alignment > 0. All memory
backends result in file_ram_alloc() or qemu_anon_ram_alloc() getting
called, setting the alignment to > 0.

So a PCDIMM memory region always has an alignment > 0. NVDIMM copy the
alignment of the original memory memory region into the handcrafted memory
region that will be used at this place.

So the check for 0 can be dropped and we can reduce the special
handling.

Dropping this check makes factoring out of alignment handling easier as
compat handling only has to look at pcmc->enforce_aligned_dimm and not
care about the alignment of the memory region.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 96be77f0dd..b31610ca63 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1713,7 +1713,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
     uint64_t align = TARGET_PAGE_SIZE;
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
+    if (pcmc->enforce_aligned_dimm) {
         align = memory_region_get_alignment(mr);
     }
 
-- 
2.17.1
