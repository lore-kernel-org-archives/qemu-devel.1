Received: from eggs.gnu.org ([2001:4830:134:3::10]:53880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiK-0002qj-E2
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiI-0004T1-Ol
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgIiI-0004SQ-Hf
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:14 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8C607FB63
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 22:15:14 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 23:14:57 +0100
Message-Id: <1487715299-21102-8-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 7/9] qxl: use graphic_* variables.
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

If graphic_* variables are set (via -g switch), pass on
that information to the guest so the driver can use it.

Also move up qxl_crc32() function so we don't need a
forward declaration.

Additionally guest driver updates are needed so the
guest driver will actually pick this up, which will
probably land in linux kernel 4.12.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index af4c0ca..37c84a8 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -304,6 +304,16 @@ void qxl_spice_reset_cursor(PCIQXLDevice *qxl)
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
@@ -368,6 +378,18 @@ static void init_qxl_rom(PCIQXLDevice *d)
     rom->num_pages          = cpu_to_le32(num_pages);
     rom->ram_header_offset  = cpu_to_le32(d->vga.vram_size - ram_header_size);
 
+    if (graphic_width && graphic_height) {
+        /* needs linux kernel 4.12+ to work */
+        rom->client_monitors_config.count = 1;
+        rom->client_monitors_config.heads[0].left = 0;
+        rom->client_monitors_config.heads[0].top = 0;
+        rom->client_monitors_config.heads[0].right = cpu_to_le32(graphic_width);
+        rom->client_monitors_config.heads[0].bottom = cpu_to_le32(graphic_height);
+        rom->client_monitors_config_crc = qxl_crc32(
+            (const uint8_t *)&rom->client_monitors_config,
+            sizeof(rom->client_monitors_config));
+    }
+
     d->shadow_rom = *rom;
     d->rom        = rom;
     d->modes      = modes;
@@ -981,16 +1003,6 @@ static void interface_set_client_capabilities(QXLInstance *sin,
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
-- 
1.8.3.1
