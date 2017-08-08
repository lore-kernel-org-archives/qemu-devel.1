Received: from eggs.gnu.org ([2001:4830:134:3::10]:60870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1df5bX-00020E-BB
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1df5bV-0001UM-QY
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:35:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:2420 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1df5bV-0001Mn-8R
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:35:29 -0400
References: <20170808142944.145159-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1e1da46c-f4c2-a367-1a51-8e7db2696e9a@virtuozzo.com>
Date: Tue, 8 Aug 2017 17:35:16 +0300
MIME-Version: 1.0
In-Reply-To: <20170808142944.145159-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for 2.10] block/nbd-client: always return
 EIO on and after the first io channel error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org

08.08.2017 17:29, Vladimir Sementsov-Ogievskiy wrote:
> Do not communicate after the first error to avoid communicating throught
> broken channel. The only exclusion is try to send NBD_CMD_DISC anyway on
> in nbd_client_close.

worth add: To simplify things, return -EIO in case of disconnect too.

(refers to:

-    if (!s->ioc) {
+    if (s->eio_to_all) {
          qemu_co_mutex_unlock(&s->send_mutex);
-        return -EPIPE;
+        return -EIO;
      }

and to:

@@ -49,6 +49,8 @@ static void nbd_teardown_connection(BlockDriverState *bs)
  {
      NBDClientSession *client = nbd_get_client_session(bs);
  
+    client->eio_to_all = true;
+

However, I'm unsure about, how s->ioc may be NULL in first chunk, and if 
it possible, why
it is not checked everywhere. read/write after bdrv_close? Should it be 
handled on higher level?)

>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>
> Hi all. Here is a patch, fixing a problem noted in
> [PATCH 06/17] block/nbd-client: fix nbd_read_reply_entry
> and
> [PATCH 17/17] block/nbd-client: always return EIO on and after the first io channel error
> and discussed on list.
>
> If it will be applied to 2.10, then I'll rebase my 'nbd client refactoring and fixing'
> on it (for 2.11). If not - I'll prefer not rebase the series, so, do not apply this
> patch for 2.11.
>
>   block/nbd-client.h |  1 +
>   block/nbd-client.c | 58 +++++++++++++++++++++++++++++++++++++-----------------
>   2 files changed, 41 insertions(+), 18 deletions(-)
>
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index df80771357..28db9922c8 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -29,6 +29,7 @@ typedef struct NBDClientSession {
>   
>       Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
>       NBDReply reply;
> +    bool eio_to_all;
>   } NBDClientSession;
>   
>   NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 25dd28406b..1282b2484e 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -49,6 +49,8 @@ static void nbd_teardown_connection(BlockDriverState *bs)
>   {
>       NBDClientSession *client = nbd_get_client_session(bs);
>   
> +    client->eio_to_all = true;
> +
>       if (!client->ioc) { /* Already closed */
>           return;
>       }
> @@ -74,12 +76,16 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
>       Error *local_err = NULL;
>   
>       for (;;) {
> +        if (s->eio_to_all) {
> +            break;
> +        }
> +
>           assert(s->reply.handle == 0);
>           ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
>           if (ret < 0) {
>               error_report_err(local_err);
>           }
> -        if (ret <= 0) {
> +        if (ret <= 0 || s->eio_to_all) {
>               break;
>           }
>   
> @@ -107,6 +113,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
>           qemu_coroutine_yield();
>       }
>   
> +    s->eio_to_all = true;
>       nbd_recv_coroutines_enter_all(s);
>       s->read_reply_co = NULL;
>   }
> @@ -118,6 +125,10 @@ static int nbd_co_send_request(BlockDriverState *bs,
>       NBDClientSession *s = nbd_get_client_session(bs);
>       int rc, ret, i;
>   
> +    if (s->eio_to_all) {
> +        return -EIO;
> +    }
> +
>       qemu_co_mutex_lock(&s->send_mutex);
>       while (s->in_flight == MAX_NBD_REQUESTS) {
>           qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
> @@ -135,15 +146,15 @@ static int nbd_co_send_request(BlockDriverState *bs,
>       assert(i < MAX_NBD_REQUESTS);
>       request->handle = INDEX_TO_HANDLE(s, i);
>   
> -    if (!s->ioc) {
> +    if (s->eio_to_all) {
>           qemu_co_mutex_unlock(&s->send_mutex);
> -        return -EPIPE;
> +        return -EIO;
>       }
>   
>       if (qiov) {
>           qio_channel_set_cork(s->ioc, true);
>           rc = nbd_send_request(s->ioc, request);
> -        if (rc >= 0) {
> +        if (rc >= 0 && !s->eio_to_all) {
>               ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, false,
>                             NULL);
>               if (ret != request->len) {
> @@ -155,7 +166,8 @@ static int nbd_co_send_request(BlockDriverState *bs,
>           rc = nbd_send_request(s->ioc, request);
>       }
>       qemu_co_mutex_unlock(&s->send_mutex);
> -    return rc;
> +
> +    return s->eio_to_all ? -EIO : rc;
>   }
>   
>   static void nbd_co_receive_reply(NBDClientSession *s,
> @@ -169,13 +181,13 @@ static void nbd_co_receive_reply(NBDClientSession *s,
>       qemu_coroutine_yield();
>       *reply = s->reply;
>       if (reply->handle != request->handle ||
> -        !s->ioc) {
> +        !s->ioc || s->eio_to_all) {
>           reply->error = EIO;
>       } else {
>           if (qiov && reply->error == 0) {
>               ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, true,
>                             NULL);
> -            if (ret != request->len) {
> +            if (ret != request->len || s->eio_to_all) {
>                   reply->error = EIO;
>               }
>           }
> @@ -225,8 +237,10 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
>       } else {
>           nbd_co_receive_reply(client, &request, &reply, qiov);
>       }
> -    nbd_coroutine_end(bs, &request);
> -    return -reply.error;
> +    if (request.handle != 0) {
> +        nbd_coroutine_end(bs, &request);
> +    }
> +    return client->eio_to_all ? -EIO : -reply.error;
>   }
>   
>   int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
> @@ -254,8 +268,10 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
>       } else {
>           nbd_co_receive_reply(client, &request, &reply, NULL);
>       }
> -    nbd_coroutine_end(bs, &request);
> -    return -reply.error;
> +    if (request.handle != 0) {
> +        nbd_coroutine_end(bs, &request);
> +    }
> +    return client->eio_to_all ? -EIO : -reply.error;
>   }
>   
>   int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
> @@ -288,8 +304,10 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
>       } else {
>           nbd_co_receive_reply(client, &request, &reply, NULL);
>       }
> -    nbd_coroutine_end(bs, &request);
> -    return -reply.error;
> +    if (request.handle != 0) {
> +        nbd_coroutine_end(bs, &request);
> +    }
> +    return client->eio_to_all ? -EIO : -reply.error;
>   }
>   
>   int nbd_client_co_flush(BlockDriverState *bs)
> @@ -312,8 +330,10 @@ int nbd_client_co_flush(BlockDriverState *bs)
>       } else {
>           nbd_co_receive_reply(client, &request, &reply, NULL);
>       }
> -    nbd_coroutine_end(bs, &request);
> -    return -reply.error;
> +    if (request.handle != 0) {
> +        nbd_coroutine_end(bs, &request);
> +    }
> +    return client->eio_to_all ? -EIO : -reply.error;
>   }
>   
>   int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
> @@ -337,9 +357,10 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
>       } else {
>           nbd_co_receive_reply(client, &request, &reply, NULL);
>       }
> -    nbd_coroutine_end(bs, &request);
> -    return -reply.error;
> -
> +    if (request.handle != 0) {
> +        nbd_coroutine_end(bs, &request);
> +    }
> +    return client->eio_to_all ? -EIO : -reply.error;
>   }
>   
>   void nbd_client_detach_aio_context(BlockDriverState *bs)
> @@ -384,6 +405,7 @@ int nbd_client_init(BlockDriverState *bs,
>       logout("session init %s\n", export);
>       qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
>   
> +    client->eio_to_all = false;
>       client->info.request_sizes = true;
>       ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
>                                   tlscreds, hostname,


-- 
Best regards,
Vladimir
