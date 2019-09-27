Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B15C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101B620872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101B620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDqhx-0000Ag-OW
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 09:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDqCl-0003Zv-8E
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDqCj-0000L6-RR
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:22:39 -0400
Received: from relay.sw.ru ([185.231.240.75]:49752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDqCg-0000IU-FS; Fri, 27 Sep 2019 09:22:34 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDpHx-0003za-It; Fri, 27 Sep 2019 15:23:57 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 1/9] block: switch reopen queue from QSIMPLEQ to QTAILQ
Date: Fri, 27 Sep 2019 15:23:47 +0300
Message-Id: <20190927122355.7344-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927122355.7344-1-vsementsov@virtuozzo.com>
References: <20190927122355.7344-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We'll need reverse-foreach in the following commit, QTAILQ support it,
so move to QTAILQ.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  2 +-
 block.c               | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 37c9de7446..f509943513 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -195,7 +195,7 @@ typedef struct HDGeometry {
 #define BDRV_BLOCK_EOF          0x20
 #define BDRV_BLOCK_RECURSE      0x40
 
-typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
+typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 
 typedef struct BDRVReopenState {
     BlockDriverState *bs;
diff --git a/block.c b/block.c
index 5944124845..6a3b33f1ec 100644
--- a/block.c
+++ b/block.c
@@ -1719,7 +1719,7 @@ typedef struct BlockReopenQueueEntry {
      bool prepared;
      bool perms_checked;
      BDRVReopenState state;
-     QSIMPLEQ_ENTRY(BlockReopenQueueEntry) entry;
+     QTAILQ_ENTRY(BlockReopenQueueEntry) entry;
 } BlockReopenQueueEntry;
 
 /*
@@ -1732,7 +1732,7 @@ static int bdrv_reopen_get_flags(BlockReopenQueue *q, BlockDriverState *bs)
     BlockReopenQueueEntry *entry;
 
     if (q != NULL) {
-        QSIMPLEQ_FOREACH(entry, q, entry) {
+        QTAILQ_FOREACH(entry, q, entry) {
             if (entry->state.bs == bs) {
                 return entry->state.flags;
             }
@@ -3249,7 +3249,7 @@ static bool bdrv_recurse_has_child(BlockDriverState *bs,
  * Adds a BlockDriverState to a simple queue for an atomic, transactional
  * reopen of multiple devices.
  *
- * bs_queue can either be an existing BlockReopenQueue that has had QSIMPLE_INIT
+ * bs_queue can either be an existing BlockReopenQueue that has had QTAILQ_INIT
  * already performed, or alternatively may be NULL a new BlockReopenQueue will
  * be created and initialized. This newly created BlockReopenQueue should be
  * passed back in for subsequent calls that are intended to be of the same
@@ -3290,7 +3290,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
 
     if (bs_queue == NULL) {
         bs_queue = g_new0(BlockReopenQueue, 1);
-        QSIMPLEQ_INIT(bs_queue);
+        QTAILQ_INIT(bs_queue);
     }
 
     if (!options) {
@@ -3298,7 +3298,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     }
 
     /* Check if this BlockDriverState is already in the queue */
-    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
         if (bs == bs_entry->state.bs) {
             break;
         }
@@ -3354,7 +3354,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
 
     if (!bs_entry) {
         bs_entry = g_new0(BlockReopenQueueEntry, 1);
-        QSIMPLEQ_INSERT_TAIL(bs_queue, bs_entry, entry);
+        QTAILQ_INSERT_TAIL(bs_queue, bs_entry, entry);
     } else {
         qobject_unref(bs_entry->state.options);
         qobject_unref(bs_entry->state.explicit_options);
@@ -3455,7 +3455,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
 
     assert(bs_queue != NULL);
 
-    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
         assert(bs_entry->state.bs->quiesce_counter > 0);
         if (bdrv_reopen_prepare(&bs_entry->state, bs_queue, errp)) {
             goto cleanup;
@@ -3463,7 +3463,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
         bs_entry->prepared = true;
     }
 
-    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
         BDRVReopenState *state = &bs_entry->state;
         ret = bdrv_check_perm(state->bs, bs_queue, state->perm,
                               state->shared_perm, NULL, NULL, errp);
@@ -3489,13 +3489,13 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
     /* If we reach this point, we have success and just need to apply the
      * changes
      */
-    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
         bdrv_reopen_commit(&bs_entry->state);
     }
 
     ret = 0;
 cleanup_perm:
-    QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
+    QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
         BDRVReopenState *state = &bs_entry->state;
 
         if (!bs_entry->perms_checked) {
@@ -3512,7 +3512,7 @@ cleanup_perm:
         }
     }
 cleanup:
-    QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
+    QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
         if (ret) {
             if (bs_entry->prepared) {
                 bdrv_reopen_abort(&bs_entry->state);
@@ -3552,7 +3552,7 @@ static BlockReopenQueueEntry *find_parent_in_reopen_queue(BlockReopenQueue *q,
 {
     BlockReopenQueueEntry *entry;
 
-    QSIMPLEQ_FOREACH(entry, q, entry) {
+    QTAILQ_FOREACH(entry, q, entry) {
         BlockDriverState *bs = entry->state.bs;
         BdrvChild *child;
 
-- 
2.21.0


