Received: from eggs.gnu.org ([209.51.188.92]:49073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPle-0008Eh-QW
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPld-0003ix-Tb
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:38 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Apr 2019 10:36:25 +0200
Message-Id: <20190408083627.7479-14-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-1-armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 13/15] blockdev: Make -drive format=help print
 to stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Command line help explicitly requested by the user should be printed
to stdout, not stderr.  We do elsewhere.  Adjust -drive to match: use
qemu_printf() instead of error_printf().  Plain printf() would be
wrong because we need to print to the current monitor for "drive_add
... format=help".

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 4775a07d93..79fbac8450 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -40,6 +40,7 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qemu/qemu-print.h"
 #include "qemu/config-file.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-transaction.h"
@@ -301,7 +302,7 @@ DriveInfo *drive_get_next(BlockInterfaceType type)
 
 static void bdrv_format_print(void *opaque, const char *name)
 {
-    error_printf(" %s", name);
+    qemu_printf(" %s", name);
 }
 
 typedef struct {
@@ -530,11 +531,11 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
 
     if ((buf = qemu_opt_get(opts, "format")) != NULL) {
         if (is_help_option(buf)) {
-            error_printf("Supported formats:");
+            qemu_printf("Supported formats:");
             bdrv_iterate_format(bdrv_format_print, NULL, false);
-            error_printf("\nSupported formats (read-only):");
+            qemu_printf("\nSupported formats (read-only):");
             bdrv_iterate_format(bdrv_format_print, NULL, true);
-            error_printf("\n");
+            qemu_printf("\n");
             goto early_err;
         }
 
-- 
2.17.2
