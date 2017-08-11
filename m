Received: from eggs.gnu.org ([2001:4830:134:3::10]:42031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dgBJR-0002oD-PW
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dgBJO-00076N-Mz
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:53:21 -0400
References: <20170811023759.26390-1-eblake@redhat.com>
	<20170811023759.26390-2-eblake@redhat.com>
	<29dc6e29-7bbc-2c81-22cc-61db4e8ac609@virtuozzo.com>
	<7d6be617-6907-5213-941b-38fe5d3f0fee@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c82b8803-c935-783c-9ff5-6c228d5a1138@virtuozzo.com>
Date: Fri, 11 Aug 2017 17:53:13 +0300
MIME-Version: 1.0
In-Reply-To: <7d6be617-6907-5213-941b-38fe5d3f0fee@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd: Drop connection if broken server
 is detected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

11.08.2017 17:15, Eric Blake wrote:
> On 08/11/2017 02:48 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 11.08.2017 05:37, Eric Blake wrote:
>>> As soon as the server is sending us garbage, we should quit
>>> trying to send further messages to the server, and allow all
>>> pending coroutines for any remaining replies to error out.
>>> Failure to do so can let a malicious server cause the client
>>> to hang, for example, if the server sends an invalid magic
>>> number in its response.
>>> @@ -107,8 +108,12 @@ static coroutine_fn void
>>> nbd_read_reply_entry(void *opaque)
>>>            qemu_coroutine_yield();
>>>        }
>>>
>>> +    s->reply.handle = 0;
>>>        nbd_recv_coroutines_enter_all(s);
>>>        s->read_reply_co = NULL;
>>> +    if (ret < 0) {
>>> +        nbd_teardown_connection(bs);
>>> +    }
>> what if it happens in parallel with nbd_co_send_request?
>> nbd_teardown_connectin destroys s->ioc, nbd_co_send_requests
>> checks s->ioc only once and then calls nbd_send_request (which is
>> finally nbd_rwv and may yield). I think nbd_rwv is not
>> prepared to sudden destruction of ioc..
> The nbd_recv_coroutines_enter_all() call schedules all pending
> nbd_co_send_request coroutines to fire as soon as the current coroutine
> reaches a yield point. The next yield point is during the
> BDRV_POLL_WHILE of nbd_teardown_connection - but this is AFTER we've
> called qio_channel_shutdown() - so as long as nbd_rwv() is called with a
> valid ioc, the qio code should recognize that we are shutting down the
> connection and gracefully give an error on each write attempt.


Hmm, was it correct even before your patch? Is it safe to enter a coroutine
(which we've scheduled by nbd_recv_coroutines_enter_all()), which is 
actually
yielded inside nbd_rwv (not our yield in nbd_co_receive_reply)?

>
> I see your point about the fact that coroutines can change hands in
> between our two writes for an NBD_CMD_WRITE in nbd_co_send_request()
> (the first write is nbd_send_request() for the header, the second is
> nbd_rwv() for the data) - if between those two writes we process a
> failing read, I see your point about us risking re-reading s->ioc as

But there are no yields between two writes, so, if previous logic is 
correct,
if the read fails during first write it will return and error and we 
will not go
into the second write. If it fails during the second write, it should be 
OK too.

> NULL for the second write call.  But maybe this is an appropriate fix -
> hanging on to the ioc that we learned when grabbing the send_mutex:
>
>
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 802d50b636..28b10f3fa2 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -122,6 +122,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
>   {
>       NBDClientSession *s = nbd_get_client_session(bs);
>       int rc, ret, i;
> +    QIOChannel *ioc;
>
>       qemu_co_mutex_lock(&s->send_mutex);
>       while (s->in_flight == MAX_NBD_REQUESTS) {
> @@ -139,25 +140,26 @@ static int nbd_co_send_request(BlockDriverState *bs,
>       g_assert(qemu_in_coroutine());
>       assert(i < MAX_NBD_REQUESTS);
>       request->handle = INDEX_TO_HANDLE(s, i);
> +    ioc = s->ioc;
>
> -    if (!s->ioc) {
> +    if (!ioc) {
>           qemu_co_mutex_unlock(&s->send_mutex);
>           return -EPIPE;
>       }
>
>       if (qiov) {
> -        qio_channel_set_cork(s->ioc, true);
> -        rc = nbd_send_request(s->ioc, request);
> +        qio_channel_set_cork(ioc, true);
> +        rc = nbd_send_request(ioc, request);
>           if (rc >= 0) {
> -            ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len,
> false,
> +            ret = nbd_rwv(ioc, qiov->iov, qiov->niov, request->len, false,
>                             NULL);
>               if (ret != request->len) {
>                   rc = -EIO;
>               }
>           }
> -        qio_channel_set_cork(s->ioc, false);
> +        qio_channel_set_cork(ioc, false);
>       } else {
> -        rc = nbd_send_request(s->ioc, request);
> +        rc = nbd_send_request(ioc, request);
>       }
>       qemu_co_mutex_unlock(&s->send_mutex);
>       return rc;
>
>
>
> But I'm really hoping Paolo will chime in on this thread.
>

-- 
Best regards,
Vladimir
