Received: from eggs.gnu.org ([2001:4830:134:3::10]:44415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1degnP-0000OD-VT
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1degnK-00056N-7k
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:06:07 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:31968 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1degnJ-00054l-O7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:06:02 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-3-vsementsov@virtuozzo.com>
	<484ffeb7-6571-af84-ee4b-0bfcb83df7ad@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8a8054d8-a5cd-dfbb-fa28-287b63e79102@virtuozzo.com>
Date: Mon, 7 Aug 2017 15:05:46 +0300
MIME-Version: 1.0
In-Reply-To: <484ffeb7-6571-af84-ee4b-0bfcb83df7ad@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/17] nbd/client: refactor nbd_read_eof
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

07.08.2017 14:42, Eric Blake wrote:
> On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Refactor nbd_read_eof to return 1 on success, 0 on eof, when no
>> data was read and <0 for other cases, because returned size of
>> read data is not actually used.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   nbd/nbd-internal.h         | 34 +++++++++++++++++++++++++---------
>>   nbd/client.c               |  5 -----
>>   tests/qemu-iotests/083.out |  4 ++--
>>   3 files changed, 27 insertions(+), 16 deletions(-)
>>
>> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
>> index 396ddb4d3e..3fb0b6098a 100644
>> --- a/nbd/nbd-internal.h
>> +++ b/nbd/nbd-internal.h
>> @@ -77,21 +77,37 @@
>>   #define NBD_ESHUTDOWN  108
>>   
>>   /* nbd_read_eof
>> - * Tries to read @size bytes from @ioc. Returns number of bytes actually read.
>> - * May return a value >= 0 and < size only on EOF, i.e. when iteratively called
>> - * qio_channel_readv() returns 0. So, there is no need to call nbd_read_eof
>> - * iteratively.
>> + * Tries to read @size bytes from @ioc.
>> + * Returns 1 on success
>> + *         0 on eof, when no data was read (errp is not set)
>> + *         -EINVAL on eof, when some data < @size was read until eof
>> + *         < 0 on read fail
> In general, mixing negative errno value and generic < 0 in the same
> function is most likely ambiguous.

Hmm, but this is entirely what we do so often:

if (,,) return -EINVAL;

return some_other_func().

last two lines may be rewritten like this:
+ * < 0 on fail

>
>>    */
>> -static inline ssize_t nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size,
>> -                                   Error **errp)
>> +static inline int nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size,
>> +                               Error **errp)
>>   {
>>       struct iovec iov = { .iov_base = buffer, .iov_len = size };
>> +    ssize_t ret;
>> +
>>       /* Sockets are kept in blocking mode in the negotiation phase.  After
>>        * that, a non-readable socket simply means that another thread stole
>>        * our request/reply.  Synchronization is done with recv_coroutine, so
>>        * that this is coroutine-safe.
>>        */
>> -    return nbd_rwv(ioc, &iov, 1, size, true, errp);
>> +
>> +    assert(size > 0);
> Effectively the same as assert(size != 0).
>
>> +
>> +    ret = nbd_rwv(ioc, &iov, 1, size, true, errp);
>> +    if (ret <= 0) {
>> +        return ret;
>> +    }
> So this is a negative errno (or 0 on EOF),

if it is < 0, it can be only -EIO, specified in nbd_rwv "by hand". it is 
unrelated to read read/write errno's

>
>> +
>> +    if (ret != size) {
>> +        error_setg(errp, "End of file");
>> +        return -EINVAL;
> and so is this. Which makes the function documentation not quite
> accurate; you aren't mixing a generic < 0.

hmm.. my wordings are weird sometimes, sorry for that :(. and thank you 
for your patience.

>
>> +    }
>> +
>> +    return 1;
>>   }
>>   
>>   /* nbd_read
>> @@ -100,9 +116,9 @@ static inline ssize_t nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size,
>>   static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
>>                              Error **errp)
>>   {
>> -    ssize_t ret = nbd_read_eof(ioc, buffer, size, errp);
>> +    int ret = nbd_read_eof(ioc, buffer, size, errp);
>>   
>> -    if (ret >= 0 && ret != size) {
>> +    if (ret == 0) {
>>           ret = -EINVAL;
>>           error_setg(errp, "End of file");
> Why do we have to set errp here instead of in nbd_read_eof()? Is there
> ever any case where hitting early EOF is not something that should be
> treated as an error?

yes. it is the only usage of nbd_read_eof - in nbd_receive_reply. This 
used to understand that there no more replies to read.

>
>>       }
>> diff --git a/nbd/client.c b/nbd/client.c
>> index f1c16b588f..4556056daa 100644
>> --- a/nbd/client.c
>> +++ b/nbd/client.c
>> @@ -925,11 +925,6 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
>>           return ret;
>>       }
>>   
>> -    if (ret != sizeof(buf)) {
>> -        error_setg(errp, "read failed");
>> -        return -EINVAL;
>> -    }
>> -
>>       /* Reply
>>          [ 0 ..  3]    magic   (NBD_REPLY_MAGIC)
>>          [ 4 ..  7]    error   (0 == no error)
>> diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
>> index a24c6bfece..d3bea1b2f5 100644
>> --- a/tests/qemu-iotests/083.out
>> +++ b/tests/qemu-iotests/083.out
>> @@ -69,12 +69,12 @@ read failed: Input/output error
>>   
>>   === Check disconnect 4 reply ===
>>   
>> -read failed
>> +End of file
>>   read failed: Input/output error
> At least you tracked that your changes tweak the error message.  But I'm
> not yet convinced whether this change simplifies anything.  Is there a
> later patch that is easier to write with the new semantics which was not
> possible with the pre-patch semantics?

This patch just moves error handling one level down (do not propagate 
unused information). And removes (with the following patch) last remains 
of ssize_t and returning number of bytes in nbd/client.c - for consistency.
Let nbd_rwv  to be the only function returning number of bytes.

>

-- 
Best regards,
Vladimir
