Received: from eggs.gnu.org ([2001:4830:134:3::10]:45953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAy-0001NG-Hh
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAx-0001e6-CO
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Jun 2018 22:06:11 -0400
Message-Id: <20180613020613.1343-9-jsnow@redhat.com>
In-Reply-To: <20180613020613.1343-1-jsnow@redhat.com>
References: <20180613020613.1343-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/10] qcow2/bitmap: track extra_data_size
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

Similarly to the last patch, track the extra_data_size field that we read.
We do reject anything other than zero, but if this restriction is lifted
in the future, we'll need to update the _info field, so loosen this now.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 36573f7b52..3c2e974458 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -86,6 +86,7 @@ typedef struct Qcow2Bitmap {
     uint8_t type;
     uint8_t granularity_bits;
     char *name;
+    uint32_t extra_data_size;
 
     BdrvDirtyBitmap *dirty_bitmap;
 
@@ -609,6 +610,7 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, Error **errp)
         bm->table.size = e->bitmap_table_size;
         bm->flags = e->flags;
         bm->type = e->type;
+        bm->extra_data_size = e->extra_data_size;
         bm->granularity_bits = e->granularity_bits;
         bm->name = dir_entry_copy_name(e);
         QSIMPLEQ_INSERT_TAIL(bm_list, bm, entry);
@@ -782,7 +784,7 @@ static int bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
         e->type = bm->type;
         e->granularity_bits = bm->granularity_bits;
         e->name_size = strlen(bm->name);
-        e->extra_data_size = 0;
+        e->extra_data_size = bm->extra_data_size;
         memcpy(e + 1, bm->name, e->name_size);
 
         if (check_dir_entry(bs, e) < 0) {
-- 
2.14.3
