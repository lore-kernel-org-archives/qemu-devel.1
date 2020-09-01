Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA26C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251652078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxvtS8R1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251652078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7g9-0004hQ-9b
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7O0-0001KW-4r
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54903
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7Nx-0007MF-Vf
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVww9NiJBTRhN7L6c4XDX9cAcrKjVvPCDDfz7ZSzCdU=;
 b=TxvtS8R13HhesGKU0tsQP3UszG/ZKOh21Zi4rTAiCR37rI2/jJJsNLDw1hihi6GsfCJc9q
 78wZNbtdEBMdeALRy594rMJ/+4xSRWRinr54oZx9wIIf29Gjtd2piaJv1iI0zMK0mDzQwb
 KP8FZaWAP+4+XyZ+kNqGfloodHHAHoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-BVj0vwWSPdm4-xmt383PHw-1; Tue, 01 Sep 2020 10:35:43 -0400
X-MC-Unique: BVj0vwWSPdm4-xmt383PHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40A3F802B49;
 Tue,  1 Sep 2020 14:35:42 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABAC461177;
 Tue,  1 Sep 2020 14:35:41 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 31/43] commit: Deal with filters
Date: Tue,  1 Sep 2020 16:34:12 +0200
Message-Id: <20200901143424.884735-32-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes some permission limiting (for example, we only need to
take the RESIZE permission if the base is smaller than the top).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-backend.c          |  7 ++-
 block/commit.c                 | 94 +++++++++++++++++++++++++---------
 block/monitor/block-hmp-cmds.c |  2 +-
 blockdev.c                     |  4 +-
 4 files changed, 79 insertions(+), 28 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 3a13cb5f0b..24dd0670d1 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2279,10 +2279,13 @@ int blk_commit_all(void)
 
     while ((blk = blk_all_next(blk)) != NULL) {
         AioContext *aio_context = blk_get_aio_context(blk);
+        BlockDriverState *unfiltered_bs = bdrv_skip_filters(blk_bs(blk));
 
         aio_context_acquire(aio_context);
-        if (blk_is_inserted(blk) && blk->root->bs->backing) {
-            int ret = bdrv_commit(blk->root->bs);
+        if (blk_is_inserted(blk) && bdrv_cow_child(unfiltered_bs)) {
+            int ret;
+
+            ret = bdrv_commit(unfiltered_bs);
             if (ret < 0) {
                 aio_context_release(aio_context);
                 return ret;
diff --git a/block/commit.c b/block/commit.c
index 7732d02dfe..2b9929aed9 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -37,6 +37,7 @@ typedef struct CommitBlockJob {
     BlockBackend *top;
     BlockBackend *base;
     BlockDriverState *base_bs;
+    BlockDriverState *base_overlay;
     BlockdevOnError on_error;
     bool base_read_only;
     bool chain_frozen;
@@ -89,7 +90,7 @@ static void commit_abort(Job *job)
      * XXX Can (or should) we somehow keep 'consistent read' blocked even
      * after the failed/cancelled commit job is gone? If we already wrote
      * something to base, the intermediate images aren't valid any more. */
-    bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
+    bdrv_replace_node(s->commit_top_bs, s->commit_top_bs->backing->bs,
                       &error_abort);
 
     bdrv_unref(s->commit_top_bs);
@@ -153,7 +154,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
             break;
         }
         /* Copy if allocated above the base */
-        ret = bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base), false,
+        ret = bdrv_is_allocated_above(blk_bs(s->top), s->base_overlay, true,
                                       offset, COMMIT_BUFFER_SIZE, &n);
         copy = (ret == 1);
         trace_commit_one_iteration(s, offset, n, ret);
@@ -253,15 +254,35 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     CommitBlockJob *s;
     BlockDriverState *iter;
     BlockDriverState *commit_top_bs = NULL;
+    BlockDriverState *filtered_base;
     Error *local_err = NULL;
+    int64_t base_size, top_size;
+    uint64_t base_perms, iter_shared_perms;
     int ret;
 
     assert(top != bs);
-    if (top == base) {
+    if (bdrv_skip_filters(top) == bdrv_skip_filters(base)) {
         error_setg(errp, "Invalid files for merge: top and base are the same");
         return;
     }
 
+    base_size = bdrv_getlength(base);
+    if (base_size < 0) {
+        error_setg_errno(errp, -base_size, "Could not inquire base image size");
+        return;
+    }
+
+    top_size = bdrv_getlength(top);
+    if (top_size < 0) {
+        error_setg_errno(errp, -top_size, "Could not inquire top image size");
+        return;
+    }
+
+    base_perms = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
+    if (base_size < top_size) {
+        base_perms |= BLK_PERM_RESIZE;
+    }
+
     s = block_job_create(job_id, &commit_job_driver, NULL, bs, 0, BLK_PERM_ALL,
                          speed, creation_flags, NULL, NULL, errp);
     if (!s) {
@@ -301,17 +322,43 @@ void commit_start(const char *job_id, BlockDriverState *bs,
 
     s->commit_top_bs = commit_top_bs;
 
-    /* Block all nodes between top and base, because they will
-     * disappear from the chain after this operation. */
-    assert(bdrv_chain_contains(top, base));
-    for (iter = top; iter != base; iter = backing_bs(iter)) {
-        /* XXX BLK_PERM_WRITE needs to be allowed so we don't block ourselves
-         * at s->base (if writes are blocked for a node, they are also blocked
-         * for its backing file). The other options would be a second filter
-         * driver above s->base. */
+    /*
+     * Block all nodes between top and base, because they will
+     * disappear from the chain after this operation.
+     * Note that this assumes that the user is fine with removing all
+     * nodes (including R/W filters) between top and base.  Assuring
+     * this is the responsibility of the interface (i.e. whoever calls
+     * commit_start()).
+     */
+    s->base_overlay = bdrv_find_overlay(top, base);
+    assert(s->base_overlay);
+
+    /*
+     * The topmost node with
+     * bdrv_skip_filters(filtered_base) == bdrv_skip_filters(base)
+     */
+    filtered_base = bdrv_cow_bs(s->base_overlay);
+    assert(bdrv_skip_filters(filtered_base) == bdrv_skip_filters(base));
+
+    /*
+     * XXX BLK_PERM_WRITE needs to be allowed so we don't block ourselves
+     * at s->base (if writes are blocked for a node, they are also blocked
+     * for its backing file). The other options would be a second filter
+     * driver above s->base.
+     */
+    iter_shared_perms = BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
+
+    for (iter = top; iter != base; iter = bdrv_filter_or_cow_bs(iter)) {
+        if (iter == filtered_base) {
+            /*
+             * From here on, all nodes are filters on the base.  This
+             * allows us to share BLK_PERM_CONSISTENT_READ.
+             */
+            iter_shared_perms |= BLK_PERM_CONSISTENT_READ;
+        }
+
         ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
-                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE,
-                                 errp);
+                                 iter_shared_perms, errp);
         if (ret < 0) {
             goto fail;
         }
@@ -328,9 +375,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     }
 
     s->base = blk_new(s->common.job.aio_context,
-                      BLK_PERM_CONSISTENT_READ
-                      | BLK_PERM_WRITE
-                      | BLK_PERM_RESIZE,
+                      base_perms,
                       BLK_PERM_CONSISTENT_READ
                       | BLK_PERM_GRAPH_MOD
                       | BLK_PERM_WRITE_UNCHANGED);
@@ -398,19 +443,22 @@ int bdrv_commit(BlockDriverState *bs)
     if (!drv)
         return -ENOMEDIUM;
 
-    if (!bs->backing) {
+    backing_file_bs = bdrv_cow_bs(bs);
+
+    if (!backing_file_bs) {
         return -ENOTSUP;
     }
 
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_COMMIT_SOURCE, NULL) ||
-        bdrv_op_is_blocked(bs->backing->bs, BLOCK_OP_TYPE_COMMIT_TARGET, NULL)) {
+        bdrv_op_is_blocked(backing_file_bs, BLOCK_OP_TYPE_COMMIT_TARGET, NULL))
+    {
         return -EBUSY;
     }
 
-    ro = bs->backing->bs->read_only;
+    ro = backing_file_bs->read_only;
 
     if (ro) {
-        if (bdrv_reopen_set_read_only(bs->backing->bs, false, NULL)) {
+        if (bdrv_reopen_set_read_only(backing_file_bs, false, NULL)) {
             return -EACCES;
         }
     }
@@ -428,8 +476,6 @@ int bdrv_commit(BlockDriverState *bs)
     }
 
     /* Insert commit_top block node above backing, so we can write to it */
-    backing_file_bs = backing_bs(bs);
-
     commit_top_bs = bdrv_new_open_driver(&bdrv_commit_top, NULL, BDRV_O_RDWR,
                                          &local_err);
     if (commit_top_bs == NULL) {
@@ -515,7 +561,7 @@ ro_cleanup:
     qemu_vfree(buf);
 
     blk_unref(backing);
-    if (backing_file_bs) {
+    if (bdrv_cow_bs(bs) != backing_file_bs) {
         bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
     }
     bdrv_unref(commit_top_bs);
@@ -523,7 +569,7 @@ ro_cleanup:
 
     if (ro) {
         /* ignoring error return here */
-        bdrv_reopen_set_read_only(bs->backing->bs, true, NULL);
+        bdrv_reopen_set_read_only(backing_file_bs, true, NULL);
     }
 
     return ret;
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 4c8c375172..4d3db5ed3c 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -217,7 +217,7 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
             return;
         }
 
-        bs = blk_bs(blk);
+        bs = bdrv_skip_implicit_filters(blk_bs(blk));
         aio_context = bdrv_get_aio_context(bs);
         aio_context_acquire(aio_context);
 
diff --git a/blockdev.c b/blockdev.c
index d53e39c303..f308adc9aa 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2703,7 +2703,9 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
 
     assert(bdrv_get_aio_context(base_bs) == aio_context);
 
-    for (iter = top_bs; iter != backing_bs(base_bs); iter = backing_bs(iter)) {
+    for (iter = top_bs; iter != bdrv_filter_or_cow_bs(base_bs);
+         iter = bdrv_filter_or_cow_bs(iter))
+    {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_COMMIT_TARGET, errp)) {
             goto out;
         }
-- 
2.26.2


