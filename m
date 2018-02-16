Received: from eggs.gnu.org ([2001:4830:134:3::10]:55062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emmo3-0001DJ-Hj
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emmo1-0003db-5Q
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:40:31 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-7-git-send-email-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b570a199-9139-5652-5ad8-407820680620@redhat.com>
Date: Fri, 16 Feb 2018 14:40:04 -0600
MIME-Version: 1.0
In-Reply-To: <1518702707-7077-7-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/9] nbd: BLOCK_STATUS for standard
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

On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> Minimal realization: only one extent in server answer is supported.
> Flag NBD_CMD_FLAG_REQ_ONE is used to force this behavior.
> 
> Tests 140, 147 and 205 are fixed due to now server failed on searching
> export in context of NBD_OPT_SET_META_CONTEXT option negotiation.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +++ b/block/nbd-client.c
> @@ -228,6 +228,45 @@ static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chunk,
>       return 0;
>   }
>   
> +/* nbd_parse_blockstatus_payload
> + * support only one extent in reply and only for
> + * base:allocation context

Reasonable, since the server should not be sending us contexts we did 
not ask for during negotiation.

> + */
> +static int nbd_parse_blockstatus_payload(NBDClientSession *client,
> +                                         NBDStructuredReplyChunk *chunk,
> +                                         uint8_t *payload, uint64_t orig_length,
> +                                         NBDExtent *extent, Error **errp)
> +{
> +    uint32_t context_id;
> +
> +    if (chunk->length != sizeof(context_id) + sizeof(extent)) {

Okay as long as we use REQ_ONE to ensure exactly one extent per chunk.

> +        error_setg(errp, "Protocol error: invalid payload for "
> +                         "NBD_REPLY_TYPE_BLOCK_STATUS");
> +        return -EINVAL;
> +    }
> +
> +    context_id = payload_advance32(&payload);
> +    if (client->info.meta_base_allocation_id != context_id) {
> +        error_setg(errp, "Protocol error: unexpected context id: %d for "
> +                         "NBD_REPLY_TYPE_BLOCK_STATUS, when negotiated context "
> +                         "id is %d", context_id,
> +                         client->info.meta_base_allocation_id);
> +        return -EINVAL;
> +    }
> +
> +    memcpy(extent, payload, sizeof(*extent));
> +    be32_to_cpus(&extent->length);
> +    be32_to_cpus(&extent->flags);

Instead of doing a memcpy() and then in-place bit-swizzling, you could 
do the swapping as part of assignment, for one less function call (and 
make the code a bit easier to extend, if we later drop our REQ_ONE 
limitation on only having one extent, because you'll advance payload as 
needed):

extent->length = payload_advance32(&payload);
extent->flags = payload_advance32(&payload);

We should probably validate that the length field is a multiple of 
min_block (if a server tells us that all operations must be 512-byte 
aligned, then reports an extent that is smaller than 512 bytes, we have 
no way to ask for the status of the second half of the sector). 
Probably also something that needs to be explicitly stated in the NBD 
spec. [1]

> +
> +    if (extent->length > orig_length) {
> +        error_setg(errp, "Protocol error: server sent chunk exceeding requested"
> +                         " region");
> +        return -EINVAL;

That matches the current spec wording, but I'm not sure I agree with it 
- what's wrong with a server providing a final extent that extends 
beyond the request, if the information was already available for free 
(the classic example: if the server never replies with HOLE or ZERO, 
then the entire file has the same status, so all requests could 
trivially be replied to by taking the starting offset to the end of the 
file as the returned length, rather than just clamping at the requested 
length).

> +    }
> +
> +    return 0;
> +}
> +
>   /* nbd_parse_error_payload
>    * on success @errp contains message describing nbd error reply
>    */
> @@ -642,6 +681,61 @@ static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
>       return iter.ret;
>   }
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

Depending on the outcome of the discussion on the NBD list, here's where 
you could make a client easily listen to both your initial server (that 
sent 5) and a server compliant to the current spec wording (where this 
constant is 3); although it remains to be seen if that's the only 
difference between your initial implementation and the NBD spec wording 
that gets promoted to stable.

