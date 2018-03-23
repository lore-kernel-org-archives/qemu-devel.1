Received: from eggs.gnu.org ([2001:4830:134:3::10]:33993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ezLlL-0005pP-Cc
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ezLlK-0002Py-14
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:25:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ezLlJ-0002PR-S9
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:25:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8428A81A43A2
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 12:25:37 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Mar 2018 13:25:20 +0100
Message-Id: <20180323122520.11270-8-kraxel@redhat.com>
In-Reply-To: <20180323122520.11270-1-kraxel@redhat.com>
References: <20180323122520.11270-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/7] [wip] hw/display: add qxl-ramfb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Like qxl-vga, but using ramfb instead of legacy vga.

NOT WORKING YET.

Also: Hackish proof-of-concept, with debug msgs.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.h   |  2 ++
 hw/display/qxl.c   | 47 +++++++++++++++++++++++++++++++++++++++++++----
 ui/spice-display.c |  6 ++++++
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 089696ef62..7bfdf429bf 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -5,6 +5,7 @@
 
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "hw/display/ramfb.h"
 #include "vga_int.h"
 #include "qemu/thread.h"
 
@@ -31,6 +32,7 @@ enum qxl_mode {
 
 typedef struct PCIQXLDevice {
     PCIDevice          pci;
+    RAMFBState         *ramfb;
     PortioList         vga_port_list;
     SimpleSpiceDisplay ssd;
     int                id;
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index a71714ccb4..ebe71fbcf5 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1893,7 +1893,12 @@ static void qxl_hw_update(void *opaque)
 {
     PCIQXLDevice *qxl = opaque;
 
-    qxl_render_update(qxl);
+    if (qxl->mode == QXL_MODE_UNDEFINED &&
+        qxl->ramfb != NULL) {
+        ramfb_display_update(qxl->vga.con, qxl->ramfb);
+    } else {
+        qxl_render_update(qxl);
+    }
 }
 
 static void qxl_dirty_one_surface(PCIQXLDevice *qxl, QXLPHYSICAL pqxl,
@@ -1968,7 +1973,8 @@ static void display_update(DisplayChangeListener *dcl,
 {
     PCIQXLDevice *qxl = container_of(dcl, PCIQXLDevice, ssd.dcl);
 
-    if (qxl->mode == QXL_MODE_VGA) {
+    if (qxl->mode == QXL_MODE_VGA ||
+        (qxl->mode == QXL_MODE_UNDEFINED && qxl->ramfb)) {
         qemu_spice_display_update(&qxl->ssd, x, y, w, h);
     }
 }
@@ -1979,7 +1985,9 @@ static void display_switch(DisplayChangeListener *dcl,
     PCIQXLDevice *qxl = container_of(dcl, PCIQXLDevice, ssd.dcl);
 
     qxl->ssd.ds = surface;
-    if (qxl->mode == QXL_MODE_VGA) {
+    if (qxl->mode == QXL_MODE_VGA ||
+        (qxl->mode == QXL_MODE_UNDEFINED && qxl->ramfb)) {
+        fprintf(stderr, "%s: !native\n", __func__);
         qemu_spice_display_switch(&qxl->ssd, surface);
     }
 }
@@ -1988,7 +1996,8 @@ static void display_refresh(DisplayChangeListener *dcl)
 {
     PCIQXLDevice *qxl = container_of(dcl, PCIQXLDevice, ssd.dcl);
 
-    if (qxl->mode == QXL_MODE_VGA) {
+    if (qxl->mode == QXL_MODE_VGA ||
+        (qxl->mode == QXL_MODE_UNDEFINED && qxl->ramfb)) {
         qemu_spice_display_refresh(&qxl->ssd);
     }
 }
@@ -2204,6 +2213,19 @@ static void qxl_realize_secondary(PCIDevice *dev, Error **errp)
     qxl_realize_common(qxl, errp);
 }
 
+static void qxl_realize_ramfb(PCIDevice *dev, Error **errp)
+{
+    PCIQXLDevice *qxl = PCI_QXL(dev);
+
+    qxl_realize_secondary(dev, errp);
+    qxl_hard_reset(qxl, 0);
+
+    qxl->ramfb = ramfb_setup(errp);
+    qxl->ssd.dcl.ops = &display_listener_ops;
+    qxl->ssd.dcl.con = qxl->vga.con;
+    register_displaychangelistener(&qxl->ssd.dcl);
+}
+
 static int qxl_pre_save(void *opaque)
 {
     PCIQXLDevice* d = opaque;
@@ -2472,11 +2494,28 @@ static const TypeInfo qxl_secondary_info = {
     .class_init    = qxl_secondary_class_init,
 };
 
+static void qxl_ramfb_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = qxl_realize_ramfb;
+    k->class_id = PCI_CLASS_DISPLAY_OTHER;
+    dc->desc = "Spice QXL GPU (ramfb)";
+}
+
+static const TypeInfo qxl_ramfb_info = {
+    .name          = "qxl-ramfb",
+    .parent        = TYPE_PCI_QXL,
+    .class_init    = qxl_ramfb_class_init,
+};
+
 static void qxl_register_types(void)
 {
     type_register_static(&qxl_pci_type_info);
     type_register_static(&qxl_primary_info);
     type_register_static(&qxl_secondary_info);
+    type_register_static(&qxl_ramfb_info);
 }
 
 type_init(qxl_register_types)
diff --git a/ui/spice-display.c b/ui/spice-display.c
index fe734821dd..c8082b0649 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -86,6 +86,9 @@ void qemu_spice_create_primary_surface(SimpleSpiceDisplay *ssd, uint32_t id,
                                        QXLDevSurfaceCreate *surface,
                                        qxl_async_io async)
 {
+    fprintf(stderr, "%s: %dx%d, %lx, %s\n", __func__,
+            surface->width, surface->height, (unsigned long)surface->mem,
+            (surface->group_id == MEMSLOT_GROUP_HOST) ? "host" : "guest");
     trace_qemu_spice_create_primary_surface(ssd->qxl.id, id, surface, async);
     if (async != QXL_SYNC) {
         spice_qxl_create_primary_surface_async(&ssd->qxl, id, surface,
@@ -310,6 +313,7 @@ void qemu_spice_create_host_memslot(SimpleSpiceDisplay *ssd)
 {
     QXLDevMemSlot memslot;
 
+    fprintf(stderr, "%s:\n", __func__);
     memset(&memslot, 0, sizeof(memslot));
     memslot.slot_group_id = MEMSLOT_GROUP_HOST;
     memslot.virt_end = ~0;
@@ -343,6 +347,8 @@ void qemu_spice_create_host_primary(SimpleSpiceDisplay *ssd)
     surface.mem        = (uintptr_t)ssd->buf;
     surface.group_id   = MEMSLOT_GROUP_HOST;
 
+    fprintf(stderr, "%s: %dx%d @ %p\n", __func__,
+            surface.width, surface.height, ssd->buf);
     qemu_spice_create_primary_surface(ssd, 0, &surface, QXL_SYNC);
 }
 
-- 
2.9.3
