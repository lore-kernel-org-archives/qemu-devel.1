Received: from eggs.gnu.org ([2001:4830:134:3::10]:59445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eWDbn-0003jY-1t
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 22:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eWDbk-0008Tu-OY
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 22:51:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:54621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eWDbk-0008Pj-8T
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 22:51:20 -0500
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Tue,  2 Jan 2018 11:55:27 +0800
Message-Id: <1514865329-29258-3-git-send-email-changpeng.liu@intel.com>
In-Reply-To: <1514865329-29258-1-git-send-email-changpeng.liu@intel.com>
References: <1514865329-29258-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH v8 2/4] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: changpeng.liu@intel.com, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, pbonzini@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

This commit introduces a new vhost-user device for block, it uses a
chardev to connect with the backend, same with Qemu virito-blk device,
Guest OS still uses the virtio-blk frontend driver.

To use it, start QEMU with command line like this:

qemu-system-x86_64 \
    -chardev socket,id=char0,path=/path/vhost.socket \
    -device vhost-user-blk-pci,chardev=char0,num-queues=2, \
            bootindex=2... \

Users can use different parameters for `num-queues` and `bootindex`.

Different with exist Qemu virtio-blk host device, it makes more easy
for users to implement their own I/O processing logic, such as all
user space I/O stack against hardware block device. It uses the new
vhost messages(VHOST_USER_GET_CONFIG) to get block virtio config
information from backend process.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 default-configs/pci.mak            |   1 +
 hw/block/Makefile.objs             |   3 +
 hw/block/vhost-user-blk.c          | 359 +++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c             |  55 ++++++
 hw/virtio/virtio-pci.h             |  18 ++
 include/hw/virtio/vhost-user-blk.h |  41 +++++
 6 files changed, 477 insertions(+)
 create mode 100644 hw/block/vhost-user-blk.c
 create mode 100644 include/hw/virtio/vhost-user-blk.h

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index e514bde..49a0f28 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -43,3 +43,4 @@ CONFIG_VGA_PCI=y
 CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
 CONFIG_ROCKER=y
 CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
+CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index e0ed980..4c19a58 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -13,3 +13,6 @@ obj-$(CONFIG_SH4) += tc58128.o
 
 obj-$(CONFIG_VIRTIO) += virtio-blk.o
 obj-$(CONFIG_VIRTIO) += dataplane/
