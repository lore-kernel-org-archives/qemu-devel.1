Received: from eggs.gnu.org ([2001:4830:134:3::10]:57258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ6-0002IE-B0
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ5-0005XG-Al
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:02 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42826
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvgQ5-0005WI-4j
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:01 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  5 Apr 2017 09:35:20 +0100
Message-Id: <1491381329-3995-6-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 05/14] tcx: alter tcx_set_dirty() to accept
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/tcx.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 8e26aae..d24466f 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -93,9 +93,9 @@ typedef struct TCXState {
     uint16_t cursy;
 } TCXState;
 
-static void tcx_set_dirty(TCXState *s)
+static void tcx_set_dirty(TCXState *s, ram_addr_t addr, int len)
 {
-    memory_region_set_dirty(&s->vram_mem, 0, MAXX * MAXY);
+    memory_region_set_dirty(&s->vram_mem, addr, len);
 }
 
 static inline int tcx24_check_dirty(TCXState *s, ram_addr_t page,
@@ -156,7 +156,7 @@ static void update_palette_entries(TCXState *s, int start, int end)
             break;
         }
     }
-    tcx_set_dirty(s);
+    tcx_set_dirty(s, 0, memory_region_size(&s->vram_mem));
 }
 
 static void tcx_draw_line32(TCXState *s1, uint8_t *d,
@@ -526,7 +526,7 @@ static void tcx_invalidate_display(void *opaque)
 {
     TCXState *s = opaque;
 
-    tcx_set_dirty(s);
+    tcx_set_dirty(s, 0, memory_region_size(&s->vram_mem));
     qemu_console_resize(s->con, s->width, s->height);
 }
 
@@ -534,7 +534,7 @@ static void tcx24_invalidate_display(void *opaque)
 {
     TCXState *s = opaque;
 
-    tcx_set_dirty(s);
+    tcx_set_dirty(s, 0, memory_region_size(&s->vram_mem));
     qemu_console_resize(s->con, s->width, s->height);
 }
 
@@ -543,7 +543,7 @@ static int vmstate_tcx_post_load(void *opaque, int version_id)
     TCXState *s = opaque;
 
     update_palette_entries(s, 0, 256);
-    tcx_set_dirty(s);
+    tcx_set_dirty(s, 0, memory_region_size(&s->vram_mem));
     return 0;
 }
 
-- 
1.7.10.4
