Received: from eggs.gnu.org ([2001:4830:134:3::10]:35240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2X0-0004up-NJ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wz-0002By-8P
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2Wy-0002BU-UL
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:17 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:19 +0200
Message-Id: <20180829153624.12299-16-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/20] virtio-pmem: prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Hildenbrand <david@redhat.com>

From: Pankaj Gupta <pagupta@redhat.com>

This is the current protoype of virtio-pmem. Support will require
machine changes for the architectures that will support it, so it will
not yet be compiled.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
[ MemoryDevice/MemoryRegion changes, cleanups, addr property "memaddr",
  split up patches ]
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/Makefile.objs                     |   1 +
 hw/virtio/virtio-pmem.c                     | 222 ++++++++++++++++++++
 include/hw/virtio/virtio-pmem.h             |  40 ++++
 include/standard-headers/linux/virtio_ids.h |   1 +
 qapi/misc.json                              |  26 ++-
 5 files changed, 289 insertions(+), 1 deletion(-)
 create mode 100644 hw/virtio/virtio-pmem.c
 create mode 100644 include/hw/virtio/virtio-pmem.h

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 1b2799cfd8..75cdd90264 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -5,6 +5,7 @@ obj-y += virtio.o
 common-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng.o
 common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
 common-obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
+obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_LINUX)) += virtio-pmem.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
 obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
