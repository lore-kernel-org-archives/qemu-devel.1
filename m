Received: from eggs.gnu.org ([2001:4830:134:3::10]:53096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emfxc-0005ea-T5
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emfxa-0002CU-SQ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:21:56 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-4-git-send-email-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b1f16df-0ee8-7453-9d82-fd85c1a17f5e@redhat.com>
Date: Fri, 16 Feb 2018 07:21:30 -0600
MIME-Version: 1.0
In-Reply-To: <1518702707-7077-4-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] nbd: BLOCK_STATUS for standard
 get_block_status function: server part
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
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

continuing where I left off,


> +++ b/nbd/common.c
> @@ -75,6 +75,10 @@ const char *nbd_opt_lookup(uint32_t opt)
>           return "go";
>       case NBD_OPT_STRUCTURED_REPLY:
>           return "structured reply";
> +    case NBD_OPT_LIST_META_CONTEXT:
> +        return "list meta context";
> +    case NBD_OPT_SET_META_CONTEXT:
> +        return "set meta context";
>       default:

Should the changes to the header for new macros and to common.c for 
mapping bits to names be split into a separate patch, so that someone 
could backport just the new constants and then the client-side 
implementation, rather than being forced to backport the rest of the 
server implementation at the same time?

> +
> +/* nbd_read_size_string
> + *
> + * Read string in format
> + *   uint32_t len
> + *   len bytes string (not 0-terminated)
> + *
> + * @buf should be enough to store @max_len+1
> + *
> + * Return -errno on I/O error, 0 if option was completely handled by
> + * sending a reply about inconsistent lengths, or 1 on success. */
> +static int nbd_read_size_string(NBDClient *client, char *buf,
> +                                uint32_t max_len, Error **errp)

Would existing code benefit from using this helper?  If so, splitting it 
into a separate patch, plus converting initial clients to use it, would 
be worthwhile.


> +
> +static int nbd_negotiate_send_meta_context(NBDClient *client,
> +                                           const char *context,
> +                                           uint32_t context_id,
> +                                           Error **errp)

No comment documenting this function?

