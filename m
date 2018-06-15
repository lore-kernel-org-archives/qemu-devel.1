Received: from eggs.gnu.org ([2001:4830:134:3::10]:54599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTpLo-00016d-TF
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTpLn-0003iy-Li
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:05:16 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 15 Jun 2018 16:04:41 +0200
Message-Id: <20180615140448.32234-7-david@redhat.com>
In-Reply-To: <20180615140448.32234-1-david@redhat.com>
References: <20180615140448.32234-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/13] nvdimm: no need to overwrite
 get_vmstate_memory_region()
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

Our parent class (PC_DIMM) provides exactly the same function.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/nvdimm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 4087aca25e..f974accbdd 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -166,11 +166,6 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
     memory_region_set_dirty(mr, backend_offset, size);
 }
 
-static MemoryRegion *nvdimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
-{
-    return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
-}
-
 static void nvdimm_class_init(ObjectClass *oc, void *data)
 {
     PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
@@ -178,7 +173,6 @@ static void nvdimm_class_init(ObjectClass *oc, void *data)
 
     ddc->realize = nvdimm_realize;
     ddc->get_memory_region = nvdimm_get_memory_region;
-    ddc->get_vmstate_memory_region = nvdimm_get_vmstate_memory_region;
 
     nvc->read_label_data = nvdimm_read_label_data;
     nvc->write_label_data = nvdimm_write_label_data;
-- 
2.17.1
