Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3459C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8988F20882
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWyIfAIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8988F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PO4-0004pw-JW
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8PMM-0002s0-CS
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:46:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56799
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8PMJ-0003XG-AD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597848394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGzGd+pmy2Z8yJNArK4j87/1yNUdnvtyYX9XDWsyyBU=;
 b=jWyIfAIffZyXhk21zN0BrKH5MI75DKkzF+qLQNmRLZRG5seo58Tv/fS7J68rXgdKG5o/+t
 DcJCpO3osPqyaboIop00GsvMsYzfCtrMigl3AiGNu77pDd9ejXPqeXV49ckcW8DwdAkF12
 oFXg5MOT83ivsM9OUta74rSUjkgg5z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-7DsyBykAMr6sTLEqrY8RyA-1; Wed, 19 Aug 2020 10:46:29 -0400
X-MC-Unique: 7DsyBykAMr6sTLEqrY8RyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9BB885C70A;
 Wed, 19 Aug 2020 14:46:27 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BD3B10013C2;
 Wed, 19 Aug 2020 14:46:27 +0000 (UTC)
Subject: Re: [PATCH v3] block/nbd: use non-blocking connect: fix vm hang on
 connect()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200812145237.4396-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <76eefe05-d608-2c1e-252a-361533ea4a0b@redhat.com>
Date: Wed, 19 Aug 2020 09:46:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812145237.4396-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 9:52 AM, Vladimir Sementsov-Ogievskiy wrote:
> This make nbd connection_co to yield during reconnects, so that

s/make nbd connection_co to/makes nbd's connection_co/

> reconnect doesn't hang up the main thread. This is very important in

s/hang up/block/

> case of unavailable nbd server host: connect() call may take a long

s/of/of an/

> time, blocking the main thread (and due to reconnect, it will hang
> again and again with small gaps of working time during pauses between
> connection attempts).
> 
> Realization notes:
> 
>   - We don't want to implement non-blocking connect() over non-blocking
>   socket, because getaddrinfo() doesn't have portable non-blocking
>   realization anyway, so let's just use a thread for both getaddrinfo()
>   and connect().
> 
>   - We can't use qio_channel_socket_connect_async (which behave

behaves

>   similarly and start a thread to execute connect() call), as it's rely

starts
relying

