Received: from eggs.gnu.org ([2001:4830:134:3::10]:42175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwIK-0003ju-Ah
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwIJ-0003jO-DM
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:06:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 24 Jun 2018 01:05:55 -0300
Message-Id: <20180624040609.17572-3-f4bug@amsat.org>
In-Reply-To: <20180624040609.17572-1-f4bug@amsat.org>
References: <20180624040609.17572-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/16] hw/input/tsc2005: Use
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/input/tsc2005.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 7990954b6c..4dd95596ab 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "ui/console.h"
@@ -208,9 +209,10 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
         }
         s->nextprecision = (data >> 13) & 1;
         s->timing[0] = data & 0x1fff;
-        if ((s->timing[0] >> 11) == 3)
-            fprintf(stderr, "%s: illegal conversion clock setting\n",
-                            __func__);
+        if ((s->timing[0] >> 11) == 3) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "tsc2005_write: illegal conversion clock setting\n");
+        }
         break;
     case 0xd:	/* CFR1 */
         s->timing[1] = data & 0xf07;
@@ -221,8 +223,9 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
         break;
 
     default:
-        fprintf(stderr, "%s: write into read-only register %x\n",
-                        __func__, reg);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write into read-only register 0x%x\n",
+                      __func__, reg);
     }
 }
 
-- 
2.18.0
