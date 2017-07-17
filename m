Received: from eggs.gnu.org ([2001:4830:134:3::10]:56671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18N-0005KJ-1h
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18L-0001IZ-Oz
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dX18L-0001IB-Ft
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:01 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 17 Jul 2017 10:11:44 +0200
Message-Id: <20170717081152.17153-2-lprosek@redhat.com>
In-Reply-To: <20170717081152.17153-1-lprosek@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/9] virtio: enhance virtio_error messages
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

Output like "Virtqueue size exceeded" is not much useful in identifying the
culprit. This commit adds virtio device name (e.g. "virtio-input") and id
if set (e.g. "mouse0") to all virtio error messages to improve debuggability.

Some virtio devices (virtio-scsi, virtio-serial) insert a bus between the
proxy object and the virtio backends, so a helper function is added to walk
the object hierarchy and find the right proxy object to extract the id from.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/virtio/virtio.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 464947f..d7fae54 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -31,6 +31,11 @@
  */
 #define VIRTIO_PCI_VRING_ALIGN         4096
 
+/*
+ * Name of the property linking proxy objects to virtio backend objects.
+ */
+#define VIRTIO_PROP_BACKEND            "virtio-backend"
+
 typedef struct VRingDesc
 {
     uint64_t addr;
@@ -2223,7 +2228,8 @@ void virtio_instance_init_common(Object *proxy_obj, void *data,
     DeviceState *vdev = data;
 
     object_initialize(vdev, vdev_size, vdev_name);
-    object_property_add_child(proxy_obj, "virtio-backend", OBJECT(vdev), NULL);
+    object_property_add_child(proxy_obj, VIRTIO_PROP_BACKEND, OBJECT(vdev),
+                              NULL);
     object_unref(OBJECT(vdev));
     qdev_alias_all_properties(vdev, proxy_obj);
 }
@@ -2443,14 +2449,34 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name)
     vdev->bus_name = g_strdup(bus_name);
 }
 
+static const char *virtio_get_device_id(VirtIODevice *vdev)
+{
+    DeviceState *qdev = DEVICE(vdev);
+    while (qdev) {
+        /* Find the proxy object corresponding to the vdev backend */
+        Object *prop = object_property_get_link(OBJECT(qdev),
+                                                VIRTIO_PROP_BACKEND, NULL);
+        if (prop == OBJECT(vdev)) {
+            return qdev->id ? qdev->id : "";
+        }
+        qdev = qdev->parent_bus->parent;
+    }
+    g_assert_not_reached();
+    return "";
+}
+
 void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
 {
     va_list ap;
+    char *msg;
 
     va_start(ap, fmt);
-    error_vreport(fmt, ap);
+    msg = g_strdup_vprintf(fmt, ap);
     va_end(ap);
 
+    error_report("%s (id=%s): %s", vdev->name, virtio_get_device_id(vdev), msg);
+    g_free(msg);
+
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
         virtio_notify_config(vdev);
-- 
2.9.3
