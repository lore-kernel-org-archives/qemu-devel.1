Received: from eggs.gnu.org ([2001:4830:134:3::10]:57289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ9-0002Ka-Ap
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ8-0005aY-FJ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:05 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42835
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvgQ8-0005a0-8v
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:04 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  5 Apr 2017 09:35:23 +0100
Message-Id: <1491381329-3995-9-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 08/14] tcx: alter tcx24_reset_dirty() to accept
 address and length parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org

This can now be used by both the 8-bit and 24-bit display code, so rename
to tcx_check_dirty().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/tcx.c |   31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 171236a..e9056e0 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -123,22 +123,16 @@ static int tcx_check_dirty(TCXState *s, ram_addr_t addr, int len)
     return ret;
 }
 
-static inline void tcx24_reset_dirty(TCXState *ts, ram_addr_t page_min,
-                               ram_addr_t page_max, ram_addr_t page24,
-                              ram_addr_t cpage)
+static void tcx_reset_dirty(TCXState *s, ram_addr_t addr, int len)
 {
-    memory_region_reset_dirty(&ts->vram_mem,
-                              page_min,
-                              (page_max - page_min) + TARGET_PAGE_SIZE,
-                              DIRTY_MEMORY_VGA);
-    memory_region_reset_dirty(&ts->vram_mem,
-                              page24 + page_min * 4,
-                              (page_max - page_min) * 4 + TARGET_PAGE_SIZE,
-                              DIRTY_MEMORY_VGA);
-    memory_region_reset_dirty(&ts->vram_mem,
-                              cpage + page_min * 4,
-                              (page_max - page_min) * 4 + TARGET_PAGE_SIZE,
-                              DIRTY_MEMORY_VGA);
+    memory_region_reset_dirty(&s->vram_mem, addr, len, DIRTY_MEMORY_VGA);
+
+    if (s->depth == 24) {
+        memory_region_reset_dirty(&s->vram_mem, s->vram24_offset + addr * 4,
+                                  len * 4, DIRTY_MEMORY_VGA);
+        memory_region_reset_dirty(&s->vram_mem, s->cplane_offset + addr * 4,
+                                  len * 4, DIRTY_MEMORY_VGA);
+    }
 }
 
 static void update_palette_entries(TCXState *s, int start, int end)
@@ -428,10 +422,7 @@ static void tcx_update_display(void *opaque)
     }
     /* reset modified pages */
     if (page_max >= page_min) {
-        memory_region_reset_dirty(&ts->vram_mem,
-                                  page_min,
-                                  (page_max - page_min) + TARGET_PAGE_SIZE,
-                                  DIRTY_MEMORY_VGA);
+        tcx_reset_dirty(ts, page_min, page_max - page_min);
     }
 }
 
@@ -528,7 +519,7 @@ static void tcx24_update_display(void *opaque)
     }
     /* reset modified pages */
     if (page_max >= page_min) {
-        tcx24_reset_dirty(ts, page_min, page_max, page24, cpage);
+        tcx_reset_dirty(ts, page_min, page_max - page_min);
     }
 }
 
-- 
1.7.10.4
