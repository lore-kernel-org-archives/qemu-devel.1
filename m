Received: from eggs.gnu.org ([2001:4830:134:3::10]:51838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHE-00023N-73
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHD-0007DJ-4k
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHC-00079F-OY
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrH7-0008Vo-Qw
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:34 +0100
Message-Id: <20180626165658.31394-9-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/32] hw/input/tsc2005: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20180624040609.17572-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/input/tsc2005.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 7990954b6cd..4dd95596ab7 100644
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
2.17.1
