Received: from eggs.gnu.org ([209.51.188.92]:44853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7J-0000rI-8g
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7G-0006uS-Ij
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38187)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M7F-0006nd-SM
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:14 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:49 -0500
Message-Id: <20190308202858.26636-9-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 08/17] block/dirty-bitmaps: move comment block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

Simply move the big status enum comment block to above the status
function, and document it as being deprecated. The whole confusing
block can get deleted in three releases time.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190223000614.13894-9-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index d50e74d337..980cae4fa3 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -28,22 +28,6 @@
 #include "block/block_int.h"
 #include "block/blockjob.h"
 
-/**
- * A BdrvDirtyBitmap can be in four possible user-visible states:
- * (1) Active:   successor is NULL, and disabled is false: full r/w mode
- * (2) Disabled: successor is NULL, and disabled is true: qualified r/w mode,
- *               guest writes are dropped, but monitor writes are possible,
- *               through commands like merge and clear.
- * (3) Frozen:   successor is not NULL.
- *               A frozen bitmap cannot be renamed, deleted, cleared, set,
- *               enabled, merged to, etc. A frozen bitmap can only abdicate()
- *               or reclaim().
- *               In this state, the anonymous successor bitmap may be either
- *               Active and recording writes from the guest (e.g. backup jobs),
- *               but it can be Disabled and not recording writes.
- * (4) Locked:   Whether Active or Disabled, the user cannot modify this bitmap
- *               in any way from the monitor.
- */
 struct BdrvDirtyBitmap {
     QemuMutex *mutex;
     HBitmap *bitmap;            /* Dirty bitmap implementation */
@@ -204,7 +188,25 @@ bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
     return !bitmap->disabled;
 }
 
-/* Called with BQL taken.  */
+/**
+ * bdrv_dirty_bitmap_status: This API is now deprecated.
+ * Called with BQL taken.
+ *
+ * A BdrvDirtyBitmap can be in four possible user-visible states:
+ * (1) Active:   successor is NULL, and disabled is false: full r/w mode
+ * (2) Disabled: successor is NULL, and disabled is true: qualified r/w mode,
+ *               guest writes are dropped, but monitor writes are possible,
+ *               through commands like merge and clear.
+ * (3) Frozen:   successor is not NULL.
+ *               A frozen bitmap cannot be renamed, deleted, cleared, set,
+ *               enabled, merged to, etc. A frozen bitmap can only abdicate()
+ *               or reclaim().
+ *               In this state, the anonymous successor bitmap may be either
+ *               Active and recording writes from the guest (e.g. backup jobs),
+ *               or it can be Disabled and not recording writes.
+ * (4) Locked:   Whether Active or Disabled, the user cannot modify this bitmap
+ *               in any way from the monitor.
+ */
 DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap)
 {
     if (bdrv_dirty_bitmap_has_successor(bitmap)) {
-- 
2.17.2
