Received: from eggs.gnu.org ([2001:4830:134:3::10]:50753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1frqjU-0001UV-OD
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1frqjP-0008Uu-15
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:25:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35438 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1frqjO-0008U9-PX
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:24:54 -0400
Date: Mon, 20 Aug 2018 23:24:48 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180820104045.133968-6-mst@redhat.com>
References: <20180820104045.133968-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820104045.133968-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] mem/nvdimm: ensure write persistence to
 PMEM in label emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

From: Junyan He <junyan.he@intel.com>

Guest writes to vNVDIMM labels are intercepted and performed on the
backend by QEMU. When the backend is a real persistent memort, QEMU
needs to take proper operations to ensure its write persistence on the
persistent memory. Otherwise, a host power failure may result in the
loss of guest label configurations.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/pmem.h | 30 ++++++++++++++++++++++++++++++
 hw/mem/nvdimm.c     |  9 ++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 include/qemu/pmem.h

diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
new file mode 100644
index 0000000000..ebdb070210
--- /dev/null
+++ b/include/qemu/pmem.h
@@ -0,0 +1,30 @@
+/*
+ * QEMU header file for libpmem.
+ *
+ * Copyright (c) 2018 Intel Corporation.
+ *
+ * Author: Haozhong Zhang <address@hidden>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_PMEM_H
+#define QEMU_PMEM_H
+
+#ifdef CONFIG_LIBPMEM
+#include <libpmem.h>
+#else  /* !CONFIG_LIBPMEM */
+
+static inline void *
+pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
+{
+    /* If 'pmem' option is 'on', we should always have libpmem support,
+       or qemu will report a error and exit, never come here. */
+    g_assert_not_reached();
+    return NULL;
+}
+
+#endif /* CONFIG_LIBPMEM */
+
+#endif /* !QEMU_PMEM_H */
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 021d1c3997..1c6674c4ed 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/pmem.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/mem/nvdimm.h"
@@ -164,11 +165,17 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
 {
     MemoryRegion *mr;
     PCDIMMDevice *dimm = PC_DIMM(nvdimm);
+    bool is_pmem = object_property_get_bool(OBJECT(dimm->hostmem),
+                                            "pmem", NULL);
     uint64_t backend_offset;
 
     nvdimm_validate_rw_label_data(nvdimm, size, offset);
 
-    memcpy(nvdimm->label_data + offset, buf, size);
+    if (!is_pmem) {
+        memcpy(nvdimm->label_data + offset, buf, size);
+    } else {
+        pmem_memcpy_persist(nvdimm->label_data + offset, buf, size);
+    }
 
     mr = host_memory_backend_get_memory(dimm->hostmem);
     backend_offset = memory_region_size(mr) - nvdimm->label_size + offset;
-- 
MST
