Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B55C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 12:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E29206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 12:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8vRgkAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E29206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc6mj-00042q-Ib
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 08:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jc6k8-0000sq-7g
 for qemu-devel@nongnu.org; Fri, 22 May 2020 08:25:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jc6k6-0002aq-0k
 for qemu-devel@nongnu.org; Fri, 22 May 2020 08:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590150336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6e8OXdUU5+lXNeyP0eOXDoQgPxdHZnUQVSroCOU+YMg=;
 b=B8vRgkAZJAyFj/q/G9du/lc1adG5H9fIxNGMfUo0xP19Bsp7DbA4OyWfPb1b17O8ry9p6C
 b6K+eu3aROCKze8ojjD5Dru1PjzqCyRCBdNTN8QDyk/4Ns5WLH+b8LqyTWhvsm77VW6ExU
 dXFK+r4ijZ08V54taivNf+AMleS7gu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-5waOI2MjNWSCqd6XGPAuYg-1; Fri, 22 May 2020 08:25:34 -0400
X-MC-Unique: 5waOI2MjNWSCqd6XGPAuYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82B7B835B40;
 Fri, 22 May 2020 12:25:33 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-19.ams2.redhat.com
 [10.36.114.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 450A660CC0;
 Fri, 22 May 2020 12:25:27 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] vhost-vsock: add vhost-vsock-common abstraction
Date: Fri, 22 May 2020 14:25:10 +0200
Message-Id: <20200522122512.87413-2-sgarzare@redhat.com>
In-Reply-To: <20200522122512.87413-1-sgarzare@redhat.com>
References: <20200522122512.87413-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:24:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Julio Montes <julio.montes@intel.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch prepares the introduction of vhost-user-vsock, moving
the common code usable for both vhost-vsock and vhost-user-vsock
devices, in the new vhost-vsock-common parent class.

While moving the code, fixed checkpatch warnings about block comments.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/hw/virtio/vhost-vsock-common.h |  47 ++++
 include/hw/virtio/vhost-vsock.h        |  11 +-
 hw/virtio/vhost-vsock-common.c         | 258 ++++++++++++++++++++++
 hw/virtio/vhost-vsock.c                | 283 ++++---------------------
 hw/virtio/Makefile.objs                |   2 +-
 5 files changed, 350 insertions(+), 251 deletions(-)
 create mode 100644 include/hw/virtio/vhost-vsock-common.h
 create mode 100644 hw/virtio/vhost-vsock-common.c

diff --git a/include/hw/virtio/vhost-vsock-common.h b/include/hw/virtio/vhost-vsock-common.h
new file mode 100644
index 0000000000..f8b4aaae00
--- /dev/null
+++ b/include/hw/virtio/vhost-vsock-common.h
@@ -0,0 +1,47 @@
+/*
+ * Parent class for vhost-vsock devices
+ *
+ * Copyright 2015-2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef _QEMU_VHOST_VSOCK_COMMON_H
+#define _QEMU_VHOST_VSOCK_COMMON_H
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost.h"
+
+#define TYPE_VHOST_VSOCK_COMMON "vhost-vsock-common"
+#define VHOST_VSOCK_COMMON(obj) \
+        OBJECT_CHECK(VHostVSockCommon, (obj), TYPE_VHOST_VSOCK_COMMON)
+
+enum {
+    VHOST_VSOCK_SAVEVM_VERSION = 0,
+
+    VHOST_VSOCK_QUEUE_SIZE = 128,
+};
+
+typedef struct {
+    VirtIODevice parent;
+
+    struct vhost_virtqueue vhost_vqs[2];
+    struct vhost_dev vhost_dev;
+
+    VirtQueue *event_vq;
+    VirtQueue *recv_vq;
+    VirtQueue *trans_vq;
+
+    QEMUTimer *post_load_timer;
+} VHostVSockCommon;
+
+int vhost_vsock_common_start(VirtIODevice *vdev);
+void vhost_vsock_common_stop(VirtIODevice *vdev);
+int vhost_vsock_common_pre_save(void *opaque);
+int vhost_vsock_common_post_load(void *opaque, int version_id);
+void vhost_vsock_common_realize(VirtIODevice *vdev, const char *name);
+void vhost_vsock_common_unrealize(VirtIODevice *vdev);
+
+#endif /* _QEMU_VHOST_VSOCK_COMMON_H */
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index bc5a988ee5..8cbb7b90f9 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -14,8 +14,7 @@
 #ifndef QEMU_VHOST_VSOCK_H
 #define QEMU_VHOST_VSOCK_H
 
