Received: from eggs.gnu.org ([2001:4830:134:3::10]:37441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fV1rC-0001eH-7p
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fV1r8-0006fR-6h
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:38:38 -0400
Received: from relay2.mail.vrmd.de ([81.28.224.28]:58817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mail@sebastianbauer.info>)
	id 1fV1r8-0006fI-03
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:38:34 -0400
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Mon, 18 Jun 2018 23:38:16 +0200
Message-Id: <20180618213816.5966-1-mail@sebastianbauer.info>
Subject: [Qemu-devel] [PATCH] sm501: Fix hardware cursor color conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mail@sebastianbauer.info
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, balaton@eik.bme.hu

According to the sm501 specs the hardware cursor colors are to be given in
the rgb565 format, but the code currently interprets them as bgr565.

Therefore, the colors of the hardware cursors are wrong in the QEMU
display, e.g., the standard mouse pointer of AmigaOS appears blue instead
of red. This change fixes this issue by replacing the existing naive
bgr565 => rgb888 conversion with a standard rgb565 => rgb888 one that also
scales the color component values properly.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
---
 hw/display/sm501.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 0488ab69d3..6c7f8483f3 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -668,9 +668,9 @@ static inline void get_hwc_palette(SM501State *state, int crt, uint8_t *palette)
         } else {
             rgb565 = color_reg & 0xFFFF;
         }
-        palette[i * 3 + 0] = (rgb565 << 3) & 0xf8; /* red */
-        palette[i * 3 + 1] = (rgb565 >> 3) & 0xfc; /* green */
-        palette[i * 3 + 2] = (rgb565 >> 8) & 0xf8; /* blue */
+        palette[i * 3 + 0] = ((rgb565 >> 11) * 527 + 23) >> 6; /* r */
+        palette[i * 3 + 1] = (((rgb565 >> 5) & 0x3f) * 259 + 33) >> 6; /* g */
+        palette[i * 3 + 2] = ((rgb565 & 0x1f) * 527 + 23) >> 6; /* b */
     }
 }
 
-- 
2.17.1
