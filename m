Received: from eggs.gnu.org ([2001:4830:134:3::10]:60242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgAKx-0006YK-Np
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgAKw-0003Yi-Q8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:18:35 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 21 Feb 2017 14:18:19 +0100
Message-Id: <1487683100-16013-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1487683100-16013-1-git-send-email-eric.auger@redhat.com>
References: <1487683100-16013-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] vfio/platform: make the vfio-platform
 device non abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: shankerd@codeaurora.org, okaya@codeaurora.org, vikrams@codeaurora.org, agraf@suse.de, pelcan@codeaurora.org

Up to now the vfio-platform device has been abstract and could not be
instantiated. The integration of a new vfio platform device required
to create a dummy derived device which only set the compatibility
string.

Following the few vfio-platform device integration we have seen
the actual requested adaptation happens on device tree node creation
(sysbus-fdt).

So this patch removes the abstract setting and defines 2 new options,
manufacturer and model that are used to build a compatibility string.

This latter will be used to match the device tree node creation
function

sysbus-fdt does not support the instantiation of the vfio-platform
device yet.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/platform.c              | 18 ++++++++++++++++--
 include/hw/vfio/vfio-platform.h |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index a4663c9..73c0489 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -637,7 +637,20 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
     VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
     SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
     VFIODevice *vbasedev = &vdev->vbasedev;
-    int i, ret;
+    int i, ret = -EINVAL;
+
+    if (!vdev->compat) {
+        if (!vdev->model) {
+            error_setg(errp, "no usable compatible string");
+            goto out;
+        }
+        if (!vdev->manufacturer) {
+            vdev->compat = g_strdup(vdev->model);
+        } else {
+            vdev->compat = g_strjoin(",", vdev->manufacturer,
+                                     vdev->model, NULL);
+        }
+    }
 
     vbasedev->type = VFIO_DEVICE_TYPE_PLATFORM;
     vbasedev->ops = &vfio_platform_ops;
@@ -678,6 +691,8 @@ static const VMStateDescription vfio_platform_vmstate = {
 static Property vfio_platform_dev_properties[] = {
     DEFINE_PROP_STRING("host", VFIOPlatformDevice, vbasedev.name),
     DEFINE_PROP_STRING("sysfsdev", VFIOPlatformDevice, vbasedev.sysfsdev),
+    DEFINE_PROP_STRING("manufacturer", VFIOPlatformDevice, manufacturer),
+    DEFINE_PROP_STRING("model", VFIOPlatformDevice, model),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPlatformDevice, vbasedev.no_mmap, false),
     DEFINE_PROP_UINT32("mmap-timeout-ms", VFIOPlatformDevice,
                        mmap_timeout, 1100),
@@ -704,7 +719,6 @@ static const TypeInfo vfio_platform_dev_info = {
     .instance_size = sizeof(VFIOPlatformDevice),
     .class_init = vfio_platform_class_init,
     .class_size = sizeof(VFIOPlatformDeviceClass),
-    .abstract   = true,
 };
 
 static void register_vfio_platform_dev_type(void)
diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
index 9baaa2db..31b9a98 100644
--- a/include/hw/vfio/vfio-platform.h
+++ b/include/hw/vfio/vfio-platform.h
@@ -55,6 +55,8 @@ typedef struct VFIOPlatformDevice {
     /* queue of pending IRQs */
     QSIMPLEQ_HEAD(pending_intp_queue, VFIOINTp) pending_intp_queue;
     char *compat; /* compatibility string */
+    char *manufacturer; /* manufacturer (1st part of the compatible property) */
+    char *model; /* model (2d part of the compatible property) */
     uint32_t mmap_timeout; /* delay to re-enable mmaps after interrupt */
     QEMUTimer *mmap_timer; /* allows fast-path resume after IRQ hit */
     QemuMutex intp_mutex; /* protect the intp_list IRQ state */
-- 
2.5.5
