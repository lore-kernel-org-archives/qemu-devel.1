Received: from eggs.gnu.org ([2001:4830:134:3::10]:52323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1fSCNo-00052s-1S
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1fSCNj-0003UL-6P
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:16:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:19946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1fSCNi-0003Rt-SH
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:16:31 -0400
From: Zhang Yi <yi.z.zhang@linux.intel.com>
Date: Mon, 11 Jun 2018 18:54:25 +0800
Message-Id: <e74aee54657de6f8d643a92ba21f467db149c2c8.1528714312.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 1/1] nvdimm: let qemu requiring section
 alignment of pmem resource.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, dan.j.williams@intel.com, ross.zwisler@linux.intel.com, stefanha@redhat.com, yu.c.zhang@linux.intel.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, linux-nvdimm@lists.01.org, ehabkost@redhat.com, Zhang Yi <yi.z.zhang@linux.intel.com>

Nvdimm driver use Memory hot-plug APIs to map it's pmem resource,
which at a section granularity.

When QEMU emulated the vNVDIMM device, decrease the label-storage,
QEMU will put the vNVDIMMs directly next to one another in physical
address space, which means that the boundary between them won't
align to the 128 MB memory section size.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 hw/mem/nvdimm.c         | 2 +-
 include/hw/mem/nvdimm.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 4087aca..ff6e171 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -109,7 +109,7 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
     NVDIMMDevice *nvdimm = NVDIMM(dimm);
     uint64_t align, pmem_size, size = memory_region_size(mr);
 
-    align = memory_region_get_alignment(mr);
+    align = MAX(memory_region_get_alignment(mr), NVDIMM_ALIGN_SIZE);
 
     pmem_size = size - nvdimm->label_size;
     nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 3c82751..1d384e4 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -41,6 +41,7 @@
  *    at least 128KB in size, which holds around 1000 labels."
  */
 #define MIN_NAMESPACE_LABEL_SIZE      (128UL << 10)
+#define NVDIMM_ALIGN_SIZE      (128UL << 20)
 
 #define TYPE_NVDIMM      "nvdimm"
 #define NVDIMM(obj)      OBJECT_CHECK(NVDIMMDevice, (obj), TYPE_NVDIMM)
-- 
2.7.4
