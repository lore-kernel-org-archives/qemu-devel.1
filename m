Received: from eggs.gnu.org ([2001:4830:134:3::10]:45669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRC7-0006YG-UA
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRC6-0002l0-Ju
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:36:35 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Mar 2018 17:36:14 +0100
Message-Id: <20180301163619.21072-4-pbonzini@redhat.com>
In-Reply-To: <20180301163619.21072-1-pbonzini@redhat.com>
References: <20180301163619.21072-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/8] qcow2: introduce qcow2_write_caches and
 qcow2_flush_caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

They will be used to avoid recursively taking s->lock during
bdrv_open or bdrv_check.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1516279431-30424-7-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qcow2-refcount.c | 28 ++++++++++++++++++++++++++++
 block/qcow2.c          | 20 ++++----------------
 block/qcow2.h          |  2 ++
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 92701ab7af..6482ade7fa 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1172,7 +1172,35 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
     }
 }
 
+int coroutine_fn qcow2_write_caches(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
 
+    ret = qcow2_cache_write(bs, s->l2_table_cache);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (qcow2_need_accurate_refcounts(s)) {
+        ret = qcow2_cache_write(bs, s->refcount_block_cache);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+int coroutine_fn qcow2_flush_caches(BlockDriverState *bs)
+{
+    int ret = qcow2_write_caches(bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return bdrv_flush(bs->file->bs);
+}
 
 /*********************************************************/
 /* snapshots and image creation */
diff --git a/block/qcow2.c b/block/qcow2.c
index 24edbb431b..4c216ecd63 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -502,7 +502,7 @@ static int qcow2_mark_clean(BlockDriverState *bs)
 
         s->incompatible_features &= ~QCOW2_INCOMPAT_DIRTY;
 
-        ret = bdrv_flush(bs);
+        ret = qcow2_flush_caches(bs);
         if (ret < 0) {
             return ret;
         }
@@ -532,7 +532,7 @@ int qcow2_mark_consistent(BlockDriverState *bs)
     BDRVQcow2State *s = bs->opaque;
 
     if (s->incompatible_features & QCOW2_INCOMPAT_CORRUPT) {
-        int ret = bdrv_flush(bs);
+        int ret = qcow2_flush_caches(bs);
         if (ret < 0) {
             return ret;
         }
@@ -3624,22 +3624,10 @@ static coroutine_fn int qcow2_co_flush_to_os(BlockDriverState *bs)
     int ret;
 
     qemu_co_mutex_lock(&s->lock);
-    ret = qcow2_cache_write(bs, s->l2_table_cache);
-    if (ret < 0) {
-        qemu_co_mutex_unlock(&s->lock);
-        return ret;
-    }
-
-    if (qcow2_need_accurate_refcounts(s)) {
-        ret = qcow2_cache_write(bs, s->refcount_block_cache);
-        if (ret < 0) {
-            qemu_co_mutex_unlock(&s->lock);
-            return ret;
-        }
-    }
+    ret = qcow2_write_caches(bs);
     qemu_co_mutex_unlock(&s->lock);
 
-    return 0;
+    return ret;
 }
 
 static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
diff --git a/block/qcow2.h b/block/qcow2.h
index 46c8cf44ec..25b50f8c01 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -570,6 +570,8 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
 int qcow2_update_snapshot_refcount(BlockDriverState *bs,
     int64_t l1_table_offset, int l1_size, int addend);
 
+int coroutine_fn qcow2_flush_caches(BlockDriverState *bs);
+int coroutine_fn qcow2_write_caches(BlockDriverState *bs);
 int qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                           BdrvCheckMode fix);
 
-- 
2.14.3
