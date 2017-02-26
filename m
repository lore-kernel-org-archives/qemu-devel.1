Received: from eggs.gnu.org ([2001:4830:134:3::10]:42497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chmkY-0001Dm-Bt
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 19:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chmkW-0005wQ-II
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 19:31:42 -0500
Message-Id: <65f979bc1683c46f74ddb5e931810f4e2b8ea27c.1488068248.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [Qemu-devel] [PATCH v2 02/14] sm501: Use defines instead of
 constants where available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Sun, 26 Feb 2017 00:31:44 -0000
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

This also fixes the initial value of misc_control register to match the
comment which is likely what was intended but the DAC_POWER bit was set
instead. This value is unused so it does not really matter but is
fixed here for consistency.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c          | 8 ++++----
 hw/display/sm501_template.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 4f40dee..4eb085c 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -555,7 +555,7 @@ static uint32_t get_local_mem_size_index(uint32_t size)
 static inline int is_hwc_enabled(SM501State *state, int crt)
 {
     uint32_t addr = crt ? state->dc_crt_hwc_addr : state->dc_panel_hwc_addr;
-    return addr & 0x80000000;
+    return addr & SM501_HWC_EN;
 }
 
 /**
@@ -1411,9 +1411,9 @@ void sm501_init(MemoryRegion *address_space_mem, uint32_t base,
     s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
     SM501_DPRINTF("local mem size=%x. index=%d\n", get_local_mem_size(s),
                   s->local_mem_size_index);
-    s->system_control = 0x00100000;
-    s->misc_control = 0x00001000; /* assumes SH, active=low */
-    s->dc_panel_control = 0x00010000;
+    s->system_control = 0x00100000; /* 2D engine FIFO empty */
+    s->misc_control = SM501_MISC_IRQ_INVERT; /* assumes SH, active=low */
+    s->dc_panel_control = 0x00010000; /* FIFO level 3 */
     s->dc_crt_control = 0x00010000;
 
     /* allocate local memory */
diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
index aeeac5d..16e500b 100644
--- a/hw/display/sm501_template.h
+++ b/hw/display/sm501_template.h
@@ -108,7 +108,7 @@ static void glue(draw_hwc_line_, PIXEL_NAME)(SM501State *s, int crt,
     /* get hardware cursor pattern */
     uint32_t cursor_addr = get_hwc_address(s, crt);
     assert(0 <= c_y && c_y < SM501_HWC_HEIGHT);
-    cursor_addr += 64 * c_y / 4;  /* 4 pixels per byte */
+    cursor_addr += SM501_HWC_WIDTH * c_y / 4;  /* 4 pixels per byte */
     cursor_addr += s->base;
 
     /* get cursor position */
-- 
2.7.4
