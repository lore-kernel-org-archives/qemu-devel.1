Received: from eggs.gnu.org ([2001:4830:134:3::10]:41312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cY6Hj-00009T-KB
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 02:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cY6Hi-0006wD-U2
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 02:21:55 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:3488 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cY6Hi-0006uT-IO
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 02:21:54 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-8-vsementsov@virtuozzo.com>
	<bf9c6aae-2aa6-bfe2-8856-67e8b13ad58d@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6d98fdb6-6043-8805-6df7-a2a03a7925da@virtuozzo.com>
Date: Mon, 30 Jan 2017 10:21:37 +0300
MIME-Version: 1.0
In-Reply-To: <bf9c6aae-2aa6-bfe2-8856-67e8b13ad58d@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/24] qcow2: add bitmaps extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

29.01.2017 00:29, Max Reitz wrote:
> On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
>> Add bitmap extension as specified in docs/specs/qcow2.txt.
>> For now, just mirror extension header into Qcow2 state and check
>> constraints.
>>
>> For now, disable image resize if it has bitmaps. It will be fixed later.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/qcow2.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   block/qcow2.h |  24 ++++++++++++
>>   2 files changed, 141 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 96fb8a8f16..a8835988c7 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
> [...]
>
>> @@ -185,6 +265,15 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>>           offset += ((ext.len + 7) & ~7);
>>       }
>>   
>> +    if (need_update && !bdrv_is_root_node(bs) &&
>> +        !(bdrv_get_flags(bs) & BDRV_O_INACTIVE))
>> +    {
>> +        ret = qcow2_update_header(bs);
> Good idea, but qcow2_read_extensions() can be called pretty early in
> qcow2_open(). Therefore, some fields in the BDRVQcow2State are not
> necessarily set already.
>
> For instance, it is always called before s->snapshots_offset and
> s->nb_snapshots are set. Thus, this will effectively always discard all
> snapshots.
>
> Max
>

So, I need to move need_update to qcow2_read_extensions parameters as 
'bool *' and handle it later, in the end of qcow2_open. Ok?



-- 
Best regards,
Vladimir
