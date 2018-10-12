Received: from eggs.gnu.org ([2001:4830:134:3::10]:35421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAvtC-00017z-0C
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAvt8-0003Vx-Oh
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:45:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAvt8-0003RF-Fz
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:45:50 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Oct 2018 13:45:40 +0200
Message-Id: <20181012114540.27829-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] qxl: store channel id in qxl->id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org

See qemu_spice_add_display_interface(), the console index is also used
as channel id.  So put that into the qxl->id field too.

In typical use cases (one primary qxl-vga device, optionally one or more
secondary qxl devices, no non-qxl display devices) this doesn't change
anything.

With this in place the qxl->id can not be used any more to figure
whenever a given device is primary (with vga compat mode) or secondary.
So add a bool to track this.

Cc: spice-devel@lists.freedesktop.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.h |  1 +
 hw/display/qxl.c | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index dd9c0522b7..6f9d1f21fa 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -34,6 +34,7 @@ typedef struct PCIQXLDevice {
     PortioList         vga_port_list;
     SimpleSpiceDisplay ssd;
     int                id;
+    bool               have_vga;
     uint32_t           debug;
     uint32_t           guestdebug;
     uint32_t           cmdlog;
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index e628cf1286..545c4370bd 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -848,7 +848,7 @@ static int interface_get_cursor_command(QXLInstance *sin, struct QXLCommandExt *
         qxl->guest_primary.commands++;
         qxl_track_command(qxl, ext);
         qxl_log_command(qxl, "csr", ext);
-        if (qxl->id == 0) {
+        if (qxl->have_vga) {
             qxl_render_cursor(qxl, ext);
         }
         trace_qxl_ring_cursor_get(qxl->id, qxl_mode_to_string(qxl->mode));
@@ -1255,7 +1255,7 @@ static void qxl_soft_reset(PCIQXLDevice *d)
     d->current_async = QXL_UNDEFINED_IO;
     qemu_mutex_unlock(&d->async_lock);
 
-    if (d->id == 0) {
+    if (d->have_vga) {
         qxl_enter_vga_mode(d);
     } else {
         d->mode = QXL_MODE_UNDEFINED;
@@ -2139,7 +2139,7 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
 
     memory_region_init_io(&qxl->io_bar, OBJECT(qxl), &qxl_io_ops, qxl,
                           "qxl-ioports", io_size);
-    if (qxl->id == 0) {
+    if (qxl->have_vga) {
         vga_dirty_log_start(&qxl->vga);
     }
     memory_region_set_flush_coalesced(&qxl->io_bar);
@@ -2171,7 +2171,7 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
 
     /* print pci bar details */
     dprint(qxl, 1, "ram/%s: %" PRId64 " MB [region 0]\n",
-           qxl->id == 0 ? "pri" : "sec", qxl->vga.vram_size / MiB);
+           qxl->have_vga ? "pri" : "sec", qxl->vga.vram_size / MiB);
     dprint(qxl, 1, "vram/32: %" PRIx64 " MB [region 1]\n",
            qxl->vram32_size / MiB);
     dprint(qxl, 1, "vram/64: %" PRIx64 " MB %s\n",
@@ -2199,7 +2199,6 @@ static void qxl_realize_primary(PCIDevice *dev, Error **errp)
     VGACommonState *vga = &qxl->vga;
     Error *local_err = NULL;
 
-    qxl->id = 0;
     qxl_init_ramsize(qxl);
     vga->vbe_size = qxl->vgamem_size;
     vga->vram_size_mb = qxl->vga.vram_size / MiB;
@@ -2210,8 +2209,15 @@ static void qxl_realize_primary(PCIDevice *dev, Error **errp)
                      vga, "vga");
     portio_list_set_flush_coalesced(&qxl->vga_port_list);
     portio_list_add(&qxl->vga_port_list, pci_address_space_io(dev), 0x3b0);
+    qxl->have_vga = true;
 
     vga->con = graphic_console_init(DEVICE(dev), 0, &qxl_ops, qxl);
+    qxl->id = qemu_console_get_index(vga->con); /* == channel_id */
+    if (qxl->id != 0) {
+        error_setg(errp, "primary qxl-vga device must be console 0 "
+                   "(first display device on the command line)");
+        return;
+    }
 
     qxl_realize_common(qxl, &local_err);
     if (local_err) {
@@ -2226,15 +2232,14 @@ static void qxl_realize_primary(PCIDevice *dev, Error **errp)
 
 static void qxl_realize_secondary(PCIDevice *dev, Error **errp)
 {
-    static int device_id = 1;
     PCIQXLDevice *qxl = PCI_QXL(dev);
 
-    qxl->id = device_id++;
     qxl_init_ramsize(qxl);
     memory_region_init_ram(&qxl->vga.vram, OBJECT(dev), "qxl.vgavram",
                            qxl->vga.vram_size, &error_fatal);
     qxl->vga.vram_ptr = memory_region_get_ram_ptr(&qxl->vga.vram);
     qxl->vga.con = graphic_console_init(DEVICE(dev), 0, &qxl_ops, qxl);
+    qxl->id = qemu_console_get_index(qxl->vga.con); /* == channel_id */
 
     qxl_realize_common(qxl, errp);
 }
-- 
2.9.3
