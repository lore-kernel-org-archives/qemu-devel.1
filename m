Received: from eggs.gnu.org ([2001:4830:134:3::10]:56695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18P-0005KV-4C
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18O-0001Ja-1A
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dX18N-0001JE-Nq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:03 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 17 Jul 2017 10:11:45 +0200
Message-Id: <20170717081152.17153-3-lprosek@redhat.com>
In-Reply-To: <20170717081152.17153-1-lprosek@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/9] virtio: introduce virtqueue_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

Most virtio error output pertains to a specific virtqueue so it makes
sense to include the queue index in error messages.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/virtio/virtio.c         | 44 +++++++++++++++++++++++++++++++++-----------
 include/hw/virtio/virtio.h |  1 +
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d7fae54..935a5e3 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2465,18 +2465,8 @@ static const char *virtio_get_device_id(VirtIODevice *vdev)
     return "";
 }
 
-void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
+static void virtio_device_set_broken(VirtIODevice *vdev)
 {
-    va_list ap;
-    char *msg;
-
-    va_start(ap, fmt);
-    msg = g_strdup_vprintf(fmt, ap);
-    va_end(ap);
-
-    error_report("%s (id=%s): %s", vdev->name, virtio_get_device_id(vdev), msg);
-    g_free(msg);
-
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
         virtio_notify_config(vdev);
@@ -2485,6 +2475,38 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
     vdev->broken = true;
 }
 
+void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
+{
+    va_list ap;
+    char *msg;
+
+    va_start(ap, fmt);
+    msg = g_strdup_vprintf(fmt, ap);
+    va_end(ap);
+
+    error_report("%s (id=%s): %s", vdev->name, virtio_get_device_id(vdev), msg);
+    g_free(msg);
+
+    virtio_device_set_broken(vdev);
+}
+
+void GCC_FMT_ATTR(2, 3) virtqueue_error(VirtQueue *vq, const char *fmt, ...)
+{
+    VirtIODevice *vdev = vq->vdev;
+    va_list ap;
+    char *msg;
+
+    va_start(ap, fmt);
+    msg = g_strdup_vprintf(fmt, ap);
+    va_end(ap);
+
+    error_report("%s (id=%s) queue %d: %s", vdev->name,
+                 virtio_get_device_id(vdev), vq->queue_index, msg);
+    g_free(msg);
+
+    virtio_device_set_broken(vdev);
+}
+
 static void virtio_memory_listener_commit(MemoryListener *listener)
 {
     VirtIODevice *vdev = container_of(listener, VirtIODevice, listener);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 80c45c3..c6c56a0 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -151,6 +151,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
 void virtio_cleanup(VirtIODevice *vdev);
 
 void virtio_error(VirtIODevice *vdev, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+void virtqueue_error(VirtQueue *vq, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 
 /* Set the child bus name. */
 void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name);
-- 
2.9.3
