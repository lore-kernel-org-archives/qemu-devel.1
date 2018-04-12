Received: from eggs.gnu.org ([2001:4830:134:3::10]:59649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6XlV-0000bj-Ph
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6XlR-0004nj-Ob
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:39:33 -0400
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-9-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63e38fb9-3a25-f857-0795-e0ec333ee589@redhat.com>
Date: Thu, 12 Apr 2018 10:39:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180411163940.2523-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/19] block: Remove bdrv_drain_recurse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

On 11/04/2018 18:39, Kevin Wolf wrote:
> For bdrv_drain(), recursively waiting for child node requests is
> pointless because we didn't quiesce their parents, so new requests could
> come in anyway. Letting the function work only on a single node makes it
> more consistent.
> 
> For subtree drains and drain_all, we already have the recursion in
> bdrv_do_drained_begin(), so the extra recursion doesn't add anything
> either.
> 
> Remove the useless code.

This solves one of my questions, but leaves me the doubt about quadratic
complexity.

Paolo

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 36 +++---------------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 0a778eeff4..f24f39c278 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -211,38 +211,6 @@ bool bdrv_drain_poll(BlockDriverState *bs, bool top_level)
>      return atomic_read(&bs->in_flight);
>  }
>  
> -static bool bdrv_drain_recurse(BlockDriverState *bs)
> -{
> -    BdrvChild *child, *tmp;
> -    bool waited;
> -
> -    /* Wait for drained requests to finish */
> -    waited = BDRV_POLL_WHILE(bs, bdrv_drain_poll(bs, true));
> -
> -    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
> -        BlockDriverState *bs = child->bs;
> -        bool in_main_loop =
> -            qemu_get_current_aio_context() == qemu_get_aio_context();
> -        assert(bs->refcnt > 0);
> -        if (in_main_loop) {
> -            /* In case the recursive bdrv_drain_recurse processes a
> -             * block_job_defer_to_main_loop BH and modifies the graph,
> -             * let's hold a reference to bs until we are done.
> -             *
> -             * IOThread doesn't have such a BH, and it is not safe to call
> -             * bdrv_unref without BQL, so skip doing it there.
> -             */
> -            bdrv_ref(bs);
> -        }
> -        waited |= bdrv_drain_recurse(bs);
> -        if (in_main_loop) {
> -            bdrv_unref(bs);
> -        }
> -    }
> -
> -    return waited;
> -}
> -
>  static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
>                                    BdrvChild *parent);
>  static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
> @@ -310,7 +278,9 @@ void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
>  
>      bdrv_parent_drained_begin(bs, parent);
>      bdrv_drain_invoke(bs, true);
> -    bdrv_drain_recurse(bs);
> +
> +    /* Wait for drained requests to finish */
> +    BDRV_POLL_WHILE(bs, bdrv_drain_poll(bs, true));
>  
>      if (recursive) {
>          bs->recursive_quiesce_counter++;
> 
