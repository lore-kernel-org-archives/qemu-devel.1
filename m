Received: from eggs.gnu.org ([2001:4830:134:3::10]:43832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e5dR8-0004iz-GA
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e5dR3-0005uD-K7
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:58:30 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-12-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <799e98b5-4013-0118-1cd1-3fba39fe6bdc@virtuozzo.com>
Date: Fri, 20 Oct 2017 22:58:22 +0300
MIME-Version: 1.0
In-Reply-To: <20171019222637.17890-12-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 11/11] nbd: Minimal structured read for
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

20.10.2017 01:26, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Minimal implementation: for structured error only error_report error
> message.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v5: fix payload_advance[32,64], return correct negative error on
> structured error, rearrange size checks to not be vulnerable to
> overflow, simplify payload to use g_new instead of qemu_memalign,
> don't set errp when returning 0, validate that error message
> length is sane
> ---
>   include/block/nbd.h |  12 ++
>   nbd/nbd-internal.h  |   1 -
>   block/nbd-client.c  | 489 ++++++++++++++++++++++++++++++++++++++++++++++++----
>   nbd/client.c        |  10 ++
>   4 files changed, 479 insertions(+), 33 deletions(-)
>
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index da6e305dd5..92d1723d7c 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -197,6 +197,11 @@ enum {
>   #define NBD_REPLY_TYPE_ERROR         NBD_REPLY_ERR(1)
>   #define NBD_REPLY_TYPE_ERROR_OFFSET  NBD_REPLY_ERR(2)
>
> +static inline bool nbd_reply_type_is_error(int type)
> +{
> +    return type & (1 << 15);
> +}
> +
>   /* NBD errors are based on errno numbers, so there is a 1:1 mapping,
>    * but only a limited set of errno values is specified in the protocol.
>    * Everything else is squashed to EINVAL.
> @@ -214,6 +219,11 @@ enum {
>   struct NBDExportInfo {
>       /* Set by client before nbd_receive_negotiate() */
>       bool request_sizes;
> +
> +    /* In-out fields, set by client before nbd_receive_negotiate() and
> +     * updated by server results during nbd_receive_negotiate() */
> +    bool structured_reply;
> +
>       /* Set by server results during nbd_receive_negotiate() */
>       uint64_t size;
>       uint16_t flags;
> @@ -284,4 +294,6 @@ static inline bool nbd_reply_is_structured(NBDReply *reply)
>       return reply->magic == NBD_STRUCTURED_REPLY_MAGIC;
>   }
>
> +const char *nbd_reply_type_lookup(uint16_t type);
> +
>   #endif
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index b64eb1cc9b..eeff78d3c9 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -104,7 +104,6 @@ const char *nbd_opt_lookup(uint32_t opt);
>   const char *nbd_rep_lookup(uint32_t rep);
>   const char *nbd_info_lookup(uint16_t info);
>   const char *nbd_cmd_lookup(uint16_t info);
> -const char *nbd_reply_type_lookup(uint16_t type);
>   const char *nbd_err_lookup(int err);
>
>   int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 58493b7ac4..9f82e23096 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -93,7 +93,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
>           if (i >= MAX_NBD_REQUESTS ||
>               !s->requests[i].coroutine ||
>               !s->requests[i].receiving ||
> -            nbd_reply_is_structured(&s->reply))
> +            (nbd_reply_is_structured(&s->reply) && !s->info.structured_reply))
>           {
>               break;
>           }
> @@ -181,75 +181,490 @@ err:
>       return rc;
>   }
>

[...]

