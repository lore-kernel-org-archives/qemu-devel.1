Received: from eggs.gnu.org ([2001:4830:134:3::10]:36822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxr-0000cu-PK
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxq-0008Q2-Cj
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:47 -0500
Received: from mail.kernel.org ([198.145.29.136]:56848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxq-0008OW-2y
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:46 -0500
Date: Thu, 19 Jan 2017 23:09:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484860116-25361-12-git-send-email-mst@redhat.com>
References: <1484860116-25361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484860116-25361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 11/17] virtio-mmio: switch to linux headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Switch to virtio_mmio.h from Linux - will make it
easier to implement virtio 1.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mmio.c | 95 +++++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 58 deletions(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 60654dc..5807aa8 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "standard-headers/linux/virtio_mmio.h"
 #include "hw/sysbus.h"
 #include "hw/virtio/virtio.h"
 #include "qemu/host-utils.h"
@@ -52,28 +53,6 @@ do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
 #define VIRTIO_MMIO(obj) \
         OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
 
-/* Memory mapped register offsets */
-#define VIRTIO_MMIO_MAGIC 0x0
-#define VIRTIO_MMIO_VERSION 0x4
-#define VIRTIO_MMIO_DEVICEID 0x8
-#define VIRTIO_MMIO_VENDORID 0xc
-#define VIRTIO_MMIO_HOSTFEATURES 0x10
-#define VIRTIO_MMIO_HOSTFEATURESSEL 0x14
-#define VIRTIO_MMIO_GUESTFEATURES 0x20
-#define VIRTIO_MMIO_GUESTFEATURESSEL 0x24
-#define VIRTIO_MMIO_GUESTPAGESIZE 0x28
-#define VIRTIO_MMIO_QUEUESEL 0x30
-#define VIRTIO_MMIO_QUEUENUMMAX 0x34
-#define VIRTIO_MMIO_QUEUENUM 0x38
-#define VIRTIO_MMIO_QUEUEALIGN 0x3c
-#define VIRTIO_MMIO_QUEUEPFN 0x40
-#define VIRTIO_MMIO_QUEUENOTIFY 0x50
-#define VIRTIO_MMIO_INTERRUPTSTATUS 0x60
-#define VIRTIO_MMIO_INTERRUPTACK 0x64
-#define VIRTIO_MMIO_STATUS 0x70
-/* Device specific config space starts here */
-#define VIRTIO_MMIO_CONFIG 0x100
-
 #define VIRT_MAGIC 0x74726976 /* 'virt' */
 #define VIRT_VERSION 1
 #define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
@@ -104,10 +83,10 @@ static int virtio_mmio_ioeventfd_assign(DeviceState *d,
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
 
     if (assign) {
-        memory_region_add_eventfd(&proxy->iomem, VIRTIO_MMIO_QUEUENOTIFY, 4,
+        memory_region_add_eventfd(&proxy->iomem, VIRTIO_MMIO_QUEUE_NOTIFY, 4,
                                   true, n, notifier);
     } else {
-        memory_region_del_eventfd(&proxy->iomem, VIRTIO_MMIO_QUEUENOTIFY, 4,
+        memory_region_del_eventfd(&proxy->iomem, VIRTIO_MMIO_QUEUE_NOTIFY, 4,
                                   true, n, notifier);
     }
     return 0;
@@ -140,11 +119,11 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
          * device ID of zero means no backend will claim it.
          */
         switch (offset) {
-        case VIRTIO_MMIO_MAGIC:
+        case VIRTIO_MMIO_MAGIC_VALUE:
             return VIRT_MAGIC;
         case VIRTIO_MMIO_VERSION:
             return VIRT_VERSION;
-        case VIRTIO_MMIO_VENDORID:
+        case VIRTIO_MMIO_VENDOR_ID:
             return VIRT_VENDOR;
         default:
             return 0;
@@ -169,40 +148,40 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
         return 0;
     }
     switch (offset) {
-    case VIRTIO_MMIO_MAGIC:
+    case VIRTIO_MMIO_MAGIC_VALUE:
         return VIRT_MAGIC;
     case VIRTIO_MMIO_VERSION:
         return VIRT_VERSION;
-    case VIRTIO_MMIO_DEVICEID:
+    case VIRTIO_MMIO_DEVICE_ID:
         return vdev->device_id;
-    case VIRTIO_MMIO_VENDORID:
+    case VIRTIO_MMIO_VENDOR_ID:
         return VIRT_VENDOR;
-    case VIRTIO_MMIO_HOSTFEATURES:
+    case VIRTIO_MMIO_DEVICE_FEATURES:
         if (proxy->host_features_sel) {
             return 0;
         }
         return vdev->host_features;
-    case VIRTIO_MMIO_QUEUENUMMAX:
+    case VIRTIO_MMIO_QUEUE_NUM_MAX:
         if (!virtio_queue_get_num(vdev, vdev->queue_sel)) {
             return 0;
         }
         return VIRTQUEUE_MAX_SIZE;
-    case VIRTIO_MMIO_QUEUEPFN:
+    case VIRTIO_MMIO_QUEUE_PFN:
         return virtio_queue_get_addr(vdev, vdev->queue_sel)
             >> proxy->guest_page_shift;
-    case VIRTIO_MMIO_INTERRUPTSTATUS:
+    case VIRTIO_MMIO_INTERRUPT_STATUS:
         return atomic_read(&vdev->isr);
     case VIRTIO_MMIO_STATUS:
         return vdev->status;
-    case VIRTIO_MMIO_HOSTFEATURESSEL:
-    case VIRTIO_MMIO_GUESTFEATURES:
-    case VIRTIO_MMIO_GUESTFEATURESSEL:
-    case VIRTIO_MMIO_GUESTPAGESIZE:
-    case VIRTIO_MMIO_QUEUESEL:
-    case VIRTIO_MMIO_QUEUENUM:
-    case VIRTIO_MMIO_QUEUEALIGN:
-    case VIRTIO_MMIO_QUEUENOTIFY:
-    case VIRTIO_MMIO_INTERRUPTACK:
+    case VIRTIO_MMIO_DEVICE_FEATURES_SEL:
+    case VIRTIO_MMIO_DRIVER_FEATURES:
+    case VIRTIO_MMIO_DRIVER_FEATURES_SEL:
+    case VIRTIO_MMIO_GUEST_PAGE_SIZE:
+    case VIRTIO_MMIO_QUEUE_SEL:
+    case VIRTIO_MMIO_QUEUE_NUM:
+    case VIRTIO_MMIO_QUEUE_ALIGN:
+    case VIRTIO_MMIO_QUEUE_NOTIFY:
+    case VIRTIO_MMIO_INTERRUPT_ACK:
         DPRINTF("read of write-only register\n");
         return 0;
     default:
@@ -251,18 +230,18 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         return;
     }
     switch (offset) {
-    case VIRTIO_MMIO_HOSTFEATURESSEL:
+    case VIRTIO_MMIO_DEVICE_FEATURES_SEL:
         proxy->host_features_sel = value;
         break;
-    case VIRTIO_MMIO_GUESTFEATURES:
+    case VIRTIO_MMIO_DRIVER_FEATURES:
         if (!proxy->guest_features_sel) {
             virtio_set_features(vdev, value);
         }
         break;
-    case VIRTIO_MMIO_GUESTFEATURESSEL:
+    case VIRTIO_MMIO_DRIVER_FEATURES_SEL:
         proxy->guest_features_sel = value;
         break;
-    case VIRTIO_MMIO_GUESTPAGESIZE:
+    case VIRTIO_MMIO_GUEST_PAGE_SIZE:
         proxy->guest_page_shift = ctz32(value);
         if (proxy->guest_page_shift > 31) {
             proxy->guest_page_shift = 0;
@@ -270,22 +249,22 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         DPRINTF("guest page size %" PRIx64 " shift %d\n", value,
                 proxy->guest_page_shift);
         break;
-    case VIRTIO_MMIO_QUEUESEL:
+    case VIRTIO_MMIO_QUEUE_SEL:
         if (value < VIRTIO_QUEUE_MAX) {
             vdev->queue_sel = value;
         }
         break;
-    case VIRTIO_MMIO_QUEUENUM:
+    case VIRTIO_MMIO_QUEUE_NUM:
         DPRINTF("mmio_queue write %d max %d\n", (int)value, VIRTQUEUE_MAX_SIZE);
         virtio_queue_set_num(vdev, vdev->queue_sel, value);
         /* Note: only call this function for legacy devices */
         virtio_queue_update_rings(vdev, vdev->queue_sel);
         break;
-    case VIRTIO_MMIO_QUEUEALIGN:
+    case VIRTIO_MMIO_QUEUE_ALIGN:
         /* Note: this is only valid for legacy devices */
         virtio_queue_set_align(vdev, vdev->queue_sel, value);
         break;
-    case VIRTIO_MMIO_QUEUEPFN:
+    case VIRTIO_MMIO_QUEUE_PFN:
         if (value == 0) {
             virtio_reset(vdev);
         } else {
@@ -293,12 +272,12 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
                                   value << proxy->guest_page_shift);
         }
         break;
-    case VIRTIO_MMIO_QUEUENOTIFY:
+    case VIRTIO_MMIO_QUEUE_NOTIFY:
         if (value < VIRTIO_QUEUE_MAX) {
             virtio_queue_notify(vdev, value);
         }
         break;
-    case VIRTIO_MMIO_INTERRUPTACK:
+    case VIRTIO_MMIO_INTERRUPT_ACK:
         atomic_and(&vdev->isr, ~value);
         virtio_update_irq(vdev);
         break;
@@ -317,13 +296,13 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
             virtio_reset(vdev);
         }
         break;
-    case VIRTIO_MMIO_MAGIC:
+    case VIRTIO_MMIO_MAGIC_VALUE:
     case VIRTIO_MMIO_VERSION:
-    case VIRTIO_MMIO_DEVICEID:
-    case VIRTIO_MMIO_VENDORID:
-    case VIRTIO_MMIO_HOSTFEATURES:
-    case VIRTIO_MMIO_QUEUENUMMAX:
-    case VIRTIO_MMIO_INTERRUPTSTATUS:
+    case VIRTIO_MMIO_DEVICE_ID:
+    case VIRTIO_MMIO_VENDOR_ID:
+    case VIRTIO_MMIO_DEVICE_FEATURES:
+    case VIRTIO_MMIO_QUEUE_NUM_MAX:
+    case VIRTIO_MMIO_INTERRUPT_STATUS:
         DPRINTF("write to readonly register\n");
         break;
 
-- 
MST
