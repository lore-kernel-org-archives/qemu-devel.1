Received: from eggs.gnu.org ([2001:4830:134:3::10]:51961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fSkee-00055y-Qm
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fSked-0002cX-LU
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 10:52:16 -0400
References: <20180609153217.19683-1-vsementsov@virtuozzo.com>
	<20180609153217.19683-11-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f7d005f5-7804-85f9-4ff6-6b4cd49a9444@virtuozzo.com>
Date: Tue, 12 Jun 2018 17:51:59 +0300
MIME-Version: 1.0
In-Reply-To: <20180609153217.19683-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 10/11] block/nbd-client: nbd reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org

09.06.2018 18:32, Vladimir Sementsov-Ogievskiy wrote:
> Implement reconnect. To achieve this:
>
> 1. Move from quit bool variable to state. 4 states are introduced:
>     connecting-wait: means, that reconnecting is in progress, and there
>       were small number of reconnect attempts, so all requests are
>       waiting for the connection.
>     connecting-nowait: reconnecting is in progress, there were a lot of
>       attempts of reconnect, all requests will return errors.
>     connected: normal state
>     quit: exiting after fatal error or on close
>
> Possible transitions are:
>
>     * -> quit
>     connecting-* -> connected
>     connecting-wait -> connecting-nowait
>     connected -> connecting-wait
>
> 2. Implement reconnect in connection_co. So, in connecting-* mode,
>      connection_co, tries to reconnect every NBD_RECONNECT_NS.
>      Configuring of this parameter (as well as NBD_RECONNECT_ATTEMPTS,
>      which specifies bound of transition from connecting-wait to
>      connecting-nowait) may be done as a follow-up patch.
>
> 3. Retry nbd queries on channel error, if we are in connecting-wait
>      state.
>
> 4. In init, wait until for connection until transition to
>      connecting-nowait. So, NBD_RECONNECT_ATTEMPTS is a bound of fail
>      for initial connection too.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd-client.h |   2 +
>   block/nbd-client.c | 170 ++++++++++++++++++++++++++++++++++++++---------------
>   2 files changed, 123 insertions(+), 49 deletions(-)
>
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index 2561e1ea42..1249f2eb52 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -44,6 +44,8 @@ typedef struct NBDClientSession {
>       bool receiving;
>       int connect_status;
>       Error *connect_err;
> +    int connect_attempts;
> +    bool wait_in_flight;
>   
>       NBDClientRequest requests[MAX_NBD_REQUESTS];
>       NBDReply reply;
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index f22ed7f404..49b1f67047 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -41,10 +41,16 @@ static int nbd_client_connect(BlockDriverState *bs,
>                                 const char *hostname,
>                                 Error **errp);
>   
> -/* @ret would be used for reconnect in future */
>   static void nbd_channel_error(NBDClientSession *s, int ret)
>   {
> -    s->state = NBD_CLIENT_QUIT;
> +    if (ret == -EIO) {
> +        if (s->state == NBD_CLIENT_CONNECTED) {
> +            s->state = NBD_CLIENT_CONNECTING_WAIT;
> +            s->connect_attempts = 0;
> +        }
> +    } else {
> +        s->state = NBD_CLIENT_QUIT;
> +    }
>   }
>   
>   static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
> @@ -90,6 +96,19 @@ typedef struct NBDConnection {
>       uint64_t reconnect_timeout;
>   } NBDConnection;
>   
> +static bool nbd_client_connecting(NBDClientSession *client)
> +{
> +    return client->state == NBD_CLIENT_CONNECTING_WAIT ||
> +           client->state == NBD_CLIENT_CONNECTING_NOWAIT ||
> +           client->state == NBD_CLIENT_CONNECTING_INIT;
> +}
> +
> +static bool nbd_client_connecting_wait(NBDClientSession *client)
> +{
> +    return client->state == NBD_CLIENT_CONNECTING_WAIT ||
> +           client->state == NBD_CLIENT_CONNECTING_INIT;
> +}
> +
>   static coroutine_fn void nbd_connection_entry(void *opaque)
>   {
>       NBDConnection *con = opaque;
> @@ -98,26 +117,55 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
>       int ret = 0;
>       Error *local_err = NULL;
>   
> -    if (con->reconnect_attempts != 0) {
> -        error_setg(&s->connect_err, "Reconnect is not supported yet");
> -        s->connect_status = -EINVAL;
> -        nbd_channel_error(s, s->connect_status);
> -        return;
> -    }
> +    while (s->state != NBD_CLIENT_QUIT) {
> +        assert(s->reply.handle == 0);
>   
> -    s->connect_status = nbd_client_connect(con->bs, con->saddr,
> -                                           con->export, con->tlscreds,
> -                                           con->hostname, &s->connect_err);
> -    if (s->connect_status < 0) {
> -        nbd_channel_error(s, s->connect_status);
> -        return;
> -    }
> +        if (nbd_client_connecting(s)) {
> +            if (s->connect_attempts == con->reconnect_attempts) {
> +                s->state = NBD_CLIENT_CONNECTING_NOWAIT;
> +                qemu_co_queue_restart_all(&s->free_sema);
> +            }
>   
> -    /* successfully connected */
> -    s->state = NBD_CLIENT_CONNECTED;
> +            qemu_co_mutex_lock(&s->send_mutex);
> +
> +            while (s->in_flight > 0) {
> +                qemu_co_mutex_unlock(&s->send_mutex);
> +                nbd_recv_coroutines_wake_all(s);
> +                s->wait_in_flight = true;
> +                qemu_coroutine_yield();
> +                s->wait_in_flight = false;
> +                qemu_co_mutex_lock(&s->send_mutex);
> +            }
> +
> +            qemu_co_mutex_unlock(&s->send_mutex);
> +
> +            /* Now we are sure, that nobody accessing the channel now and nobody
> +             * will try to access the channel, until we set state to CONNECTED
> +             */
> +
> +            s->connect_status = nbd_client_connect(con->bs, con->saddr,
> +                                                   con->export, con->tlscreds,
> +                                                   con->hostname, &local_err);

previous s->ioc leaked here. closing previous connection needs more actions

> +            s->connect_attempts++;
> +            error_free(s->connect_err);
> +            s->connect_err = NULL;
> +            error_propagate(&s->connect_err, local_err);
> +            local_err = NULL;
> +            if (s->connect_status == -EINVAL) {
> +                /* Protocol error or something like this */
> +                nbd_channel_error(s, s->connect_status);
> +                continue;
> +            }
> +            if (s->connect_status < 0) {
> +                qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, con->reconnect_timeout);
> +                continue;
> +            }
> +
> +            /* successfully connected */
> +            s->state = NBD_CLIENT_CONNECTED;
> +            qemu_co_queue_restart_all(&s->free_sema);
> +        }
>   
> -    while (s->state != NBD_CLIENT_QUIT) {
> -        assert(s->reply.handle == 0);
>           s->receiving = true;
>           ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
>           s->receiving = false;
> @@ -158,6 +206,7 @@ stat



-- 
Best regards,
Vladimir
