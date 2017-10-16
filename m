Received: from eggs.gnu.org ([2001:4830:134:3::10]:43718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e437u-0003K8-VM
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e437q-0004Ul-2K
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:00:07 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-6-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b40d728c-3abc-7061-65b1-93033d6d6960@virtuozzo.com>
Date: Mon, 16 Oct 2017 13:59:57 +0300
MIME-Version: 1.0
In-Reply-To: <20171015010131.12172-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 5/8] nbd/server: Include human-readable
 message in structured errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

15.10.2017 04:01, Eric Blake wrote:
> The NBD spec permits including a human-readable error string if
> structured replies are in force, so we might as well send the
> client the message that we logged on any error.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/server.c     | 22 ++++++++++++++++------
>   nbd/trace-events |  2 +-
>   2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/nbd/server.c b/nbd/server.c
> index 23dc6be708..8085d79076 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1289,23 +1289,25 @@ static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
>   static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
>                                                        uint64_t handle,
>                                                        uint32_t error,
> +                                                     char *msg,

it's not const because we want to put it into iov..
may be it is better to make it const and convert to (char *) like in 
qio_channel_write_all, to
1: more native message parameter type
2: allow constat strings like nbd_co_send_structured_error(..., "some 
error")

>                                                        Error **errp)
>   {
>       NBDStructuredError chunk;
>       int nbd_err = system_errno_to_nbd_errno(error);
>       struct iovec iov[] = {
>           {.iov_base = &chunk, .iov_len = sizeof(chunk)},
> -        /* FIXME: Support human-readable error message */
> +        {.iov_base = msg, .iov_len = strlen(msg)},
>       };

msg is always non-zero? so we don't want to send errors without 
message.. (1)

>
>       assert(nbd_err);
> -    trace_nbd_co_send_structured_error(handle, nbd_err);
> +    trace_nbd_co_send_structured_error(handle, nbd_err,
> +                                       nbd_err_lookup(nbd_err), msg);

it doesn't really matter, but "nbd_err_lookup(nbd_err)" is a bit 
unrelated and looks like part of previous patch

>       set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_ERROR, handle,
>                    sizeof(chunk) - sizeof(chunk.h));
>       stl_be_p(&chunk.error, nbd_err);
> -    stw_be_p(&chunk.message_length, 0);
> +    stw_be_p(&chunk.message_length, iov[1].iov_len);
>
> -    return nbd_co_send_iov(client, iov, 1, errp);
> +    return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);

but you allow messages of zero length..
it's ok, but looks a bit strange in connection with (1)

>   }
>
>   /* nbd_co_receive_request
> @@ -1406,6 +1408,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>       int flags;
>       int reply_data_len = 0;
>       Error *local_err = NULL;
> +    char *msg = NULL;
>
>       trace_nbd_trip();
>       if (client->closing) {
> @@ -1521,14 +1524,20 @@ reply:
>       if (local_err) {
>           /* If we get here, local_err was not a fatal error, and should be sent
>            * to the client. */
> +        assert(ret < 0);
> +        msg = g_strdup(error_get_pretty(local_err));
>           error_report_err(local_err);
>           local_err = NULL;
>       }
>
> -    if (client->structured_reply && request.type == NBD_CMD_READ) {
> +    if (client->structured_reply &&
> +        (ret < 0 || request.type == NBD_CMD_READ)) {
>           if (ret < 0) {
> +            if (!msg) {
> +                msg = g_strdup("");

I'd prefer to handle msg=NULL in nbd_co_send_structured_error instead of 
this.

> +            }
>               ret = nbd_co_send_structured_error(req->client, request.handle,
> -                                               -ret, &local_err);
> +                                               -ret, msg, &local_err);
>           } else {
>               ret = nbd_co_send_structured_read(req->client, request.handle,
>                                                 request.from, req->data,
> @@ -1539,6 +1548,7 @@ reply:
>                                          ret < 0 ? -ret : 0,
>                                          req->data, reply_data_len, &local_err);
>       }
> +    g_free(msg);
>       if (ret < 0) {
>           error_prepend(&local_err, "Failed to send reply: ");
>           goto disconnect;
> diff --git a/nbd/trace-events b/nbd/trace-events
> index 15a9294445..880f211c07 100644
> --- a/nbd/trace-events
> +++ b/nbd/trace-events
> @@ -57,7 +57,7 @@ nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients
>   nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p\n"
>   nbd_co_send_simple_reply(uint64_t handle, uint32_t error, const char *errname, int len) "Send simple reply: handle = %" PRIu64 ", error = %" PRIu32 " (%s), len = %d"
>   nbd_co_send_structured_read(uint64_t handle, uint64_t offset, void *data, size_t size) "Send structured read data reply: handle = %" PRIu64 ", offset = %" PRIu64 ", data = %p, len = %zu"
> -nbd_co_send_structured_error(uint64_t handle, int err) "Send structured error reply: handle = %" PRIu64 ", error = %d"
> +nbd_co_send_structured_error(uint64_t handle, int err, const char *errname, const char *msg) "Send structured error reply: handle = %" PRIu64 ", error = %d (%s), msg = '%s'"
>   nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
>   nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu32
>   nbd_co_receive_request_cmd_write(uint32_t len) "Reading %" PRIu32 " byte(s)"

anyway it should work, so, with or without my suggestions:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir
