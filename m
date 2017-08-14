Received: from eggs.gnu.org ([2001:4830:134:3::10]:42445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dh9yq-0003rL-Vu
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 03:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dh9yk-00005d-Ug
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 03:40:09 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:19620 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dh9yk-0008UJ-FL
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 03:40:02 -0400
References: <20170808152607.147691-1-vsementsov@virtuozzo.com>
	<6079e4c4-ae54-826f-8cb4-dbcd773ecf50@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <561af6b4-ca21-7118-e44d-2f12da1b23b8@virtuozzo.com>
Date: Mon, 14 Aug 2017 10:39:44 +0300
MIME-Version: 1.0
In-Reply-To: <6079e4c4-ae54-826f-8cb4-dbcd773ecf50@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 for 2.10] block/nbd-client: always
 return EIO on and after the first io channel error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

12.08.2017 01:28, Eric Blake wrote:
> On 08/08/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
>
> Initial review, I'm still playing with this one, and will reply again on
> Monday.
>
>> Do not communicate after the first error to avoid communicating throught
> s/throught/through a/
>
>> broken channel. The only exclusion is try to send NBD_CMD_DISC anyway on
>> in nbd_client_close.
> I think the exclusion is wrong - if we detected the server sending us
> garbage, we're probably better off disconnecting entirely rather than
> trying to assume that the server will give us a clean disconnect via
> NBD_CMD_DISC.

But we assume nothing, just send NBD_CMD_DISC and then disconnect. May 
be it'll help server a bit.
The only doubt: is it possible to hang on nbd_rwv because some fail in 
connection or server?

