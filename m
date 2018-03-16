Received: from eggs.gnu.org ([2001:4830:134:3::10]:45765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1ewqZl-0005pR-Mc
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1ewqZk-0000MZ-Su
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:43:21 -0400
From: Nia Alarie <nia.alarie@gmail.com>
Date: Fri, 16 Mar 2018 14:43:07 +0000
Message-Id: <20180316144307.31073-1-nia.alarie@gmail.com>
Subject: [Qemu-devel] [PATCH] block/xen_disk: Convert atoi use to
 qemu_strtol to allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, Nia Alarie <nia.alarie@gmail.com>

Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
---
 hw/block/xen_disk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index f74fcd42d1..a9ec0ad6eb 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -32,6 +32,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
+#include "qemu/cutils.h"
 #include "trace.h"
 
 /* ------------------------------------------------------------- */
@@ -1010,7 +1011,10 @@ static int blk_init(struct XenDevice *xendev)
         blkdev->devtype = xenstore_read_be_str(&blkdev->xendev, "device-type");
     }
     directiosafe = xenstore_read_be_str(&blkdev->xendev, "direct-io-safe");
-    blkdev->directiosafe = (directiosafe && atoi(directiosafe));
+
+    if (directiosafe && qemu_strtoi(directiosafe, NULL, 10, &blkdev->directiosafe)) {
+        goto out_error;
+    }
 
     /* do we have all we need? */
     if (blkdev->params == NULL ||
-- 
2.16.2
