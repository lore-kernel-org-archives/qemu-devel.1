Received: from eggs.gnu.org ([2001:4830:134:3::10]:44837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fXw0c-00041T-F1
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fXw0X-0002hF-GX
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:30220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fXw0X-0002f8-8z
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:17 -0400
Message-Id: <f36a1d271881c4dacf82c4294cd20d4bd2918d8b.1530047900.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1530047900.git.balaton@eik.bme.hu>
References: <cover.1530047900.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 26 Jun 2018 23:18:20 +0200
Subject: [Qemu-devel] [PATCH v2 7/7] sm501: Set updated region dirty after
 2D operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>

Set the changed memory region dirty after performed a 2D operation to
ensure that the screen is updated properly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v2: fixed to work with non-zero fb_addr

 hw/display/sm501.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 6e78f73..090bc6a 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -715,12 +715,16 @@ static void sm501_2d_operation(SM501State *s)
     /* 1 if rop2 source is the pattern, otherwise the source is the bitmap */
     int rop2_source_is_pattern = (s->twoD_control >> 14) & 0x1;
     int rop = s->twoD_control & 0xFF;
+    uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
+    uint32_t dst_base = s->twoD_destination_base & 0x03FFFFFF;
 
     /* get frame buffer info */
-    uint8_t *src = s->local_mem + (s->twoD_source_base & 0x03FFFFFF);
-    uint8_t *dst = s->local_mem + (s->twoD_destination_base & 0x03FFFFFF);
+    uint8_t *src = s->local_mem + src_base;
+    uint8_t *dst = s->local_mem + dst_base;
     int src_width = s->twoD_pitch & 0x1FFF;
     int dst_width = (s->twoD_pitch >> 16) & 0x1FFF;
+    int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
+    int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt);
 
     if (addressing != 0x0) {
         printf("%s: only XY addressing is supported.\n", __func__);
@@ -821,6 +825,15 @@ static void sm501_2d_operation(SM501State *s)
         abort();
         break;
     }
+
+    if (dst_base >= get_fb_addr(s, crt) &&
+        dst_base <= get_fb_addr(s, crt) + fb_len) {
+        int dst_len = MIN(fb_len, ((dst_y + operation_height - 1) * dst_width +
+                           dst_x + operation_width) * (1 << format_flags));
+        if (dst_len) {
+            memory_region_set_dirty(&s->local_mem_region, dst_base, dst_len);
+        }
+    }
 }
 
 static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
-- 
2.7.6
