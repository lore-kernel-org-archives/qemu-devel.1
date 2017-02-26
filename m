Received: from eggs.gnu.org ([2001:4830:134:3::10]:42557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chmkZ-0001IZ-TU
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 19:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chmkW-0005x1-P1
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 19:31:43 -0500
Message-Id: <379a9021607724194b457bf562df9900993788c0.1488068248.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [Qemu-devel] [PATCH v2 11/14] sm501: Add some more missing registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Sun, 26 Feb 2017 00:31:46 -0000
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Values are not used yet, only stored to allow clients to initialise
these without failing as long as no 2D engine function is called that
would use the written value.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---

v2: Fixed mask of video_control register for a read only bit
    Changed IRQ status register to write ignored as IRQ is not implemented

 hw/display/sm501.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index caa7e5c..af5e4db 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -511,6 +511,8 @@ typedef struct SM501State {
     uint32_t dc_panel_hwc_color_1_2;
     uint32_t dc_panel_hwc_color_3;
 
+    uint32_t dc_video_control;
+
     uint32_t dc_crt_control;
     uint32_t dc_crt_fb_addr;
     uint32_t dc_crt_fb_offset;
@@ -530,13 +532,20 @@ typedef struct SM501State {
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
@@ -945,6 +954,10 @@ static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
         ret = s->dc_panel_v_sync;
         break;
 
+    case SM501_DC_VIDEO_CONTROL:
+        ret = s->dc_video_control;
+        break;
+
     case SM501_DC_CRT_CONTROL:
         ret = s->dc_crt_control;
         break;
@@ -1060,6 +1073,10 @@ static void sm501_disp_ctrl_write(void *opaque, hwaddr addr,
         s->dc_panel_hwc_color_3 = value & 0x0000FFFF;
         break;
 
+    case SM501_DC_VIDEO_CONTROL:
+        s->dc_video_control = value & 0x00037FFF;
+        break;
+
     case SM501_DC_CRT_CONTROL:
         s->dc_crt_control = value & 0x0003FFFF;
         break;
@@ -1135,6 +1152,9 @@ static uint64_t sm501_2d_engine_read(void *opaque, hwaddr addr,
     case SM501_2D_SOURCE_BASE:
         ret = s->twoD_source_base;
         break;
+    case SM501_2D_STATUS:
+        ret = 0; /* Should return interrupt status */
+        break;
     default:
         printf("sm501 disp ctrl : not implemented register read."
                " addr=%x\n", (int)addr);
@@ -1177,15 +1197,33 @@ static void sm501_2d_engine_write(void *opaque, hwaddr addr,
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
@@ -1195,6 +1233,15 @@ static void sm501_2d_engine_write(void *opaque, hwaddr addr,
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
-- 
2.7.4
