Received: from eggs.gnu.org ([2001:4830:134:3::10]:45981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAz-0001Nk-4C
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAx-0001eG-Hd
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Jun 2018 22:06:10 -0400
Message-Id: <20180613020613.1343-8-jsnow@redhat.com>
In-Reply-To: <20180613020613.1343-1-jsnow@redhat.com>
References: <20180613020613.1343-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/10] qcow2/bitmap: track bitmap type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

We only have one type of persistent bitmap right now, but I'd like the
qemu-img tool to be able to give good diagnostic information if it sees
an unknown/unsupported type.

We do enforce it to be the dirty tracking type in check_dir_entry, but
I wanted positive affirmation of the type in the forthcoming info script.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 6c4fe9b281..36573f7b52 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -83,6 +83,7 @@ typedef QSIMPLEQ_HEAD(Qcow2BitmapTableList, Qcow2BitmapTable)
 typedef struct Qcow2Bitmap {
     Qcow2BitmapTable table;
     uint32_t flags;
+    uint8_t type;
     uint8_t granularity_bits;
     char *name;
 
@@ -607,6 +608,7 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, Error **errp)
         bm->table.offset = e->bitmap_table_offset;
         bm->table.size = e->bitmap_table_size;
         bm->flags = e->flags;
+        bm->type = e->type;
         bm->granularity_bits = e->granularity_bits;
         bm->name = dir_entry_copy_name(e);
         QSIMPLEQ_INSERT_TAIL(bm_list, bm, entry);
@@ -777,7 +779,7 @@ static int bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
         e->bitmap_table_offset = bm->table.offset;
         e->bitmap_table_size = bm->table.size;
         e->flags = bm->flags;
-        e->type = BT_DIRTY_TRACKING_BITMAP;
+        e->type = bm->type;
         e->granularity_bits = bm->granularity_bits;
         e->name_size = strlen(bm->name);
         e->extra_data_size = 0;
@@ -1393,6 +1395,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         }
         bm->flags = bdrv_dirty_bitmap_enabled(bitmap) ? BME_FLAG_AUTO : 0;
         bm->granularity_bits = ctz32(bdrv_dirty_bitmap_granularity(bitmap));
+        bm->type = BT_DIRTY_TRACKING_BITMAP;
         bm->dirty_bitmap = bitmap;
     }
 
-- 
2.14.3
