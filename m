Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A97C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA792071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyVSnhsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA792071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jHE-00066Z-Qh
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4jGN-00056J-Io
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4jGL-00030w-Jj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:40:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40399
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4jGL-00030g-FZ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582195256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ex5xG3r+RATyrtbsQYvZtFlrAOFlNYfAQwXvRHGu74I=;
 b=QyVSnhsWENqXSq0kd9E1mNw3ezfHIYc6ctX75pUTc2g3fMXsDiyDgs5lQ+vVFIhq0ZE0VL
 FkfgIKAtRHwCUzW+yX6K0jXHIqYxJM29Iw/vdQYJskUGI6l9d481cNnc8mdBcH+lkd/Ft2
 GIg8VQQyHwbADgPQ9HWxikjRsuGC2cs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-euQh7FA5NUyYKbnxsuUu5g-1; Thu, 20 Feb 2020 05:40:51 -0500
Received: by mail-wr1-f69.google.com with SMTP id o9so1554768wrw.14
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 02:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ex5xG3r+RATyrtbsQYvZtFlrAOFlNYfAQwXvRHGu74I=;
 b=UJSLi2eKE7MNCLiDWwxzI+FR/oJY+OBJQGEz9hKbJBBfeliivptQ21xuymaOV2VeZl
 FadSR/pc9sIR82xrBra3ObKNeEdcAq6+xYi6s4NZ1JluCA3YkVcEmH4oY5uiJnkzj4TA
 79fllm/Hcu22aEHLxJR6Z4eChhDoP9jbGoxgSSy6Pj1wsJ3jMOXzn+yWrLQWd4Jm8QSA
 jp2/xVfClDaUwalbNZLGQZRr3oK+ls6eFtxsvkriK/D0x31pJmEti7OK4i3Lg+AdwmCZ
 D56WY4PYB5cNj/1kh+aADap16mQpcDgp9qdRxjlvmmpE6BL/qsnKyYw2QzQz+kVznN4I
 oD1Q==
X-Gm-Message-State: APjAAAWr4VMnFiae8Gfz2ZUiPWxWDoFeStPRrD3+w/XU+VO1fg6FbtlV
 ju68FsV2/TKADswNMgs2BSdcZct/t5bfRFCxCXcr/IYaJe8iZiJ9auCf3OmeY8vdGo/XLELNxeM
 HPR2UY5tguvZX/So=
X-Received: by 2002:a05:600c:2042:: with SMTP id
 p2mr3798191wmg.79.1582195249867; 
 Thu, 20 Feb 2020 02:40:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwiDcMd/D/NV+kJwhqfCjpYpPFThyeLSeyUdDR7ecmxyMDMSZtP/TgP883oUrNSQMR8LNVU6A==
X-Received: by 2002:a05:600c:2042:: with SMTP id
 p2mr3798137wmg.79.1582195249237; 
 Thu, 20 Feb 2020 02:40:49 -0800 (PST)
Received: from [10.201.49.12] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id a16sm3702755wrx.87.2020.02.20.02.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 02:40:48 -0800 (PST)
Subject: Re: [PATCH v2] util/async: make bh_aio_poll() O(1)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200219175348.1161536-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa6b2d81-c654-2a2c-12a8-8bc300fc1dd6@redhat.com>
Date: Thu, 20 Feb 2020 11:40:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200219175348.1161536-1-stefanha@redhat.com>
Content-Language: en-US
X-MC-Unique: euQh7FA5NUyYKbnxsuUu5g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/02/20 18:53, Stefan Hajnoczi wrote:
> The ctx->first_bh list contains all created BHs, including those that
> are not scheduled.  The list is iterated by the event loop and therefore
> has O(n) time complexity with respected to the number of created BHs.
> 
> Rewrite BHs so that only scheduled or deleted BHs are enqueued.
> Only BHs that actually require action will be iterated.
> 
> One semantic change is required: qemu_bh_delete() enqueues the BH and
> therefore invokes aio_notify().  The
> tests/test-aio.c:test_source_bh_delete_from_cb() test case assumed that
> g_main_context_iteration(NULL, false) returns false after
> qemu_bh_delete() but it now returns true for one iteration.  Fix up the
> test case.
> 
> This patch makes aio_compute_timeout() and aio_bh_poll() drop from a CPU
> profile reported by perf-top(1).  Previously they combined to 9% CPU
> utilization when AioContext polling is commented out and the guest has 2
> virtio-blk,num-queues=1 and 99 virtio-blk,num-queues=32 devices.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Use QSLIST for BHs and QSIMPLEQ for BHListSlices [Paolo]
>    (Note that I replaced bh = atomic_rcu_read(&first_bh) with
>     QSLIST_FOREACH(&bh_list) so there is no memory ordering but I think
>     this is safe.)

