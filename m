Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB668C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9486C26C31
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9486C26C31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46165 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkUA-00087p-QF
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:34:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWkRu-0006mT-JD
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWkRs-0008DJ-LD
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:32:10 -0400
Received: from relay.sw.ru ([185.231.240.75]:57228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hWkRs-0008Ab-9L; Fri, 31 May 2019 12:32:08 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hWkRn-0006Lb-9a; Fri, 31 May 2019 19:32:03 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 31 May 2019 19:31:54 +0300
Message-Id: <20190531163202.162543-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190531163202.162543-1-vsementsov@virtuozzo.com>
References: <20190531163202.162543-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 1/9] block: add
 .bdrv_need_rw_file_child_during_reopen_rw handler
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On reopen to rw parent may need rw access to child in .prepare, for
example qcow2 needs to write IN_USE flags into stored bitmaps
(currently it is done in a hacky way after commit and don't work).
So, let's introduce such logic.

The drawback is that in worst case bdrv_reopen_set_read_only may finish
with error and in some intermediate state: some nodes reopened RW and
some are not. But this is a way to fix bug around reopening qcow2
bitmaps in the following commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |   2 +
 block.c                   | 144 ++++++++++++++++++++++++++++++++++----
 2 files changed, 133 insertions(+), 13 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1eebc7c8f3..7b22fb5d9c 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -531,6 +531,8 @@ struct BlockDriver {
                              uint64_t parent_perm, uint64_t parent_shared,
                              uint64_t *nperm, uint64_t *nshared);
 
+     bool (*bdrv_need_rw_file_child_during_reopen_rw)(BlockDriverState *bs);
+
     /**
      * Bitmaps should be marked as 'IN_USE' in the image on reopening image
      * as rw. This handler should realize it. It also should unset readonly
diff --git a/block.c b/block.c
index 1a73e310c1..56e1388908 100644
--- a/block.c
+++ b/block.c
@@ -1713,10 +1713,12 @@ static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
                                      uint64_t *shared_perm);
 
 typedef struct BlockReopenQueueEntry {
-     bool prepared;
-     bool perms_checked;
-     BDRVReopenState state;
-     QSIMPLEQ_ENTRY(BlockReopenQueueEntry) entry;
+    bool reopened_file_child_rw;
+    bool changed_file_child_perm_rw;
+    bool prepared;
+    bool perms_checked;
+    BDRVReopenState state;
+    QSIMPLEQ_ENTRY(BlockReopenQueueEntry) entry;
 } BlockReopenQueueEntry;
 
 /*
@@ -3278,6 +3280,105 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                    keep_old_opts);
 }
 
+static int bdrv_reopen_set_read_only_drained(BlockDriverState *bs,
+                                             bool read_only,
+                                             Error **errp)
+{
+    BlockReopenQueue *queue;
+    QDict *opts = qdict_new();
+
+    qdict_put_bool(opts, BDRV_OPT_READ_ONLY, read_only);
+
+    queue = bdrv_reopen_queue(NULL, bs, opts, true);
+
+    return bdrv_reopen_multiple(queue, errp);
+}
+
+/*
+ * handle_recursive_reopens
+ *
+ * On fail it needs rollback_recursive_reopens to be called.
+ */
+static int handle_recursive_reopens(BlockReopenQueueEntry *current,
+                                    Error **errp)
+{
+    int ret;
+    BlockDriverState *bs = current->state.bs;
+
+    /*
+     * We use the fact that in reopen-queue children are always following
+     * parents.
+     * TODO: Switch BlockReopenQueue to be QTAILQ and use
+     *       QTAILQ_FOREACH_REVERSE.
+     */
+    if (QSIMPLEQ_NEXT(current, entry)) {
+        ret = handle_recursive_reopens(QSIMPLEQ_NEXT(current, entry), errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    if ((current->state.flags & BDRV_O_RDWR) && bs->file && bs->drv &&
+        bs->drv->bdrv_need_rw_file_child_during_reopen_rw &&
+        bs->drv->bdrv_need_rw_file_child_during_reopen_rw(bs))
+    {
+        if (!bdrv_is_writable(bs->file->bs)) {
+            ret = bdrv_reopen_set_read_only_drained(bs->file->bs, false, errp);
+            if (ret < 0) {
+                return ret;
+            }
+            current->reopened_file_child_rw = true;
+        }
+
+        if (!(bs->file->perm & BLK_PERM_WRITE)) {
+            ret = bdrv_child_try_set_perm(bs->file,
+                                          bs->file->perm | BLK_PERM_WRITE,
+                                          bs->file->shared_perm, errp);
+            if (ret < 0) {
+                return ret;
+            }
+            current->changed_file_child_perm_rw = true;
+        }
+    }
+
+    return 0;
+}
+
+static int rollback_recursive_reopens(BlockReopenQueue *bs_queue,
+                                      Error **errp)
+{
+    int ret;
+    BlockReopenQueueEntry *bs_entry;
+
+    /*
+     * We use the fact that in reopen-queue children are always following
+     * parents.
+     */
+    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+        BlockDriverState *bs = bs_entry->state.bs;
+
+        if (bs_entry->changed_file_child_perm_rw) {
+            ret = bdrv_child_try_set_perm(bs->file,
+                                          bs->file->perm & ~BLK_PERM_WRITE,
+                                          bs->file->shared_perm, errp);
+
+            if (ret < 0) {
+                return ret;
+            }
+        }
+
+        if (bs_entry->reopened_file_child_rw) {
+            ret = bdrv_reopen_set_read_only_drained(bs, true, errp);
+
+            if (ret < 0) {
+                return ret;
+            }
+        }
+    }
+
+    return 0;
+}
+
 /*
  * Reopen multiple BlockDriverStates atomically & transactionally.
  *
@@ -3297,11 +3398,18 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
  */
 int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
 {
-    int ret = -1;
+    int ret;
     BlockReopenQueueEntry *bs_entry, *next;
 
     assert(bs_queue != NULL);
 
+    ret = handle_recursive_reopens(QSIMPLEQ_FIRST(bs_queue), errp);
+    if (ret < 0) {
+        goto rollback_recursion;
+    }
+
+    ret = -1;
+
     QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
         assert(bs_entry->state.bs->quiesce_counter > 0);
         if (bdrv_reopen_prepare(&bs_entry->state, bs_queue, errp)) {
@@ -3342,7 +3450,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
 
     ret = 0;
 cleanup_perm:
-    QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
+    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
         BDRVReopenState *state = &bs_entry->state;
 
         if (!bs_entry->perms_checked) {
@@ -3359,7 +3467,7 @@ cleanup_perm:
         }
     }
 cleanup:
-    QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
+    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
         if (ret) {
             if (bs_entry->prepared) {
                 bdrv_reopen_abort(&bs_entry->state);
@@ -3370,8 +3478,23 @@ cleanup:
         if (bs_entry->state.new_backing_bs) {
             bdrv_unref(bs_entry->state.new_backing_bs);
         }
+    }
+
+rollback_recursion:
+    if (ret) {
+        Error *local_err = NULL;
+        int ret2 = rollback_recursive_reopens(bs_queue, &local_err);
+
+        if (ret2 < 0) {
+            error_reportf_err(local_err, "Failed to rollback partially "
+                              "succeeded reopen to RW: ");
+        }
+    }
+
+    QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
         g_free(bs_entry);
     }
+
     g_free(bs_queue);
 
     return ret;
@@ -3381,14 +3504,9 @@ int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
                               Error **errp)
 {
     int ret;
-    BlockReopenQueue *queue;
-    QDict *opts = qdict_new();
-
-    qdict_put_bool(opts, BDRV_OPT_READ_ONLY, read_only);
 
     bdrv_subtree_drained_begin(bs);
-    queue = bdrv_reopen_queue(NULL, bs, opts, true);
-    ret = bdrv_reopen_multiple(queue, errp);
+    ret = bdrv_reopen_set_read_only_drained(bs, read_only, errp);
     bdrv_subtree_drained_end(bs);
 
     return ret;
-- 
2.18.0


