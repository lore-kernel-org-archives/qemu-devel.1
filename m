Received: from eggs.gnu.org ([209.51.188.92]:46042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpyd-0005pT-Eg
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpyc-00050Y-Hb
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:57:23 -0500
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-12-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3efe273b-16af-4927-b684-57cf71275923@redhat.com>
Date: Mon, 18 Feb 2019 14:57:13 -0600
MIME-Version: 1.0
In-Reply-To: <20190218161822.3573-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/12] block: Use normal drain for
 bdrv_set_aio_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On 2/18/19 10:18 AM, Kevin Wolf wrote:
> Now that bdrv_set_aio_context() works inside drained sections, it can
> also use the real drain function instead of open coding something
> similar.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/block.c b/block.c
> index aefb5701f5..7024172db8 100644
> --- a/block.c
> +++ b/block.c
> @@ -5268,18 +5268,15 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
>      bs->walking_aio_notifiers = false;
>  }
>  
> +/* The caller must own the AioContext lock for the old AioContext of bs, but it
> + * must not own the AioContext lock for new_context. */

Is this comment still accurate, given

>  void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
>  {
> -    AioContext *ctx = bdrv_get_aio_context(bs);
> -
> -    if (ctx == new_context) {
> +    if (bdrv_get_aio_context(bs) == new_context) {
>          return;
>      }

the short-circuiting when the old context is the new context?

>  
> -    aio_disable_external(ctx);
> -    bdrv_parent_drained_begin(bs, NULL, false);
> -    bdrv_drain(bs); /* ensure there are no in-flight requests */
> -
> +    bdrv_drained_begin(bs);
>      bdrv_detach_aio_context(bs);
>  
>      /* This function executes in the old AioContext so acquire the new one in
> @@ -5287,8 +5284,7 @@ void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
>       */
>      aio_context_acquire(new_context);
>      bdrv_attach_aio_context(bs, new_context);
> -    bdrv_parent_drained_end(bs, NULL, false);
> -    aio_enable_external(ctx);
> +    bdrv_drained_end(bs);
>      aio_context_release(new_context);
>  }
>  
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
