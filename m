Received: from eggs.gnu.org ([209.51.188.92]:50068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmOjo-0007DE-OQ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmOcw-0002PA-6X
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:55:59 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 23 Jan 2019 20:55:22 +0100
Message-Id: <20190123195527.29575-5-david@redhat.com>
In-Reply-To: <20190123195527.29575-1-david@redhat.com>
References: <20190123195527.29575-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFCv2 4/9] virtio-pmem: Prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Pankaj Gupta <pagupta@redhat.com>

From: Pankaj Gupta <pagupta@redhat.com>

This is the current protoype of virtio-pmem. Support will require
machine changes for the architectures that will support it, so it will
not yet be compiled.

TODO:
- Use separate struct for tracking requests internally
- Move request/response structs to linux headers
- Factor out linux header sync
- Drop debug printfs

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
[ MemoryDevice/MemoryRegion changes, cleanups, addr property "memaddr",
  split up patches, unplug handler ]
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/Makefile.objs                     |   2 +
 hw/virtio/virtio-pmem.c                     | 191 ++++++++++++++++++++
 include/hw/virtio/virtio-pmem.h             |  54 ++++++
 include/standard-headers/linux/virtio_ids.h |   1 +
 qapi/misc.json                              |  28 ++-
 5 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 hw/virtio/virtio-pmem.c
 create mode 100644 include/hw/virtio/virtio-pmem.h

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index ea7913d532..565667096e 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -9,6 +9,8 @@ obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
 obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
 
