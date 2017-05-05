Received: from eggs.gnu.org ([2001:4830:134:3::10]:47247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFU-0002ZE-LJ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFS-0006k9-7F
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFR-0006il-Sr
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:06 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:37 +0200
Message-Id: <20170505101337.4650-22-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/21] vhost-scsi: create a vhost-scsi-common
 abstraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>

From: Felipe Franciosi <felipe@nutanix.com>

In order to introduce a new vhost-user-scsi host device type, it makes
sense to abstract part of vhost-scsi into a common parent class. This
commit does exactly that.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Message-Id: <1488479153-21203-3-git-send-email-felipe@nutanix.com>
---
 hw/scsi/Makefile.objs                 |   2 +-
 hw/scsi/vhost-scsi-common.c           | 143 +++++++++++++++++++++++++
 hw/scsi/vhost-scsi.c                  | 194 ++++++++++------------------------
 include/hw/virtio/vhost-scsi-common.h |  48 +++++++++
 include/hw/virtio/vhost-scsi.h        |  11 +-
 include/hw/virtio/virtio-scsi.h       |   2 +
 6 files changed, 252 insertions(+), 148 deletions(-)
 create mode 100644 hw/scsi/vhost-scsi-common.c
 create mode 100644 include/hw/virtio/vhost-scsi-common.h

diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 5a2248be36..54d8754e9a 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -10,5 +10,5 @@ obj-$(CONFIG_PSERIES) += spapr_vscsi.o
 
 ifeq ($(CONFIG_VIRTIO),y)
 obj-y += virtio-scsi.o virtio-scsi-dataplane.o
