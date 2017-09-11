Received: from eggs.gnu.org ([2001:4830:134:3::10]:56195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGY5-0000rx-1b
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGY2-0004W3-FJ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:23374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1drGY2-0004UV-2W
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:14 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 11 Sep 2017 12:41:50 +0800
Message-Id: <20170911044157.15403-4-haozhong.zhang@intel.com>
In-Reply-To: <20170911044157.15403-1-haozhong.zhang@intel.com>
References: <20170911044157.15403-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v3 03/10] hostmem-xen: add a host
 memory backend for Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xen.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

vNVDIMM requires a host memory backend to allocate its backend
resources to the guest. When QEMU is used as Xen device model, the
backend resource allocation of vNVDIMM is managed out of QEMU. A new
host memory backend 'memory-backend-xen' is introduced to represent
the backend resource allocated by Xen. It simply creates a memory
region of the specified size as a placeholder in the guest address
space, which will be mapped by Xen to the actual backend resource.

Following example QEMU options create a vNVDIMM device backed by a 4GB
host PMEM region at host physical address 0x100000000:
   -object memory-backend-xen,id=mem1,host-addr=0x100000000,size=4G
   -device nvdimm,id=nvdimm1,memdev=mem1

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 backends/Makefile.objs |   1 +
 backends/hostmem-xen.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++
 backends/hostmem.c     |   9 +++++
 hw/mem/pc-dimm.c       |   6 ++-
 4 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 backends/hostmem-xen.c

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 0400799efd..3096fde21f 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -5,6 +5,7 @@ common-obj-$(CONFIG_TPM) += tpm.o
 
 common-obj-y += hostmem.o hostmem-ram.o
 common-obj-$(CONFIG_LINUX) += hostmem-file.o
+common-obj-${CONFIG_XEN_BACKEND} += hostmem-xen.o
 
 common-obj-y += cryptodev.o
 common-obj-y += cryptodev-builtin.o
diff --git a/backends/hostmem-xen.c b/backends/hostmem-xen.c
new file mode 100644
index 0000000000..99211efd81
--- /dev/null
+++ b/backends/hostmem-xen.c
@@ -0,0 +1,108 @@
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
+#include "sysemu/hostmem.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
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
+    uint64_t host_addr;
+};
+
+static void xen_backend_get_host_addr(Object *obj, Visitor *v, const char *name,
+                                      void *opaque, Error **errp)
+{
+    HostMemoryBackendXen *backend = MEMORY_BACKEND_XEN(obj);
+    uint64_t value = backend->host_addr;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static void xen_backend_set_host_addr(Object *obj, Visitor *v, const char *name,
+                                      void *opaque, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+    HostMemoryBackendXen *xb = MEMORY_BACKEND_XEN(obj);
+    Error *local_err = NULL;
+    uint64_t value;
+
+    if (memory_region_size(&backend->mr)) {
+        error_setg(&local_err, "cannot change property value");
+        goto out;
+    }
+
+    visit_type_size(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    xb->host_addr = value;
+
+ out:
+    error_propagate(errp, local_err);
+}
+
+static void xen_backend_alloc(HostMemoryBackend *backend, Error **errp)
+{
+    if (!backend->size) {
+        error_setg(errp, "can't create backend with size 0");
+        return;
+    }
+    memory_region_init(&backend->mr, OBJECT(backend), "hostmem-xen",
+                       backend->size);
+    backend->mr.align = getpagesize();
+}
+
+static void xen_backend_class_init(ObjectClass *oc, void *data)
+{
+    HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
+
+    bc->alloc = xen_backend_alloc;
+
+    object_class_property_add(oc, "host-addr", "int",
+                              xen_backend_get_host_addr,
+                              xen_backend_set_host_addr,
+                              NULL, NULL, &error_abort);
+}
+
+static const TypeInfo xen_backend_info = {
+    .name = TYPE_MEMORY_BACKEND_XEN,
+    .parent = TYPE_MEMORY_BACKEND,
+    .class_init = xen_backend_class_init,
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
index ee2c2d5bfd..ba13a52994 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
+#include "hw/xen/xen.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi-types.h"
@@ -277,6 +278,14 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
             goto out;
         }
 
+        /*
+         * The backend storage of MEMORY_BACKEND_XEN is managed by Xen,
+         * so no further work in this function is needed.
+         */
+        if (xen_enabled() && !backend->mr.ram_block) {
+            goto out;
+        }
+
         ptr = memory_region_get_ram_ptr(&backend->mr);
         sz = memory_region_size(&backend->mr);
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index bdf6649083..7e1fe005ee 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -28,6 +28,7 @@
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "hw/virtio/vhost.h"
+#include "hw/xen/xen.h"
 
 typedef struct pc_dimms_capacity {
      uint64_t size;
@@ -108,7 +109,10 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
     }
 
     memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);
-    vmstate_register_ram(vmstate_mr, dev);
+    /* memory-backend-xen is not backed by RAM. */
+    if (!xen_enabled()) {
+        vmstate_register_ram(vmstate_mr, dev);
+    }
     numa_set_mem_node_id(addr, memory_region_size(mr), dimm->node);
 
 out:
-- 
2.11.0
