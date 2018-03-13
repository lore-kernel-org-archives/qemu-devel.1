Received: from eggs.gnu.org ([2001:4830:134:3::10]:45465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evkHA-00088r-N2
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evkH8-0000G3-OL
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:47:36 -0400
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
	<20180312152126.286890-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88dd6a74-56a4-b63d-2b33-354443586331@redhat.com>
Date: Tue, 13 Mar 2018 08:47:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180312152126.286890-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/8] nbd: BLOCK_STATUS for standard
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

On 03/12/2018 10:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> Minimal realization: only one extent in server answer is supported.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> v2: - constants and type defs were splitted out by Eric, except for
>      NBD_META_ID_BASE_ALLOCATION

The constant for NBD_META_ID_BASE_ALLOCATION was intentionally not split 
out; it is the only constant that is relevant only to the server side ;) 
  In fact,...

>      - add nbd_opt_skip, to skip meta query remainder, if we are already sure,
>      that the query selects nothing
>      - check meta export name in OPT_EXPORT_NAME and OPT_GO
>      - always set context_id = 0 for NBD_OPT_LIST_META_CONTEXT
>      - negotiation rewritten to avoid wasting time and memory on reading long,
>      obviously invalid meta queries
>      - fixed ERR_INVALID->ERR_UNKNOWN if export not found in nbd_negotiate_meta_queries
>      - check client->export_meta.valid in "case NBD_CMD_BLOCK_STATUS"
> 
> 
>   include/block/nbd.h |   2 +
>   nbd/server.c        | 310 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 312 insertions(+)
> 
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 2285637e67..9f2be18186 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -188,6 +188,8 @@ typedef struct NBDExtent {
>   #define NBD_CMD_FLAG_REQ_ONE    (1 << 3) /* only one extent in BLOCK_STATUS
>                                             * reply chunk */
>   
> +#define NBD_META_ID_BASE_ALLOCATION 0
> +

...I will be squashing in a change to move it out of the .h and into the .c.

>   /* Supported request types */
>   enum {
>       NBD_CMD_READ = 0,
> diff --git a/nbd/server.c b/nbd/server.c
> index 085e14afbf..16d7388085 100644
> --- a/nbd/server.c

> @@ -371,6 +396,12 @@ static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)
>       return nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
>   }
>   
> +static void nbd_check_meta_export_name(NBDClient *client)
> +{
> +    client->export_meta.valid = client->export_meta.valid &&
> +        strcmp(client->exp->name, client->export_meta.export_name) == 0;

The indentation makes this harder for me to parse (at first glance, I 
thought you had (a) && (b), and were either missing a side effect or 
return statement).  It's a lot more obvious what you are doing with:

client->export_meta.valid &= !strcmp(client->exp->name,
                                      client->export_meta.export_name);


> +/* nbd_meta_base_query
> + *
> + * Handle query to 'base' namespace. For now, only base:allocation context is
> + * available in it.
> + *
> + * Return -errno on I/O error, 0 if option was completely handled by
> + * sending a reply about inconsistent lengths, or 1 on success. */
> +static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
> +                               uint32_t len, Error **errp)

The comments don't describe what 'len' represents, I had to go read the 
call-site before I could understand this function.  If I understand 
correctly, this function is called at the point that we have parsed 
"base:" out of the longer overall name given to LIST or SET, and len is 
the remaining length of the overall name that still needs parsing.

> +{
> +    int ret;
> +    char query[sizeof("allocation") - 1];

Why discard the trailing NUL from the size?  It doesn't hurt to leave it 
in, unless...

> +    size_t alen = strlen("allocation");

...Better than strlen() would be sizeof(query), as long as the trailing 
NUL is not changing the size of the array.

> +
> +    if (len == 0) {
> +        if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
> +            meta->base_allocation = true;
> +        }
> +        return 1;
> +    }

Okay, so here, the user requested "base:"; on list we return all 
contexts that we know (base:allocation); on set we fall through.

> +
> +    if (len != alen) {
> +        return nbd_opt_skip(client, len, errp);
> +    }

Here, the user requested "base:garbage", where the garbage (including 
empty string on set) is a different length than "base:allocation".  It 
may be a valid string for a future NBD version, but for us, we know 
right away it is is not something we recognize, so we gracefully skip it.

