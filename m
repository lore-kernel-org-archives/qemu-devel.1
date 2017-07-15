Received: from eggs.gnu.org ([2001:4830:134:3::10]:45812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dWKD2-0000pS-He
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 06:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dWKCz-0005RI-So
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 06:22:00 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dWKCy-0005Pn-R7
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 06:21:57 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Sat, 15 Jul 2017 18:21:09 +0800
Message-ID: <1500114070-181004-3-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1500114070-181004-1-git-send-email-arei.gonglei@huawei.com>
References: <1500114070-181004-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 2/3] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, roy.fan.zhang@intel.com, xin.zeng@intel.com, linqiangmin@huawei.com, marcandre.lureau@redhat.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, jianjay.zhou@huawei.com, Gonglei <arei.gonglei@huawei.com>

Impliment the vhost-crypto's funtions, such as startup,
stop and notification etc. Introduce an enum
QCryptoCryptoDevBackendOptionsType in order to
identify the cryptodev vhost backend is vhost-user
or vhost-kernel-module (If exist).

At this point, the cryptdoev-vhost-user works.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Zhoujian <jianjay.zhou@huawei.com>
---
 backends/cryptodev-builtin.c          |   1 +
 backends/cryptodev-vhost-user.c       |  16 +++
 backends/cryptodev-vhost.c            | 224 ++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-crypto.c             |  70 +++++++++++
 include/hw/virtio/virtio-crypto.h     |   1 +
 include/sysemu/cryptodev-vhost-user.h |  44 +++++++
 include/sysemu/cryptodev.h            |   8 ++
 7 files changed, 364 insertions(+)
 create mode 100644 include/sysemu/cryptodev-vhost-user.h

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 657c0ba..9fb0bd5 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -78,6 +78,7 @@ static void cryptodev_builtin_init(
               "cryptodev-builtin", NULL);
     cc->info_str = g_strdup_printf("cryptodev-builtin0");
     cc->queue_index = 0;
+    cc->type = CRYPTODEV_BACKEND_TYPE_BUILTIN;
     backend->conf.peers.ccs[0] = cc;
 
     backend->conf.crypto_services =
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 4e63ece..0b1f049 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -29,6 +29,7 @@
 #include "standard-headers/linux/virtio_crypto.h"
 #include "sysemu/cryptodev-vhost.h"
 #include "chardev/char-fe.h"
