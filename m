Received: from eggs.gnu.org ([209.51.188.92]:47778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu49S-0005c5-RM
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu3tx-0005jK-AV
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:25:15 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Feb 2019 18:23:56 -0500
Message-Id: <20190213232356.21034-7-jsnow@redhat.com>
In-Reply-To: <20190213232356.21034-1-jsnow@redhat.com>
References: <20190213232356.21034-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] block/dirty-bitmaps: move comment block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <fam@euphon.net>, libvir-list@redhat.com, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Simply move the big status enum comment block to above the status
function, and document it as being deprecated. The whole confusing
block can get deleted in three releases time.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 8ab048385a..fc390cae94 100644
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
@@ -205,7 +189,25 @@ bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
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
+ *               but it can be Disabled and not recording writes.
+ * (4) Locked:   Whether Active or Disabled, the user cannot modify this bitmap
+ *               in any way from the monitor.
+ */
 DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap)
 {
     if (bdrv_dirty_bitmap_has_successor(bitmap)) {
-- 
2.17.2
