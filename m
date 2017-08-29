Received: from eggs.gnu.org ([2001:4830:134:3::10]:48056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCT-0001Hn-IR
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCQ-0005Su-L8
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34328
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCQ-0005Sh-F5
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8S7017789
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:10 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmub2wvt6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:09 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:08 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:14 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-40-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 39/79] blkdebug: Refactor error injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>

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
(cherry picked from commit d157ed5f7235f3d2d5596a514ad7507b18e24b88)
* prereq for 81c219a
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/blkdebug.c | 74 +++++++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index b2cee0c..c5d2edb 100644
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
2.7.4
