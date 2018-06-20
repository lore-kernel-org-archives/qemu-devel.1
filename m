Received: from eggs.gnu.org ([2001:4830:134:3::10]:52876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVbDo-0002Ze-6U
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVbDm-0008CW-9W
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:24:20 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4ab9dd4e-1c79-fbe2-8e4b-6563e3775366@redhat.com>
Date: Wed, 20 Jun 2018 06:24:08 -0500
MIME-Version: 1.0
In-Reply-To: <20180609151758.17343-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/6] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> Handle new NBD meta namespace: "qemu", and corresponding queries:

s/new/a new/

> "qemu:dirty-bitmap:<export bitmap name>".
> 
> With new metadata context negotiated, BLOCK_STATUS query will reply

s/new/the new/

> with dirty-bitmap data, converted to extents. New public function

s/New/The new/

> nbd_export_bitmap selects bitmap to export. For now, only one bitmap

s/bitmap/which bitmap/

> may be exported.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/nbd.h |   6 ++
>   nbd/server.c        | 271 ++++++++++++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 259 insertions(+), 18 deletions(-)
> 
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index fcdcd54502..a653d0fba7 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -234,6 +234,10 @@ enum {
>   #define NBD_STATE_HOLE (1 << 0)
>   #define NBD_STATE_ZERO (1 << 1)
>   
> +/* Flags for extents (NBDExtent.flags) of NBD_REPLY_TYPE_BLOCK_STATUS,
> + * for qemu:dirty-bitmap:* meta contexts */

Comment tail.

> +#define NBD_STATE_DIRTY (1 << 0)
> +
>   static inline bool nbd_reply_type_is_error(int type)
>   {
>       return type & (1 << 15);
> @@ -315,6 +319,8 @@ void nbd_client_put(NBDClient *client);
>   void nbd_server_start(SocketAddress *addr, const char *tls_creds,
>                         Error **errp);
>   
> +void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
> +                       const char *bitmap_export_name, Error **errp);
>   
>   /* nbd_read
>    * Reads @size bytes from @ioc. Returns 0 on success.
> diff --git a/nbd/server.c b/nbd/server.c
> index 2d762d7289..569e068fc2 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -23,6 +23,12 @@
>   #include "nbd-internal.h"
>   
>   #define NBD_META_ID_BASE_ALLOCATION 0
> +#define NBD_META_ID_DIRTY_BITMAP 1
> +
> +/* NBD_MAX_BITMAP_EXTENTS: 1 mb of extents data. An empirical constant. If need
> + * to increase, note that NBD protocol defines 32 mb as a limit, after which the

s/need to increase/an increase is needed/

> + * reply may be considered as a denial of service attack. */
> +#define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8)
>   
>   static int system_errno_to_nbd_errno(int err)
>   {
> @@ -80,6 +86,9 @@ struct NBDExport {
>   
>       BlockBackend *eject_notifier_blk;
>       Notifier eject_notifier;
> +
> +    BdrvDirtyBitmap *export_bitmap;
> +    char *export_bitmap_context;
>   };
>   
>   static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
> @@ -92,6 +101,7 @@ typedef struct NBDExportMetaContexts {
>       bool valid; /* means that negotiation of the option finished without
>                      errors */
>       bool base_allocation; /* export base:allocation context (block status) */
> +    bool dirty_bitmap; /* export qemu:dirty-bitmap:<export bitmap name> */
>   } NBDExportMetaContexts;
>   
>   struct NBDClient {
> @@ -810,6 +820,55 @@ static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
>                                        &meta->base_allocation, errp);
>   }
>   
> +/* nbd_meta_bitmap_query
> + *
> + * Handle query to 'qemu:' namespace.
> + * @len is the amount of text remaining to be read from the current name, after
> + * the 'qemu:' portion has been stripped.
> + *
> + * Return -errno on I/O error, 0 if option was completely handled by
> + * sending a reply about inconsistent lengths, or 1 on success. */
> +static int nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
> +                               uint32_t len, Error **errp)
> +{
> +    bool dirty_bitmap = false;
> +    int dirty_bitmap_len = strlen("dirty-bitmap:");

size_t is better for strlen() values.

> +    int ret;
> +
> +    if (!meta->exp->export_bitmap) {
> +        return nbd_opt_skip(client, len, errp);
> +    }

Worth a trace?...

> +
> +    if (len == 0) {
> +        if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
> +            meta->dirty_bitmap = true;
> +        }
> +        trace_nbd_negotiate_meta_query_parse("empty");
> +        return 1;
> +    }
> +
> +    if (len < dirty_bitmap_len) {
> +        trace_nbd_negotiate_meta_query_skip("not dirty-bitmap:");
> +        return nbd_opt_skip(client, len, errp);
> +    }
> +

...especially since other returns have traced the result.

