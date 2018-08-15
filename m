Received: from eggs.gnu.org ([2001:4830:134:3::10]:52279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLk-0004kX-Dq
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLe-0001Lb-6B
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 15 Aug 2018 14:55:30 +0200
Message-Id: <20180815125537.10651-15-kwolf@redhat.com>
In-Reply-To: <20180815125537.10651-1-kwolf@redhat.com>
References: <20180815125537.10651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/21] block: make .bdrv_close optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c          | 4 +++-
 block/snapshot.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 39f373e035..9694018a68 100644
--- a/block.c
+++ b/block.c
@@ -3349,7 +3349,9 @@ static void bdrv_close(BlockDriverState *bs)
     bdrv_drain(bs); /* in case flush left pending I/O */
 
     if (bs->drv) {
-        bs->drv->bdrv_close(bs);
+        if (bs->drv->bdrv_close) {
+            bs->drv->bdrv_close(bs);
+        }
         bs->drv = NULL;
     }
 
diff --git a/block/snapshot.c b/block/snapshot.c
index f9903bc94e..3218a542df 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -218,7 +218,9 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         qobject_unref(file_options);
         qdict_put_str(options, "file", bdrv_get_node_name(file));
 
-        drv->bdrv_close(bs);
+        if (drv->bdrv_close) {
+            drv->bdrv_close(bs);
+        }
         bdrv_unref_child(bs, bs->file);
         bs->file = NULL;
 
-- 
2.13.6
