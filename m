Received: from eggs.gnu.org ([2001:4830:134:3::10]:52948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dL5GY-00005e-U9
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 06:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dL5GX-0006rT-NB
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 06:11:10 -0400
References: <20170522135704.842-1-stefanha@redhat.com>
	<20170522135704.842-4-stefanha@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <add32dd6-f842-9d66-0f7f-6e0e2b7c8100@virtuozzo.com>
Date: Wed, 14 Jun 2017 13:10:10 +0300
MIME-Version: 1.0
In-Reply-To: <20170522135704.842-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] migration: avoid recursive
 AioContext locking in save_vmstate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org


On 22.05.2017 16:57, Stefan Hajnoczi wrote:
> AioContext was designed to allow nested acquire/release calls.  It uses
> a recursive mutex so callers don't need to worry about nesting...or so
> we thought.
> 
> BDRV_POLL_WHILE() is used to wait for block I/O requests.  It releases
> the AioContext temporarily around aio_poll().  This gives IOThreads a
> chance to acquire the AioContext to process I/O completions.
> 
> It turns out that recursive locking and BDRV_POLL_WHILE() don't mix.
> BDRV_POLL_WHILE() only releases the AioContext once, so the IOThread
> will not be able to acquire the AioContext if it was acquired
> multiple times.
> 
> Instead of trying to release AioContext n times in BDRV_POLL_WHILE(),
> this patch simply avoids nested locking in save_vmstate().  It's the
> simplest fix and we should step back to consider the big picture with
> all the recent changes to block layer threading.
> 
> This patch is the final fix to solve 'savevm' hanging with -object
> iothread.

The same I see in external_snapshot_prepare():
     /* Acquire AioContext now so any threads operating on old_bs stop */
     state->aio_context = bdrv_get_aio_context(state->old_bs);
     aio_context_acquire(state->aio_context);
     bdrv_drained_begin(state->old_bs);

     if (!bdrv_is_inserted(state->old_bs)) {
         error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, device);
         return;
     }

     if (bdrv_op_is_blocked(state->old_bs,
                            BLOCK_OP_TYPE_EXTERNAL_SNAPSHOT, errp)) {
         return;
     }

     if (!bdrv_is_read_only(state->old_bs)) {
         if (bdrv_flush(state->old_bs)) {      <---!!!

and at the moment BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE),
we have at least two locks.. So here is another deadlock.

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   migration/savevm.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f5e8194..3ca319f 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2150,6 +2150,14 @@ int save_vmstate(const char *name, Error **errp)
>           goto the_end;
>       }
>   
> +    /* The bdrv_all_create_snapshot() call that follows acquires the AioContext
> +     * for itself.  BDRV_POLL_WHILE() does not support nested locking because
> +     * it only releases the lock once.  Therefore synchronous I/O will deadlock
> +     * unless we release the AioContext before bdrv_all_create_snapshot().
> +     */
> +    aio_context_release(aio_context);
> +    aio_context = NULL;
> +
>       ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
>       if (ret < 0) {
>           error_setg(errp, "Error while creating snapshot on '%s'",
> @@ -2160,7 +2168,9 @@ int save_vmstate(const char *name, Error **errp)
>       ret = 0;
>   
>    the_end:
> -    aio_context_release(aio_context);
> +    if (aio_context) {
> +        aio_context_release(aio_context);
> +    }
>       if (saved_vm_running) {
>           vm_start();
>       }
> 
