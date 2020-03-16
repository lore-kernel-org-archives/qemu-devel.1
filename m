Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7445C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A289920409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqUjgJzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A289920409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuG5-0001dc-Qu
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDspO-0006zE-VD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDspM-0004nl-JX
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:42:58 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDspM-0004er-7n; Mon, 16 Mar 2020 12:42:56 -0400
Received: by mail-wr1-x430.google.com with SMTP id a25so22105421wrd.0;
 Mon, 16 Mar 2020 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=90ElrVne0DNWy12R3Ax/OR44n9OkwkCWxNhK6Cdk6dE=;
 b=RqUjgJzvbzkanSvr+nTYXnjXz0z8mmQICTAy52sTrSxCKuKA4B9yLzdfqNv/+/HfMF
 7kpuVxuMjZj8K4oFc4PEE0+wPMdgWdrA3nRnu6OlfGwBLyZJuUbLsmOtqzIAwhu8qasI
 YtSLN5fJHMI/Nc+2x6chsu1fvIFq2wEKC1mc6sPc6nHYNQ4iCfK6TkmrjtVJ3//u9AsZ
 Ecijl7afq07o3/MBOiflEftKR1tlTnR2C92TRmyLvEvMAt8/vejyuxWLX77IeO2EC+xX
 d76GXbdm3JUUxCPY5NyreRMVhasXxfugMP+aZDTXzVkKjRRnDObEr1MBPONmKTqIyXuO
 2Yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=90ElrVne0DNWy12R3Ax/OR44n9OkwkCWxNhK6Cdk6dE=;
 b=U+qd81aNCfBMwksbWaoA4FVMN+yLhzSUMKDJgrANGhXTAu/duYXo0tVGlxRkLBBgJP
 usXom0sXMInUbWpXgVoQOgscRnp550rkVHt2X1905Jf8JKQaH3NbZmiFHIc6FqzWdQqW
 LdtVCRrmkyTbc0cnXzgJD5taz+WE7WaKb2SHui5WRJLLJ4e16NZBUa8hb6RLdpXS6y06
 zpQpnwcchN0fCzLJBMJkVeAGsJIc2rqqnEuADfRAKSVbJH4y41ZBnNdr8/aUtzpjSEOY
 f7SRMYvA3s0t5IOhjSYM+ZV8BUs6MB5hIWmtnuxx4brRYbqpQ/yUYrHAp8MfrXcadgz1
 CxIg==
X-Gm-Message-State: ANhLgQ1lnhtY9gFy5sdvGGIM3SUjxsOvQRWvzu+iEbLiosGM3yxyIC5W
 aCdsuh3t4+V+jjXzkTRYs/bs60FrIHeSh6jIslQ=
X-Google-Smtp-Source: ADFU+vvfUEeJ1l60MQBEcZRaE+t2v/xlIwr6sHVYRH8Jfh2Wisv4L6YdAMVbixJxsSSTldwYrS3k2ZQPYOI/JYCaeb4=
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr265242wrs.96.1584376974367;
 Mon, 16 Mar 2020 09:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200222085030.1760640-1-stefanha@redhat.com>
 <20200222085030.1760640-5-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-5-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 17:42:42 +0100
Message-ID: <CAJ+F1CLYTAsg957M3Nw8cvNSwW-JqoNTMBxWYrRTO9Mc5XkSdA@mail.gmail.com>
Subject: Re: [PULL 04/31] util/async: make bh_aio_poll() O(1)
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sat, Feb 22, 2020 at 9:51 AM Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>
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
> virtio-blk,num-queues=3D1 and 99 virtio-blk,num-queues=3D32 devices.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200221093951.1414693-1-stefanha@redhat.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Current master migration-test fails with --enable-sanitizers. qemu
exit 1 when 0 is expected.
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
tests/qtest/migration-test  -p /x86_64/migration/postcopy/recovery
tests/qtest/libqtest.c:140: kill_qemu() tried to terminate QEMU
process but encountered exit status 1 (expected 0)

Leak is

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D2082571=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f25971dfc58 in __interceptor_malloc (/lib64/libasan.so.5+0x10dc58=
)
    #1 0x7f2596d08358 in g_malloc (/lib64/libglib-2.0.so.0+0x57358)
    #2 0x560970d006f8 in qemu_bh_new /home/elmarco/src/qemu/util/main-loop.=
c:532
    #3 0x5609704afa02 in migrate_fd_connect
/home/elmarco/src/qemu/migration/migration.c:3407
    #4 0x5609704b6b6f in migration_channel_connect
