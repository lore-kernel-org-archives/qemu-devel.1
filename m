Received: from eggs.gnu.org ([209.51.188.92]:35453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMaMo-0006Wv-4i
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMaMm-00074K-Ko
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:44:54 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hMaMm-00073Q-3H
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:44:52 -0400
Received: by mail-pl1-x642.google.com with SMTP id z8so2890200pln.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:44:51 -0700 (PDT)
From: Boxuan Li <liboxuan@connect.hku.hk>
Date: Fri,  3 May 2019 23:44:24 +0800
Message-Id: <20190503154424.73933-1-liboxuan@connect.hku.hk>
Subject: [Qemu-devel] [PATCH v4] hw/virtio/virtio-mmio: Convert DPRINTF to
 trace and log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, eblake@redhat.com, philmd@redhat.com, yuval.shaia@oracle.com, alex.bennee@linaro.org, Boxuan Li <liboxuan@connect.hku.hk>, "Michael S. Tsirkin" <mst@redhat.com>

Use traces for debug message and qemu_log_mask for errors.

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
v1: https://patchew.org/QEMU/20190428110258.86681-1-liboxuan@connect.hku.hk/
v2: https://patchew.org/QEMU/20190501081039.58938-1-liboxuan@connect.hku.hk/
v3: https://patchew.org/QEMU/20190503084654.18413-1-liboxuan@connect.hku.hk/
v4: Fix indentation and do not convert uint64_t to int
---
 hw/virtio/trace-events  |  7 +++++++
 hw/virtio/virtio-mmio.c | 44 +++++++++++++++++++++-----------------------
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 60c649c4bc..e28ba48da6 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -46,3 +46,10 @@ virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s g
 virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
 virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
 virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: 0x%"PRIx64" num_pages: %d"
+
+# virtio-mmio.c
+virtio_mmio_read(uint64_t offset) "virtio_mmio_read offset 0x%" PRIx64
+virtio_mmio_write_offset(uint64_t offset, uint64_t value) "virtio_mmio_write offset 0x%" PRIx64 " value 0x%" PRIx64
+virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%" PRIx64 " shift %d"
+virtio_mmio_queue_write(uint64_t value, int max_size) "mmio_queue write 0x%" PRIx64 " max %d"
+virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 5807aa87fe..96c762f0bf 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -27,16 +27,8 @@
 #include "sysemu/kvm.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qemu/error-report.h"
-
-/* #define DEBUG_VIRTIO_MMIO */
-
-#ifdef DEBUG_VIRTIO_MMIO
-
-#define DPRINTF(fmt, ...) \
-do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#include "qemu/log.h"
+#include "trace.h"
 
 /* QOM macros */
 /* virtio-mmio-bus */
@@ -107,7 +99,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
     VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
-    DPRINTF("virtio_mmio_read offset 0x%x\n", (int)offset);
+    trace_virtio_mmio_read(offset);
 
     if (!vdev) {
         /* If no backend is present, we treat most registers as
@@ -144,7 +136,9 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
         }
     }
     if (size != 4) {
-        DPRINTF("wrong size access to register!\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: wrong size access to register!\n",
+                      __func__);
         return 0;
     }
     switch (offset) {
@@ -182,10 +176,12 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
     case VIRTIO_MMIO_QUEUE_ALIGN:
     case VIRTIO_MMIO_QUEUE_NOTIFY:
     case VIRTIO_MMIO_INTERRUPT_ACK:
-        DPRINTF("read of write-only register\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read of write-only register\n",
+                      __func__);
         return 0;
     default:
-        DPRINTF("bad register offset\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n", __func__);
         return 0;
     }
     return 0;
@@ -197,8 +193,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
     VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
-    DPRINTF("virtio_mmio_write offset 0x%x value 0x%" PRIx64 "\n",
-            (int)offset, value);
+    trace_virtio_mmio_write_offset(offset, value);
 
     if (!vdev) {
         /* If no backend is present, we just make all registers
@@ -226,7 +221,9 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         return;
     }
     if (size != 4) {
-        DPRINTF("wrong size access to register!\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: wrong size access to register!\n",
+                      __func__);
         return;
     }
     switch (offset) {
@@ -246,8 +243,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         if (proxy->guest_page_shift > 31) {
             proxy->guest_page_shift = 0;
         }
-        DPRINTF("guest page size %" PRIx64 " shift %d\n", value,
-                proxy->guest_page_shift);
+        trace_virtio_mmio_guest_page(value, proxy->guest_page_shift);
         break;
     case VIRTIO_MMIO_QUEUE_SEL:
         if (value < VIRTIO_QUEUE_MAX) {
@@ -255,7 +251,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         }
         break;
     case VIRTIO_MMIO_QUEUE_NUM:
-        DPRINTF("mmio_queue write %d max %d\n", (int)value, VIRTQUEUE_MAX_SIZE);
+        trace_virtio_mmio_queue_write(value, VIRTQUEUE_MAX_SIZE);
         virtio_queue_set_num(vdev, vdev->queue_sel, value);
         /* Note: only call this function for legacy devices */
         virtio_queue_update_rings(vdev, vdev->queue_sel);
@@ -303,11 +299,13 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
     case VIRTIO_MMIO_DEVICE_FEATURES:
     case VIRTIO_MMIO_QUEUE_NUM_MAX:
     case VIRTIO_MMIO_INTERRUPT_STATUS:
-        DPRINTF("write to readonly register\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to readonly register\n",
+                      __func__);
         break;
 
     default:
-        DPRINTF("bad register offset\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n", __func__);
     }
 }
 
@@ -327,7 +325,7 @@ static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
         return;
     }
     level = (atomic_read(&vdev->isr) != 0);
-    DPRINTF("virtio_mmio setting IRQ %d\n", level);
+    trace_virtio_mmio_setting_irq(level);
     qemu_set_irq(proxy->irq, level);
 }
 
-- 
2.13.2
