Received: from eggs.gnu.org ([2001:4830:134:3::10]:33119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkk-0000ob-35
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkh-0006Vg-95
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:39 +0100
Message-Id: <20180309161933.8168-3-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/56] qcow2: introduce qcow2_write_caches and
 qcow2_flush_caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

They will be used to avoid recursively taking s->lock during
bdrv_open or bdrv_check.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1516279431-30424-7-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h          |  2 ++
 block/qcow2-refcount.c | 28 ++++++++++++++++++++++++++++
 block/qcow2.c          | 20 ++++----------------
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 1a84cc77b0..965846f7af 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -576,6 +576,8 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
 int qcow2_update_snapshot_refcount(BlockDriverState *bs,
     int64_t l1_table_offset, int l1_size, int addend);
 
+int coroutine_fn qcow2_flush_caches(BlockDriverState *bs);
+int coroutine_fn qcow2_write_caches(BlockDriverState *bs);
 int qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                           BdrvCheckMode fix);
 
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 126cca3276..2f7e710fa6 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1171,7 +1171,35 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
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
index 071dc4d608..ee040a49cd 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -500,7 +500,7 @@ static int qcow2_mark_clean(BlockDriverState *bs)
 
         s->incompatible_features &= ~QCOW2_INCOMPAT_DIRTY;
 
-        ret = bdrv_flush(bs);
+        ret = qcow2_flush_caches(bs);
         if (ret < 0) {
             return ret;
         }
@@ -530,7 +530,7 @@ int qcow2_mark_consistent(BlockDriverState *bs)
     BDRVQcow2State *s = bs->opaque;
 
     if (s->incompatible_features & QCOW2_INCOMPAT_CORRUPT) {
-        int ret = bdrv_flush(bs);
+        int ret = qcow2_flush_caches(bs);
         if (ret < 0) {
             return ret;
         }
@@ -3647,22 +3647,10 @@ static coroutine_fn int qcow2_co_flush_to_os(BlockDriverState *bs)
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
-- 
2.13.6
