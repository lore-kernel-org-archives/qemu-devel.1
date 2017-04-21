Received: from eggs.gnu.org ([2001:4830:134:3::10]:54475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1TwZ-0008V7-LW
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1TwY-0001Zi-9f
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:31 -0400
Received: from chuckie.co.uk ([82.165.15.123]:50164
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1TwY-0001Y3-2f
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:30 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 21 Apr 2017 09:28:40 +0100
Message-Id: <1492763327-12742-7-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 06/13] tcx: alter tcx24_check_dirty() to
 accept address and length parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This can now be used by both the 8-bit and 24-bit display code, so rename
to tcx_check_dirty().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/tcx.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 6817bd2..171236a 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -105,17 +105,21 @@ static void tcx_set_dirty(TCXState *s, ram_addr_t addr, int len)
     }
 }
 
-static inline int tcx24_check_dirty(TCXState *s, ram_addr_t page,
-                                    ram_addr_t page24, ram_addr_t cpage)
+static int tcx_check_dirty(TCXState *s, ram_addr_t addr, int len)
 {
     int ret;
 
-    ret = memory_region_get_dirty(&s->vram_mem, page, TARGET_PAGE_SIZE,
-                                  DIRTY_MEMORY_VGA);
-    ret |= memory_region_get_dirty(&s->vram_mem, page24, TARGET_PAGE_SIZE * 4,
-                                   DIRTY_MEMORY_VGA);
-    ret |= memory_region_get_dirty(&s->vram_mem, cpage, TARGET_PAGE_SIZE * 4,
-                                   DIRTY_MEMORY_VGA);
+    ret = memory_region_get_dirty(&s->vram_mem, addr, len, DIRTY_MEMORY_VGA);
+
+    if (s->depth == 24) {
+        ret |= memory_region_get_dirty(&s->vram_mem,
+                                       s->vram24_offset + addr * 4, len * 4,
+                                       DIRTY_MEMORY_VGA);
+        ret |= memory_region_get_dirty(&s->vram_mem,
+                                       s->cplane_offset + addr * 4, len * 4,
+                                       DIRTY_MEMORY_VGA);
+    }
+
     return ret;
 }
 
@@ -366,8 +370,7 @@ static void tcx_update_display(void *opaque)
 
     memory_region_sync_dirty_bitmap(&ts->vram_mem);
     for (y = 0; y < ts->height; page += TARGET_PAGE_SIZE) {
-        if (memory_region_get_dirty(&ts->vram_mem, page, TARGET_PAGE_SIZE,
-                                    DIRTY_MEMORY_VGA)) {
+        if (tcx_check_dirty(ts, page, TARGET_PAGE_SIZE)) {
             if (y_start < 0)
                 y_start = y;
             if (page < page_min)
@@ -461,7 +464,7 @@ static void tcx24_update_display(void *opaque)
     memory_region_sync_dirty_bitmap(&ts->vram_mem);
     for (y = 0; y < ts->height; page += TARGET_PAGE_SIZE,
             page24 += TARGET_PAGE_SIZE, cpage += TARGET_PAGE_SIZE) {
-        if (tcx24_check_dirty(ts, page, page24, cpage)) {
+        if (tcx_check_dirty(ts, page, TARGET_PAGE_SIZE)) {
             if (y_start < 0)
                 y_start = y;
             if (page < page_min)
-- 
1.7.10.4