I'm strongly thinking of adding a patch to QMP to add an x-context 
parameter when creating an NBD client, in order to at least make testing 
client/server interactions easier than just code inspection.  Does not 
have to be part of this series.

> +    len -= dirty_bitmap_len;
> +    ret = nbd_meta_pattern(client, "dirty-bitmap:", &dirty_bitmap, errp);
> +    if (ret <= 0) {
> +        return ret;
> +    }
> +    if (!dirty_bitmap) {
> +        trace_nbd_negotiate_meta_query_skip("not dirty-bitmap:");
> +        return nbd_opt_skip(client, len, errp);
> +    }
> +
> +    trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
> +
> +    return nbd_meta_empty_or_pattern(
> +            client, meta->exp->export_bitmap_context +
> +            strlen("qemu:dirty_bitmap:"), len, &meta->dirty_bitmap, errp);
> +}
> +
>   /* nbd_negotiate_meta_query
>    *
>    * Parse namespace name and call corresponding function to parse body of the
> @@ -826,8 +885,10 @@ static int nbd_negotiate_meta_query(NBDClient *client,
>                                       NBDExportMetaContexts *meta, Error **errp)
>   {
>       int ret;
> -    char query[sizeof("base:") - 1];
> -    size_t baselen = strlen("base:");
> +    size_t ns_len = 5;
> +    char ns[5]; /* Both 'qemu' and 'base' namespaces have length = 5 including a
> +                   colon. If it's needed to introduce a namespace of the other
> +                   length, this should be certainly refactored. */

s/be certainly/certainly be/

...

> @@ -1793,6 +1871,9 @@ static int blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,
>   }
>   
>   /* nbd_co_send_extents
> + *
> + * NBD_REPLY_FLAG_DONE is not set, don't forget to send it.
> + *
>    * @extents should be in big-endian */
>   static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
>                                  NBDExtent *extents, unsigned nb_extents,
> @@ -1805,7 +1886,7 @@ static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
>           {.iov_base = extents, .iov_len = nb_extents * sizeof(extents[0])}
>       };
>   
> -    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_BLOCK_STATUS,
> +    set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_BLOCK_STATUS,

Worth a bool parameter to send the flag automatically on the last context?

