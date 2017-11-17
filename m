Received: from eggs.gnu.org ([2001:4830:134:3::10]:43384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCp-0001aa-Sa
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCo-0002fy-Ht
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:35 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:52 +0100
Message-Id: <20171117181653.20651-25-kwolf@redhat.com>
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 24/25] block: Make bdrv_next() keep strong
 references
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

From: Max Reitz <mreitz@redhat.com>

On one hand, it is a good idea for bdrv_next() to return a strong
reference because ideally nearly every pointer should be refcounted.
This fixes intermittent failure of iotest 194.

On the other, it is absolutely necessary for bdrv_next() itself to keep
a strong reference to both the BB (in its first phase) and the BDS (at
least in the second phase) because when called the next time, it will
dereference those objects to get a link to the next one.  Therefore, it
needs these objects to stay around until then.  Just storing the pointer
to the next in the iterator is not really viable because that pointer
might become invalid as well.

Both arguments taken together means we should probably just invoke
bdrv_ref() and blk_ref() in bdrv_next().  This means we have to assert
that bdrv_next() is always called from the main loop, but that was
probably necessary already before this patch and judging from the
callers, it also looks to actually be the case.

Keeping these strong references means however that callers need to give
them up if they decide to abort the iteration early.  They can do so
through the new bdrv_next_cleanup() function.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171110172545.32609-1-mreitz@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  1 +
 block.c               |  3 +++
 block/block-backend.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 block/snapshot.c      |  6 ++++++
 migration/block.c     |  1 +
 5 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index fbc21daf62..c05cac57e5 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -461,6 +461,7 @@ typedef struct BdrvNextIterator {
 
 BlockDriverState *bdrv_first(BdrvNextIterator *it);
 BlockDriverState *bdrv_next(BdrvNextIterator *it);
+void bdrv_next_cleanup(BdrvNextIterator *it);
 
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
 bool bdrv_is_encrypted(BlockDriverState *bs);
diff --git a/block.c b/block.c
index 996778cfa0..6c8ef98dfa 100644
--- a/block.c
+++ b/block.c
@@ -4255,6 +4255,7 @@ void bdrv_invalidate_cache_all(Error **errp)
         aio_context_release(aio_context);
         if (local_err) {
             error_propagate(errp, local_err);
+            bdrv_next_cleanup(&it);
             return;
         }
     }
@@ -4330,6 +4331,7 @@ int bdrv_inactivate_all(void)
         for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
             ret = bdrv_inactivate_recurse(bs, pass);
             if (ret < 0) {
+                bdrv_next_cleanup(&it);
                 goto out;
             }
         }
@@ -4864,6 +4866,7 @@ bool bdrv_is_first_non_filter(BlockDriverState *candidate)
 
         /* candidate is the first non filter */
         if (perm) {
+            bdrv_next_cleanup(&it);
             return true;
         }
     }
diff --git a/block/block-backend.c b/block/block-backend.c
index f10b1db612..5836cb3087 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -442,21 +442,37 @@ BlockBackend *blk_next(BlockBackend *blk)
  * the monitor or attached to a BlockBackend */
 BlockDriverState *bdrv_next(BdrvNextIterator *it)
 {
-    BlockDriverState *bs;
+    BlockDriverState *bs, *old_bs;
+
+    /* Must be called from the main loop */
+    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
 
     /* First, return all root nodes of BlockBackends. In order to avoid
      * returning a BDS twice when multiple BBs refer to it, we only return it
      * if the BB is the first one in the parent list of the BDS. */
     if (it->phase == BDRV_NEXT_BACKEND_ROOTS) {
+        BlockBackend *old_blk = it->blk;
+
+        old_bs = old_blk ? blk_bs(old_blk) : NULL;
+
         do {
             it->blk = blk_all_next(it->blk);
             bs = it->blk ? blk_bs(it->blk) : NULL;
         } while (it->blk && (bs == NULL || bdrv_first_blk(bs) != it->blk));
 
+        if (it->blk) {
+            blk_ref(it->blk);
+        }
+        blk_unref(old_blk);
+
         if (bs) {
+            bdrv_ref(bs);
+            bdrv_unref(old_bs);
             return bs;
         }
         it->phase = BDRV_NEXT_MONITOR_OWNED;
+    } else {
+        old_bs = it->bs;
     }
 
     /* Then return the monitor-owned BDSes without a BB attached. Ignore all
@@ -467,18 +483,46 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it)
         bs = it->bs;
     } while (bs && bdrv_has_blk(bs));
 
+    if (bs) {
+        bdrv_ref(bs);
+    }
+    bdrv_unref(old_bs);
+
     return bs;
 }
 
-BlockDriverState *bdrv_first(BdrvNextIterator *it)
+static void bdrv_next_reset(BdrvNextIterator *it)
 {
     *it = (BdrvNextIterator) {
         .phase = BDRV_NEXT_BACKEND_ROOTS,
     };
+}
 
+BlockDriverState *bdrv_first(BdrvNextIterator *it)
+{
+    bdrv_next_reset(it);
     return bdrv_next(it);
 }
 
+/* Must be called when aborting a bdrv_next() iteration before
+ * bdrv_next() returns NULL */
+void bdrv_next_cleanup(BdrvNextIterator *it)
+{
+    /* Must be called from the main loop */
+    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
+
+    if (it->phase == BDRV_NEXT_BACKEND_ROOTS) {
+        if (it->blk) {
+            bdrv_unref(blk_bs(it->blk));
+            blk_unref(it->blk);
+        }
+    } else {
+        bdrv_unref(it->bs);
+    }
+
+    bdrv_next_reset(it);
+}
+
 /*
  * Add a BlockBackend into the list of backends referenced by the monitor, with
  * the given @name acting as the handle for the monitor.
diff --git a/block/snapshot.c b/block/snapshot.c
index 1d5ab5f90f..be0743abac 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -417,6 +417,7 @@ bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs)
         }
         aio_context_release(ctx);
         if (!ok) {
+            bdrv_next_cleanup(&it);
             goto fail;
         }
     }
@@ -444,6 +445,7 @@ int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
         }
         aio_context_release(ctx);
         if (ret < 0) {
+            bdrv_next_cleanup(&it);
             goto fail;
         }
     }
@@ -469,6 +471,7 @@ int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs)
         }
         aio_context_release(ctx);
         if (err < 0) {
+            bdrv_next_cleanup(&it);
             goto fail;
         }
     }
@@ -494,6 +497,7 @@ int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs)
         }
         aio_context_release(ctx);
         if (err < 0) {
+            bdrv_next_cleanup(&it);
             goto fail;
         }
     }
@@ -525,6 +529,7 @@ int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
         }
         aio_context_release(ctx);
         if (err < 0) {
+            bdrv_next_cleanup(&it);
             goto fail;
         }
     }
@@ -548,6 +553,7 @@ BlockDriverState *bdrv_all_find_vmstate_bs(void)
         aio_context_release(ctx);
 
         if (found) {
+            bdrv_next_cleanup(&it);
             break;
         }
     }
diff --git a/migration/block.c b/migration/block.c
index 3282809583..7147171bb7 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -415,6 +415,7 @@ static int init_blk_migration(QEMUFile *f)
         sectors = bdrv_nb_sectors(bs);
         if (sectors <= 0) {
             ret = sectors;
+            bdrv_next_cleanup(&it);
             goto out;
         }
 
-- 
2.13.6