Checking myself: if nbd_opt_skip returned -1, we have detected 
communication problems with the client; it does not matter if there is 
any unparsed data remaining in the current option.  It can only return 0 
if nbd_opt_invalid has already finished parsing the entire option (we 
are ready to parse the next NBD_OPT command, no further queries in the 
current option matter).  It can only return 1 if we finished parsing the 
current query, and are positioned ready to parse the next query. [1]

> +
> +    ret = nbd_opt_read(client, query, len, errp);
> +    if (ret <= 0) {
> +        return ret;
> +    }
> +
> +    if (strncmp(query, "allocation", alen) == 0) {

Here, you HAD to use strncmp because you didn't leave room for the 
trailing NUL in the array above.  Tradeoffs.  So I guess your approach 
is okay.

> +        meta->base_allocation = true;
> +    }
> +
> +    return 1;

And if we get here, the user requested exactly "base:allocation", so we 
enabled exactly that context.

> +}
> +
> +/* nbd_negotiate_meta_query
> + *
> + * Parse namespace name and call corresponding function to parse body of the
> + * query.
> + *
> + * The only supported namespace now is 'base'.
> + *
> + * The function aims not wasting time and memory to read long unknown namespace
> + * names.
> + *
> + * Return -errno on I/O error, 0 if option was completely handled by
> + * sending a reply about inconsistent lengths, or 1 on success. */
> +static int nbd_negotiate_meta_query(NBDClient *client,
> +                                    NBDExportMetaContexts *meta, Error **errp)
> +{
> +    int ret;
> +    char query[sizeof("base:") - 1];
> +    size_t baselen = strlen("base:");

And since this matches the approach in the previous function, we'll keep 
it consistent.

> +    uint32_t len;
> +
> +    ret = nbd_opt_read(client, &len, sizeof(len), errp);
> +    if (ret <= 0) {
> +        return ret;
> +    }
> +    cpu_to_be32s(&len);
> +
> +    /* The only supported namespace for now is 'base'. So query should start
> +     * with 'base:'. Otherwise, we can ignore it and skip the remainder. */
> +    if (len < baselen) {
> +        return nbd_opt_skip(client, len, errp);
> +    }
> +
> +    len -= baselen;
> +    ret = nbd_opt_read(client, query, baselen, errp);
> +    if (ret <= 0) {
> +        return ret;
> +    }
> +    if (strncmp(query, "base:", baselen) != 0) {

Again, strncmp is a bit awkward compared to strcmp, but it works.

> +        return nbd_opt_skip(client, len, errp);
> +    }
> +
> +    return nbd_meta_base_query(client, meta, len, errp);
> +}
> +
> +/* nbd_negotiate_meta_queries
> + * Handle NBD_OPT_LIST_META_CONTEXT and NBD_OPT_SET_META_CONTEXT
> + *
> + * @meta may be NULL, if caller isn't interested in selected contexts (for
> + *     NBD_OPT_LIST_META_CONTEXT)
> + *
> + * Return -errno on I/O error, 0 if option was completely handled by
> + * sending a reply about inconsistent lengths, or 1 on success. */

Comment is wrong - this function never returns 1 (nor should it, as 
nbd_negotiate_options() expects a return of 1 only from NBD_OPT_ABORT).

> +static int nbd_negotiate_meta_queries(NBDClient *client,
> +                                      NBDExportMetaContexts *meta, Error **errp)
> +{
> +    int ret;
> +    NBDExport *exp;
> +    NBDExportMetaContexts local_meta;
> +    uint32_t nb_queries;
> +    int i;
> +
> +    assert(client->structured_reply);

Perhaps worth a comment that this is safe because we already filtered it 
out at the caller.

> +
> +    if (!meta) {
> +        meta = &local_meta;
> +    }
> +
> +    memset(meta, 0, sizeof(*meta));
> +
> +    ret = nbd_opt_read_name(client, meta->export_name, NULL, errp);
> +    if (ret <= 0) {
> +        return ret;
> +    }
> +
> +    exp = nbd_export_find(meta->export_name);
> +    if (exp == NULL) {
> +        return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
> +                            "export '%s' not present", meta->export_name);
> +    }
> +

It's nice to see my review comments from v1 fixed here ;)

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