-#include "hw/virtio/virtio.h"
-#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-vsock-common.h"
 
 #define TYPE_VHOST_VSOCK "vhost-vsock-device"
 #define VHOST_VSOCK(obj) \
@@ -28,14 +27,8 @@ typedef struct {
 
 typedef struct {
     /*< private >*/
-    VirtIODevice parent;
+    VHostVSockCommon parent;
     VHostVSockConf conf;
-    struct vhost_virtqueue vhost_vqs[2];
-    struct vhost_dev vhost_dev;
-    VirtQueue *event_vq;
-    VirtQueue *recv_vq;
-    VirtQueue *trans_vq;
-    QEMUTimer *post_load_timer;
 
     /*< public >*/
 } VHostVSock;
diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
new file mode 100644
index 0000000000..5b2ebf3496
--- /dev/null
+++ b/hw/virtio/vhost-vsock-common.c
@@ -0,0 +1,258 @@
+/*
+ * Parent class for vhost-vsock devices
+ *
+ * Copyright 2015-2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "standard-headers/linux/virtio_vsock.h"
+#include "qapi/error.h"
+#include "hw/virtio/virtio-access.h"
+#include "qemu/error-report.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost-vsock.h"
+#include "qemu/iov.h"
+#include "monitor/monitor.h"
+
+int vhost_vsock_common_start(VirtIODevice *vdev)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+    int i;
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return -ENOSYS;
+    }
+
+    ret = vhost_dev_enable_notifiers(&vvc->vhost_dev, vdev);
+    if (ret < 0) {
+        error_report("Error enabling host notifiers: %d", -ret);
+        return ret;
+    }
+
+    ret = k->set_guest_notifiers(qbus->parent, vvc->vhost_dev.nvqs, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier: %d", -ret);
+        goto err_host_notifiers;
+    }
+
+    vvc->vhost_dev.acked_features = vdev->guest_features;
+    ret = vhost_dev_start(&vvc->vhost_dev, vdev);
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
+    for (i = 0; i < vvc->vhost_dev.nvqs; i++) {
+        vhost_virtqueue_mask(&vvc->vhost_dev, vdev, i, false);
+    }
+
+    return 0;
+
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, vvc->vhost_dev.nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(&vvc->vhost_dev, vdev);
+    return ret;
+}
+
+void vhost_vsock_common_stop(VirtIODevice *vdev)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+
+    if (!k->set_guest_notifiers) {
+        return;
+    }
+
+    vhost_dev_stop(&vvc->vhost_dev, vdev);
+
+    ret = k->set_guest_notifiers(qbus->parent, vvc->vhost_dev.nvqs, false);
+    if (ret < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", ret);
+        return;
+    }
+
+    vhost_dev_disable_notifiers(&vvc->vhost_dev, vdev);
+}
+
+
+static void vhost_vsock_common_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    /* Do nothing */
+}
+
+static void vhost_vsock_common_guest_notifier_mask(VirtIODevice *vdev, int idx,
+                                            bool mask)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+
+    vhost_virtqueue_mask(&vvc->vhost_dev, vdev, idx, mask);
+}
+
+static bool vhost_vsock_common_guest_notifier_pending(VirtIODevice *vdev,
+                                               int idx)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+
+    return vhost_virtqueue_pending(&vvc->vhost_dev, idx);
+}
+
+static void vhost_vsock_common_send_transport_reset(VHostVSockCommon *vvc)
+{
+    VirtQueueElement *elem;
+    VirtQueue *vq = vvc->event_vq;
+    struct virtio_vsock_event event = {
+        .id = cpu_to_le32(VIRTIO_VSOCK_EVENT_TRANSPORT_RESET),
+    };
+
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        error_report("vhost-vsock missed transport reset event");
+        return;
+    }
+
+    if (elem->out_num) {
+        error_report("invalid vhost-vsock event virtqueue element with "
+                     "out buffers");
+        goto out;
+    }
+
+    if (iov_from_buf(elem->in_sg, elem->in_num, 0,
+                     &event, sizeof(event)) != sizeof(event)) {
+        error_report("vhost-vsock event virtqueue element is too short");
+        goto out;
+    }
+
+    virtqueue_push(vq, elem, sizeof(event));
+    virtio_notify(VIRTIO_DEVICE(vvc), vq);
+
+out:
+    g_free(elem);
+}
+
+static void vhost_vsock_common_post_load_timer_cleanup(VHostVSockCommon *vvc)
+{
+    if (!vvc->post_load_timer) {
+        return;
+    }
+
+    timer_del(vvc->post_load_timer);
+    timer_free(vvc->post_load_timer);
+    vvc->post_load_timer = NULL;
+}
+
+static void vhost_vsock_common_post_load_timer_cb(void *opaque)
+{
+    VHostVSockCommon *vvc = opaque;
+
+    vhost_vsock_common_post_load_timer_cleanup(vvc);
+    vhost_vsock_common_send_transport_reset(vvc);
+}
+
+int vhost_vsock_common_pre_save(void *opaque)
+{
+    VHostVSockCommon *vvc = opaque;
+
+    /*
+     * At this point, backend must be stopped, otherwise
+     * it might keep writing to memory.
+     */
+    assert(!vvc->vhost_dev.started);
+
+    return 0;
+}
+
+int vhost_vsock_common_post_load(void *opaque, int version_id)
+{
+    VHostVSockCommon *vvc = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(vvc);
+
+    if (virtio_queue_get_addr(vdev, 2)) {
+        /*
+         * Defer transport reset event to a vm clock timer so that virtqueue
+         * changes happen after migration has completed.
+         */
+        assert(!vvc->post_load_timer);
+        vvc->post_load_timer =
+            timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                         vhost_vsock_common_post_load_timer_cb,
+                         vvc);
+        timer_mod(vvc->post_load_timer, 1);
+    }
+    return 0;
+}
+
+void vhost_vsock_common_realize(VirtIODevice *vdev, const char *name)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+
+    virtio_init(vdev, name, VIRTIO_ID_VSOCK,
+                sizeof(struct virtio_vsock_config));
+
+    /* Receive and transmit queues belong to vhost */
+    vvc->recv_vq = virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
+                                      vhost_vsock_common_handle_output);
+    vvc->trans_vq = virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
+                                       vhost_vsock_common_handle_output);
+
+    /* The event queue belongs to QEMU */
+    vvc->event_vq = virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
+                                       vhost_vsock_common_handle_output);
+
+    vvc->vhost_dev.nvqs = ARRAY_SIZE(vvc->vhost_vqs);
+    vvc->vhost_dev.vqs = vvc->vhost_vqs;
+
+    vvc->post_load_timer = NULL;
+}
+
+void vhost_vsock_common_unrealize(VirtIODevice *vdev)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+
+    vhost_vsock_common_post_load_timer_cleanup(vvc);
+
+    virtio_delete_queue(vvc->recv_vq);
+    virtio_delete_queue(vvc->trans_vq);
+    virtio_delete_queue(vvc->event_vq);
+    virtio_cleanup(vdev);
+}
+
+static void vhost_vsock_common_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->guest_notifier_mask = vhost_vsock_common_guest_notifier_mask;
+    vdc->guest_notifier_pending = vhost_vsock_common_guest_notifier_pending;
+}
+
+static const TypeInfo vhost_vsock_common_info = {
+    .name = TYPE_VHOST_VSOCK_COMMON,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VHostVSockCommon),
+    .class_init = vhost_vsock_common_class_init,
+    .abstract = true,
+};
+
+static void vhost_vsock_common_register_types(void)
+{
+    type_register_static(&vhost_vsock_common_info);
+}
+
+type_init(vhost_vsock_common_register_types)
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 4a228f5168..c8f0699b4f 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -12,24 +12,14 @@
  */
 
 #include "qemu/osdep.h"
