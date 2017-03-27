Received: from eggs.gnu.org ([2001:4830:134:3::10]:53147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csYia-0002gF-Bg
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csYiX-0000et-9z
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:12 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:57502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1csYiX-0000eP-3B
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:09 -0400
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id A20A2782B2
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 19:46:07 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 27 Mar 2017 19:46:03 +0200
Message-ID: <149063676337.4447.2095575576822297032.stgit@bahia.lan>
In-Reply-To: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
References: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/5] virtio: Error object based virtio_error()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>

This introduces an Error object based implementation of virtio_error(). It
allows to implement virtio_error() wrappers in device-specific code.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/virtio/virtio.c         |   21 ++++++++++++++++-----
 include/hw/virtio/virtio.h |    1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 03592c542a55..4036f4816038 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2443,6 +2443,16 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name)
     vdev->bus_name = g_strdup(bus_name);
 }
 
+static void virtio_device_set_broken(VirtIODevice *vdev)
+{
+    vdev->broken = true;
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
+        virtio_notify_config(vdev);
+    }
+}
+
 void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
 {
     va_list ap;
@@ -2451,12 +2461,13 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
     error_vreport(fmt, ap);
     va_end(ap);
 
-    vdev->broken = true;
+    virtio_device_set_broken(vdev);
+}
 
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
-        virtio_notify_config(vdev);
-    }
+void virtio_error_err(VirtIODevice *vdev, Error *err)
+{
+    error_report_err(err);
+    virtio_device_set_broken(vdev);
 }
 
 static void virtio_memory_listener_commit(MemoryListener *listener)
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 15efcf205711..5b13c5f67b63 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -150,6 +150,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
 void virtio_cleanup(VirtIODevice *vdev);
 
 void virtio_error(VirtIODevice *vdev, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+void virtio_error_err(VirtIODevice *vdev, Error *err);
 
 /* Set the child bus name. */
 void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name);
