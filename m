Received: from eggs.gnu.org ([2001:4830:134:3::10]:42116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvj-0006ac-Rs
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvf-0007OQ-Qt
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d2cvf-0007NG-K9
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6483B5695
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 12:17:17 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Apr 2017 14:17:03 +0200
Message-Id: <20170424121708.31953-9-kraxel@redhat.com>
In-Reply-To: <20170424121708.31953-1-kraxel@redhat.com>
References: <20170424121708.31953-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 08/13] framebuffer: make display updates thread
 safe
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
Message-id: 20170421091632.30900-6-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/framebuffer.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/display/framebuffer.c b/hw/display/framebuffer.c
index 25aa46c8c7..d7310d25f2 100644
--- a/hw/display/framebuffer.c
+++ b/hw/display/framebuffer.c
@@ -67,7 +67,7 @@ void framebuffer_update_display(
     int *first_row, /* Input and output.  */
     int *last_row /* Output only */)
 {
-    hwaddr src_len;
+    DirtyBitmapSnapshot *snap;
     uint8_t *dest;
     uint8_t *src;
     int first, last = 0;
@@ -78,7 +78,6 @@ void framebuffer_update_display(
 
     i = *first_row;
     *first_row = -1;
-    src_len = (hwaddr)src_width * rows;
 
     mem = mem_section->mr;
     if (!mem) {
@@ -102,9 +101,10 @@ void framebuffer_update_display(
     src += i * src_width;
     dest += i * dest_row_pitch;
 
+    snap = memory_region_snapshot_and_clear_dirty(mem, addr, src_width * rows,
+                                                  DIRTY_MEMORY_VGA);
     for (; i < rows; i++) {
-        dirty = memory_region_get_dirty(mem, addr, src_width,
-                                             DIRTY_MEMORY_VGA);
+        dirty = memory_region_snapshot_get_dirty(mem, snap, addr, src_width);
         if (dirty || invalidate) {
             fn(opaque, dest, src, cols, dest_col_pitch);
             if (first == -1)
@@ -115,11 +115,10 @@ void framebuffer_update_display(
         src += src_width;
         dest += dest_row_pitch;
     }
+    g_free(snap);
     if (first < 0) {
         return;
     }
-    memory_region_reset_dirty(mem, mem_section->offset_within_region, src_len,
-                              DIRTY_MEMORY_VGA);
     *first_row = first;
     *last_row = last;
 }
-- 
2.9.3
