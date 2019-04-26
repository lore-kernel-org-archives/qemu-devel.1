Received: from eggs.gnu.org ([209.51.188.92]:33979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Qe-0004JS-8L
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Qd-0005zF-3H
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:02:16 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190331111747.14685-1-berto@igalia.com>
References: <20190331111747.14685-1-berto@igalia.com>
Date: Fri, 26 Apr 2019 16:02:08 +0200
Message-ID: <w51v9z0g90f.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.1] block: Use bdrv_unref_child() for
 all children in bdrv_close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

ping

On Sun 31 Mar 2019 01:17:47 PM CEST, Alberto Garcia wrote:
> bdrv_unref_child() does the following things:
>
>   - Updates the child->bs->inherits_from pointer.
>   - Calls bdrv_detach_child() to remove the BdrvChild from bs->children.
>   - Calls bdrv_unref() to unref the child BlockDriverState.
>
> When bdrv_unref_child() was introduced in commit 33a604075c it was not
> used in bdrv_close() because the drivers that had additional children
> (like quorum or blkverify) had already called bdrv_unref() on their
> children during their own close functions.
>
> This was changed later (in 0bd6e91a7e for quorum, in 3e586be0b2 for
> blkverify) so there's no reason not to use bdrv_unref_child() in
> bdrv_close() anymore.
>
> After this there's also no need to remove bs->backing and bs->file
> separately from the rest of the children, so bdrv_close() can be
> simplified.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/block.c b/block.c
> index 0a93ee9ac8..3b7c12d68e 100644
> --- a/block.c
> +++ b/block.c
> @@ -3842,22 +3842,12 @@ static void bdrv_close(BlockDriverState *bs)
>          bs->drv = NULL;
>      }
>  
> -    bdrv_set_backing_hd(bs, NULL, &error_abort);
> -
> -    if (bs->file != NULL) {
> -        bdrv_unref_child(bs, bs->file);
> -        bs->file = NULL;
> -    }
> -
>      QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
> -        /* TODO Remove bdrv_unref() from drivers' close function and use
> -         * bdrv_unref_child() here */
> -        if (child->bs->inherits_from == bs) {
> -            child->bs->inherits_from = NULL;
> -        }
> -        bdrv_detach_child(child);
> +        bdrv_unref_child(bs, child);
>      }
>  
> +    bs->backing = NULL;
> +    bs->file = NULL;
>      g_free(bs->opaque);
>      bs->opaque = NULL;
>      atomic_set(&bs->copy_on_read, 0);
> -- 
> 2.11.0
