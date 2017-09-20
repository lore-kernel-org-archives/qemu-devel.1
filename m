Received: from eggs.gnu.org ([2001:4830:134:3::10]:37068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duf2N-0003UF-5F
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duf2K-0004du-Sx
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:35 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-6-vsementsov@virtuozzo.com>
	<cd7f10e4-2e78-5108-f744-eab2babb5965@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <21bf795a-f5af-670a-26f8-1313f36ca8c0@virtuozzo.com>
Date: Wed, 20 Sep 2017 15:03:24 +0300
MIME-Version: 1.0
In-Reply-To: <cd7f10e4-2e78-5108-f744-eab2babb5965@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/7] block/nbd-client:
 nbd_co_send_request: return -EIO if s->quit was set in parallel
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

18.09.2017 19:01, Eric Blake wrote:
> On 09/18/2017 08:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>> It's incorrect to return success rc >= 0 if we skip qio_channel_writev_all()
>> call due to s->quit.
> Does this need to cc: qemu-stable for 2.10.1 (or put another way, can we
> come up with some scenario of EAGAIN or other handling that would
> actually set s->quit in a parallel coroutine when a client sends out
> multiple requests at once)?

Intuitively, I think it should not be possible, first nbd_send_request 
should not do
something serious (should not yield) after set_cork..

>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/nbd-client.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/block/nbd-client.c b/block/nbd-client.c
>> index f331f08a9a..280147e6a7 100644
>> --- a/block/nbd-client.c
>> +++ b/block/nbd-client.c
>> @@ -189,6 +189,9 @@ static int nbd_co_send_request(BlockDriverState *bs,
>>       }
>>   
>>   err:
>> +    if (rc >= 0 && s->quit) {
>> +        rc = -EIO;
>> +    }
> I'm still not convinced this is in the right place.  This fails the
> send_request regardless of whether we skipped qio_channel_writev_all();
> shouldn't the rc be set only in the case that we actually skipped
> writing the full command because s->quit was detected at that point in time?
>
>>       if (rc < 0) {
>>           s->quit = true;
>>           s->requests[i].coroutine = NULL;
>>

-- 
Best regards,
Vladimir
