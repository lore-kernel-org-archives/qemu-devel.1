Received: from eggs.gnu.org ([2001:4830:134:3::10]:54142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcY-00026p-LS
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcT-0002Cy-Px
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cvLcT-0002Bp-Ko
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:25 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  4 Apr 2017 12:23:13 +0200
Message-Id: <20170404102315.24923-9-kraxel@redhat.com>
In-Reply-To: <20170404102315.24923-1-kraxel@redhat.com>
References: <20170404102315.24923-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 08/10] tcx: introduce tcx_check_dirty() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is similar to the existing tcx24_check_dirty() function and will aid
with the transition to thread-safe updates.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/tcx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 8e26aae..15172f0 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -98,6 +98,12 @@ static void tcx_set_dirty(TCXState *s)
     memory_region_set_dirty(&s->vram_mem, 0, MAXX * MAXY);
 }
 
+static inline int tcx_check_dirty(TCXState *s, ram_addr_t page)
+{
+    return memory_region_get_dirty(&s->vram_mem, page, TARGET_PAGE_SIZE,
+                                   DIRTY_MEMORY_VGA);
+}
+
 static inline int tcx24_check_dirty(TCXState *s, ram_addr_t page,
                                     ram_addr_t page24, ram_addr_t cpage)
 {
@@ -359,8 +365,7 @@ static void tcx_update_display(void *opaque)
 
     memory_region_sync_dirty_bitmap(&ts->vram_mem);
     for (y = 0; y < ts->height; page += TARGET_PAGE_SIZE) {
-        if (memory_region_get_dirty(&ts->vram_mem, page, TARGET_PAGE_SIZE,
-                                    DIRTY_MEMORY_VGA)) {
+        if (tcx_check_dirty(ts, page)) {
             if (y_start < 0)
                 y_start = y;
             if (page < page_min)
-- 
2.9.3
