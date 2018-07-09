Received: from eggs.gnu.org ([2001:4830:134:3::10]:44258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq9-00053m-Fn
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq7-0002E9-W0
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:09 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:40 +1000
Message-Id: <20180709074350.27086-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/16] sm501: Implement negated destination
 raster operation mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sebastian Bauer <mail@sebastianbauer.info>, David Gibson <david@gibson.dropbear.id.au>

From: Sebastian Bauer <mail@sebastianbauer.info>

Add support for the negated destination operation mode. This is used e.g.
by AmigaOS for the INVERSEVID drawing mode. With this change, the cursor
in the shell and non-immediate window adjustment are working now.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/display/sm501.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index d4878f01c0..0b44d95169 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -705,6 +705,8 @@ static void sm501_2d_operation(SM501State *s)
     uint32_t color = s->twoD_foreground;
     int format_flags = (s->twoD_stretch >> 20) & 0x3;
     int addressing = (s->twoD_stretch >> 16) & 0xF;
+    int rop_mode = (s->twoD_control >> 15) & 0x1; /* 1 for rop2, else rop3 */
+    int rop = s->twoD_control & 0xFF;
 
     /* get frame buffer info */
     uint8_t *src = s->local_mem + (s->twoD_source_base & 0x03FFFFFF);
@@ -729,6 +731,8 @@ static void sm501_2d_operation(SM501State *s)
         int y, x, index_d, index_s;                                           \
         for (y = 0; y < operation_height; y++) {                              \
             for (x = 0; x < operation_width; x++) {                           \
+                _pixel_type val;                                              \
+                                                                              \
                 if (rtl) {                                                    \
                     index_s = ((src_y - y) * src_width + src_x - x) * _bpp;   \
                     index_d = ((dst_y - y) * dst_width + dst_x - x) * _bpp;   \
@@ -736,7 +740,13 @@ static void sm501_2d_operation(SM501State *s)
                     index_s = ((src_y + y) * src_width + src_x + x) * _bpp;   \
                     index_d = ((dst_y + y) * dst_width + dst_x + x) * _bpp;   \
                 }                                                             \
-                *(_pixel_type *)&dst[index_d] = *(_pixel_type *)&src[index_s];\
+                if (rop_mode == 1 && rop == 5) {                              \
+                    /* Invert dest */                                         \
+                    val = ~*(_pixel_type *)&dst[index_d];                     \
+                } else {                                                      \
+                    val = *(_pixel_type *)&src[index_s];                      \
+                }                                                             \
+                *(_pixel_type *)&dst[index_d] = val;                          \
             }                                                                 \
         }                                                                     \
     }
-- 
2.17.1
