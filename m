Received: from eggs.gnu.org ([2001:4830:134:3::10]:54425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1TwY-0008UP-Lx
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1TwV-0001Yc-2e
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:30 -0400
Received: from chuckie.co.uk ([82.165.15.123]:50169
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1TwU-0001YU-Rc
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:27 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 21 Apr 2017 09:28:42 +0100
Message-Id: <1492763327-12742-9-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 08/13] tcx: remove page24 and cpage from
 tcx24_update_display()
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

Since all of the tcx_*_dirty() functions now calculate the 24-bit and
cplane offsets themselves from the base address, these variables are no
longer needed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/tcx.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index e9056e0..4f4f03f 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -430,7 +430,7 @@ static void tcx24_update_display(void *opaque)
 {
     TCXState *ts = opaque;
     DisplaySurface *surface = qemu_console_surface(ts->con);
-    ram_addr_t page, page_min, page_max, cpage, page24;
+    ram_addr_t page, page_min, page_max;
     int y, y_start, dd, ds;
     uint8_t *d, *s;
     uint32_t *cptr, *s24;
@@ -440,8 +440,6 @@ static void tcx24_update_display(void *opaque)
     }
 
     page = 0;
-    page24 = ts->vram24_offset;
-    cpage = ts->cplane_offset;
     y_start = -1;
     page_min = -1;
     page_max = 0;
@@ -453,8 +451,7 @@ static void tcx24_update_display(void *opaque)
     ds = 1024;
 
     memory_region_sync_dirty_bitmap(&ts->vram_mem);
-    for (y = 0; y < ts->height; page += TARGET_PAGE_SIZE,
-            page24 += TARGET_PAGE_SIZE, cpage += TARGET_PAGE_SIZE) {
+    for (y = 0; y < ts->height; page += TARGET_PAGE_SIZE) {
         if (tcx_check_dirty(ts, page, TARGET_PAGE_SIZE)) {
             if (y_start < 0)
                 y_start = y;
-- 
1.7.10.4