-#include <sys/ioctl.h>
 #include "standard-headers/linux/virtio_vsock.h"
 #include "qapi/error.h"
-#include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "qemu/error-report.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
-#include "qemu/iov.h"
-#include "qemu/module.h"
 #include "monitor/monitor.h"
 
-enum {
-    VHOST_VSOCK_SAVEVM_VERSION = 0,
-
-    VHOST_VSOCK_QUEUE_SIZE = 128,
-};
-
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VHostVSock *vsock = VHOST_VSOCK(vdev);
@@ -39,16 +29,18 @@ static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
     memcpy(config, &vsockcfg, sizeof(vsockcfg));
 }
 
-static int vhost_vsock_set_guest_cid(VHostVSock *vsock)
+static int vhost_vsock_set_guest_cid(VirtIODevice *vdev)
 {
-    const VhostOps *vhost_ops = vsock->vhost_dev.vhost_ops;
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    VHostVSock *vsock = VHOST_VSOCK(vdev);
+    const VhostOps *vhost_ops = vvc->vhost_dev.vhost_ops;
     int ret;
 
     if (!vhost_ops->vhost_vsock_set_guest_cid) {
         return -ENOSYS;
     }
 
-    ret = vhost_ops->vhost_vsock_set_guest_cid(&vsock->vhost_dev,
+    ret = vhost_ops->vhost_vsock_set_guest_cid(&vvc->vhost_dev,
                                                vsock->conf.guest_cid);
     if (ret < 0) {
         return -errno;
@@ -56,123 +48,58 @@ static int vhost_vsock_set_guest_cid(VHostVSock *vsock)
     return 0;
 }
 
-static int vhost_vsock_set_running(VHostVSock *vsock, int start)
+static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
 {
-    const VhostOps *vhost_ops = vsock->vhost_dev.vhost_ops;
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    const VhostOps *vhost_ops = vvc->vhost_dev.vhost_ops;
     int ret;
 
     if (!vhost_ops->vhost_vsock_set_running) {
         return -ENOSYS;
     }
 
-    ret = vhost_ops->vhost_vsock_set_running(&vsock->vhost_dev, start);
+    ret = vhost_ops->vhost_vsock_set_running(&vvc->vhost_dev, start);
     if (ret < 0) {
         return -errno;
     }
     return 0;
 }
 
-static void vhost_vsock_start(VirtIODevice *vdev)
-{
-    VHostVSock *vsock = VHOST_VSOCK(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
-    int i;
-
-    if (!k->set_guest_notifiers) {
-        error_report("binding does not support guest notifiers");
-        return;
-    }
-
-    ret = vhost_dev_enable_notifiers(&vsock->vhost_dev, vdev);
-    if (ret < 0) {
-        error_report("Error enabling host notifiers: %d", -ret);
-        return;
-    }
-
-    ret = k->set_guest_notifiers(qbus->parent, vsock->vhost_dev.nvqs, true);
-    if (ret < 0) {
-        error_report("Error binding guest notifier: %d", -ret);
-        goto err_host_notifiers;
-    }
-
-    vsock->vhost_dev.acked_features = vdev->guest_features;
-    ret = vhost_dev_start(&vsock->vhost_dev, vdev);
-    if (ret < 0) {
-        error_report("Error starting vhost: %d", -ret);
-        goto err_guest_notifiers;
-    }
-
-    ret = vhost_vsock_set_running(vsock, 1);
-    if (ret < 0) {
-        error_report("Error starting vhost vsock: %d", -ret);
-        goto err_dev_start;
-    }
-
-    /* guest_notifier_mask/pending not used yet, so just unmask
-     * everything here.  virtio-pci will do the right thing by
-     * enabling/disabling irqfd.
-     */
-    for (i = 0; i < vsock->vhost_dev.nvqs; i++) {
-        vhost_virtqueue_mask(&vsock->vhost_dev, vdev, i, false);
-    }
-
-    return;
-
-err_dev_start:
-    vhost_dev_stop(&vsock->vhost_dev, vdev);
-err_guest_notifiers:
-    k->set_guest_notifiers(qbus->parent, vsock->vhost_dev.nvqs, false);
-err_host_notifiers:
-    vhost_dev_disable_notifiers(&vsock->vhost_dev, vdev);
-}
-
-static void vhost_vsock_stop(VirtIODevice *vdev)
-{
-    VHostVSock *vsock = VHOST_VSOCK(vdev);
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    int ret;
-
-    if (!k->set_guest_notifiers) {
-        return;
-    }
-
-    ret = vhost_vsock_set_running(vsock, 0);
-    if (ret < 0) {
-        error_report("vhost vsock set running failed: %d", ret);
-        return;
-    }
-
-    vhost_dev_stop(&vsock->vhost_dev, vdev);
-
-    ret = k->set_guest_notifiers(qbus->parent, vsock->vhost_dev.nvqs, false);
-    if (ret < 0) {
-        error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
-    }
-
-    vhost_dev_disable_notifiers(&vsock->vhost_dev, vdev);
-}
 
 static void vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
-    VHostVSock *vsock = VHOST_VSOCK(vdev);
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
     bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
+    int ret;
 
     if (!vdev->vm_running) {
         should_start = false;
     }
 
-    if (vsock->vhost_dev.started == should_start) {
+    if (vvc->vhost_dev.started == should_start) {
         return;
     }
 
     if (should_start) {
-        vhost_vsock_start(vdev);
+        ret = vhost_vsock_common_start(vdev);
+        if (ret < 0) {
+            return;
+        }
+
+        ret = vhost_vsock_set_running(vdev, 1);
+        if (ret < 0) {
+            vhost_vsock_common_stop(vdev);
+            error_report("Error starting vhost vsock: %d", -ret);
+            return;
+        }
     } else {
-        vhost_vsock_stop(vdev);
+        ret = vhost_vsock_set_running(vdev, 0);
+        if (ret < 0) {
+            error_report("vhost vsock set running failed: %d", ret);
+            return;
+        }
+
+        vhost_vsock_common_stop(vdev);
     }
 }
 
@@ -184,108 +111,6 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return requested_features;
 }
 
-static void vhost_vsock_handle_output(VirtIODevice *vdev, VirtQueue *vq)
-{
-    /* Do nothing */
-}
-
-static void vhost_vsock_guest_notifier_mask(VirtIODevice *vdev, int idx,
-                                            bool mask)
-{
-    VHostVSock *vsock = VHOST_VSOCK(vdev);
-
-    vhost_virtqueue_mask(&vsock->vhost_dev, vdev, idx, mask);
-}
-
-static bool vhost_vsock_guest_notifier_pending(VirtIODevice *vdev, int idx)
-{
-    VHostVSock *vsock = VHOST_VSOCK(vdev);
-
-    return vhost_virtqueue_pending(&vsock->vhost_dev, idx);
-}
-
-static void vhost_vsock_send_transport_reset(VHostVSock *vsock)
-{
-    VirtQueueElement *elem;
-    VirtQueue *vq = vsock->event_vq;
-    struct virtio_vsock_event event = {
-        .id = cpu_to_le32(VIRTIO_VSOCK_EVENT_TRANSPORT_RESET),
-    };
-
-    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
-    if (!elem) {
-        error_report("vhost-vsock missed transport reset event");
-        return;
-    }
-
-    if (elem->out_num) {
-        error_report("invalid vhost-vsock event virtqueue element with "
-                     "out buffers");
-        goto out;
-    }
-
-    if (iov_from_buf(elem->in_sg, elem->in_num, 0,
-                     &event, sizeof(event)) != sizeof(event)) {
-        error_report("vhost-vsock event virtqueue element is too short");
-        goto out;
-    }
-
-    virtqueue_push(vq, elem, sizeof(event));
-    virtio_notify(VIRTIO_DEVICE(vsock), vq);
-
-out:
-    g_free(elem);
-}
-
-static void vhost_vsock_post_load_timer_cleanup(VHostVSock *vsock)
-{
-    if (!vsock->post_load_timer) {
-        return;
-    }
-
-    timer_del(vsock->post_load_timer);
-    timer_free(vsock->post_load_timer);
-    vsock->post_load_timer = NULL;
-}
-
-static void vhost_vsock_post_load_timer_cb(void *opaque)
-{
-    VHostVSock *vsock = opaque;
-
-    vhost_vsock_post_load_timer_cleanup(vsock);
-    vhost_vsock_send_transport_reset(vsock);
-}
-
-static int vhost_vsock_pre_save(void *opaque)
-{
-    VHostVSock *vsock = opaque;
-
-    /* At this point, backend must be stopped, otherwise
-     * it might keep writing to memory. */
-    assert(!vsock->vhost_dev.started);
-
-    return 0;
-}
-
-static int vhost_vsock_post_load(void *opaque, int version_id)
-{
-    VHostVSock *vsock = opaque;
-    VirtIODevice *vdev = VIRTIO_DEVICE(vsock);
-
-    if (virtio_queue_get_addr(vdev, 2)) {
-        /* Defer transport reset event to a vm clock timer so that virtqueue
-         * changes happen after migration has completed.
-         */
-        assert(!vsock->post_load_timer);
-        vsock->post_load_timer =
-            timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                         vhost_vsock_post_load_timer_cb,
-                         vsock);
-        timer_mod(vsock->post_load_timer, 1);
-    }
-    return 0;
-}
-
 static const VMStateDescription vmstate_virtio_vhost_vsock = {
     .name = "virtio-vhost_vsock",
     .minimum_version_id = VHOST_VSOCK_SAVEVM_VERSION,
@@ -294,12 +119,13 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = vhost_vsock_pre_save,
-    .post_load = vhost_vsock_post_load,
+    .pre_save = vhost_vsock_common_pre_save,
+    .post_load = vhost_vsock_common_post_load,
 };
 
 static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 {
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
     int vhostfd;
@@ -331,46 +157,29 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    virtio_init(vdev, "vhost-vsock", VIRTIO_ID_VSOCK,
-                sizeof(struct virtio_vsock_config));
-
-    /* Receive and transmit queues belong to vhost */
-    vsock->recv_vq = virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
-                                      vhost_vsock_handle_output);
-    vsock->trans_vq = virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
-                                       vhost_vsock_handle_output);
+    vhost_vsock_common_realize(vdev, "vhost-vsock");
 
