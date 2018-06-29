Received: from eggs.gnu.org ([2001:4830:134:3::10]:33746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumi-0007OK-CJ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumg-0006NE-9p
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumf-0005dk-MG
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:02 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumT-0004Tn-IO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:53:49 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:52:53 +0100
Message-Id: <20180629145347.652-2-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/55] hw/block/fdc: Replace
 error_setg(&error_abort) by assert()
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

Use assert() instead of error_setg(&error_abort),
as suggested by the "qapi/error.h" documentation:

    Please don't error_setg(&error_fatal, ...), use error_report() and
    exit(), because that's more obvious.
    Likewise, don't error_setg(&error_abort, ...), use assert().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: John Snow <jsnow@redhat.com>
Message-id: 20180625165749.3910-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/fdc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index cd29e27d8f5..7c1c57f57fa 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -396,16 +396,9 @@ static int pick_geometry(FDrive *drv)
                            nb_sectors,
                            FloppyDriveType_str(parse->drive));
         }
+        assert(type_match != -1 && "misconfigured fd_format");
         match = type_match;
     }
-
-    /* No match of any kind found -- fd_format is misconfigured, abort. */
-    if (match == -1) {
-        error_setg(&error_abort, "No candidate geometries present in table "
-                   " for floppy drive type '%s'",
-                   FloppyDriveType_str(drv->drive));
-    }
-
     parse = &(fd_formats[match]);
 
  out:
-- 
2.17.1