-obj-$(CONFIG_VHOST_SCSI) += vhost-scsi.o
+obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-common.o vhost-scsi.o
 endif
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
new file mode 100644
index 0000000000..e41c0314db
--- /dev/null
+++ b/hw/scsi/vhost-scsi-common.c
@@ -0,0 +1,143 @@
+/*
+ * vhost-scsi-common
+ *
+ * Copyright (c) 2016 Nutanix Inc. All rights reserved.
+ *
+ * Author:
+ *  Felipe Franciosi <felipe@nutanix.com>
+ *
+ * This work is largely based on the "vhost-scsi" implementation by:
+ *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
+ *  Nicholas Bellinger <nab@risingtidesystems.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include <linux/vhost.h>
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "migration/migration.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-scsi-common.h"
+#include "hw/virtio/virtio-scsi.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-access.h"
+#include "hw/fw-path-provider.h"
+
+int vhost_scsi_common_start(VHostSCSICommon *vsc)
+{
+    int ret, i;
+    VirtIODevice *vdev = VIRTIO_DEVICE(vsc);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return -ENOSYS;
+    }
+
+    ret = vhost_dev_enable_notifiers(&vsc->dev, vdev);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier");
+        goto err_host_notifiers;
+    }
+
+    vsc->dev.acked_features = vdev->guest_features;
+    ret = vhost_dev_start(&vsc->dev, vdev);
+    if (ret < 0) {
+        error_report("Error start vhost dev");
+        goto err_guest_notifiers;
+    }
+
+    /* guest_notifier_mask/pending not used yet, so just unmask
+     * everything here.  virtio-pci will do the right thing by
+     * enabling/disabling irqfd.
+     */
+    for (i = 0; i < vsc->dev.nvqs; i++) {
+        vhost_virtqueue_mask(&vsc->dev, vdev, vsc->dev.vq_index + i, false);
+    }
+
+    return ret;
+
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(&vsc->dev, vdev);
+    return ret;
+}
+
+void vhost_scsi_common_stop(VHostSCSICommon *vsc)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(vsc);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret = 0;
+
+    vhost_dev_stop(&vsc->dev, vdev);
+
+    if (k->set_guest_notifiers) {
+        ret = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
+        if (ret < 0) {
+                error_report("vhost guest notifier cleanup failed: %d", ret);
+        }
+    }
+    assert(ret >= 0);
+
+    vhost_dev_disable_notifiers(&vsc->dev, vdev);
+}
+
+uint64_t vhost_scsi_common_get_features(VirtIODevice *vdev, uint64_t features,
+                                        Error **errp)
+{
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(vdev);
+
+    return vhost_get_features(&vsc->dev, vsc->feature_bits, features);
+}
+
+void vhost_scsi_common_set_config(VirtIODevice *vdev, const uint8_t *config)
+{
+    VirtIOSCSIConfig *scsiconf = (VirtIOSCSIConfig *)config;
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
+
+    if ((uint32_t)virtio_ldl_p(vdev, &scsiconf->sense_size) != vs->sense_size ||
+        (uint32_t)virtio_ldl_p(vdev, &scsiconf->cdb_size) != vs->cdb_size) {
+        error_report("vhost-scsi does not support changing the sense data and "
+                     "CDB sizes");
+        exit(1);
+    }
+}
+
+/*
+ * Implementation of an interface to adjust firmware path
+ * for the bootindex property handling.
+ */
+char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState *bus,
+                                        DeviceState *dev)
+{
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(dev);
+    /* format: /channel@channel/vhost-scsi@target,lun */
+    return g_strdup_printf("/channel@%x/%s@%x,%x", vsc->channel,
+                           qdev_fw_name(dev), vsc->target, vsc->lun);
+}
+
+static const TypeInfo vhost_scsi_common_info = {
+    .name = TYPE_VHOST_SCSI_COMMON,
+    .parent = TYPE_VIRTIO_SCSI_COMMON,
+    .instance_size = sizeof(VHostSCSICommon),
+    .abstract = true,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&vhost_scsi_common_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index f53bc179da..8f53ac3795 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -42,13 +42,14 @@ static const int kernel_feature_bits[] = {
 static int vhost_scsi_set_endpoint(VHostSCSI *s)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
-    const VhostOps *vhost_ops = s->dev.vhost_ops;
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    const VhostOps *vhost_ops = vsc->dev.vhost_ops;
     struct vhost_scsi_target backend;
     int ret;
 
     memset(&backend, 0, sizeof(backend));
     pstrcpy(backend.vhost_wwpn, sizeof(backend.vhost_wwpn), vs->conf.wwpn);
-    ret = vhost_ops->vhost_scsi_set_endpoint(&s->dev, &backend);
+    ret = vhost_ops->vhost_scsi_set_endpoint(&vsc->dev, &backend);
     if (ret < 0) {
         return -errno;
     }
@@ -58,130 +59,62 @@ static int vhost_scsi_set_endpoint(VHostSCSI *s)
 static void vhost_scsi_clear_endpoint(VHostSCSI *s)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
     struct vhost_scsi_target backend;
-    const VhostOps *vhost_ops = s->dev.vhost_ops;
+    const VhostOps *vhost_ops = vsc->dev.vhost_ops;
 
     memset(&backend, 0, sizeof(backend));
     pstrcpy(backend.vhost_wwpn, sizeof(backend.vhost_wwpn), vs->conf.wwpn);
-    vhost_ops->vhost_scsi_clear_endpoint(&s->dev, &backend);
+    vhost_ops->vhost_scsi_clear_endpoint(&vsc->dev, &backend);
 }
 
 static int vhost_scsi_start(VHostSCSI *s)
 {
-    int ret, abi_version, i;
-    VirtIODevice *vdev = VIRTIO_DEVICE(s);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    const VhostOps *vhost_ops = s->dev.vhost_ops;
-
-    if (!k->set_guest_notifiers) {
-        error_report("binding does not support guest notifiers");
-        return -ENOSYS;
-    }
+    int ret, abi_version;
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    const VhostOps *vhost_ops = vsc->dev.vhost_ops;
 
-    ret = vhost_ops->vhost_scsi_get_abi_version(&s->dev, &abi_version);
+    ret = vhost_ops->vhost_scsi_get_abi_version(&vsc->dev, &abi_version);
     if (ret < 0) {
         return -errno;
     }
     if (abi_version > VHOST_SCSI_ABI_VERSION) {
         error_report("vhost-scsi: The running tcm_vhost kernel abi_version:"
-                     " %d is greater than vhost_scsi userspace supports: %d, please"
-                     " upgrade your version of QEMU", abi_version,
+                     " %d is greater than vhost_scsi userspace supports: %d,"
+                     " please upgrade your version of QEMU", abi_version,
                      VHOST_SCSI_ABI_VERSION);
         return -ENOSYS;
     }
 
-    ret = vhost_dev_enable_notifiers(&s->dev, vdev);
+    ret = vhost_scsi_common_start(vsc);
     if (ret < 0) {
         return ret;
     }
 
-    s->dev.acked_features = vdev->guest_features;
-    ret = vhost_dev_start(&s->dev, vdev);
-    if (ret < 0) {
-        error_report("Error start vhost dev");
-        goto err_notifiers;
-    }
-
     ret = vhost_scsi_set_endpoint(s);
     if (ret < 0) {
-        error_report("Error set vhost-scsi endpoint");
-        goto err_vhost_stop;
-    }
-
-    ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, true);
-    if (ret < 0) {
-        error_report("Error binding guest notifier");
-        goto err_endpoint;
-    }
-
-    /* guest_notifier_mask/pending not used yet, so just unmask
-     * everything here.  virtio-pci will do the right thing by
-     * enabling/disabling irqfd.
-     */
-    for (i = 0; i < s->dev.nvqs; i++) {
-        vhost_virtqueue_mask(&s->dev, vdev, s->dev.vq_index + i, false);
+        error_report("Error setting vhost-scsi endpoint");
+        vhost_scsi_common_stop(vsc);
     }
 
     return ret;
-
-err_endpoint:
-    vhost_scsi_clear_endpoint(s);
-err_vhost_stop:
-    vhost_dev_stop(&s->dev, vdev);
-err_notifiers:
-    vhost_dev_disable_notifiers(&s->dev, vdev);
-    return ret;
 }
 
 static void vhost_scsi_stop(VHostSCSI *s)
 {
-    VirtIODevice *vdev = VIRTIO_DEVICE(s);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret = 0;
-
-    if (k->set_guest_notifiers) {
-        ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
-        if (ret < 0) {
-                error_report("vhost guest notifier cleanup failed: %d", ret);
-        }
-    }
-    assert(ret >= 0);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
 
     vhost_scsi_clear_endpoint(s);
-    vhost_dev_stop(&s->dev, vdev);
-    vhost_dev_disable_notifiers(&s->dev, vdev);
-}
-
-static uint64_t vhost_scsi_get_features(VirtIODevice *vdev,
-                                        uint64_t features,
-                                        Error **errp)
-{
-    VHostSCSI *s = VHOST_SCSI(vdev);
-
-    return vhost_get_features(&s->dev, kernel_feature_bits, features);
-}
-
-static void vhost_scsi_set_config(VirtIODevice *vdev,
-                                  const uint8_t *config)
-{
-    VirtIOSCSIConfig *scsiconf = (VirtIOSCSIConfig *)config;
-    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
-
-    if ((uint32_t) virtio_ldl_p(vdev, &scsiconf->sense_size) != vs->sense_size ||
-        (uint32_t) virtio_ldl_p(vdev, &scsiconf->cdb_size) != vs->cdb_size) {
-        error_report("vhost-scsi does not support changing the sense data and CDB sizes");
-        exit(1);
-    }
+    vhost_scsi_common_stop(vsc);
 }
 
 static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
 {
-    VHostSCSI *s = (VHostSCSI *)vdev;
+    VHostSCSI *s = VHOST_SCSI(vdev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
     bool start = (val & VIRTIO_CONFIG_S_DRIVER_OK);
 
-    if (s->dev.started == start) {
+    if (vsc->dev.started == start) {
         return;
     }
 
@@ -190,10 +123,7 @@ static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
 
         ret = vhost_scsi_start(s);
         if (ret < 0) {
-            error_report("virtio-scsi: unable to start vhost: %s",
-                         strerror(-ret));
-
-            /* There is no userspace virtio-scsi fallback so exit */
+            error_report("unable to start vhost-scsi: %s", strerror(-ret));
             exit(1);
         }
     } else {
@@ -208,7 +138,7 @@ static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 static void vhost_scsi_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
-    VHostSCSI *s = VHOST_SCSI(dev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(dev);
     Error *err = NULL;
     int vhostfd = -1;
     int ret;
@@ -243,21 +173,21 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         goto close_fd;
     }
 
-    error_setg(&s->migration_blocker,
+    error_setg(&vsc->migration_blocker,
                "vhost-scsi does not support migration");
-    migrate_add_blocker(s->migration_blocker, &err);
+    migrate_add_blocker(vsc->migration_blocker, &err);
     if (err) {
         error_propagate(errp, err);
-        error_free(s->migration_blocker);
+        error_free(vsc->migration_blocker);
         goto close_fd;
     }
 
-    s->dev.nvqs = VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
-    s->dev.vqs = g_new(struct vhost_virtqueue, s->dev.nvqs);
-    s->dev.vq_index = 0;
-    s->dev.backend_features = 0;
+    vsc->dev.nvqs = VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
+    vsc->dev.vqs = g_new(struct vhost_virtqueue, vsc->dev.nvqs);
+    vsc->dev.vq_index = 0;
+    vsc->dev.backend_features = 0;
 
-    ret = vhost_dev_init(&s->dev, (void *)(uintptr_t)vhostfd,
+    ret = vhost_dev_init(&vsc->dev, (void *)(uintptr_t)vhostfd,
                          VHOST_BACKEND_TYPE_KERNEL, 0);
     if (ret < 0) {
         error_setg(errp, "vhost-scsi: vhost initialization failed: %s",
@@ -266,16 +196,16 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     }
 
     /* At present, channel and lun both are 0 for bootable vhost-scsi disk */
-    s->channel = 0;
-    s->lun = 0;
+    vsc->channel = 0;
+    vsc->lun = 0;
     /* Note: we can also get the minimum tpgt from kernel */
-    s->target = vs->conf.boot_tpgt;
+    vsc->target = vs->conf.boot_tpgt;
 
     return;
 
  free_vqs:
-    migrate_del_blocker(s->migration_blocker);
-    g_free(s->dev.vqs);
+    migrate_del_blocker(vsc->migration_blocker);
+    g_free(vsc->dev.vqs);
  close_fd:
     close(vhostfd);
     return;
@@ -284,42 +214,28 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
 static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostSCSI *s = VHOST_SCSI(dev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(dev);
 
-    migrate_del_blocker(s->migration_blocker);
-    error_free(s->migration_blocker);
+    migrate_del_blocker(vsc->migration_blocker);
+    error_free(vsc->migration_blocker);
 
     /* This will stop vhost backend. */
     vhost_scsi_set_status(vdev, 0);
 
-    vhost_dev_cleanup(&s->dev);
-    g_free(s->dev.vqs);
+    vhost_dev_cleanup(&vsc->dev);
+    g_free(vsc->dev.vqs);
 
     virtio_scsi_common_unrealize(dev, errp);
 }
 
-/*
- * Implementation of an interface to adjust firmware path
- * for the bootindex property handling.
- */
-static char *vhost_scsi_get_fw_dev_path(FWPathProvider *p, BusState *bus,
-                                        DeviceState *dev)
-{
-    VHostSCSI *s = VHOST_SCSI(dev);
-    /* format: channel@channel/vhost-scsi@target,lun */
-    return g_strdup_printf("/channel@%x/%s@%x,%x", s->channel,
-                           qdev_fw_name(dev), s->target, s->lun);
-}
-
 static Property vhost_scsi_properties[] = {
-    DEFINE_PROP_STRING("vhostfd", VHostSCSI, parent_obj.conf.vhostfd),
-    DEFINE_PROP_STRING("wwpn", VHostSCSI, parent_obj.conf.wwpn),
-    DEFINE_PROP_UINT32("boot_tpgt", VHostSCSI, parent_obj.conf.boot_tpgt, 0),
-    DEFINE_PROP_UINT32("num_queues", VHostSCSI, parent_obj.conf.num_queues, 1),
-    DEFINE_PROP_UINT32("max_sectors", VHostSCSI, parent_obj.conf.max_sectors,
-                                                 0xFFFF),
-    DEFINE_PROP_UINT32("cmd_per_lun", VHostSCSI, parent_obj.conf.cmd_per_lun,
-                                                 128),
+    DEFINE_PROP_STRING("vhostfd", VirtIOSCSICommon, conf.vhostfd),
+    DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
+    DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
+    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
+    DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
+                       0xFFFF),
+    DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -333,23 +249,25 @@ static void vhost_scsi_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = vhost_scsi_realize;
     vdc->unrealize = vhost_scsi_unrealize;
-    vdc->get_features = vhost_scsi_get_features;
-    vdc->set_config = vhost_scsi_set_config;
+    vdc->get_features = vhost_scsi_common_get_features;
+    vdc->set_config = vhost_scsi_common_set_config;
     vdc->set_status = vhost_scsi_set_status;
-    fwc->get_dev_path = vhost_scsi_get_fw_dev_path;
+    fwc->get_dev_path = vhost_scsi_common_get_fw_dev_path;
 }
 
 static void vhost_scsi_instance_init(Object *obj)
 {
-    VHostSCSI *dev = VHOST_SCSI(obj);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(obj);
+
+    vsc->feature_bits = kernel_feature_bits;
 
-    device_add_bootindex_property(obj, &dev->bootindex, "bootindex", NULL,
-                                  DEVICE(dev), NULL);
+    device_add_bootindex_property(obj, &vsc->bootindex, "bootindex", NULL,
+                                  DEVICE(vsc), NULL);
 }
 
 static const TypeInfo vhost_scsi_info = {
     .name = TYPE_VHOST_SCSI,
-    .parent = TYPE_VIRTIO_SCSI_COMMON,
+    .parent = TYPE_VHOST_SCSI_COMMON,
     .instance_size = sizeof(VHostSCSI),
     .class_init = vhost_scsi_class_init,
     .instance_init = vhost_scsi_instance_init,
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
new file mode 100644
index 0000000000..4553be4bc3
--- /dev/null
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -0,0 +1,48 @@
+/*
+ * vhost_scsi host device
+ *
+ * Copyright (c) 2016 Nutanix Inc. All rights reserved.
+ *
+ * Author:
+ *  Felipe Franciosi <felipe@nutanix.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#ifndef VHOST_SCSI_COMMON_H
+#define VHOST_SCSI_COMMON_H
+
+#include "qemu-common.h"
+#include "hw/qdev.h"
+#include "hw/virtio/virtio-scsi.h"
+#include "hw/virtio/vhost.h"
+#include "hw/fw-path-provider.h"
+
+#define TYPE_VHOST_SCSI_COMMON "vhost-scsi-common"
+#define VHOST_SCSI_COMMON(obj) \
+        OBJECT_CHECK(VHostSCSICommon, (obj), TYPE_VHOST_SCSI_COMMON)
+
+typedef struct VHostSCSICommon {
+    VirtIOSCSICommon parent_obj;
+
+    Error *migration_blocker;
+
+    struct vhost_dev dev;
+    const int *feature_bits;
+    int32_t bootindex;
+    int channel;
+    int target;
+    int lun;
+} VHostSCSICommon;
+
+int vhost_scsi_common_start(VHostSCSICommon *vsc);
+void vhost_scsi_common_stop(VHostSCSICommon *vsc);
+char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState *bus,
+                                        DeviceState *dev);
+void vhost_scsi_common_set_config(VirtIODevice *vdev, const uint8_t *config);
+uint64_t vhost_scsi_common_get_features(VirtIODevice *vdev, uint64_t features,
+                                        Error **errp);
+
+#endif /* VHOST_SCSI_COMMON_H */
diff --git a/include/hw/virtio/vhost-scsi.h b/include/hw/virtio/vhost-scsi.h
index 9fd63df12e..04658d14f5 100644
--- a/include/hw/virtio/vhost-scsi.h
+++ b/include/hw/virtio/vhost-scsi.h
@@ -18,6 +18,7 @@
 #include "hw/qdev.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-scsi-common.h"
 
 enum vhost_scsi_vq_list {
     VHOST_SCSI_VQ_CONTROL = 0,
@@ -30,15 +31,7 @@ enum vhost_scsi_vq_list {
         OBJECT_CHECK(VHostSCSI, (obj), TYPE_VHOST_SCSI)
 
 typedef struct VHostSCSI {
-    VirtIOSCSICommon parent_obj;
-
-    Error *migration_blocker;
-
-    struct vhost_dev dev;
-    int32_t bootindex;
-    int channel;
-    int target;
-    int lun;
+    VHostSCSICommon parent_obj;
 } VHostSCSI;
 
 #endif
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 8c8453cf19..eac2013ddd 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -49,8 +49,10 @@ struct VirtIOSCSIConf {
     uint32_t num_queues;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
+#ifdef CONFIG_VHOST_SCSI
     char *vhostfd;
     char *wwpn;
+#endif
     uint32_t boot_tpgt;
     IOThread *iothread;
 };
-- 
2.12.2
