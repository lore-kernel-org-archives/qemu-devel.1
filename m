Received: from eggs.gnu.org ([2001:4830:134:3::10]:60620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdnTY-0004gz-A9
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 19:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdnTX-0003dl-Am
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 19:29:40 -0500
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
	<1487091579-67092-25-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <480cc4f8-c952-49b3-7e20-2f91593c9bf9@redhat.com>
Date: Tue, 14 Feb 2017 19:29:30 -0500
MIME-Version: 1.0
In-Reply-To: <1487091579-67092-25-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 24/25] qmp: block-dirty-bitmap-remove:
 remove persistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 02/14/2017 11:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> Remove persistent bitmap from the storage on block-dirty-bitmap-remove.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  blockdev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/blockdev.c b/blockdev.c
> index c41b791..a365cdf 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2767,6 +2767,7 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
>      AioContext *aio_context;
>      BlockDriverState *bs;
>      BdrvDirtyBitmap *bitmap;
> +    Error *local_err = NULL;
>  
>      bitmap = block_dirty_bitmap_lookup(node, name, &bs, &aio_context, errp);
>      if (!bitmap || !bs) {
> @@ -2779,6 +2780,15 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
>                     name);
>          goto out;
>      }
> +
> +    if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
> +        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
> +        if (local_err != NULL) {
> +            error_propagate(errp, local_err);
> +            goto out;
> +        }
> +    }
> +
>      bdrv_dirty_bitmap_make_anon(bitmap);
>      bdrv_release_dirty_bitmap(bs, bitmap);
>  
> 

Reviewed-by: John Snow <jsnow@redhat.com>
