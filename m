Received: from eggs.gnu.org ([2001:4830:134:3::10]:56557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dtyCg-0007AA-W7
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dtyCf-0005tr-R9
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:43:23 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-4-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d554b537-54da-2a70-66c7-722f2c27f4da@redhat.com>
Date: Mon, 18 Sep 2017 17:43:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170918135935.255591-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] block/nbd-client: refactor reading
 reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org

On 18/09/2017 15:59, Vladimir Sementsov-Ogievskiy wrote:
> Read the whole reply in one place - in nbd_read_reply_entry.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.h |  1 +
>  block/nbd-client.c | 42 ++++++++++++++++++++++++------------------
>  2 files changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index b1900e6a6d..3f97d31013 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -21,6 +21,7 @@ typedef struct {
>      Coroutine *coroutine;
>      bool receiving;         /* waiting for read_reply_co? */
>      NBDRequest *request;
> +    QEMUIOVector *qiov;
>  } NBDClientRequest;
>  
>  typedef struct NBDClientSession {
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 5f241ecc22..f7b642f079 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -98,6 +98,21 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
>              break;
>          }
>  
> +        if (s->reply.error == 0 &&
> +            s->requests[i].request->type == NBD_CMD_READ)
> +        {
> +            QEMUIOVector *qiov = s->requests[i].qiov;
> +            assert(qiov != NULL);
> +            assert(s->requests[i].request->len ==
> +                   iov_size(qiov->iov, qiov->niov));
> +            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
> +                                      NULL) < 0)
> +            {
> +                s->reply.error = EIO;
> +                break;
> +            }
> +        }

I am not sure this is an improvement.  In principle you could have
commands that read replies a bit at a time without using a QEMUIOVector.

Paolo

>          /* We're woken up again by the request itself.  Note that there
>           * is no race between yielding and reentering read_reply_co.  This
>           * is because:
> @@ -118,6 +133,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
>      s->read_reply_co = NULL;
>  }
>  
> +/* qiov should be provided for READ and WRITE */
>  static int nbd_co_send_request(BlockDriverState *bs,
>                                 NBDRequest *request,
>                                 QEMUIOVector *qiov)
> @@ -145,6 +161,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
>  
>      request->handle = INDEX_TO_HANDLE(s, i);
>      s->requests[i].request = request;
> +    s->requests[i].qiov = qiov;
>  
>      if (s->quit) {
>          rc = -EIO;
> @@ -155,7 +172,8 @@ static int nbd_co_send_request(BlockDriverState *bs,
>          goto err;
>      }
>  
> -    if (qiov) {
> +    if (s->requests[i].request->type == NBD_CMD_WRITE) {
> +        assert(qiov);
>          qio_channel_set_cork(s->ioc, true);
>          rc = nbd_send_request(s->ioc, request);
>          if (rc >= 0 && !s->quit) {
> @@ -181,9 +199,7 @@ err:
>      return rc;
>  }
>  
> -static int nbd_co_receive_reply(NBDClientSession *s,
> -                                NBDRequest *request,
> -                                QEMUIOVector *qiov)
> +static int nbd_co_receive_reply(NBDClientSession *s, NBDRequest *request)
>  {
>      int ret;
>      int i = HANDLE_TO_INDEX(s, request->handle);
> @@ -197,14 +213,6 @@ static int nbd_co_receive_reply(NBDClientSession *s,
>      } else {
>          assert(s->reply.handle == request->handle);
>          ret = -s->reply.error;
> -        if (qiov && s->reply.error == 0) {
> -            assert(request->len == iov_size(qiov->iov, qiov->niov));
> -            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
> -                                      NULL) < 0) {
> -                ret = -EIO;
> -                s->quit = true;
> -            }
> -        }
>  
>          /* Tell the read handler to read another header.  */
>          s->reply.handle = 0;
> @@ -232,16 +240,14 @@ static int nbd_co_request(BlockDriverState *bs,
>      NBDClientSession *client = nbd_get_client_session(bs);
>      int ret;
>  
> -    assert(!qiov || request->type == NBD_CMD_WRITE ||
> -           request->type == NBD_CMD_READ);
> -    ret = nbd_co_send_request(bs, request,
> -                              request->type == NBD_CMD_WRITE ? qiov : NULL);
> +    assert((qiov == NULL) !=
> +           (request->type == NBD_CMD_WRITE || request->type == NBD_CMD_READ));
> +    ret = nbd_co_send_request(bs, request, qiov);
>      if (ret < 0) {
>          return ret;
>      }
>  
> -    return nbd_co_receive_reply(client, request,
> -                                request->type == NBD_CMD_READ ? qiov : NULL);
> +    return nbd_co_receive_reply(client, request);
>  }
>  
>  int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
> 