>   on someone iterating main loop (g_main_loop_run() or something like
>   this), which is not always the case.
> 
>   - We can't use thread_pool_submit_co API, as thread pool waits for all
>   threads to finish (but we don't want to wait for blocking reconnect
>   attempt on shutdown.
> 
>   So, we just create the thread by hand. Some additional difficulties
>   are:
> 
>   - We want our connect don't block drained sections and aio context

s/don't block/to avoid blocking/

>   switches. To achieve this, we make it possible to "cancel" synchronous
>   wait for the connect (which is an coroutine yield actually), still,

s/an/a/

>   the thread continues in background, and it successful result may be

s/it successful/if successful, its/

>   reused on next reconnect attempt.
> 
>   - We don't want to wait for reconnect on shutdown, so there is
>   CONNECT_THREAD_RUNNING_DETACHED thread state, which means that block
>   layer not more interested in a result, and thread should close new

which means that the block layer is no longer interested

>   connected socket on finish and free the state.
> 
> How to reproduce the bug, fixed with this commit:
> 
> 1. Create an image on node1:
>     qemu-img create -f qcow2 xx 100M
> 
> 2. Start NBD server on node1:
>     qemu-nbd xx
> 
> 3. Start vm with second nbd disk on node2, like this:
> 
>    ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -drive \
>      file=/work/images/cent7.qcow2 -drive file=nbd+tcp://192.168.100.2 \
>      -vnc :0 -qmp stdio -m 2G -enable-kvm -vga std
> 
> 4. Access the vm through vnc (or some other way?), and check that NBD
>     drive works:
> 
>     dd if=/dev/sdb of=/dev/null bs=1M count=10
> 
>     - the command should succeed.
> 
> 5. Now, let's trigger nbd-reconnect loop in Qemu process. For this:
> 
> 5.1 Kill NBD server on node1
> 
> 5.2 run "dd if=/dev/sdb of=/dev/null bs=1M count=10" in the guest
>      again. The command should fail and a lot of error messages about
>      failing disk may appear as well.
> 
>      Now NBD client driver in Qemu tries to reconnect.
>      Still, VM works well.
> 
> 6. Make node1 unavailable on NBD port, so connect() from node2 will
>     last for a long time:
> 
>     On node1 (Note, that 10809 is just a default NBD port):
> 
>     sudo iptables -A INPUT -p tcp --dport 10809 -j DROP
> 
>     After some time the guest hangs, and you may check in gdb that Qemu
>     hangs in connect() call, issued from the main thread. This is the
>     BUG.
> 
> 7. Don't forget to drop iptables rule from your node1:
> 
>     sudo iptables -D INPUT -p tcp --dport 10809 -j DROP
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> Hi!
> 
> This a continuation of "[PATCH v2 for-5.1? 0/5] Fix nbd reconnect dead-locks",
> which was mostly merged to 5.1. The only last patch was not merged, and
> here is a no-change resend for convenience.
> 
> 
>   block/nbd.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 265 insertions(+), 1 deletion(-)

Looks big, but the commit message goes into good detail about what the 
problem is, why the solution takes the approach it does, and a good 
formula for reproduction.

> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 7bb881fef4..919ec5e573 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -38,6 +38,7 @@
>   
>   #include "qapi/qapi-visit-sockets.h"
>   #include "qapi/qmp/qstring.h"
> +#include "qapi/clone-visitor.h"
>   
>   #include "block/qdict.h"
>   #include "block/nbd.h"
> @@ -62,6 +63,47 @@ typedef enum NBDClientState {
>       NBD_CLIENT_QUIT
>   } NBDClientState;
>   
> +typedef enum NBDConnectThreadState {
> +/* No thread, no pending results */
> +    CONNECT_THREAD_NONE,

I'd indent the comments by four spaces, to line up with the enumeration 
values they describe.

> +
> +/* Thread is running, no results for now */
> +    CONNECT_THREAD_RUNNING,
> +
> +/*
> + * Thread is running, but requestor exited. Thread should close the new socket
> + * and free the connect state on exit.
> + */
> +    CONNECT_THREAD_RUNNING_DETACHED,
> +
> +/* Thread finished, results are stored in a state */
> +    CONNECT_THREAD_FAIL,
> +    CONNECT_THREAD_SUCCESS
> +} NBDConnectThreadState;
> +
> +typedef struct NBDConnectThread {
> +    /* Initialization constants */
> +    SocketAddress *saddr; /* address to connect to */
> +    /*
> +     * Bottom half to schedule on completion. Scheduled only if bh_ctx is not
> +     * NULL
> +     */
> +    QEMUBHFunc *bh_func;
> +    void *bh_opaque;
> +
> +    /*
> +     * Result of last attempt. Valid in FAIL and SUCCESS states.
> +     * If you want to steal error, don't forget to set pointer to NULL.
> +     */
> +    QIOChannelSocket *sioc;
> +    Error *err;
> +
> +    /* state and bh_ctx are protected by mutex */
> +    QemuMutex mutex;
> +    NBDConnectThreadState state; /* current state of the thread */
> +    AioContext *bh_ctx; /* where to schedule bh (NULL means don't schedule) */
> +} NBDConnectThread;

Looks reasonable.

> @@ -246,6 +298,216 @@ static bool nbd_client_connecting_wait(BDRVNBDState *s)
>       return s->state == NBD_CLIENT_CONNECTING_WAIT;
>   }
>   
> +static void connect_bh(void *opaque)
> +{
> +    BDRVNBDState *state = opaque;
> +
> +    assert(state->wait_connect);
> +    state->wait_connect = false;
> +    aio_co_wake(state->connection_co);
> +}
> +
> +static void nbd_init_connect_thread(BDRVNBDState *s)
> +{
> +    s->connect_thread = g_new(NBDConnectThread, 1);
> +
> +    *s->connect_thread = (NBDConnectThread) {
> +        .saddr = QAPI_CLONE(SocketAddress, s->saddr),
> +        .state = CONNECT_THREAD_NONE,
> +        .bh_func = connect_bh,
> +        .bh_opaque = s
> +    };

I prefer using trailing commas in initializer lists (less churn if a 
later patch needs to initialize another member)

> +
> +    qemu_mutex_init(&s->connect_thread->mutex);
> +}
> +
> +static void nbd_free_connect_thread(NBDConnectThread *thr)
> +{
> +    if (thr->sioc) {
> +        qio_channel_close(QIO_CHANNEL(thr->sioc), NULL);
> +    }
> +    error_free(thr->err);
> +    qapi_free_SocketAddress(thr->saddr);
> +    g_free(thr);
> +}
> +
> +static void *connect_thread_func(void *opaque)
> +{
> +    NBDConnectThread *thr = opaque;
> +    int ret;
> +    bool do_free = false;
> +
> +    thr->sioc = qio_channel_socket_new();
> +
> +    error_free(thr->err);
> +    thr->err = NULL;

Why do we need to clear the error at startup?  Shouldn't it already be 
created as starting life NULL?

> +    ret = qio_channel_socket_connect_sync(thr->sioc, thr->saddr, &thr->err);
> +    if (ret < 0) {
> +        object_unref(OBJECT(thr->sioc));
> +        thr->sioc = NULL;
> +    }
> +
> +    qemu_mutex_lock(&thr->mutex);
> +
> +    switch (thr->state) {
> +    case CONNECT_THREAD_RUNNING:
> +        thr->state = ret < 0 ? CONNECT_THREAD_FAIL : CONNECT_THREAD_SUCCESS;
> +        if (thr->bh_ctx) {
> +            aio_bh_schedule_oneshot(thr->bh_ctx, thr->bh_func, thr->bh_opaque);
> +
> +            /* play safe, don't reuse bh_ctx on further connection attempts */
> +            thr->bh_ctx = NULL;
> +        }
> +        break;
> +    case CONNECT_THREAD_RUNNING_DETACHED:
> +        do_free = true;
> +        break;
> +    default:
> +        abort();
> +    }
> +
> +    qemu_mutex_unlock(&thr->mutex);
> +
> +    if (do_free) {
> +        nbd_free_connect_thread(thr);
> +    }
> +
> +    return NULL;
> +}
> +
> +static QIOChannelSocket *coroutine_fn
> +nbd_co_establish_connection(BlockDriverState *bs, Error **errp)

