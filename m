Received: from eggs.gnu.org ([2001:4830:134:3::10]:56574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffhCF-00022A-KA
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffhCB-0003l5-Iz
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:48:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:63886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1ffhCB-0003XX-7X
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:48:23 -0400
From: junyan.he@gmx.com
Date: Wed, 18 Jul 2018 15:48:01 +0800
Message-Id: <1531900083-18167-6-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1531900083-18167-1-git-send-email-junyan.he@gmx.com>
References: <1531900083-18167-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 5/7 V11] mem/nvdimm: ensure write persistence
 to PMEM in label emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, yi.z.zhang@intel.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

From: Junyan He <junyan.he@intel.com>

Guest writes to vNVDIMM labels are intercepted and performed on the
backend by QEMU. When the backend is a real persistent memort, QEMU
needs to take proper operations to ensure its write persistence on the
persistent memory. Otherwise, a host power failure may result in the
loss of guest label configurations.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/mem/nvdimm.c     |  9 ++++++++-
 include/qemu/pmem.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 include/qemu/pmem.h

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 021d1c3..1c6674c 100644
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
diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
new file mode 100644
index 0000000..ebdb070
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
-- 
2.7.4
