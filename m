Received: from eggs.gnu.org ([2001:4830:134:3::10]:57329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.mayatskih@gmail.com>) id 1gJfTt-0007VS-2q
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.mayatskih@gmail.com>) id 1gJfTo-0005oe-TV
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:03:52 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:43237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <v.mayatskih@gmail.com>)
	id 1gJfTm-0005hA-RK
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:03:46 -0500
Received: by mail-qk1-x744.google.com with SMTP id r71so14743854qkr.10
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 06:03:44 -0800 (PST)
From: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Date: Mon,  5 Nov 2018 14:03:27 +0000
Message-Id: <20181105140327.8363-2-v.mayatskih@gmail.com>
In-Reply-To: <20181105140327.8363-1-v.mayatskih@gmail.com>
References: <20181105140327.8363-1-v.mayatskih@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1 resend] Add vhost-pci-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Mayatskikh <v.mayatskih@gmail.com>

This driver uses the kernel-mode acceleration for virtio-blk and
allows to get a near bare metal disk performance inside a VM.

Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
---
 configure                     |  10 +
 default-configs/virtio.mak    |   1 +
 hw/block/Makefile.objs        |   1 +
 hw/block/vhost-blk.c          | 411 ++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c        |  60 +++++
 hw/virtio/virtio-pci.h        |  19 ++
 include/hw/virtio/vhost-blk.h |  43 ++++
 7 files changed, 545 insertions(+)
 create mode 100644 hw/block/vhost-blk.c
 create mode 100644 include/hw/virtio/vhost-blk.h

diff --git a/configure b/configure
index 46ae1e8c76..787bc780da 100755
--- a/configure
+++ b/configure
@@ -371,6 +371,7 @@ vhost_crypto="no"
 vhost_scsi="no"
 vhost_vsock="no"
 vhost_user=""
+vhost_blk=""
 kvm="no"
 hax="no"
 hvf="no"
@@ -869,6 +870,7 @@ Linux)
   vhost_crypto="yes"
   vhost_scsi="yes"
   vhost_vsock="yes"
+  vhost_blk="yes"
   QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
   libudev="yes"
@@ -1263,6 +1265,10 @@ for opt do
   ;;
   --enable-vhost-vsock) vhost_vsock="yes"
   ;;
+  --disable-vhost-blk) vhost_blk="no"
+  ;;
+  --enable-vhost-blk) vhost_blk="yes"
+  ;;
   --disable-opengl) opengl="no"
   ;;
   --enable-opengl) opengl="yes"
@@ -6000,6 +6006,7 @@ echo "vhost-crypto support $vhost_crypto"
 echo "vhost-scsi support $vhost_scsi"
 echo "vhost-vsock support $vhost_vsock"
 echo "vhost-user support $vhost_user"
+echo "vhost-blk support $vhost_blk"
 echo "Trace backends    $trace_backends"
 if have_backend "simple"; then
 echo "Trace output file $trace_file-<pid>"
@@ -6461,6 +6468,9 @@ fi
 if test "$vhost_user" = "yes" ; then
   echo "CONFIG_VHOST_USER=y" >> $config_host_mak
 fi
+if test "$vhost_blk" = "yes" ; then
+  echo "CONFIG_VHOST_BLK=y" >> $config_host_mak
+fi
 if test "$blobs" = "yes" ; then
   echo "INSTALL_BLOBS=yes" >> $config_host_mak
 fi
diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
index 1304849018..765c0a2a04 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -1,5 +1,6 @@
 CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
 CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