>                    handle, sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
>       stl_be_p(&chunk.context_id, context_id);
>   
> @@ -1830,6 +1911,97 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
>       return nbd_co_send_extents(client, handle, &extent, 1, context_id, errp);
>   }
>   
> +/* Set several extents, describing region of given @length with given @flags.
> + * Do not set more than @nb_extents, return number of set extents.
> + */
> +static unsigned add_extents(NBDExtent *extents, unsigned nb_extents,
> +                            uint64_t length, uint32_t flags)
> +{
> +    unsigned i = 0;
> +    uint32_t max_extent = QEMU_ALIGN_DOWN(INT32_MAX, BDRV_SECTOR_SIZE);

This is too small of a granularity wrong when the server advertised 4k 
alignment during NBD_OPT_GO; it should probably refer to 
bs->bl.request_alignment.

> +    uint32_t max_extent_be = cpu_to_be32(max_extent);
> +    uint32_t flags_be = cpu_to_be32(flags);
> +
> +    for (i = 0; i < nb_extents && length > max_extent;
> +         i++, length -= max_extent)
> +    {
> +        extents[i].length = max_extent_be;
> +        extents[i].flags = flags_be;
> +    }
> +
> +    if (length > 0 && i < nb_extents) {
> +        extents[i].length = cpu_to_be32(length);
> +        extents[i].flags = flags_be;
> +        i++;
> +    }
> +
> +    return i;
> +}
> +
> +static unsigned bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
> +                                  uint64_t length, NBDExtent *extents,
> +                                  unsigned nb_extents, bool dont_fragment)
> +{
> +    uint64_t begin = offset, end;
> +    uint64_t overall_end = offset + length;
> +    unsigned i = 0;
> +    BdrvDirtyBitmapIter *it;
> +    bool dirty;
> +
> +    bdrv_dirty_bitmap_lock(bitmap);
> +
> +    it = bdrv_dirty_iter_new(bitmap);
> +    dirty = bdrv_get_dirty_locked(NULL, bitmap, offset);
> +
> +    while (begin < overall_end && i < nb_extents) {
> +        if (dirty) {
> +            end = bdrv_dirty_bitmap_next_zero(bitmap, begin);
> +        } else {
> +            bdrv_set_dirty_iter(it, begin);
> +            end = bdrv_dirty_iter_next(it);
> +        }
> +        if (end == -1) {
> +            end = bdrv_dirty_bitmap_size(bitmap);
> +        }
> +        if (dont_fragment && end > overall_end) {
> +            /* We MUST not exceed requested region if NBD_CMD_FLAG_REQ_ONE flag
> +             * is set */
> +            end = overall_end;
> +        }
> +
> +        i += add_extents(extents + i, nb_extents - i, end - begin,
> +                         dirty ? NBD_STATE_DIRTY : 0);
> +        begin = end;
> +        dirty = !dirty;
> +    }
> +
> +    bdrv_dirty_iter_free(it);
> +
> +    bdrv_dirty_bitmap_unlock(bitmap);
> +
> +    return i;
> +}
> +
> +static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
> +                              BdrvDirtyBitmap *bitmap, uint64_t offset,
> +                              uint64_t length, bool dont_fragment,
> +                              uint32_t context_id, Error **errp)
> +{
> +    int ret;
> +    unsigned nb_extents = dont_fragment ? 1 : NBD_MAX_BITMAP_EXTENTS;
> +    NBDExtent *extents = g_new(NBDExtent, nb_extents);
> +
> +    nb_extents = bitmap_to_extents(bitmap, offset, length, extents, nb_extents,
> +                                   dont_fragment);
> +
> +    ret = nbd_co_send_extents(client, handle, extents, nb_extents, context_id,
> +                              errp);

Worth a trace when extents are sent?

> +
> +    g_free(extents);
> +
> +    return ret;
> +}
> +
>   /* nbd_co_receive_request
>    * Collect a client request. Return 0 if request looks valid, -EIO to drop
>    * connection right away, and any other negative value to report an error to
> @@ -2043,11 +2215,33 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>                                         "discard failed", errp);
>   
>       case NBD_CMD_BLOCK_STATUS:
> -        if (client->export_meta.valid && client->export_meta.base_allocation) {
> -            return nbd_co_send_block_status(client, request->handle,
> -                                            blk_bs(exp->blk), request->from,
> -                                            request->len,
> -                                            NBD_META_ID_BASE_ALLOCATION, errp);
> +        if (client->export_meta.valid &&
> +            (client->export_meta.base_allocation ||
> +             client->export_meta.dirty_bitmap))
> +        {
> +            if (client->export_meta.base_allocation) {
> +                ret = nbd_co_send_block_status(client, request->handle,
> +                                               blk_bs(exp->blk), request->from,
> +                                               request->len,
> +                                               NBD_META_ID_BASE_ALLOCATION,
> +                                               errp);
> +                if (ret < 0) {
> +                    return ret;
> +                }
> +            }
> +
> +            if (client->export_meta.dirty_bitmap) {
> +                ret = nbd_co_send_bitmap(client, request->handle,
> +                                         client->exp->export_bitmap,
> +                                         request->from, request->len,
> +                                         request->flags & NBD_CMD_FLAG_REQ_ONE,
> +                                         NBD_META_ID_DIRTY_BITMAP, errp);
> +                if (ret < 0) {
> +                    return ret;
> +                }
> +            }
> +
> +            return nbd_co_send_structured_done(client, request->handle, errp);
>           } else {
>               return nbd_send_generic_reply(client, request->handle, -EINVAL,
>                                             "CMD_BLOCK_STATUS not negotiated",
> @@ -2199,3 +2393,44 @@ void nbd_client_new(NBDExport *exp,
>       co = qemu_coroutine_create(nbd_co_client_start, client);
>       qemu_coroutine_enter(co);
>   }
> +
> +void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
> +                       const char *bitmap_export_name, Error **errp)
> +{
> +    BdrvDirtyBitmap *bm = NULL;
> +    BlockDriverState *bs = blk_bs(exp->blk);
> +
> +    if (exp->export_bitmap) {
> +        error_setg(errp, "Export bitmap is already set");
> +        return;
> +    }
> +
> +    while (true) {
> +        bm = bdrv_find_dirty_bitmap(bs, bitmap);
> +        if (bm != NULL || bs->backing == NULL) {
> +            break;
> +        }
> +
> +        bs = bs->backing->bs;
> +    }

Is searching for the dirty bitmap in the backing chain always the wisest 
thing to do?  I guess it works, but it seems a bit odd on first glance.

> +
> +    if (bm == NULL) {
> +        error_setg(errp, "Bitmap '%s' is not found", bitmap);
> +        return;
> +    }
> +
> +    if (bdrv_dirty_bitmap_enabled(bm)) {
> +        error_setg(errp, "Bitmap '%s' is enabled", bitmap);
> +        return;
> +    }
> +
> +    if (bdrv_dirty_bitmap_qmp_locked(bm)) {
> +        error_setg(errp, "Bitmap '%s' is locked", bitmap);
> +        return;
> +    }
> +
> +    bdrv_dirty_bitmap_set_qmp_locked(bm, true);
> +    exp->export_bitmap = bm;
> +    exp->export_bitmap_context =
> +            g_strdup_printf("qemu:dirty-bitmap:%s", bitmap_export_name);
> +}
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