+#include "sysemu/cryptodev-vhost-user.h"
 
 
 /**
@@ -58,6 +59,20 @@ cryptodev_vhost_user_running(
     return crypto ? 1 : 0;
 }
 
+CryptoDevBackendVhost *
+cryptodev_vhost_user_get_vhost(
+                         CryptoDevBackendClient *cc,
+                         CryptoDevBackend *b,
+                         uint16_t queue)
+{
+    CryptoDevBackendVhostUser *s =
+                      CRYPTODEV_BACKEND_VHOST_USER(b);
+    assert(cc->type == CRYPTODEV_BACKEND_TYPE_VHOST_USER);
+    assert(queue < MAX_CRYPTO_QUEUE_NUM);
+
+    return s->vhost_crypto[queue];
+}
+
 static void cryptodev_vhost_user_stop(int queues,
                           CryptoDevBackendVhostUser *s)
 {
@@ -190,6 +205,7 @@ static void cryptodev_vhost_user_init(
         cc->info_str = g_strdup_printf("cryptodev-vhost-user%lu to %s ",
                                        i, chr->label);
         cc->queue_index = i;
+        cc->type = CRYPTODEV_BACKEND_TYPE_VHOST_USER;
 
         backend->conf.peers.ccs[i] = cc;
 
diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 111e428..c65e741 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -25,7 +25,11 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/error-report.h"
 #include "sysemu/cryptodev-vhost.h"
+#include "hw/virtio/virtio-crypto.h"
+#include "hw/virtio/virtio-bus.h"
+#include "sysemu/cryptodev-vhost-user.h"
 
 
 uint64_t
@@ -71,3 +75,223 @@ fail:
     g_free(crypto);
     return NULL;
 }
+
+static int
+cryptodev_vhost_start_one(CryptoDevBackendVhost *crypto,
+                                  VirtIODevice *dev)
+{
+    int r;
+
+    crypto->dev.nvqs = 1;
+    crypto->dev.vqs = crypto->vqs;
+
+    r = vhost_dev_enable_notifiers(&crypto->dev, dev);
+    if (r < 0) {
+        goto fail_notifiers;
+    }
+
+    r = vhost_dev_start(&crypto->dev, dev);
+    if (r < 0) {
+        goto fail_start;
+    }
+
+    return 0;
+
+fail_start:
+    vhost_dev_disable_notifiers(&crypto->dev, dev);
+fail_notifiers:
+    return r;
+}
+
+static void
+cryptodev_vhost_stop_one(CryptoDevBackendVhost *crypto,
+                                 VirtIODevice *dev)
+{
+    vhost_dev_stop(&crypto->dev, dev);
+    vhost_dev_disable_notifiers(&crypto->dev, dev);
+}
+
+CryptoDevBackendVhost *
+cryptodev_get_vhost(CryptoDevBackendClient *cc,
+                            CryptoDevBackend *b,
+                            uint16_t queue)
+{
+    CryptoDevBackendVhost *vhost_crypto = NULL;
+
+    if (!cc) {
+        return NULL;
+    }
+
+    switch (cc->type) {
+    case CRYPTODEV_BACKEND_TYPE_VHOST_USER:
+        vhost_crypto = cryptodev_vhost_user_get_vhost(cc, b, queue);
+        break;
+    default:
+        break;
+    }
+
+    return vhost_crypto;
+}
+
+static void
+cryptodev_vhost_set_vq_index(CryptoDevBackendVhost *crypto,
+                                     int vq_index)
+{
+    crypto->dev.vq_index = vq_index;
+}
+
+static int
+vhost_set_vring_enable(CryptoDevBackendClient *cc,
+                            CryptoDevBackend *b,
+                            uint16_t queue, int enable)
+{
+    CryptoDevBackendVhost *crypto =
+                       cryptodev_get_vhost(cc, b, queue);
+    const VhostOps *vhost_ops;
+
+    cc->vring_enable = enable;
+
+    if (!crypto) {
+        return 0;
+    }
+
+    vhost_ops = crypto->dev.vhost_ops;
+    if (vhost_ops->vhost_set_vring_enable) {
+        return vhost_ops->vhost_set_vring_enable(&crypto->dev, enable);
+    }
+
+    return 0;
+}
+
+int cryptodev_vhost_start(VirtIODevice *dev, int total_queues)
+{
+    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
+    VirtioBusState *vbus = VIRTIO_BUS(qbus);
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    int r, e;
+    int i;
+    CryptoDevBackend *b = vcrypto->cryptodev;
+    CryptoDevBackendVhost *vhost_crypto;
+    CryptoDevBackendClient *cc;
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return -ENOSYS;
+    }
+
+    for (i = 0; i < total_queues; i++) {
+        cc = b->conf.peers.ccs[i];
+
+        vhost_crypto = cryptodev_get_vhost(cc, b, i);
+        cryptodev_vhost_set_vq_index(vhost_crypto, i);
+
+        /* Suppress the masking guest notifiers on vhost user
+         * because vhost user doesn't interrupt masking/unmasking
+         * properly.
+         */
+        if (cc->type == CRYPTODEV_BACKEND_TYPE_VHOST_USER) {
+            dev->use_guest_notifier_mask = false;
+        }
+     }
+
+    r = k->set_guest_notifiers(qbus->parent, total_queues, true);
+    if (r < 0) {
+        error_report("error binding guest notifier: %d", -r);
+        goto err;
+    }
+
+    for (i = 0; i < total_queues; i++) {
+        cc = b->conf.peers.ccs[i];
+
+        vhost_crypto = cryptodev_get_vhost(cc, b, i);
+        r = cryptodev_vhost_start_one(vhost_crypto, dev);
+
+        if (r < 0) {
+            goto err_start;
+        }
+
+        if (cc->vring_enable) {
+            /* restore vring enable state */
+            r = vhost_set_vring_enable(cc, b, i, cc->vring_enable);
+
+            if (r < 0) {
+                goto err_start;
+            }
+        }
+    }
+
+    return 0;
+
+err_start:
+    while (--i >= 0) {
+        cc = b->conf.peers.ccs[i];
+        vhost_crypto = cryptodev_get_vhost(cc, b, i);
+        cryptodev_vhost_stop_one(vhost_crypto, dev);
+    }
+    e = k->set_guest_notifiers(qbus->parent, total_queues, false);
+    if (e < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", e);
+    }
+err:
+    return r;
+}
+
+void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues)
+{
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
+    VirtioBusState *vbus = VIRTIO_BUS(qbus);
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
+    CryptoDevBackend *b = vcrypto->cryptodev;
+    CryptoDevBackendVhost *vhost_crypto;
+    CryptoDevBackendClient *cc;
+    size_t i;
+    int r;
+
+    for (i = 0; i < total_queues; i++) {
+        cc = b->conf.peers.ccs[i];
+
+        vhost_crypto = cryptodev_get_vhost(cc, b, i);
+        cryptodev_vhost_stop_one(vhost_crypto, dev);
+    }
+
+    r = k->set_guest_notifiers(qbus->parent, total_queues, false);
+    if (r < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", r);
+    }
+    assert(r >= 0);
+}
+
+void cryptodev_vhost_virtqueue_mask(VirtIODevice *dev,
+                                           int queue,
+                                           int idx, bool mask)
+{
+    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
+    CryptoDevBackend *b = vcrypto->cryptodev;
+    CryptoDevBackendVhost *vhost_crypto;
+    CryptoDevBackendClient *cc;
+
+    assert(queue < MAX_CRYPTO_QUEUE_NUM);
+
+    cc = b->conf.peers.ccs[queue];
+    vhost_crypto = cryptodev_get_vhost(cc, b, queue);
+
+    vhost_virtqueue_mask(&vhost_crypto->dev, dev, idx, mask);
+}
+
+bool cryptodev_vhost_virtqueue_pending(VirtIODevice *dev,
+                                              int queue, int idx)
+{
+    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
+    CryptoDevBackend *b = vcrypto->cryptodev;
+    CryptoDevBackendVhost *vhost_crypto;
+    CryptoDevBackendClient *cc;
+
+    assert(queue < MAX_CRYPTO_QUEUE_NUM);
+
+    cc = b->conf.peers.ccs[queue];
+    vhost_crypto = cryptodev_get_vhost(cc, b, queue);
+
+    return vhost_virtqueue_pending(&vhost_crypto->dev, idx);
+}
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 19c82e0..a13ba39 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -20,6 +20,7 @@
 #include "hw/virtio/virtio-crypto.h"
 #include "hw/virtio/virtio-access.h"
 #include "standard-headers/linux/virtio_ids.h"
