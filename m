Received: from eggs.gnu.org ([209.51.188.92]:54723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1pT1-0005So-5X
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1pT0-0004uf-8o
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:37:31 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Mar 2019 10:37:22 +0100
Message-Id: <20190307093723.655-4-armbru@redhat.com>
In-Reply-To: <20190307093723.655-1-armbru@redhat.com>
References: <20190307093723.655-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v6 3/4] fixup! hw/block: better reporting
 on pflash backing file mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, philmd@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

---
 hw/block/pflash_cfi02.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 33779ce807..d30a351472 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -39,6 +39,7 @@
 #include "hw/hw.h"
 #include "hw/block/flash.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "sysemu/block-backend.h"
 #include "qemu/host-utils.h"
@@ -550,12 +551,6 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     }
 
     chip_len = pfl->sector_len * pfl->nb_blocs;
-    /* XXX: to be fixed */
-#if 0
-    if (total_len != (8 * 1024 * 1024) && total_len != (16 * 1024 * 1024) &&
-        total_len != (32 * 1024 * 1024) && total_len != (64 * 1024 * 1024))
-        return NULL;
-#endif
 
     memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
                                   &pflash_cfi02_ops_be : &pflash_cfi02_ops_le,
@@ -581,6 +576,27 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     }
 
     if (pfl->blk) {
+        /*
+         * Validate the backing store is the right size for pflash
+         * devices. If the user supplies a larger file we ignore the
+         * tail.
+         */
+        int64_t backing_len = blk_getlength(pfl->blk);
+        if (backing_len < 0) {
+            error_setg(errp, "unable to check size of backing file");
+            return;
+        }
+
+        if (backing_len < chip_len) {
+            error_setg(errp, "device needs %" PRIu32 " bytes, "
+                       "backing file provides only %" PRIu64 " bytes",
+                       chip_len, backing_len);
+            return;
+        } else if (backing_len > chip_len) {
+            warn_report("device needs %" PRIu32 " bytes, rest ignored",
+                        chip_len);
+        }
+
         /* read the initial flash content */
         ret = blk_pread(pfl->blk, 0, pfl->storage, chip_len);
         if (ret < 0) {
-- 
2.17.2
