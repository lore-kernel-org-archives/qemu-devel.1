Received: from eggs.gnu.org ([2001:4830:134:3::10]:57278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1faeOo-0008D6-AG
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1faeOj-0003ux-Cs
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:48:34 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:46735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1faeOj-0003uR-5B
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:48:29 -0400
Message-Id: <8412fd970b69ee1e3313d27590c90b31acc64e4c.1530697258.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1530697258.git.balaton@eik.bme.hu>
References: <cover.1530697258.git.balaton@eik.bme.hu>
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Wed, 04 Jul 2018 11:40:58 +0200
Subject: [Qemu-devel] [PATCH v3 5/7] sm501: Log unimplemented raster
 operation modes
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

The sm501 currently implements only a very limited set of raster operation
modes. After this change, unknown raster operation modes are logged so
these can be easily spotted.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 0b44d95..ebd1390 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -706,6 +706,8 @@ static void sm501_2d_operation(SM501State *s)
     int format_flags = (s->twoD_stretch >> 20) & 0x3;
     int addressing = (s->twoD_stretch >> 16) & 0xF;
     int rop_mode = (s->twoD_control >> 15) & 0x1; /* 1 for rop2, else rop3 */
+    /* 1 if rop2 source is the pattern, otherwise the source is the bitmap */
+    int rop2_source_is_pattern = (s->twoD_control >> 14) & 0x1;
     int rop = s->twoD_control & 0xFF;
 
     /* get frame buffer info */
@@ -719,6 +721,27 @@ static void sm501_2d_operation(SM501State *s)
         abort();
     }
 
+    if (rop_mode == 0) {
+        if (rop != 0xcc) {
+            /* Anything other than plain copies are not supported */
+            qemu_log_mask(LOG_UNIMP, "sm501: rop3 mode with rop %x is not "
+                          "supported.\n", rop);
+        }
+    } else {
+        if (rop2_source_is_pattern && rop != 0x5) {
+            /* For pattern source, we support only inverse dest */
+            qemu_log_mask(LOG_UNIMP, "sm501: rop2 source being the pattern and "
+                          "rop %x is not supported.\n", rop);
+        } else {
+            if (rop != 0x5 && rop != 0xc) {
+                /* Anything other than plain copies or inverse dest is not
+                 * supported */
+                qemu_log_mask(LOG_UNIMP, "sm501: rop mode %x is not "
+                              "supported.\n", rop);
+            }
+        }
+    }
+
     if ((s->twoD_source_base & 0x08000000) ||
         (s->twoD_destination_base & 0x08000000)) {
         printf("%s: only local memory is supported.\n", __func__);
-- 
2.7.6
