Received: from eggs.gnu.org ([2001:4830:134:3::10]:57282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT6lm-0006NP-KW
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT6lj-0005K5-FD
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:52:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cT6lj-0005Jm-6k
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:52:15 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C7991555C
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 12:52:15 +0000 (UTC)
Date: Mon, 16 Jan 2017 20:52:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170116125208.GF14226@lemon.Home>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-7-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/16] nbd: do not block on partial reply
 header reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Fri, 01/13 14:17, Paolo Bonzini wrote:
> Read the replies from a coroutine, switching the read side between the
> "read header" coroutine and the I/O coroutine that reads the body of
> the reply.
> 
> qio_channel_yield is used so that the right coroutine is restarted
> automatically, eliminating the need for send_coroutine in
> NBDClientSession.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nbd-client.c | 108 +++++++++++++++++++++--------------------------------
>  block/nbd-client.h |   2 +-
>  nbd/client.c       |   2 +-
>  nbd/common.c       |   9 +----
>  4 files changed, 45 insertions(+), 76 deletions(-)
> 
> @@ -65,54 +67,34 @@ static void nbd_teardown_connection(BlockDriverState *bs)
>      client->ioc = NULL;
>  }
>  
> -static void nbd_reply_ready(void *opaque)
> +static void nbd_read_reply_entry(void *opaque)
>  {
> -    BlockDriverState *bs = opaque;
> -    NBDClientSession *s = nbd_get_client_session(bs);
> +    NBDClientSession *s = opaque;
>      uint64_t i;
>      int ret;
>  
> -    if (!s->ioc) { /* Already closed */
> -        return;
> -    }
> -
> -    if (s->reply.handle == 0) {
> -        /* No reply already in flight.  Fetch a header.  It is possible
> -         * that another thread has done the same thing in parallel, so
> -         * the socket is not readable anymore.
> -         */
> +    for (;;) {
> +        assert(s->reply.handle == 0);
>          ret = nbd_receive_reply(s->ioc, &s->reply);
> -        if (ret == -EAGAIN) {
> -            return;
> -        }
>          if (ret < 0) {
> -            s->reply.handle = 0;
> -            goto fail;
> +            break;
>          }
> -    }
> -
> -    /* There's no need for a mutex on the receive side, because the
> -     * handler acts as a synchronization point and ensures that only
> -     * one coroutine is called until the reply finishes.  */
> -    i = HANDLE_TO_INDEX(s, s->reply.handle);
> -    if (i >= MAX_NBD_REQUESTS) {
> -        goto fail;
> -    }
>  
> -    if (s->recv_coroutine[i]) {
> -        qemu_coroutine_enter(s->recv_coroutine[i]);
> -        return;
> -    }
> -
> -fail:
> -    nbd_teardown_connection(bs);
> -}
> +        /* There's no need for a mutex on the receive side, because the
> +         * handler acts as a synchronization point and ensures that only
> +         * one coroutine is called until the reply finishes.
> +         */
> +        i = HANDLE_TO_INDEX(s, s->reply.handle);
> +        if (i >= MAX_NBD_REQUESTS || !s->recv_coroutine[i]) {
> +            break;
> +        }
>  
> -static void nbd_restart_write(void *opaque)
> -{
> -    BlockDriverState *bs = opaque;
> +        aio_co_wake(s->recv_coroutine[i]);
>  
> -    qemu_coroutine_enter(nbd_get_client_session(bs)->send_coroutine);
> +        /* We're woken up by the recv_coroutine itself.  */

"Wait until we're woken by ..." ?

> +        qemu_coroutine_yield();
> +    }
> +    s->read_reply_co = NULL;
>  }
>  
>  static int nbd_co_send_request(BlockDriverState *bs,
> @@ -120,7 +102,6 @@ static int nbd_co_send_request(BlockDriverState *bs,
>                                 QEMUIOVector *qiov)
>  {
>      NBDClientSession *s = nbd_get_client_session(bs);
> -    AioContext *aio_context;
>      int rc, ret, i;
>  
>      qemu_co_mutex_lock(&s->send_mutex);
> @@ -141,11 +122,6 @@ static int nbd_co_send_request(BlockDriverState *bs,
>          return -EPIPE;
>      }
>  
> -    s->send_coroutine = qemu_coroutine_self();
> -    aio_context = bdrv_get_aio_context(bs);
> -
> -    aio_set_fd_handler(aio_context, s->sioc->fd, false,
> -                       nbd_reply_ready, nbd_restart_write, NULL, bs);
>      if (qiov) {
>          qio_channel_set_cork(s->ioc, true);
>          rc = nbd_send_request(s->ioc, request);
> @@ -160,9 +136,6 @@ static int nbd_co_send_request(BlockDriverState *bs,
>      } else {
>          rc = nbd_send_request(s->ioc, request);
>      }
> -    aio_set_fd_handler(aio_context, s->sioc->fd, false,
> -                       nbd_reply_ready, NULL, NULL, bs);
> -    s->send_coroutine = NULL;
>      qemu_co_mutex_unlock(&s->send_mutex);
>      return rc;
>  }
> @@ -174,8 +147,7 @@ static void nbd_co_receive_reply(NBDClientSession *s,
>  {
>      int ret;
>  
> -    /* Wait until we're woken up by the read handler.  TODO: perhaps
> -     * peek at the next reply and avoid yielding if it's ours?  */
> +    /* Wait until we're woken up by nbd_read_reply_entry.  */
>      qemu_coroutine_yield();
>      *reply = s->reply;
>      if (reply->handle != request->handle ||
> @@ -209,14 +181,18 @@ static void nbd_coroutine_start(NBDClientSession *s,
>      /* s->recv_coroutine[i] is set as soon as we get the send_lock.  */
>  }
>  
> -static void nbd_coroutine_end(NBDClientSession *s,
> +static void nbd_coroutine_end(BlockDriverState *bs,
>                                NBDRequest *request)
>  {
> +    NBDClientSession *s = nbd_get_client_session(bs);
>      int i = HANDLE_TO_INDEX(s, request->handle);
> +
>      s->recv_coroutine[i] = NULL;
> -    if (s->in_flight-- == MAX_NBD_REQUESTS) {
> -        qemu_co_queue_next(&s->free_sema);
> -    }
> +    s->in_flight--;
> +    qemu_co_queue_next(&s->free_sema);
> +
> +    /* Kick the read_reply_co to get the next reply.  */
> +    aio_co_wake(s->read_reply_co);

Can't s->read_reply_co be NULL? nbd_read_reply_entry unsets it. (Surprisingly
this file is rather unfamiliar to me, it's possible I'm missing something.)

>  }
>  
>  int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
>  void nbd_client_attach_aio_context(BlockDriverState *bs,
>                                     AioContext *new_context)
>  {
> -    aio_set_fd_handler(new_context, nbd_get_client_session(bs)->sioc->fd,
> -                       false, nbd_reply_ready, NULL, NULL, bs);
> +    NBDClientSession *client = nbd_get_client_session(bs);
> +    qio_channel_set_aio_context(QIO_CHANNEL(client->sioc), new_context);
> +    aio_co_schedule(new_context, client->read_reply_co);

Like above, is client->read_reply_co possibly NULL?

>  }
>  
>  void nbd_client_close(BlockDriverState *bs)
> @@ -434,7 +410,7 @@ int nbd_client_init(BlockDriverState *bs,
>      /* Now that we're connected, set the socket to be non-blocking and
>       * kick the reply mechanism.  */
>      qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
> -
> +    client->read_reply_co = qemu_coroutine_create(nbd_read_reply_entry, client);
>      nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
>  
>      logout("Established connection with NBD server\n");
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index f8d6006..8cdfc92 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -25,7 +25,7 @@ typedef struct NBDClientSession {
>  
>      CoMutex send_mutex;
>      CoQueue free_sema;
> -    Coroutine *send_coroutine;
> +    Coroutine *read_reply_co;
>      int in_flight;
>  
>      Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
> diff --git a/nbd/client.c b/nbd/client.c
> index ffb0743..5c9dee3 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -778,7 +778,7 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
>      ssize_t ret;
>  
>      ret = read_sync(ioc, buf, sizeof(buf));
> -    if (ret < 0) {
> +    if (ret <= 0) {

Not sure why this belongs to this patch, but it also looks harmless.

>          return ret;
>      }
>  

Fam
