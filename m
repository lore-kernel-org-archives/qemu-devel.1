Received: from eggs.gnu.org ([2001:4830:134:3::10]:48179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyh44-0000t3-Av
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyh43-0006ac-Cq
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:58:16 -0400
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
	<20180321121940.39426-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e21af76d-977d-cadf-0a27-14a2d2aa228a@redhat.com>
Date: Wed, 21 Mar 2018 11:57:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180321121940.39426-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 03/21/2018 07:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Rather sparse on the details in the commit message; I had to read the 
patch to even learn what the new namespace is.

> ---
>   include/block/nbd.h |   2 +
>   nbd/server.c        | 207 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 203 insertions(+), 6 deletions(-)
> 

> +++ b/nbd/server.c
> @@ -23,6 +23,12 @@
>   #include "nbd-internal.h"
>   
>   #define NBD_META_ID_BASE_ALLOCATION 0
> +#define NBD_META_ID_DIRTY_BITMAP 1
> +
> +#define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8) /* 1 mb of extents data */
> +#define MAX_EXTENT_LENGTH QEMU_ALIGN_DOWN(INT32_MAX, 512)

Worth comments on these two limits?

> +
> +#define NBD_STATE_DIRTY 1

Does this belong better in nbd.h, alongside NBD_STATE_HOLE?  (And 
defining it as (1 << 0) might be nicer, too).

>   
>   static int system_errno_to_nbd_errno(int err)
>   {
> @@ -80,6 +86,9 @@ struct NBDExport {
>   
>       BlockBackend *eject_notifier_blk;
>       Notifier eject_notifier;
> +
> +    BdrvDirtyBitmap *export_bitmap;
> +    char *export_bitmap_name;
>   };
>   
>   static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
> @@ -92,6 +101,7 @@ typedef struct NBDExportMetaContexts {
>       bool valid; /* means that negotiation of the option finished without
>                      errors */
>       bool base_allocation; /* export base:allocation context (block status) */
> +    bool dirty_bitmap; /* export qemu-dirty-bitmap:<export_bitmap_name> */

That's a LONG namespace name, and it does not lend itself well to other 
qemu extensions; so future qemu BLOCK_STATUS additions would require 
consuming yet another namespace and additional upstream NBD 
registration.  Wouldn't it be better to have the namespace be 'qemu:' 
(which we register with upstream NBD just once), where we are then free 
to document leafnames to look like 'dirty-bitmap:name' or 'foo:bar'?

>   } NBDExportMetaContexts;
>   
>   struct NBDClient {
> @@ -786,12 +796,32 @@ static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
>                                    &meta->base_allocation, errp);
>   }
>   
> +/* nbd_meta_bitmap_query
> + *
> + * Handle query to 'qemu-dirty-bitmap' namespace.
> + * 'len' is the amount of text remaining to be read from the current name, after
> + * the 'qemu-dirty-bitmap:' portion has been stripped.
> + *
> + * Return -errno on I/O error, 0 if option was completely handled by
> + * sending a reply about inconsistent lengths, or 1 on success. */
> +static int nbd_meta_bitmap_query(NBDClient *client, NBDExportMetaContexts *meta,
> +                                 uint32_t len, Error **errp)
> +{
> +    if (!client->exp->export_bitmap) {
> +        return nbd_opt_skip(client, len, errp);
> +    }
> +
> +    return nbd_meta_single_query(client, client->exp->export_bitmap_name, len,
> +                                 &meta->dirty_bitmap, errp);

So if I'm reading this right, a client can do _LIST_ 
'qemu-dirty-bitmap:' (or 'qemu:dirty-bitmap:' if we choose a shorter 
initial namespace) and get back the exported bitmap name; or the user 
already knows the bitmap name and both _LIST_ and _SET_ 
'qemu-dirty-bitmap:name' return the one supported bitmap for that NBD 
server.


>   /* nbd_co_send_extents
> + *
> + * NBD_REPLY_FLAG_DONE is not set, don't forget to send it.
> + *
>    * @extents should be in big-endian */
>   static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
>                                  NBDExtent *extents, unsigned nb_extents,

Worth a bool flag that the caller can inform this function whether to 
include FLAG_DONE?
> +
> +static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
> +                              BdrvDirtyBitmap *bitmap, uint64_t offset,
> +                              uint64_t length, uint32_t context_id,
> +                              Error **errp)
> +{
> +    int ret;
> +    unsigned nb_extents;
> +    NBDExtent *extents = g_new(NBDExtent, NBD_MAX_BITMAP_EXTENTS);

Is this correct even when the client used NBD_CMD_FLAG_REQ_ONE?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
