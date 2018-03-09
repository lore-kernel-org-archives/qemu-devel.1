Received: from eggs.gnu.org ([2001:4830:134:3::10]:45886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euQOl-0001kY-SV
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euQOk-00017e-JH
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:21:59 -0500
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
	<20180308184636.178534-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f44dfa2c-ce40-70f6-cad4-e2982d2dfc75@redhat.com>
Date: Fri, 9 Mar 2018 16:21:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180308184636.178534-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] nbd/server: refactor nbd_trip:
 cmd_read and generic reply
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

On 03/08/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> nbd_trip has difficult logic of sending reply: it tries to use one
> code path for all replies. It is ok for simple replies, but is not
> comfortable for structured replies. Also, two types of error (and
> corresponding message in local_err) - fatal (leading to disconnect)
> and not-fatal (just to be sent to the client) are difficult to follow.
> 
> To make things a bit clearer, the following is done:
>   - split CMD_READ logic to separate function. It is the most difficult
>     command for now, and it is definitely cramped inside nbd_trip. Also,
>     it is difficult to follow CMD_READ logic, shared between
>     "case NBD_CMD_READ" and "if"s under "reply:" label.

Yay - I already admitted when adding sparse read replies that splitting 
the logic was weird.

>   - create separate helper function nbd_send_generic_reply() and use it
>     both in new nbd_do_cmd_read and for other command in nbd_trip instead

s/command/commands/

>     of common code-path under "reply:" label in nbd_trip. The helper
>     supports error message, so logic with local_err in nbd_trip is

s/supports/supports an/

>     simplified.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 164 ++++++++++++++++++++++++++++++++---------------------------
>   1 file changed, 88 insertions(+), 76 deletions(-)

Gains a few lines, but I think the end result is more legible.

> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 97b45a21fa..a2f5f73d52 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1520,6 +1520,70 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
>       return 0;
>   }
>   
> +/* Send simple reply without a payload or structured error

s/payload or/payload, or a /

> + * @error_msg is ignored if @ret >= 0 */

Maybe mention the return value (0 if connection is still live, -errno on 
failure to communicate to client)

> +static coroutine_fn int nbd_send_generic_reply(NBDClient *client,
> +                                               uint64_t handle,
> +                                               int ret,
> +                                               const char *error_msg,
> +                                               Error **errp)
> +{
> +    if (client->structured_reply && ret < 0) {
> +        return nbd_co_send_structured_error(client, handle, -ret, error_msg,
> +                                            errp);
> +    } else {
> +        return nbd_co_send_simple_reply(client, handle, ret < 0 ? -ret : 0,
> +                                        NULL, 0, errp);
> +    }
> +}
> +
> +/* Handle NBD_CMD_READ request.
> + * Return -errno if sending fails. Other errors are reported directly to the
> + * client as an error reply. */
> +static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
> +                                        uint8_t *data, Error **errp)
> +{

> +
>   /* Owns a reference to the NBDClient passed as opaque.  */
>   static coroutine_fn void nbd_trip(void *opaque)
>   {
> @@ -1529,7 +1593,6 @@ static coroutine_fn void nbd_trip(void *opaque)
>       NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
>       int ret;
>       int flags;
> -    int reply_data_len = 0;
>       Error *local_err = NULL;
>       char *msg = NULL;
>   
> @@ -1556,39 +1619,21 @@ static coroutine_fn void nbd_trip(void *opaque)
>       }
>   
>       if (ret < 0) {
> -        goto reply;
> +        /* It's not a -EIO, so, accordingly to nbd_co_receive_request()

It wasn't -EIO, so according to nbd_co_receive_request()

> +         * semantics, we should return the error to the client. */
> +        Error *export_err = local_err;
> +
> +        local_err = NULL;
> +        ret = nbd_send_generic_reply(client, request.handle, -EINVAL,
> +                                     error_get_pretty(export_err), &local_err);
> +        error_free(export_err);
> +
> +        goto replied;
>       }
>   
>       switch (request.type) {
>       case NBD_CMD_READ:

> -        reply_data_len = request.len;
> +        ret = nbd_do_cmd_read(client, &request, req->data, &local_err);
>   
>           break;

We could also collapse the empty line before break.

>       case NBD_CMD_WRITE:
> @@ -1598,9 +1643,8 @@ static coroutine_fn void nbd_trip(void *opaque)
>           }
>           ret = blk_pwrite(exp->blk, request.from + exp->dev_offset,
>                            req->data, request.len, flags);
> -        if (ret < 0) {
> -            error_setg_errno(&local_err, -ret, "writing to file failed");
> -        }
> +        ret = nbd_send_generic_reply(client, request.handle, ret,
> +                                     "writing to file failed", &local_err);

I like how this works out.

>   
>           break;
>       default:
> -        error_setg(&local_err, "invalid request type (%" PRIu32 ") received",
> -                   request.type);
> -        ret = -EINVAL;
> -    }
> -
> -reply:
> -    if (local_err) {
> -        /* If we get here, local_err was not a fatal error, and should be sent
> -         * to the client. */
> -        assert(ret < 0);
> -        msg = g_strdup(error_get_pretty(local_err));
> -        error_report_err(local_err);
> -        local_err = NULL;
> +        msg = g_strdup_printf("invalid request type (%" PRIu32 ") received",
> +                              request.type);
> +        ret = nbd_send_generic_reply(client, request.handle, -EINVAL, msg,
> +                                     &local_err);
> +        g_free(msg);

I wonder if nbd_send_generic_reply() would be any easier to use if it 
took varargs and formatted the argument.  But for now, this is okay.

Only comment and grammar tweaks, so
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
