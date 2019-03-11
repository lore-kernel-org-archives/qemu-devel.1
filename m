Received: from eggs.gnu.org ([209.51.188.92]:56224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3Q1h-0004r8-0r
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3Q1g-0005Mt-3Q
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:51:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Mar 2019 21:51:45 +0300
Message-Id: <20190311185147.52309-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190311185147.52309-1-vsementsov@virtuozzo.com>
References: <20190311185147.52309-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/4] block/qcow2-bitmap: Don't check size
 for IN_USE bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, eblake@redhat.com, den@virtuozzo.com

We are going to allow image resize when there are persistent bitmaps.
It may lead to appearing of inconsistent bitmaps (IN_USE=1) with
inconsistent size. But we still want to load them as inconsistent.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-bitmap.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 6adbe06b4d..141bc1e52c 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -462,10 +462,25 @@ static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *entry)
         return len;
     }
 
-    fail = (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) ||
-           (len > ((phys_bitmap_bytes * 8) << entry->granularity_bits));
+    if (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) {
+        return -EINVAL;
+    }
 
-    return fail ? -EINVAL : 0;
+    if (!(entry->flags & BME_FLAG_IN_USE) &&
+        (len > ((phys_bitmap_bytes * 8) << entry->granularity_bits)))
+    {
+        /*
+         * We've loaded valid bitmap (IN_USE not set) or we are going to store
+         * valid bitmap. But allocated bitmap table size is not enough to store
+         * such bitmap.
+         *
+         * Note, that it's OK to have invalid bitmap with invalid size during to
+         * bitmap was not correctly saved after image resize.
+         */
+        return -EINVAL;
+    }
+
+    return 0;
 }
 
 static inline void bitmap_directory_to_be(uint8_t *dir, size_t size)
-- 
2.18.0
