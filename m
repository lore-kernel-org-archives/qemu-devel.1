Received: from eggs.gnu.org ([2001:4830:134:3::10]:48039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evm0R-0000Ru-DT
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evm0P-0007gh-J5
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:38:27 -0400
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
	<20180312152126.286890-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3c7cb59-87bb-77b2-81a1-03cec05c13c3@redhat.com>
Date: Tue, 13 Mar 2018 10:38:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180312152126.286890-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/8] nbd: BLOCK_STATUS for standard
 get_block_status function: client part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 03/12/2018 10:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> Minimal realization: only one extent in server answer is supported.
> Flag NBD_CMD_FLAG_REQ_ONE is used to force this behavior.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> v2: - drop iotests changes, as server is fixed in 03
>      - rebase to byte-based block status
>      - use payload_advance32
>      - check extent->length for zero and for alignment (not sure about
>        zero, but, we do not send block status with zero-length, so
>        reply should not be zero-length too)

The NBD spec needs to be clarified that a zero-length request is bogus; 
once that is done, then the server can be required to make progress (if 
it succeeds, at least one non-zero extent was reported per namespace), 
as that is the most useful behavior (if a server replies with 0 extents 
or 0-length extents, the client could go into an inf-loop re-requesting 
the same status).

>      - handle max_block in nbd_client_co_block_status
>      - handle zero-length request in nbd_client_co_block_status
>      - do not use magic numbers in nbd_negotiate_simple_meta_context
> 
>      ? Hm, don't remember, what we decided about DATA/HOLE flags mapping..

At this point, it's still up in the air for me to fix the complaints 
Kevin had, but those are bug fixes on top of this series (and thus okay 
during soft freeze), so your initial implementation is adequate for a 
first commit.

