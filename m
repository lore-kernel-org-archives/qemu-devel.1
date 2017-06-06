Received: from eggs.gnu.org ([2001:4830:134:3::10]:38886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dIAVE-0004Al-Ej
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dIAV9-0003hn-Ca
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:10:16 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:43076 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dIAV9-0003eh-0i
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:10:11 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-20-vsementsov@virtuozzo.com>
	<ca6625b0-1be4-fa44-f6fe-da935621d6b3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <90014201-59ca-1a22-660d-2046a240ea45@virtuozzo.com>
Date: Tue, 6 Jun 2017 12:10:07 +0300
MIME-Version: 1.0
In-Reply-To: <ca6625b0-1be4-fa44-f6fe-da935621d6b3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 19/19] nbd: use generic trace subsystem
 instead of TRACE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>

05.06.2017 18:23, Eric Blake wrote:
> [adding Stefan as trace maintainer]
>
> On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   Makefile.objs      |  1 +
>>   nbd/client.c       | 77 ++++++++++++++++++++++++----------------------------
>>   nbd/nbd-internal.h | 19 -------------
>>   nbd/server.c       | 79 ++++++++++++++++++++++++++----------------------------
>>   nbd/trace-events   | 67 +++++++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 141 insertions(+), 102 deletions(-)

[...]

>>           goto fail;
>>       }
>>       magic = be64_to_cpu(magic);
>> -    TRACE("Magic is 0x%" PRIx64, magic);
>> +    trace_nbd_receive_negotiate_magic2(magic);
> In fact, I think you only need one trace function for tracing an 8-byte
> magic number, that can be called from more than one spot.

You've touched interesting point: is it normal to create 
trace-functions, used as different trace-points? So should 
trace-point-name describe point in the program or not? I've thought it 
should.

>
>> @@ -501,15 +499,16 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
>>               goto fail;
>>           }
>>           globalflags = be16_to_cpu(globalflags);
>> -        TRACE("Global flags are %" PRIx32, globalflags);
>> +        trace_nbd_receive_negotiate_server_flags(
>> +            globalflags,
>> +            !!(globalflags & NBD_FLAG_FIXED_NEWSTYLE),
>> +            !!(globalflags & NBD_FLAG_NO_ZEROES));
> Why do we have to trace particular b


-- 
Best regards,
Vladimir