There's some inconsistency on whether you use:

return_type name()

or

return_type
name()

It's aesthetic, but it would be nice to stick to one (I prefer the 
second, but see that the qemu code base as a whole is inconsistent, so 
the best we can do is stay consistent within a file)

> +{
> +    QemuThread thread;
> +    BDRVNBDState *s = bs->opaque;
> +    QIOChannelSocket *res;
> +    NBDConnectThread *thr = s->connect_thread;
> +
> +    qemu_mutex_lock(&thr->mutex);

Should we use the auto-cleanup macro magic here? ...

> +
> +    switch (thr->state) {
> +    case CONNECT_THREAD_FAIL:
> +    case CONNECT_THREAD_NONE:
> +        error_free(thr->err);
> +        thr->err = NULL;
> +        thr->state = CONNECT_THREAD_RUNNING;
> +        qemu_thread_create(&thread, "nbd-connect",
> +                           connect_thread_func, thr, QEMU_THREAD_DETACHED);
> +        break;
> +    case CONNECT_THREAD_SUCCESS:
> +        /* Previous attempt finally succeeded in background */
> +        thr->state = CONNECT_THREAD_NONE;
> +        res = thr->sioc;
> +        thr->sioc = NULL;
> +        qemu_mutex_unlock(&thr->mutex);
> +        return res;
> +    case CONNECT_THREAD_RUNNING:
> +        /* Already running, will wait */
> +        break;
> +    default:
> +        abort();
> +    }
> +
> +    thr->bh_ctx = qemu_get_current_aio_context();
> +
> +    qemu_mutex_unlock(&thr->mutex);
> +
> +

...to do so, you'd put the above in a nested scope, where the mutex is 
released when the scope is exited.

> +    /*
> +     * We are going to wait for connect-thread finish, but
> +     * nbd_client_co_drain_begin() can interrupt.
> +     *
> +     * Note that wait_connect variable is not visible for connect-thread. It
> +     * doesn't need mutex protection, it used only inside home aio context of
> +     * bs.
> +     */
> +    s->wait_connect = true;
> +    qemu_coroutine_yield();
> +
> +    qemu_mutex_lock(&thr->mutex);
> +
> +    switch (thr->state) {
> +    case CONNECT_THREAD_SUCCESS:
> +    case CONNECT_THREAD_FAIL:
> +        thr->state = CONNECT_THREAD_NONE;
> +        error_propagate(errp, thr->err);
> +        thr->err = NULL;
> +        res = thr->sioc;
> +        thr->sioc = NULL;
> +        break;
> +    case CONNECT_THREAD_RUNNING:
> +    case CONNECT_THREAD_RUNNING_DETACHED:
> +        /*
> +         * Obviously, drained section wants to start. Report the attempt as
> +         * failed. Still connect thread is executing in background, and its
> +         * result may be used for next connection attempt.
> +         */
> +        res = NULL;
> +        error_setg(errp, "Connection attempt cancelled by other operation");
> +        break;
> +
> +    case CONNECT_THREAD_NONE:
> +        /*
> +         * Impossible. We've seen this thread running. So it should be
> +         * running or at least give some results.
> +         */
> +        abort();
> +
> +    default:
> +        abort();
> +    }
> +
> +    qemu_mutex_unlock(&thr->mutex);
> +
> +    return res;
> +}

