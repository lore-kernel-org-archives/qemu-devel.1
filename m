Received: from eggs.gnu.org ([2001:4830:134:3::10]:57279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1faeOo-0008D7-AQ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1faeOj-0003v7-Do
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:48:34 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:46728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1faeOj-0003uP-4J
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:48:29 -0400
Message-Id: <5336b4402ad41f178a5a816129e563709923d73f.1530697258.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1530697258.git.balaton@eik.bme.hu>
References: <cover.1530697258.git.balaton@eik.bme.hu>
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Wed, 04 Jul 2018 11:40:58 +0200
Subject: [Qemu-devel] [PATCH v3 4/7] sm501: Implement negated destination
 raster operation mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>, Philippe Mathieu-Daude <f4bug@amsat.org>

Add support for the negated destination operation mode. This is used e.g.
by AmigaOS for the INVERSEVID drawing mode. With this change, the cursor
in the shell and non-immediate window adjustment are working now.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index d4878f0..0b44d95 100644
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
2.7.6
