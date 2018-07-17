Received: from eggs.gnu.org ([2001:4830:134:3::10]:50154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffJXC-0002zx-6U
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffJXB-0007bx-1v
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:32:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:18700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1ffJXA-0007Ug-N0
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:32:28 -0400
From: junyan.he@gmx.com
Date: Tue, 17 Jul 2018 14:32:08 +0800
Message-Id: <1531809130-31088-6-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
References: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 5/7 V10] mem/nvdimm: ensure write persistence
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
 include/qemu/pmem.h | 23 +++++++++++++++++++++++
 stubs/Makefile.objs |  1 +
 stubs/pmem.c        | 19 +++++++++++++++++++
 4 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 include/qemu/pmem.h
 create mode 100644 stubs/pmem.c

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
index 0000000..00d6680
--- /dev/null
+++ b/include/qemu/pmem.h
@@ -0,0 +1,23 @@
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
+void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len);
+
+#endif /* CONFIG_LIBPMEM */
+
+#endif /* !QEMU_PMEM_H */
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 53d3f32..be9a042 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -43,3 +43,4 @@ stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
 stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
+stub-obj-$(call lnot,$(CONFIG_LIBPMEM)) += pmem.o
\ No newline at end of file
diff --git a/stubs/pmem.c b/stubs/pmem.c
new file mode 100644
index 0000000..b4ec72d
--- /dev/null
+++ b/stubs/pmem.c
@@ -0,0 +1,19 @@
+/*
+ * Stubs for libpmem.
+ *
+ * Copyright (c) 2018 Intel Corporation.
+ *
+ * Author: Haozhong Zhang <address@hidden>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <string.h>
+
+#include "qemu/pmem.h"
+
+void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
+{
+    return memcpy(pmemdest, src, len);
+}
-- 
2.7.4