+ifeq ($(CONFIG_VIRTIO),y)
+obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
+endif
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
new file mode 100644
index 0000000..b53b4c9
--- /dev/null
+++ b/hw/block/vhost-user-blk.c
@@ -0,0 +1,359 @@
+/*
+ * vhost-user-blk host device
+ *
+ * Copyright(C) 2017 Intel Corporation.
+ *
+ * Authors:
+ *  Changpeng Liu <changpeng.liu@intel.com>
+ *
+ * Largely based on the "vhost-user-scsi.c" and "vhost-scsi.c" implemented by:
+ * Felipe Franciosi <felipe@nutanix.com>
+ * Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
+ * Nicholas Bellinger <nab@risingtidesystems.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/typedefs.h"
+#include "qemu/cutils.h"
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user-blk.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-access.h"
+
+static const int user_feature_bits[] = {
+    VIRTIO_BLK_F_SIZE_MAX,
+    VIRTIO_BLK_F_SEG_MAX,
+    VIRTIO_BLK_F_GEOMETRY,
+    VIRTIO_BLK_F_BLK_SIZE,
+    VIRTIO_BLK_F_TOPOLOGY,
+    VIRTIO_BLK_F_MQ,
+    VIRTIO_BLK_F_RO,
+    VIRTIO_BLK_F_FLUSH,
+    VIRTIO_BLK_F_CONFIG_WCE,
+    VIRTIO_F_VERSION_1,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VHOST_INVALID_FEATURE_BIT
+};
+
+static void vhost_user_blk_update_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    memcpy(config, &s->blkcfg, sizeof(struct virtio_blk_config));
+}
+
+static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    struct virtio_blk_config *blkcfg = (struct virtio_blk_config *)config;
+    int ret;
+
+    if (blkcfg->wce == s->blkcfg.wce) {
+        return;
+    }
+
+    ret = vhost_dev_set_config(&s->dev, &blkcfg->wce,
+                               offsetof(struct virtio_blk_config, wce),
+                               sizeof(blkcfg->wce),
+                               VHOST_SET_CONFIG_TYPE_MASTER);
+    if (ret) {
+        error_report("set device config space failed");
+        return;
+    }
+
+    s->blkcfg.wce = blkcfg->wce;
+}
+
+static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
+{
+    int ret;
+    struct virtio_blk_config blkcfg;
+    VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
+
+    ret = vhost_dev_get_config(dev, (uint8_t *)&blkcfg,
+                               sizeof(struct virtio_blk_config));
+    if (ret < 0) {
+        error_report("get config space failed");
+        return -1;
+    }
+
+    /* valid for resize only */
+    if (blkcfg.capacity != s->blkcfg.capacity) {
+        s->blkcfg.capacity = blkcfg.capacity;
+        memcpy(dev->vdev->config, &s->blkcfg, sizeof(struct virtio_blk_config));
+        virtio_notify_config(dev->vdev);
+    }
+
+    return 0;
+}
+
+const VhostDevConfigOps blk_ops = {
+    .vhost_dev_config_notifier = vhost_user_blk_handle_config_change,
+};
+
+static void vhost_user_blk_start(VirtIODevice *vdev)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int i, ret;
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return;
+    }
+
+    ret = vhost_dev_enable_notifiers(&s->dev, vdev);
+    if (ret < 0) {
+        error_report("Error enabling host notifiers: %d", -ret);
+        return;
+    }
+
+    ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier: %d", -ret);
+        goto err_host_notifiers;
+    }
+
+    s->dev.acked_features = vdev->guest_features;
+    ret = vhost_dev_start(&s->dev, vdev);
+    if (ret < 0) {
+        error_report("Error starting vhost: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
+    /* guest_notifier_mask/pending not used yet, so just unmask
+     * everything here. virtio-pci will do the right thing by
+     * enabling/disabling irqfd.
+     */
+    for (i = 0; i < s->dev.nvqs; i++) {
+        vhost_virtqueue_mask(&s->dev, vdev, i, false);
+    }
+
+    return;
+
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(&s->dev, vdev);
+}
+
+static void vhost_user_blk_stop(VirtIODevice *vdev)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+
+    if (!k->set_guest_notifiers) {
+        return;
+    }
+
+    vhost_dev_stop(&s->dev, vdev);
+
+    ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
+    if (ret < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", ret);
+        return;
+    }
+
+    vhost_dev_disable_notifiers(&s->dev, vdev);
+}
+
+static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
+
+    if (!vdev->vm_running) {
+        should_start = false;
+    }
+
+    if (s->dev.started == should_start) {
+        return;
+    }
+
+    if (should_start) {
+        vhost_user_blk_start(vdev);
+    } else {
+        vhost_user_blk_stop(vdev);
+    }
+
+}
+
+static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
+                                            uint64_t features,
+                                            Error **errp)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    uint64_t get_features;
+
+    /* Turn on pre-defined features */
+    virtio_add_feature(&features, VIRTIO_BLK_F_SEG_MAX);
+    virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
+    virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
+    virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
+    virtio_add_feature(&features, VIRTIO_BLK_F_FLUSH);
+
+    if (s->config_wce) {
+        virtio_add_feature(&features, VIRTIO_BLK_F_CONFIG_WCE);
+    }
+    if (s->config_ro) {
+        virtio_add_feature(&features, VIRTIO_BLK_F_RO);
+    }
+    if (s->num_queues > 1) {
+        virtio_add_feature(&features, VIRTIO_BLK_F_MQ);
+    }
+
+    get_features = vhost_get_features(&s->dev, user_feature_bits, features);
+
+    return get_features;
+}
+
+static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+
+}
+
+static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    int i, ret;
+
+    if (!s->chardev.chr) {
+        error_setg(errp, "vhost-user-blk: chardev is mandatory");
+        return;
+    }
+
+    if (!s->num_queues || s->num_queues > VIRTIO_QUEUE_MAX) {
+        error_setg(errp, "vhost-user-blk: invalid number of IO queues");
+        return;
+    }
+
+    if (!s->queue_size) {
+        error_setg(errp, "vhost-user-blk: queue size must be non-zero");
+        return;
+    }
+
+    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
+                sizeof(struct virtio_blk_config));
+
+    for (i = 0; i < s->num_queues; i++) {
+        virtio_add_queue(vdev, s->queue_size,
+                         vhost_user_blk_handle_output);
+    }
+
+    s->dev.nvqs = s->num_queues;
+    s->dev.vqs = g_new(struct vhost_virtqueue, s->dev.nvqs);
+    s->dev.vq_index = 0;
+    s->dev.backend_features = 0;
+
+    ret = vhost_dev_init(&s->dev, &s->chardev, VHOST_BACKEND_TYPE_USER, 0);
+    if (ret < 0) {
+        error_setg(errp, "vhost-user-blk: vhost initialization failed: %s",
+                   strerror(-ret));
+        goto virtio_err;
+    }
+
+    ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
+                              sizeof(struct virtio_blk_config));
+    if (ret < 0) {
+        error_setg(errp, "vhost-user-blk: get block config failed");
+        goto vhost_err;
+    }
+
+    if (s->blkcfg.num_queues != s->num_queues) {
+        s->blkcfg.num_queues = s->num_queues;
+    }
+
+    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
+
+    return;
+
+vhost_err:
+    vhost_dev_cleanup(&s->dev);
+virtio_err:
+    g_free(s->dev.vqs);
+    virtio_cleanup(vdev);
+}
+
+static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(dev);
+
+    vhost_user_blk_set_status(vdev, 0);
+    vhost_dev_cleanup(&s->dev);
+    g_free(s->dev.vqs);
+    virtio_cleanup(vdev);
+}
+
+static void vhost_user_blk_instance_init(Object *obj)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(obj);
+
+    device_add_bootindex_property(obj, &s->bootindex, "bootindex",
+                                  "/disk@0,0", DEVICE(obj), NULL);
+}
+
+static const VMStateDescription vmstate_vhost_user_blk = {
+    .name = "vhost-user-blk",
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property vhost_user_blk_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
+    DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues, 1),
+    DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
+    DEFINE_PROP_BIT("config-wce", VHostUserBlk, config_wce, 0, true),
+    DEFINE_PROP_BIT("config-ro", VHostUserBlk, config_ro, 0, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    dc->props = vhost_user_blk_properties;
+    dc->vmsd = &vmstate_vhost_user_blk;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    vdc->realize = vhost_user_blk_device_realize;
+    vdc->unrealize = vhost_user_blk_device_unrealize;
+    vdc->get_config = vhost_user_blk_update_config;
+    vdc->set_config = vhost_user_blk_set_config;
+    vdc->get_features = vhost_user_blk_get_features;
+    vdc->set_status = vhost_user_blk_set_status;
+}
+
+static const TypeInfo vhost_user_blk_info = {
+    .name = TYPE_VHOST_USER_BLK,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VHostUserBlk),
+    .instance_init = vhost_user_blk_instance_init,
+    .class_init = vhost_user_blk_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&vhost_user_blk_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e92837c..b5e05d9 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1976,6 +1976,58 @@ static const TypeInfo virtio_blk_pci_info = {
     .class_init    = virtio_blk_pci_class_init,
 };
 