+#include "sysemu/cryptodev-vhost.h"
 
 #define VIRTIO_CRYPTO_VM_VERSION 1
 
@@ -880,6 +881,72 @@ static void virtio_crypto_get_config(VirtIODevice *vdev, uint8_t *config)
     memcpy(config, &crypto_cfg, c->config_size);
 }
 
+static bool virtio_crypto_started(VirtIOCrypto *c, uint8_t status)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(c);
+    return (status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+        (c->status & VIRTIO_CRYPTO_S_HW_READY) && vdev->vm_running;
+}
+
+static void virtio_crypto_vhost_status(VirtIOCrypto *c, uint8_t status)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(c);
+    int queues = c->multiqueue ? c->max_queues : 1;
+    CryptoDevBackend *b = c->cryptodev;
+    CryptoDevBackendClient *cc = b->conf.peers.ccs[0];
+
+    if (!cryptodev_get_vhost(cc, b, 0)) {
+        return;
+    }
+
+    if ((virtio_crypto_started(c, status)) == !!c->vhost_started) {
+        return;
+    }
+
+    if (!c->vhost_started) {
+        int r;
+
+        c->vhost_started = 1;
+        r = cryptodev_vhost_start(vdev, queues);
+        if (r < 0) {
+            error_report("unable to start vhost net: %d: "
+                         "falling back on userspace virtio", -r);
+            c->vhost_started = 0;
+        }
+    } else {
+        cryptodev_vhost_stop(vdev, queues);
+        c->vhost_started = 0;
+    }
+}
+
+static void virtio_crypto_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
+
+    virtio_crypto_vhost_status(vcrypto, status);
+}
+
+static void virtio_crypto_guest_notifier_mask(VirtIODevice *vdev, int idx,
+                                           bool mask)
+{
+    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
+    int queue = virtio_crypto_vq2q(idx);
+
+    assert(vcrypto->vhost_started);
+
+    cryptodev_vhost_virtqueue_mask(vdev, queue, idx, mask);
+}
+
+static bool virtio_crypto_guest_notifier_pending(VirtIODevice *vdev, int idx)
+{
+    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
+    int queue = virtio_crypto_vq2q(idx);
+
+    assert(vcrypto->vhost_started);
+
+    return cryptodev_vhost_virtqueue_pending(vdev, queue, idx);
+}
+
 static void virtio_crypto_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -893,6 +960,9 @@ static void virtio_crypto_class_init(ObjectClass *klass, void *data)
     vdc->get_config = virtio_crypto_get_config;
     vdc->get_features = virtio_crypto_get_features;
     vdc->reset = virtio_crypto_reset;