> +++ b/block/nbd-client.c
> @@ -228,6 +228,47 @@ static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chunk,
>       return 0;
>   }
>   
> +/* nbd_parse_blockstatus_payload
> + * support only one extent in reply and only for
> + * base:allocation context
> + */
> +static int nbd_parse_blockstatus_payload(NBDClientSession *client,
> +                                         NBDStructuredReplyChunk *chunk,
> +                                         uint8_t *payload, uint64_t orig_length,
> +                                         NBDExtent *extent, Error **errp)
> +{
> +    uint32_t context_id;
> +
> +    if (chunk->length != sizeof(context_id) + sizeof(extent)) {
> +        error_setg(errp, "Protocol error: invalid payload for "
> +                         "NBD_REPLY_TYPE_BLOCK_STATUS");
> +        return -EINVAL;
> +    }
> +
> +    context_id = payload_advance32(&payload);
> +    if (client->info.meta_base_allocation_id != context_id) {
> +        error_setg(errp, "Protocol error: unexpected context id: %d for "

s/id:/id/

> +                         "NBD_REPLY_TYPE_BLOCK_STATUS, when negotiated context "
> +                         "id is %d", context_id,
> +                         client->info.meta_base_allocation_id);
> +        return -EINVAL;
> +    }
> +
> +    extent->length = payload_advance32(&payload);
> +    extent->flags = payload_advance32(&payload);
> +
> +    if (extent->length == 0 ||
> +        extent->length % client->info.min_block != 0 ||
> +        extent->length > orig_length)
> +    {
> +        /* TODO: clarify in NBD spec the second requirement about min_block */

Yeah, the spec wording can be tightened, but the intent is obvious: the 
server better not be reporting status on anything smaller than what you 
can address with read or write.  But I think we can address that on the 
NBD list without a TODO here.

However, you do have a bug: the server doesn't have to report min_block, 
so the value can still be zero (see nbd_refresh_limits, for example) - 
and %0 is a bad idea.  I'll do the obvious cleanup of checking for a 
non-zero min_block.

> +        error_setg(errp, "Protocol error: server sent chunk of invalid length");

Maybe insert 'status' in there?

>   
> +static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
> +                                            uint64_t handle, uint64_t length,
> +                                            NBDExtent *extent, Error **errp)
> +{
> +    NBDReplyChunkIter iter;
> +    NBDReply reply;
> +    void *payload = NULL;
> +    Error *local_err = NULL;
> +    bool received = false;
> +
> +    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, s->info.structured_reply,
> +                            NULL, &reply, &payload)
> +    {
> +        int ret;
> +        NBDStructuredReplyChunk *chunk = &reply.structured;
> +
> +        assert(nbd_reply_is_structured(&reply));
> +
> +        switch (chunk->type) {
> +        case NBD_REPLY_TYPE_BLOCK_STATUS:
> +            if (received) {
> +                s->quit = true;
> +                error_setg(&local_err, "Several BLOCK_STATUS chunks in reply");

Not necessarily an error later on when we request more than one 
namespace, but fine for the initial implementation where we really do 
expect exactly one status.

> +                nbd_iter_error(&iter, true, -EINVAL, &local_err);
> +            }
> +            received = true;
> +
> +            ret = nbd_parse_blockstatus_payload(s, &reply.structured,
> +                                                payload, length, extent,
> +                                                &local_err);
> +            if (ret < 0) {
> +                s->quit = true;
> +                nbd_iter_error(&iter, true, ret, &local_err);
> +            }
> +            break;
> +        default:
> +            if (!nbd_reply_type_is_error(chunk->type)) {
> +                /* not allowed reply type */

Comment doesn't add much, compared to the error message right below.

> +                s->quit = true;
> +                error_setg(&local_err,
> +                           "Unexpected reply type: %d (%s) "
> +                           "for CMD_BLOCK_STATUS",
> +                           chunk->type, nbd_reply_type_lookup(chunk->type));
> +                nbd_iter_error(&iter, true, -EINVAL, &local_err);
> +            }
> +        }
> +
> +        g_free(payload);
> +        payload = NULL;
> +    }
> +
> +    error_propagate(errp, iter.err);
> +    return iter.ret;
> +}
> +
>   static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
>                             QEMUIOVector *write_qiov)
>   {
> @@ -784,6 +880,53 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
>       return nbd_co_request(bs, &request, NULL);
>   }
>   
> +int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
> +                                            bool want_zero,
> +                                            int64_t offset, int64_t bytes,
> +                                            int64_t *pnum, int64_t *map,
> +                                            BlockDriverState **file)
> +{
> +    int64_t ret;
> +    NBDExtent extent;
> +    NBDClientSession *client = nbd_get_client_session(bs);
> +    Error *local_err = NULL;
> +
> +    NBDRequest request = {
> +        .type = NBD_CMD_BLOCK_STATUS,
> +        .from = offset,
> +        .len = MIN(bytes, MIN_NON_ZERO(INT_MAX, client->info.max_block)),

Hmm.  I see why you are capping this to 32 bits; io.c does not cap the 
maximum other than to the file size, which can still be larger than 32 
bits.  If min_block is greater than 1, then .len better be aligned 
(INT_MAX isn't).  If min_block is non-zero, max_block must already be 
set to an integer value that is aligned, and is therefore smaller than 
INT_MAX, so we're good there; but if min_block is zero, then we are 
acting as though the server has 512-byte alignment (even if the server 
supports byte alignment after all), and max_block is also zero, and 
we've just requested status for an unaligned amount.

So we have to tweak it slightly; I'm thinking:

.len = MIN(bytes, MIN_NON_ZERO(QEMU_ALIGN_DOWN(INT_MAX, 
bs->bl.request_alignment), client->info.max_block))

> +        .flags = NBD_CMD_FLAG_REQ_ONE,
> +    };
> +
> +    if (!bytes) {
> +        *pnum = 0;
> +        return 0;
> +    }

Dead code.  io.c guarantees bytes is non-zero on entry.

> +
> +    if (!client->info.base_allocation) {
> +        *pnum = bytes;
> +        return BDRV_BLOCK_DATA;
> +    }

Doesn't set *map or *file - but that's part of what I have to clean up 
in response to Kevin anyways as a post-series bug fix, so we're okay there.

> +
> +    ret = nbd_co_send_request(bs, &request, NULL);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = nbd_co_receive_blockstatus_reply(client, request.handle, bytes,
> +                                           &extent, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    *pnum = extent.length;
> +    return (extent.flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_DATA) |
> +           (extent.flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0);
> +}

More of the post-series cleanups (I'm not quite sure if !NBD_STATE_HOLE 
and BDRV_BLOCK_DATA are synonyms, but it's okay for your first 
approximation).

> +

> +++ b/nbd/client.c
> @@ -595,6 +595,111 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
>       return QIO_CHANNEL(tioc);
>   }
>   
> +/* nbd_negotiate_simple_meta_context:
> + * Set one meta context. Simple means that reply must contain zero (not
> + * negotiated) or one (negotiated) contexts. More contexts would be considered
> + * as a protocol error. It's also implied, that meta-data query equals queried

s/implied,/implied/

> + * context name, so, if server replies with something different then @context,
> + * it considered as error too.
> + * return 1 for successful negotiation, context_id is set
> + *        0 if operation is unsupported,
> + *        -errno with errp set for any other error
> + */
> +static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
> +                                             const char *export,
> +                                             const char *context,
> +                                             uint32_t *context_id,
> +                                             Error **errp)
> +{
> +    int ret;
> +    NBDOptionReply reply;
> +    uint32_t received_id;
> +    bool received;
> +    uint32_t export_len = strlen(export);
> +    uint32_t context_len = strlen(context);
> +    uint32_t data_len = sizeof(export_len) + export_len +
> +                        sizeof(uint32_t) + /* number of queries */
> +                        sizeof(context_len) + context_len;
> +    char *data = g_malloc(data_len);
> +    char *p = data;
> +
> +    stl_be_p(p, export_len);
> +    memcpy(p += sizeof(export_len), export, export_len);
> +    stl_be_p(p += export_len, 1);
> +    stl_be_p(p += sizeof(uint32_t), context_len);
> +    memcpy(p += sizeof(context_len), context, context_len);

Looks correct.

...
> +    if (reply.type == NBD_REP_META_CONTEXT) {
> +        char *name;
> +        size_t len;
> +
> +        if (nbd_read(ioc, &received_id, sizeof(received_id), errp) < 0) {
> +            return -EIO;
> +        }
> +        be32_to_cpus(&received_id);
> +
> +        len = reply.length - sizeof(received_id);
> +        name = g_malloc(len + 1);
> +        if (nbd_read(ioc, name, len, errp) < 0) {
> +            g_free(name);
> +            return -EIO;
> +        }
> +        name[len] = '\0';
> +        if (strcmp(context, name)) {
> +            error_setg(errp, "Failed to negotiate meta context '%s', server "
> +                       "answered with different context '%s'", context,
> +                       name);
> +            g_free(name);
> +            return -1;

Ouch - we're returning -EIO and -1 from the same function.  Mixing errno 
and -1 is never a good idea; but the caller doesn't care about errno 
values, so -1 everywhere is just fine.

> @@ -606,10 +711,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>       int rc;
>       bool zeroes = true;
>       bool structured_reply = info->structured_reply;
> +    bool base_allocation = info->base_allocation;
>   
>       trace_nbd_receive_negotiate(tlscreds, hostname ? hostname : "<null>");
>   
>       info->structured_reply = false;
> +    info->base_allocation = false;
>       rc = -EINVAL;
>   
>       if (outioc) {
> @@ -700,6 +807,16 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>                   info->structured_reply = result == 1;
>               }
>   
> +            if (info->structured_reply && base_allocation) {
> +                result = nbd_negotiate_simple_meta_context(
> +                        ioc, name, "base:allocation",
> +                        &info->meta_base_allocation_id, errp);
> +                if (result < 0) {
> +                    goto fail;
> +                }
> +                info->base_allocation = result == 1;
> +            }

I've made fixes, but overall it's good enough for inclusion.
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
