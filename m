Received: from eggs.gnu.org ([2001:4830:134:3::10]:54857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdgSH-0005XD-Ai
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdgSD-0003yX-2S
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:59:53 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:18629 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cdgSC-0003vG-HL
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:59:48 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 14 Feb 2017 19:59:29 +0300
Message-Id: <1487091579-67092-16-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 15/25] qcow2: add
 .bdrv_can_store_new_dirty_bitmap
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

Realize .bdrv_can_store_new_dirty_bitmap interface.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 40 ++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        |  1 +
 block/qcow2.h        |  4 ++++
 3 files changed, 45 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b177a95..419d51e 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1182,3 +1182,43 @@ fail:
 
     bitmap_list_free(bm_list);
 }
+
+bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                      const char *name,
+                                      uint32_t granularity,
+                                      Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+    const char *reason = NULL;
+    bool found;
+    Qcow2BitmapList *bm_list;
+
+    if (check_constraints_on_bitmap(bs, name, granularity) != 0) {
+        reason = "it doesn't satisfy the constraints";
+        goto common_errp;
+    }
+
+    if (s->nb_bitmaps == 0) {
+        return true;
+    }
+
+    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, errp);
+    if (bm_list == NULL) {
+        return false;
+    }
+
+    found = find_bitmap_by_name(bm_list, name);
+    bitmap_list_free(bm_list);
+    if (found) {
+        reason = "bitmap with the same name is already stored";
+        goto common_errp;
+    }
+
+    return true;
+
+common_errp:
+    error_setg(errp, "Can't make bitmap '%s' persistent in '%s', as %s.",
+               name, bdrv_get_device_or_node_name(bs), reason);
+    return false;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index d0e41bf..6e1fe53 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3541,6 +3541,7 @@ BlockDriver bdrv_qcow2 = {
 
     .bdrv_load_autoloading_dirty_bitmaps = qcow2_load_autoloading_dirty_bitmaps,
     .bdrv_store_persistent_dirty_bitmaps = qcow2_store_persistent_dirty_bitmaps,
+    .bdrv_can_store_new_dirty_bitmap = qcow2_can_store_new_dirty_bitmap,
 };
 
 static void bdrv_qcow2_init(void)
diff --git a/block/qcow2.h b/block/qcow2.h
index d9a7643..749710d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -616,5 +616,9 @@ void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table);
 /* qcow2-bitmap.c functions */
 void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                      const char *name,
+                                      uint32_t granularity,
+                                      Error **errp);
 
 #endif
-- 
1.8.3.1
