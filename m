Received: from eggs.gnu.org ([2001:4830:134:3::10]:38686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1coU6A-0001e3-Sb
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1coU69-0004oi-OR
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:01:42 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <iwona260909@gmail.com>)
	id 1coU69-0004oG-IE
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:01:41 -0400
Received: by mail-lf0-x242.google.com with SMTP id v2so3232190lfi.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 05:01:41 -0700 (PDT)
From: iwona260909@gmail.com
Date: Thu, 16 Mar 2017 13:01:10 +0100
Message-Id: <20170316120110.11677-2-iwona260909@gmail.com>
In-Reply-To: <20170316120110.11677-1-iwona260909@gmail.com>
References: <20170316120110.11677-1-iwona260909@gmail.com>
Subject: [Qemu-devel] [PATCH] Dead code removal: removing code for
 unsupported DEPTH.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Iwona Kotlarska <iwona260909@gmail.com>

From: Iwona Kotlarska <iwona260909@gmail.com>

Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>
---
 hw/display/cirrus_vga.c      |  3 ---
 hw/display/cirrus_vga_rop.h  |  9 ---------
 hw/display/cirrus_vga_rop2.h | 46 ++------------------------------------------
 3 files changed, 2 insertions(+), 56 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index b9e7cb1df1..efa9609ccd 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -478,9 +478,6 @@ static const cirrus_bitblt_rop_t cirrus_bkwd_transp_rop[16][2] = {
 };
 
 #define ROP2(name) {\
-    name ## _8,\
-    name ## _16,\
-    name ## _24,\
     name ## _32,\
         }
 
diff --git a/hw/display/cirrus_vga_rop.h b/hw/display/cirrus_vga_rop.h
index 0925a009fe..f175c808cc 100644
--- a/hw/display/cirrus_vga_rop.h
+++ b/hw/display/cirrus_vga_rop.h
@@ -189,15 +189,6 @@ glue(glue(cirrus_bitblt_rop_bkwd_transp_, ROP_NAME),_16)(CirrusVGAState *s,
     }
 }
 
-#define DEPTH 8
-#include "cirrus_vga_rop2.h"
-
-#define DEPTH 16
-#include "cirrus_vga_rop2.h"
-
-#define DEPTH 24
-#include "cirrus_vga_rop2.h"
-
 #define DEPTH 32
 #include "cirrus_vga_rop2.h"
 
diff --git a/hw/display/cirrus_vga_rop2.h b/hw/display/cirrus_vga_rop2.h
index d28bcc6f25..adf0f30a94 100644
--- a/hw/display/cirrus_vga_rop2.h
+++ b/hw/display/cirrus_vga_rop2.h
@@ -22,15 +22,8 @@
  * THE SOFTWARE.
  */
 
-#if DEPTH == 8
-#define PUTPIXEL()    ROP_OP(&d[0], col)
-#elif DEPTH == 16
-#define PUTPIXEL()    ROP_OP_16((uint16_t *)&d[0], col)
-#elif DEPTH == 24
-#define PUTPIXEL()    ROP_OP(&d[0], col);        \
-                      ROP_OP(&d[1], (col >> 8)); \
-                      ROP_OP(&d[2], (col >> 16))
-#elif DEPTH == 32
+
+#if DEPTH == 32
 #define PUTPIXEL()    ROP_OP_32(((uint32_t *)&d[0]), col)
 #else
 #error unsupported DEPTH
@@ -47,41 +40,16 @@ glue(glue(glue(cirrus_patternfill_, ROP_NAME), _),DEPTH)
     int x, y, pattern_y, pattern_pitch, pattern_x;
     unsigned int col;
     const uint8_t *src1;
-#if DEPTH == 24
-    int skipleft = s->vga.gr[0x2f] & 0x1f;
-#else
     int skipleft = (s->vga.gr[0x2f] & 0x07) * (DEPTH / 8);
-#endif
-
-#if DEPTH == 8
-    pattern_pitch = 8;
-#elif DEPTH == 16
-    pattern_pitch = 16;
-#else
     pattern_pitch = 32;
-#endif
     pattern_y = s->cirrus_blt_srcaddr & 7;
     for(y = 0; y < bltheight; y++) {
         pattern_x = skipleft;
         d = dst + skipleft;
         src1 = src + pattern_y * pattern_pitch;
         for (x = skipleft; x < bltwidth; x += (DEPTH / 8)) {
-#if DEPTH == 8
-            col = src1[pattern_x];
-            pattern_x = (pattern_x + 1) & 7;
-#elif DEPTH == 16
-            col = ((uint16_t *)(src1 + pattern_x))[0];
-            pattern_x = (pattern_x + 2) & 15;
-#elif DEPTH == 24
-            {
-                const uint8_t *src2 = src1 + pattern_x * 3;
-                col = src2[0] | (src2[1] << 8) | (src2[2] << 16);
-                pattern_x = (pattern_x + 1) & 7;
-            }
-#else
             col = ((uint32_t *)(src1 + pattern_x))[0];
             pattern_x = (pattern_x + 4) & 31;
-#endif
             PUTPIXEL();
             d += (DEPTH / 8);
         }
@@ -104,13 +72,8 @@ glue(glue(glue(cirrus_colorexpand_transp_, ROP_NAME), _),DEPTH)
     unsigned int col;
     unsigned bitmask;
     unsigned index;
-#if DEPTH == 24
-    int dstskipleft = s->vga.gr[0x2f] & 0x1f;
-    int srcskipleft = dstskipleft / 3;
-#else
     int srcskipleft = s->vga.gr[0x2f] & 0x07;
     int dstskipleft = srcskipleft * (DEPTH / 8);
-#endif
 
     if (s->cirrus_blt_modeext & CIRRUS_BLTMODEEXT_COLOREXPINV) {
         bits_xor = 0xff;
@@ -187,13 +150,8 @@ glue(glue(glue(cirrus_colorexpand_pattern_transp_, ROP_NAME), _),DEPTH)
     int x, y, bitpos, pattern_y;
     unsigned int bits, bits_xor;
     unsigned int col;
-#if DEPTH == 24
-    int dstskipleft = s->vga.gr[0x2f] & 0x1f;
-    int srcskipleft = dstskipleft / 3;
-#else
     int srcskipleft = s->vga.gr[0x2f] & 0x07;
     int dstskipleft = srcskipleft * (DEPTH / 8);
-#endif
 
     if (s->cirrus_blt_modeext & CIRRUS_BLTMODEEXT_COLOREXPINV) {
         bits_xor = 0xff;
-- 
2.12.0