> +{
> +    NBDOptionReplyMetaContext opt;
> +    struct iovec iov[] = {
> +        {.iov_base = &opt, .iov_len = sizeof(opt)},
> +        {.iov_base = (void *)context, .iov_len = strlen(context)}

Casting to void* looks suspicious, but I see that it is casting away 
const.  Okay.

> +    };
> +
> +    set_be_option_rep(&opt.h, client->opt, NBD_REP_META_CONTEXT,
> +                      sizeof(opt) - sizeof(opt.h) + iov[1].iov_len);
> +    stl_be_p(&opt.context_id, context_id);
> +
> +    return qio_channel_writev_all(client->ioc, iov, 2, errp) < 0 ? -EIO : 0;
> +}
> +
> +static void nbd_meta_base_query(NBDExportMetaContexts *meta, const char *query)
> +{

Again, function comments are useful.

> +    if (query[0] == '\0' || strcmp(query, "allocation") == 0) {
> +        /* Note: empty query should select all contexts within base
> +         * namespace. */
> +        meta->base_allocation = true;

 From the client perspective, this handling of the empty leaf-name works 
well for NBD_OPT_LIST_META_CONTEXT (I want to see what leaf nodes the 
server supports), but not so well for NBD_OPT_SET_META_CONTEXT (asking 
the server to send ALL base allocations, even when I don't necessarily 
know how to interpret anything other than base:allocation, is a waste). 
So this function needs a bool parameter that says whether it is being 
invoked from _LIST (empty string okay, to advertise ALL base leaf names 
back to client, which for now is just base:allocation) or from _SET 
(empty string is ignored as invalid; client has to specifically ask for 
base:allocation by name).

> +    }
> +}
> +
> +/* nbd_negotiate_meta_query
> + * Return -errno on I/O error, 0 if option was completely handled by
> + * sending a reply about inconsistent lengths, or 1 on success. */
> +static int nbd_negotiate_meta_query(NBDClient *client,
> +                                    NBDExportMetaContexts *meta, Error **errp)
> +{
> +    int ret;
> +    char *query, *colon, *namespace, *subquery;

Is it worth stack-allocating query here, so you don't have to g_free() 
it later?  NBD limits the maximum string to 4k, which is a little bit 
big for stack allocation (on an operating system with 4k pages, 
allocating more than 4k on the stack in one function risks missing the 
guard page on stack overflow), but we also have the benefit that we KNOW 
that the set of meta-context namespaces that we support have a much 
smaller maximum limit of what we even care about.

> +
> +    ret = nbd_alloc_read_size_string(client, &query, errp);
> +    if (ret <= 0) {
> +        return ret;
> +    }
> +
> +    colon = strchr(query, ':');
> +    if (colon == NULL) {
> +        ret = nbd_opt_invalid(client, errp, "no colon in query");
> +        goto out;

Hmm, that puts a slight wrinkle into my proposal, or else maybe it is 
something I should bring up on the NBD list.  If we only read 5 
characters (because the max namespace WE support is "base:"), but a 
client asks for namespace "X-longname:", we should gracefully ignore the 
client's request; while we still want to reply with an error to a client 
that asks for "garbage" with no colon at all.  The question for the NBD 
spec, then, is whether detecting bad client requests that didn't use 
colon is mandatory for the server (meaning we MUST read the entire 
namespace request, and search for the colon) or merely best effort (we 
only have to read 5 characters, and if we silently ignore instead of 
diagnose a bad namespace request that was longer than that, oh well). 
Worded from the client, it switches to a question of whether the client 
should expect the server to diagnose all requests, or must be prepared 
for the server to ignore requests even where those requests are bogus. 
Or, the NBD spec may change slightly to pass namespace and leafname as 
separate fields, both with lengths, rather than a colon, to make it 
easier for the server to skip over an unknown namespace/leaf pair 
without having to parse whether a colon was present.  I'll send that in 
a separate email (the upstream NBD list doesn't need to see all my 
review comments on this thread).

> +    }
> +    *colon = '\0';
> +    namespace = query;
> +    subquery = colon + 1;
> +
> +    if (strcmp(namespace, "base") == 0) {
> +        nbd_meta_base_query(meta, subquery);
> +    }
> +
> +out:
> +    g_free(query);
> +    return ret;
> +}
> +
> +/* nbd_negotiate_meta_queries
> + * Handle NBD_OPT_LIST_META_CONTEXT and NBD_OPT_SET_META_CONTEXT
> + *
> + * Return -errno on I/O error, 0 if option was completely handled by
> + * sending a reply about inconsistent lengths, or 1 on success. */
> +static int nbd_negotiate_meta_queries(NBDClient *client,
> +                                      NBDExportMetaContexts *meta, Error **errp)
> +{

The two options can mostly share code, but see my earlier comments about 
how I think you need to distinguish between list ('base:' is a valid 
query) and set ('base:' is an invalid request).

> +    int ret;
> +    NBDExport *exp;
> +    NBDExportMetaContexts local_meta;
> +    uint32_t nb_queries;
> +    int i;
> +
> +    assert(client->structured_reply);

Hmm.  Asserting here is bad if the client can get here without 
negotiating structured reply (I'll have to see if you checked that in 
the caller... [1])

> +
> +    if (meta == NULL) {

Bikeshedding - I like writing 'if (!meta) {' as it is fewer characters.

The function documentation should mention that 'meta' may be NULL from 
the caller.  But (without seeing the callers yet), why?  Are you arguing 
that _LIST uses local_meta (because it only needs something for the 
duration of the reply) while _SET supplies a pre-existing meta (that is 
associated with the server state, and used when the client finally calls 
NBD_OPT_GO)?

> +        meta = &local_meta;
> +    }
> +
> +    memset(meta, 0, sizeof(*meta));
> +
> +    ret = nbd_read_size_string(client, meta->export_name,
> +                               NBD_MAX_NAME_SIZE, errp);

Revisiting a question I raised in my first half review - you saved the 
name as part of the struct because we have to later compare that the 
final OPT_SET export name matches the request during OPT_GO (if they 
don't match, then we have no contexts to serve after all).  So a 'const 
char *' won't work, but maybe the struct could use a 'char *' pointing 
to malloc'd storage rather than char[MAX_NAME] that reserves array space 
that is mostly unused for the typical name that is much shorter than the 
maximum name length.

> +    if (ret <= 0) {
> +        return ret;
> +    }
> +
> +    exp = nbd_export_find(meta->export_name);
> +    if (exp == NULL) {
> +        return nbd_opt_invalid(client, errp,
> +                               "export '%s' not present", meta->export_name);

Wrong error; I think NBD_REP_ERR_UNKNOWN is better here.

> +    }
> +
> +    ret = nbd_opt_read(client, &nb_queries, sizeof(nb_queries), errp);
> +    if (ret <= 0) {
> +        return ret;
> +    }
> +    cpu_to_be32s(&nb_queries);
> +
> +    for (i = 0; i < nb_queries; ++i) {
> +        ret = nbd_negotiate_meta_query(client, meta, errp);
> +        if (ret <= 0) {
> +            return ret;
> +        }
> +    }

Interesting choice - you parse all queries prior to preparing any 
response.  I guess you could also reply as you read, but it doesn't 
change the fact that you have to remember what the final _SET selected 
for use later on.  So this works.

> +
> +    if (meta->base_allocation) {
> +        ret = nbd_negotiate_send_meta_context(client, "base:allocation",
> +                                              NBD_META_ID_BASE_ALLOCATION,
> +                                              errp);

Since earlier you have #define NBD_META_ID_BASE_ALLOCATION 0, that means 
you use the context ID of 0 in response to both _LIST (where the spec 
says the server SHOULD send 0, but the client SHOULD ignore the id 
field) and for _SET (where the client needs a unique ID for every 
separate context that actually got selected - but since we only select a 
single context, we get away with it).  I suspect later patches will add 
additional contexts where you'll have to actually worry about context 
ids (and always sending 0 in response to _LIST), but for now, this works :)

> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
> +    if (ret == 0) {
> +        meta->valid = true;
> +    }

Interesting - meta->valid can be true even if 0 contexts were selected; 
I presume we use this later on to decide whether to reply with EINVAL 
vs. an empty list if a client uses NBD_CMD_BLOCK_STATUS without a valid 
_SET call.  Then again, the NBD spec currently states that 
NBD_CMD_BLOCK_STATUS should not be used even if _SET succeeded, if the 
_SET didn't return at least one context.

> +
> +    return ret;
> +}
> +
>   /* nbd_negotiate_options
>    * Process all NBD_OPT_* client option commands, during fixed newstyle
>    * negotiation.
> @@ -826,6 +1031,22 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
>                   }
>                   break;
>   
> +            case NBD_OPT_LIST_META_CONTEXT:
> +            case NBD_OPT_SET_META_CONTEXT:
> +                if (!client->structured_reply) {
> +                    ret = nbd_opt_invalid(
> +                            client, errp,
> +                            "request option '%s' when structured reply "
> +                            "is not negotiated", nbd_opt_lookup(option));

[1] okay, you did filter out clients that request out of order.

> +                } else if (option == NBD_OPT_LIST_META_CONTEXT) {
> +                    ret = nbd_negotiate_meta_queries(client, NULL, errp);
> +                } else {
> +                    ret = nbd_negotiate_meta_queries(client,
> +                                                     &client->export_meta,
> +                                                     errp);

Okay, so you DO have a difference on whether you pass in 'meta' based on 
whether it is a local response vs. setting things for later.

> +                }
> +                break;
> +
>               default:
>                   ret = nbd_opt_drop(client, NBD_REP_ERR_UNSUP, errp,
>                                      "Unsupported option 0x%" PRIx32 " (%s)",
> @@ -1446,6 +1667,78 @@ static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
>       return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
>   }
>   
> +static int blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,
> +                                    uint64_t bytes, NBDExtent *extent)
> +{
> +    uint64_t tail_bytes = bytes;
> +
> +    while (tail_bytes) {

I might have named this 'remaining'

> +        uint32_t flags;
> +        int64_t num;
> +        int ret = bdrv_block_status_above(bs, NULL, offset, tail_bytes, &num,
> +                                          NULL, NULL);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        flags = (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
> +                (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);

Looks like the correct bit mapping to me.

> +
> +        if (tail_bytes == bytes) {
> +            extent->flags = flags;
> +        }
> +
> +        if (flags != extent->flags) {
> +            break;
> +        }
> +
> +        offset += num;
> +        tail_bytes -= num;
> +    }
> +
> +    cpu_to_be32s(&extent->flags);
> +    extent->length = cpu_to_be32(bytes - tail_bytes);

This only computes one extent, but tries to find the longest extent 
possible (if two consecutive bdrv_block_status calls return the same 
status, perhaps because of fragmentation).  Presumably this is called in 
a loop to find a full list of extents covering the client's entire 
request? [2]

> +
> +    return 0;
> +}
> +
> +/* nbd_co_send_extents
> + * @extents should be in big-endian */
> +static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
> +                               NBDExtent *extents, unsigned nb_extents,
> +                               uint32_t context_id, Error **errp)
> +{
> +    NBDStructuredMeta chunk;
> +
> +    struct iovec iov[] = {
> +        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
> +        {.iov_base = extents, .iov_len = nb_extents * sizeof(extents[0])}
> +    };
> +
> +    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_BLOCK_STATUS,
> +                 handle, sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);