+    vdc->set_status = virtio_crypto_set_status;
+    vdc->guest_notifier_mask = virtio_crypto_guest_notifier_mask;
+    vdc->guest_notifier_pending = virtio_crypto_guest_notifier_pending;
 }
 
 static void virtio_crypto_instance_init(Object *obj)
diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio-crypto.h
index a00a0bf..ca3a049 100644
--- a/include/hw/virtio/virtio-crypto.h
+++ b/include/hw/virtio/virtio-crypto.h
@@ -96,6 +96,7 @@ typedef struct VirtIOCrypto {
     int multiqueue;
     uint32_t curr_queues;
     size_t config_size;
+    uint8_t vhost_started;
 } VirtIOCrypto;
 
 #endif /* _QEMU_VIRTIO_CRYPTO_H */
diff --git a/include/sysemu/cryptodev-vhost-user.h b/include/sysemu/cryptodev-vhost-user.h
new file mode 100644
index 0000000..937217b
--- /dev/null
+++ b/include/sysemu/cryptodev-vhost-user.h
@@ -0,0 +1,44 @@
+/*
+ * QEMU Crypto Device Common Vhost User Implement
+ *
+ * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *    Gonglei <arei.gonglei@huawei.com>
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
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+#ifndef CRYPTODEV_VHOST_USER_H
+#define CRYPTODEV_VHOST_USER_H
+
+
+/**
+ * cryptodev_vhost_user_get_vhost:
+ * @cc: the client object for each queue
+ * @b: the cryptodev backend common vhost object
+ * @queue: the queue index
+ *
+ * Gets a new cryptodev backend common vhost object based on
+ * @b and @queue
+ *
+ * Returns: the cryptodev backend common vhost object
+ */
+CryptoDevBackendVhost *
+cryptodev_vhost_user_get_vhost(
+                         CryptoDevBackendClient *cc,
+                         CryptoDevBackend *b,
+                         uint16_t queue);
+
+#endif /* CRYPTODEV_VHOST_USER_H */
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index a9d0d1e..faeb6f8 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -163,12 +163,20 @@ typedef struct CryptoDevBackendClass {
                      uint32_t queue_index, Error **errp);
 } CryptoDevBackendClass;
 
+typedef enum CryptoDevBackendOptionsType {
+    CRYPTODEV_BACKEND_TYPE_NONE = 0,
+    CRYPTODEV_BACKEND_TYPE_BUILTIN = 1,
+    CRYPTODEV_BACKEND_TYPE_VHOST_USER = 2,
+    CRYPTODEV_BACKEND_TYPE__MAX,
+} CryptoDevBackendOptionsType;
 
 struct CryptoDevBackendClient {
+    CryptoDevBackendOptionsType type;
     char *model;
     char *name;
     char *info_str;
     unsigned int queue_index;
+    int vring_enable;
     QTAILQ_ENTRY(CryptoDevBackendClient) next;
 };
 
-- 
1.8.3.1
