Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB14CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E36206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E36206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYYIo-0007BI-2R
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 13:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYY7U-0004r6-Cy; Tue, 12 May 2020 12:51:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:50530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYY7P-0001R4-3b; Tue, 12 May 2020 12:51:04 -0400
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYY7C-0004nT-Vv; Tue, 12 May 2020 19:50:47 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 07/15] commit: Deal with filters when blocking intermediate
 nodes
Date: Tue, 12 May 2020 19:50:37 +0300
Message-Id: <1589302245-893269-8-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589302245-893269-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1589302245-893269-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 10:53:25
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

This includes some permission limiting (for example, we only need to
take the RESIZE permission if the base is smaller than the top).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/commit.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 60 insertions(+), 15 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index e1f45a4..4df145d 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -37,6 +37,7 @@ typedef struct CommitBlockJob {
     BlockBackend *top;
     BlockBackend *base;
     BlockDriverState *base_bs;
+    BlockDriverState *above_base;
     BlockdevOnError on_error;
     bool base_read_only;
     bool chain_frozen;
@@ -153,7 +154,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
             break;
         }
         /* Copy if allocated above the base */
-        ret = bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base), false,
+        ret = bdrv_is_allocated_above(blk_bs(s->top), s->above_base, true,
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
+    uint64_t perms, iter_shared_perms;
     int ret;
 
     assert(top != bs);
-    if (top == base) {
+    if (bdrv_skip_rw_filters(top) == bdrv_skip_rw_filters(base)) {
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
+    perms = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
+    if (base_size < top_size) {
+        perms |= BLK_PERM_RESIZE;
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
+    s->above_base = bdrv_find_overlay(top, base);
+    assert(s->above_base);
+
+    /*
+     * The topmost node with
+     * bdrv_skip_rw_filters(filtered_base) == bdrv_skip_rw_filters(base)
+     */
+    filtered_base = bdrv_filtered_cow_bs(s->above_base);
+    assert(bdrv_skip_rw_filters(filtered_base) == bdrv_skip_rw_filters(base));
+
+    /*
+     * XXX BLK_PERM_WRITE needs to be allowed so we don't block ourselves
+     * at s->base (if writes are blocked for a node, they are also blocked
+     * for its backing file). The other options would be a second filter
+     * driver above s->base.
+     */
+    iter_shared_perms = BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
+
+    for (iter = top; iter != base; iter = bdrv_filtered_bs(iter)) {
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
+                      perms,
                       BLK_PERM_CONSISTENT_READ
                       | BLK_PERM_GRAPH_MOD
                       | BLK_PERM_WRITE_UNCHANGED);
-- 
1.8.3.1


