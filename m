Received: from eggs.gnu.org ([2001:4830:134:3::10]:44637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eNGCj-0002j5-W1
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eNGCg-0005lD-22
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:30 -0500
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:56580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eNGCf-0005l8-RH
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:25 -0500
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id E82E9924F4
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 11:48:23 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 08 Dec 2017 11:48:21 +0100
Message-ID: <151273010147.18940.8992794348746235271.stgit@bahia.lan>
In-Reply-To: <151273008711.18940.15284049324681529367.stgit@bahia.lan>
References: <151273008711.18940.15284049324681529367.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/5] virtio-9p: move unrealize/realize after
 virtio_9p_transport definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>

And drop the now useless forward declaration of virtio_9p_transport.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/virtio-9p-device.c |   60 +++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 62650b0a6b99..c3ae7de3a2d5 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -20,8 +20,6 @@
 #include "hw/virtio/virtio-access.h"
 #include "qemu/iov.h"
 
-static const struct V9fsTransport virtio_9p_transport;
-
 static void virtio_9p_push_and_notify(V9fsPDU *pdu)
 {
     V9fsState *s = pdu->s;
@@ -104,35 +102,6 @@ static void virtio_9p_get_config(VirtIODevice *vdev, uint8_t *config)
     g_free(cfg);
 }
 
-static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    V9fsVirtioState *v = VIRTIO_9P(dev);
-    V9fsState *s = &v->state;
-
-    if (v9fs_device_realize_common(s, errp)) {
-        goto out;
-    }
-
-    v->config_size = sizeof(struct virtio_9p_config) + strlen(s->fsconf.tag);
-    virtio_init(vdev, "virtio-9p", VIRTIO_ID_9P, v->config_size);
-    v->vq = virtio_add_queue(vdev, MAX_REQ, handle_9p_output);
-    v9fs_register_transport(s, &virtio_9p_transport);
-
-out:
-    return;
-}
-
-static void virtio_9p_device_unrealize(DeviceState *dev, Error **errp)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    V9fsVirtioState *v = VIRTIO_9P(dev);
-    V9fsState *s = &v->state;
-
-    virtio_cleanup(vdev);
-    v9fs_device_unrealize_common(s, errp);
-}
-
 static void virtio_9p_reset(VirtIODevice *vdev)
 {
     V9fsVirtioState *v = (V9fsVirtioState *)vdev;
@@ -223,6 +192,35 @@ static const struct V9fsTransport virtio_9p_transport = {
     .push_and_notify = virtio_9p_push_and_notify,
 };
 
+static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    V9fsVirtioState *v = VIRTIO_9P(dev);
+    V9fsState *s = &v->state;
+
+    if (v9fs_device_realize_common(s, errp)) {
+        goto out;
+    }
+
+    v->config_size = sizeof(struct virtio_9p_config) + strlen(s->fsconf.tag);
+    virtio_init(vdev, "virtio-9p", VIRTIO_ID_9P, v->config_size);
+    v->vq = virtio_add_queue(vdev, MAX_REQ, handle_9p_output);
+    v9fs_register_transport(s, &virtio_9p_transport);
+
+out:
+    return;
+}
+
+static void virtio_9p_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    V9fsVirtioState *v = VIRTIO_9P(dev);
+    V9fsState *s = &v->state;
+
+    virtio_cleanup(vdev);
+    v9fs_device_unrealize_common(s, errp);
+}
+
 /* virtio-9p device */
 
 static const VMStateDescription vmstate_virtio_9p = {