[1] Okay, I've convinced myself we are good.  We can only early return 
from this loop if we encountered a disconnect (result -1, either read or 
write to client failed, no further communication is worth trying, so it 
doesn't matter if we are left mid-option) or if we encountered an 
inconsistent length and already replied successfully to the client about 
their bogus request (result 0, we've already skipped to the end of the 
current option, ready to parse the next NBD_OPT).

> +        }
> +    }

Missing: On LIST, if nb_queries is 0 before the loop, then we must reply 
with ALL supported contexts, rather than none (the behavior for SET is 
correct, though).

> +
> +    if (meta->base_allocation) {
> +        ret = nbd_negotiate_send_meta_context(client, "base:allocation",
> +                                              NBD_META_ID_BASE_ALLOCATION,
> +                                              errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
> +    if (ret == 0) {
> +        meta->valid = true;
> +    }
> +
> +    return ret;

Code is correct - all early returns and this final return are negative 
or 0, where 0 means we parsed the entire NBD_OPT, gave a reply, and the 
connection is ready for the next NBD_OPT.

> +}
> +
>   /* nbd_negotiate_options
>    * Process all NBD_OPT_* client option commands, during fixed newstyle
>    * negotiation.
> @@ -856,6 +1064,22 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
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
> +                } else if (option == NBD_OPT_LIST_META_CONTEXT) {
> +                    ret = nbd_negotiate_meta_queries(client, NULL, errp);
> +                } else {
> +                    ret = nbd_negotiate_meta_queries(client,
> +                                                     &client->export_meta,
> +                                                     errp);
> +                }

Looks good.

If we WANTED to split this patch into two, then part 1 would be NBD_OPT 
handling (were we just always return 0 contexts in reply to LIST or 
SET), and part 2 would be NBD_CMD_BLOCK_STATUS handling plus enabling 
base:allocation advertisement during NBD_OPT handling.  But I'm not 
going to ask for a split now.

> +                break;
> +
>               default:
>                   ret = nbd_opt_drop(client, NBD_REP_ERR_UNSUP, errp,
>                                      "Unsupported option %" PRIu32 " (%s)",
> @@ -1485,6 +1709,79 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
>       return ret;
>   }
>   
> +static int blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,
> +                                    uint64_t bytes, NBDExtent *extent)
> +{
> +    uint64_t remaining_bytes = bytes;
> +
> +    while (remaining_bytes) {
> +        uint32_t flags;
> +        int64_t num;
> +        int ret = bdrv_block_status_above(bs, NULL, offset, remaining_bytes,
> +                                          &num, NULL, NULL);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        flags = (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
> +                (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);

I still need to fix what block_status_above returns for protocol drivers 
per Kevin's review of my byte-based status patches, but that will be 
during soft freeze (as it is in the bug fix category); it may have a 
minor impact to this code.  But it shouldn't hold up this series.

> @@ -1562,6 +1859,8 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
>           valid_flags |= NBD_CMD_FLAG_DF;
>       } else if (request->type == NBD_CMD_WRITE_ZEROES) {
>           valid_flags |= NBD_CMD_FLAG_NO_HOLE;
> +    } else if (request->type == NBD_CMD_BLOCK_STATUS) {
> +        valid_flags |= NBD_CMD_FLAG_REQ_ONE;
>       }
>       if (request->flags & ~valid_flags) {
>           error_setg(errp, "unsupported flags for command %s (got 0x%x)",
> @@ -1690,6 +1989,17 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>   
>           return nbd_send_generic_reply(client, request->handle, ret,
>                                         "discard failed", errp);
> +    case NBD_CMD_BLOCK_STATUS:
> +        if (client->export_meta.valid && client->export_meta.base_allocation) {
> +            return nbd_co_send_block_status(client, request->handle,
> +                                            blk_bs(exp->blk), request->from,
> +                                            request->len,
> +                                            NBD_META_ID_BASE_ALLOCATION, errp);

Will obviously be expanded as we add more namespaces (for dirty bitmap 
queries), but works for your first cut of just reporting block status.

> +        } else {
> +            return nbd_send_generic_reply(client, request->handle, -EINVAL,
> +                                          "CMD_BLOCK_STATUS not negotiated",
> +                                          errp);
> +        }
>       default:
>           msg = g_strdup_printf("invalid request type (%" PRIu32 ") received",
>                                 request->type);
> 

I'm making tweaks as mentioned above, but this is close enough to get 
into softfreeze.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