+#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
+/* vhost-user-blk */
+
+static Property vhost_user_blk_pci_properties[] = {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_user_blk_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props = vhost_user_blk_pci_properties;
+    k->realize = vhost_user_blk_pci_realize;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
+}
+
+static void vhost_user_blk_pci_instance_init(Object *obj)
+{
+    VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_BLK);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const TypeInfo vhost_user_blk_pci_info = {
+    .name           = TYPE_VHOST_USER_BLK_PCI,
+    .parent         = TYPE_VIRTIO_PCI,
+    .instance_size  = sizeof(VHostUserBlkPCI),
+    .instance_init  = vhost_user_blk_pci_instance_init,
+    .class_init     = vhost_user_blk_pci_class_init,
+};
+#endif
+
 /* virtio-scsi-pci */
 
 static Property virtio_scsi_pci_properties[] = {
@@ -2622,6 +2674,9 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_9p_pci_info);
 #endif
     type_register_static(&virtio_blk_pci_info);
+#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
+    type_register_static(&vhost_user_blk_pci_info);
+#endif
     type_register_static(&virtio_scsi_pci_info);
     type_register_static(&virtio_balloon_pci_info);
     type_register_static(&virtio_serial_pci_info);
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 12d3a90..813082b 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -27,6 +27,9 @@
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
 #include "hw/virtio/vhost-user-scsi.h"
