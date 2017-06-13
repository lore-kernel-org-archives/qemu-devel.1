Received: from eggs.gnu.org ([2001:4830:134:3::10]:39220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKqBK-000557-Pn
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKqBH-0007Bd-Kw
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:04:46 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dKqBH-00079l-A1
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:04:43 -0400
Received: by mail-wr0-x244.google.com with SMTP id u101so32754152wrc.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 11:04:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170602150150.258222-1-vsementsov@virtuozzo.com>
	<20170602150150.258222-13-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51615829-c8d4-6773-43b6-7a07b2ea7dae@redhat.com>
Date: Tue, 13 Jun 2017 20:04:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170602150150.258222-13-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/12] nbd/server: refactor nbd_trip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, den@openvz.org



On 02/06/2017 17:01, Vladimir Sementsov-Ogievskiy wrote:
> - do not use 'goto error_reply' outside a switch to jump into the
>   middle of the switch's default case label
> - reduce code duplication
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

As a followup, maybe the switch statement can be extracted to its own
function.  This way the "goto reply" can be avoided.  I'll take a look.

Apart from this, the series looks good.  I'll queue it tomorrow.

Paolo


> ---
>  nbd/server.c | 53 ++++++++++++++++++++---------------------------------
>  1 file changed, 20 insertions(+), 33 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 209a3d4e1e..198eabe338 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1078,6 +1078,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>      NBDReply reply;
>      int ret;
>      int flags;
> +    int reply_data_len = 0;
>  
>      TRACE("Reading request.");
>      if (client->closing) {
> @@ -1090,7 +1091,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>      client->recv_coroutine = NULL;
>      nbd_client_receive_next_request(client);
>      if (ret == -EIO) {
> -        goto out;
> +        goto disconnect;
>      }
>  
>      reply.handle = request.handle;
> @@ -1098,7 +1099,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>  
>      if (ret < 0) {
>          reply.error = -ret;
> -        goto error_reply;
> +        goto reply;
>      }
>  
>      if (client->closing) {
> @@ -1119,7 +1120,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>              if (ret < 0) {
>                  LOG("flush failed");
>                  reply.error = -ret;
> -                goto error_reply;
> +                break;
>              }
>          }
>  
> @@ -1128,12 +1129,12 @@ static coroutine_fn void nbd_trip(void *opaque)
>          if (ret < 0) {
>              LOG("reading from file failed");
>              reply.error = -ret;
> -            goto error_reply;
> +            break;
>          }
>  
> +        reply_data_len = request.len;
>          TRACE("Read %" PRIu32" byte(s)", request.len);
> -        if (nbd_co_send_reply(req, &reply, request.len) < 0)
> -            goto out;
> +
>          break;
>      case NBD_CMD_WRITE:
>          TRACE("Request type is WRITE");
> @@ -1141,7 +1142,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>          if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
>              TRACE("Server is read-only, return error");
>              reply.error = EROFS;
> -            goto error_reply;
> +            break;
>          }
>  
>          TRACE("Writing to device");
> @@ -1155,21 +1156,16 @@ static coroutine_fn void nbd_trip(void *opaque)
>          if (ret < 0) {
>              LOG("writing to file failed");
>              reply.error = -ret;
> -            goto error_reply;
>          }
>  
> -        if (nbd_co_send_reply(req, &reply, 0) < 0) {
> -            goto out;
> -        }
>          break;
> -
>      case NBD_CMD_WRITE_ZEROES:
>          TRACE("Request type is WRITE_ZEROES");
>  
>          if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
>              TRACE("Server is read-only, return error");
>              reply.error = EROFS;
> -            goto error_reply;
> +            break;
>          }
>  
>          TRACE("Writing to device");
> @@ -1186,14 +1182,9 @@ static coroutine_fn void nbd_trip(void *opaque)
>          if (ret < 0) {
>              LOG("writing to file failed");
>              reply.error = -ret;
> -            goto error_reply;
>          }
>  
> -        if (nbd_co_send_reply(req, &reply, 0) < 0) {
> -            goto out;
> -        }
>          break;
> -
>      case NBD_CMD_DISC:
>          /* unreachable, thanks to special case in nbd_co_receive_request() */
>          abort();
> @@ -1206,9 +1197,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>              LOG("flush failed");
>              reply.error = -ret;
>          }
> -        if (nbd_co_send_reply(req, &reply, 0) < 0) {
> -            goto out;
> -        }
> +
>          break;
>      case NBD_CMD_TRIM:
>          TRACE("Request type is TRIM");
> @@ -1218,21 +1207,19 @@ static coroutine_fn void nbd_trip(void *opaque)
>              LOG("discard failed");
>              reply.error = -ret;
>          }
> -        if (nbd_co_send_reply(req, &reply, 0) < 0) {
> -            goto out;
> -        }
> +
>          break;
>      default:
>          LOG("invalid request type (%" PRIu32 ") received", request.type);
>          reply.error = EINVAL;
> -    error_reply:
> -        /* We must disconnect after NBD_CMD_WRITE if we did not
> -         * read the payload.
> -         */
> -        if (nbd_co_send_reply(req, &reply, 0) < 0 || !req->complete) {
> -            goto out;
> -        }
> -        break;
> +    }
> +
> +reply:
> +    /* We must disconnect after NBD_CMD_WRITE if we did not
> +     * read the payload.
> +     */
> +    if (nbd_co_send_reply(req, &reply, reply_data_len) < 0 || !req->complete) {
> +        goto disconnect;
>      }
>  
>      TRACE("Request/Reply complete");
> @@ -1242,7 +1229,7 @@ done:
>      nbd_client_put(client);
>      return;
>  
> -out:
> +disconnect:
>      nbd_request_put(req);
>      client_close(client);
>      nbd_client_put(client);
> 
