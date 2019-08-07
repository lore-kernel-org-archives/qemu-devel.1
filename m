Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48455C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D9C21E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D9C21E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMjH-0007Kh-Cz
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36666)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg9-0007q4-4w
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg7-0003LB-Ra
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:37 -0400
Received: from relay.sw.ru ([185.231.240.75]:40648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMg4-0003Cw-Bk; Wed, 07 Aug 2019 10:12:32 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMfz-0005oH-B8; Wed, 07 Aug 2019 17:12:27 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 17:12:17 +0300
Message-Id: <20190807141226.193501-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807141226.193501-1-vsementsov@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 01/10] block: switch reopen queue from
 QSIMPLEQ to QTAILQ
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
---
 include/block/block.h |  2 +-
 block.c               | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 50a07c1c33..3d84b2a2c9 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -192,7 +192,7 @@ typedef struct HDGeometry {
 #define BDRV_BLOCK_RECURSE      0x40
 #define BDRV_BLOCK_OFFSET_MASK  BDRV_SECTOR_MASK
 
-typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
+typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 
 typedef struct BDRVReopenState {
     BlockDriverState *bs;
diff --git a/block.c b/block.c
index cbd8da5f3b..696162cd7a 100644
--- a/block.c
+++ b/block.c
@@ -1718,7 +1718,7 @@ typedef struct BlockReopenQueueEntry {
      bool prepared;
      bool perms_checked;
      BDRVReopenState state;
-     QSIMPLEQ_ENTRY(BlockReopenQueueEntry) entry;
+     QTAILQ_ENTRY(BlockReopenQueueEntry) entry;
 } BlockReopenQueueEntry;
 
 /*
@@ -1731,7 +1731,7 @@ static int bdrv_reopen_get_flags(BlockReopenQueue *q, BlockDriverState *bs)
     BlockReopenQueueEntry *entry;
 
     if (q != NULL) {
-        QSIMPLEQ_FOREACH(entry, q, entry) {
+        QTAILQ_FOREACH(entry, q, entry) {
             if (entry->state.bs == bs) {
                 return entry->state.flags;
             }
@@ -3280,7 +3280,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
 
     if (bs_queue == NULL) {
         bs_queue = g_new0(BlockReopenQueue, 1);
-        QSIMPLEQ_INIT(bs_queue);
+        QTAILQ_INIT(bs_queue);
     }
 
     if (!options) {
@@ -3288,7 +3288,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     }
 
     /* Check if this BlockDriverState is already in the queue */
-    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
         if (bs == bs_entry->state.bs) {
             break;
         }
@@ -3344,7 +3344,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
 
     if (!bs_entry) {
         bs_entry = g_new0(BlockReopenQueueEntry, 1);
-        QSIMPLEQ_INSERT_TAIL(bs_queue, bs_entry, entry);
+        QTAILQ_INSERT_TAIL(bs_queue, bs_entry, entry);
     } else {
         qobject_unref(bs_entry->state.options);
         qobject_unref(bs_entry->state.explicit_options);
@@ -3445,7 +3445,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
 
     assert(bs_queue != NULL);
 
-    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
         assert(bs_entry->state.bs->quiesce_counter > 0);
         if (bdrv_reopen_prepare(&bs_entry->state, bs_queue, errp)) {
             goto cleanup;
@@ -3453,7 +3453,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
         bs_entry->prepared = true;
     }
 
-    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
         BDRVReopenState *state = &bs_entry->state;
         ret = bdrv_check_perm(state->bs, bs_queue, state->perm,
                               state->shared_perm, NULL, NULL, errp);
@@ -3479,13 +3479,13 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
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
@@ -3502,7 +3502,7 @@ cleanup_perm:
         }
     }
 cleanup:
-    QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
+    QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
         if (ret) {
             if (bs_entry->prepared) {
                 bdrv_reopen_abort(&bs_entry->state);
@@ -3542,7 +3542,7 @@ static BlockReopenQueueEntry *find_parent_in_reopen_queue(BlockReopenQueue *q,
 {
     BlockReopenQueueEntry *entry;
 
-    QSIMPLEQ_FOREACH(entry, q, entry) {
+    QTAILQ_FOREACH(entry, q, entry) {
         BlockDriverState *bs = entry->state.bs;
         BdrvChild *child;
 
-- 
2.18.0