+CONFIG_VHOST_BLK=$(CONFIG_LINUX)
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_9P=y
 CONFIG_VIRTIO_BALLOON=y
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 53ce5751ae..857ce823fc 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -14,3 +14,4 @@ obj-$(CONFIG_SH4) += tc58128.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
 obj-$(CONFIG_VIRTIO_BLK) += dataplane/
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
+obj-$(CONFIG_VHOST_BLK) += vhost-blk.o
diff --git a/hw/block/vhost-blk.c b/hw/block/vhost-blk.c
new file mode 100644
index 0000000000..6d30b3c8fa
--- /dev/null
+++ b/hw/block/vhost-blk.c
@@ -0,0 +1,411 @@
+/*
+ * vhost-blk host device
+ *
+ * Copyright(C) 2018 IBM Corporation
+ *
+ * Authors:
+ *  Vitaly Mayatskikh <v.mayatskih@gmail.com>
+ *
+ * Largely based on the "vhost-user-blk.c" implemented by:
+ * Changpeng Liu <changpeng.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/cutils.h"
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-blk.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-access.h"
+#include <sys/ioctl.h>
+#include <linux/fs.h>
+
+static const int feature_bits[] = {
+    VIRTIO_BLK_F_SIZE_MAX,
+    VIRTIO_BLK_F_SEG_MAX,
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
+static void vhost_blk_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VHostBlk *s = VHOST_BLK(vdev);
+    memcpy(config, &s->blkcfg, sizeof(struct virtio_blk_config));
+}
+
+static void vhost_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
+{
+    VHostBlk *s = VHOST_BLK(vdev);
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
+static int vhost_blk_handle_config_change(struct vhost_dev *dev)
+{
+    int ret;
+    struct virtio_blk_config blkcfg;
+    VHostBlk *s = VHOST_BLK(dev->vdev);
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
+const VhostDevConfigOps vhost_blk_ops = {
+    .vhost_dev_config_notifier = vhost_blk_handle_config_change,
+};
+
+static void vhost_blk_start(VirtIODevice *vdev)
+{
+    VHostBlk *s = VHOST_BLK(vdev);
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
+    printf("hdev %p vqs %d\n", &s->dev, s->dev.nvqs);
+    ret = vhost_dev_start(&s->dev, vdev);
+    if (ret < 0) {
+        error_report("Error starting vhost: %d", -ret);
+        goto err_guest_notifiers;
+    }
+    /* guest_notifier_mask/pending not used yet, so just unmask
+     * everything here. virtio-pci will do the right thing by
+     * enabling/disabling irqfd.
+     */
+    for (i = 0; i < s->dev.nvqs; i++) {
+        vhost_virtqueue_mask(&s->dev, vdev, i, false);
+    }
+
+    s->bs_fd = open(blk_bs(s->blk)->filename, O_RDWR);
+    if (s->bs_fd < 0) {
+        error_report("Error opening backing store: %d\n", -errno);
+        goto err_ioctl;
+    }
+    ret = ioctl(s->vhostfd, _IOW(0xaf, 0x50, int), &s->bs_fd);
+    if (ret < 0) {
+        error_report("Error setting up backend: %d", -errno);
+        goto err_ioctl;
+    }
+
+    return;
+
+err_ioctl:
+    if (s->bs_fd > 0)
+        close(s->bs_fd);
+    vhost_dev_stop(&s->dev, vdev);
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(&s->dev, vdev);
+}
+
+static void vhost_blk_stop(VirtIODevice *vdev)
+{
+    VHostBlk *s = VHOST_BLK(vdev);
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
+    close(s->bs_fd);
+}
+
+static void vhost_blk_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VHostBlk *s = VHOST_BLK(vdev);
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
+        vhost_blk_start(vdev);
+    } else {
+        vhost_blk_stop(vdev);
+    }
+
+}
+
+static uint64_t vhost_blk_get_features(VirtIODevice *vdev,
+                                       uint64_t features,
+                                       Error **errp)
+{
+    VHostBlk *s = VHOST_BLK(vdev);
+
+    /* Turn on pre-defined features */
+    virtio_add_feature(&features, VIRTIO_BLK_F_SIZE_MAX);
+    virtio_add_feature(&features, VIRTIO_BLK_F_SEG_MAX);
+    virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
+    virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
+    virtio_add_feature(&features, VIRTIO_BLK_F_FLUSH);
+    virtio_add_feature(&features, VIRTIO_BLK_F_RO);
+
+    if (s->config_wce) {
+        virtio_add_feature(&features, VIRTIO_BLK_F_CONFIG_WCE);
+    }
+    if (s->num_queues > 1) {
+        virtio_add_feature(&features, VIRTIO_BLK_F_MQ);
+    }
+
+    return vhost_get_features(&s->dev, feature_bits, features);
+}
+
+static void vhost_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+}
+
+static int vhost_blk_cfg_init(VHostBlk *s)
+{
+    int ret;
+    uint64_t var64;
+    int var;
+    int fd = - 1;
+
+    fd = open(blk_bs(s->blk)->filename, O_RDWR);
+    if (fd < 0) {
+	    error_report("Can't open device %s: %d\n", blk_bs(s->blk)->filename, errno);
+	    goto out;
+    }
+    ret = ioctl(fd, BLKGETSIZE64, &var64);
+    if (ret != 0 && (errno == ENOTTY)) {
+	    ret = ioctl(fd, BLKGETSIZE, &var);
+	    var64 = var;
+    }
+    if (ret != 0) {
+	    error_report("Can't get drive size: %d\n", errno);
+	    goto out;
+    }
+    s->blkcfg.capacity = var64 / 512;
+
+    ret = ioctl(fd, BLKSSZGET, &var);
+    if (ret != 0) {
+	    error_report("Can't get drive logical sector size, assuming 512: %d\n", errno);
+	    var = 512;
+    }
+    s->blkcfg.blk_size = var;
+    s->blkcfg.physical_block_exp = 0;
+    s->blkcfg.num_queues = s->num_queues;
+    /* TODO query actual block device */
+    s->blkcfg.size_max = 8192;
+    s->blkcfg.seg_max = 8192 / 512;
+    s->blkcfg.min_io_size = 512;
+    s->blkcfg.opt_io_size = 8192;
+
+out:
+    if (fd > 0)
+	    close(fd);
+    return ret;
+}
+
+static void vhost_blk_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostBlk *s = VHOST_BLK(vdev);
+    int i, ret;
+
+    if (!s->blk) {
+        error_setg(errp, "drive property not set");
+        return;
+    }
+    if (!blk_is_inserted(s->blk)) {
+        error_setg(errp, "Device needs media, but drive is empty");
+        return;
+    }
+
+    if (!s->num_queues || s->num_queues > VIRTIO_QUEUE_MAX) {
+        error_setg(errp, "vhost-blk: invalid number of IO queues");
+        return;
+    }
+
+    if (!s->queue_size) {
+        error_setg(errp, "vhost-blk: queue size must be non-zero");
+        return;
+    }
+
+    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
+                sizeof(struct virtio_blk_config));
+
+    s->dev.max_queues = s->num_queues;
+    s->dev.nvqs = s->num_queues;
+    s->dev.vqs = g_new(struct vhost_virtqueue, s->dev.nvqs);
+    s->dev.vq_index = 0;
+    s->dev.backend_features = 0;
+
+    vhost_dev_set_config_notifier(&s->dev, &vhost_blk_ops);
+
+    for (i = 0; i < s->dev.max_queues; i++) {
+        virtio_add_queue(vdev, s->queue_size,
+                         vhost_blk_handle_output);
+    }
+
+    s->vhostfd = open("/dev/vhost-blk", O_RDWR);
+    if (s->vhostfd < 0) {
+        error_setg_errno(errp, -errno,
+                        "vhost-blk: failed to open vhost device");
+	goto virtio_err;
+    }
+
+    ret = vhost_dev_init(&s->dev, (void *)(uintptr_t)s->vhostfd, VHOST_BACKEND_TYPE_KERNEL, 0);
+    if (ret < 0) {
+        error_setg(errp, "vhost-blk: vhost initialization failed: %s",
+                   strerror(-ret));
+        goto virtio_err;
+    }
+
+    vhost_blk_cfg_init(s);
+    blk_iostatus_enable(s->blk);
+    return;
+
+virtio_err:
+    g_free(s->dev.vqs);
+    virtio_cleanup(vdev);
+    close(s->vhostfd);
+}
+
+static void vhost_blk_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostBlk *s = VHOST_BLK(dev);
+
+    vhost_blk_set_status(vdev, 0);
+    close(s->vhostfd);
+    vhost_dev_cleanup(&s->dev);
+    g_free(s->dev.vqs);
+    virtio_cleanup(vdev);
+}
+
+static void vhost_blk_instance_init(Object *obj)
+{
+    VHostBlk *s = VHOST_BLK(obj);
+
+    device_add_bootindex_property(obj, &s->bootindex, "bootindex",
+                                  "/disk@0,0", DEVICE(obj), NULL);
+}
+
+static const VMStateDescription vmstate_vhost_blk = {
+    .name = "vhost-blk",
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property vhost_blk_properties[] = {
+    DEFINE_PROP_DRIVE("drive", VHostBlk, blk),
+    DEFINE_PROP_UINT16("num-queues", VHostBlk, num_queues, 1),
+    DEFINE_PROP_UINT32("queue-size", VHostBlk, queue_size, 128),
+    DEFINE_PROP_BIT("config-wce", VHostBlk, config_wce, 0, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_blk_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    dc->props = vhost_blk_properties;
+    dc->vmsd = &vmstate_vhost_blk;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    vdc->realize = vhost_blk_device_realize;
+    vdc->unrealize = vhost_blk_device_unrealize;
+    vdc->get_config = vhost_blk_get_config;
+    vdc->set_config = vhost_blk_set_config;
+    vdc->get_features = vhost_blk_get_features;
+    vdc->set_status = vhost_blk_set_status;
+}
+
+static const TypeInfo vhost_blk_info = {
+    .name = TYPE_VHOST_BLK,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VHostBlk),
+    .instance_init = vhost_blk_instance_init,
+    .class_init = vhost_blk_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&vhost_blk_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index a954799267..ec00b54424 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2060,6 +2060,63 @@ static const TypeInfo vhost_user_blk_pci_info = {
 };
 #endif
 
+#ifdef CONFIG_VHOST_BLK
+/* vhost-blk */
+
+static Property vhost_blk_pci_properties[] = {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostBlkPCI *dev = VHOST_BLK_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = dev->vdev.num_queues + 1;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_blk_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props = vhost_blk_pci_properties;
+    k->realize = vhost_blk_pci_realize;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
+}
+
+static void vhost_blk_pci_instance_init(Object *obj)
+{
+    VHostBlkPCI *dev = VHOST_BLK_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_BLK);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const TypeInfo vhost_blk_pci_info = {
+    .name           = TYPE_VHOST_BLK_PCI,
+    .parent         = TYPE_VIRTIO_PCI,
+    .instance_size  = sizeof(VHostBlkPCI),
+    .instance_init  = vhost_blk_pci_instance_init,
+    .class_init     = vhost_blk_pci_class_init,
+};
+#endif
+
 /* virtio-scsi-pci */
 
 static Property virtio_scsi_pci_properties[] = {
@@ -2723,6 +2780,9 @@ static void virtio_pci_register_types(void)
 #ifdef CONFIG_VHOST_VSOCK
     type_register_static(&vhost_vsock_pci_info);
 #endif
+#ifdef CONFIG_VHOST_BLK
+    type_register_static(&vhost_blk_pci_info);
+#endif
 }
 
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 813082b0d7..4cca04a45a 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -31,6 +31,10 @@
 #include "hw/virtio/vhost-user-blk.h"
 #endif
 
+#ifdef CONFIG_VHOST_BLK
+#include "hw/virtio/vhost-blk.h"
+#endif
+
 #ifdef CONFIG_VIRTFS
 #include "hw/9pfs/virtio-9p.h"
 #endif
@@ -50,6 +54,7 @@ typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VHostSCSIPCI VHostSCSIPCI;
 typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
 typedef struct VHostUserBlkPCI VHostUserBlkPCI;
+typedef struct VHostBlkPCI VHostBlkPCI;
 typedef struct VirtIORngPCI VirtIORngPCI;
 typedef struct VirtIOInputPCI VirtIOInputPCI;
 typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
@@ -262,6 +267,20 @@ struct VHostUserBlkPCI {
 };
 #endif
 
+#ifdef CONFIG_VHOST_BLK
+/*
+ * vhost-blk-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VHOST_BLK_PCI "vhost-blk-pci"
+#define VHOST_BLK_PCI(obj) \
+        OBJECT_CHECK(VHostBlkPCI, (obj), TYPE_VHOST_BLK_PCI)
+
+struct VHostBlkPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostBlk vdev;
+};
+#endif
+
 /*
  * virtio-blk-pci: This extends VirtioPCIProxy.
  */
diff --git a/include/hw/virtio/vhost-blk.h b/include/hw/virtio/vhost-blk.h
new file mode 100644
index 0000000000..6dc5d9634a
--- /dev/null
+++ b/include/hw/virtio/vhost-blk.h
@@ -0,0 +1,43 @@
+/*
+ * vhost-blk host device
+ * Copyright(C) 2018 IBM Corporation.
+ *
+ * Authors:
+ *  Vitaly Mayatskikh <v.mayatskih@gmail.com>
+ *
+ * Based on vhost-user-blk.h, Copyright Intel, Corp. 2017
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#ifndef VHOST_BLK_H
+#define VHOST_BLK_H
+
+#include "standard-headers/linux/virtio_blk.h"
+#include "qemu-common.h"
+#include "hw/qdev.h"
+#include "hw/block/block.h"
+#include "hw/virtio/vhost.h"
+#include "sysemu/block-backend.h"
+
+#define TYPE_VHOST_BLK "vhost-blk"
+#define VHOST_BLK(obj) \
+        OBJECT_CHECK(VHostBlk, (obj), TYPE_VHOST_BLK)
+
+typedef struct VHostBlk {
+    VirtIODevice parent_obj;
+    BlockConf conf;
+    BlockBackend *blk;
+    int32_t bootindex;
+    struct virtio_blk_config blkcfg;
+    uint16_t num_queues;
+    uint32_t queue_size;
+    uint32_t config_wce;
+    int vhostfd;
+    int bs_fd;
+    struct vhost_dev dev;
+} VHostBlk;
+
+#endif
-- 
2.17.1
