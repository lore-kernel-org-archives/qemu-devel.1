Received: from eggs.gnu.org ([2001:4830:134:3::10]:46266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d9Cwh-0007lL-6H
	for qemu-devel@nongnu.org; Fri, 12 May 2017 11:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d9Cwe-0001xL-3w
	for qemu-devel@nongnu.org; Fri, 12 May 2017 11:57:35 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:21336 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1d9Cwd-0001vh-NC
	for qemu-devel@nongnu.org; Fri, 12 May 2017 11:57:32 -0400
References: <20170512141702.12423-1-vsementsov@virtuozzo.com>
	<8c231084-8eaa-fe66-43cd-4c85f1e45272@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <005ea4a3-6565-6a56-75de-b6464bcae8fd@virtuozzo.com>
Date: Fri, 12 May 2017 18:57:28 +0300
MIME-Version: 1.0
In-Reply-To: <8c231084-8eaa-fe66-43cd-4c85f1e45272@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd: strict nbd_wr_syncv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: den@openvz.org

12.05.2017 18:46, Paolo Bonzini wrote:
>
> On 12/05/2017 16:17, Vladimir Sementsov-Ogievskiy wrote:
>> nbd_wr_syncv is called either from coroutine or from client negotiation
>> code, when socket is in blocking mode. So, -EAGAIN is impossible.
>>
>> Furthermore, EAGAIN is confusing, as, what to read/write again? With
>> EAGAIN as a return code we don't know how much data is already
>> read or written by the function, so in case of EAGAIN the whole
>> communication is broken.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Hi all!
>>
>> If I understand right, nbd_wr_syncv is called either from coroutine
>> or from client negotiation code, when socket is in blocking mode.
>> So, some thoughts
>>
>> 1. let's establish this with an assert, because returning EAGAIN is
>>     confusing (see above)
> Yes, this seems like a good idea.
>
>> 2. should we in case of non-coroutine context start this coroutine in
>>     nbd_wr_syncv, like in bdrv_prwv_co, and use non-blocking mode?
>> 3. is there any problems or disadvantages of moving  client negotiation
>>     to coroutine too?
> When you move code to coroutines you need to be aware of what code can
> now run concurrently, for example the monitor.  I'm not sure that it's
> possible to do this.

Hmm, can you please give some example of a problem? qcow2_open starts 
coroutines to read it's header, why nbd_open can't start 
coroutine/coroutines to read/write some negotiation data?

>
> Paolo
>
>>   nbd/common.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/nbd/common.c b/nbd/common.c
>> index dccbb8e9de..4db45b3ede 100644
>> --- a/nbd/common.c
>> +++ b/nbd/common.c
>> @@ -20,6 +20,10 @@
>>   #include "qapi/error.h"
>>   #include "nbd-internal.h"
>>   
>> +/* nbd_wr_syncv
>> + * The function may be called from coroutine or from non-coroutine context.
>> + * When called from non-coroutine context @ioc must be in blocking mode.
>> + */
>>   ssize_t nbd_wr_syncv(QIOChannel *ioc,
>>                        struct iovec *iov,
>>                        size_t niov,
>> @@ -42,11 +46,8 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
>>               len = qio_channel_writev(ioc, local_iov, nlocal_iov, &local_err);
>>           }
>>           if (len == QIO_CHANNEL_ERR_BLOCK) {
>> -            if (qemu_in_coroutine()) {
>> -                qio_channel_yield(ioc, do_read ? G_IO_IN : G_IO_OUT);
>> -            } else {
>> -                return -EAGAIN;
>> -            }
>> +            assert(qemu_in_coroutine());
>> +            qio_channel_yield(ioc, do_read ? G_IO_IN : G_IO_OUT);
>>               continue;
>>           }
>>           if (len < 0) {
>>


-- 
Best regards,
Vladimir
