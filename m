Received: from eggs.gnu.org ([2001:4830:134:3::10]:41363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPZ-0000Oj-4P
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPV-0007nj-OE
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:54:01 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPV-0007n9-DN
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:57 -0400
Received: by mail-wr0-x234.google.com with SMTP id r103so16480304wrb.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:53:00 +0200
Message-Id: <1497523981-38449-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 40/41] vhost-user-scsi: Introduce
 vhost-user-scsi host device
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

This commit introduces a vhost-user device for SCSI. This is based
on the existing vhost-scsi implementation, but done over vhost-user
instead. It also uses a chardev to connect to the backend. Unlike
vhost-scsi (today), VMs using vhost-user-scsi can be live migrated.

To use it, start Qemu with a command line equivalent to:

qemu-system-x86_64 \
       -chardev socket,id=vus0,path=/tmp/vus.sock \
       -device vhost-user-scsi-pci,chardev=vus0,bus=pci.0,addr=...

A separate commit presents a sample application linked with libiscsi to
provide a backend for vhost-user-scsi.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Message-Id: <1488479153-21203-4-git-send-email-felipe@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore                          |   1 +
 default-configs/pci.mak             |   1 +
 default-configs/s390x-softmmu.mak   |   1 +
 hw/scsi/Makefile.objs               |   1 +
 hw/scsi/vhost-scsi-common.c         |   1 -
 hw/scsi/vhost-user-scsi.c           | 205 ++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c              |  58 ++++++++++
 hw/virtio/virtio-pci.h              |  11 ++
 include/hw/virtio/vhost-user-scsi.h |  35 ++++++
 include/hw/virtio/virtio-scsi.h     |   2 +
 10 files changed, 315 insertions(+), 1 deletion(-)
 create mode 100644 hw/scsi/vhost-user-scsi.c
 create mode 100644 include/hw/virtio/vhost-user-scsi.h

diff --git a/.gitignore b/.gitignore
index 11bb1b1..09c2363 100644
--- a/.gitignore
+++ b/.gitignore
@@ -50,6 +50,7 @@
 /qemu-version.h.tmp
 /module_block.h
 /vscclient
+/vhost-user-scsi
 /fsdev/virtfs-proxy-helper
 *.[1-9]
 *.a
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 3bbeb62..53ff109 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -43,3 +43,4 @@ CONFIG_VGA=y
 CONFIG_VGA_PCI=y
 CONFIG_IVSHMEM=$(CONFIG_EVENTFD)
 CONFIG_ROCKER=y
+CONFIG_VHOST_USER_SCSI=$(CONFIG_LINUX)
diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 18aed56..b227a36 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -1,5 +1,6 @@
 CONFIG_PCI=y
 CONFIG_VIRTIO_PCI=y
+CONFIG_VHOST_USER_SCSI=$(CONFIG_LINUX)
 CONFIG_VIRTIO=y
 CONFIG_SCLPCONSOLE=y
 CONFIG_TERMINAL3270=y
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 54d8754..b188f72 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -11,4 +11,5 @@ obj-$(CONFIG_PSERIES) += spapr_vscsi.o
 ifeq ($(CONFIG_VIRTIO),y)
 obj-y += virtio-scsi.o virtio-scsi-dataplane.o
 obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-common.o vhost-scsi.o
+obj-$(CONFIG_VHOST_USER_SCSI) += vhost-scsi-common.o vhost-user-scsi.o
 endif
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index e41c031..d434b3e 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -16,7 +16,6 @@
  */
 
 #include "qemu/osdep.h"
