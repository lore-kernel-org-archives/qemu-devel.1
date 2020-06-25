Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486ECC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124E12082F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKGBQCJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124E12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTqg-0007YM-9F
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiO-0005gm-Jo
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiI-0000nl-1v
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjN0VjBNTVyuUssgXdokfrm5GaKIdaT0s290vIvxN4I=;
 b=YKGBQCJdDkgD5XVFki0ohjw7lhgBNU06ObLZo6ZRZMmwWUMhvfocF7FcBDZ/82pTPA+oyv
 wrg7PNPGwNXlOzNHcr4CDLV2uRqmPxtXWANUhEVhlF+//H93pa4zrDAtV5jfI+dLDi/w7U
 vntZHLr5ly2UUGkqEJrBpOI2F0Ixlo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-jTiX5rGWPdKpsDidUqN_Kg-1; Thu, 25 Jun 2020 11:22:51 -0400
X-MC-Unique: jTiX5rGWPdKpsDidUqN_Kg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3391E8031F7;
 Thu, 25 Jun 2020 15:22:50 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A76351944D;
 Thu, 25 Jun 2020 15:22:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 14/47] stream: Deal with filters
Date: Thu, 25 Jun 2020 17:21:42 +0200
Message-Id: <20200625152215.941773-15-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because of the (not so recent anymore) changes that make the stream job
independent of the base node and instead track the node above it, we
have to split that "bottom" node into two cases: The bottom COW node,
and the node directly above the base node (which may be an R/W filter
or the bottom COW node).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json |  4 +++
 block/stream.c       | 63 ++++++++++++++++++++++++++++++++------------
 blockdev.c           |  4 ++-
 3 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b20332e592..df87855429 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2486,6 +2486,10 @@
 # On successful completion the image file is updated to drop the backing file
 # and the BLOCK_JOB_COMPLETED event is emitted.
 #
+# In case @device is a filter node, block-stream modifies the first non-filter
+# overlay node below it to point to base's backing node (or NULL if @base was
+# not specified) instead of modifying @device itself.
+#
 # @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
diff --git a/block/stream.c b/block/stream.c
index aa2e7af98e..b9c1141656 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -31,7 +31,8 @@ enum {
 
 typedef struct StreamBlockJob {
     BlockJob common;
-    BlockDriverState *bottom;
+    BlockDriverState *base_overlay; /* COW overlay (stream from this) */
+    BlockDriverState *above_base;   /* Node directly above the base */
     BlockdevOnError on_error;
     char *backing_file_str;
     bool bs_read_only;
@@ -53,7 +54,7 @@ static void stream_abort(Job *job)
 
     if (s->chain_frozen) {
         BlockJob *bjob = &s->common;
-        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->bottom);
+        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->above_base);
     }
 }
 
@@ -62,14 +63,15 @@ static int stream_prepare(Job *job)
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob = &s->common;
     BlockDriverState *bs = blk_bs(bjob->blk);
-    BlockDriverState *base = backing_bs(s->bottom);
+    BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
+    BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
     Error *local_err = NULL;
     int ret = 0;
 
-    bdrv_unfreeze_backing_chain(bs, s->bottom);
+    bdrv_unfreeze_backing_chain(bs, s->above_base);
     s->chain_frozen = false;
 
