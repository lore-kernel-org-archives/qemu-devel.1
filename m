Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FBAC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4819C206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4819C206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAG8J-00030Y-95
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iAFuo-0000GD-Vn
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iAFui-0004xc-Jy
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:01:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iAFui-0004xH-BM
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:01:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 851E38553D
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 16:01:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-53.ams2.redhat.com
 [10.36.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BEDF6013A;
 Tue, 17 Sep 2019 16:01:06 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	cohuck@redhat.com,
	mst@redhat.com
Date: Tue, 17 Sep 2019 17:00:56 +0100
Message-Id: <20190917160057.11847-3-dgilbert@redhat.com>
In-Reply-To: <20190917160057.11847-1-dgilbert@redhat.com>
References: <20190917160057.11847-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 17 Sep 2019 16:01:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 2/3] virtio: add vhost-user-fs base device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mszeredi@redhat.com, vgoyal@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The virtio-fs virtio device provides shared file system access using
the FUSE protocol carried over virtio.
The actual file server is implemented in an external vhost-user-fs device
backend process.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 configure                         |  13 ++
 hw/virtio/Makefile.objs           |   1 +
 hw/virtio/vhost-user-fs.c         | 299 ++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user-fs.h |  45 +++++
 4 files changed, 358 insertions(+)
 create mode 100644 hw/virtio/vhost-user-fs.c
 create mode 100644 include/hw/virtio/vhost-user-fs.h

diff --git a/configure b/configure
index 30aad233d1..1bd7b40d49 100755
--- a/configure
+++ b/configure
@@ -382,6 +382,7 @@ vhost_crypto=3D""
 vhost_scsi=3D""
 vhost_vsock=3D""
 vhost_user=3D""
+vhost_user_fs=3D""
 kvm=3D"no"
 hax=3D"no"
 hvf=3D"no"
@@ -1294,6 +1295,10 @@ for opt do
   ;;
   --enable-vhost-vsock) vhost_vsock=3D"yes"
   ;;
+  --disable-vhost-user-fs) vhost_user_fs=3D"no"
+  ;;
+  --enable-vhost-user-fs) vhost_user_fs=3D"yes"
+  ;;
   --disable-opengl) opengl=3D"no"
   ;;
   --enable-opengl) opengl=3D"yes"
@@ -2232,6 +2237,10 @@ test "$vhost_crypto" =3D "" && vhost_crypto=3D$vho=
st_user
 if test "$vhost_crypto" =3D "yes" && test "$vhost_user" =3D "no"; then
   error_exit "--enable-vhost-crypto requires --enable-vhost-user"
 fi
+test "$vhost_user_fs" =3D "" && vhost_user_fs=3D$vhost_user
+if test "$vhost_user_fs" =3D "yes" && test "$vhost_user" =3D "no"; then
+  error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
+fi
=20
 # OR the vhost-kernel and vhost-user values for simplicity
 if test "$vhost_net" =3D ""; then
@@ -6374,6 +6383,7 @@ echo "vhost-crypto support $vhost_crypto"
 echo "vhost-scsi support $vhost_scsi"
 echo "vhost-vsock support $vhost_vsock"
 echo "vhost-user support $vhost_user"
+echo "vhost-user-fs support $vhost_user_fs"
 echo "Trace backends    $trace_backends"
 if have_backend "simple"; then
 echo "Trace output file $trace_file-<pid>"
@@ -6873,6 +6883,9 @@ fi
 if test "$vhost_user" =3D "yes" ; then
   echo "CONFIG_VHOST_USER=3Dy" >> $config_host_mak
 fi
+if test "$vhost_user_fs" =3D "yes" ; then
+  echo "CONFIG_VHOST_USER_FS=3Dy" >> $config_host_mak
+fi
 if test "$blobs" =3D "yes" ; then
   echo "INSTALL_BLOBS=3Dyes" >> $config_host_mak
 fi
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 964ce78607..47ffbf22c4 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -11,6 +11,7 @@ common-obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-pci.o
 common-obj-$(CONFIG_VIRTIO_MMIO) +=3D virtio-mmio.o
 obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon.o
 obj-$(CONFIG_VIRTIO_CRYPTO) +=3D virtio-crypto.o
+obj-$(CONFIG_VHOST_USER_FS) +=3D vhost-user-fs.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) +=3D virti=
o-crypto-pci.o
 obj-$(CONFIG_VIRTIO_PMEM) +=3D virtio-pmem.o
 common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) +=3D =
