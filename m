Received: from eggs.gnu.org ([2001:4830:134:3::10]:56196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGY5-0000ry-1o
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGY1-0004VC-3k
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:52456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1drGY0-0004Si-QQ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:13 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 11 Sep 2017 12:41:48 +0800
Message-Id: <20170911044157.15403-2-haozhong.zhang@intel.com>
In-Reply-To: <20170911044157.15403-1-haozhong.zhang@intel.com>
References: <20170911044157.15403-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v3 01/10] nvdimm: do not intiailize
 nvdimm->label_data if label size is zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xen.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The memory region of vNVDIMM on Xen is a RAM memory region, so
memory_region_get_ram_ptr() cannot be used in nvdimm_realize() to get
a pointer to the label data area in that region. To be worse, it may
abort QEMU. As Xen currently does not support labels (i.e. label size
is 0) and every access in QEMU to labels is led by a label size check,
let's not intiailize nvdimm->label_data if the label size is 0.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 hw/mem/nvdimm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 952fce5ec8..3e58538b99 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -87,7 +87,15 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
     align = memory_region_get_alignment(mr);
 
     pmem_size = size - nvdimm->label_size;
-    nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
+    /*
+     * The memory region of vNVDIMM on Xen is not a RAM memory region,
+     * so memory_region_get_ram_ptr() below will abort QEMU. In
+     * addition that Xen currently does not support vNVDIMM labels
+     * (i.e. label_size is zero here), let's not initialize of the
+     * pointer to label data if the label size is zero.
+     */
+    if (nvdimm->label_size)
+        nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
     pmem_size = QEMU_ALIGN_DOWN(pmem_size, align);
 
     if (size <= nvdimm->label_size || !pmem_size) {
-- 
2.11.0
