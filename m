Received: from eggs.gnu.org ([2001:4830:134:3::10]:53477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft6Su-00035k-CY
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft6St-00014o-Jx
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:25:04 -0400
Date: Fri, 24 Aug 2018 15:24:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180824072456.GE31581@lemon.usersys.redhat.com>
References: <20180817170246.14641-1-kwolf@redhat.com>
	<20180817170246.14641-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817170246.14641-5-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 4/5] block: Drop AioContext lock in
 bdrv_drain_poll_top_level()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org

On Fri, 08/17 19:02, Kevin Wolf wrote:
> Simimlar to AIO_WAIT_WHILE(), bdrv_drain_poll_top_level() needs to
> release the AioContext lock of the node to be drained before calling
> aio_poll(). Otherwise, callbacks called by aio_poll() would possibly
> take the lock a second time and run into a deadlock with a nested
> AIO_WAIT_WHILE() call.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 7100344c7b..832d2536bf 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -268,9 +268,32 @@ bool bdrv_drain_poll(BlockDriverState *bs, bool recursive,
>  static bool bdrv_drain_poll_top_level(BlockDriverState *bs, bool recursive,
>                                        BdrvChild *ignore_parent)
>  {
> +    AioContext *ctx = bdrv_get_aio_context(bs);
> +
> +    /*
> +     * We cannot easily release the lock unconditionally here because many
> +     * callers of drain function (like qemu initialisation, tools, etc.) don't
> +     * even hold the main context lock.
> +     *
> +     * This means that we fix potential deadlocks for the case where we are in
> +     * the main context and polling a BDS in a different AioContext, but
> +     * draining a BDS in the main context from a different I/O thread would
> +     * still have this problem. Fortunately, this isn't supposed to happen
> +     * anyway.
> +     */
> +    if (ctx != qemu_get_aio_context()) {
> +        aio_context_release(ctx);
> +    } else {
> +        assert(qemu_get_current_aio_context() == qemu_get_aio_context());
> +    }
> +
>      /* Execute pending BHs first and check everything else only after the BHs
>       * have executed. */
> -    while (aio_poll(bs->aio_context, false));
> +    while (aio_poll(ctx, false));
> +
> +    if (ctx != qemu_get_aio_context()) {
> +        aio_context_acquire(ctx);
> +    }
>  
>      return bdrv_drain_poll(bs, recursive, ignore_parent, false);
>  }
> -- 
> 2.13.6
> 

The same question as patch 3: why not just use AIO_WAIT_WHILE() here? It takes
care to not release any lock if both running and polling in the main context
(taking the in_aio_context_home_thread() branch).

Fam