-#include <linux/vhost.h>
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "migration/migration.h"
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
new file mode 100644
index 0000000..500fa6a
--- /dev/null
+++ b/hw/scsi/vhost-user-scsi.c
@@ -0,0 +1,205 @@
+/*
+ * vhost-user-scsi host device
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
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/typedefs.h"
+#include "qom/object.h"
+#include "hw/fw-path-provider.h"
+#include "hw/qdev-core.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-backend.h"
+#include "hw/virtio/vhost-user-scsi.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-access.h"
+#include "chardev/char-fe.h"
+
+/* Features supported by the host application */
+static const int user_feature_bits[] = {
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+    VIRTIO_SCSI_F_HOTPLUG,
+    VHOST_INVALID_FEATURE_BIT
+};
+
+static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VHostUserSCSI *s = (VHostUserSCSI *)vdev;
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    bool start = (status & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->vm_running;
+
+    if (vsc->dev.started == start) {
+        return;
+    }
+
+    if (start) {
+        int ret;
+
+        ret = vhost_scsi_common_start(vsc);
+        if (ret < 0) {
+            error_report("unable to start vhost-user-scsi: %s", strerror(-ret));
+            exit(1);
+        }
+    } else {
+        vhost_scsi_common_stop(vsc);
+    }
+}
+
+static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+}
+
+static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
+{
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
+    VHostUserSCSI *s = VHOST_USER_SCSI(dev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    Error *err = NULL;
+    int ret;
+
+    if (!vs->conf.chardev.chr) {
+        error_setg(errp, "vhost-user-scsi: missing chardev");
+        return;
+    }
+
+    virtio_scsi_common_realize(dev, vhost_dummy_handle_output,
+                               vhost_dummy_handle_output,
+                               vhost_dummy_handle_output, &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    vsc->dev.nvqs = 2 + vs->conf.num_queues;
+    vsc->dev.vqs = g_new(struct vhost_virtqueue, vsc->dev.nvqs);
+    vsc->dev.vq_index = 0;
+    vsc->dev.backend_features = 0;
+
+    ret = vhost_dev_init(&vsc->dev, (void *)&vs->conf.chardev,
+                         VHOST_BACKEND_TYPE_USER, 0);
+    if (ret < 0) {
+        error_setg(errp, "vhost-user-scsi: vhost initialization failed: %s",
+                   strerror(-ret));
+        return;
+    }
+
+    /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
+    vsc->channel = 0;
+    vsc->lun = 0;
+    vsc->target = vs->conf.boot_tpgt;
+}
+
+static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserSCSI *s = VHOST_USER_SCSI(dev);
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+
+    /* This will stop the vhost backend. */
+    vhost_user_scsi_set_status(vdev, 0);
+
+    vhost_dev_cleanup(&vsc->dev);
+    g_free(vsc->dev.vqs);
+
+    virtio_scsi_common_unrealize(dev, errp);
+}
+
+static uint64_t vhost_user_scsi_get_features(VirtIODevice *vdev,
+                                             uint64_t features, Error **errp)
+{
+    VHostUserSCSI *s = VHOST_USER_SCSI(vdev);
+
+    /* Turn on predefined features supported by this device */
+    features |= s->host_features;
+
+    return vhost_scsi_common_get_features(vdev, features, errp);
+}
+
+static Property vhost_user_scsi_properties[] = {
+    DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
+    DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
+    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
+    DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
+                       0xFFFF),
+    DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
+    DEFINE_PROP_BIT64("hotplug", VHostUserSCSI, host_features,
+                                                VIRTIO_SCSI_F_HOTPLUG,
+                                                true),
+    DEFINE_PROP_BIT64("param_change", VHostUserSCSI, host_features,
+                                                     VIRTIO_SCSI_F_CHANGE,
+                                                     true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vmstate_vhost_scsi = {
+    .name = "virtio-scsi",
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(klass);
+
+    dc->props = vhost_user_scsi_properties;
+    dc->vmsd = &vmstate_vhost_scsi;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    vdc->realize = vhost_user_scsi_realize;
+    vdc->unrealize = vhost_user_scsi_unrealize;
+    vdc->get_features = vhost_user_scsi_get_features;
+    vdc->set_config = vhost_scsi_common_set_config;
+    vdc->set_status = vhost_user_scsi_set_status;
+    fwc->get_dev_path = vhost_scsi_common_get_fw_dev_path;
+}
+
+static void vhost_user_scsi_instance_init(Object *obj)
+{
+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(obj);
+
+    vsc->feature_bits = user_feature_bits;
+
+    /* Add the bootindex property for this object */
+    device_add_bootindex_property(obj, &vsc->bootindex, "bootindex", NULL,
+                                  DEVICE(vsc), NULL);
+}
+
+static const TypeInfo vhost_user_scsi_info = {
+    .name = TYPE_VHOST_USER_SCSI,
+    .parent = TYPE_VHOST_SCSI_COMMON,
+    .instance_size = sizeof(VHostUserSCSI),
+    .class_init = vhost_user_scsi_class_init,
+    .instance_init = vhost_user_scsi_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_FW_PATH_PROVIDER },
+        { }
+    },
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&vhost_user_scsi_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index f9b7244..20d6a08 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2135,6 +2135,61 @@ static const TypeInfo vhost_scsi_pci_info = {
 };
 #endif
 
+#ifdef CONFIG_LINUX
+/* vhost-user-scsi-pci */
+static Property vhost_user_scsi_pci_properties[] = {
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserSCSIPCI *dev = VHOST_USER_SCSI_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = vs->conf.num_queues + 3;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_user_scsi_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_scsi_pci_realize;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props = vhost_user_scsi_pci_properties;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SCSI;
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
+}
+
+static void vhost_user_scsi_pci_instance_init(Object *obj)
+{
+    VHostUserSCSIPCI *dev = VHOST_USER_SCSI_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_SCSI);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const TypeInfo vhost_user_scsi_pci_info = {
+    .name          = TYPE_VHOST_USER_SCSI_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VHostUserSCSIPCI),
+    .instance_init = vhost_user_scsi_pci_instance_init,
+    .class_init    = vhost_user_scsi_pci_class_init,
+};
+#endif
+
 /* vhost-vsock-pci */
 
 #ifdef CONFIG_VHOST_VSOCK
