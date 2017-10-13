Received: from eggs.gnu.org ([2001:4830:134:3::10]:51218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e354U-00023f-An
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e354T-0000gh-G4
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:52:34 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:4318 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e354T-0000fT-2e
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:52:33 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-12-vsementsov@virtuozzo.com>
	<a60a6827-406f-de08-41c5-ba1dac4e4c4e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <63b4f81a-9466-9a94-403b-867aa8af57b1@virtuozzo.com>
Date: Fri, 13 Oct 2017 21:52:18 +0300
MIME-Version: 1.0
In-Reply-To: <a60a6827-406f-de08-41c5-ba1dac4e4c4e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 11/13] nbd: share some nbd entities to
 be reused in block/nbd-client.c
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

13.10.2017 21:47, Eric Blake wrote:
> On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/nbd.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   nbd/nbd-internal.h  | 25 -------------------------
>>   nbd/client.c        | 32 --------------------------------
>>   3 files changed, 48 insertions(+), 57 deletions(-)
>>
>> +static inline int nbd_errno_to_system_errno(int err)
>> +{
>> +    switch (err) {
>> +    case NBD_SUCCESS:
>> +        return 0;
>> +    case NBD_EPERM:
>> +        return EPERM;
>> +    case NBD_EIO:
>> +        return EIO;
>> +    case NBD_ENOMEM:
>> +        return ENOMEM;
>> +    case NBD_ENOSPC:
>> +        return ENOSPC;
>> +    case NBD_ESHUTDOWN:
>> +        return ESHUTDOWN;
>> +    case NBD_EINVAL:
>> +        return EINVAL;
>> +    }
>> +
>> +    return EINVAL;
>> +}
> This lacks a trace...
>
>> +++ b/nbd/client.c
>> @@ -22,38 +22,6 @@
>>   #include "trace.h"
>>   #include "nbd-internal.h"
>>   
>> -static int nbd_errno_to_system_errno(int err)
>> -{
>> -    int ret;
>> -    switch (err) {
>> -    case NBD_SUCCESS:
>> -        ret = 0;
>> -        break;
>> -    case NBD_EPERM:
>> -        ret = EPERM;
>> -        break;
>> -    case NBD_EIO:
>> -        ret = EIO;
>> -        break;
>> -    case NBD_ENOMEM:
>> -        ret = ENOMEM;
>> -        break;
>> -    case NBD_ENOSPC:
>> -        ret = ENOSPC;
>> -        break;
>> -    case NBD_ESHUTDOWN:
>> -        ret = ESHUTDOWN;
>> -        break;
>> -    default:
>> -        trace_nbd_unknown_error(err);
>> -        /* fallthrough */
>> -    case NBD_EINVAL:
> ...that was present here.  And you didn't do straight code motion, but

hmm, sorry.

> modified things on the way (hence why checkpatch complained that your
> more concise version is suspicious with regards to returning positive
> errno).  Does the function still need to be static inline, or should we
> just declare a prototype in the header and put the function itself in
> nbd/common.c?
>

ok for me to do so.

-- 
Best regards,
Vladimir
