Received: from eggs.gnu.org ([2001:4830:134:3::10]:36336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNija-0004HI-ER
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNijZ-00056V-KG
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:48:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 29 May 2018 14:48:18 -0300
Message-Id: <20180529174821.19964-2-f4bug@amsat.org>
In-Reply-To: <20180529174821.19964-1-f4bug@amsat.org>
References: <20180529174821.19964-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/4] hw/block/fdc: Replace
 error_setg(&error_abort) by error_report() + abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Use error_report() + abort() instead of error_setg(&error_abort),
as suggested by the "qapi/error.h" documentation:

    Please don't error_setg(&error_fatal, ...), use error_report() and
    exit(), because that's more obvious.
    Likewise, don't error_setg(&error_abort, ...), use assert().

Use abort() instead of the suggested assert() because the error message
already got displayed.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/fdc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index cd29e27d8f..048467c00b 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -401,9 +401,10 @@ static int pick_geometry(FDrive *drv)
 
     /* No match of any kind found -- fd_format is misconfigured, abort. */
     if (match == -1) {
-        error_setg(&error_abort, "No candidate geometries present in table "
-                   " for floppy drive type '%s'",
-                   FloppyDriveType_str(drv->drive));
+        error_report("No candidate geometries present in table "
+                     " for floppy drive type '%s'",
+                     FloppyDriveType_str(drv->drive));
+        abort();
     }
 
     parse = &(fd_formats[match]);
-- 
2.17.0
