Received: from eggs.gnu.org ([2001:4830:134:3::10]:49877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb6P2-00071B-V6
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb6P2-0002um-0z
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:42:41 -0400
References: <20180704112302.471456-1-vsementsov@virtuozzo.com>
	<20180704112302.471456-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2fd38919-a733-692f-488d-3071eeea4bd1@redhat.com>
Date: Thu, 5 Jul 2018 10:42:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180704112302.471456-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd/server: fix
 nbd_co_send_block_status
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
> Call nbd_co_send_extents() with correct length parameter
> (extent.length may be smaller than original length).

Only matters for tracing purposes, but indeed worth an accurate trace.

> 
> Also, switch length parameter type to uint32_t, to correspond with
> request->len and similar nbd_co_send_bitmap().

No semantic impact.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index e52b76bd1a..ea5fe0eb33 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1910,7 +1910,7 @@ static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
>   /* Get block status from the exported device and send it to the client */
>   static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
>                                       BlockDriverState *bs, uint64_t offset,
> -                                    uint64_t length, bool last,
> +                                    uint32_t length, bool last,
>                                       uint32_t context_id, Error **errp)
>   {
>       int ret;
> @@ -1922,7 +1922,8 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
>                   client, handle, -ret, "can't get block status", errp);
>       }
>   
> -    return nbd_co_send_extents(client, handle, &extent, 1, length, last,
> +    return nbd_co_send_extents(client, handle, &extent, 1,
> +                               be32_to_cpu(extent.length), last,

be32_to_cpu() is necessary to undo the fact that extent is already 
encoded for transmission over the wire.  Alternatively, 
blockstatus_to_extent_be() could be modified to return negative on 
error, or the total length encoded on success, or set the final length 
via a pointer parameter.  But the next patch will probably deal with 
that more directly.

This one is fine for 3.0,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