> +            if (received) {
> +                s->quit = true;
> +                error_setg(&local_err, "Several BLOCK_STATUS chunks in reply");
> +                nbd_iter_error(&iter, true, -EINVAL, &local_err);
> +            }

We may change this in the future to ask for more than one context at 
once; but for now, this matches that we negotiated for only one context, 
so it is fine to hang up on a server that disobeyed negotiation and sent 
us too much stuff.

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
> @@ -784,6 +878,50 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
>       return nbd_co_request(bs, &request, NULL);
>   }
>   
> +int64_t coroutine_fn nbd_client_co_get_block_status(BlockDriverState *bs,
> +                                                    int64_t sector_num,
> +                                                    int nb_sectors, int *pnum,
> +                                                    BlockDriverState **file)

Needs rebasing on top of Kevin's block branch to use the byte-based 
interface.  I also need to finish up my promised followups on that 
series, as NBD (and other protocol drivers) should have consistent 
behavior on what it means to report OFFSET_VALID (or whether that should 
be limited to just format/filter drivers).

> +{
> +    int64_t ret;
> +    NBDExtent extent;
> +    NBDClientSession *client = nbd_get_client_session(bs);
> +    Error *local_err = NULL;
> +
> +    uint64_t offset = sector_num << BDRV_SECTOR_BITS;
> +    uint32_t bytes = nb_sectors << BDRV_SECTOR_BITS;
> +
> +    NBDRequest request = {
> +        .type = NBD_CMD_BLOCK_STATUS,
> +        .from = offset,
> +        .len = bytes,
> +        .flags = NBD_CMD_FLAG_REQ_ONE,
> +    };
> +
> +    if (!client->info.base_allocation) {
> +        *pnum = nb_sectors;
> +        return BDRV_BLOCK_DATA;
> +    }

Hmm - you are not setting *file nor returning OFFSET_VALID - which goes 
along with the way Kevin was asking me to clean up the other protocol 
drivers ;)

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
> +    *pnum = extent.length >> BDRV_SECTOR_BITS;

[1] And now my above worry about a sub-sector reply from the server 
(when the server supports min_block of 1 instead of 512) rears its head: 
as long as we reply by sectors, we must NOT report a partial sector as a 
hole if we are unable to report the tail of the sector as data, but must 
instead report the entire sector as data.  Thankfully, all that goes 
away once you rebase to use the byte-based interface, at which point 
we're no longer rounding and risking a result on a partial sector being 
portrayed as the wrong status of the entire sector.

