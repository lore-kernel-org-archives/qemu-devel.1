Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF74C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 17:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F2220786
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 17:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bynZJejg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F2220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8SN7-0001P4-Sc
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 13:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8SMW-0000pq-NI
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 13:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8SMU-0006EL-BV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 13:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597859937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iZpbYIxbV1Lpiu2UzjINoVDjs+VCz4qWRCBEc+DGd6U=;
 b=bynZJejg1frIum/GWI551+b9om7mbVJEQ2hdmJeKhj8CiwZX+poF/l0B9vflo00ICyl/21
 ChtMfjxpPH8Du7IZmEZs3xgdkuu4R171w4BYIdNHGUnvtPlKLw62OMP/+vVaVnxLEfS8Xa
 iaBURY418BYtS6OUTc/j8BWijeobzgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-GKYAgQJ5OzqFh2cjSzLjTw-1; Wed, 19 Aug 2020 13:58:55 -0400
X-MC-Unique: GKYAgQJ5OzqFh2cjSzLjTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3E5C186A578;
 Wed, 19 Aug 2020 17:58:54 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA6947DFFC;
 Wed, 19 Aug 2020 17:58:53 +0000 (UTC)
Date: Wed, 19 Aug 2020 19:58:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v7 35/47] commit: Deal with filters
Message-ID: <20200819175106.GI10272@linux.fritz.box>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-36-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625152215.941773-36-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 10:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
> This includes some permission limiting (for example, we only need to
> take the RESIZE permission if the base is smaller than the top).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/block-backend.c          |  9 +++-
>  block/commit.c                 | 96 +++++++++++++++++++++++++---------
>  block/monitor/block-hmp-cmds.c |  2 +-
>  blockdev.c                     |  4 +-
>  4 files changed, 81 insertions(+), 30 deletions(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 6936b25c83..7f2c7dbccc 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2271,8 +2271,13 @@ int blk_commit_all(void)
>          AioContext *aio_context = blk_get_aio_context(blk);
>  
>          aio_context_acquire(aio_context);
> -        if (blk_is_inserted(blk) && blk->root->bs->backing) {
> -            int ret = bdrv_commit(blk->root->bs);

The old code didn't try to commit nodes that don't have a backing file.

> +        if (blk_is_inserted(blk)) {
> +            BlockDriverState *non_filter;
> +            int ret;
> +
> +            /* Legacy function, so skip implicit filters */
> +            non_filter = bdrv_skip_implicit_filters(blk->root->bs);
> +            ret = bdrv_commit(non_filter);

The new one tries unconditionally. For nodes without a backing file,
bdrv_commit() will return -ENOTSUP, so the whole function fails.

(First real bug at patch 35. I almost thought I wouldn't find any!)

>              if (ret < 0) {
>                  aio_context_release(aio_context);
>                  return ret;
> diff --git a/block/commit.c b/block/commit.c
> index 7732d02dfe..4122b6736d 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -37,6 +37,7 @@ typedef struct CommitBlockJob {
>      BlockBackend *top;
>      BlockBackend *base;
>      BlockDriverState *base_bs;
> +    BlockDriverState *base_overlay;
>      BlockdevOnError on_error;
>      bool base_read_only;
>      bool chain_frozen;

Hm, again this mysterious base_overlay. I know that stream introduced it
to avoid freezing the link to base, but commit doesn't seem to do that.

Is it to avoid using the block status of filter drivers between
base_overlay and base? If so, I guess that goes back to the question I
raised earlier in this series: What is the block status supposed to tell
for filter nodes?

But anyway, in contrast to mirror, commit actually freezes the chain
between commit_top_bs and base, so it should be safe at least.

> @@ -89,7 +90,7 @@ static void commit_abort(Job *job)
>       * XXX Can (or should) we somehow keep 'consistent read' blocked even
>       * after the failed/cancelled commit job is gone? If we already wrote
>       * something to base, the intermediate images aren't valid any more. */
> -    bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
> +    bdrv_replace_node(s->commit_top_bs, s->commit_top_bs->backing->bs,
>                        &error_abort);
>  
>      bdrv_unref(s->commit_top_bs);
> @@ -153,7 +154,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>              break;
>          }
>          /* Copy if allocated above the base */
> -        ret = bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base), false,
> +        ret = bdrv_is_allocated_above(blk_bs(s->top), s->base_overlay, true,
>                                        offset, COMMIT_BUFFER_SIZE, &n);
>          copy = (ret == 1);
>          trace_commit_one_iteration(s, offset, n, ret);
> @@ -253,15 +254,35 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>      CommitBlockJob *s;
>      BlockDriverState *iter;
>      BlockDriverState *commit_top_bs = NULL;
> +    BlockDriverState *filtered_base;
>      Error *local_err = NULL;
> +    int64_t base_size, top_size;
> +    uint64_t perms, iter_shared_perms;
>      int ret;
>  
>      assert(top != bs);
> -    if (top == base) {
> +    if (bdrv_skip_filters(top) == bdrv_skip_filters(base)) {
>          error_setg(errp, "Invalid files for merge: top and base are the same");
>          return;
>      }
>  
> +    base_size = bdrv_getlength(base);
> +    if (base_size < 0) {
> +        error_setg_errno(errp, -base_size, "Could not inquire base image size");
> +        return;
> +    }
> +
> +    top_size = bdrv_getlength(top);
> +    if (top_size < 0) {
> +        error_setg_errno(errp, -top_size, "Could not inquire top image size");
> +        return;
> +    }
> +
> +    perms = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
> +    if (base_size < top_size) {
> +        perms |= BLK_PERM_RESIZE;
> +    }

base_perms would indicate which permissions these are (particularly
because it's not the next thing that requires permissions, but only used
further down the function).

>      s = block_job_create(job_id, &commit_job_driver, NULL, bs, 0, BLK_PERM_ALL,
>                           speed, creation_flags, NULL, NULL, errp);
>      if (!s) {
> @@ -301,17 +322,43 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>  
>      s->commit_top_bs = commit_top_bs;
>  
> -    /* Block all nodes between top and base, because they will
> -     * disappear from the chain after this operation. */
> -    assert(bdrv_chain_contains(top, base));
> -    for (iter = top; iter != base; iter = backing_bs(iter)) {
> -        /* XXX BLK_PERM_WRITE needs to be allowed so we don't block ourselves
> -         * at s->base (if writes are blocked for a node, they are also blocked
> -         * for its backing file). The other options would be a second filter
> -         * driver above s->base. */
> +    /*
> +     * Block all nodes between top and base, because they will
> +     * disappear from the chain after this operation.
> +     * Note that this assumes that the user is fine with removing all
> +     * nodes (including R/W filters) between top and base.  Assuring
> +     * this is the responsibility of the interface (i.e. whoever calls
> +     * commit_start()).
> +     */
> +    s->base_overlay = bdrv_find_overlay(top, base);
> +    assert(s->base_overlay);
> +
> +    /*
> +     * The topmost node with
> +     * bdrv_skip_filters(filtered_base) == bdrv_skip_filters(base)
> +     */
> +    filtered_base = bdrv_cow_bs(s->base_overlay);
> +    assert(bdrv_skip_filters(filtered_base) == bdrv_skip_filters(base));
> +
> +    /*
> +     * XXX BLK_PERM_WRITE needs to be allowed so we don't block ourselves
> +     * at s->base (if writes are blocked for a node, they are also blocked
> +     * for its backing file). The other options would be a second filter
> +     * driver above s->base.
> +     */
> +    iter_shared_perms = BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
> +
> +    for (iter = top; iter != base; iter = bdrv_filter_or_cow_bs(iter)) {
> +        if (iter == filtered_base) {
> +            /*
> +             * From here on, all nodes are filters on the base.  This
> +             * allows us to share BLK_PERM_CONSISTENT_READ.
> +             */
> +            iter_shared_perms |= BLK_PERM_CONSISTENT_READ;
> +        }
> +
>          ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
> -                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE,
> -                                 errp);
> +                                 iter_shared_perms, errp);
>          if (ret < 0) {
>              goto fail;
>          }
> @@ -328,9 +375,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>      }
>  
>      s->base = blk_new(s->common.job.aio_context,
> -                      BLK_PERM_CONSISTENT_READ
> -                      | BLK_PERM_WRITE
> -                      | BLK_PERM_RESIZE,
> +                      perms,
>                        BLK_PERM_CONSISTENT_READ
>                        | BLK_PERM_GRAPH_MOD
>                        | BLK_PERM_WRITE_UNCHANGED);
> @@ -398,19 +443,22 @@ int bdrv_commit(BlockDriverState *bs)
>      if (!drv)
>          return -ENOMEDIUM;
>  
> -    if (!bs->backing) {
> +    backing_file_bs = bdrv_cow_bs(bs);
> +
> +    if (!backing_file_bs) {
>          return -ENOTSUP;
>      }
>  
>      if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_COMMIT_SOURCE, NULL) ||
> -        bdrv_op_is_blocked(bs->backing->bs, BLOCK_OP_TYPE_COMMIT_TARGET, NULL)) {
> +        bdrv_op_is_blocked(backing_file_bs, BLOCK_OP_TYPE_COMMIT_TARGET, NULL))
> +    {
>          return -EBUSY;
>      }
>  
> -    ro = bs->backing->bs->read_only;
> +    ro = backing_file_bs->read_only;
>  
>      if (ro) {
> -        if (bdrv_reopen_set_read_only(bs->backing->bs, false, NULL)) {
> +        if (bdrv_reopen_set_read_only(backing_file_bs, false, NULL)) {
>              return -EACCES;
>          }
>      }
> @@ -428,8 +476,6 @@ int bdrv_commit(BlockDriverState *bs)
>      }
>  
>      /* Insert commit_top block node above backing, so we can write to it */
> -    backing_file_bs = backing_bs(bs);
> -
>      commit_top_bs = bdrv_new_open_driver(&bdrv_commit_top, NULL, BDRV_O_RDWR,
>                                           &local_err);
>      if (commit_top_bs == NULL) {
> @@ -515,15 +561,13 @@ ro_cleanup:
>      qemu_vfree(buf);
>  
>      blk_unref(backing);
> -    if (backing_file_bs) {
> -        bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
> -    }
> +    bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);

This means that bdrv_set_backing_hd() is now called to undo a change
that hasn't even been made yet. This fails (with &error_abort) if the
backing chain is frozen.

On the other hand, the other bdrv_set_backing_hd() calls in the same
function would fail the same way.

>      bdrv_unref(commit_top_bs);
>      blk_unref(src);
>  
>      if (ro) {
>          /* ignoring error return here */
> -        bdrv_reopen_set_read_only(bs->backing->bs, true, NULL);
> +        bdrv_reopen_set_read_only(backing_file_bs, true, NULL);
>      }
>  
>      return ret;

Kevin


