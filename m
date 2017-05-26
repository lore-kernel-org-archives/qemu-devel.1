Received: from eggs.gnu.org ([2001:4830:134:3::10]:49162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dE4vx-0001nP-Aj
	for qemu-devel@nongnu.org; Thu, 25 May 2017 22:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dE4vu-0002GG-2k
	for qemu-devel@nongnu.org; Thu, 25 May 2017 22:24:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:36392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dE4vt-0002Fq-Q5
	for qemu-devel@nongnu.org; Thu, 25 May 2017 22:24:54 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Fri, 26 May 2017 10:24:37 +0800
Message-Id: <20170526022438.17478-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH 1/2] nvdimm: warn if the backend is not a DAX
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>

Applications in Linux guest that use device-dax never trigger flush
that can be trapped by KVM/QEMU. Meanwhile, if the host backend is not
device-dax, QEMU cannot guarantee the persistence of guest writes.
Before solving this flushing problem, QEMU should warn users if the
host backend is not device-dax.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Message-id: CAPcyv4hV2-ZW8SMCRtD0P_86KgR3DHOvNe+6T5SY2u7wXg3gEg@mail.gmail.com
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 hw/mem/nvdimm.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index db896b0bb6..c7bb407f33 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/mem/nvdimm.h"
+#include "qemu/error-report.h"
 
 static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
@@ -78,12 +79,48 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm)
     return &nvdimm->nvdimm_mr;
 }
 
+static void nvdimm_check_dax(HostMemoryBackend *hostmem)
+{
+    char *mem_path =
+        object_property_get_str(OBJECT(hostmem), "mem-path", NULL);
+    char *dev_name = NULL, *sysfs_path = NULL;
+    bool is_dax = false;
+
+    if (!mem_path) {
+        goto out;
+    }
+
+    if (!g_str_has_prefix(mem_path, "/dev/dax")) {
+        goto out;
+    }
+
+    dev_name = mem_path + strlen("/dev/");
+    sysfs_path = g_strdup_printf("/sys/class/dax/%s", dev_name);
+    if (access(sysfs_path, F_OK)) {
+        goto out;
+    }
+
+    is_dax = true;
+
+ out:
+    if (!is_dax) {
+        error_report("warning: nvdimm backend %s is not DAX device, "
+                     "unable to guarantee persistence of guest writes",
+                     mem_path ?: "RAM");
+    }
+
+    g_free(sysfs_path);
+    g_free(mem_path);
+}
+
 static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
 {
     MemoryRegion *mr = host_memory_backend_get_memory(dimm->hostmem, errp);
     NVDIMMDevice *nvdimm = NVDIMM(dimm);
     uint64_t align, pmem_size, size = memory_region_size(mr);
 
+    nvdimm_check_dax(dimm->hostmem);
+
     align = memory_region_get_alignment(mr);
 
     pmem_size = size - nvdimm->label_size;
-- 
2.11.0
