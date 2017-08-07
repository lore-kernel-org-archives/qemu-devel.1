Received: from eggs.gnu.org ([2001:4830:134:3::10]:59334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dehaK-0000YE-Rv
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dehaG-0005sa-3J
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:56:40 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:40523 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dehaF-0005qZ-N2
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:56:36 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-7-vsementsov@virtuozzo.com>
	<4dc2dde8-2177-3d1c-c168-f98d826922b5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cf38e6aa-e934-bf75-48bf-3c3bbcb7f254@virtuozzo.com>
Date: Mon, 7 Aug 2017 15:56:24 +0300
MIME-Version: 1.0
In-Reply-To: <4dc2dde8-2177-3d1c-c168-f98d826922b5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 06/17] block/nbd-client: fix
 nbd_read_reply_entry
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

07.08.2017 14:52, Eric Blake wrote:
> On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Set reply.handle to 0 on error path to prevent normal path of
>> nbd_co_receive_reply.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/nbd-client.c | 1 +
>>   1 file changed, 1 insertion(+)
> Can you document a case where not fixing this would be an observable bug
> (even if it requires using gdb and single-stepping between client and
> server to make what is otherwise a racy situation easy to see)?  I'm
> trying to figure out if this is 2.10 material.

it is simple enough:

run qemu-nbd in gdb, set break on nbd_send_reply, and when it shoot s,
next up to "stl_be_p(buf, NBD_REPLY_MAGIC);" and after it do "call 
stl_be_p(buf, 1000)"

run qemu-io with some read in gdb, set break on
br block/nbd-client.c:83

( it is break; after failed nbd_receive_reply call)

and on
br block/nbd-client.c:170

(it is in nbd_co_receive_reply after yield)

on first break we will be sure that  nbd_receive_reply failed,
on second we will be sure by
(gdb) p s->reply
$1 = {handle = 93825000680144, error = 0}
(gdb) p request->handle
$2 = 93825000680144

that we are on normal receiving path.

>
>> diff --git a/block/nbd-client.c b/block/nbd-client.c
>> index dc19894a7c..0c88d84de6 100644
>> --- a/block/nbd-client.c
>> +++ b/block/nbd-client.c
>> @@ -107,6 +107,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
>>           qemu_coroutine_yield();
>>       }
>>   
>> +    s->reply.handle = 0;
>>       nbd_recv_coroutines_enter_all(s);
>>       s->read_reply_co = NULL;
>>   }
>>

-- 
Best regards,
Vladimir
