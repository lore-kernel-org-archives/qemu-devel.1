Received: from eggs.gnu.org ([2001:4830:134:3::10]:48704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eTHED-00064Z-1Q
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 20:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eTHEA-0007no-CO
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 20:06:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:31731)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eTHEA-0007mF-1o
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 20:06:50 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 25 Dec 2017 09:06:11 +0800
Message-Id: <20171225010611.32621-3-haozhong.zhang@intel.com>
In-Reply-To: <20171225010611.32621-1-haozhong.zhang@intel.com>
References: <20171225010611.32621-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH 2/2] mem/nvdimm: ensure persistence of QEMU
 writes to real NVDIMM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

QEMU intercepts guest writes to vNVDIMM labels, and then stores them
to the backend. When the backend is a real NVDIMM device, QEMU needs
to ensure the write persistence before returning to guest, so that the
guest labels will not be lost if QEMU exits abnormally.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 hw/mem/nvdimm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 952fce5ec8..b644876eb1 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/pmem.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/mem/nvdimm.h"
@@ -135,6 +136,8 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
     nvdimm_validate_rw_label_data(nvdimm, size, offset);
 
     memcpy(nvdimm->label_data + offset, buf, size);
+    /* Make QEMU writes persistent in case the backend is a real NVDIMM. */
+    pmem_persistent(nvdimm->label_data + offset, size);
 
     mr = host_memory_backend_get_memory(dimm->hostmem, &error_abort);
     backend_offset = memory_region_size(mr) - nvdimm->label_size + offset;
-- 
2.14.1
