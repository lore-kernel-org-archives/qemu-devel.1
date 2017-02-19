Received: from eggs.gnu.org ([2001:4830:134:3::10]:34572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cfUtz-00005x-Pm
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cfUty-0002op-3w
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:03:59 -0500
Message-Id: <8936f97ffdf6fe9a71a300113019bfdba0ecef23.1487522123.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1487522123.git.balaton@eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 19 Feb 2017 17:35:23 +0100
Subject: [Qemu-devel] [PATCH 09/10] sm501: Add some more missing registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Write only to allow clients to initialise these without failing

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 2e1c4b7..16a00cc 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -508,6 +508,8 @@ typedef struct SM501State {
     uint32_t dc_panel_hwc_color_1_2;
     uint32_t dc_panel_hwc_color_3;
 
+    uint32_t dc_video_control;
+
     uint32_t dc_crt_control;
     uint32_t dc_crt_fb_addr;
     uint32_t dc_crt_fb_offset;
@@ -527,12 +529,21 @@ typedef struct SM501State {
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
+    uint32_t twoD_alpha;
+    uint32_t twoD_wrap;
+    uint32_t twoD_status;
 
 } SM501State;
 
@@ -1057,6 +1068,10 @@ static void sm501_disp_ctrl_write(void *opaque, hwaddr addr,
         s->dc_panel_hwc_color_3 = value & 0x0000FFFF;
         break;
 
+    case SM501_DC_VIDEO_CONTROL:
+        s->dc_video_control = value & 0x0003FFFF;
+        break;
+
     case SM501_DC_CRT_CONTROL:
         s->dc_crt_control = value & 0x0003FFFF;
         break;
@@ -1174,15 +1189,33 @@ static void sm501_2d_engine_write(void *opaque, hwaddr addr,
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
@@ -1192,6 +1225,15 @@ static void sm501_2d_engine_write(void *opaque, hwaddr addr,
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
+        s->twoD_status = value;
+        break;
     default:
         printf("sm501 2d engine : not implemented register write."
                " addr=%x, val=%x\n", (int)addr, (unsigned)value);
-- 
2.7.4