> +static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chunk,
> +                                         uint8_t *payload, QEMUIOVector *qiov,
> +                                         Error **errp)
> +{
> +    uint64_t offset;
> +    uint32_t hole_size;
> +
> +    if (chunk->length != sizeof(offset) + sizeof(hole_size)) {
> +        error_setg(errp, "Protocol error: invalid payload for "
> +                         "NBD_REPLY_TYPE_OFFSET_HOLE");
> +        return -EINVAL;
> +    }
> +
> +    offset = payload_advance64(&payload);
> +    hole_size = payload_advance32(&payload);
> +
> +    if (offset > qiov->size - hole_size) {

hmm, you've changed order to prevent overflow.. can it overflow anyway 
through negative minimum on 32-bit system with some unhappy size and 
hole_size?

> +        error_setg(errp, "Protocol error: server sent chunk exceeding requested"
> +                         " region");
> +        return -EINVAL;
> +    }
> +
> +    qemu_iovec_memset(qiov, offset, 0, hole_size);
> +
> +    return 0;
> +}
> +
> +/* nbd_parse_error_payload
> + * on success @errp contains message describing nbd error reply

[1]

> + */
> +static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
> +                                   uint8_t *payload, int *request_ret,
> +                                   Error **errp)
> +{
> +    uint32_t error;
> +    uint16_t message_size;
> +
> +    assert(chunk->type & (1 << 15));
> +
> +    if (chunk->length < sizeof(error) + sizeof(message_size)) {
> +        error_setg(errp,
> +                   "Protocol error: invalid payload for structured error");
> +        return -EINVAL;
> +    }
> +
> +    error = nbd_errno_to_system_errno(payload_advance32(&payload));
> +    if (error == 0) {
> +        error_setg(errp, "Protocol error: server sent structured error chunk"
> +                         "with error = 0");
> +        return -EINVAL;
> +    }
> +
> +    *request_ret = -error;
> +    message_size = payload_advance16(&payload);
> +
> +    if (message_size > chunk->length - sizeof(error) - sizeof(message_size)) {
> +        error_setg(errp, "Protocol error: server sent structured error chunk"
> +                         "with incorrect message size");
> +        return -EINVAL;
> +    }
> +

you removed my error message from errp, but didn't change comment..

And you lose the message.. At least add a "TODO" for it...

> +    /* TODO: Add a trace point to mention the server complaint */
> +
> +    /* TODO handle ERROR_OFFSET */
> +
> +    return 0;
> +}
> +
> +static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
> +                                              QEMUIOVector *qiov, Error **errp)
> +{
> +    QEMUIOVector sub_qiov;
> +    uint64_t offset;
> +    size_t data_size;
> +    int ret;
> +    NBDStructuredReplyChunk *chunk = &s->reply.structured;
> +
> +    assert(nbd_reply_is_structured(&s->reply));
> +
> +    if (chunk->length < sizeof(offset)) {
> +        error_setg(errp, "Protocol error: invalid payload for "
> +                         "NBD_REPLY_TYPE_OFFSET_DATA");
> +        return -EINVAL;
> +    }
> +
> +    if (nbd_read(s->ioc, &offset, sizeof(offset), errp) < 0) {
> +        return -EIO;
> +    }
> +    be64_to_cpus(&offset);
> +
> +    data_size = chunk->length - sizeof(offset);
> +    if (offset > qiov->size - data_size) {
> +        error_setg(errp, "Protocol error: server sent chunk exceeding requested"
> +                         " region");
> +        return -EINVAL;
> +    }
> +
> +    qemu_iovec_init(&sub_qiov, qiov->niov);
> +    qemu_iovec_concat(&sub_qiov, qiov, offset, data_size);
> +    ret = qio_channel_readv_all(s->ioc, sub_qiov.iov, sub_qiov.niov, errp);
> +    qemu_iovec_destroy(&sub_qiov);
> +
> +    return ret < 0 ? -EIO : 0;
> +}
> +
> +#define NBD_MAX_MALLOC_PAYLOAD 1000
> +/* nbd_co_receive_structured_payload
> + * The resulting pointer stored in @payload requires g_free() to free it.

I think now it is an extra comment..
(and all it's duplication)

> + */
> +static coroutine_fn int nbd_co_receive_structured_payload(
> +        NBDClientSession *s, void **payload, Error **errp)
> +{
> +    int ret;
> +    uint32_t len;
> +
> +    assert(nbd_reply_is_structured(&s->reply));
> +
> +    len = s->reply.structured.length;
> +
> +    if (len == 0) {
> +        return 0;
> +    }
> +
> +    if (payload == NULL) {
> +        error_setg(errp, "Unexpected structured payload");
> +        return -EINVAL;
> +    }
> +
> +    if (len > NBD_MAX_MALLOC_PAYLOAD) {
> +        error_setg(errp, "Payload too large");
> +        return -EINVAL;
> +    }
> +
> +    *payload = g_new(char, len);
> +    ret = nbd_read(s->ioc, *payload, len, errp);
> +    if (ret < 0) {
> +        g_free(*payload);
> +        *payload = NULL;
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +/* nbd_co_do_receive_one_chunk
> + * for simple reply:
> + *   set request_ret to received reply error
> + *   if qiov is not NULL: read payload to @qiov
> + * for structured reply chunk:
> + *   if error chunk: read payload, set @request_ret, do not set @payload
> + *   else if offset_data chunk: read payload data to @qiov, do not set @payload
> + *   else: read payload to @payload
> + *
> + * The pointer stored in @payload requires g_free() to free it.
> + * If function fails, @errp contains corresponding error message, and the
> + * connection with the server is suspect.  If it returns 0, then the
> + * transaction succeeded (although @request_ret may be a negative errno
> + * corresponding to the server's error reply), and errp is unchanged.
> + */
> +static coroutine_fn int nbd_co_do_receive_one_chunk(
> +        NBDClientSession *s, uint64_t handle, bool only_structured,
> +        int *request_ret, QEMUIOVector *qiov, void **payload, Error **errp)
>   {
>       int ret;
>       int i = HANDLE_TO_INDEX(s, handle);
> +    void *local_payload = NULL;
> +    NBDStructuredReplyChunk *chunk;
> +
> +    if (payload) {
> +        *payload = NULL;
> +    }
> +    *request_ret = 0;
>
>       /* Wait until we're woken up by nbd_read_reply_entry.  */
>       s->requests[i].receiving = true;
>       qemu_coroutine_yield();
>       s->requests[i].receiving = false;
>       if (!s->ioc || s->quit) {
> -        ret = -EIO;
> +        error_setg(errp, "Connection closed");
> +        return -EIO;
> +    }
> +
> +    assert(s->reply.handle == handle);
> +
> +    if (nbd_reply_is_simple(&s->reply)) {
> +        if (only_structured) {
> +            error_setg(errp, "Protocol error: simple reply when structured"
> +                             "reply chunk was expected");
> +            return -EINVAL;
> +        }
> +
> +        *request_ret = -nbd_errno_to_system_errno(s->reply.simple.error);
> +        if (*request_ret < 0 || !qiov) {
> +            return 0;
> +        }
> +
> +        return qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
> +                                     errp) < 0 ? -EIO : 0;
> +    }
> +
> +    /* handle structured reply chunk */
> +    assert(s->info.structured_reply);
> +    chunk = &s->reply.structured;
> +
> +    if (chunk->type == NBD_REPLY_TYPE_NONE) {
> +        if (!(chunk->flags & NBD_REPLY_FLAG_DONE)) {
> +            error_setg(errp, "Protocol error: NBD_REPLY_TYPE_NONE chunk without"
> +                             "NBD_REPLY_FLAG_DONE flag set");
> +            return -EINVAL;
> +        }
> +        return 0;
> +    }
> +
> +    if (chunk->type == NBD_REPLY_TYPE_OFFSET_DATA) {
> +        if (!qiov) {
> +            error_setg(errp, "Unexpected NBD_REPLY_TYPE_OFFSET_DATA chunk");
> +            return -EINVAL;
> +        }
> +
> +        return nbd_co_receive_offset_data_payload(s, qiov, errp);
> +    }
> +
> +    if (nbd_reply_type_is_error(chunk->type)) {
> +        payload = &local_payload;
> +    }
> +
> +    ret = nbd_co_receive_structured_payload(s, payload, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (nbd_reply_type_is_error(chunk->type)) {
> +        ret = nbd_parse_error_payload(chunk, local_payload, request_ret, errp);
> +        g_free(local_payload);

and error message is lost.. So you don't like an idea of saving it in errp?

> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +

[...]

> +
> +static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
> +                          QEMUIOVector *write_qiov)
>   {
> -    NBDClientSession *client = nbd_get_client_session(bs);
>       int ret;
> +    Error *local_err = NULL;
> +    NBDClientSession *client = nbd_get_client_session(bs);
>
> -    if (qiov) {
> -        assert(request->type == NBD_CMD_WRITE || request->type == NBD_CMD_READ);
> -        assert(request->len == iov_size(qiov->iov, qiov->niov));
> +    assert(request->type != NBD_CMD_READ);
> +    if (write_qiov) {
> +        assert(request->type == NBD_CMD_WRITE);
> +        assert(request->len == iov_size(write_qiov->iov, write_qiov->niov));
>       } else {
> -        assert(request->type != NBD_CMD_WRITE && request->type != NBD_CMD_READ);
> +        assert(request->type != NBD_CMD_WRITE);
>       }
> -    ret = nbd_co_send_request(bs, request,
> -                              request->type == NBD_CMD_WRITE ? qiov : NULL);
> +    ret = nbd_co_send_request(bs, request, write_qiov);
>       if (ret < 0) {
>           return ret;
>       }
>
> -    return nbd_co_receive_reply(client, request->handle,
> -                                request->type == NBD_CMD_READ ? qiov : NULL);
> +    ret = nbd_co_receive_return_code(client, request->handle, &local_err);
> +    if (local_err) {

hmm, you changed it from "if (ret < 0)"... It doesn't matter, just note 
that here (local_err != NULL) <=> (ret < 0).

> +        error_report_err(local_err);
> +    }
> +    return ret;
>   }

[...]


I'm ok with this, we can improve error handling later.


-- 
Best regards,
Vladimir
