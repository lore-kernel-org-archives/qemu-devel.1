Received: from eggs.gnu.org ([2001:4830:134:3::10]:33599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQJ-000378-DR
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQG-0006GG-K3
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eYYQG-0006FH-CR
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:08 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
	w08ESv0I089804
	for <qemu-devel@nongnu.org>; Mon, 8 Jan 2018 09:29:04 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fc8f6dwgs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:28:58 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 8 Jan 2018 14:28:49 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  8 Jan 2018 15:28:18 +0100
In-Reply-To: <20180108142831.6638-1-groug@kaod.org>
References: <20180108142831.6638-1-groug@kaod.org>
Message-Id: <20180108142831.6638-2-groug@kaod.org>
Subject: [Qemu-devel] [PULL 01/14] virtio-9p: move unrealize/realize after
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

And drop the now useless forward declaration of virtio_9p_transport.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/virtio-9p-device.c | 60 ++++++++++++++++++++++------------------------
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
-- 
2.13.6