new file mode 100644
index 0000000000..27ff064682
--- /dev/null
+++ b/hw/virtio/virtio-pmem.c
@@ -0,0 +1,222 @@
+/*
+ * Virtio pmem device
+ *
+ * Copyright (C) 2018 Red Hat, Inc.
+ * Copyright (C) 2018 Pankaj Gupta <pagupta@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "qemu/error-report.h"
+#include "hw/virtio/virtio-access.h"
+#include "hw/virtio/virtio-pmem.h"
+#include "hw/mem/memory-device.h"
+#include "block/aio.h"
+#include "block/thread-pool.h"
+
+typedef struct VirtIOPMEMresp {
+    int ret;
+} VirtIOPMEMResp;
+
+typedef struct VirtIODeviceRequest {
+    VirtQueueElement elem;
+    int fd;
+    VirtIOPMEM *pmem;
+    VirtIOPMEMResp resp;
+} VirtIODeviceRequest;
+
+static int worker_cb(void *opaque)
+{
+    VirtIODeviceRequest *req = opaque;
+    int err = 0;
+
+    printf("\n performing flush ...");
+    /* flush raw backing image */
+    err = fsync(req->fd);
+    printf("\n performed flush ...:errcode::%d", err);
+    if (err != 0) {
+        err = EIO;
+    }
+    req->resp.ret = err;
+
+    return 0;
+}
+
+static void done_cb(void *opaque, int ret)
+{
+    VirtIODeviceRequest *req = opaque;
+    int len = iov_from_buf(req->elem.in_sg, req->elem.in_num, 0,
+                              &req->resp, sizeof(VirtIOPMEMResp));
+
+    /* Callbacks are serialized, so no need to use atomic ops.  */
+    virtqueue_push(req->pmem->rq_vq, &req->elem, len);
+    virtio_notify((VirtIODevice *)req->pmem, req->pmem->rq_vq);
+    g_free(req);
+}
+
+static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIODeviceRequest *req;
+    VirtIOPMEM *pmem = VIRTIO_PMEM(vdev);
+    HostMemoryBackend *backend = MEMORY_BACKEND(pmem->memdev);
+    ThreadPool *pool = aio_get_thread_pool(qemu_get_aio_context());
+
+    req = virtqueue_pop(vq, sizeof(VirtIODeviceRequest));
+    if (!req) {
+        virtio_error(vdev, "virtio-pmem missing request data");
+        return;
+    }
+
+    if (req->elem.out_num < 1 || req->elem.in_num < 1) {
+        virtio_error(vdev, "virtio-pmem request not proper");
+        g_free(req);
+        return;
+    }
+    req->fd = memory_region_get_fd(&backend->mr);
+    req->pmem = pmem;
+    thread_pool_submit_aio(pool, worker_cb, req, done_cb, req);
+}
+
+static void virtio_pmem_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VirtIOPMEM *pmem = VIRTIO_PMEM(vdev);
+    struct virtio_pmem_config *pmemcfg = (struct virtio_pmem_config *) config;
+
+    virtio_stq_p(vdev, &pmemcfg->start, pmem->start);
+    virtio_stq_p(vdev, &pmemcfg->size, memory_region_size(&pmem->memdev->mr));
+}
+
+static uint64_t virtio_pmem_get_features(VirtIODevice *vdev, uint64_t features,
+                                        Error **errp)
+{
+    return features;
+}
+
+static void virtio_pmem_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice   *vdev   = VIRTIO_DEVICE(dev);
+    VirtIOPMEM     *pmem   = VIRTIO_PMEM(dev);
+
+    if (!pmem->memdev) {
+        error_setg(errp, "virtio-pmem memdev not set");
+        return;
+    } else if (host_memory_backend_is_mapped(pmem->memdev)) {
+        char *path = object_get_canonical_path_component(OBJECT(pmem->memdev));
+        error_setg(errp, "can't use already busy memdev: %s", path);
+        g_free(path);
+        return;
+    }
+
+    host_memory_backend_set_mapped(pmem->memdev, true);
+    virtio_init(vdev, TYPE_VIRTIO_PMEM, VIRTIO_ID_PMEM,
+                                          sizeof(struct virtio_pmem_config));
+    pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);
+}
+
+static void virtio_pmem_md_fill_device_info(const MemoryDeviceState *md,
+                                            MemoryDeviceInfo *info)
+{
+    VirtioPMemDeviceInfo *vi = g_new0(VirtioPMemDeviceInfo, 1);
+    VirtIOPMEM *pmem = VIRTIO_PMEM(md);
+    const char *id = memory_device_id(md);
+
+    if (id) {
+        vi->has_id = true;
+        vi->id = g_strdup(id);
+    }
+
+    vi->memaddr = pmem->start;
+    vi->size = pmem->memdev ? memory_region_size(&pmem->memdev->mr) : 0;
+    vi->memdev = object_get_canonical_path(OBJECT(pmem->memdev));
+
+    info->u.virtio_pmem.data = vi;
+    info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM;
+}
+
+static uint64_t virtio_pmem_md_get_addr(const MemoryDeviceState *md)
+{
+    VirtIOPMEM *pmem = VIRTIO_PMEM(md);
+
+    return pmem->start;
+}
+
+static void virtio_pmem_md_set_addr(MemoryDeviceState *md, uint64_t addr,
+                                    Error **errp)
+{
+    object_property_set_uint(OBJECT(md), addr, VIRTIO_PMEM_ADDR_PROP, errp);
+}
+
+static uint64_t virtio_pmem_md_get_plugged_size(const MemoryDeviceState *md,
+                                                Error **errp)
+{
+    VirtIOPMEM *pmem = VIRTIO_PMEM(md);
+
+    if (!pmem->memdev) {
+        error_setg(errp, "'%s' property must be set", VIRTIO_PMEM_MEMDEV_PROP);
+        return 0;
+    }
+
+    return memory_region_size(&pmem->memdev->mr);
+}
+
+static MemoryRegion *virtio_pmem_md_get_memory_region(MemoryDeviceState *md,
+                                                      Error **errp)
+{
+    VirtIOPMEM *pmem = VIRTIO_PMEM(md);
+
+    if (!pmem->memdev) {
+        error_setg(errp, "'%s' property must be set", VIRTIO_PMEM_MEMDEV_PROP);
+        return NULL;
+    }
+
+    return &pmem->memdev->mr;
+}
+
+static Property virtio_pmem_properties[] = {
+    DEFINE_PROP_UINT64(VIRTIO_PMEM_ADDR_PROP, VirtIOPMEM, start, 0),
+    DEFINE_PROP_LINK(VIRTIO_PMEM_MEMDEV_PROP, VirtIOPMEM, memdev,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_pmem_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(klass);
+
+    dc->props = virtio_pmem_properties;
+
+    vdc->realize      =  virtio_pmem_realize;
+    vdc->get_config   =  virtio_pmem_get_config;
+    vdc->get_features =  virtio_pmem_get_features;
+
+    mdc->get_addr         = virtio_pmem_md_get_addr;
+    mdc->set_addr         = virtio_pmem_md_set_addr;
+    mdc->get_plugged_size = virtio_pmem_md_get_plugged_size;
+    mdc->get_memory_region  = virtio_pmem_md_get_memory_region;
+    mdc->fill_device_info = virtio_pmem_md_fill_device_info;
+}
+
+static TypeInfo virtio_pmem_info = {
+    .name          = TYPE_VIRTIO_PMEM,
+    .parent        = TYPE_VIRTIO_DEVICE,
+    .class_init    = virtio_pmem_class_init,
+    .instance_size = sizeof(VirtIOPMEM),
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_MEMORY_DEVICE },
+        { }
+  },
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_pmem_info);
+}
+
+type_init(virtio_register_types)
diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
new file mode 100644
index 0000000000..11e549e0f1
--- /dev/null
+++ b/include/hw/virtio/virtio-pmem.h
@@ -0,0 +1,40 @@
+/*
+ * Virtio pmem Device
+ *
+ * Copyright Red Hat, Inc. 2018
+ * Copyright Pankaj Gupta <pagupta@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef QEMU_VIRTIO_PMEM_H
+#define QEMU_VIRTIO_PMEM_H
+
+#include "hw/virtio/virtio.h"
+#include "sysemu/hostmem.h"
+#include "standard-headers/linux/virtio_ids.h"
+
+#define TYPE_VIRTIO_PMEM "virtio-pmem"
+
+#define VIRTIO_PMEM(obj) \
+        OBJECT_CHECK(VirtIOPMEM, (obj), TYPE_VIRTIO_PMEM)
+
+#define VIRTIO_PMEM_ADDR_PROP "memaddr"
+#define VIRTIO_PMEM_MEMDEV_PROP "memdev"
+
+/* VirtIOPMEM device structure */
+typedef struct VirtIOPMEM {
+    VirtIODevice parent_obj;
+
+    VirtQueue *rq_vq;
+    uint64_t start;
+    HostMemoryBackend *memdev;
+} VirtIOPMEM;
+
+struct virtio_pmem_config {
+    uint64_t start;
+    uint64_t size;
+};
+#endif
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 6d5c3b2d4f..346389565a 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -43,5 +43,6 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_PMEM         25 /* virtio pmem */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/qapi/misc.json b/qapi/misc.json
index 7c36de0464..cadbca26ac 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2907,6 +2907,29 @@
           }
 }
 
+##
+# @VirtioPMemDeviceInfo:
+#
+# VirtioPMem state information
+#
+# @id: device's ID
+#
+# @memaddr: physical address in memory, where device is mapped
+#
+# @size: size of memory that the device provides
+#
+# @memdev: memory backend linked with device
+#
+# Since: 3.1
+##
+{ 'struct': 'VirtioPMemDeviceInfo',
+  'data': { '*id': 'str',
+            'memaddr': 'size',
+            'size': 'size',
+            'memdev': 'str'
+          }
+}
+
 ##
 # @MemoryDeviceInfo:
 #
@@ -2916,7 +2939,8 @@
 ##
 { 'union': 'MemoryDeviceInfo',
   'data': { 'dimm': 'PCDIMMDeviceInfo',
-            'nvdimm': 'PCDIMMDeviceInfo'
+            'nvdimm': 'PCDIMMDeviceInfo',
+            'virtio-pmem': 'VirtioPMemDeviceInfo'
           }
 }
 
-- 
2.17.1