virtio-pmem-pci.o
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
new file mode 100644
index 0000000000..f0df7f4746
--- /dev/null
+++ b/hw/virtio/vhost-user-fs.c
@@ -0,0 +1,299 @@
+/*
+ * Vhost-user filesystem virtio device
+ *
+ * Copyright 2018-2019 Red Hat, Inc.
+ *
+ * Authors:
+ *  Stefan Hajnoczi <stefanha@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#include "standard-headers/linux/virtio_fs.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-access.h"
+#include "qemu/error-report.h"
+#include "hw/virtio/vhost-user-fs.h"
+#include "monitor/monitor.h"
+
+static void vuf_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
+    struct virtio_fs_config fscfg =3D {};
+
+    memcpy((char *)fscfg.tag, fs->conf.tag,
+           MIN(strlen(fs->conf.tag) + 1, sizeof(fscfg.tag)));
+
+    virtio_stl_p(vdev, &fscfg.num_request_queues, fs->conf.num_request_q=
ueues);
+
+    memcpy(config, &fscfg, sizeof(fscfg));
+}
+
+static void vuf_start(VirtIODevice *vdev)
+{
+    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
+    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+    int i;
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return;
+    }
+
+    ret =3D vhost_dev_enable_notifiers(&fs->vhost_dev, vdev);
+    if (ret < 0) {
+        error_report("Error enabling host notifiers: %d", -ret);
+        return;
+    }
+
+    ret =3D k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, tru=
e);
+    if (ret < 0) {
+        error_report("Error binding guest notifier: %d", -ret);
+        goto err_host_notifiers;
+    }
+
+    fs->vhost_dev.acked_features =3D vdev->guest_features;
+    ret =3D vhost_dev_start(&fs->vhost_dev, vdev);
+    if (ret < 0) {
+        error_report("Error starting vhost: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
+    /*
+     * guest_notifier_mask/pending not used yet, so just unmask
+     * everything here.  virtio-pci will do the right thing by
+     * enabling/disabling irqfd.
+     */
+    for (i =3D 0; i < fs->vhost_dev.nvqs; i++) {
+        vhost_virtqueue_mask(&fs->vhost_dev, vdev, i, false);
+    }
+
+    return;
+
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
+}
+
+static void vuf_stop(VirtIODevice *vdev)
+{
+    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
+    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+
+    if (!k->set_guest_notifiers) {
+        return;
+    }
+
+    vhost_dev_stop(&fs->vhost_dev, vdev);
+
+    ret =3D k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, fal=
se);
+    if (ret < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", ret);
+        return;
+    }
+
+    vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
+}
+
+static void vuf_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
+    bool should_start =3D status & VIRTIO_CONFIG_S_DRIVER_OK;
+
+    if (!vdev->vm_running) {
+        should_start =3D false;
+    }
+
+    if (fs->vhost_dev.started =3D=3D should_start) {
+        return;
+    }
+
+    if (should_start) {
+        vuf_start(vdev);
+    } else {
+        vuf_stop(vdev);
+    }
+}
+
+static uint64_t vuf_get_features(VirtIODevice *vdev,
+                                      uint64_t requested_features,
+                                      Error **errp)
+{
+    /* No feature bits used yet */
+    return requested_features;
+}
+
+static void vuf_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    /*
+     * Not normally called; it's the daemon that handles the queue;
+     * however virtio's cleanup path can call this.
+     */
+}
+
+static void vuf_guest_notifier_mask(VirtIODevice *vdev, int idx,
+                                            bool mask)
+{
+    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
+
+    vhost_virtqueue_mask(&fs->vhost_dev, vdev, idx, mask);
+}
+
+static bool vuf_guest_notifier_pending(VirtIODevice *vdev, int idx)
+{
+    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
+
+    return vhost_virtqueue_pending(&fs->vhost_dev, idx);
+}
+
+static void vuf_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VHostUserFS *fs =3D VHOST_USER_FS(dev);
+    unsigned int i;
+    size_t len;
+    int ret;
+
+    if (!fs->conf.chardev.chr) {
+        error_setg(errp, "missing chardev");
+        return;
+    }
+
+    if (!fs->conf.tag) {
+        error_setg(errp, "missing tag property");
+        return;
+    }
+    len =3D strlen(fs->conf.tag);
+    if (len =3D=3D 0) {
+        error_setg(errp, "tag property cannot be empty");
+        return;
+    }
+    if (len > sizeof_field(struct virtio_fs_config, tag)) {
+        error_setg(errp, "tag property must be %zu bytes or less",
+                   sizeof_field(struct virtio_fs_config, tag));
+        return;
+    }
+
+    if (fs->conf.num_request_queues =3D=3D 0) {
+        error_setg(errp, "num-request-queues property must be larger tha=
n 0");
+        return;
+    }
+
+    if (!is_power_of_2(fs->conf.queue_size)) {
+        error_setg(errp, "queue-size property must be a power of 2");
+        return;
+    }
+
+    if (fs->conf.queue_size > VIRTQUEUE_MAX_SIZE) {
+        error_setg(errp, "queue-size property must be %u or smaller",
+                   VIRTQUEUE_MAX_SIZE);
+        return;
+    }
+
+    if (!vhost_user_init(&fs->vhost_user, &fs->conf.chardev, errp)) {
+        return;
+    }
+
+    virtio_init(vdev, "vhost-user-fs", VIRTIO_ID_FS,
+                sizeof(struct virtio_fs_config));
+
+    /* Hiprio queue */
+    virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
+
+    /* Request queues */
+    for (i =3D 0; i < fs->conf.num_request_queues; i++) {
+        virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
+    }
+
+    /* 1 high prio queue, plus the number configured */
+    fs->vhost_dev.nvqs =3D 1 + fs->conf.num_request_queues;
+    fs->vhost_dev.vqs =3D g_new0(struct vhost_virtqueue, fs->vhost_dev.n=
vqs);
+    ret =3D vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
+                         VHOST_BACKEND_TYPE_USER, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vhost_dev_init failed");
+        goto err_virtio;
+    }
+
+    return;
+
+err_virtio:
+    vhost_user_cleanup(&fs->vhost_user);
+    virtio_cleanup(vdev);
+    g_free(fs->vhost_dev.vqs);
+    return;
+}
+
+static void vuf_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VHostUserFS *fs =3D VHOST_USER_FS(dev);
+
+    /* This will stop vhost backend if appropriate. */
+    vuf_set_status(vdev, 0);
+
+    vhost_dev_cleanup(&fs->vhost_dev);
+
+    vhost_user_cleanup(&fs->vhost_user);
+
+    virtio_cleanup(vdev);
+    g_free(fs->vhost_dev.vqs);
+    fs->vhost_dev.vqs =3D NULL;
+}
+
+static const VMStateDescription vuf_vmstate =3D {
+    .name =3D "vhost-user-fs",
+    .unmigratable =3D 1,
+};
+
+static Property vuf_properties[] =3D {
+    DEFINE_PROP_CHR("chardev", VHostUserFS, conf.chardev),
+    DEFINE_PROP_STRING("tag", VHostUserFS, conf.tag),
+    DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
+                       conf.num_request_queues, 1),
+    DEFINE_PROP_UINT16("queue-size", VHostUserFS, conf.queue_size, 128),
+    DEFINE_PROP_STRING("vhostfd", VHostUserFS, conf.vhostfd),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vuf_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
+
+    dc->props =3D vuf_properties;
+    dc->vmsd =3D &vuf_vmstate;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    vdc->realize =3D vuf_device_realize;
+    vdc->unrealize =3D vuf_device_unrealize;
+    vdc->get_features =3D vuf_get_features;
+    vdc->get_config =3D vuf_get_config;
+    vdc->set_status =3D vuf_set_status;
+    vdc->guest_notifier_mask =3D vuf_guest_notifier_mask;
+    vdc->guest_notifier_pending =3D vuf_guest_notifier_pending;
+}
+
+static const TypeInfo vuf_info =3D {
+    .name =3D TYPE_VHOST_USER_FS,
+    .parent =3D TYPE_VIRTIO_DEVICE,
+    .instance_size =3D sizeof(VHostUserFS),
+    .class_init =3D vuf_class_init,
+};
+
+static void vuf_register_types(void)
+{
+    type_register_static(&vuf_info);
+}
+
+type_init(vuf_register_types)
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-=
user-fs.h
new file mode 100644
index 0000000000..4a9186721a
--- /dev/null
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -0,0 +1,45 @@
+/*
+ * Vhost-user filesystem virtio device
+ *
+ * Copyright 2018-2019 Red Hat, Inc.
+ *
+ * Authors:
+ *  Stefan Hajnoczi <stefanha@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef _QEMU_VHOST_USER_FS_H
+#define _QEMU_VHOST_USER_FS_H
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "chardev/char-fe.h"
+
+#define TYPE_VHOST_USER_FS "x-vhost-user-fs-device"
+#define VHOST_USER_FS(obj) \
+        OBJECT_CHECK(VHostUserFS, (obj), TYPE_VHOST_USER_FS)
+
+typedef struct {
+    CharBackend chardev;
+    char *tag;
+    uint16_t num_request_queues;
+    uint16_t queue_size;
+    char *vhostfd;
+} VHostUserFSConf;
+
+typedef struct {
+    /*< private >*/
+    VirtIODevice parent;
+    VHostUserFSConf conf;
+    struct vhost_virtqueue *vhost_vqs;
+    struct vhost_dev vhost_dev;
+    VhostUserState vhost_user;
+
+    /*< public >*/
+} VHostUserFS;
+
+#endif /* _QEMU_VHOST_USER_FS_H */
--=20
2.21.0