-    if (bs->backing) {
+    if (bdrv_cow_child(unfiltered_bs)) {
         const char *base_id = NULL, *base_fmt = NULL;
         if (base) {
             base_id = s->backing_file_str;
@@ -77,8 +79,8 @@ static int stream_prepare(Job *job)
                 base_fmt = base->drv->format_name;
             }
         }
-        bdrv_set_backing_hd(bs, base, &local_err);
-        ret = bdrv_change_backing_file(bs, base_id, base_fmt);
+        bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
+        ret = bdrv_change_backing_file(unfiltered_bs, base_id, base_fmt);
         if (local_err) {
             error_report_err(local_err);
             return -EPERM;
@@ -109,14 +111,15 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockBackend *blk = s->common.blk;
     BlockDriverState *bs = blk_bs(blk);
-    bool enable_cor = !backing_bs(s->bottom);
+    BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
+    bool enable_cor = !bdrv_cow_child(s->base_overlay);
     int64_t len;
     int64_t offset = 0;
     uint64_t delay_ns = 0;
     int error = 0;
     int64_t n = 0; /* bytes */
 
-    if (bs == s->bottom) {
+    if (unfiltered_bs == s->base_overlay) {
         /* Nothing to stream */
         return 0;
     }
@@ -150,13 +153,14 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
 
         copy = false;
 
-        ret = bdrv_is_allocated(bs, offset, STREAM_CHUNK, &n);
+        ret = bdrv_is_allocated(unfiltered_bs, offset, STREAM_CHUNK, &n);
         if (ret == 1) {
             /* Allocated in the top, no need to copy.  */
         } else if (ret >= 0) {
             /* Copy if allocated in the intermediate images.  Limit to the
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
-            ret = bdrv_is_allocated_above(backing_bs(bs), s->bottom, true,
+            ret = bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
+                                          s->base_overlay, true,
                                           offset, n, &n);
             /* Finish early if end of backing file has been reached */
             if (ret == 0 && n == 0) {
@@ -223,9 +227,29 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     BlockDriverState *iter;
     bool bs_read_only;
     int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
-    BlockDriverState *bottom = bdrv_find_overlay(bs, base);
+    BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
+    BlockDriverState *above_base;
 
-    if (bdrv_freeze_backing_chain(bs, bottom, errp) < 0) {
+    if (!base_overlay) {
+        error_setg(errp, "'%s' is not in the backing chain of '%s'",
+                   base->node_name, bs->node_name);
+        return;
+    }
+
+    /*
+     * Find the node directly above @base.  @base_overlay is a COW overlay, so
+     * it must have a bdrv_cow_child(), but it is the immediate overlay of
+     * @base, so between the two there can only be filters.
+     */
+    above_base = base_overlay;
+    if (bdrv_cow_bs(above_base) != base) {
+        above_base = bdrv_cow_bs(above_base);
+        while (bdrv_filter_bs(above_base) != base) {
+            above_base = bdrv_filter_bs(above_base);
+        }
+    }
+
+    if (bdrv_freeze_backing_chain(bs, above_base, errp) < 0) {
         return;
     }
 
@@ -255,14 +279,19 @@ void stream_start(const char *job_id, BlockDriverState *bs,
      * and resizes. Reassign the base node pointer because the backing BS of the
      * bottom node might change after the call to bdrv_reopen_set_read_only()
      * due to parallel block jobs running.
+     * above_base node might change after the call to
+     * bdrv_reopen_set_read_only() due to parallel block jobs running.
      */
-    base = backing_bs(bottom);
-    for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
+    base = bdrv_filter_or_cow_bs(above_base);
+    for (iter = bdrv_filter_or_cow_bs(bs); iter != base;
+         iter = bdrv_filter_or_cow_bs(iter))
+    {
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                            basic_flags, &error_abort);
     }
 
-    s->bottom = bottom;
+    s->base_overlay = base_overlay;
+    s->above_base = above_base;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
     s->chain_frozen = true;
@@ -276,5 +305,5 @@ fail:
     if (bs_read_only) {
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
-    bdrv_unfreeze_backing_chain(bs, bottom);
+    bdrv_unfreeze_backing_chain(bs, above_base);
 }
diff --git a/blockdev.c b/blockdev.c
index 72df193ca7..1eb0fcdea2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2515,7 +2515,9 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     }
 
     /* Check for op blockers in the whole chain between bs and base */
-    for (iter = bs; iter && iter != base_bs; iter = backing_bs(iter)) {
+    for (iter = bs; iter && iter != base_bs;
+         iter = bdrv_filter_or_cow_bs(iter))
+    {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_STREAM, errp)) {
             goto out;
         }
-- 
2.26.2


