Received: from eggs.gnu.org ([2001:4830:134:3::10]:55643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euKO8-0004oc-W2
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euKO8-0002XQ-75
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:56:57 -0500
References: <20180306204819.11266-1-stefanha@redhat.com>
	<20180306204819.11266-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f3e7a178-0002-fd12-caf2-585171de1b04@redhat.com>
Date: Fri, 9 Mar 2018 09:56:44 -0600
MIME-Version: 1.0
In-Reply-To: <20180306204819.11266-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] block: let
 blk_add/remove_aio_context_notifier() tolerate BDS changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Panella <spanella@gmail.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 03/06/2018 02:48 PM, Stefan Hajnoczi wrote:
> Commit 2019ba0a0197 ("block: Add AioContextNotifier functions to BB")
> added blk_add/remove_aio_context_notifier() and implemented them by
> passing through the bdrv_*() equivalent.
> 
> This doesn't work across bdrv_append(), which detaches child->bs and
> re-attaches it to a new BlockDriverState.  When
> blk_remove_aio_context_notifier() is called we will access the new BDS
> instead of the one where the notifier was added!
> 
>>From the point of view of the blk_*() API user, changes to the root BDS
> should be transparent.
> 
> This patch maintains a list of AioContext notifiers in BlockBackend and
> adds/removes them from the BlockDriverState as needed.
> 
> Reported-by: Stefano Panella <spanella@gmail.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   block/block-backend.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   block/trace-events    |  2 ++
>   2 files changed, 65 insertions(+)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 94ffbb6a60..aa27698820 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -31,6 +31,13 @@
>   
>   static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb);
>   
> +typedef struct BlockBackendAioNotifier {
> +    void (*attached_aio_context)(AioContext *new_context, void *opaque);
> +    void (*detach_aio_context)(void *opaque);

Why the difference in tense (past 'attached' vs. present 'detach')?

> @@ -1827,12 +1877,25 @@ void blk_remove_aio_context_notifier(BlockBackend *blk,
>                                        void (*detach_aio_context)(void *),
>                                        void *opaque)
>   {
> +    BlockBackendAioNotifier *notifier;
>       BlockDriverState *bs = blk_bs(blk);
>   
>       if (bs) {
>           bdrv_remove_aio_context_notifier(bs, attached_aio_context,
>                                            detach_aio_context, opaque);
>       }
> +
> +    QLIST_FOREACH(notifier, &blk->aio_notifiers, list) {
> +        if (notifier->attached_aio_context == attached_aio_context &&
> +            notifier->detach_aio_context == detach_aio_context &&
> +            notifier->opaque == opaque) {
> +            QLIST_REMOVE(notifier, list);

Don't you need to use QLIST_FOREACH_SAFE if you are going to modify the 
list during traversal?

Otherwise makes sense to me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