+#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
+#include "hw/virtio/vhost-user-blk.h"
+#endif
 
 #ifdef CONFIG_VIRTFS
 #include "hw/9pfs/virtio-9p.h"
@@ -46,6 +49,7 @@ typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VHostSCSIPCI VHostSCSIPCI;
 typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
+typedef struct VHostUserBlkPCI VHostUserBlkPCI;
 typedef struct VirtIORngPCI VirtIORngPCI;
 typedef struct VirtIOInputPCI VirtIOInputPCI;
 typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
@@ -244,6 +248,20 @@ struct VHostUserSCSIPCI {
     VHostUserSCSI vdev;
 };
 
+#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
+/*
+ * vhost-user-blk-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VHOST_USER_BLK_PCI "vhost-user-blk-pci"
+#define VHOST_USER_BLK_PCI(obj) \
+        OBJECT_CHECK(VHostUserBlkPCI, (obj), TYPE_VHOST_USER_BLK_PCI)
+
+struct VHostUserBlkPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserBlk vdev;
+};
+#endif
+
 /*
  * virtio-blk-pci: This extends VirtioPCIProxy.
  */
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
new file mode 100644
index 0000000..5804cc9
--- /dev/null
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -0,0 +1,41 @@
+/*
+ * vhost-user-blk host device
+ * Copyright(C) 2017 Intel Corporation.
+ *
+ * Authors:
+ *  Changpeng Liu <changpeng.liu@intel.com>
+ *
+ * Based on vhost-scsi.h, Copyright IBM, Corp. 2011
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#ifndef VHOST_USER_BLK_H
+#define VHOST_USER_BLK_H
+
+#include "standard-headers/linux/virtio_blk.h"
+#include "qemu-common.h"
+#include "hw/qdev.h"
+#include "hw/block/block.h"
+#include "chardev/char-fe.h"
+#include "hw/virtio/vhost.h"
+
+#define TYPE_VHOST_USER_BLK "vhost-user-blk"
+#define VHOST_USER_BLK(obj) \
+        OBJECT_CHECK(VHostUserBlk, (obj), TYPE_VHOST_USER_BLK)
+
+typedef struct VHostUserBlk {
+    VirtIODevice parent_obj;
+    CharBackend chardev;
+    int32_t bootindex;
+    struct virtio_blk_config blkcfg;
+    uint16_t num_queues;
+    uint32_t queue_size;
+    uint32_t config_wce;
+    uint32_t config_ro;
+    struct vhost_dev dev;
+} VHostUserBlk;
+
+#endif
-- 
1.9.3
