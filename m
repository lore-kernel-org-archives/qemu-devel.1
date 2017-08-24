Received: from eggs.gnu.org ([2001:4830:134:3::10]:58022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dknGL-0004Sy-V5
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dknGI-0002iT-P9
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:13:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dknGI-0002i4-Ik
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:13:10 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Aug 2017 10:13:05 +0200
Message-Id: <20170824081305.8445-3-kraxel@redhat.com>
In-Reply-To: <20170824081305.8445-1-kraxel@redhat.com>
References: <20170824081305.8445-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qxl: add support for chunked cursors.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl-render.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index e1b3f05ecb..b2c98f90c0 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -204,7 +204,30 @@ void qxl_render_update_area_done(PCIQXLDevice *qxl, QXLCookie *cookie)
     g_free(cookie);
 }
 
-static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor)
+static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
+                              QXLDataChunk *chunk, uint32_t group_id)
+{
+    uint32_t max_chunks = 32;
+    size_t offset = 0;
+    size_t bytes;
+
+    for (;;) {
+        bytes = MIN(size - offset, chunk->data_size);
+        memcpy(dest + offset, chunk->data, bytes);
+        offset += bytes;
+        if (offset == size)
+            return;
+        chunk = qxl_phys2virt(qxl, chunk->next_chunk, group_id);
+        if (!chunk)
+            return;
+        max_chunks--;
+        if (max_chunks == 0)
+            return;
+    }
+}
+
+static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
+                              uint32_t group_id)
 {
     QEMUCursor *c;
     size_t size;
@@ -215,7 +238,7 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor)
     switch (cursor->header.type) {
     case SPICE_CURSOR_TYPE_ALPHA:
         size = sizeof(uint32_t) * cursor->header.width * cursor->header.height;
-        memcpy(c->data, cursor->chunk.data, size);
+        qxl_unpack_chunks(c->data, size, qxl, &cursor->chunk, group_id);
         if (qxl->debug > 2) {
             cursor_print_ascii_art(c, "qxl/alpha");
         }
@@ -259,11 +282,7 @@ int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext)
         if (!cursor) {
             return 1;
         }
-        if (cursor->chunk.data_size != cursor->data_size) {
-            fprintf(stderr, "%s: multiple chunks\n", __FUNCTION__);
-            return 1;
-        }
-        c = qxl_cursor(qxl, cursor);
+        c = qxl_cursor(qxl, cursor, ext->group_id);
         if (c == NULL) {
             c = cursor_builtin_left_ptr();
         }
-- 
2.9.3
