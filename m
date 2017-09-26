Received: from eggs.gnu.org ([2001:4830:134:3::10]:33241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkw-0001ym-Iz
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqko-0005f2-VG
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:33 +0200
Message-Id: <20170926142133.2498-25-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-1-kwolf@redhat.com>
References: <20170926142133.2498-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 24/24] block/qcow2-bitmap: fix use of
 uninitialized pointer
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

Without initialization to zero dirty_bitmap field may be not zero
for a bitmap which should not be stored and
qcow2_store_persistent_dirty_bitmaps will erroneously call
store_bitmap for it which leads to SIGSEGV on bdrv_dirty_bitmap_name.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20170922144353.4220-1-vsementsov@virtuozzo.com
Cc: qemu-stable@nongnu.org
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index e8d3bdbd6e..14f41d0427 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -602,7 +602,7 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
             goto fail;
         }
 
-        bm = g_new(Qcow2Bitmap, 1);
+        bm = g_new0(Qcow2Bitmap, 1);
         bm->table.offset = e->bitmap_table_offset;
         bm->table.size = e->bitmap_table_size;
         bm->flags = e->flags;
-- 
2.13.5
