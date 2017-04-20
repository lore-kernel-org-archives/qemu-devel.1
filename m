Received: from eggs.gnu.org ([2001:4830:134:3::10]:51702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d1J83-0005fS-Jv
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d1J7z-00052D-CT
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:56:39 -0400
Message-Id: <c219602071cb7301ce08a12a3a5c8302467cc3de.1492721026.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1492721026.git.balaton@eik.bme.hu>
References: <cover.1492721026.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 20 Apr 2017 22:43:46 +0200
Subject: [Qemu-devel] [PATCH v5 11/13] sm501: Add some more missing registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

This is to allow clients to initialise these without failing as long
as no 2D engine function is called that would use the written value.
Saved values are not used yet (may get used when more of 2D engine is
added sometimes) and clients normally only write to most of these
registers, nothing is known to ever read them but they are documented
as read/write so also implement read for these.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---

v2: Fixed mask of video_control register for a read only bit
    Changed IRQ status register to write ignored as IRQ is not implemented
v3: Squashed read implementation into this patch
v4: Add reset for all 2D engine registers (although these are
    documented to be 0 on reset, a comment in U-Boot source suggests that
    they are really undefined so the previous version might have been enough)

 hw/display/sm501.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 8abac8f..851c7c8 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -512,6 +512,8 @@ typedef struct SM501State {
     uint32_t dc_panel_hwc_color_1_2;
     uint32_t dc_panel_hwc_color_3;
 
+    uint32_t dc_video_control;
+
     uint32_t dc_crt_control;
     uint32_t dc_crt_fb_addr;
     uint32_t dc_crt_fb_offset;
@@ -531,13 +533,20 @@ typedef struct SM501State {
     uint32_t twoD_control;
     uint32_t twoD_pitch;
     uint32_t twoD_foreground;
+    uint32_t twoD_background;
     uint32_t twoD_stretch;
+    uint32_t twoD_color_compare;
     uint32_t twoD_color_compare_mask;
     uint32_t twoD_mask;
+    uint32_t twoD_clip_tl;
+    uint32_t twoD_clip_br;
+    uint32_t twoD_mono_pattern_low;
+    uint32_t twoD_mono_pattern_high;
     uint32_t twoD_window_width;
     uint32_t twoD_source_base;
     uint32_t twoD_destination_base;
-
+    uint32_t twoD_alpha;
+    uint32_t twoD_wrap;
 } SM501State;
 
 static uint32_t get_local_mem_size_index(uint32_t size)
@@ -946,6 +955,10 @@ static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
         ret = s->dc_panel_v_sync;
         break;
 
+    case SM501_DC_VIDEO_CONTROL:
+        ret = s->dc_video_control;
+        break;
+
     case SM501_DC_CRT_CONTROL:
         ret = s->dc_crt_control;
         break;
@@ -1061,6 +1074,10 @@ static void sm501_disp_ctrl_write(void *opaque, hwaddr addr,
         s->dc_panel_hwc_color_3 = value & 0x0000FFFF;
         break;
 
+    case SM501_DC_VIDEO_CONTROL:
+        s->dc_video_control = value & 0x00037FFF;
+        break;
+
     case SM501_DC_CRT_CONTROL:
         s->dc_crt_control = value & 0x0003FFFF;
         break;
@@ -1133,9 +1150,69 @@ static uint64_t sm501_2d_engine_read(void *opaque, hwaddr addr,
     SM501_DPRINTF("sm501 2d engine regs : read addr=%x\n", (int)addr);
 
     switch (addr) {
+    case SM501_2D_SOURCE:
+        ret = s->twoD_source;
+        break;
+    case SM501_2D_DESTINATION:
+        ret = s->twoD_destination;
+        break;
+    case SM501_2D_DIMENSION:
+        ret = s->twoD_dimension;
+        break;
+    case SM501_2D_CONTROL:
+        ret = s->twoD_control;
+        break;
+    case SM501_2D_PITCH:
+        ret = s->twoD_pitch;
+        break;
+    case SM501_2D_FOREGROUND:
+        ret = s->twoD_foreground;
+        break;
+    case SM501_2D_BACKGROUND:
+        ret = s->twoD_background;
+        break;
+    case SM501_2D_STRETCH:
+        ret = s->twoD_stretch;
+        break;
+    case SM501_2D_COLOR_COMPARE:
+        ret = s->twoD_color_compare;
+        break;
+    case SM501_2D_COLOR_COMPARE_MASK:
+        ret = s->twoD_color_compare_mask;
+        break;
+    case SM501_2D_MASK:
+        ret = s->twoD_mask;
+        break;
+    case SM501_2D_CLIP_TL:
+        ret = s->twoD_clip_tl;
+        break;
+    case SM501_2D_CLIP_BR:
+        ret = s->twoD_clip_br;
+        break;
+    case SM501_2D_MONO_PATTERN_LOW:
+        ret = s->twoD_mono_pattern_low;
+        break;
+    case SM501_2D_MONO_PATTERN_HIGH:
+        ret = s->twoD_mono_pattern_high;
+        break;
+    case SM501_2D_WINDOW_WIDTH:
+        ret = s->twoD_window_width;
+        break;
     case SM501_2D_SOURCE_BASE:
         ret = s->twoD_source_base;
         break;
+    case SM501_2D_DESTINATION_BASE:
+        ret = s->twoD_destination_base;
+        break;
+    case SM501_2D_ALPHA:
+        ret = s->twoD_alpha;
+        break;
+    case SM501_2D_WRAP:
+        ret = s->twoD_wrap;
+        break;
+    case SM501_2D_STATUS:
+        ret = 0; /* Should return interrupt status */
+        break;
     default:
         printf("sm501 disp ctrl : not implemented register read."
                " addr=%x\n", (int)addr);
@@ -1178,15 +1255,33 @@ static void sm501_2d_engine_write(void *opaque, hwaddr addr,
     case SM501_2D_FOREGROUND:
         s->twoD_foreground = value;
         break;
+    case SM501_2D_BACKGROUND:
+        s->twoD_background = value;
+        break;
     case SM501_2D_STRETCH:
         s->twoD_stretch = value;
         break;
+    case SM501_2D_COLOR_COMPARE:
+        s->twoD_color_compare = value;
+        break;
     case SM501_2D_COLOR_COMPARE_MASK:
         s->twoD_color_compare_mask = value;
         break;
     case SM501_2D_MASK:
         s->twoD_mask = value;
         break;
+    case SM501_2D_CLIP_TL:
+        s->twoD_clip_tl = value;
+        break;
+    case SM501_2D_CLIP_BR:
+        s->twoD_clip_br = value;
+        break;
+    case SM501_2D_MONO_PATTERN_LOW:
+        s->twoD_mono_pattern_low = value;
+        break;
+    case SM501_2D_MONO_PATTERN_HIGH:
+        s->twoD_mono_pattern_high = value;
+        break;
     case SM501_2D_WINDOW_WIDTH:
         s->twoD_window_width = value;
         break;
@@ -1196,6 +1291,15 @@ static void sm501_2d_engine_write(void *opaque, hwaddr addr,
     case SM501_2D_DESTINATION_BASE:
         s->twoD_destination_base = value;
         break;
+    case SM501_2D_ALPHA:
+        s->twoD_alpha = value;
+        break;
+    case SM501_2D_WRAP:
+        s->twoD_wrap = value;
+        break;
+    case SM501_2D_STATUS:
+        /* ignored, writing 0 should clear interrupt status */
+        break;
     default:
         printf("sm501 2d engine : not implemented register write."
                " addr=%x, val=%x\n", (int)addr, (unsigned)value);
@@ -1454,8 +1558,28 @@ static void sm501_reset(SM501State *s)
     s->misc_timing = 0;
     s->power_mode_control = 0;
     s->dc_panel_control = 0x00010000; /* FIFO level 3 */
+    s->dc_video_control = 0;
     s->dc_crt_control = 0x00010000;
+    s->twoD_source = 0;
+    s->twoD_destination = 0;
+    s->twoD_dimension = 0;
     s->twoD_control = 0;
+    s->twoD_pitch = 0;
+    s->twoD_foreground = 0;
+    s->twoD_background = 0;
+    s->twoD_stretch = 0;
+    s->twoD_color_compare = 0;
+    s->twoD_color_compare_mask = 0;
+    s->twoD_mask = 0;
+    s->twoD_clip_tl = 0;
+    s->twoD_clip_br = 0;
+    s->twoD_mono_pattern_low = 0;
+    s->twoD_mono_pattern_high = 0;
+    s->twoD_window_width = 0;
+    s->twoD_source_base = 0;
+    s->twoD_destination_base = 0;
+    s->twoD_alpha = 0;
+    s->twoD_wrap = 0;
 }
 
 static void sm501_init(SM501State *s, DeviceState *dev,
-- 
2.7.4