> +    return (extent.flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_DATA) |
> +           (extent.flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0);
> +}
> +
>   void nbd_client_detach_aio_context(BlockDriverState *bs)
>   {
>       NBDClientSession *client = nbd_get_client_session(bs);
> @@ -828,6 +966,7 @@ int nbd_client_init(BlockDriverState *bs,
>   
>       client->info.request_sizes = true;
>       client->info.structured_reply = true;
> +    client->info.base_allocation = true;

Hmm - the combination structured_reply = false and base_allocation = 
true is bogus.  Then again, these two fields are in-out; left false when 
handing over to the kernel NBD transmission phase (since the kernel 
module does not yet support structured replies let alone block status), 
and true when requested with qemu as the transmission driver (since we 
want to use it if available).  I don't know if having a single tri-state 
enum is any better than two bools (on input, it is either all-or-none; 
on output, it is either none (old server), structured reads only (qemu 
2.11 server, for example), or all (this series' server).

One of the obvious things that I will be testing is whether applying 
your series in a different order (client first, then server) still works 
well (the client requests, but fails to get, block status, but can still 
use structured reads, when paired against a qemu 2.11 server).  (And now 
you see why I suggested splitting the earlier patch that adds the 
constants and lookup tables for the structured reply additions, so that 
server and client can be backported independently)

> +++ b/nbd/client.c
> @@ -594,6 +594,108 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
>       return QIO_CHANNEL(tioc);
>   }
>   
> +/* nbd_negotiate_simple_meta_context:
> + * Set one meta context. Simple means that reply must contain zero (not
> + * negotiated) or one (negotiated) contexts. More contexts would be considered
> + * as a protocol error.
> + * return 1 for successful negotiation, context_id is set
> + *        0 if operation is unsupported,
> + *        -errno with errp set for any other error
> + */

Good enough for our first use.  Will obviously need improvements if we 
support base:allocation AND dirty bitmap exposure at the same time, in 
future patches ;)

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
> +    size_t export_len = strlen(export);
> +    size_t context_len = strlen(context);
> +    size_t data_len = 4 + export_len + 4 + 4 + context_len;

Looks a bit like magic numbers; would some sizeof() constructs make this 
any more obvious?

> +
> +    char *data = g_malloc(data_len);
> +    char *p = data;
> +
> +    stl_be_p(p, export_len);
> +    memcpy(p += 4, export, export_len);
> +    stl_be_p(p += export_len, 1);
> +    stl_be_p(p += 4, context_len);
> +    memcpy(p += 4, context, context_len);
> +
> +    ret = nbd_send_option_request(ioc, NBD_OPT_SET_META_CONTEXT, data_len, data,

So we don't even bother with LIST; either the SET works or we don't use 
block status.  Fair enough.

> +                                  errp);
> +    g_free(data);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
> +                                 errp) < 0)
> +    {
> +        return -1;
> +    }
> +
> +    ret = nbd_handle_reply_err(ioc, &reply, errp);
> +    if (ret <= 0) {
> +        return ret;
> +    }
> +
> +    if (reply.type == NBD_REP_META_CONTEXT) {
> +        char *name;
> +        size_t len;

A bit odd that this isn't a loop; we'll have to revisit that when we can 
start requesting more than one type of context at once.  But should work 
for now - given our initial request, the server shouldn't send us more 
than one response.

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

This check may not be valid for other context namespaces, but is correct 
for "base:allocation".

> +            g_free(name);
> +            return -1;
> +        }
> +        g_free(name);
> +
> +        received = true;
> +
> +        /* receive NBD_REP_ACK */
> +        if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
> +                                     errp) < 0)
> +        {
> +            return -1;
> +        }
> +
> +        ret = nbd_handle_reply_err(ioc, &reply, errp);
> +        if (ret <= 0) {
> +            return ret;
> +        }
> +    }
> +
> +    if (reply.type != NBD_REP_ACK) {
> +        error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x",
> +                   reply.type, NBD_REP_ACK);
> +        return -1;
> +    }
> +
> +    if (received) {
> +        *context_id = received_id;
> +        return 1;
> +    }
> +
> +    return 0;
> +}

Looks good.

>   
>   int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>                             QCryptoTLSCreds *tlscreds, const char *hostname,
> @@ -605,10 +707,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
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
> @@ -699,6 +803,16 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
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
> +
>               /* Try NBD_OPT_GO first - if it works, we are done (it
>                * also gives us a good message if the server requires
>                * TLS).  If it is not available, fall back to

Looks like the right place to ask.  This also gives us a good message if 
the server doesn't recognize the export name (presumably the same 
message we would also get under NBD_OPT_GO).

> diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
> index 7295b3d975..b083e2effd 100644
> --- a/tests/qemu-iotests/140.out
> +++ b/tests/qemu-iotests/140.out
> @@ -8,7 +8,7 @@ wrote 65536/65536 bytes at offset 0
>   read 65536/65536 bytes at offset 0
>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   {"return": {}}
> -can't open device nbd+unix:///drv?socket=TEST_DIR/nbd: Requested export not available
> +can't open device nbd+unix:///drv?socket=TEST_DIR/nbd: Invalid parameters for option 10 (set meta context)

Ouch, that's a regression.  Should be fixed by having the server fixed 
to send REP_ERR_UNKNOWN when an export name is not found (the same as we 
used to get under NBD_OPT_GO); I mentioned this already while reviewing 
the server side.

It also means our test is rather sensitive to running qemu as both 
client and server; other servers may send different error messages. 
Maybe we need to consider sanitizing things to be more independent of 
the server and only worry about the client under test - but that's not 
your problem in this series (I may be doing some of that as part of my 
work to get nbdkit to support structured replies, and finally have a 
server other than qemu so I can actually do interop testing).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