>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Hi all. Here is a patch, fixing a problem noted in
>> [PATCH 06/17] block/nbd-client: fix nbd_read_reply_entry
>> and
>> [PATCH 17/17] block/nbd-client: always return EIO on and after the first io channel error
>> and discussed on list.
>>
>> If it will be applied to 2.10, then I'll rebase my 'nbd client refactoring and fixing'
>> on it (for 2.11). If not - I'll prefer not rebase the series, so, do not apply this
>> patch for 2.11.
>>
>> v2: set eio_to_all in nbd_co_send_request and nbd_co_receive_reply in case of error
>>
>>   block/nbd-client.h |  1 +
>>   block/nbd-client.c | 65 +++++++++++++++++++++++++++++++++++++++---------------
>>   2 files changed, 48 insertions(+), 18 deletions(-)
>>
>> diff --git a/block/nbd-client.h b/block/nbd-client.h
>> index df80771357..28db9922c8 100644
>> --- a/block/nbd-client.h
>> +++ b/block/nbd-client.h
>> @@ -29,6 +29,7 @@ typedef struct NBDClientSession {
>>   
>>       Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
>>       NBDReply reply;
>> +    bool eio_to_all;
> Bikeshedding - I'm wondering if there is a better name; maybe 'error' or
> 'server_broken'?

current name also used for normal path shutdown, when reply read returns 
0 because of EOF.

>
>>   } NBDClientSession;
>>   
>>   NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
>> diff --git a/block/nbd-client.c b/block/nbd-client.c
>> index 25dd28406b..a72cb7690a 100644
>> --- a/block/nbd-client.c
>> +++ b/block/nbd-client.c
>> @@ -49,6 +49,8 @@ static void nbd_teardown_connection(BlockDriverState *bs)
>>   {
>>       NBDClientSession *client = nbd_get_client_session(bs);
>>   
>> +    client->eio_to_all = true;
>> +
> Okay, if you set it here, then it does NOT mean 'server_broken' - and if
> we reached this spot normally, we still WANT the NBD_CMD_DISC.  So do we
> really need to set it here?

and NBD_CMD_DISC is an exception

>
>>       if (!client->ioc) { /* Already closed */
>>           return;
>>       }
>> @@ -74,12 +76,16 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
>>       Error *local_err = NULL;
>>   
>>       for (;;) {
>> +        if (s->eio_to_all) {
>> +            break;
>> +        }
>> +
>>           assert(s->reply.handle == 0);
>>           ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
>>           if (ret < 0) {
>>               error_report_err(local_err);
>>           }
>> -        if (ret <= 0) {
>> +        if (ret <= 0 || s->eio_to_all) {
> I'm still wondering if we need this condition at two points in the loop,
> or if merely checking at the beginning of the cycle is sufficient (like
> I said in my counterproposal thread, I'll be hammering away at your
> patch under gdb over the weekend, to see if I can trigger all the
> additions under some situation).

the check should be done after each possible yield, in a start of the 
loop it after last yield of the loop.

>
>>               break;
>>           }
>>   
>> @@ -107,6 +113,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
>>           qemu_coroutine_yield();
>>       }
>>   
>> +    s->eio_to_all = true;
> I think this one should be guarded by 'if (ret < 0)' - we also break out
> of the for loop when ret == 0 (aka EOF because the server ended
> cleanly), which is not the same as the server sending us garbage.

but my idea was to use eio_to_all in this case too, so it is not called 
server_error.

>
>>       nbd_recv_coroutines_enter_all(s);
>>       s->read_reply_co = NULL;
>>   }
>> @@ -118,6 +125,10 @@ static int nbd_co_send_request(BlockDriverState *bs,
>>       NBDClientSession *s = nbd_get_client_session(bs);
>>       int rc, ret, i;
>>   
>> +    if (s->eio_to_all) {
>> +        return -EIO;
>> +    }
>> +
> This one is good.
>
>>       qemu_co_mutex_lock(&s->send_mutex);
>>       while (s->in_flight == MAX_NBD_REQUESTS) {
>>           qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
>> @@ -135,15 +146,15 @@ static int nbd_co_send_request(BlockDriverState *bs,
>>       assert(i < MAX_NBD_REQUESTS);
>>       request->handle = INDEX_TO_HANDLE(s, i);
>>   
>> -    if (!s->ioc) {
>> +    if (s->eio_to_all) {
>>           qemu_co_mutex_unlock(&s->send_mutex);
>> -        return -EPIPE;
>> +        return -EIO;
>>       }
> I don't know if changing the errno is wise; maybe we want to keep both
> conditions (the !s->ioc and the s->eio_to_all) - especially if we only
> set eio_to_all on an actual detection of server garbage rather than on
> all exit paths.

I think it is ok for all exit paths, otherwise we should carefully 
declare in which cases
we return EIO and in which EPIPE, and spread this difference to the 
whole file.

>
>>   
>>       if (qiov) {
>>           qio_channel_set_cork(s->ioc, true);
>>           rc = nbd_send_request(s->ioc, request);
>> -        if (rc >= 0) {
>> +        if (rc >= 0 && !s->eio_to_all) {
>>               ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, false,
>>                             NULL);
>>               if (ret != request->len) {
>> @@ -155,7 +166,13 @@ static int nbd_co_send_request(BlockDriverState *bs,
>>           rc = nbd_send_request(s->ioc, request);
>>       }
>>       qemu_co_mutex_unlock(&s->send_mutex);
>> -    return rc;
>> +
>> +    if (rc < 0 || s->eio_to_all) {
>> +        s->eio_to_all = true;
>> +        return -EIO;
> I think this one makes sense.
>
>> +    }
>> +
>> +    return 0;
>>   }
>>   
>>   static void nbd_co_receive_reply(NBDClientSession *s,
>> @@ -169,14 +186,16 @@ static void nbd_co_receive_reply(NBDClientSession *s,
>>       qemu_coroutine_yield();
>>       *reply = s->reply;
>>       if (reply->handle != request->handle ||
>> -        !s->ioc) {
>> +        !s->ioc || s->eio_to_all) {
>>           reply->error = EIO;
>> +        s->eio_to_all = true;
>>       } else {
>>           if (qiov && reply->error == 0) {
>>               ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, true,
>>                             NULL);
>> -            if (ret != request->len) {
>> +            if (ret != request->len || s->eio_to_all) {
>>                   reply->error = EIO;
>> +                s->eio_to_all = true;
>>               }
> This may be redundant with setting eio_to_all in nbd_read_reply_entry.

it may prevent nbd_read_reply_entry trying to read after error on write

>
>>           }
>>   
>> @@ -225,8 +244,10 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
>>       } else {
>>           nbd_co_receive_reply(client, &request, &reply, qiov);
>>       }
>> -    nbd_coroutine_end(bs, &request);
>> -    return -reply.error;
>> +    if (request.handle != 0) {
>> +        nbd_coroutine_end(bs, &request);
>> +    }
> I'm not sure about this one - don't we always need to call
> nbd_coroutine_end for resource cleanup, even when we detected an error?

it is for early-error-exit from nbd_co_send_request, which is introduced 
in this patch

>
>> @@ -384,6 +412,7 @@ int nbd_client_init(BlockDriverState *bs,
>>       logout("session init %s\n", export);
>>       qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
>>   
>> +    client->eio_to_all = false;
> This one happens by default since we zero-initialize, but explicit
> initialization doesn't hurt.

I'm unsure about some kind 'reopens', so I've added this paranoic 
assignment.

>
>>       client->info.request_sizes = true;
>>       ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
>>                                   tlscreds, hostname,
>>

-- 
Best regards,
Vladimir