This says you can only send a single chunk, which matches the fact that 
right now you support exactly one context type.  Presumably later 
patches tweak this.

> +    stl_be_p(&chunk.context_id, context_id);
> +
> +    return nbd_co_send_iov(client, iov, 2, errp);
> +}
> +
> +static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
> +                                    BlockDriverState *bs, uint64_t offset,
> +                                    uint64_t length, uint32_t context_id,
> +                                    Error **errp)

No function comment?

> +{
> +    int ret;
> +    NBDExtent extent;
> +
> +    ret = blockstatus_to_extent_be(bs, offset, length, &extent);
> +    if (ret < 0) {
> +        return nbd_co_send_structured_error(
> +                client, handle, -ret, "can't get block status", errp);
> +    }
> +
> +    return nbd_co_send_extents(client, handle, &extent, 1, context_id, errp);

[2] Okay, no looping to answer the client's entire request, so that may 
be something you add in a later patch, to keep this initial patch 
minimal.  But at least it matches your commit message.

> +}
> +
>   /* nbd_co_receive_request
>    * Collect a client request. Return 0 if request looks valid, -EIO to drop
>    * connection right away, and any other negative value to report an error to
> @@ -1523,6 +1816,8 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
>           valid_flags |= NBD_CMD_FLAG_DF;
>       } else if (request->type == NBD_CMD_WRITE_ZEROES) {
>           valid_flags |= NBD_CMD_FLAG_NO_HOLE;
> +    } else if (request->type == NBD_CMD_BLOCK_STATUS) {
> +        valid_flags |= NBD_CMD_FLAG_REQ_ONE;
>       }
>       if (request->flags & ~valid_flags) {
>           error_setg(errp, "unsupported flags for command %s (got 0x%x)",
> @@ -1650,6 +1945,19 @@ static coroutine_fn void nbd_trip(void *opaque)
>           }
>   
>           break;
> +    case NBD_CMD_BLOCK_STATUS:
> +        if (client->export_meta.base_allocation) {
> +            ret = nbd_co_send_block_status(req->client, request.handle,
> +                                           blk_bs(exp->blk), request.from,
> +                                           request.len,
> +                                           NBD_META_ID_BASE_ALLOCATION,
> +                                           &local_err);

No check of client->export_meta.valid?

> +        } else {
> +            ret = -EINVAL;
> +            error_setg(&local_err, "CMD_BLOCK_STATUS not negotiated");
> +        }

At this point, we've either sent the final structured chunk, or we've 
sent nothing and have ret < 0;...

> +
> +        break;
>       default:
>           error_setg(&local_err, "invalid request type (%" PRIu32 ") received",
>                      request.type);
> @@ -1680,7 +1988,7 @@ reply:

     if (client->structured_reply &&
         (ret < 0 || request.type == NBD_CMD_READ)) {

>               ret = nbd_co_send_structured_done(req->client, request.handle,
>                                                 &local_err);
>           }

...iIf the client negotiated structured reply, then we've sent the error 
message.  But if the client did NOT negotiate structured reply, then...

> -    } else {
> +    } else if (request.type != NBD_CMD_BLOCK_STATUS) {

...we fail to reply at all.  Oops.  That's not good for 
interoperability.  You'll need to make sure that we reply with EINVAL 
even if the client (mistakenly) calls NBD_CMD_BLOCK_STATUS without 
negotiating structured replies.

>           ret = nbd_co_send_simple_reply(req->client, request.handle,
>                                          ret < 0 ? -ret : 0,
>                                          req->data, reply_data_len, &local_err);
> 

Also missing from the patch - where do you validate that the export name 
in client->export_meta matches the export name in NBD_OPT_GO?  If they 
don't match, then export_meta should be discarded.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
