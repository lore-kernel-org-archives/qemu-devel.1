Received: from eggs.gnu.org ([2001:4830:134:3::10]:33807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YW8-0007e4-4J
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YW6-0004B8-Oy
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:48 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 26 Apr 2017 20:46:22 -0500
Message-Id: <20170427014626.11553-14-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-1-eblake@redhat.com>
References: <20170427014626.11553-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v10 13/17] blkdebug: Refactor error injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Rather than repeat the logic at each caller of checking if a Rule
exists that warrants an error injection, fold that logic into
inject_error(); and rename it to rule_check() for legibility.
This will help the next patch, which adds two more callers that
need to check rules for the potential of injecting errors.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>

---
v10: no change
v9: no change
v7-v8: not submitted (earlier half of series sent for 2.9)
v6: new patch
---
 block/blkdebug.c | 74 +++++++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 14d3fc5..db58db0 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -405,11 +405,30 @@ out:
     return ret;
 }

-static int inject_error(BlockDriverState *bs, BlkdebugRule *rule)
+static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes)
 {
     BDRVBlkdebugState *s = bs->opaque;
-    int error = rule->options.inject.error;
-    bool immediately = rule->options.inject.immediately;
+    BlkdebugRule *rule = NULL;
+    int error;
+    bool immediately;
+
+    QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
+        uint64_t inject_offset = rule->options.inject.offset;
+
+        if (inject_offset == -1 ||
+            (bytes && inject_offset >= offset &&
+             inject_offset < offset + bytes))
+        {
+            break;
+        }
+    }
+
+    if (!rule || !rule->options.inject.error) {
+        return 0;
+    }
+
+    immediately = rule->options.inject.immediately;
+    error = rule->options.inject.error;

     if (rule->options.inject.once) {
         QSIMPLEQ_REMOVE(&s->active_rules, rule, BlkdebugRule, active_next);
@@ -428,8 +447,7 @@ static int coroutine_fn
 blkdebug_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                    QEMUIOVector *qiov, int flags)
 {
-    BDRVBlkdebugState *s = bs->opaque;
-    BlkdebugRule *rule = NULL;
+    int err;

     /* Sanity check block layer guarantees */
     assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
@@ -438,18 +456,9 @@ blkdebug_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         assert(bytes <= bs->bl.max_transfer);
     }

-    QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
-        uint64_t inject_offset = rule->options.inject.offset;
-
-        if (inject_offset == -1 ||
-            (inject_offset >= offset && inject_offset < offset + bytes))
-        {
-            break;
-        }
-    }
-
-    if (rule && rule->options.inject.error) {
-        return inject_error(bs, rule);
+    err = rule_check(bs, offset, bytes);
+    if (err) {
+        return err;
     }

     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
@@ -459,8 +468,7 @@ static int coroutine_fn
 blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                     QEMUIOVector *qiov, int flags)
 {
-    BDRVBlkdebugState *s = bs->opaque;
-    BlkdebugRule *rule = NULL;
+    int err;

     /* Sanity check block layer guarantees */
     assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
@@ -469,18 +477,9 @@ blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         assert(bytes <= bs->bl.max_transfer);
     }

-    QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
-        uint64_t inject_offset = rule->options.inject.offset;
-
-        if (inject_offset == -1 ||
-            (inject_offset >= offset && inject_offset < offset + bytes))
-        {
-            break;
-        }
-    }
-
-    if (rule && rule->options.inject.error) {
-        return inject_error(bs, rule);
+    err = rule_check(bs, offset, bytes);
+    if (err) {
+        return err;
     }

     return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
@@ -488,17 +487,10 @@ blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,

 static int blkdebug_co_flush(BlockDriverState *bs)
 {
-    BDRVBlkdebugState *s = bs->opaque;
-    BlkdebugRule *rule = NULL;
+    int err = rule_check(bs, 0, 0);

-    QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
-        if (rule->options.inject.offset == -1) {
-            break;
-        }
-    }
-
-    if (rule && rule->options.inject.error) {
-        return inject_error(bs, rule);
+    if (err) {
+        return err;
     }

     return bdrv_co_flush(bs->file->bs);
-- 
2.9.3
