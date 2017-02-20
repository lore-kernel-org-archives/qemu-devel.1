Received: from eggs.gnu.org ([2001:4830:134:3::10]:33974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfpiD-0005hp-F6
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfpi9-0006fw-UO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:17:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cfpi9-0006fQ-Lu
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:17:09 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C65E74E33C
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 15:17:08 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Feb 2017 16:16:03 +0100
Message-Id: <1487603763-14932-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH] vga: wire up -g <width>x<height> switch
 for virtio and qxl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

FIXME: qxl not working yet.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch_init.c             |  8 ++++++--
 hw/display/qxl.c        | 18 ++++++++++++++++++
 hw/display/virtio-gpu.c |  9 +++++++--
 qemu-options.hx         |  6 ++++--
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch_init.c b/arch_init.c
index 0810116..9cd3dfc 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -34,14 +34,18 @@
 #include "hw/acpi/acpi.h"
 #include "qemu/help_option.h"
 
-#ifdef TARGET_SPARC
+#if defined(TARGET_SPARC)
 int graphic_width = 1024;
 int graphic_height = 768;
 int graphic_depth = 8;
-#else
+#elif defined(TARGET_PPC)
 int graphic_width = 800;
 int graphic_height = 600;
 int graphic_depth = 32;
+#else
+int graphic_width;
+int graphic_height;
+int graphic_depth;
 #endif
 
 
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index af4c0ca..c29ee7b 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -368,6 +368,24 @@ static void init_qxl_rom(PCIQXLDevice *d)
     rom->num_pages          = cpu_to_le32(num_pages);
     rom->ram_header_offset  = cpu_to_le32(d->vga.vram_size - ram_header_size);
 
+#if 0
+    /*
+     * FIXME:
+     *
+     * Not working that simple.  Seems the driver doesn't check this
+     * without notification.  So we have to try something more clever,
+     * and pay attention that we don't screw up the spice guest agent
+     * monitor configuration ...
+     */
+    if (graphic_width && graphic_height) {
+        rom->client_monitors_config.count = 1;
+        rom->client_monitors_config.heads[0].left = 0;
+        rom->client_monitors_config.heads[0].top = 0;
+        rom->client_monitors_config.heads[0].right = graphic_width;
+        rom->client_monitors_config.heads[0].bottom = graphic_height;
+    }
+#endif
+
     d->shadow_rom = *rom;
     d->rom        = rom;
     d->modes      = modes;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 9b530ab..04ba221 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1170,8 +1170,13 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
                 g->config_size);
 
-    g->req_state[0].width = 1024;
-    g->req_state[0].height = 768;
+    if (graphic_width && graphic_height) {
+        g->req_state[0].width = graphic_width;
+        g->req_state[0].height = graphic_height;
+    } else {
+        g->req_state[0].width = 1024;
+        g->req_state[0].height = 768;
+    }
 
     if (virtio_gpu_virgl_enabled(g->conf)) {
         /* use larger control queue in 3d mode */
diff --git a/qemu-options.hx b/qemu-options.hx
index 5633d39..734a87b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1233,11 +1233,13 @@ ETEXI
 
 DEF("g", 1, QEMU_OPTION_g ,
     "-g WxH[xDEPTH]  Set the initial graphical resolution and depth\n",
-    QEMU_ARCH_PPC | QEMU_ARCH_SPARC)
+    QEMU_ARCH_ALL)
 STEXI
 @item -g @var{width}x@var{height}[x@var{depth}]
 @findex -g
-Set the initial graphical resolution and depth (PPC, SPARC only).
+Set the initial graphical resolution and depth.
+On PPC and SPARC the firmware will configure the display accordingly.
+On other archs this is supported by virtio and qxl (FIXME) display adapters.
 ETEXI
 
 DEF("vnc", HAS_ARG, QEMU_OPTION_vnc ,
-- 
1.8.3.1
