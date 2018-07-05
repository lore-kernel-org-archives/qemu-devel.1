Received: from eggs.gnu.org ([2001:4830:134:3::10]:53551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb6fV-0005Oq-0v
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb6fR-0005XT-Va
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:59:41 -0400
References: <20180704112302.471456-1-vsementsov@virtuozzo.com>
	<20180704112302.471456-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <68016e9d-eefe-adb0-2dee-3935ee0aa549@redhat.com>
Date: Thu, 5 Jul 2018 10:59:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180704112302.471456-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

On 07/04/2018 06:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> This is necessary for efficient block-status export, for clients which
> support it.

qemu as client doesn't currently process additional information when 
querying block status.  Should it?

Are there other clients which DO make use of the additional information?

This is a feature, so it is indeed 3.1 material.

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

I don't think the comparison to bitmap_to_extents in a nested 
parenthetical buys us anything; the shorter:

(which may be smaller than the original)

would do just fine for the function contract.

> + *
> + * Returns zero on success and -errno on bdrv_block_status_above failure.

Is it worth returning a positive value for one less pointer parameter 
used for output?

> + */
> +static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
> +                                  uint64_t *bytes, NBDExtent *extents,
> +                                  unsigned int *nb_extents)
>   {
> -    uint64_t remaining_bytes = bytes;
> +    uint64_t remaining_bytes = *bytes;
> +    NBDExtent *extent = extents, *extents_end = extents + *nb_extents;

So both bytes and nb_extents are in-out.


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

At any rate, this conversion looks sane.

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

Blank lines between declarations and statements can aid in legibility; I 
can add when queuing.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
