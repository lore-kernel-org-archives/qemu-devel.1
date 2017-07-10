Received: from eggs.gnu.org ([2001:4830:134:3::10]:58348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUc19-00045V-MM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUc18-00031M-Qx
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUc18-000318-Ir
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5600EC05678E
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 16:58:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Jul 2017 18:58:26 +0200
Message-Id: <20170710165827.4250-5-pbonzini@redhat.com>
In-Reply-To: <20170710165827.4250-1-pbonzini@redhat.com>
References: <20170710165827.4250-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] qcow2: introduce qcow2_write_caches and
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
Cc: marcandre.lureau@redhat.com, kwolf@redhat.com

Avoid recursively taking s->lock during bdrv_check.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qcow2-refcount.c | 28 ++++++++++++++++++++++++++++
 block/qcow2.c          | 20 ++++----------------
 block/qcow2.h          |  2 ++
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 7c06061aae..57bf91422b 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1046,7 +1046,35 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
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
index 4ff7e89009..9bab0d3012 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -278,7 +278,7 @@ static int qcow2_mark_clean(BlockDriverState *bs)
 
         s->incompatible_features &= ~QCOW2_INCOMPAT_DIRTY;
 
-        ret = bdrv_flush(bs);
+        ret = qcow2_flush_caches(bs);
         if (ret < 0) {
             return ret;
         }
@@ -308,7 +308,7 @@ int qcow2_mark_consistent(BlockDriverState *bs)
     BDRVQcow2State *s = bs->opaque;
 
     if (s->incompatible_features & QCOW2_INCOMPAT_CORRUPT) {
-        int ret = bdrv_flush(bs);
+        int ret = qcow2_flush_caches(bs);
         if (ret < 0) {
             return ret;
         }
@@ -2968,22 +2968,10 @@ static coroutine_fn int qcow2_co_flush_to_os(BlockDriverState *bs)
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
 
 static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
diff --git a/block/qcow2.h b/block/qcow2.h
index 87b15eb4aa..1d3fffd8ac 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -525,6 +525,8 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
 int qcow2_update_snapshot_refcount(BlockDriverState *bs,
     int64_t l1_table_offset, int l1_size, int addend);
 
+int coroutine_fn qcow2_flush_caches(BlockDriverState *bs);
+int coroutine_fn qcow2_write_caches(BlockDriverState *bs);
 int qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                           BdrvCheckMode fix);
 
-- 
2.13.0
