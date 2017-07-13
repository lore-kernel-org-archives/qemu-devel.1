Received: from eggs.gnu.org ([2001:4830:134:3::10]:40224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVbtT-0005iD-27
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVbtR-0001Jp-QE
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:02:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dVbtR-0001IY-Jz
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:02:49 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 13 Jul 2017 13:02:31 +0200
Message-Id: <20170713110237.6712-3-lprosek@redhat.com>
In-Reply-To: <20170713110237.6712-1-lprosek@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/8] virtio: enhance virtio_error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, stefanha@redhat.com

Output like "Virtqueue size exceeded" is not much useful in identifying the
culprit. This commit adds virtio device name (e.g. "virtio-input") and id
if set (e.g. "mouse0") to all virtio error messages to improve debuggability.

Some virtio devices (virtio-scsi, virtio-serial) insert a bus between the
proxy object and the virtio backends, so a helper function is added to walk
the object hierarchy and find the right proxy object to extract the id from.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/virtio/virtio.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 0e76a73..a98f681 100644
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
@@ -2443,12 +2449,29 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name)
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
+            return qdev->id;
+        }
+        qdev = qdev->parent_bus->parent;
+    }
+    return NULL;
+}
+
 void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
 {
     va_list ap;
 
+    error_report_nolf("%s (id=%s): ", vdev->name, virtio_get_device_id(vdev));
+
     va_start(ap, fmt);
-    error_vreport_nolf(fmt, ap);
+    error_vprintf(fmt, ap);
     va_end(ap);
     error_printf("\n");
 
-- 
2.9.3
