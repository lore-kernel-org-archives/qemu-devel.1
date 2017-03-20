Received: from eggs.gnu.org ([2001:4830:134:3::10]:58270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwp-0005CB-Ad
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwn-0004xg-Si
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:51743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cpkwn-0004uJ-GD
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:17 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 20 Mar 2017 08:12:47 +0800
Message-Id: <20170320001249.25521-9-haozhong.zhang@intel.com>
In-Reply-To: <20170320001249.25521-1-haozhong.zhang@intel.com>
References: <20170320001249.25521-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v2 08/10] hostmem: add a host memory
 backend for Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xen.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Some virtual devices (e.g. NVDIMM) use the host memory backend to map
its backend resources to the guest. When those devices are used on Xen,
the mapping has to be managed out of QEMU. In order to reuse other parts
of the implementation of those devices, we introduce a host memory
backend for Xen (memory-backend-xen) which is mostly a placeholder
that only creates an empty memory region and does not actually
allocate and map the resource.

Following is an example of a vNVDIMM device backed by a host pmem
namespace,
   -object memory-backend-xen,id=mem1,mem-path=/dev/pmem0,size=4G
   -device nvdimm,id=nvdimm1,memdev=mem1

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 backends/Makefile.objs |   1 +
 backends/hostmem-xen.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++
 backends/hostmem.c     |   8 ++++
 hw/mem/pc-dimm.c       |   5 +-
 4 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 backends/hostmem-xen.c

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 0e0f1567b2..11dcaa4d0e 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -9,6 +9,7 @@ common-obj-$(CONFIG_TPM) += tpm.o
 
 common-obj-y += hostmem.o hostmem-ram.o
 common-obj-$(CONFIG_LINUX) += hostmem-file.o
+common-obj-${CONFIG_XEN_BACKEND} += hostmem-xen.o
 
 common-obj-y += cryptodev.o
 common-obj-y += cryptodev-builtin.o
diff --git a/backends/hostmem-xen.c b/backends/hostmem-xen.c
new file mode 100644
index 0000000000..b1b446766d
--- /dev/null
+++ b/backends/hostmem-xen.c
@@ -0,0 +1,121 @@
+/*
+ * QEMU Host Memory Backend for Xen
+ *
+ * Copyright(C) 2017 Intel Corporation.
+ *
+ * Author:
+ *   Haozhong Zhang <haozhong.zhang@intel.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/mmap-alloc.h"
+#include "sysemu/hostmem.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+
+
+#define TYPE_MEMORY_BACKEND_XEN "memory-backend-xen"
+
+#define MEMORY_BACKEND_XEN(obj) \
+    OBJECT_CHECK(HostMemoryBackendXen, (obj), TYPE_MEMORY_BACKEND_XEN)
+
+typedef struct HostMemoryBackendXen HostMemoryBackendXen;
+
+struct HostMemoryBackendXen {
+    HostMemoryBackend parent_obj;
+
+    char *mem_path;
+};
+
+static void xen_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
+{
+    HostMemoryBackendXen *db = MEMORY_BACKEND_XEN(backend);
+    int fd;
+    size_t page_size;
+
+    if (!backend->size) {
+        error_setg(errp, "can't create backend with size 0");
+        return;
+    }
+    memory_region_init(&backend->mr,
+                       OBJECT(backend), db->mem_path, backend->size);
+
+    fd = open(db->mem_path, O_RDONLY);
+    if (!fd) {
+        error_setg(errp, "can't open file %s, err %d", db->mem_path, errno);
+        return;
+    }
+    page_size = qemu_fd_getpagesize(fd);
+    backend->mr.align = MAX(page_size, QEMU_VMALLOC_ALIGN);
+    close(fd);
+}
+
+static void xen_backend_class_init(ObjectClass *oc, void *data)
+{
+    HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
+
+    bc->alloc = xen_backend_memory_alloc;
+}
+
+static char *get_mem_path(Object *o, Error **errp)
+{
+    HostMemoryBackendXen *db = MEMORY_BACKEND_XEN(o);
+
+    return g_strdup(db->mem_path);
+}
+
+static void set_mem_path(Object *o, const char *str, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+    HostMemoryBackendXen *db = MEMORY_BACKEND_XEN(o);
+
+    if (memory_region_size(&backend->mr)) {
+        error_setg(errp, "cannot change property value");
+        return;
+    }
+    g_free(db->mem_path);
+    db->mem_path = g_strdup(str);
+}
+
+static void
+xen_backend_instance_init(Object *o)
+{
+    object_property_add_str(o, "mem-path", get_mem_path,
+                            set_mem_path, NULL);
+}
+
+static void xen_backend_instance_finalize(Object *o)
+{
+    HostMemoryBackendXen *db = MEMORY_BACKEND_XEN(o);
+
+    g_free(db->mem_path);
+}
+
+static const TypeInfo xen_backend_info = {
+    .name = TYPE_MEMORY_BACKEND_XEN,
+    .parent = TYPE_MEMORY_BACKEND,
+    .class_init = xen_backend_class_init,
+    .instance_init = xen_backend_instance_init,
+    .instance_finalize = xen_backend_instance_finalize,
+    .instance_size = sizeof(HostMemoryBackendXen),
+};
+
+static void register_types(void)
+{
+    type_register_static(&xen_backend_info);
+}
+
+type_init(register_types);
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 7f5de70609..ee5e59c133 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -18,6 +18,7 @@
 #include "qapi-visit.h"
 #include "qemu/config-file.h"
 #include "qom/object_interfaces.h"
+#include "hw/xen/xen.h"
 
 #ifdef CONFIG_NUMA
 #include <numaif.h>
@@ -274,6 +275,13 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
             goto out;
         }
 
+        /* The backend storage of MEMORY_BACKEND_XEN is managed by Xen,
+         * so no further work in this function is needed.
+         */
+        if (xen_enabled() && !backend->mr.ram_block) {
+            goto out;
+        }
+
         ptr = memory_region_get_ram_ptr(&backend->mr);
         sz = memory_region_size(&backend->mr);
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9e8dab0e89..69c5784252 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -28,6 +28,7 @@
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "hw/virtio/vhost.h"
+#include "hw/xen/xen.h"
 
 typedef struct pc_dimms_capacity {
      uint64_t size;
@@ -107,7 +108,9 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
     }
 
     memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);
-    vmstate_register_ram(vmstate_mr, dev);
+    if (!xen_enabled()) {
+        vmstate_register_ram(vmstate_mr, dev);
+    }
     numa_set_mem_node_id(addr, memory_region_size(mr), dimm->node);
 
 out:
-- 
2.12.0
