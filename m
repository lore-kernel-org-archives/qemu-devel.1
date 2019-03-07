Received: from eggs.gnu.org ([209.51.188.92]:40592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1nzU-0004aP-00
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1nzS-0002Pq-4w
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:02:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1nzQ-0002Nx-6Z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:02:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E2A88763A
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 08:02:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 09:02:43 +0100
Message-Id: <20190307080244.9011-3-kraxel@redhat.com>
In-Reply-To: <20190307080244.9011-1-kraxel@redhat.com>
References: <20190307080244.9011-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] virtio-vga: fix reset.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Store reset handler of the parent class and just call that for a
complete virtio reset.  When taking the shortcut and calling
virtio_gpu_reset() directly the generic virtio reset code (for
virtqueues etc) will not be executed.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1597621
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-vga.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 1e48009b74a6..a2b803b75f94 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -12,6 +12,10 @@
 #define TYPE_VIRTIO_VGA "virtio-vga"
 #define VIRTIO_VGA(obj) \
         OBJECT_CHECK(VirtIOVGA, (obj), TYPE_VIRTIO_VGA)
+#define VIRTIO_VGA_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(VirtIOVGAClass, obj, TYPE_VIRTIO_VGA)
+#define VIRTIO_VGA_CLASS(klass) \
+        OBJECT_CLASS_CHECK(VirtIOVGAClass, klass, TYPE_VIRTIO_VGA)
 
 typedef struct VirtIOVGA {
     VirtIOPCIProxy parent_obj;
@@ -20,6 +24,11 @@ typedef struct VirtIOVGA {
     MemoryRegion   vga_mrs[3];
 } VirtIOVGA;
 
+typedef struct VirtIOVGAClass {
+    VirtioPCIClass parent_class;
+    DeviceReset parent_reset;
+} VirtIOVGAClass;
+
 static void virtio_vga_invalidate_display(void *opaque)
 {
     VirtIOVGA *vvga = opaque;
@@ -168,10 +177,11 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 
 static void virtio_vga_reset(DeviceState *dev)
 {
+    VirtIOVGAClass *klass = VIRTIO_VGA_GET_CLASS(dev);
     VirtIOVGA *vvga = VIRTIO_VGA(dev);
 
     /* reset virtio-gpu */
-    virtio_gpu_reset(VIRTIO_DEVICE(&vvga->vdev));
+    klass->parent_reset(dev);
 
     /* reset vga */
     vga_common_reset(&vvga->vga);
@@ -187,13 +197,15 @@ static void virtio_vga_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    VirtIOVGAClass *v = VIRTIO_VGA_CLASS(klass);
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->props = virtio_vga_properties;
-    dc->reset = virtio_vga_reset;
     dc->vmsd = &vmstate_virtio_vga;
     dc->hotpluggable = false;
+    device_class_set_parent_reset(dc, virtio_vga_reset,
+                                  &v->parent_reset);
 
     k->realize = virtio_vga_realize;
     pcidev_k->romfile = "vgabios-virtio.bin";
@@ -212,6 +224,7 @@ static VirtioPCIDeviceTypeInfo virtio_vga_info = {
     .generic_name  = TYPE_VIRTIO_VGA,
     .instance_size = sizeof(struct VirtIOVGA),
     .instance_init = virtio_vga_inst_initfn,
+    .class_size    = sizeof(struct VirtIOVGAClass),
     .class_init    = virtio_vga_class_init,
 };
 
-- 
2.18.1
