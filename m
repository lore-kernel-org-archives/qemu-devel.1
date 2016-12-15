Received: from eggs.gnu.org ([2001:4830:134:3::10]:42949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC8-0003q9-Eh
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC5-0001T7-Ag
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKC5-0001SK-25
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:45 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hae3056427
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:44 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm90wg2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:43 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:43 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:39 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-46-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 45/67] virtio: allow per-device-class legacy
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

From: "Michael S. Tsirkin" <mst@redhat.com>

Legacy features are those that transitional devices only
expose on the legacy interface.
Allow different ones per device class.

Cc: qemu-stable@nongnu.org # dependency for the next patch
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
(cherry picked from commit 9b706dbbbb81f5cb7c67e491d38cd6077205e056)

Conflicts:
	hw/virtio/virtio.c

* drop context dep on ff4c07df
* resolv func dep on ff4c07df creating vdc variable in
  virtio_device_class_init()

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/s390x/virtio-ccw.c      | 4 +++-
 hw/virtio/virtio-pci.c     | 4 +++-
 hw/virtio/virtio.c         | 3 +++
 include/hw/virtio/virtio.h | 5 +++++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index a554a24..f6f5e79 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -330,6 +330,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         if (!ccw.cda) {
             ret = -EFAULT;
         } else {
+            VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+
             features.index = address_space_ldub(&address_space_memory,
                                                 ccw.cda
                                                 + sizeof(features.features),
@@ -339,7 +341,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                 if (dev->revision >= 1) {
                     /* Don't offer legacy features for modern devices. */
                     features.features = (uint32_t)
-                        (vdev->host_features & ~VIRTIO_LEGACY_FEATURES);
+                        (vdev->host_features & ~vdc->legacy_features);
                 } else {
                     features.features = (uint32_t)vdev->host_features;
                 }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 755f921..46711a2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1192,7 +1192,9 @@ static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
         break;
     case VIRTIO_PCI_COMMON_DF:
         if (proxy->dfselect <= 1) {
-            val = (vdev->host_features & ~VIRTIO_LEGACY_FEATURES) >>
+            VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+
+            val = (vdev->host_features & ~vdc->legacy_features) >>
                 (32 * proxy->dfselect);
         }
         break;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e8a13a5..f31140a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1966,12 +1966,15 @@ static Property virtio_properties[] = {
 static void virtio_device_class_init(ObjectClass *klass, void *data)
 {
     /* Set the default value here. */
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = virtio_device_realize;
     dc->unrealize = virtio_device_unrealize;
     dc->bus_type = TYPE_VIRTIO_BUS;
     dc->props = virtio_properties;
+
+    vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
 }
 
 static const TypeInfo virtio_device_info = {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index d2490c1..d51341d 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -112,6 +112,11 @@ typedef struct VirtioDeviceClass {
     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
     void (*reset)(VirtIODevice *vdev);
     void (*set_status)(VirtIODevice *vdev, uint8_t val);
+    /* For transitional devices, this is a bitmap of features
+     * that are only exposed on the legacy interface but not
+     * the modern one.
+     */
+    uint64_t legacy_features;
     /* Test and clear event pending status.
      * Should be called after unmask to avoid losing events.
      * If backend does not support masking,
-- 
1.9.1
