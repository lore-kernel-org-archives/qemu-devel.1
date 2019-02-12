Received: from eggs.gnu.org ([209.51.188.92]:43781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gtXIE-00065d-Sz
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gtXIB-0002IF-Ue
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:36:06 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Tue, 12 Feb 2019 15:35:51 +0300
Message-Id: <1549974951-731285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] Discard old bitmap directories in QCOW2 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

Clean QCOW2 image from bitmap obsolete directory when a new one
is allocated and stored. It slows down the image growth a little bit.
The flag QCOW2_DISCARD_ALWAYS allows a call to raw_co_pdiscard()
that does the actual cleaning of the image on disk.
With the flag QCOW2_DISCARD_OTHER, a reference count of the cluster
is updated only.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/qcow2-bitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b946301..682cb09 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -202,7 +202,7 @@ static void clear_bitmap_table(BlockDriverState *bs, uint64_t *bitmap_table,
             continue;
         }
 
-        qcow2_free_clusters(bs, addr, s->cluster_size, QCOW2_DISCARD_OTHER);
+        qcow2_free_clusters(bs, addr, s->cluster_size, QCOW2_DISCARD_ALWAYS);
         bitmap_table[i] = 0;
     }
 }
@@ -257,7 +257,7 @@ static int free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
 
     clear_bitmap_table(bs, bitmap_table, tb->size);
     qcow2_free_clusters(bs, tb->offset, tb->size * sizeof(uint64_t),
-                        QCOW2_DISCARD_OTHER);
+                        QCOW2_DISCARD_ALWAYS);
     g_free(bitmap_table);
 
     tb->offset = 0;
@@ -801,7 +801,7 @@ fail:
     g_free(dir);
 
     if (!in_place && dir_offset > 0) {
-        qcow2_free_clusters(bs, dir_offset, dir_size, QCOW2_DISCARD_OTHER);
+        qcow2_free_clusters(bs, dir_offset, dir_size, QCOW2_DISCARD_ALWAYS);
     }
 
     return ret;
@@ -904,14 +904,14 @@ static int update_ext_header_and_dir(BlockDriverState *bs,
     }
 
     if (old_size > 0) {
-        qcow2_free_clusters(bs, old_offset, old_size, QCOW2_DISCARD_OTHER);
+        qcow2_free_clusters(bs, old_offset, old_size, QCOW2_DISCARD_ALWAYS);
     }
 
     return 0;
 
 fail:
     if (new_offset > 0) {
-        qcow2_free_clusters(bs, new_offset, new_size, QCOW2_DISCARD_OTHER);
+        qcow2_free_clusters(bs, new_offset, new_size, QCOW2_DISCARD_ALWAYS);
     }
 
     s->bitmap_directory_offset = old_offset;
@@ -1242,7 +1242,7 @@ fail:
 
     if (tb_offset > 0) {
         qcow2_free_clusters(bs, tb_offset, tb_size * sizeof(tb[0]),
-                            QCOW2_DISCARD_OTHER);
+                            QCOW2_DISCARD_ALWAYS);
     }
 
     g_free(tb);
-- 
1.8.3.1
