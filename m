Received: from eggs.gnu.org ([2001:4830:134:3::10]:57545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fcthk-00072a-PZ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fcthj-0004tR-Lo
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:33:24 -0400
References: <20180704112302.471456-1-vsementsov@virtuozzo.com>
	<20180704112302.471456-3-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <894031cf-d826-1d20-21de-a8f7af4be5fc@virtuozzo.com>
Date: Tue, 10 Jul 2018 17:33:09 +0300
MIME-Version: 1.0
In-Reply-To: <20180704112302.471456-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/2] nbd/server: send more than one extent
 of base:allocation context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, den@openvz.org

04.07.2018 14:23, Vladimir Sementsov-Ogievskiy wrote:
> This is necessary for efficient block-status export, for clients which
> support it.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 77 +++++++++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 58 insertions(+), 19 deletions(-)
>
> diff --git a/nbd/server.c b/nbd/server.c
> index ea5fe0eb33..a6d013aec4 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1844,11 +1844,22 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
>       return ret;
>   }
>   
> -static int blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,
> -                                    uint64_t bytes, NBDExtent *extent)
> +/*
> + * Populate @extents from block status. Store in @bytes the byte length encoded
> + * (which may be smaller but (unlike bitmap_to_extents) _never_ larger than the
> + * original), and store in @nb_extents the number of extents used.
> + *
> + * Returns zero on success and -errno on bdrv_block_status_above failure.
> + */
> +static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
> +                                  uint64_t *bytes, NBDExtent *extents,
> +                                  unsigned int *nb_extents)
>   {
> -    uint64_t remaining_bytes = bytes;
> +    uint64_t remaining_bytes = *bytes;
> +    NBDExtent *extent = extents, *extents_end = extents + *nb_extents;
> +    bool first_extent = true;
>   
> +    assert(*nb_extents);
>       while (remaining_bytes) {
>           uint32_t flags;
>           int64_t num;
> @@ -1860,21 +1871,40 @@ static int blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,

after bdrv_block_status_above, is there a guarantee that num > 0? Should 
we add an assertion?

>   
>           flags = (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
>                   (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);
> +        offset += num;
> +        remaining_bytes -= num;
>   
> -        if (remaining_bytes == bytes) {
> +        if (first_extent) {
>               extent->flags = flags;
> +            extent->length = num;
> +            first_extent = false;
> +            continue;
>           }
>   
> -        if (flags != extent->flags) {
> -            break;
> +        if (flags == extent->flags) {
> +            /* extend current extent */
> +            extent->length += num;
> +        } else {
> +            if (extent + 1 == extents_end) {
> +                break;
> +            }
> +
> +            /* start new extent */
> +            extent++;
> +            extent->flags = flags;
> +            extent->length = num;
>           }
> +    }
>   
> -        offset += num;
> -        remaining_bytes -= num;
> +    extents_end = extent + 1;
> +
> +    for (extent = extents; extent < extents_end; extent++) {
> +        cpu_to_be32s(&extent->flags);
> +        cpu_to_be32s(&extent->length);
>       }
>   
> -    cpu_to_be32s(&extent->flags);
> -    extent->length = cpu_to_be32(bytes - remaining_bytes);
> +    *bytes -= remaining_bytes;
> +    *nb_extents = extents_end - extents;
>   
>       return 0;
>   }
> @@ -1910,21 +1940,29 @@ static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
>   /* Get block status from the exported device and send it to the client */
>   static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
>                                       BlockDriverState *bs, uint64_t offset,
> -                                    uint32_t length, bool last,
> -                                    uint32_t context_id, Error **errp)
> +                                    uint32_t length, bool dont_fragment,
> +                                    bool last, uint32_t context_id,
> +                                    Error **errp)
>   {
>       int ret;
> -    NBDExtent extent;
> +    unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BITMAP_EXTENTS;
> +    NBDExtent *extents = g_new(NBDExtent, nb_extents);
> +    uint64_t final_length = length;
>   
> -    ret = blockstatus_to_extent_be(bs, offset, length, &extent);
> +    ret = blockstatus_to_extents(bs, offset, &final_length, extents,
> +                                 &nb_extents);
>       if (ret < 0) {
> +        g_free(extents);
>           return nbd_co_send_structured_error(
>                   client, handle, -ret, "can't get block status", errp);
>       }
>   
> -    return nbd_co_send_extents(client, handle, &extent, 1,
> -                               be32_to_cpu(extent.length), last,
> -                               context_id, errp);
> +    ret = nbd_co_send_extents(client, handle, extents, nb_extents,
> +                              final_length, last, context_id, errp);
> +
> +    g_free(extents);
> +
> +    return ret;
>   }
>   
>   /*
> @@ -2228,10 +2266,11 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>               (client->export_meta.base_allocation ||
>                client->export_meta.bitmap))
>           {
> +            bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
>               if (client->export_meta.base_allocation) {
>                   ret = nbd_co_send_block_status(client, request->handle,
>                                                  blk_bs(exp->blk), request->from,
> -                                               request->len,
> +                                               request->len, dont_fragment,
>                                                  !client->export_meta.bitmap,
>                                                  NBD_META_ID_BASE_ALLOCATION,
>                                                  errp);
> @@ -2244,7 +2283,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>                   ret = nbd_co_send_bitmap(client, request->handle,
>                                            client->exp->export_bitmap,
>                                            request->from, request->len,
> -                                         request->flags & NBD_CMD_FLAG_REQ_ONE,
> +                                         dont_fragment,
>                                            true, NBD_META_ID_DIRTY_BITMAP, errp);
>                   if (ret < 0) {
>                       return ret;


-- 
Best regards,
Vladimir