/home/elmarco/src/qemu/migration/channel.c:92
    #5 0x5609704b2bfb in socket_outgoing_migration
/home/elmarco/src/qemu/migration/socket.c:108
    #6 0x560970b9bd6c in qio_task_complete /home/elmarco/src/qemu/io/task.c=
:196
    #7 0x560970b9aa97 in qio_task_thread_result
/home/elmarco/src/qemu/io/task.c:111
    #8 0x7f2596cfee3a  (/lib64/libglib-2.0.so.0+0x4de3a)

Any idea?

>  include/block/aio.h |  20 +++-
>  tests/test-aio.c    |   3 +-
>  util/async.c        | 237 ++++++++++++++++++++++++++------------------
>  3 files changed, 158 insertions(+), 102 deletions(-)
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
> + * Each aio_bh_poll() call carves off a slice of the BH list, so that ne=
wly
> + * scheduled BHs are not processed until the next aio_bh_poll() call.  A=
ll
> + * active aio_bh_poll() calls chain their slices together in a list, so =
that
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
>      g_assert_cmpint(data1.n, =3D=3D, data1.max);
>      g_assert(data1.bh =3D=3D NULL);
>
> -    g_assert(!g_main_context_iteration(NULL, false));
> +    assert(g_main_context_iteration(NULL, false));
> +    assert(!g_main_context_iteration(NULL, false));
>  }
>
>  static void test_source_bh_delete_from_cb_many(void)
> diff --git a/util/async.c b/util/async.c
> index c192a24a61..b94518b948 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -29,6 +29,7 @@
>  #include "block/thread-pool.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/atomic.h"
> +#include "qemu/rcu_queue.h"
>  #include "block/raw-aio.h"
>  #include "qemu/coroutine_int.h"
>  #include "trace.h"
> @@ -36,16 +37,76 @@
>  /***********************************************************/
>  /* bottom halves (can be seen as timers which expire ASAP) */
>
> +/* QEMUBH::flags values */
> +enum {
> +    /* Already enqueued and waiting for aio_bh_poll() */
> +    BH_PENDING   =3D (1 << 0),
> +
> +    /* Invoke the callback */
> +    BH_SCHEDULED =3D (1 << 1),
> +
> +    /* Delete without invoking callback */
> +    BH_DELETED   =3D (1 << 2),
> +
> +    /* Delete after invoking callback */
> +    BH_ONESHOT   =3D (1 << 3),
> +
> +    /* Schedule periodically when the event loop is idle */
> +    BH_IDLE      =3D (1 << 4),
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
> +    AioContext *ctx =3D bh->ctx;
> +    unsigned old_flags;
> +
> +    /*
> +     * The memory barrier implicit in atomic_fetch_or makes sure that:
> +     * 1. idle & any writes needed by the callback are done before the
> +     *    locations are read in the aio_bh_poll.
> +     * 2. ctx is loaded before the callback has a chance to execute and =
bh
> +     *    could be freed.
> +     */
> +    old_flags =3D atomic_fetch_or(&bh->flags, BH_PENDING | new_flags);
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
> +    QEMUBH *bh =3D QSLIST_FIRST_RCU(head);
> +
> +    if (!bh) {
> +        return NULL;
> +    }
> +
> +    QSLIST_REMOVE_HEAD(head, next);
> +
> +    /*
> +     * The atomic_and is paired with aio_bh_enqueue().  The implicit mem=
ory
> +     * barrier ensures that the callback sees all writes done by the sch=
eduling
> +     * thread.  It also ensures that the scheduling thread sees the clea=
red
> +     * flag before bh->cb has run, and thus will call aio_notify again i=
f
> +     * necessary.
> +     */
> +    *flags =3D atomic_fetch_and(&bh->flags,
> +                              ~(BH_PENDING | BH_SCHEDULED | BH_IDLE));
> +    return bh;
> +}
> +
>  void aio_bh_schedule_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaq=
ue)
>  {
>      QEMUBH *bh;
> @@ -55,15 +116,7 @@ void aio_bh_schedule_oneshot(AioContext *ctx, QEMUBHF=
unc *cb, void *opaque)
>          .cb =3D cb,
>          .opaque =3D opaque,
>      };
> -    qemu_lockcnt_lock(&ctx->list_lock);
> -    bh->next =3D ctx->first_bh;
> -    bh->scheduled =3D 1;
> -    bh->deleted =3D 1;
> -    /* Make sure that the members are ready before putting bh into list =
*/
> -    smp_wmb();
> -    ctx->first_bh =3D bh;
> -    qemu_lockcnt_unlock(&ctx->list_lock);
> -    aio_notify(ctx);
> +    aio_bh_enqueue(bh, BH_SCHEDULED | BH_ONESHOT);
>  }
>
>  QEMUBH *aio_bh_new(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
> @@ -75,12 +128,6 @@ QEMUBH *aio_bh_new(AioContext *ctx, QEMUBHFunc *cb, v=
oid *opaque)
>          .cb =3D cb,
>          .opaque =3D opaque,
>      };
> -    qemu_lockcnt_lock(&ctx->list_lock);
> -    bh->next =3D ctx->first_bh;
> -    /* Make sure that the members are ready before putting bh into list =
*/
> -    smp_wmb();
> -    ctx->first_bh =3D bh;
> -    qemu_lockcnt_unlock(&ctx->list_lock);
>      return bh;
>  }
>
> @@ -89,91 +136,56 @@ void aio_bh_call(QEMUBH *bh)
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
> -    bool deleted =3D false;
> -
> -    ret =3D 0;
> -    for (bh =3D atomic_rcu_read(&ctx->first_bh); bh; bh =3D next) {
> -        next =3D atomic_rcu_read(&bh->next);
> -        /* The atomic_xchg is paired with the one in qemu_bh_schedule.  =
The
> -         * implicit memory barrier ensures that the callback sees all wr=
ites
> -         * done by the scheduling thread.  It also ensures that the sche=
duling
> -         * thread sees the zero before bh->cb has run, and thus will cal=
l
> -         * aio_notify again if necessary.
> -         */
> -        if (atomic_xchg(&bh->scheduled, 0)) {
> +    BHListSlice slice;
> +    BHListSlice *s;
> +    int ret =3D 0;
> +
> +    QSLIST_MOVE_ATOMIC(&slice.bh_list, &ctx->bh_list);
> +    QSIMPLEQ_INSERT_TAIL(&ctx->bh_slice_list, &slice, next);
> +
> +    while ((s =3D QSIMPLEQ_FIRST(&ctx->bh_slice_list))) {
> +        QEMUBH *bh;
> +        unsigned flags;
> +
> +        bh =3D aio_bh_dequeue(&s->bh_list, &flags);
> +        if (!bh) {
> +            QSIMPLEQ_REMOVE_HEAD(&ctx->bh_slice_list, next);
> +            continue;
> +        }
> +
> +        if ((flags & (BH_SCHEDULED | BH_DELETED)) =3D=3D BH_SCHEDULED) {
>              /* Idle BHs don't count as progress */
> -            if (!bh->idle) {
> +            if (!(flags & BH_IDLE)) {
>                  ret =3D 1;
>              }
> -            bh->idle =3D 0;
>              aio_bh_call(bh);
>          }
> -        if (bh->deleted) {
> -            deleted =3D true;
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
> -        bhp =3D &ctx->first_bh;
> -        while (*bhp) {
> -            bh =3D *bhp;
> -            if (bh->deleted && !bh->scheduled) {
> -                *bhp =3D bh->next;
> -                g_free(bh);
> -            } else {
> -                bhp =3D &bh->next;
> -            }
> -        }
> -        qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
> -    }
>      return ret;
>  }
>
>  void qemu_bh_schedule_idle(QEMUBH *bh)
>  {
> -    bh->idle =3D 1;
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
> -    ctx =3D bh->ctx;
> -    bh->idle =3D 0;
> -    /* The memory barrier implicit in atomic_xchg makes sure that:
> -     * 1. idle & any writes needed by the callback are done before the
> -     *    locations are read in the aio_bh_poll.
> -     * 2. ctx is loaded before scheduled is set and the callback has a c=
hance
> -     *    to execute.
> -     */
> -    if (atomic_xchg(&bh->scheduled, 1) =3D=3D 0) {
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
>  /* This func is async.The bottom half will do the delete action at the f=
inial
> @@ -181,21 +193,16 @@ void qemu_bh_cancel(QEMUBH *bh)
>   */
>  void qemu_bh_delete(QEMUBH *bh)
>  {
> -    bh->scheduled =3D 0;
> -    bh->deleted =3D 1;
> +    aio_bh_enqueue(bh, BH_DELETED);
>  }
>
> -int64_t
> -aio_compute_timeout(AioContext *ctx)
> +static int64_t aio_compute_bh_timeout(BHList *head, int timeout)
>  {
> -    int64_t deadline;
> -    int timeout =3D -1;
>      QEMUBH *bh;
>
> -    for (bh =3D atomic_rcu_read(&ctx->first_bh); bh;
> -         bh =3D atomic_rcu_read(&bh->next)) {
> -        if (bh->scheduled) {
> -            if (bh->idle) {
> +    QSLIST_FOREACH_RCU(bh, head, next) {
> +        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) =3D=3D BH_SCHEDULE=
D) {
> +            if (bh->flags & BH_IDLE) {
>                  /* idle bottom halves will be polled at least
>                   * every 10ms */
>                  timeout =3D 10000000;
> @@ -207,6 +214,28 @@ aio_compute_timeout(AioContext *ctx)
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
> +    int timeout =3D -1;
> +
> +    timeout =3D aio_compute_bh_timeout(&ctx->bh_list, timeout);
> +    if (timeout =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    QSIMPLEQ_FOREACH(s, &ctx->bh_slice_list, next) {
> +        timeout =3D aio_compute_bh_timeout(&s->bh_list, timeout);
> +        if (timeout =3D=3D 0) {
> +            return 0;
> +        }
> +    }
> +
>      deadline =3D timerlistgroup_deadline_ns(&ctx->tlg);
>      if (deadline =3D=3D 0) {
>          return 0;
> @@ -237,15 +266,24 @@ aio_ctx_check(GSource *source)
>  {
>      AioContext *ctx =3D (AioContext *) source;
>      QEMUBH *bh;
> +    BHListSlice *s;
>
>      atomic_and(&ctx->notify_me, ~1);
>      aio_notify_accept(ctx);
>
> -    for (bh =3D ctx->first_bh; bh; bh =3D bh->next) {
> -        if (bh->scheduled) {
> +    QSLIST_FOREACH_RCU(bh, &ctx->bh_list, next) {
> +        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) =3D=3D BH_SCHEDULE=
D) {
>              return true;
>          }
>      }
> +
> +    QSIMPLEQ_FOREACH(s, &ctx->bh_slice_list, next) {
> +        QSLIST_FOREACH_RCU(bh, &s->bh_list, next) {
> +            if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) =3D=3D BH_SCHE=
DULED) {
> +                return true;
> +            }
> +        }
> +    }
>      return aio_pending(ctx) || (timerlistgroup_deadline_ns(&ctx->tlg) =
=3D=3D 0);
>  }
>
> @@ -265,6 +303,8 @@ static void
>  aio_ctx_finalize(GSource     *source)
>  {
>      AioContext *ctx =3D (AioContext *) source;
> +    QEMUBH *bh;
> +    unsigned flags;
>
>      thread_pool_free(ctx->thread_pool);
>
> @@ -287,18 +327,15 @@ aio_ctx_finalize(GSource     *source)
>      assert(QSLIST_EMPTY(&ctx->scheduled_coroutines));
>      qemu_bh_delete(ctx->co_schedule_bh);
>
> -    qemu_lockcnt_lock(&ctx->list_lock);
> -    assert(!qemu_lockcnt_count(&ctx->list_lock));
> -    while (ctx->first_bh) {
> -        QEMUBH *next =3D ctx->first_bh->next;
> +    /* There must be no aio_bh_poll() calls going on */
> +    assert(QSIMPLEQ_EMPTY(&ctx->bh_slice_list));
>
> +    while ((bh =3D aio_bh_dequeue(&ctx->bh_list, &flags))) {
>          /* qemu_bh_delete() must have been called on BHs in this AioCont=
ext */
> -        assert(ctx->first_bh->deleted);
> +        assert(flags & BH_DELETED);
>
> -        g_free(ctx->first_bh);
> -        ctx->first_bh =3D next;
> +        g_free(bh);
>      }
> -    qemu_lockcnt_unlock(&ctx->list_lock);
>
>      aio_set_event_notifier(ctx, &ctx->notifier, false, NULL, NULL);
>      event_notifier_cleanup(&ctx->notifier);
> @@ -445,6 +482,8 @@ AioContext *aio_context_new(Error **errp)
>      AioContext *ctx;
>
>      ctx =3D (AioContext *) g_source_new(&aio_source_funcs, sizeof(AioCon=
text));
> +    QSLIST_INIT(&ctx->bh_list);
> +    QSIMPLEQ_INIT(&ctx->bh_slice_list);
>      aio_context_setup(ctx);
>
>      ret =3D event_notifier_init(&ctx->notifier, false);
> --
> 2.24.1
>


--=20
Marc-Andr=C3=A9 Lureau

