Received: from eggs.gnu.org ([2001:4830:134:3::10]:39790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDd2-0007ld-0p
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDd0-0003c5-K3
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:55 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 14:24:28 +1000
Message-Id: <20180622042437.14259-14-david@gibson.dropbear.id.au>
In-Reply-To: <20180622042437.14259-1-david@gibson.dropbear.id.au>
References: <20180622042437.14259-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 14/23] sm501: Fix hardware cursor color
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sebastian Bauer <mail@sebastianbauer.info>, David Gibson <david@gibson.dropbear.id.au>

From: Sebastian Bauer <mail@sebastianbauer.info>

According to the sm501 specs the hardware cursor colors are to be given in
the rgb565 format, but the code currently interprets them as bgr565.

Therefore, the colors of the hardware cursors are wrong in the QEMU
display, e.g., the standard mouse pointer of AmigaOS appears blue instead
of red. This change fixes this issue by replacing the existing naive
bgr565 => rgb888 conversion with a standard rgb565 => rgb888 one that also
scales the color component values properly.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/display/sm501.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index ca0840f6fa..8206ae81a1 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -652,9 +652,9 @@ static inline void get_hwc_palette(SM501State *state, int crt, uint8_t *palette)
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