-    /* The event queue belongs to QEMU */
-    vsock->event_vq = virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
-                                       vhost_vsock_handle_output);
-
-    vsock->vhost_dev.nvqs = ARRAY_SIZE(vsock->vhost_vqs);
-    vsock->vhost_dev.vqs = vsock->vhost_vqs;
-    ret = vhost_dev_init(&vsock->vhost_dev, (void *)(uintptr_t)vhostfd,
+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
                          VHOST_BACKEND_TYPE_KERNEL, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "vhost-vsock: vhost_dev_init failed");
         goto err_virtio;
     }
 
-    ret = vhost_vsock_set_guest_cid(vsock);
+    ret = vhost_vsock_set_guest_cid(vdev);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "vhost-vsock: unable to set guest cid");
         goto err_vhost_dev;
     }
 
-    vsock->post_load_timer = NULL;
     return;
 
 err_vhost_dev:
-    vhost_dev_cleanup(&vsock->vhost_dev);
+    vhost_dev_cleanup(&vvc->vhost_dev);
     /* vhost_dev_cleanup() closes the vhostfd passed to vhost_dev_init() */
     vhostfd = -1;
 err_virtio:
-    virtio_delete_queue(vsock->recv_vq);
-    virtio_delete_queue(vsock->trans_vq);
-    virtio_delete_queue(vsock->event_vq);
-    virtio_cleanup(vdev);
+    vhost_vsock_common_unrealize(vdev);
     if (vhostfd >= 0) {
         close(vhostfd);
     }
