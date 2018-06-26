Received: from eggs.gnu.org ([2001:4830:134:3::10]:51815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHD-00022z-L4
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHC-0007D1-MJ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:11 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHC-0007CU-Dt
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:10 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHB-00006D-CI
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:09 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:39 +0100
Message-Id: <20180626165658.31394-14-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/32] hw/i2c/omap_i2c: Use qemu_log_mask(UNIMP)
 instead of fprintf
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
Message-id: 20180624040609.17572-8-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/omap_i2c.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 26e3e5ebf6e..d02e734ea8e 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -17,6 +17,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/arm/omap.h"
@@ -339,14 +340,15 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
             }
             break;
         }
-        if ((value & (1 << 15)) && !(value & (1 << 10))) {	/* MST */
-            fprintf(stderr, "%s: I^2C slave mode not supported\n",
-                            __func__);
+        if ((value & (1 << 15)) && !(value & (1 << 10))) {    /* MST */
+            qemu_log_mask(LOG_UNIMP, "%s: I^2C slave mode not supported\n",
+                          __func__);
             break;
         }
-        if ((value & (1 << 15)) && value & (1 << 8)) {		/* XA */
-            fprintf(stderr, "%s: 10-bit addressing mode not supported\n",
-                            __func__);
+        if ((value & (1 << 15)) && value & (1 << 8)) {        /* XA */
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: 10-bit addressing mode not supported\n",
+                          __func__);
             break;
         }
         if ((value & (1 << 15)) && value & (1 << 0)) {		/* STT */
@@ -392,8 +394,10 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
                 s->stat |= 0x3f;
                 omap_i2c_interrupts_update(s);
             }
-        if (value & (1 << 15))					/* ST_EN */
-            fprintf(stderr, "%s: System Test not supported\n", __func__);
+        if (value & (1 << 15)) {                    /* ST_EN */
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: System Test not supported\n", __func__);
+        }
         break;
 
     default:
-- 
2.17.1
