Received: from eggs.gnu.org ([2001:4830:134:3::10]:36821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2Iu-00058W-UV
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2Is-0003LN-FI
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds2Is-0003Ip-9p
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 575147E426
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:41:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 09:41:38 +0200
Message-Id: <20170913074140.5160-5-kraxel@redhat.com>
In-Reply-To: <20170913074140.5160-1-kraxel@redhat.com>
References: <20170913074140.5160-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] qxl: add support for chunked cursors.
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170828123933.30323-3-kraxel@redhat.com
---
 hw/display/qxl-render.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index e1b3f05ecb..90e0865618 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -204,7 +204,33 @@ void qxl_render_update_area_done(PCIQXLDevice *qxl, QXLCookie *cookie)
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
+        if (offset == size) {
+            return;
+        }
+        chunk = qxl_phys2virt(qxl, chunk->next_chunk, group_id);
+        if (!chunk) {
+            return;
+        }
+        max_chunks--;
+        if (max_chunks == 0) {
+            return;
+        }
+    }
+}
+
+static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
+                              uint32_t group_id)
 {
     QEMUCursor *c;
     size_t size;
@@ -215,7 +241,7 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor)
     switch (cursor->header.type) {
     case SPICE_CURSOR_TYPE_ALPHA:
         size = sizeof(uint32_t) * cursor->header.width * cursor->header.height;
-        memcpy(c->data, cursor->chunk.data, size);
+        qxl_unpack_chunks(c->data, size, qxl, &cursor->chunk, group_id);
         if (qxl->debug > 2) {
             cursor_print_ascii_art(c, "qxl/alpha");
         }
@@ -259,11 +285,7 @@ int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext)
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
