Received: from eggs.gnu.org ([2001:4830:134:3::10]:43900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1ejKFD-0004st-Pb
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1ejKFC-0000Zr-Ru
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:34:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:13680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1ejKFC-0000Td-KJ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:34:14 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed,  7 Feb 2018 15:33:27 +0800
Message-Id: <20180207073331.14158-5-haozhong.zhang@intel.com>
In-Reply-To: <20180207073331.14158-1-haozhong.zhang@intel.com>
References: <20180207073331.14158-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2 4/8] mem/nvdimm: ensure write persistence to
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

Guest writes to vNVDIMM labels are intercepted and performed on the
backend by QEMU. When the backend is a real persistent memort, QEMU
needs to take proper operations to ensure its write persistence on the
persistent memory. Otherwise, a host power failure may result in the
loss of guest label configurations.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 hw/mem/nvdimm.c     |  9 ++++++++-
 include/qemu/pmem.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 include/qemu/pmem.h

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 61e677f92f..18861d1a7a 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/pmem.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi-visit.h"
@@ -156,11 +157,17 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
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
 
     mr = host_memory_backend_get_memory(dimm->hostmem, &error_abort);
     backend_offset = memory_region_size(mr) - nvdimm->label_size + offset;
diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
new file mode 100644
index 0000000000..9017596ff0
--- /dev/null
+++ b/include/qemu/pmem.h
@@ -0,0 +1,31 @@
+/*
+ * Stub functions for libpmem.
+ *
+ * Copyright (c) 2018 Intel Corporation.
+ *
+ * Author: Haozhong Zhang <haozhong.zhang@intel.com>
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
+#include <string.h>
+
+/* Stubs */
+
+static inline void *
+pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
+{
+    return memcpy(pmemdest, src, len);
+}
+
+#endif /* CONFIG_LIBPMEM */
+
+#endif /* !QEMU_PMEM_H */
-- 
2.14.1
