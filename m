Received: from eggs.gnu.org ([2001:4830:134:3::10]:44615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter@lekensteyn.nl>) id 1fwqFg-0004Od-1Y
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter@lekensteyn.nl>) id 1fwqFe-0002ZS-Op
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:54:51 -0400
Received: from mail.lekensteyn.nl ([2a02:2308::360:1:25]:56663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter@lekensteyn.nl>) id 1fwqFe-0002W4-Dr
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:54:50 -0400
From: Peter Wu <peter@lekensteyn.nl>
Date: Mon,  3 Sep 2018 16:54:47 +0200
Message-Id: <20180903145447.17142-1-peter@lekensteyn.nl>
Subject: [Qemu-devel] [PATCH] qxl: support mono cursors with inverted colors
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

Monochrome cursors are still used by Windows guests with the
QXL-WDDM-DOD driver. Such cursor types have one odd feature, inversion
of colors. GDK does not seem to support it, so implement an alternative
solution: fill the inverted pixels and add an outline to make the cursor
more visible. Tested with the text cursor in Notepad and Windows 10.

cursor_set_mono is also used by the vmware GPU, so add a special check
to avoid breaking its 32bpp format (tested with Kubuntu 14.04.4). I was
unable to find a guest which supports the 1bpp format with a vmware GPU.

The old implementation was buggy and removed in v2.10.0-108-g79c5a10cdd
("qxl: drop mono cursor support"), this version improves upon that by
adding bounds validation, clarifying the semantics of the two masks and
adds a workaround for inverted colors support.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1611984
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 hw/display/qxl-render.c | 16 ++++++++++++++++
 ui/cursor.c             | 42 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index c62b9a5e75..b82501ea9a 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -234,12 +234,28 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
                               uint32_t group_id)
 {
     QEMUCursor *c;
+    uint8_t *and_mask, *xor_mask;
     size_t size;
 
     c = cursor_alloc(cursor->header.width, cursor->header.height);
     c->hot_x = cursor->header.hot_spot_x;
     c->hot_y = cursor->header.hot_spot_y;
     switch (cursor->header.type) {
+    case SPICE_CURSOR_TYPE_MONO:
+        /* Assume that the full cursor is available in a single chunk. */
+        size = 2 * cursor_get_mono_bpl(c) * c->height;
+        if (size != cursor->data_size) {
+            fprintf(stderr, "%s: bad monochrome cursor %ux%u with size %u\n",
+                    __func__, c->width, c->height, cursor->data_size);
+            goto fail;
+        }
+        and_mask = cursor->chunk.data;
+        xor_mask = and_mask + cursor_get_mono_bpl(c) * c->height;
+        cursor_set_mono(c, 0xffffff, 0x000000, xor_mask, 1, and_mask);
+        if (qxl->debug > 2) {
+            cursor_print_ascii_art(c, "qxl/mono");
+        }
+        break;
     case SPICE_CURSOR_TYPE_ALPHA:
         size = sizeof(uint32_t) * cursor->header.width * cursor->header.height;
         qxl_unpack_chunks(c->data, size, qxl, &cursor->chunk, group_id);
diff --git a/ui/cursor.c b/ui/cursor.c
index f3da0cee79..836bfb847f 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -128,13 +128,25 @@ void cursor_set_mono(QEMUCursor *c,
     uint32_t *data = c->data;
     uint8_t bit;
     int x,y,bpl;
-
+    bool expand_bitmap_only = image == mask;
+    bool has_inverted_colors = false;
+    const uint32_t inverted = 0x80000000;
+
+    /*
+     * Converts a monochrome bitmap with XOR mask 'image' and AND mask 'mask':
+     * https://docs.microsoft.com/en-us/windows-hardware/drivers/display/drawing-monochrome-pointers
+     */
     bpl = cursor_get_mono_bpl(c);
     for (y = 0; y < c->height; y++) {
         bit = 0x80;
         for (x = 0; x < c->width; x++, data++) {
             if (transparent && mask[x/8] & bit) {
-                *data = 0x00000000;
+                if (!expand_bitmap_only && image[x/8] & bit) {
+                    *data = inverted;
+                    has_inverted_colors = true;
+                } else {
+                    *data = 0x00000000;
+                }
             } else if (!transparent && !(mask[x/8] & bit)) {
                 *data = 0x00000000;
             } else if (image[x/8] & bit) {
@@ -150,6 +162,32 @@ void cursor_set_mono(QEMUCursor *c,
         mask  += bpl;
         image += bpl;
     }
+
+    /*
+     * If there are any pixels with inverted colors, create an outline (fill
+     * transparent neighbors with the background color) and use the foreground
+     * color as "inverted" color.
+     */
+    if (has_inverted_colors) {
+        data = c->data;
+        for (y = 0; y < c->height; y++) {
+            for (x = 0; x < c->width; x++, data++) {
+                if (*data == 0 /* transparent */ &&
+                        ((x > 0 && data[-1] == inverted) ||
+                         (x + 1 < c->width && data[1] == inverted) ||
+                         (y > 0 && data[-c->width] == inverted) ||
+                         (y + 1 < c->height && data[c->width] == inverted))) {
+                    *data = 0xff000000 | background;
+                }
+            }
+        }
+        data = c->data;
+        for (x = 0; x < c->width * c->height; x++, data++) {
+            if (*data == inverted) {
+                *data = 0xff000000 | foreground;
+            }
+        }
+    }
 }
 
 void cursor_get_mono_image(QEMUCursor *c, int foreground, uint8_t *image)
-- 
2.18.0
