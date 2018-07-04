Received: from eggs.gnu.org ([2001:4830:134:3::10]:36899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fakN8-0000UV-Ns
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fakN7-00045L-Ij
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:11:14 -0400
References: <20180703180751.243496-1-vsementsov@virtuozzo.com>
	<20180703180751.243496-2-vsementsov@virtuozzo.com>
	<0e6e9f14-ad45-51c5-0d14-3e2e3dcaf5cb@virtuozzo.com>
	<20180704150833.GG4334@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f50dc336-cb33-de03-d8ab-a0c01cadd850@virtuozzo.com>
Date: Wed, 4 Jul 2018 19:11:00 +0300
MIME-Version: 1.0
In-Reply-To: <20180704150833.GG4334@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/2] block: add BDRV_REQ_SERIALISING flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org

04.07.2018 18:08, Kevin Wolf wrote:
> Am 04.07.2018 um 16:44 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 03.07.2018 21:07, Vladimir Sementsov-Ogievskiy wrote:
>>> Serialized writes should be used in copy-on-write of backup(sync=none)
>>> for image fleecing scheme.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>    include/block/block.h | 5 ++++-
>>>    block/io.c            | 4 ++++
>>>    2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/block/block.h b/include/block/block.h
>>> index e5c7759a0c..107113aad5 100644
>>> --- a/include/block/block.h
>>> +++ b/include/block/block.h
>>> @@ -58,8 +58,11 @@ typedef enum {
>>>         * content. */
>>>        BDRV_REQ_WRITE_UNCHANGED    = 0x40,
>>> +    /* Force request serializing. Only for writes. */
>>> +    BDRV_REQ_SERIALISING        = 0x80,
>>> +
>>>        /* Mask of valid flags */
>>> -    BDRV_REQ_MASK               = 0x7f,
>>> +    BDRV_REQ_MASK               = 0xff,
>>>    } BdrvRequestFlags;
>>>    typedef struct BlockSizes {
>>> diff --git a/block/io.c b/block/io.c
>>> index 1a2272fad3..d5ba078514 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -1572,6 +1572,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>>>        max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
>>>                                       align);
>>> +    if (flags & BDRV_REQ_SERIALISING) {
>>> +        mark_request_serialising(req, bdrv_get_cluster_size(bs));
>>> +    }
>>> +
>>>        waited = wait_serialising_requests(req);
>>>        assert(!waited || !req->serialising);
>> Kevin, about this assertion, introduced in 28de2dcd88de "block: Assert
>> serialisation assumptions in pwritev"? Will not it fail with fleecing
>> scheme? I'm afraid it will, when we will wait for client read with our
>> request, marked serializing a moment ago...
> Hm, looks like it yes.
>
>> Can we just switch it to assert(!waited || !req->partial);, setting
>> req->partial in bdrv_co_pwritev for parts of unaligned requests? And allow
>> new flag only for aligned requests?
>>
>> Other ideas?
> The commit message of 28de2dcd88de tells you what we need to do (and
> that just changing the assertion is wrong):
>
>      If a request calls wait_serialising_requests() and actually has to wait
>      in this function (i.e. a coroutine yield), other requests can run and
>      previously read data (like the head or tail buffer) could become
>      outdated. In this case, we would have to restart from the beginning to
>      read in the updated data.
>
>      However, we're lucky and don't actually need to do that: A request can
>      only wait in the first call of wait_serialising_requests() because we
>      mark it as serialising before that call, so any later requests would
>      wait. So as we don't wait in practice, we don't have to reload the data.
>
>      This is an important assumption that may not be broken or data
>      corruption will happen. Document it with some assertions.
>
> So we may need to return -EAGAIN here, check that in the caller and
> repeat the write request from the very start.

But in case of aligned request, there no previously read data, and we 
can safely continue. And actually it's our case (backup writes are aligned).

>
> Kevin


-- 
Best regards,
Vladimir