I have sent an implementation of QSLIST_FOREACH_RCU.  I doubt you'd see
any problem in practice, since RCU accesses only need a compiler
barrier, but it's cleaner.

With that changed,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Any further optimization of aio_compute_timeout() and aio_ctx_check()
can be done on top.

Paolo

> ---
>  include/block/aio.h |  20 +++-
>  tests/test-aio.c    |   3 +-
>  util/async.c        | 236 +++++++++++++++++++++++++-------------------
>  3 files changed, 157 insertions(+), 102 deletions(-)
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 7ba9bd7874..1a2ce9ca26 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -51,6 +51,19 @@ struct ThreadPool;
>  struct LinuxAioState;
>  struct LuringState;
>  
> +/*
> + * Each aio_bh_poll() call carves off a slice of the BH list, so that newly
> + * scheduled BHs are not processed until the next aio_bh_poll() call.  All
> + * active aio_bh_poll() calls chain their slices together in a list, so that
> + * nested aio_bh_poll() calls process all scheduled bottom halves.
> + */
> +typedef QSLIST_HEAD(, QEMUBH) BHList;
> +typedef struct BHListSlice BHListSlice;
> +struct BHListSlice {
> +    BHList bh_list;
> +    QSIMPLEQ_ENTRY(BHListSlice) next;
> +};
> +
>  struct AioContext {
>      GSource source;
>  
> @@ -91,8 +104,11 @@ struct AioContext {
>       */
>      QemuLockCnt list_lock;
>  
> -    /* Anchor of the list of Bottom Halves belonging to the context */
> -    struct QEMUBH *first_bh;
> +    /* Bottom Halves pending aio_bh_poll() processing */
> +    BHList bh_list;
> +
> +    /* Chained BH list slices for each nested aio_bh_poll() call */
> +    QSIMPLEQ_HEAD(, BHListSlice) bh_slice_list;
>  
>      /* Used by aio_notify.
>       *
> diff --git a/tests/test-aio.c b/tests/test-aio.c
> index 86fb73b3d5..8a46078463 100644
> --- a/tests/test-aio.c
> +++ b/tests/test-aio.c
> @@ -615,7 +615,8 @@ static void test_source_bh_delete_from_cb(void)
>      g_assert_cmpint(data1.n, ==, data1.max);
>      g_assert(data1.bh == NULL);
>  
> -    g_assert(!g_main_context_iteration(NULL, false));
> +    assert(g_main_context_iteration(NULL, false));
> +    assert(!g_main_context_iteration(NULL, false));
>  }
>  
>  static void test_source_bh_delete_from_cb_many(void)
> diff --git a/util/async.c b/util/async.c
> index c192a24a61..2c8499cc29 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -36,16 +36,76 @@
>  /***********************************************************/
>  /* bottom halves (can be seen as timers which expire ASAP) */
>  
> +/* QEMUBH::flags values */
> +enum {
> +    /* Already enqueued and waiting for aio_bh_poll() */
> +    BH_PENDING   = (1 << 0),
> +
> +    /* Invoke the callback */
> +    BH_SCHEDULED = (1 << 1),
> +
> +    /* Delete without invoking callback */
> +    BH_DELETED   = (1 << 2),
> +
> +    /* Delete after invoking callback */
> +    BH_ONESHOT   = (1 << 3),
> +
> +    /* Schedule periodically when the event loop is idle */
> +    BH_IDLE      = (1 << 4),
> +};
> +
>  struct QEMUBH {
>      AioContext *ctx;
>      QEMUBHFunc *cb;
>      void *opaque;
> -    QEMUBH *next;
> -    bool scheduled;
> -    bool idle;
> -    bool deleted;
> +    QSLIST_ENTRY(QEMUBH) next;
> +    unsigned flags;
>  };
>  
> +/* Called concurrently from any thread */
> +static void aio_bh_enqueue(QEMUBH *bh, unsigned new_flags)
> +{
> +    AioContext *ctx = bh->ctx;
> +    unsigned old_flags;
> +
> +    /*
> +     * The memory barrier implicit in atomic_fetch_or makes sure that:
> +     * 1. idle & any writes needed by the callback are done before the
> +     *    locations are read in the aio_bh_poll.
> +     * 2. ctx is loaded before the callback has a chance to execute and bh
> +     *    could be freed.
> +     */
> +    old_flags = atomic_fetch_or(&bh->flags, BH_PENDING | new_flags);
> +    if (!(old_flags & BH_PENDING)) {
> +        QSLIST_INSERT_HEAD_ATOMIC(&ctx->bh_list, bh, next);
> +    }
> +
> +    aio_notify(ctx);
> +}
> +
> +/* Only called from aio_bh_poll() and aio_ctx_finalize() */
> +static QEMUBH *aio_bh_dequeue(BHList *head, unsigned *flags)
> +{
> +    QEMUBH *bh = QSLIST_FIRST(head);
> +
> +    if (!bh) {
> +        return NULL;
> +    }
> +
> +    QSLIST_REMOVE_HEAD(head, next);
> +
> +    /*
> +     * The atomic_and is paired with aio_bh_enqueue().  The implicit memory
> +     * barrier ensures that the callback sees all writes done by the scheduling
> +     * thread.  It also ensures that the scheduling thread sees the cleared
> +     * flag before bh->cb has run, and thus will call aio_notify again if
> +     * necessary.
> +     */
> +    *flags = atomic_fetch_and(&bh->flags,
> +                              ~(BH_PENDING | BH_SCHEDULED | BH_IDLE));
> +    return bh;
> +}
> +
>  void aio_bh_schedule_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
>  {
>      QEMUBH *bh;
> @@ -55,15 +115,7 @@ void aio_bh_schedule_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
>          .cb = cb,
>          .opaque = opaque,
>      };
> -    qemu_lockcnt_lock(&ctx->list_lock);
> -    bh->next = ctx->first_bh;
> -    bh->scheduled = 1;
> -    bh->deleted = 1;
> -    /* Make sure that the members are ready before putting bh into list */
> -    smp_wmb();
> -    ctx->first_bh = bh;
> -    qemu_lockcnt_unlock(&ctx->list_lock);
> -    aio_notify(ctx);
> +    aio_bh_enqueue(bh, BH_SCHEDULED | BH_ONESHOT);
>  }
>  
>  QEMUBH *aio_bh_new(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
> @@ -75,12 +127,6 @@ QEMUBH *aio_bh_new(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
>          .cb = cb,
>          .opaque = opaque,
>      };
> -    qemu_lockcnt_lock(&ctx->list_lock);
> -    bh->next = ctx->first_bh;
> -    /* Make sure that the members are ready before putting bh into list */
> -    smp_wmb();
> -    ctx->first_bh = bh;
> -    qemu_lockcnt_unlock(&ctx->list_lock);
>      return bh;
>  }
>  
> @@ -89,91 +135,56 @@ void aio_bh_call(QEMUBH *bh)
>      bh->cb(bh->opaque);
>  }
>  
> -/* Multiple occurrences of aio_bh_poll cannot be called concurrently.
> - * The count in ctx->list_lock is incremented before the call, and is
> - * not affected by the call.
> - */
> +/* Multiple occurrences of aio_bh_poll cannot be called concurrently. */
>  int aio_bh_poll(AioContext *ctx)
>  {
> -    QEMUBH *bh, **bhp, *next;
> -    int ret;
> -    bool deleted = false;
> -
> -    ret = 0;
> -    for (bh = atomic_rcu_read(&ctx->first_bh); bh; bh = next) {
> -        next = atomic_rcu_read(&bh->next);
> -        /* The atomic_xchg is paired with the one in qemu_bh_schedule.  The
> -         * implicit memory barrier ensures that the callback sees all writes
> -         * done by the scheduling thread.  It also ensures that the scheduling
> -         * thread sees the zero before bh->cb has run, and thus will call
> -         * aio_notify again if necessary.
> -         */
> -        if (atomic_xchg(&bh->scheduled, 0)) {
> +    BHListSlice slice;
> +    BHListSlice *s;
> +    int ret = 0;
> +
> +    QSLIST_MOVE_ATOMIC(&slice.bh_list, &ctx->bh_list);
> +    QSIMPLEQ_INSERT_TAIL(&ctx->bh_slice_list, &slice, next);
> +
> +    while ((s = QSIMPLEQ_FIRST(&ctx->bh_slice_list))) {
> +        QEMUBH *bh;
> +        unsigned flags;
> +
> +        bh = aio_bh_dequeue(&s->bh_list, &flags);
> +        if (!bh) {
> +            QSIMPLEQ_REMOVE_HEAD(&ctx->bh_slice_list, next);
> +            continue;
> +        }
> +
> +        if ((flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
>              /* Idle BHs don't count as progress */
> -            if (!bh->idle) {
> +            if (!(flags & BH_IDLE)) {
>                  ret = 1;
>              }
> -            bh->idle = 0;
>              aio_bh_call(bh);
>          }
> -        if (bh->deleted) {
> -            deleted = true;
> +        if (flags & (BH_DELETED | BH_ONESHOT)) {
> +            g_free(bh);
>          }
>      }
>  
> -    /* remove deleted bhs */
> -    if (!deleted) {
> -        return ret;
> -    }
> -
> -    if (qemu_lockcnt_dec_if_lock(&ctx->list_lock)) {
> -        bhp = &ctx->first_bh;
> -        while (*bhp) {
> -            bh = *bhp;
> -            if (bh->deleted && !bh->scheduled) {
> -                *bhp = bh->next;
> -                g_free(bh);
> -            } else {
> -                bhp = &bh->next;
> -            }
> -        }
> -        qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
> -    }
>      return ret;
>  }
>  
>  void qemu_bh_schedule_idle(QEMUBH *bh)
>  {
> -    bh->idle = 1;
> -    /* Make sure that idle & any writes needed by the callback are done
> -     * before the locations are read in the aio_bh_poll.
> -     */
> -    atomic_mb_set(&bh->scheduled, 1);
> +    aio_bh_enqueue(bh, BH_SCHEDULED | BH_IDLE);
>  }
>  
>  void qemu_bh_schedule(QEMUBH *bh)
>  {
> -    AioContext *ctx;
> -
> -    ctx = bh->ctx;
> -    bh->idle = 0;
> -    /* The memory barrier implicit in atomic_xchg makes sure that:
> -     * 1. idle & any writes needed by the callback are done before the
> -     *    locations are read in the aio_bh_poll.
> -     * 2. ctx is loaded before scheduled is set and the callback has a chance
> -     *    to execute.
> -     */
> -    if (atomic_xchg(&bh->scheduled, 1) == 0) {
> -        aio_notify(ctx);
> -    }
> +    aio_bh_enqueue(bh, BH_SCHEDULED);
>  }
>  
> -
>  /* This func is async.
>   */
>  void qemu_bh_cancel(QEMUBH *bh)
>  {
> -    atomic_mb_set(&bh->scheduled, 0);
> +    atomic_and(&bh->flags, ~BH_SCHEDULED);
>  }
>  
>  /* This func is async.The bottom half will do the delete action at the finial
> @@ -181,21 +192,16 @@ void qemu_bh_cancel(QEMUBH *bh)
>   */
>  void qemu_bh_delete(QEMUBH *bh)
>  {
> -    bh->scheduled = 0;
> -    bh->deleted = 1;
> +    aio_bh_enqueue(bh, BH_DELETED);
>  }
>  
> -int64_t
> -aio_compute_timeout(AioContext *ctx)
> +static int64_t aio_compute_bh_timeout(BHList *head, int timeout)
>  {
> -    int64_t deadline;
> -    int timeout = -1;
>      QEMUBH *bh;
>  
> -    for (bh = atomic_rcu_read(&ctx->first_bh); bh;
> -         bh = atomic_rcu_read(&bh->next)) {
> -        if (bh->scheduled) {
> -            if (bh->idle) {
> +    QSLIST_FOREACH(bh, head, next) {
> +        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
> +            if (bh->flags & BH_IDLE) {
>                  /* idle bottom halves will be polled at least
>                   * every 10ms */
>                  timeout = 10000000;
> @@ -207,6 +213,28 @@ aio_compute_timeout(AioContext *ctx)
>          }
>      }
>  
> +    return timeout;
> +}
> +
> +int64_t
> +aio_compute_timeout(AioContext *ctx)
> +{
> +    BHListSlice *s;
> +    int64_t deadline;
> +    int timeout = -1;
> +
> +    timeout = aio_compute_bh_timeout(&ctx->bh_list, timeout);
> +    if (timeout == 0) {
> +        return 0;
> +    }
> +
> +    QSIMPLEQ_FOREACH(s, &ctx->bh_slice_list, next) {
> +        timeout = aio_compute_bh_timeout(&s->bh_list, timeout);
> +        if (timeout == 0) {
> +            return 0;
> +        }
> +    }
> +
>      deadline = timerlistgroup_deadline_ns(&ctx->tlg);
>      if (deadline == 0) {
>          return 0;
> @@ -237,15 +265,24 @@ aio_ctx_check(GSource *source)
>  {
>      AioContext *ctx = (AioContext *) source;
>      QEMUBH *bh;
> +    BHListSlice *s;
>  
>      atomic_and(&ctx->notify_me, ~1);
>      aio_notify_accept(ctx);
>  
> -    for (bh = ctx->first_bh; bh; bh = bh->next) {
> -        if (bh->scheduled) {
> +    QSLIST_FOREACH(bh, &ctx->bh_list, next) {
> +        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
>              return true;
>          }
>      }
> +
> +    QSIMPLEQ_FOREACH(s, &ctx->bh_slice_list, next) {
> +        QSLIST_FOREACH(bh, &s->bh_list, next) {
> +            if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
> +                return true;
> +            }
> +        }
> +    }
>      return aio_pending(ctx) || (timerlistgroup_deadline_ns(&ctx->tlg) == 0);
>  }
>  
> @@ -265,6 +302,8 @@ static void
>  aio_ctx_finalize(GSource     *source)
>  {
>      AioContext *ctx = (AioContext *) source;
> +    QEMUBH *bh;
> +    unsigned flags;
>  
>      thread_pool_free(ctx->thread_pool);
>  
> @@ -287,18 +326,15 @@ aio_ctx_finalize(GSource     *source)
>      assert(QSLIST_EMPTY(&ctx->scheduled_coroutines));
>      qemu_bh_delete(ctx->co_schedule_bh);
>  
> -    qemu_lockcnt_lock(&ctx->list_lock);
> -    assert(!qemu_lockcnt_count(&ctx->list_lock));
> -    while (ctx->first_bh) {
> -        QEMUBH *next = ctx->first_bh->next;
> +    /* There must be no aio_bh_poll() calls going on */
> +    assert(QSIMPLEQ_EMPTY(&ctx->bh_slice_list));
>  
> +    while ((bh = aio_bh_dequeue(&ctx->bh_list, &flags))) {
>          /* qemu_bh_delete() must have been called on BHs in this AioContext */
> -        assert(ctx->first_bh->deleted);
> +        assert(flags & BH_DELETED);
>  
> -        g_free(ctx->first_bh);
> -        ctx->first_bh = next;
> +        g_free(bh);
>      }
> -    qemu_lockcnt_unlock(&ctx->list_lock);
>  
>      aio_set_event_notifier(ctx, &ctx->notifier, false, NULL, NULL);
>      event_notifier_cleanup(&ctx->notifier);
> @@ -445,6 +481,8 @@ AioContext *aio_context_new(Error **errp)
>      AioContext *ctx;
>  
>      ctx = (AioContext *) g_source_new(&aio_source_funcs, sizeof(AioContext));
> +    QSLIST_INIT(&ctx->bh_list);
> +    QSIMPLEQ_INIT(&ctx->bh_slice_list);
>      aio_context_setup(ctx);
>  
>      ret = event_notifier_init(&ctx->notifier, false);
> 


