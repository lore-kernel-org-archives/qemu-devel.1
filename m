Received: from eggs.gnu.org ([209.51.188.92]:44362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gviTM-000851-OC
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gviTL-0000lb-ER
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:36 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Feb 2019 13:56:07 +0100
Message-Id: <20190218125615.18970-3-armbru@redhat.com>
In-Reply-To: <20190218125615.18970-1-armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 02/10] pflash: Macro PFLASH_BUG() is used just
 once, expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org

PFLASH_BUG()'s lone use has a suspicious smell: it prints "Possible
BUG", which sounds like a warning, then calls exit(1), followed by
unreachable goto reset_flash.  All this commit does is expanding the
macro, so the smell becomes more poignant, and the macro can be
deleted.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/block/pflash_cfi01.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 9efa7aa9af..f73c30a3ee 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -49,12 +49,6 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
 
-#define PFLASH_BUG(fmt, ...) \
-do { \
-    fprintf(stderr, "PFLASH: Possible BUG - " fmt, ## __VA_ARGS__); \
-    exit(1); \
-} while(0)
-
 /* #define PFLASH_DEBUG */
 #ifdef PFLASH_DEBUG
 #define DPRINTF(fmt, ...)                                   \
@@ -624,8 +618,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
                 pfl->status |= 0x80;
             } else {
                 DPRINTF("%s: unknown command for \"write block\"\n", __func__);
-                PFLASH_BUG("Write block confirm");
-                goto reset_flash;
+                fprintf(stderr, "PFLASH: Possible BUG - Write block confirm");
+                exit(1);
             }
             break;
         default:
-- 
2.17.2
