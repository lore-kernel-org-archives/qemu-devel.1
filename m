Received: from eggs.gnu.org ([2001:4830:134:3::10]:48953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLl7-00025x-0f
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLl6-0008Vx-3P
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:16 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Jun 2018 14:16:52 +0200
Message-Id: <20180611121655.19616-9-david@redhat.com>
In-Reply-To: <20180611121655.19616-1-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 08/11] pc-dimm: get_memory_region() will
 never return a NULL pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

This is guaranteed by passing into host_memory_backend_get_memory() a
value that is not NULL - which is what we always do.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/pc-dimm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 7bb6ce509c..9a0da5d441 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -157,7 +157,6 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
     uint64_t value;
-    MemoryRegion *mr;
     PCDIMMDevice *dimm = PC_DIMM(obj);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(obj);
 
@@ -167,11 +166,7 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    mr = ddc->get_memory_region(dimm);
-    if (!mr) {
-        return;
-    }
-    value = memory_region_size(mr);
+    value = memory_region_size(ddc->get_memory_region(dimm));
 
     visit_type_uint64(v, name, &value, errp);
 }
@@ -241,14 +236,8 @@ static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md)
     /* dropping const here is fine as we don't touch the memory region */
     PCDIMMDevice *dimm = PC_DIMM(md);
     const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(md);
-    MemoryRegion *mr;
-
-    mr = ddc->get_memory_region(dimm);
-    if (!mr) {
-        return 0;
-    }
 
-    return memory_region_size(mr);
+    return memory_region_size(ddc->get_memory_region(dimm));
 }
 
 static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
-- 
2.17.1