@@ -2612,6 +2667,9 @@ static void virtio_pci_register_types(void)
 #ifdef CONFIG_VHOST_SCSI
     type_register_static(&vhost_scsi_pci_info);
 #endif
+#ifdef CONFIG_LINUX
+    type_register_static(&vhost_user_scsi_pci_info);
+#endif
 #ifdef CONFIG_VHOST_VSOCK
     type_register_static(&vhost_vsock_pci_info);
 #endif
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index b095dfc..69f5959 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -26,6 +26,7 @@
 #include "hw/virtio/virtio-input.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
+#include "hw/virtio/vhost-user-scsi.h"
 
 #ifdef CONFIG_VIRTFS
 #include "hw/9pfs/virtio-9p.h"
@@ -44,6 +45,7 @@ typedef struct VirtIOBalloonPCI VirtIOBalloonPCI;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VHostSCSIPCI VHostSCSIPCI;
+typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
 typedef struct VirtIORngPCI VirtIORngPCI;
 typedef struct VirtIOInputPCI VirtIOInputPCI;
 typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
@@ -230,6 +232,15 @@ struct VHostSCSIPCI {
 };
 #endif
 
+#define TYPE_VHOST_USER_SCSI_PCI "vhost-user-scsi-pci"
+#define VHOST_USER_SCSI_PCI(obj) \
+        OBJECT_CHECK(VHostUserSCSIPCI, (obj), TYPE_VHOST_USER_SCSI_PCI)
+
+struct VHostUserSCSIPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserSCSI vdev;
+};
+
 /*
  * virtio-blk-pci: This extends VirtioPCIProxy.
  */
diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhost-user-scsi.h
new file mode 100644
index 0000000..01861f7
--- /dev/null
+++ b/include/hw/virtio/vhost-user-scsi.h
@@ -0,0 +1,35 @@
+/*
+ * vhost-user-scsi host device
+ *
+ * Copyright (c) 2016 Nutanix Inc. All rights reserved.
+ *
+ * Author:
+ *  Felipe Franciosi <felipe@nutanix.com>
+ *
+ * This file is largely based on "vhost-scsi.h" by:
+ *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#ifndef VHOST_USER_SCSI_H
+#define VHOST_USER_SCSI_H
+
+#include "qemu-common.h"
+#include "hw/qdev.h"
+#include "hw/virtio/virtio-scsi.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-scsi-common.h"
+
+#define TYPE_VHOST_USER_SCSI "vhost-user-scsi"
+#define VHOST_USER_SCSI(obj) \
+        OBJECT_CHECK(VHostUserSCSI, (obj), TYPE_VHOST_USER_SCSI)
+
+typedef struct VHostUserSCSI {
+    VHostSCSICommon parent_obj;
+    uint64_t host_features;
+} VHostUserSCSI;
+
+#endif /* VHOST_USER_SCSI_H */
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index eac2013..de6ae5a 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -21,6 +21,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/pci/pci.h"
 #include "hw/scsi/scsi.h"
+#include "chardev/char-fe.h"
 #include "sysemu/iothread.h"
 
 #define TYPE_VIRTIO_SCSI_COMMON "virtio-scsi-common"
@@ -53,6 +54,7 @@ struct VirtIOSCSIConf {
     char *vhostfd;
     char *wwpn;
 #endif
+    CharBackend chardev;
     uint32_t boot_tpgt;
     IOThread *iothread;
 };
-- 
1.8.3.1
