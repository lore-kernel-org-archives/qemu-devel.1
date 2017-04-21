Received: from eggs.gnu.org ([2001:4830:134:3::10]:38487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d1Um4-0006Lo-2Z
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d1Um1-0003DI-B7
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:22:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d1Um1-0003D4-2P
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:22:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1ABC4680EC
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 09:22:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 21 Apr 2017 11:22:34 +0200
Message-Id: <20170421092234.8368-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] qxl: add xres and yres properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Add properties for the default display resolution, pass
on that information to the guest so the driver can use it.

Also move up qxl_crc32() function so we don't need a
forward declaration.

Additionally guest driver updates are needed so the
guest driver will actually pick this up, which will
probably land in linux kernel 4.12.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.h |  2 ++
 hw/display/qxl.c | 34 ++++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 77e5a36dc5..f6556adb73 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -119,6 +119,8 @@ typedef struct PCIQXLDevice {
     uint32_t          vram_size_mb;
     uint32_t          vram32_size_mb;
     uint32_t          vgamem_size_mb;
+    uint32_t          xres;
+    uint32_t          yres;
 
     /* qxl_render_update state */
     int                render_update_cookie_num;
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 9feae78e4e..4d94cecd72 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -305,6 +305,16 @@ void qxl_spice_reset_cursor(PCIQXLDevice *qxl)
     qxl->ssd.cursor = cursor_builtin_hidden();
 }
 
+static uint32_t qxl_crc32(const uint8_t *p, unsigned len)
+{
+    /*
+     * zlib xors the seed with 0xffffffff, and xors the result
+     * again with 0xffffffff; Both are not done with linux's crc32,
+     * which we want to be compatible with, so undo that.
+     */
+    return crc32(0xffffffff, p, len) ^ 0xffffffff;
+}
+
 static ram_addr_t qxl_rom_size(void)
 {
 #define QXL_REQUIRED_SZ (sizeof(QXLRom) + sizeof(QXLModes) + sizeof(qxl_modes))
@@ -369,6 +379,18 @@ static void init_qxl_rom(PCIQXLDevice *d)
     rom->num_pages          = cpu_to_le32(num_pages);
     rom->ram_header_offset  = cpu_to_le32(d->vga.vram_size - ram_header_size);
 
+    if (d->xres && d->yres) {
+        /* needs linux kernel 4.12+ to work */
+        rom->client_monitors_config.count = 1;
+        rom->client_monitors_config.heads[0].left = 0;
+        rom->client_monitors_config.heads[0].top = 0;
+        rom->client_monitors_config.heads[0].right = cpu_to_le32(d->xres);
+        rom->client_monitors_config.heads[0].bottom = cpu_to_le32(d->yres);
+        rom->client_monitors_config_crc = qxl_crc32(
+            (const uint8_t *)&rom->client_monitors_config,
+            sizeof(rom->client_monitors_config));
+    }
+
     d->shadow_rom = *rom;
     d->rom        = rom;
     d->modes      = modes;
@@ -1011,16 +1033,6 @@ static void interface_set_client_capabilities(QXLInstance *sin,
     qxl_send_events(qxl, QXL_INTERRUPT_CLIENT);
 }
 
-static uint32_t qxl_crc32(const uint8_t *p, unsigned len)
-{
-    /*
-     * zlib xors the seed with 0xffffffff, and xors the result
-     * again with 0xffffffff; Both are not done with linux's crc32,
-     * which we want to be compatible with, so undo that.
-     */
-    return crc32(0xffffffff, p, len) ^ 0xffffffff;
-}
-
 static bool qxl_rom_monitors_config_changed(QXLRom *rom,
         VDAgentMonitorsConfig *monitors_config,
         unsigned int max_outputs)
@@ -2397,6 +2409,8 @@ static Property qxl_properties[] = {
 #if SPICE_SERVER_VERSION >= 0x000c06 /* release 0.12.6 */
         DEFINE_PROP_UINT16("max_outputs", PCIQXLDevice, max_outputs, 0),
 #endif
+        DEFINE_PROP_UINT32("xres", PCIQXLDevice, xres, 0),
+        DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
         DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.3
