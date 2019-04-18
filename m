Received: from eggs.gnu.org ([209.51.188.92]:54842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0g-0005FP-3q
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0d-0005Mo-3D
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:52 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:51:15 +0200
Message-Id: <20190418205135.6686-17-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-4.1 16/36] blockdev: Make -drive format=help
 print to stdout
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
... format=3Dhelp".

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190417190641.26814-13-armbru@redhat.com>
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
=20
 static void bdrv_format_print(void *opaque, const char *name)
 {
-    error_printf(" %s", name);
+    qemu_printf(" %s", name);
 }
=20
 typedef struct {
@@ -530,11 +531,11 @@ static BlockBackend *blockdev_init(const char *file=
, QDict *bs_opts,
=20
     if ((buf =3D qemu_opt_get(opts, "format")) !=3D NULL) {
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
=20
--=20
2.17.2
