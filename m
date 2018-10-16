Received: from eggs.gnu.org ([2001:4830:134:3::10]:58353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gCPH2-0001rw-BP
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gCPGv-00056M-DS
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:20:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 16 Oct 2018 16:20:18 +0300
Message-Id: <20181016132018.5054-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: fix Coverity
 CID1390625
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, peter.maydell@linaro.org, vsementsov@virtuozzo.com, den@openvz.org

Theoretically possible that we finish the skipping loop with bs = NULL
and the following code will crash trying to dereference it. Fix that.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 477826330c..6de808f95f 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -288,6 +288,10 @@ static int init_dirty_bitmap_migration(void)
             bs = backing_bs(bs);
         }
 
+        if (!bs || bs->implicit) {
+            continue;
+        }
+
         for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
              bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
         {
-- 
2.18.0
