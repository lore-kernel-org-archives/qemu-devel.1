Received: from eggs.gnu.org ([2001:4830:134:3::10]:42278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwIT-0003sl-BR
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwIR-0003qB-MB
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:06:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 24 Jun 2018 01:05:58 -0300
Message-Id: <20180624040609.17572-6-f4bug@amsat.org>
In-Reply-To: <20180624040609.17572-1-f4bug@amsat.org>
References: <20180624040609.17572-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 05/16] hw/ssi/omap_spi: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/ssi/omap_spi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/ssi/omap_spi.c b/hw/ssi/omap_spi.c
index 34163e5646..f278a55160 100644
--- a/hw/ssi/omap_spi.c
+++ b/hw/ssi/omap_spi.c
@@ -20,6 +20,7 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/arm/omap.h"
 
@@ -294,11 +295,15 @@ static void omap_mcspi_write(void *opaque, hwaddr addr,
     case 0x2c:	/* MCSPI_CHCONF */
         if ((value ^ s->ch[ch].config) & (3 << 14))	/* DMAR | DMAW */
             omap_mcspi_dmarequest_update(s->ch + ch);
-        if (((value >> 12) & 3) == 3)			/* TRM */
-            fprintf(stderr, "%s: invalid TRM value (3)\n", __func__);
-        if (((value >> 7) & 0x1f) < 3)			/* WL */
-            fprintf(stderr, "%s: invalid WL value (%" PRIx64 ")\n",
-                            __func__, (value >> 7) & 0x1f);
+        if (((value >> 12) & 3) == 3) { /* TRM */
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid TRM value (3)\n",
+                          __func__);
+        }
+        if (((value >> 7) & 0x1f) < 3) { /* WL */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid WL value (%" PRIx64 ")\n",
+                          __func__, (value >> 7) & 0x1f);
+        }
         s->ch[ch].config = value & 0x7fffff;
         break;
 
-- 
2.18.0
