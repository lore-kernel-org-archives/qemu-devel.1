Received: from eggs.gnu.org ([2001:4830:134:3::10]:36488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dx9E2-0007Jn-Um
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dx9Dw-00058I-VV
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:05:54 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:33828 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dx9Dw-00056f-Bu
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:05:48 -0400
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
	<20170925135801.144261-9-vsementsov@virtuozzo.com>
	<b8b01f1a-6e7b-342f-02b6-b7386bff1500@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a86f5324-231f-5072-f843-095c8b191fe1@virtuozzo.com>
Date: Wed, 27 Sep 2017 13:05:38 +0300
MIME-Version: 1.0
In-Reply-To: <b8b01f1a-6e7b-342f-02b6-b7386bff1500@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 8/8] nbd: Minimal structured read for client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

26.09.2017 01:19, Eric Blake wrote:
> On 09/25/2017 08:58 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal implementation: drop most of additional error information.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/nbd-client.h  |   2 +
>>   include/block/nbd.h |  15 ++++-
>>   block/nbd-client.c  |  97 +++++++++++++++++++++++++-----
>>   nbd/client.c        | 169 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>   4 files changed, 249 insertions(+), 34 deletions(-)
>>
>> +++ b/include/block/nbd.h
>> @@ -57,11 +57,17 @@ struct NBDRequest {
>>   };
>>   typedef struct NBDRequest NBDRequest;
>>   
>> -struct NBDReply {
>> +typedef struct NBDReply {
>> +    bool simple;
>>       uint64_t handle;
>>       uint32_t error;
>> -};
>> -typedef struct NBDReply NBDReply;
>> +
>> +    uint16_t flags;
>> +    uint16_t type;
>> +    uint32_t tail_length;
>> +    uint64_t offset;
>> +    uint32_t hole_size;
>> +} NBDReply;
> This feels like it should be a discriminated union, rather than a struct
> containing fields that are only sometimes valid...

No:

simple, handle and error are always valid
flags, type, tail_length are valid for all structured replies
offset and hole_size are valid for structured hole reply

so, we have one case when all fields are valid.. how do you see it with 
union, what is the real difference? I think it would be just a complication.

>
>>   
>>   #define NBD_SREP_TYPE_NONE          0
>>   #define NBD_SREP_TYPE_OFFSET_DATA   1
>> +#define NBD_SREP_TYPE_OFFSET_HOLE   2
>>   #define NBD_SREP_TYPE_ERROR         NBD_SREP_ERR(1)
>> +#define NBD_SREP_TYPE_ERROR_OFFSET  NBD_SREP_ERR(2)
> ...especially since there is more than one type of SREP packet layout.
>
> I also wonder why you are defining constants in a piecemeal fashion,
> rather than all at once (even if your minimal server implementation
> doesn't send a particular constant, there's no harm in defining them all
> up front).

hmm. just to not define unused constants. It doesn't matter, I can 
define them all if you prefer.

>
>> +++ b/block/nbd-client.c
>> @@ -179,9 +179,10 @@ err:
>>       return rc;
>>   }
>>   
>> -static int nbd_co_receive_reply(NBDClientSession *s,
>> -                                uint64_t handle,
>> -                                QEMUIOVector *qiov)
>> +static int nbd_co_receive_1_reply_or_chunk(NBDClientSession *s,
> Long name, and unusual to mix in "1" instead of "one".  Would it be
> better to name it nbd_co_receive_chunk, where we declare that a simple
> reply is (roughly) the same amount of effort as a chunk in a structured
> reply?
>
>> +                                           uint64_t handle,
>> +                                           bool *cont,
>> +                                           QEMUIOVector *qiov)
>>   {
> No documentation of the function?
>
>>       int ret;
>>       int i = HANDLE_TO_INDEX(s, handle);
>> @@ -191,29 +192,95 @@ static int nbd_co_receive_reply(NBDClientSession *s,
>>       qemu_coroutine_yield();
>>       s->requests[i].receiving = false;
>>       if (!s->ioc || s->quit) {
>> -        ret = -EIO;
>> -    } else {
>> -        assert(s->reply.handle == handle);
>> -        ret = -s->reply.error;
>> -        if (qiov && s->reply.error == 0) {
>> +        *cont = false;
>> +        return -EIO;
>> +    }
>> +
>> +    assert(s->reply.handle == handle);
>> +    *cont = !(s->reply.simple || (s->reply.flags & NBD_SREP_FLAG_DONE));
> We need to validate that the server is not sending us SREP chunks unless
> we negotiated them.  I'm thinking it might be better to do it here
> (maybe you did it somewhere else, but I haven't seen it yet; I'm
> reviewing the patch in textual order rather than the order in which
> things are called).

No, I didn't. Will add (may be early, in reply_entry).

>
>> +    ret = -s->reply.error;
>> +    if (ret < 0) {
>> +        goto out;
>> +    }
>> +
>> +    if (s->reply.simple) {
>> +        if (qiov) {
>>               if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
>> -                                      NULL) < 0) {
>> -                ret = -EIO;
>> -                s->quit = true;
>> +                                      NULL) < 0)
>> +            {
>> +                goto fatal;
>>               }
>>           }
>> +        goto out;
>> +    }
>>   
>> -        /* Tell the read handler to read another header.  */
>> -        s->reply.handle = 0;
>> +    /* here we deal with successful structured reply */
>> +    switch (s->reply.type) {
>> +        QEMUIOVector sub_qiov;
>> +    case NBD_SREP_TYPE_OFFSET_DATA:
> This is putting a LOT of smarts directly into the receive routine.
> Here's where I was previously wondering (and I think Paolo as well)
> whether it might be better to split the efforts: the generic function
> reads off the chunk information and any payload, but a per-command

Hmm. it was my idea to move all reading into one coroutine (in my 
refactoring series, but Paolo was against).

Or you mean to read a payload as raw? It would lead to double copying it 
to destination qiov, which I dislike..

> callback function then parses the chunks.

per-command? Then callback for CMD_READ would have all of these 
"smarts", so the whole code would not be simpler.. (However it will 
simplify adding block-status later).

>    Especially since the
> definition of the chunks differs on a per-command basis (yes, the NBD
> spec will try to not reuse an SREP chunk type across multiple commands
> unless the semantics are similar, but that's a bit more fragile).  This
> particularly matters given my statement above that you want a
> discriminated union, rather than a struct that contains unused fields,
> for handling different SREP chunk types.
>
> My review has to pause here for now...
>
>


-- 
Best regards,
Vladimir
