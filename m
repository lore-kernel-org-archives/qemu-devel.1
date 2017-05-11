Received: from eggs.gnu.org ([2001:4830:134:3::10]:37153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAl-0002fu-OI
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAk-0007tf-F7
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:44 +0200
Message-Id: <1494513181-7900-42-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 41/58] blkdebug: Refactor error injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Rather than repeat the logic at each caller of checking if a Rule
exists that warrants an error injection, fold that logic into
inject_error(); and rename it to rule_check() for legibility.
This will help the next patch, which adds two more callers that
need to check rules for the potential of injecting errors.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170429191419.30051-6-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkdebug.c | 74 +++++++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index a562e2e..554573f 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -403,11 +403,30 @@ out:
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
@@ -426,8 +445,7 @@ static int coroutine_fn
 blkdebug_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                    QEMUIOVector *qiov, int flags)
 {
-    BDRVBlkdebugState *s = bs->opaque;
-    BlkdebugRule *rule = NULL;
+    int err;
 
     /* Sanity check block layer guarantees */
     assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
@@ -436,18 +454,9 @@ blkdebug_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
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
@@ -457,8 +466,7 @@ static int coroutine_fn
 blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                     QEMUIOVector *qiov, int flags)
 {
-    BDRVBlkdebugState *s = bs->opaque;
-    BlkdebugRule *rule = NULL;
+    int err;
 
     /* Sanity check block layer guarantees */
     assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
@@ -467,18 +475,9 @@ blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
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
@@ -486,17 +485,10 @@ blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
 
 static int blkdebug_co_flush(BlockDriverState *bs)
 {
-    BDRVBlkdebugState *s = bs->opaque;
-    BlkdebugRule *rule = NULL;
-
-    QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
-        if (rule->options.inject.offset == -1) {
-            break;
-        }
-    }
+    int err = rule_check(bs, 0, 0);
 
-    if (rule && rule->options.inject.error) {
-        return inject_error(bs, rule);
+    if (err) {
+        return err;
     }
 
     return bdrv_co_flush(bs->file->bs);
-- 
1.8.3.1
