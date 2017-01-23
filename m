Received: from eggs.gnu.org ([2001:4830:134:3::10]:36325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdST-0002HF-C7
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSO-0005CP-46
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:49 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:35782 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVdSN-00059m-P3
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 23 Jan 2017 15:10:33 +0300
Message-Id: <20170123121036.4823-22-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-1-vsementsov@virtuozzo.com>
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 21/24] qcow2-bitmap: refcounts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Calculate refcounts for qcow2 bitmaps. It is needed for qcow2's qemu-img
check implementation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-bitmap.c   | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2-refcount.c |  6 ++++
 block/qcow2.h          |  3 ++
 3 files changed, 89 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 8b8f2d11ec..2687a3acd5 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1232,3 +1232,83 @@ common_errp:
                name, bdrv_get_device_or_node_name(bs), reason);
     return false;
 }
+
+int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
+                                  void **refcount_table,
+                                  int64_t *refcount_table_size)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2BitmapList *bm_list;
+    Qcow2Bitmap *bm;
+
+    if (s->nb_bitmaps == 0) {
+        return 0;
+    }
+
+    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, refcount_table_size,
+                                   s->bitmap_directory_offset,
+                                   s->bitmap_directory_size);
+    if (ret < 0) {
+        return ret;
+    }
+
+    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, NULL);
+    if (bm_list == NULL) {
+        res->corruptions++;
+        return -EINVAL;
+    }
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        uint64_t *bitmap_table = NULL;
+        int i;
+
+        ret = qcow2_inc_refcounts_imrt(bs, res,
+                                       refcount_table, refcount_table_size,
+                                       bm->table.offset,
+                                       bm->table.size * sizeof(uint64_t));
+        if (ret < 0) {
+            goto out;
+        }
+
+        ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
+        if (ret < 0) {
+            res->corruptions++;
+            goto out;
+        }
+
+        for (i = 0; i < bm->table.size; ++i) {
+            uint64_t entry = bitmap_table[i];
+            uint64_t offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
+
+            if (check_table_entry(entry, s->cluster_size) < 0) {
+                res->corruptions++;
+                continue;
+            }
+
+            if (offset == 0) {
+                continue;
+            }
+
+            ret = qcow2_inc_refcounts_imrt(bs, res,
+                                           refcount_table, refcount_table_size,
+                                           offset, s->cluster_size);
+            if (ret < 0) {
+                g_free(bitmap_table);
+                goto out;
+            }
+        }
+
+        g_free(bitmap_table);
+    }
+
+    if (res->corruptions > 0) {
+        ret = -EINVAL;
+    }
+
+out:
+    bitmap_list_free(bm_list);
+
+    return ret;
+}
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 14a736d245..cdb74ba4de 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1846,6 +1846,12 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
         return ret;
     }
 
+    /* bitmaps */
+    ret = qcow2_check_bitmaps_refcounts(bs, res, refcount_table, nb_clusters);
+    if (ret < 0) {
+        return ret;
+    }
+
     return check_refblocks(bs, res, fix, rebuild, refcount_table, nb_clusters);
 }
 
diff --git a/block/qcow2.h b/block/qcow2.h
index 0a3708d890..eaad34a527 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -624,5 +624,8 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
                                       const char *name,
                                       uint32_t granularity,
                                       Error **errp);
+int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
+                                  void **refcount_table,
+                                  int64_t *refcount_table_size);
 
 #endif
-- 
2.11.0
