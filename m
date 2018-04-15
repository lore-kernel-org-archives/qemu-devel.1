Received: from eggs.gnu.org ([2001:4830:134:3::10]:52470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rKj-0006Ho-T3
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rKg-0001dv-Qb
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:45:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:43:01 -0300
Message-Id: <20180415234307.28132-36-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 35/41] hw/sd: Use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c    | 4 ++--
 hw/sd/sdhci.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 235e0518d6..3b2f925ae6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -30,6 +30,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/qdev.h"
 #include "hw/hw.h"
 #include "hw/registerfields.h"
@@ -37,7 +38,6 @@
 #include "hw/sd/sd.h"
 #include "qapi/error.h"
 #include "qemu/bitmap.h"
-#include "qemu/cutils.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
@@ -394,7 +394,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
             ((HWBLOCK_SHIFT << 6) & 0xc0);
         sd->csd[14] = 0x00;	/* File format group */
     } else {			/* SDHC */
-        size /= 512 * 1024;
+        size /= 512 * K_BYTE;
         size -= 1;
         sd->csd[0] = 0x40;
         sd->csd[1] = 0x0e;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 63c44a4ee8..55e2054148 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
@@ -34,7 +35,6 @@
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
 #include "qemu/log.h"
-#include "qemu/cutils.h"
 #include "trace.h"
 
 #define TYPE_SDHCI_BUS "sdhci-bus"
@@ -792,7 +792,7 @@ static void sdhci_do_adma(SDHCIState *s)
             return;
         }
 
-        length = dscr.length ? dscr.length : 65536;
+        length = dscr.length ? dscr.length : 64 * K_BYTE;
 
         switch (dscr.attr & SDHC_ADMA_ATTR_ACT_MASK) {
         case SDHC_ADMA_ATTR_ACT_TRAN:  /* data transfer */
-- 
2.17.0
