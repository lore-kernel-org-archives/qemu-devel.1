Received: from eggs.gnu.org ([2001:4830:134:3::10]:32926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eld17-0003Wx-Vn
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eld12-0003JS-2e
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:01:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eld11-0003J2-U0
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:01:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67B7E4023141
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 16:01:07 +0000 (UTC)
References: <20180213142102.14450-1-stefanha@redhat.com>
	<20180213142102.14450-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73eb771d-ddcd-42e6-5895-23e6024ccc80@redhat.com>
Date: Tue, 13 Feb 2018 10:01:06 -0600
MIME-Version: 1.0
In-Reply-To: <20180213142102.14450-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block: extract AIO_WAIT_WHILE()
 from BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On 02/13/2018 08:20 AM, Stefan Hajnoczi wrote:
> BlockDriverState has the BDRV_POLL_WHILE() macro to wait on event loop
> activity while a condition evaluates to true.  This is used to implement
> synchronous operations where it acts as a condvar between the IOThread
> running the operation and the main loop waiting for the operation.  It
> can also be called from the thread that owns the AioContext and in that
> case it's just a nested event loop.
> 
> BlockBackend needs this behavior but doesn't always have a
> BlockDriverState it can use.  This patch extracts BDRV_POLL_WHILE() into
> the AioWait abstraction, which can be used with AioContext and isn't
> tied to BlockDriverState anymore.
> 
> This feature could be built directly into AioContext but then all users
> would kick the event loop even if they signal different conditions.
> Imagine an AioContext with many BlockDriverStates, each time a request
> completes any waiter would wake up and re-check their condition.  It's
> nicer to keep a separate AioWait object for each condition instead.
> 
> Please see "block/aio-wait.h" for details on the API.
> 
> The name AIO_WAIT_WHILE() avoids the confusion between AIO_POLL_WHILE()
> and AioContext polling.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Trying to understand here:


> +#define AIO_WAIT_WHILE(wait, ctx, cond) ({                  \
> +    bool waited_ = false;                                   \
> +    bool busy_ = true;                                      \
> +    AioWait *wait_ = (wait);                                \
> +    AioContext *ctx_ = (ctx);                               \
> +    if (aio_context_in_iothread(ctx_)) {                    \
> +        while ((cond) || busy_) {                           \
> +            busy_ = aio_poll(ctx_, (cond));                 \
> +            waited_ |= !!(cond) | busy_;                    \
> +        }                                                   \

If we are in an iothread already, we never dereference wait,

> +    } else {                                                \
> +        assert(qemu_get_current_aio_context() ==            \
> +               qemu_get_aio_context());                     \
> +        assert(!wait_->need_kick);                          \

but if we are in the main loop, wait must be non-NULL.

> +++ b/include/block/block.h
> @@ -2,6 +2,7 @@
>   #define BLOCK_H
>   
>   #include "block/aio.h"
> +#include "block/aio-wait.h"
>   #include "qapi-types.h"
>   #include "qemu/iov.h"
>   #include "qemu/coroutine.h"
> @@ -367,41 +368,14 @@ void bdrv_drain_all_begin(void);
>   void bdrv_drain_all_end(void);
>   void bdrv_drain_all(void);
>   
> +/* Returns NULL when bs == NULL */
> +AioWait *bdrv_get_aio_wait(BlockDriverState *bs);

This can return NULL, so it is only ever safe to use in an iothread; 
because if it is used in the main loop,...

> +
>   #define BDRV_POLL_WHILE(bs, cond) ({                       \

> +    AIO_WAIT_WHILE(bdrv_get_aio_wait(bs_),                 \
> +                   bdrv_get_aio_context(bs_),              \
> +                   cond); })

...we can pass NULL as the wait parameter, which will crash.

> +++ b/block.c
> @@ -4716,6 +4716,11 @@ AioContext *bdrv_get_aio_context(BlockDriverState *bs)
>       return bs->aio_context;
>   }
>   
> +AioWait *bdrv_get_aio_wait(BlockDriverState *bs)
> +{
> +    return bs ? &bs->wait : NULL;
> +}

So, do we need documentation to that fact?  Also,

> +++ b/block/io.c

>   void bdrv_wakeup(BlockDriverState *bs)
>   {
> -    /* The barrier (or an atomic op) is in the caller.  */
> -    if (atomic_read(&bs->wakeup)) {
> -        aio_bh_schedule_oneshot(qemu_get_aio_context(), dummy_bh_cb, NULL);
> -    }
> +    aio_wait_kick(bdrv_get_aio_wait(bs));

this is another case where passing NULL...

> +++ b/util/aio-wait.c

> +void aio_wait_kick(AioWait *wait)
> +{
> +    /* The barrier (or an atomic op) is in the caller.  */
> +    if (atomic_read(&wait->need_kick)) {

...is bad.  Does that mean bdrv_wakeup() can only be called when bs is 
non-NULL?  Does that need documentation?

It may be that your patch is correct (as I'm not an expert on the rules 
in play here), but more comments may help.  Or you may have a NULL 
dereference bug lurking.  So at this point, I can't give R-b, even 
though the refactoring of the BDRV_POLL_WHILE() macro into a separate 
helper makes sense from the high level view.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
