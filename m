Received: from eggs.gnu.org ([2001:4830:134:3::10]:47004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1df5zm-000741-Bv
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1df5zl-0007ZD-2N
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:00:34 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:14784 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1df5zk-0007Qk-GF
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:00:33 -0400
References: <20170808142944.145159-1-vsementsov@virtuozzo.com>
	<a8eaea35-6959-e3ff-db0f-f7bf4448b61c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <61222882-0ed9-b591-f6cf-ba3dca69b25a@virtuozzo.com>
Date: Tue, 8 Aug 2017 18:00:13 +0300
MIME-Version: 1.0
In-Reply-To: <a8eaea35-6959-e3ff-db0f-f7bf4448b61c@redhat.com>
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
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

08.08.2017 17:44, Eric Blake wrote:
> On 08/08/2017 09:29 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Do not communicate after the first error to avoid communicating throught
>> broken channel. The only exclusion is try to send NBD_CMD_DISC anyway on
>> in nbd_client_close.
>>
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
> It may be possible to do something even smaller:
>
>>   block/nbd-client.h |  1 +
>>   block/nbd-client.c | 58 +++++++++++++++++++++++++++++++++++++-----------------
>>   2 files changed, 41 insertions(+), 18 deletions(-)
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
>>   } NBDClientSession;
>>   
>>   NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
>> diff --git a/block/nbd-client.c b/block/nbd-client.c
>> index 25dd28406b..1282b2484e 100644
>> --- a/block/nbd-client.c
>> +++ b/block/nbd-client.c
>> @@ -49,6 +49,8 @@ static void nbd_teardown_connection(BlockDriverState *bs)
>>   {
>>       NBDClientSession *client = nbd_get_client_session(bs);
>>   
>> +    client->eio_to_all = true;
>> +
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
> How is this conditional ever reached? nbd_read_reply_entry() is our
> workhorse, that is supposed to run until the client is ready to disconnect.

I forget to set eio_to_all on error in sending request.

>
>>           assert(s->reply.handle == 0);
>>           ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
>>           if (ret < 0) {
>>               error_report_err(local_err);
>>           }
>> -        if (ret <= 0) {
>> +        if (ret <= 0 || s->eio_to_all) {
>>               break;
>>           }
> This says we're now supposed to break out of the while loop.  So unless
> something can set s->eio_to_all during
> aio_co_wake(s->recv_coroutine[i]), the next iteration of the loop won't
> hit the first conditional.
>
> Meanwhile, even if we skip the first conditional, this second
> conditional will still end the loop prior to acting on anything received
> from the server (the difference being whether we called
> nbd_receive_reply() one additional time, but I don't see that as getting
> in the way of a clean exit).
>
> But my question is whether we can just go with a simpler fix: if we ever
> break out of the workhorse loop of nbd_read_reply_entry(), then (and
> only then) is when we call nbd_recv_coroutines_enter_all() to mop up any
> pending transactions before tearing down the coroutines.  Is there
> something we can do in nbd_recv_coroutines_enter_all() that will
> guarantee that our final entry into each coroutine will fail?

anyway, you should prevent the following new requests, using some 
additional variable or disconnect..

Also, I think, an error in sending requests should cause finishing of 
this loop in nbd_read_reply_entry, so, an error condition should be 
checked after each yield.


>
> I'm still playing with the idea locally.
>

-- 
Best regards,
Vladimir