Looks sensible.

> +
> +/*
> + * nbd_co_establish_connection_cancel
> + * Cancel nbd_co_establish_connection asynchronously: it will finish soon, to
> + * allow drained section to begin.
> + *
> + * If detach is true, also cleanup the state (or if thread is running, move it
> + * to CONNECT_THREAD_RUNNING_DETACHED state). s->connect_thread becomes NULL if
> + * detach is true.
> + */
> +static void nbd_co_establish_connection_cancel(BlockDriverState *bs,
> +                                               bool detach)
> +{
> +    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;

Is the cast necessary here?

> +    NBDConnectThread *thr = s->connect_thread;
> +    bool wake = false;
> +    bool do_free = false;
> +
> +    qemu_mutex_lock(&thr->mutex);
> +
> +    if (thr->state == CONNECT_THREAD_RUNNING) {
> +        /* We can cancel only in running state, when bh is not yet scheduled */
> +        thr->bh_ctx = NULL;
> +        if (s->wait_connect) {
> +            s->wait_connect = false;
> +            wake = true;
> +        }
> +        if (detach) {
> +            thr->state = CONNECT_THREAD_RUNNING_DETACHED;
> +            s->connect_thread = NULL;
> +        }
> +    } else if (detach) {
> +        do_free = true;
> +    }
> +
> +    qemu_mutex_unlock(&thr->mutex);
> +
> +    if (do_free) {
> +        nbd_free_connect_thread(thr);
> +        s->connect_thread = NULL;
> +    }
> +
> +    if (wake) {
> +        aio_co_wake(s->connection_co);
> +    }
> +}
> +
>   static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
>   {
>       int ret;
> @@ -289,7 +551,7 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
>           s->ioc = NULL;
>       }
>   
> -    sioc = nbd_establish_connection(s->saddr, &local_err);
> +    sioc = nbd_co_establish_connection(s->bs, &local_err);
>       if (!sioc) {
>           ret = -ECONNREFUSED;
>           goto out;
> @@ -1946,6 +2208,8 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
>       /* successfully connected */
>       s->state = NBD_CLIENT_CONNECTED;
>   
> +    nbd_init_connect_thread(s);
> +
>       s->connection_co = qemu_coroutine_create(nbd_connection_entry, s);
>       bdrv_inc_in_flight(bs);
>       aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
> 

Overall this looks good to me.  I still want to run some tests 
(including playing with your reproducer formula), but code-wise, I can 
offer:

Reviewed-by: Eric Blake <eblake@redhat.com>

I pointed out a number of grammar and format touchups; I don't mind 
applying those locally, if there is no other reason to send a v4.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