@@ -379,19 +188,14 @@ err_virtio:
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostVSock *vsock = VHOST_VSOCK(dev);
-
-    vhost_vsock_post_load_timer_cleanup(vsock);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
-    vhost_dev_cleanup(&vsock->vhost_dev);
-    virtio_delete_queue(vsock->recv_vq);
-    virtio_delete_queue(vsock->trans_vq);
-    virtio_delete_queue(vsock->event_vq);
-    virtio_cleanup(vdev);
+    vhost_dev_cleanup(&vvc->vhost_dev);
+    vhost_vsock_common_unrealize(vdev);
 }
 
 static Property vhost_vsock_properties[] = {
@@ -407,19 +211,16 @@ static void vhost_vsock_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, vhost_vsock_properties);
     dc->vmsd = &vmstate_virtio_vhost_vsock;
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     vdc->realize = vhost_vsock_device_realize;
     vdc->unrealize = vhost_vsock_device_unrealize;
     vdc->get_features = vhost_vsock_get_features;
     vdc->get_config = vhost_vsock_get_config;
     vdc->set_status = vhost_vsock_set_status;
-    vdc->guest_notifier_mask = vhost_vsock_guest_notifier_mask;
-    vdc->guest_notifier_pending = vhost_vsock_guest_notifier_pending;
 }
 
 static const TypeInfo vhost_vsock_info = {
     .name = TYPE_VHOST_VSOCK,
-    .parent = TYPE_VIRTIO_DEVICE,
+    .parent = TYPE_VHOST_VSOCK_COMMON,
     .instance_size = sizeof(VHostVSock),
     .class_init = vhost_vsock_class_init,
 };
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 4e4d39a0a4..b1eeb44eac 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -17,7 +17,7 @@ obj-$(CONFIG_VIRTIO_PMEM) += virtio-pmem.o
 common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) += virtio-pmem-pci.o
 obj-$(call land,$(CONFIG_VHOST_USER_FS),$(CONFIG_VIRTIO_PCI)) += vhost-user-fs-pci.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
-obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
+obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-common.o vhost-vsock.o
 
 ifeq ($(CONFIG_VIRTIO_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
-- 
2.25.4


