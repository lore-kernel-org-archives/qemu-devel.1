Received: from eggs.gnu.org ([209.51.188.92]:40732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpYU-0005R6-Ne
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpYQ-0005DB-UQ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:30:20 -0500
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cb0d71c8-65fb-768e-7e5c-758de16d5d76@redhat.com>
Date: Mon, 18 Feb 2019 14:30:03 -0600
MIME-Version: 1.0
In-Reply-To: <20190218161822.3573-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/12] nbd: Restrict connection_co
 reentrance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On 2/18/19 10:18 AM, Kevin Wolf wrote:
> nbd_client_attach_aio_context() schedules connection_co in the new
> AioContext and this way reenters it in any arbitrary place that has
> yielded. We can restrict this a bit to the function call where the
> coroutine actually sits waiting when it's idle.
> 
> This doesn't solve any bug yet, but it shows where in the code we need
> to support this random reentrance and where we don't have to care.
> 
> Add FIXME comments for the existing bugs that the rest of this series
> will fix.

Wow, that's a lot of comments. Thanks for working on this.

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/nbd-client.h |  1 +
>  block/nbd-client.c | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/block/nbd-client.c
> @@ -76,8 +76,24 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
>      Error *local_err = NULL;
>  
>      while (!s->quit) {
> +        /*
> +         * The NBD client can only really be considered idle when it has
> +         * yielded from qio_channel_readv_all_eof(), waiting for data. This is
> +         * the point where the additional scheduled coroutine entry happens
> +         * after nbd_client_attach_aio_context().
> +         *
> +         * Therefore we keep an additional in_flight reference all the time and
> +         * only drop it temporarily here.
> +         *
> +         * FIXME This is not safe because the QIOChannel could wake up the
> +         * coroutine for a second time; it is not prepared for coroutine
> +         * resumption from external code.
> +         */
> +        bdrv_dec_in_flight(s->bs);
>          assert(s->reply.handle == 0);
>          ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
> +        bdrv_inc_in_flight(s->bs);
> +
>          if (local_err) {
>              trace_nbd_read_reply_entry_fail(ret, error_get_pretty(local_err));
>              error_free(local_err);
> @@ -116,6 +132,8 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
>  
>      s->quit = true;
>      nbd_recv_coroutines_wake_all(s);
> +    bdrv_dec_in_flight(s->bs);
> +
>      s->connection_co = NULL;
>      aio_wait_kick();
>  }
> @@ -970,6 +988,9 @@ void nbd_client_attach_aio_context(BlockDriverState *bs,
>  {
>      NBDClientSession *client = nbd_get_client_session(bs);
>      qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context);
> +
> +    /* FIXME Really need a bdrv_inc_in_flight() here, but the corresponding
> +     * bdrv_dec_in_flight() would have to be in QIOChannel code :-/ */
>      aio_co_schedule(new_context, client->connection_co);
>  }
>  
> @@ -1076,6 +1097,7 @@ static int nbd_client_connect(BlockDriverState *bs,
>       * kick the reply mechanism.  */
>      qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
>      client->connection_co = qemu_coroutine_create(nbd_connection_entry, client);
> +    bdrv_inc_in_flight(bs);
>      nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
>  
>      logout("Established connection with NBD server\n");
> @@ -1108,6 +1130,7 @@ int nbd_client_init(BlockDriverState *bs,
>  {
>      NBDClientSession *client = nbd_get_client_session(bs);
>  
> +    client->bs = bs;
>      qemu_co_mutex_init(&client->send_mutex);
>      qemu_co_queue_init(&client->free_sema);
>  
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
