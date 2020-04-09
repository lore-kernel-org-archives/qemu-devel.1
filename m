Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A77BC2D0EA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 06:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E12B2072F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 06:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E12B2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMQbL-0008Nc-5A
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 02:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1jMQaf-0007mW-Rk
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1jMQae-0002pU-CX
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:23:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55352 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1jMQae-0002lx-0K
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:23:04 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 636D1EEA4CE62F98F7CD;
 Thu,  9 Apr 2020 14:22:57 +0800 (CST)
Received: from [10.133.205.53] (10.133.205.53) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 9 Apr 2020
 14:22:51 +0800
Subject: Re: [PATCH 5/5] async: use explicit memory barriers
To: Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
References: <20200407140746.8041-1-pbonzini@redhat.com>
 <20200407140746.8041-6-pbonzini@redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <f1591b16-6f82-c0b1-be5f-2008c6a9035d@huawei.com>
Date: Thu, 9 Apr 2020 14:22:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200407140746.8041-6-pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.205.53]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/4/7 22:07, Paolo Bonzini wrote:
> When using C11 atomics, non-seqcst reads and writes do not participate
> in the total order of seqcst operations.  In util/async.c and util/aio-posix.c,
> in particular, the pattern that we use
> 
>            write ctx->notify_me                 write bh->scheduled
>            read bh->scheduled                   read ctx->notify_me
>            if !bh->scheduled, sleep             if ctx->notify_me, notify
> 
> needs to use seqcst operations for both the write and the read.  In
> general this is something that we do not want, because there can be
> many sources that are polled in addition to bottom halves.  The
> alternative is to place a seqcst memory barrier between the write
> and the read.  This also comes with a disadvantage, in that the
> memory barrier is implicit on strongly-ordered architectures and
> it wastes a few dozen clock cycles.
> 
> Fortunately, ctx->notify_me is never written concurrently by two
> threads, so we can assert that and relax the writes to ctx->notify_me.
> The resulting solution works and performs well on both aarch64 and x86.
> 
> Note that the atomic_set/atomic_read combination is not an atomic
> read-modify-write, and therefore it is even weaker than C11 ATOMIC_RELAXED;
> on x86, ATOMIC_RELAXED compiles to a locked operation.
> 
> Analyzed-by: Ying Fang <fangying1@huawei.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   util/aio-posix.c | 16 ++++++++++++++--
>   util/aio-win32.c | 17 ++++++++++++++---
>   util/async.c     | 16 ++++++++++++----
>   3 files changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index cd6cf0a4a9..c3613d299e 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -559,6 +559,11 @@ bool aio_poll(AioContext *ctx, bool blocking)
>       int64_t timeout;
>       int64_t start = 0;
>   
> +    /*
> +     * There cannot be two concurrent aio_poll calls for the same AioContext (or
> +     * an aio_poll concurrent with a GSource prepare/check/dispatch callback).
> +     * We rely on this below to avoid slow locked accesses to ctx->notify_me.
> +     */
>       assert(in_aio_context_home_thread(ctx));
>   
>       /* aio_notify can avoid the expensive event_notifier_set if
> @@ -569,7 +574,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
>        * so disable the optimization now.
>        */
>       if (blocking) {
> -        atomic_add(&ctx->notify_me, 2);
> +        atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) + 2);
> +        /*
> +         * Write ctx->notify_me before computing the timeout
> +         * (reading bottom half flags, etc.).  Pairs with
> +         * smp_mb in aio_notify().
> +         */
> +        smp_mb();
>       }
>   
>       qemu_lockcnt_inc(&ctx->list_lock);
> @@ -590,7 +601,8 @@ bool aio_poll(AioContext *ctx, bool blocking)
>       }
>   
>       if (blocking) {
> -        atomic_sub(&ctx->notify_me, 2);
> +        /* Finish the poll before clearing the flag.  */
> +        atomic_store_release(&ctx->notify_me, atomic_read(&ctx->notify_me) - 2);
>           aio_notify_accept(ctx);
>       }
>   
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index a23b9c364d..729d533faf 100644
> --- a/util/aio-win32.c
> +++ b/util/aio-win32.c
> @@ -321,6 +321,12 @@ bool aio_poll(AioContext *ctx, bool blocking)
>       int count;
>       int timeout;
>   
> +    /*
> +     * There cannot be two concurrent aio_poll calls for the same AioContext (or
> +     * an aio_poll concurrent with a GSource prepare/check/dispatch callback).
> +     * We rely on this below to avoid slow locked accesses to ctx->notify_me.
> +     */
> +    assert(in_aio_context_home_thread(ctx));
>       progress = false;
>   
>       /* aio_notify can avoid the expensive event_notifier_set if
> @@ -331,7 +337,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
>        * so disable the optimization now.
>        */
>       if (blocking) {
> -        atomic_add(&ctx->notify_me, 2);
> +        atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) + 2);
> +        /*
> +         * Write ctx->notify_me before computing the timeout
> +         * (reading bottom half flags, etc.).  Pairs with
> +         * smp_mb in aio_notify().
> +         */
> +        smp_mb();
>       }
>   
>       qemu_lockcnt_inc(&ctx->list_lock);
> @@ -364,8 +376,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
>           ret = WaitForMultipleObjects(count, events, FALSE, timeout);
>           if (blocking) {
>               assert(first);
> -            assert(in_aio_context_home_thread(ctx));
> -            atomic_sub(&ctx->notify_me, 2);
> +            atomic_store_release(&ctx->notify_me, atomic_read(&ctx->notify_me) - 2);
>               aio_notify_accept(ctx);
>           }
>   
> diff --git a/util/async.c b/util/async.c
> index b94518b948..3165a28f2f 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -249,7 +249,14 @@ aio_ctx_prepare(GSource *source, gint    *timeout)
>   {
>       AioContext *ctx = (AioContext *) source;
>   
> -    atomic_or(&ctx->notify_me, 1);
> +    atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) | 1);
> +
> +    /*
> +     * Write ctx->notify_me before computing the timeout
> +     * (reading bottom half flags, etc.).  Pairs with
> +     * smp_mb in aio_notify().
> +     */
> +    smp_mb();
>   
>       /* We assume there is no timeout already supplied */
>       *timeout = qemu_timeout_ns_to_ms(aio_compute_timeout(ctx));
> @@ -268,7 +275,8 @@ aio_ctx_check(GSource *source)
>       QEMUBH *bh;
>       BHListSlice *s;
>   
> -    atomic_and(&ctx->notify_me, ~1);
> +    /* Finish computing the timeout before clearing the flag.  */
> +    atomic_store_release(&ctx->notify_me, atomic_read(&ctx->notify_me) & ~1);
>       aio_notify_accept(ctx);
>   
>       QSLIST_FOREACH_RCU(bh, &ctx->bh_list, next) {
> @@ -411,10 +419,10 @@ LuringState *aio_get_linux_io_uring(AioContext *ctx)
>   void aio_notify(AioContext *ctx)
>   {
>       /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
> -     * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
> +     * with smp_mb in aio_ctx_prepare or aio_poll.
>        */
>       smp_mb();
> -    if (ctx->notify_me) {
> +    if (atomic_read(&ctx->notify_me)) {
>           event_notifier_set(&ctx->notifier);
>           atomic_mb_set(&ctx->notified, true);
>       }
> 
Tested-by: Ying Fang <fangying1@huawei.com>

