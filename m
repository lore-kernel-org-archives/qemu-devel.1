Received: from eggs.gnu.org ([2001:4830:134:3::10]:42033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cktYP-0004NA-4x
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cktYL-0007Wj-1f
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:24:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cktYK-0007WO-Pb
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:23:56 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  6 Mar 2017 15:23:49 +0100
Message-Id: <1488810230-31945-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1488810230-31945-1-git-send-email-kraxel@redhat.com>
References: <1488810230-31945-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] sm501: drop support for anything but 32bpp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

The qemu console code hands out 32bpp display surfaces only, when using
qemu_console_resize or qemu_create_displaysurface (which sm501 does).
So there is no need to ever generate other output.  Drop the code.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/sm501.c | 89 +++---------------------------------------------------
 1 file changed, 4 insertions(+), 85 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 040a0b9..6c7717c 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1173,89 +1173,9 @@ typedef void draw_line_func(uint8_t *d, const uint8_t *s,
 typedef void draw_hwc_line_func(SM501State * s, int crt, uint8_t * palette,
                                 int c_y, uint8_t *d, int width);
 
-#define DEPTH 8
-#include "sm501_template.h"
-
-#define DEPTH 15
-#include "sm501_template.h"
-
-#define BGR_FORMAT
-#define DEPTH 15
-#include "sm501_template.h"
-
-#define DEPTH 16
-#include "sm501_template.h"
-
-#define BGR_FORMAT
-#define DEPTH 16
-#include "sm501_template.h"
-
-#define DEPTH 32
-#include "sm501_template.h"
-
-#define BGR_FORMAT
 #define DEPTH 32
 #include "sm501_template.h"
 
-static draw_line_func * draw_line8_funcs[] = {
-    draw_line8_8,
-    draw_line8_15,
-    draw_line8_16,
-    draw_line8_32,
-    draw_line8_32bgr,
-    draw_line8_15bgr,
-    draw_line8_16bgr,
-};
-
-static draw_line_func * draw_line16_funcs[] = {
-    draw_line16_8,
-    draw_line16_15,
-    draw_line16_16,
-    draw_line16_32,
-    draw_line16_32bgr,
-    draw_line16_15bgr,
-    draw_line16_16bgr,
-};
-
-static draw_line_func * draw_line32_funcs[] = {
-    draw_line32_8,
-    draw_line32_15,
-    draw_line32_16,
-    draw_line32_32,
-    draw_line32_32bgr,
-    draw_line32_15bgr,
-    draw_line32_16bgr,
-};
-
-static draw_hwc_line_func * draw_hwc_line_funcs[] = {
-    draw_hwc_line_8,
-    draw_hwc_line_15,
-    draw_hwc_line_16,
-    draw_hwc_line_32,
-    draw_hwc_line_32bgr,
-    draw_hwc_line_15bgr,
-    draw_hwc_line_16bgr,
-};
-
-static inline int get_depth_index(DisplaySurface *surface)
-{
-    switch (surface_bits_per_pixel(surface)) {
-    default:
-    case 8:
-	return 0;
-    case 15:
-        return 1;
-    case 16:
-        return 2;
-    case 32:
-        if (is_surface_bgr(surface)) {
-            return 4;
-        } else {
-            return 3;
-        }
-    }
-}
-
 static void sm501_draw_crt(SM501State * s)
 {
     DisplaySurface *surface = qemu_console_surface(s->con);
@@ -1269,7 +1189,6 @@ static void sm501_draw_crt(SM501State * s)
     uint32_t * palette = (uint32_t *)&s->dc_palette[SM501_DC_CRT_PALETTE
 						    - SM501_DC_PANEL_PALETTE];
     uint8_t hwc_palette[3 * 3];
-    int ds_depth_index = get_depth_index(surface);
     draw_line_func * draw_line = NULL;
     draw_hwc_line_func * draw_hwc_line = NULL;
     int full_update = 0;
@@ -1282,15 +1201,15 @@ static void sm501_draw_crt(SM501State * s)
     switch (s->dc_crt_control & 3) {
     case SM501_DC_CRT_CONTROL_8BPP:
 	src_bpp = 1;
-	draw_line = draw_line8_funcs[ds_depth_index];
+	draw_line = draw_line8_32;
 	break;
     case SM501_DC_CRT_CONTROL_16BPP:
 	src_bpp = 2;
-	draw_line = draw_line16_funcs[ds_depth_index];
+	draw_line = draw_line16_32;
 	break;
     case SM501_DC_CRT_CONTROL_32BPP:
 	src_bpp = 4;
-	draw_line = draw_line32_funcs[ds_depth_index];
+	draw_line = draw_line32_32;
 	break;
     default:
 	printf("sm501 draw crt : invalid DC_CRT_CONTROL=%x.\n",
@@ -1312,7 +1231,7 @@ static void sm501_draw_crt(SM501State * s)
         }
 
         /* choose cursor draw line function */
-        draw_hwc_line = draw_hwc_line_funcs[ds_depth_index];
+        draw_hwc_line = draw_hwc_line_32;
     }
 
     /* adjust console size */
-- 
1.8.3.1
