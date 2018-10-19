Received: from eggs.gnu.org ([2001:4830:134:3::10]:42968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDD-0003kn-Sv
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDC-0000Cd-Qz
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:39 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gDNDB-0008SP-7Y
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:38 -0400
Received: by mail-pf1-x441.google.com with SMTP id j23-v6so15952801pfi.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:20:30 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 18 Oct 2018 22:20:07 -0700
Message-Id: <1539926412-21831-3-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
References: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 2/7] vfio: ap-device: make it more
 QOMConventional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, philmd@redhat.com, Li Qiang <liq3ea@gmail.com>

As the documentation says "use TYPE_FOO constants"
This also changes the parent of ap-device's MACRO.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/s390x/ap-device.c         |  2 +-
 hw/vfio/ap.c                 | 12 ++++++------
 include/hw/s390x/ap-device.h |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
index f5ac8db..64a5f11 100644
--- a/hw/s390x/ap-device.c
+++ b/hw/s390x/ap-device.c
@@ -22,7 +22,7 @@ static void ap_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ap_device_info = {
-    .name = AP_DEVICE_TYPE,
+    .name = TYPE_AP_DEVICE,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(APDevice),
     .class_size = sizeof(DeviceClass),
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 3962bb7..b332395 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -28,7 +28,7 @@
 #include "hw/s390x/ap-bridge.h"
 #include "exec/address-spaces.h"
 
-#define VFIO_AP_DEVICE_TYPE      "vfio-ap"
+#define TYPE_VFIO_AP_DEVICE      "vfio-ap"
 
 typedef struct VFIOAPDevice {
     APDevice apdev;
@@ -36,7 +36,7 @@ typedef struct VFIOAPDevice {
 } VFIOAPDevice;
 
 #define VFIO_AP_DEVICE(obj) \
-        OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
+        OBJECT_CHECK(VFIOAPDevice, (obj), TYPE_VFIO_AP_DEVICE)
 
 static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
 {
@@ -69,7 +69,7 @@ static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
 
     if (!group_path) {
         error_setg(errp, "%s: no iommu_group found for %s: %s",
-                   VFIO_AP_DEVICE_TYPE, vapdev->vdev.sysfsdev, gerror->message);
+                   TYPE_VFIO_AP_DEVICE, vapdev->vdev.sysfsdev, gerror->message);
         return NULL;
     }
 
@@ -147,7 +147,7 @@ static void vfio_ap_reset(DeviceState *dev)
 }
 
 static const VMStateDescription vfio_ap_vmstate = {
-    .name = VFIO_AP_DEVICE_TYPE,
+    .name = TYPE_VFIO_AP_DEVICE,
     .unmigratable = 1,
 };
 
@@ -167,8 +167,8 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo vfio_ap_info = {
-    .name = VFIO_AP_DEVICE_TYPE,
-    .parent = AP_DEVICE_TYPE,
+    .name = TYPE_VFIO_AP_DEVICE,
+    .parent = TYPE_AP_DEVICE,
     .instance_size = sizeof(VFIOAPDevice),
     .class_init = vfio_ap_class_init,
 };
diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
index 765e908..d7eced4 100644
--- a/include/hw/s390x/ap-device.h
+++ b/include/hw/s390x/ap-device.h
@@ -10,13 +10,13 @@
 #ifndef HW_S390X_AP_DEVICE_H
 #define HW_S390X_AP_DEVICE_H
 
-#define AP_DEVICE_TYPE       "ap-device"
+#define TYPE_AP_DEVICE      "ap-device"
 
 typedef struct APDevice {
     DeviceState parent_obj;
 } APDevice;
 
 #define AP_DEVICE(obj) \
-    OBJECT_CHECK(APDevice, (obj), AP_DEVICE_TYPE)
+    OBJECT_CHECK(APDevice, (obj), TYPE_AP_DEVICE)
 
 #endif /* HW_S390X_AP_DEVICE_H */
-- 
1.8.3.1
