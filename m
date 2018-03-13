Received: from eggs.gnu.org ([2001:4830:134:3::10]:40179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1evi9Q-0003JF-EX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1evi9L-0007we-R6
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:31:28 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 13 Mar 2018 12:26:56 +0100
Message-Id: <20180313113114.DBFF174569F@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH v3] ppc440_pcix: Change some error_report to
 qemu_log_mask(LOG_UNIMP, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

Using log unimp is more appropriate for these messages and this also
silences them by default so they won't clobber make check output when
tests are added for this board.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
v3: Include qemu/log.h to avoid undeclared function warning
v2: Use defined format string for printing hwaddr instead of casting.
I guess this does not invalidate the R-b tag of v1 so I've added that too.

 hw/ppc/ppc440_pcix.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index ab2626a..b1307e6 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
@@ -286,8 +287,9 @@ static void ppc440_pcix_reg_write4(void *opaque, hwaddr addr,
         break;
 
     default:
-        error_report("%s: unhandled PCI internal register 0x%lx", __func__,
-                     (unsigned long)addr);
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unhandled PCI internal register 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
 }
@@ -377,8 +379,9 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, hwaddr addr,
         break;
 
     default:
-        error_report("%s: invalid PCI internal register 0x%lx", __func__,
-                     (unsigned long)addr);
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: invalid PCI internal register 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
         val = 0;
     }
 
-- 
2.7.6