+obj-$(CONFIG_VIRTIO_PMEM) += virtio-pmem.o
+
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
 ifeq ($(CONFIG_PCI),y)
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
new file mode 100644
index 0000000000..6ec2ea5d1d
--- /dev/null
+++ b/hw/virtio/virtio-pmem.c
@@ -0,0 +1,191 @@
+/*
+ * Virtio PMEM device
+ *
+ * Copyright (C) 2018-2019 Red Hat, Inc.
+ *
+ * Authors:
+ *  Pankaj Gupta <pagupta@redhat.com>
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "qemu/error-report.h"
+#include "hw/virtio/virtio-pmem.h"
+#include "hw/virtio/virtio-access.h"
+#include "standard-headers/linux/virtio_ids.h"
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
+    /* Callbacks are serialized, so no need to use atomic ops. */
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
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOPMEM *pmem = VIRTIO_PMEM(dev);
+
+    if (!pmem->memdev) {
+        error_setg(errp, "virtio-pmem memdev not set");
+        return;
+    }
+
+    if (host_memory_backend_is_mapped(pmem->memdev)) {
+        char *path = object_get_canonical_path_component(OBJECT(pmem->memdev));
+        error_setg(errp, "can't use already busy memdev: %s", path);
+        g_free(path);
+        return;
+    }
+
+    host_memory_backend_set_mapped(pmem->memdev, true);
+    virtio_init(vdev, TYPE_VIRTIO_PMEM, VIRTIO_ID_PMEM,
+                sizeof(struct virtio_pmem_config));
+    pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);
+}
+
+static void virtio_pmem_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOPMEM *pmem = VIRTIO_PMEM(dev);
+
+    host_memory_backend_set_mapped(pmem->memdev, false);
+    pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);
+    virtio_cleanup(vdev);
+}
+
+static void virtio_pmem_fill_device_info(const VirtIOPMEM *pmem,
+                                         VirtioPMEMDeviceInfo *vi)
+{
+    vi->memaddr = pmem->start;
+    vi->size = pmem->memdev ? memory_region_size(&pmem->memdev->mr) : 0;
+    vi->memdev = object_get_canonical_path(OBJECT(pmem->memdev));
+}
+
+static MemoryRegion *virtio_pmem_get_memory_region(VirtIOPMEM *pmem,
+                                                   Error **errp)
+{
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
+    VirtIOPMEMClass *vpc = VIRTIO_PMEM_CLASS(klass);
+
+    dc->props = virtio_pmem_properties;
+
+    vdc->realize = virtio_pmem_realize;
+    vdc->unrealize = virtio_pmem_unrealize;
+    vdc->get_config = virtio_pmem_get_config;
+    vdc->get_features = virtio_pmem_get_features;
+
+    vpc->fill_device_info = virtio_pmem_fill_device_info;
+    vpc->get_memory_region = virtio_pmem_get_memory_region;
+}
+
+static TypeInfo virtio_pmem_info = {
+    .name          = TYPE_VIRTIO_PMEM,
+    .parent        = TYPE_VIRTIO_DEVICE,
+    .class_size    = sizeof(VirtIOPMEMClass),
+    .class_init    = virtio_pmem_class_init,
+    .instance_size = sizeof(VirtIOPMEM),
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
index 0000000000..c9917b9a31
--- /dev/null
+++ b/include/hw/virtio/virtio-pmem.h
@@ -0,0 +1,54 @@
+/*
+ * Virtio PMEM device
+ *
+ * Copyright (C) 2018-2019 Red Hat, Inc.
+ *
+ * Authors:
+ *  Pankaj Gupta <pagupta@redhat.com>
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VIRTIO_PMEM_H
+#define HW_VIRTIO_PMEM_H
+
+#include "hw/virtio/virtio.h"
+#include "sysemu/hostmem.h"
+
+#define TYPE_VIRTIO_PMEM "virtio-pmem"
+
+#define VIRTIO_PMEM(obj) \
+        OBJECT_CHECK(VirtIOPMEM, (obj), TYPE_VIRTIO_PMEM)
+#define VIRTIO_PMEM_CLASS(oc) \
+        OBJECT_CLASS_CHECK(VirtIOPMEMClass, (oc), TYPE_VIRTIO_PMEM)
+#define VIRTIO_PMEM_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(VirtIOPMEMClass, (obj), TYPE_VIRTIO_PMEM)
+
+#define VIRTIO_PMEM_ADDR_PROP "memaddr"
+#define VIRTIO_PMEM_MEMDEV_PROP "memdev"
+
+typedef struct VirtIOPMEM {
+    VirtIODevice parent_obj;
+
+    VirtQueue *rq_vq;
+    uint64_t start;
+    HostMemoryBackend *memdev;
+} VirtIOPMEM;
+
+typedef struct VirtIOPMEMClass {
+    /* private */
+    VirtIODevice parent;
+
+    /* public */
+    void (*fill_device_info)(const VirtIOPMEM *pmem, VirtioPMEMDeviceInfo *vi);
+    MemoryRegion *(*get_memory_region)(VirtIOPMEM *pmem, Error **errp);
+} VirtIOPMEMClass;
+
+struct virtio_pmem_config {
+    uint64_t start;
+    uint64_t size;
+};
+
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
index 24d20a880a..b71eca2666 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2949,16 +2949,42 @@
           }
 }
 
+##
+# @VirtioPMEMDeviceInfo:
+#
+# VirtioPMEM state information
+#
+# @id: device's ID
+#
+# @memaddr: physical address in memory, where device is mapped
+#
+# @size: size of memory that the device provides
+#
+# @memdev: memory backend linked with device
+#
+# Since: 4.0
+##
+{ 'struct': 'VirtioPMEMDeviceInfo',
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
 # Union containing information about a memory device
 #
+# nvdimm is included since 2.12. virtio-pmem is included since 4.0.
+#
 # Since: 2.1
 ##
 { 'union': 'MemoryDeviceInfo',
   'data': { 'dimm': 'PCDIMMDeviceInfo',
-            'nvdimm': 'PCDIMMDeviceInfo'
+            'nvdimm': 'PCDIMMDeviceInfo',
+            'virtio-pmem': 'VirtioPMEMDeviceInfo'
           }
 }
 
-- 
2.17.2
