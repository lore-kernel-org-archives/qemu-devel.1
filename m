Received: from eggs.gnu.org ([2001:4830:134:3::10]:44768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2KkK-0007cj-2f
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2KkG-00040A-0M
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:24:40 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:37501 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2KkF-0003zn-Fx
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:24:35 -0400
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
	<20171009172723.190282-9-vsementsov@virtuozzo.com>
	<5c57b76e-eb34-7825-9c8b-9ee5bd909b02@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <25ca38f0-fb7e-3db0-3889-45604ebcb612@virtuozzo.com>
Date: Wed, 11 Oct 2017 20:24:18 +0300
MIME-Version: 1.0
In-Reply-To: <5c57b76e-eb34-7825-9c8b-9ee5bd909b02@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 04/10] nbd-server: refactor simple reply
 sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, "Daniel P. Berrange" <berrange@redhat.com>

09.10.2017 22:18, Eric Blake wrote:
> [adding Dan for a qio question - search for your name below]
>
> On 10/09/2017 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Get rid of calculating structure fields offsets by hand and set_cork,
>> rename nbd_co_send_reply to nbd_co_send_simple_reply. Do not use
>> NBDReply which will be upgraded in future patches to handle both simple
>> and structured replies and will be used only in the client.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/nbd.h |  6 ++++
>>   nbd/nbd-internal.h  |  9 +++++
>>   nbd/server.c        | 97 ++++++++++++++++++++++-------------------------------
>>   3 files changed, 56 insertions(+), 56 deletions(-)
> Feels a bit big for one patch, although I'm borderline for being able to
> take it as-is.
>
>> diff --git a/include/block/nbd.h b/include/block/nbd.h
>> index 707fd37575..49008980f4 100644
>> --- a/include/block/nbd.h
>> +++ b/include/block/nbd.h
>> @@ -63,6 +63,12 @@ struct NBDReply {
>>   };
>>   typedef struct NBDReply NBDReply;
>>   
>> +typedef struct NBDSimpleReply {
>> +    uint32_t magic;  /* NBD_SIMPLE_REPLY_MAGIC */
>> +    uint32_t error;
>> +    uint64_t handle;
>> +} QEMU_PACKED NBDSimpleReply;
>> +
> So (one of?) the goal of this patch is to use a packed struct for
> on-the-wire transmissions, instead of manually packing things into
> offsets by hand.  I can live with that.
>
>>   /* Transmission (export) flags: sent from server to client during handshake,
>>      but describe what will happen during transmission */
>>   #define NBD_FLAG_HAS_FLAGS      (1 << 0)        /* Flags are there */
>> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
>> index 2d6663de23..320abef296 100644
>> --- a/nbd/nbd-internal.h
>> +++ b/nbd/nbd-internal.h
>> @@ -113,6 +113,15 @@ static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
>>       return qio_channel_write_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
>>   }
>>   
>> +/* nbd_writev
>> + * Writes @size bytes to @ioc. Returns 0 on success.
>> + */
>> +static inline int nbd_writev(QIOChannel *ioc, const struct iovec *iov,
>> +                             size_t niov, Error **errp)
> Comment is wrong; you don't have a @size parameter.
>
>> +{
>> +    return qio_channel_writev_all(ioc, iov, niov, errp) < 0 ? -EIO : 0;
>> +}
> Do we really need this, or can we just directly use
> qio_channel_writev_all() at the lone site that uses this new interface?
>
>> +
>>   struct NBDTLSHandshakeData {
>>       GMainLoop *loop;
>>       bool complete;
>> diff --git a/nbd/server.c b/nbd/server.c
>> index a1b21a6951..57d5598e0f 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -902,26 +902,6 @@ static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request,
>>       return 0;
>>   }
>>   
>> -static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
> So instead of taking a non-packed struct, doing the hand-packing here,
> then sending the message, you split this up...
>
>> -static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len,
>> -                             Error **errp)
>> +static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iovec *iov,
>> +                                        unsigned niov, Error **errp)
>>   {
>> -    NBDClient *client = req->client;
>>       int ret;
>>   
>>       g_assert(qemu_in_coroutine());
>> -
>> -    trace_nbd_co_send_reply(reply->handle, reply->error, len);
>> -
>>       qemu_co_mutex_lock(&client->send_lock);
>>       client->send_coroutine = qemu_coroutine_self();
>>   
>> -    if (!len) {
>> -        ret = nbd_send_reply(client->ioc, reply, errp);
>> -    } else {
>> -        qio_channel_set_cork(client->ioc, true);
>> -        ret = nbd_send_reply(client->ioc, reply, errp);
>> -        if (ret == 0) {
>> -            ret = nbd_write(client->ioc, req->data, len, errp);
>> -            if (ret < 0) {
>> -                ret = -EIO;
>> -            }
>> -        }
>> -        qio_channel_set_cork(client->ioc, false);
>> -    }
>> +    ret = nbd_writev(client->ioc, iov, niov, errp);
> ...the transmission is now done via iov so that you can send two buffers
> at once without having to play with the cork,...
>
> Dan - are we guaranteed that qio_channel_writev_all() with a multi-iov
> argument called by one thread will send all its data in order, without
> being interleaved with any other parallel coroutine also calling
> qio_channel_writev_all()?  In other words, it looks like the NBD code
> was previously using manual cork changes to ensure that two halves of a
> message were sent without interleave, but Vladimir is now relying on the
> qio code to do that under the hood.
>
>>   
>>       client->send_coroutine = NULL;
>>       qemu_co_mutex_unlock(&client->send_lock);
>> +
>>       return ret;
>>   }
>>   
>> +static inline void set_be_simple_reply(NBDSimpleReply *reply, uint64_t error,
>> +                                       uint64_t handle)
>> +{
>> +    stl_be_p(&reply->magic, NBD_SIMPLE_REPLY_MAGIC);
>> +    stl_be_p(&reply->error, error);
>> +    stq_be_p(&reply->handle, handle);
>> +}
> ...loading the packed struct is now its own helper function,...
>
>> +
>> +static int nbd_co_send_simple_reply(NBDClient *client,
>> +                                    uint64_t handle,
>> +                                    uint32_t error,
>> +                                    void *data,
>> +                                    size_t size,
>> +                                    Error **errp)
>> +{
>> +    NBDSimpleReply reply;
>> +    struct iovec iov[] = {
>> +        {.iov_base = &reply, .iov_len = sizeof(reply)},
>> +        {.iov_base = data, .iov_len = size}
>> +    };
>> +
>> +    trace_nbd_co_send_reply(handle, error, size);
>> +
>> +    set_be_simple_reply(&reply, system_errno_to_nbd_errno(error), handle);
>> +
>> +    return nbd_co_send_iov(client, iov, size ? 2 : 1, errp);
>> +}
> ...and the function gets renamed, all at once.  Okay, maybe it IS easier
> to review if split.  A good split might be:
>
> Focus on naming: Rename nbd_co_send_reply() to
> nbd_co_send_simple_reply() in one patch (in fact, this part should be
> squashed with the rename of the magic number in 3/10)
>
> Focus on conversion to on-the-wire representation: Add the packed struct
> and set_be_simple_reply() in one patch, but still using corks
>
> Focus on simplified transmission: Switch to using iov to send both
> halves of a two-part message in one transaction
>
>> +
>>   /* nbd_co_receive_request
>>    * Collect a client request. Return 0 if request looks valid, -EIO to drop
>>    * connection right away, and any other negative value to report an error to
>> @@ -1331,7 +1324,6 @@ static coroutine_fn void nbd_trip(void *opaque)
>>       NBDExport *exp = client->exp;
>>       NBDRequestData *req;
>>       NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
>> -    NBDReply reply;
>>       int ret;
>>       int flags;
>>       int reply_data_len = 0;
>> @@ -1351,11 +1343,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>>           goto disconnect;
>>       }
>>   
>> -    reply.handle = request.handle;
>> -    reply.error = 0;
>> -
>>       if (ret < 0) {
>> -        reply.error = -ret;
>>           goto reply;
>>       }
> Oh, and you're doing a fourth thing - tracking the error directly in ret
> instead of buried in reply.error.  Could also be split.
>
>>   
>>   reply:
>>       if (local_err) {
>> -        /* If we are here local_err is not fatal error, already stored in
>> -         * reply.error */
>> +        /* If we are here local_err is not fatal error, which should be sent
>> +         * to client. */
> Reads awkwardly (even pre-patch); maybe this is better:
>
> /* If we get here, local_err was not a fatal error, and should be sent
> to the client. */
>
>>           error_report_err(local_err);
>>           local_err = NULL;
>>       }
>>   
>> -    if (nbd_co_send_reply(req, &reply, reply_data_len, &local_err) < 0) {
>> +    if (nbd_co_send_simple_reply(req->client, request.handle,
>> +                                 ret < 0 ? -ret : 0,
>> +                                 req->data, reply_data_len, &local_err) < 0)
>> +    {
>>           error_prepend(&local_err, "Failed to send reply: ");
>>           goto disconnect;
>>       }
>>
> I'm not necessarily going to insist that you split things if I don't see
> any other reasons to respin the series; but I might also try to do the
> split locally and post it for you to see my thinking (remember, a series
> of small patches that each do one thing well can be easier to review
> than large patches, even if it results in more emails).
>

Done, will send tomorrow. I agree, there are too many things in one patch.

-- 
Best regards,
Vladimir
